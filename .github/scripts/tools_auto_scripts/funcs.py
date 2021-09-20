import os
import fnmatch
import time

RED = '\033[31m'
GREEN = '\033[32m'
YELLOW = '\033[93m'
BLUE = '\033[94m'
CYAN = '\033[96m'
ENDCOLOR = '\033[0m'

def print_red(TEXT:str):
  print(RED+TEXT+ENDCOLOR)

def print_green(TEXT:str):
  print(GREEN+TEXT+ENDCOLOR)
  
def print_yellow(TEXT:str):
  print(YELLOW+TEXT+ENDCOLOR)
  
def print_blue(TEXT:str):
  print(BLUE+TEXT+ENDCOLOR) 
  
def print_cyan(TEXT:str):
  print(CYAN+TEXT+ENDCOLOR) 

#Function to search for all the top files in RTL_benchmark folder
def find(pattern, path):
  top_path = []
  for root, dirs, files in os.walk(path):
    for name in files:
      if fnmatch.fnmatch(name, pattern):          
        top_path.append(root)
  return top_path

def check_if_string_in_file(file_name, string_to_search):
  with open(file_name, 'r') as read_obj:
    for line in read_obj:
      if string_to_search in line:
        x = line.split()
        num_worst = x.index('Worst')
        if x[num_worst + 1] == "Slack":
          result = x[num_worst + 2]
          result = re.findall(r"[-+]?\d*\.\d+|\d+", result)
          result = float(result[0])
          return result
  return False
    
def timer(operation:str, init_time=float("0")):
  if (operation == "start"):
    start_time=time.time()
    return start_time
      
  elif (operation == "stop"):
    elapsed_time = (time.time() - init_time)
    return elapsed_time
  
def timer_string(elapsed_time):
  elapsed_hr = elapsed_time // 3600
  elapsed_min = (elapsed_time % 3600) // 60
  elapsed_sec = (elapsed_time % 3600) % 60

  return str(int(elapsed_hr))+"hr "+str(int(elapsed_min))+"min "+str(int(elapsed_sec))+"sec"
  
def append_text(file:str, text:str):
  file_to_edit = open(file, "at")
  file_to_edit.write(text)
  file_to_edit.close
  
def write_text(file:str, text:str):
  file_to_edit = open(file, "wt")
  file_to_edit.write(text)
  file_to_edit.close  
  
def find_string_in_file(filename, string_to_search, string_to_replace):
  new_string = ""
  with open(filename, 'r') as read_job:
    for line in read_job:
      if string_to_search in line:
        new_string = line.replace(string_to_search, string_to_replace).strip()
        return new_string
  return new_string

def generate_interim_script(TEMP_PATH, GEN_PATH, TEMP_STRING1, GEN_STRING1, TEMP_STRING2 = "", GEN_STRING2 = ""):
  TEMP_FILE = open(TEMP_PATH,"rt")
  GEN_FILE = open(GEN_PATH,"wt")
  for line in TEMP_FILE:
    GEN_FILE.write(line.replace(TEMP_STRING1,GEN_STRING1).replace(TEMP_STRING2,GEN_STRING2))
  TEMP_FILE.close()
  GEN_FILE.close()