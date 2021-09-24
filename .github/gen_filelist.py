import sys
import os

n = len(sys.argv)
cwd = os.getcwd()
config_path=[]

for i in range(1,n):
  #print (sys.argv[i])
  if((os.path.basename(sys.argv[i]))).endswith ((".v",".sv",".vh")):
    directory = os.path.dirname(sys.argv[i])
    config_path.append(os.path.join(cwd, directory, 'config.tcl'))
  
config_list = list(set(config_path))
print(config_list)

with open ('run_designs','a') as file_list:
  for conf in config_list:
    file_list.write(conf)
    file_list.write('\n')
file_list.close()