from cga_defs import *
import argparse
import os
import subprocess
import shutil

parser = argparse.ArgumentParser()
group = parser.add_mutually_exclusive_group(required=True)

parser.add_argument("-T", "--tool",
		   type=str,
		   choices=["openfpga", "vivado", "quartus"],
		   help="Specify which tool to run",
		   required=True)

group.add_argument("-a", "--all",
		   action="store_true",
		   help="Run all designs in benchmark")

group.add_argument("-f", "--file",
		   type=str,
		   help="Run all designs in file specified")

#group.add_argument("-c", "--config",
#		   nargs='+',
#		   type=str,
#		   help="Run design for the config specified")

#parser.add_argument("--strategy",
#		    type=str,
#		    choices=["default", "area", "performance"],
#		    default="default",
#		    help="Which strategy to implement",
#		    required=False)

args = parser.parse_args()


try:
  if (args.tool == "vivado"):
    subprocess.Popen(["vivado", "-version"])
  elif (args.tool == "quartus"):
    subprocess.Popen(["quartus_sh", "--version"])
except:
  print_red("%s has not been loaded" %args.tool)
  print("To load tool please use the following command:")
  if (args.tool == "vivado"):
    print_cyan("load_vivado")
  elif (args.tool == "quartus"):
    print_cyan("load_quartus")
  sys.exit()

#os.environ['STRATEGY'] = args.strategy

BENCHMARK_FILE = False
#BENCHMARK_CONF = False
if (args.file): 
  BENCHMARK_FILE = args.file
#if (args.config):
#  BENCHMARK_CONF = args.config

run(args.tool, BENCHMARK_FILE)
