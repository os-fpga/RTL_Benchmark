import time
from pathlib import Path
import os
import re
import tkinter
import subprocess
import shutil
import sys
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

exec(open(CGA_ROOT+'/scripts/tools_auto_scripts/filelist.py').read())
exec(open(CGA_ROOT+'/scripts/tools_auto_scripts/general constants').read())

def clean_openfpga_runs():
  os.system("python3 %s/openfpga_flow/scripts/run_fpga_task.py --remove_run_dir all param_config" %OPENFPGA_PATH)

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

def check_slack(TOOL:str, FILE:str):
  with open(FILE) as slack_file:
    if (TOOL == "openfpga"):
      for line in slack_file:
        if ("slack") in line:
          slack = re.findall(r"[+-]?\d+(?:\.\d+)?", line)
          slack = float(slack[0])
          print_green("\nValue of slack found %s" %slack)
          return slack
    elif (TOOL == "vivado"):
      for line in slack_file:
        if (" Worst Slack ") in line:
          slack = re.findall(r"[+-]?\d+(?:\.\d+)?", line)
          slack = float(slack[1])
          print_green("\nValue of slack found %s" %slack)
          return slack
    elif (TOOL == "quartus"):
      for line in slack_file:
        if ("Worst-case Slack ") in line:
          slack = re.findall(r"[+-]?\d+(?:\.\d+)?", line)
          slack = float(slack[0])
          print_blue("\nValue of slack found %s" %slack)
          return slack
    else:
      print_red("No valid tool selected")
      
def check_dir(*args):
  for directory in args:
    if not (os.path.isdir(Path(directory))):
      os.makedirs(directory)
    else:
      print ("%s already exists" %directory)
	
def update_status(STATUS_LOG:str, name="Name", status="Status", runtime="-", w_slack="-", iters="-"):
  log_file = Path(STATUS_LOG)
  if not (os.path.isfile(log_file)):
    with open(log_file, 'wt') as init_log:
      init_log.write("Design name,Status,Runtime,Worst Slack,No. of iterations\n")
  with open(log_file, 'at') as append_log:
    append_log.write("%s,%s,%s,%s,%s\n" %(name, status, runtime, w_slack, iters))
  
def get_openfpga_error_msg(shell_file:str, yosys_file:str):       
    if os.path.isfile(Path(shell_file)):
      msg = find_string_in_file(shell_file, "Message: ", "")
    elif os.path.isfile(Path(yosys_file)):
      msg = find_string_in_file(yosys_file, "ERROR: ", "")
    else:
        msg = "Design directory or path for top verilog, provided in config, is incorrect"
    return msg
  
def get_vivado_error_msg(error_log:str):
  msg = find_string_in_file(error_log, "ERROR: ", "")
  return msg

def get_quartus_error_msg(error_log:str):
  if os.path.isfile(Path(error_log)):
    msg = find_string_in_file(error_log, "Error ", "")
  else:
    msg = "Error occured"
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
 
def set_openfpga_params(GEN_CONF): 
  global ARCH, VPR_ARCH
  ARCH = find_string_in_file(GEN_CONF, "set ::env(OPENFPGA_ARCH) ", "")
  VPR_ARCH = find_string_in_file(GEN_CONF, "set ::env(VPR_ARCH) ", "")

def init_runs(STRT_TIME, STRT_SLCK, TOL):
  iters = 0
  time_period = STRT_TIME
  slack = STRT_SLCK
  slack_prev_itr = slack
  tolerance = TOL
  return iters, time_period, slack, slack_prev_itr, tolerance

def calc_slack(slack, slack_prev_itr, tolerance):
  if (0 <= slack <= tolerance):
    slack_prev_itr = slack
    slack = False
  elif (slack < 0):
    slack_prev_itr = slack
    slack = -1 * slack
  else:
    slack = slack_prev_itr/2
    slack_prev_itr = slack_prev_itr/2
    
  return slack, slack_prev_itr
  
def generate_status_log(file:str, status:str, domain:str, strategy:str, runtime="-", error_msg=""):
  write_text(file, "Domain of the design: %s" %domain)
  append_text(file, "\n\nTotal RunTime:%s" %str(runtime))
  append_text(file, "\n\nStrategy: %s" %strategy)
  if (status == "Successfully run"):
    append_text(file, "\n\nStatus: %s" %status)
  else:
    append_text(file, "\n\nStatus: %s" %error_msg)
    
def update_json(json_file:str, tool:str, strategy:str, val:float):
  if not (os.path.exists(json_file)):
    write_text(json_file, '{"openfpga": { "default": null, "area": null, "performance": null },')
    append_text(json_file, '"vivado": { "default": null, "area": null, "performance": null },')
    append_text(json_file, '"quartus": { "default": null, "area": null, "performance": null }}')
  
  with open(json_file, "r") as read_job: 
    sdc_data=json.load(read_job)
  read_job.close()

  if(sdc_data[tool][strategy] == None):
    sdc_data[tool][strategy] = val
  
  with open(json_file, "w") as write_job: 
    json.dump(sdc_data, write_job, indent=2)
  write_job.close()
    
def openfpga_logs(slack, domain, strategy, runtime, iters):
  update_status(OPENFPGA_STATUS_LOG1, PROJECT_NAME, "Successfully run", timer_string(runtime), str(slack), str(iters))
        
  generate_status_log(OPENFPGA_STATUS_LOG, "Successfully run", domain, strategy, runtime)
  shutil.move(OPENFPGA_GEN_UTIL_LOG, OPENFPGA_UTIL_LOG)
  shutil.move(OPENFPGA_GEN_TIME1_LOG, OPENFPGA_TIME1_LOG)
  shutil.move(OPENFPGA_GEN_TIME2_LOG, OPENFPGA_TIME2_LOG)
  
def vivado_logs(slack, domain, strategy, runtime, iters):
  update_status(VIVADO_STATUS_LOG1, PROJECT_NAME, "Successfully run", timer_string(runtime), str(slack), str(iters))
        
  generate_status_log(VIVADO_STATUS_LOG, "Successfully run", domain, strategy, runtime)
  shutil.move(VIVADO_GEN_UTIL_LOG, VIVADO_UTIL_LOG)
  shutil.move(VIVADO_GEN_TIME_LOG, VIVADO_TIME_LOG)
  
def quartus_logs(slack, domain, strategy, runtime, iters):
  update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, "Successfully run", timer_string(runtime), str(slack), str(iters))
        
  generate_status_log(QUARTUS_STATUS_LOG, "Successfully run", domain, strategy, runtime)
  shutil.move(QUARTUS_GEN_UTIL_LOG, QUARTUS_UTIL_LOG)
  shutil.move(QUARTUS_GEN_TIME_LOG, QUARTUS_TIME_LOG)

def run(TOOL, BENCHMARK_FILE):  
  #if (BENCHMARK_FILE):
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
            print_green("\nConfig file found, running %s" %TOOL)
            run_tool(TOOL, DESIGN_CONF, GEN_CONF)
                
  #elif BENCHMARK_CONF:
  #  for DESIGN_CONF in BENCHMARK_CONF:
  #    if (DESIGN_CONF == ""):
  #      pass
  #    elif not(os.path.isfile(DESIGN_CONF)):
  #      print_red("Following config file doesn't exist")
  #      print_red (DESIGN_CONF)
  #    elif (os.path.getsize(DESIGN_CONF) == 0):
  #      print_red("Following config file exists, but is empty")
  #      print_red (DESIGN_CONF)
  #    else:
  
  #print_green("\nConfig file found, running %s" %TOOL)
  #      run_tool(TOOL, DESIGN_CONF, GEN_CONF)

  #else:
  #  if (glob.glob(CGA_ROOT+"/RTL_Benchmark/*") == []):
  #    print_cyan("RTL Benchmarks directory is empty")
  #  else:
  #    for benchmarks in glob.glob(CGA_ROOT+"/RTL_Benchmark/*"):
  #      confs = find('config.tcl', benchmarks)
  #      for conf in confs:
  #        DESIGN_CONF = conf+"/config.tcl"
  #        print_green("\nConfig file found, running %s" %TOOL)
  #        run_tool(TOOL, DESIGN_CONF, GEN_CONF)
          
def run_tool(TOOL, DESIGN_CONF, GEN_CONF):
  if (TOOL == "openfpga"):
    run_OpenFPGA(DESIGN_CONF, GEN_CONF)
  elif (TOOL == "vivado"):
    run_vivado(DESIGN_CONF, GEN_CONF)
  elif (TOOL == "quartus"):
    run_quartus(DESIGN_CONF, GEN_CONF)
  else:
    print_red("No valid tool selected")

def run_OpenFPGA(DESIGN_CONF, GEN_CONF):
    
  STRATEGY = "default"
  
  source_configs(DESIGN_CONF, GEN_CONF)
  set_openfpga_params(GEN_CONF)
  
  if (glob.glob(CGA_ROOT+"/"+DESIGN_DIR+"/*.vh")):
   TASK_DIR = 'param_config_vh'
  else:
   TASK_DIR = 'param_config'
        
  globals()['TASK_DIR'] = TASK_DIR
  
  set_openfpga_variables()
  
  check_dir(OPENFPGA_MISC_DIR, OPENFPGA_FINAL_LOG_PATH)

  generate_interim_script(OPENFPGA_SHELL_TEMP_PATH, OPENFPGA_SHELL_GEN_PATH, "$CON_PATH", " %s" %OPENFPGA_SDC_GEN)
    
  start_time=timer("start")
  iters, time_period, slack, slack_prev_itr, tolerance = init_runs(STRT_TIME, STRT_SLCK, TOL)
  
  while True:
    try:
      time_period = time_period + slack
      iters = iters + 1
      
      print_cyan("\nCurrently running iteration no. %s for design %s" %(iters, PROJECT_NAME))
      
      if (os.path.exists(SDC_JSON)):
        with open(SDC_JSON) as file:
          sdc_data=json.load(file)
          if(sdc_data['openfpga'][STRATEGY]!=None):
            generate_interim_script(OPENFPGA_SDC_TEMP, OPENFPGA_SDC_GEN, "$PERIOD", str(sdc_data['openfpga'][STRATEGY]), "$CLOCK_PORT", CLOCK_PORT)
            file.close()
      else:    
        if (CLOCK_PORT):
          generate_interim_script(OPENFPGA_SDC_TEMP, OPENFPGA_SDC_GEN, "$PERIOD", str(time_period), "$CLOCK_PORT", CLOCK_PORT)
        else:    
          generate_interim_script(OPENFPGA_SDC_COMB_TEMP, OPENFPGA_SDC_GEN, "$PERIOD", str(time_period), "$CLOCK_PORT", "clk")
  
      process = subprocess.Popen(['python3', OPENFPGA_PATH+'/openfpga_flow/scripts/openfpga_task.py', TASK_DIR])

      try:
        process.communicate(timeout=TIMEOUT)
        if (process.returncode):
          error_msg = get_openfpga_error_msg(OPENFPGA_GEN_UTIL_LOG, OPENFPGA_GEN_UTIL2_LOG)
          update_status(OPENFPGA_STATUS_LOG1, PROJECT_NAME, error_msg)
          print("Return code", process.returncode)
          print_red(error_msg)
          generate_status_log(OPENFPGA_STATUS_LOG, "Failed", DOMAIN, STRATEGY, 0, error_msg)
          break
           
      except subprocess.TimeoutExpired as timeout_msg:
        print_red(str(timeout_msg))
        runtime = timer("stop", start_time)
        update_status(OPENFPGA_STATUS_LOG1, PROJECT_NAME, "Timed-out", timer_string(runtime), "-", str(iters))
        generate_status_log(OPENFPGA_STATUS_LOG, "Failed", DOMAIN, STRATEGY, runtime, "Error: Design timed-out")
        break

      except Exception as exception:
        print_red(str(exception))
        update_status(OPENFPGA_STATUS_LOG1, PROJECT_NAME, str(exception))
        break 
        
      slack = check_slack("openfpga", OPENFPGA_GEN_TIME2_LOG)
  
      slack, slack_prev_itr = calc_slack(slack, slack_prev_itr, tolerance)
      
      if not (slack):
        runtime = timer("stop", start_time)
        openfpga_logs(slack_prev_itr, DOMAIN, STRATEGY, runtime, iters)
        update_json(SDC_JSON, "openfpga", STRATEGY, time_period)     
        break
        
      if ((iters == 26) or (iters == 32)):
        tolerance = tolerance*2
      if(iters == 40):
        itr_limit_msg = "Error: Iteration limit exceeded"
        print_red(str(itr_limit_msg))
        runtime = timer("stop", start_time)
        update_status(OPENFPGA_STATUS_LOG1, PROJECT_NAME, itr_limit_msg, timer_string(runtime), "-", str(iters))
        generate_status_log(OPENFPGA_STATUS_LOG, "Failed", DOMAIN, STRATEGY, runtime, itr_limit_msg)
        break
        
    except OSError as os_error:
      print (str(os_error))
      break

def run_vivado(DESIGN_CONF, GEN_CONF):
      
  vivado_banner(BLUE)
  
  source_configs(DESIGN_CONF, GEN_CONF)
  
  set_vivado_variables()
  os.environ['VIVADO_GEN_LOG_PATH'] = VIVADO_GEN_LOG_PATH
    
  start_time=timer("start")
  
  check_dir(VIVADO_MISC_DIR, VIVADO_FINAL_LOG_PATH)
   
  while True:
    try:
      #time_period = time_period + slack
      #iters = iters + 1
      
      #print_cyan("\nCurrently running iteration no. %s for design %s" %(iters, PROJECT_NAME))
      
      #if (os.path.exists(SDC_JSON)):
      #  with open(SDC_JSON) as file:
      #    sdc_data=json.load(file)
      #    if(sdc_data['vivado'][STRATEGY]!=None):
      #      generate_interim_script(VIVADO_SDC_TEMP, VIVADO_SDC_GEN, "$PERIOD", str(sdc_data['vivado'][STRATEGY]), "$CLOCK_PORT", CLOCK_PORT)
      #      file.close()
      #elif (CLOCK_PORT):
      #  generate_interim_script(VIVADO_SDC_TEMP, VIVADO_SDC_GEN, "$PERIOD", str(time_period), "$CLOCK_PORT", CLOCK_PORT)
      #else:    
      #  generate_interim_script(VIVADO_SDC_COMB_TEMP, VIVADO_SDC_GEN, "$PERIOD", str(time_period), "$CLOCK_PORT", "clk")
  
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
          #generate_status_log(VIVADO_STATUS_LOG, "Failed", DOMAIN, STRATEGY, 0, error_msg)
          break
           
      except subprocess.TimeoutExpired as timeout_msg:
        print_red(str(timeout_msg))
        os.killpg(pgrp, signal.SIGHUP)
        runtime = timer("stop", start_time)
        update_status(VIVADO_STATUS_LOG1, PROJECT_NAME, "Timed-out", timer_string(runtime), "-", str(iters))
        #generate_status_log(VIVADO_STATUS_LOG, "Failed", DOMAIN, STRATEGY, runtime, "Error: Design timed-out")
        break

      except Exception as exception:
        print_red(str(exception))
        update_status(VIVADO_STATUS_LOG1, PROJECT_NAME, str(exception))
        break
        
      #slack = check_slack("vivado", VIVADO_GEN_TIME_LOG)
  
      #slack, slack_prev_itr = calc_slack(slack, slack_prev_itr, tolerance)
      
      #if not (slack):
      #  runtime = timer("stop", start_time)
      #  vivado_logs(slack_prev_itr, DOMAIN, STRATEGY, runtime, iters)
      #  update_json(SDC_JSON, "vivado", STRATEGY, time_period)       
      #  break
        
      #if ((iters == 26) or (iters == 32)):
      #  tolerance = tolerance*2
      #elif(iters == 40):
      #  itr_limit_msg = "Error: Iteration limit exceeded"
      #  print_red(str(itr_limit_msg))
      #  runtime = timer("stop", start_time)
      #  update_status(VIVADO_STATUS_LOG1, PROJECT_NAME, itr_limit_msg, timer_string(runtime), "-", str(iters))
      #  generate_status_log(VIVADO_STATUS_LOG, "Failed", DOMAIN, STRATEGY, runtime, itr_limit_msg)
      #  break
        
    except OSError as os_error:
      print (str(os_error))
      break
      
      
def run_quartus(DESIGN_CONF, GEN_CONF):
    
  STRATEGY = os.environ['STRATEGY']
  
  source_configs(DESIGN_CONF, GEN_CONF)
  
  set_quartus_variables()
  os.environ['QUARTUS_GEN_LOG_PATH'] = QUARTUS_GEN_LOG_PATH
  os.environ['QUARTUS_SDC_GEN'] = QUARTUS_SDC_GEN
    
  start_time=timer("start")
  iters, time_period, slack, slack_prev_itr, tolerance = init_runs(STRT_TIME, STRT_SLCK, TOL)
  
  check_dir(QUARTUS_MISC_DIR, QUARTUS_FINAL_LOG_PATH)
  
  while True:
    try:
      time_period = time_period + slack
      iters = iters + 1
      
      print_cyan("\nCurrently running iteration no. %s for design %s" %(iters, PROJECT_NAME))

      if (os.path.exists(SDC_JSON)):        
        with open(SDC_JSON) as file:
          sdc_data=json.load(file)
        file.close()
        if(sdc_data['quartus'][STRATEGY]!=None):
          generate_interim_script(QUARTUS_SDC_TEMP, QUARTUS_SDC_GEN, "$PERIOD", str(sdc_data['quartus'][STRATEGY]), "$CLOCK_PORT", CLOCK_PORT)
      else:
        generate_interim_script(QUARTUS_SDC_TEMP, QUARTUS_SDC_GEN, "$PERIOD", str(time_period), "$CLOCK_PORT", CLOCK_PORT)
  
      os.chdir(QUARTUS_MISC_DIR)
      process = subprocess.Popen(["quartus_sh", "-t", QUARTUS_SCRIPT], preexec_fn=os.setsid)
      pgrp=os.getpgid(process.pid)
      os.chdir(CGA_ROOT)

      try:
        process.communicate(timeout=TIMEOUT)
        if (process.returncode):
          error_msg = get_quartus_error_msg(QUARTUS_ERROR_LOG)
          update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, error_msg)
          print("Return code", process.returncode)
          print_red(error_msg)
          generate_status_log(QUARTUS_STATUS_LOG, "Failed", DOMAIN, STRATEGY, 0, error_msg)
          break
           
      except subprocess.TimeoutExpired as timeout_msg:
        print_red(str(timeout_msg))
        os.killpg(pgrp, signal.SIGHUP)
        runtime = timer("stop", start_time)
        update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, "Timed-out", timer_string(runtime), "-", str(iters))
        generate_status_log(QUARTUS_STATUS_LOG, "Failed", DOMAIN, STRATEGY, runtime, "Error: Design timed-out")
        break

      except Exception as exception:
        print_red(str(exception))
        update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, str(exception))
        break
        
      slack = check_slack("quartus", QUARTUS_GEN_TIME_LOG)
  
      slack, slack_prev_itr = calc_slack(slack, slack_prev_itr, tolerance)
      
      if not (slack):
        runtime = timer("stop", start_time)
        quartus_logs(slack_prev_itr, DOMAIN, STRATEGY, runtime, iters)
        update_json(SDC_JSON, "quartus", STRATEGY, time_period)       
        break
        
      if ((iters == 26) or (iters == 32)):
        tolerance = tolerance*2
      elif(iters == 40):
        itr_limit_msg = "Error: Iteration limit exceeded"
        print_red(str(itr_limit_msg))
        runtime = timer("stop", start_time)
        update_status(QUARTUS_STATUS_LOG1, PROJECT_NAME, itr_limit_msg, timer_string(runtime), "-", str(iters))
        generate_status_log(QUARTUS_STATUS_LOG, "Failed", DOMAIN, STRATEGY, runtime, itr_limit_msg)
        break
        
    except OSError as os_error:
      print (str(os_error))
      break
