import sys
import time
from pathlib import Path
import os
import re
import tkinter
import subprocess
import shutil
import glob
import fnmatch
import signal
import json
from funcs import *


try:
  CGA_ROOT = os.environ['CGA_ROOT']
except:
  print_red ("CGA_ROOT is not defined, Please export CGA_ROOT=<path to the Gap-Analysis directory>")
  sys.exit()

tclsh = tkinter.Tcl()

exec(open(CGA_ROOT+'/.github/scripts/tools_auto_scripts/filelist.py').read())


def vivado_banner(COLOR:str):
  print("\n")
  print(COLOR+r'                                       ____       ______   ______  ')
  print(r'       \\          //||\\          // //  \\     |  __  \ /  __  \ ')
  print(r'        \\        // || \\        // // /\ \\    | |  \ | | /  \ | ')
  print(r'         \\      //  ||  \\      // // /__\ \\   | |  | | | |  | | ')
  print(r'          \\    //   ||   \\    // //________\\  | |  | | | |  | | ')
  print(r'           \\__//    ||    \\__// //          \\ | |__/ | | \__/ | ')
  print(r'            \__/     ||     \__/ //            \\|______/ \______/ '+ENDCOLOR)
  print("\n")
  
      
def check_dir(*args):
  for directory in args:
    if not (os.path.isdir(Path(directory))):
      os.makedirs(directory)
    else:
      print ("%s already exists" %directory)
	
def update_status(STATUS_LOG:str, name="Name", status="Status", runtime="-"):
  log_file = Path(STATUS_LOG)
  if not (os.path.isfile(log_file)):
    with open(log_file, 'wt') as init_log:
      init_log.write("Design name,Runtime,Status\n")
  with open(log_file, 'at') as append_log:
    append_log.write("%s,%s,%s\n" %(name, runtime, status))
  
def get_vivado_error_msg(error_log:str):
  msg = find_string_in_file(error_log, "ERROR: ", "")
  return msg

def get_quartus_error_msg(error_log:str):
  if os.path.isfile(Path(error_log)):
    msg = find_string_in_file(error_log, "Error ", "")
  else:
    msg = "Error occured"
  return msg

def get_lattice_error_msg(error_log:str):
  if os.path.isfile(Path(error_log)):
    msg = find_string_in_file(error_log, "ERROR - ", "")
  else:
    msg = "Error occured in run"
  return msg

def get_yosys_error_msg(error_log:str):
  if os.path.isfile(Path(error_log)):
    msg = find_string_in_file(error_log, "ERROR: ", "ERROR: ")
  else:
    msg = "Error occured in run"
  return msg

def get_gowin_error_msg(error_log:str):
  print(error_log)
  if os.path.isfile(Path(error_log)):
    msg = find_string_in_file(error_log, "ERROR ", "ERROR: ")
  else:
    msg = "Error occured in run"
  return msg

def set_params(DESIGN_CONF, GEN_CONF):
  global PROJECT_NAME, DESIGN_TOP, DESIGN_DIR, DOMAIN, CLOCK_PORT
  PROJECT_NAME = find_string_in_file(DESIGN_CONF, "set ::env(PROJECT_NAME) ", "")
  DESIGN_TOP = find_string_in_file(DESIGN_CONF, "set ::env(DESIGN_TOP) ", "")
  DESIGN_DIR = find_string_in_file(DESIGN_CONF, "set ::env(DESIGN_DIR) ", "")
  DOMAIN = find_string_in_file(DESIGN_CONF, "set ::env(DOMAIN) ", "")
  CLOCK_PORT = find_string_in_file(DESIGN_CONF, "set ::env(CLOCK_PORT) ", "")
  
def source_configs(config:str, gen_config):
  source_conf = "source %s" %config
  source_all = "source %s" %gen_config
  tclsh.eval(source_all)
  tclsh.eval(source_conf)
  
  set_params(config, gen_config)
 

def run(TOOL, BENCHMARK_FILE):  
    if not(os.path.exists(BENCHMARK_FILE)):
      print_red("File does not exist")
    elif ((os.path.getsize(BENCHMARK_FILE) == 0)):
      print_red("File exists, but is empty")
    else:
      with open(BENCHMARK_FILE, 'rt') as read_job:
        for line in read_job:
          DESIGN_CONF=line.strip()
          if (DESIGN_CONF == ""):
            pass
          elif (not(os.path.isfile(DESIGN_CONF))):
            print_red("Following config file doesn't exist")
            print_red (DESIGN_CONF)
          elif (os.path.getsize(DESIGN_CONF) == 0):
            print_red("Following config file exists, but is empty")
            print_red (DESIGN_CONF)
          else:
            run_tool(TOOL, DESIGN_CONF, GEN_CONF)
    else:
      if (glob.glob(CGA_ROOT+"/RTL_Benchmark/*") == []):
        print_cyan("RTL Benchmarks directory is empty")
      else:
        for benchmarks in glob.glob(CGA_ROOT+"/RTL_Benchmark/*"):
          confs = find('config.tcl', benchmarks)
          for conf in confs:
            DESIGN_CONF = conf+"/config.tcl"
            print_green("\nConfig file found, running %s" %TOOL)
            run_tool(TOOL, DESIGN_CONF, GEN_CONF)
          
def run_tool(TOOL, DESIGN_CONF, GEN_CONF):
  if (TOOL == "vivado"):
    run_vivado(DESIGN_CONF, GEN_CONF)
  elif (TOOL == "quartus"):
    run_quartus(DESIGN_CONF, GEN_CONF)
  elif (TOOL == "lattice"):
    run_lattice(DESIGN_CONF, GEN_CONF)
  elif (TOOL == "yosys"):
    run_yosys(DESIGN_CONF, GEN_CONF)
  elif (TOOL == "gowin"):
    run_gowin(DESIGN_CONF, GEN_CONF)
  else:
    print_red("No valid tool selected")

def run_yosys(DESIGN_CONF, GEN_CONF):
      
  source_configs(DESIGN_CONF, GEN_CONF)
  
  set_yosys_variables()
  
  check_dir(YOSYS_MISC_DIR, YOSYS_FINAL_LOG_PATH, YOSYS_GEN_LOG_PATH)
  
  start_time=timer("start")
    
  try:
      process = subprocess.Popen(["yosys", YOSYS_SCRIPT, "-l", YOSYS_GEN_LOG_PATH+"/"+PROJECT_NAME+".log"])
      
      try:
        process.communicate(timeout=1800)
        if (process.returncode):
          error_msg = get_yosys_error_msg(YOSYS_ERROR_LOG)
          update_status(YOSYS_STATUS_LOG1, PROJECT_NAME, error_msg)
          print("Return code", process.returncode)
          print_red(error_msg)
          sys.exit(process.returncode)
        runtime = timer("stop", start_time)
        update_status(YOSYS_STATUS_LOG1, PROJECT_NAME, "Successfully run", timer_string(runtime))
           
      except subprocess.TimeoutExpired as timeout_msg:
        print_red(str(timeout_msg))
        runtime = timer("stop", start_time)
        update_status(YOSYS_STATUS_LOG1, PROJECT_NAME, "Timed-out", timer_string(runtime), "-", str(iters))
        

      except Exception as exception:
        print_red(str(exception))
        update_status(YOSYS_STATUS_LOG1, PROJECT_NAME, str(exception)) 
        
  except OSError as os_error:
      print (str(os_error))

def run_vivado(DESIGN_CONF, GEN_CONF):
      
  vivado_banner(BLUE)
  
  source_configs(DESIGN_CONF, GEN_CONF)
  
  set_vivado_variables()
  os.environ['VIVADO_GEN_LOG_PATH'] = VIVADO_GEN_LOG_PATH
    
  start_time=timer("start")
  
  check_dir(VIVADO_MISC_DIR, VIVADO_FINAL_LOG_PATH)
   
  try:
      try:
        os.chdir(VIVADO_MISC_DIR)
        process = subprocess.Popen(["vivado", "-mode", "batch", "-source", VIVADO_SCRIPT, "-tempDir", VIVADO_MISC_DIR], preexec_fn=os.setsid)
        pgrp=os.getpgid(process.pid)
        os.chdir(CGA_ROOT)
        process.communicate(timeout=1800)
        if (process.returncode):
          error_msg = get_vivado_error_msg(VIVADO_ERROR_LOG)
          update_status(VIVADO_STATUS_LOG1, PROJECT_NAME, error_msg)
          print("Return code", process.returncode)
          print_red(error_msg)
          sys.exit(process.returncode)
        runtime = timer("stop", start_time)
        update_status(VIVADO_STATUS_LOG1, PROJECT_NAME, "Successfully run", timer_string(runtime))
           
      except subprocess.TimeoutExpired as timeout_msg:
        print_red(str(timeout_msg))
        os.killpg(pgrp, signal.SIGHUP)
        runtime = timer("stop", start_time)
        update_status(VIVADO_STATUS_LOG1, PROJECT_NAME, "Timed-out", timer_string(runtime))

      except Exception as exception:
        print_red(str(exception))
        update_status(VIVADO_STATUS_LOG1, PROJECT_NAME, str(exception))

        
  except OSError as os_error:
      print (str(os_error))      
      
def run_quartus(DESIGN_CONF, GEN_CONF):
      
  source_configs(DESIGN_CONF, GEN_CONF)
  
  set_quartus_variables()
  os.environ['QUARTUS_GEN_LOG_PATH'] = QUARTUS_GEN_LOG_PATH
    
  start_time=timer("start")
  
  check_dir(QUARTUS_MISC_DIR, QUARTUS_FINAL_LOG_PATH)
  
  try:
      os.chdir(QUARTUS_MISC_DIR)
      process1 = subprocess.Popen(["quartus_sh", "-t", QUARTUS_SCRIPT])
      process = subprocess.Popen(["quartus_map", PROJECT_NAME], preexec_fn=os.setsid)
      pgrp=os.getpgid(process.pid)
      os.chdir(CGA_ROOT)

      try:
        process.communicate(timeout=1800)
        if (process.returncode):
          error_msg = get_quartus_error_msg(QUARTUS_ERROR_LOG)
          update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, error_msg)
          print("Return code", process.returncode)
          print_red(error_msg)
          sys.exit(process.returncode)
        runtime = timer("stop", start_time)
        update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, "Successfully run", timer_string(runtime))  
          
      except subprocess.TimeoutExpired as timeout_msg:
        print_red(str(timeout_msg))
        os.killpg(pgrp, signal.SIGHUP)
        runtime = timer("stop", start_time)
        update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, "Timed-out", timer_string(runtime))

      except Exception as exception:
        print_red(str(exception))
        update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, str(exception))
        
  except OSError as os_error:
    print (str(os_error))
    
    
def run_lattice(DESIGN_CONF, GEN_CONF):
      
  source_configs(DESIGN_CONF, GEN_CONF)
  
  set_lattice_variables()
  
  os.environ['LATTICE_GEN_LOG_PATH'] = LATTICE_GEN_LOG_PATH
    
  start_time=timer("start")
  
  check_dir(LATTICE_MISC_DIR, LATTICE_FINAL_LOG_PATH)
  
  try:

      os.chdir(LATTICE_MISC_DIR)
      process = subprocess.Popen(["diamondc", LATTICE_SCRIPT], preexec_fn=os.setsid)
      pgrp=os.getpgid(process.pid)
      os.chdir(CGA_ROOT)

      try:
        process.communicate(timeout=1800)
        if (process.returncode):
          error_msg = get_lattice_error_msg(LATTICE_ERROR_LOG)
          update_status(LATTICE_STATUS_LOG1, PROJECT_NAME, error_msg)
          print("Return code", process.returncode)
          print_red(error_msg)
          sys.exit(process.returncode)

        runtime = timer("stop", start_time)
        update_status(LATTICE_STATUS_LOG1, PROJECT_NAME, "Successfully run", timer_string(runtime))

           
      except subprocess.TimeoutExpired as timeout_msg:
        print_red(str(timeout_msg))
        os.killpg(pgrp, signal.SIGHUP)
        runtime = timer("stop", start_time)
        update_status(LATTICE_STATUS_LOG1, PROJECT_NAME, "Timed-out", timer_string(runtime))

      except Exception as exception:
        print_red(str(exception))
        update_status(LATTICE_STATUS_LOG1, PROJECT_NAME, str(exception))

  except OSError as os_error:
    print (str(os_error))
    
    
def run_gowin(DESIGN_CONF, GEN_CONF):
        
  source_configs(DESIGN_CONF, GEN_CONF)
  
  set_gowin_variables()
  os.environ['GOWIN_GEN_LOG_PATH'] = GOWIN_GEN_LOG_PATH
    
  start_time=timer("start")
  
  check_dir(GOWIN_MISC_DIR, GOWIN_FINAL_LOG_PATH)
   
  try:
      try:
        os.chdir(GOWIN_MISC_DIR)
        process = subprocess.Popen(["gw_sh", GOWIN_SCRIPT], preexec_fn=os.setsid)
        pgrp=os.getpgid(process.pid)
        os.chdir(CGA_ROOT)
        process.communicate(timeout=1800)
        if (process.returncode):
          error_msg = get_gowin_error_msg(GOWIN_ERROR_LOG)
          update_status(GOWIN_STATUS_LOG1, PROJECT_NAME, error_msg)
          print("Return code", process.returncode)
          print_red(error_msg)
          sys.exit(process.returncode)
        runtime = timer("stop", start_time)
        update_status(GOWIN_STATUS_LOG1, PROJECT_NAME, "Successfully run", timer_string(runtime))
           
      except subprocess.TimeoutExpired as timeout_msg:
        print_red(str(timeout_msg))
        os.killpg(pgrp, signal.SIGHUP)
        runtime = timer("stop", start_time)
        update_status(GOWIN_STATUS_LOG1, PROJECT_NAME, "Timed-out", timer_string(runtime))

      except Exception as exception:
        print_red(str(exception))
        update_status(GOWIN_STATUS_LOG1, PROJECT_NAME, str(exception))

        
  except OSError as os_error:
      print (str(os_error))  
