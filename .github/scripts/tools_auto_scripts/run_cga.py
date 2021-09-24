import sys
sys.dont_write_bytecode = True
from cga_defs import *
import argparse
import os
import subprocess
import shutil


parser = argparse.ArgumentParser()
group = parser.add_mutually_exclusive_group(required=True)

parser.add_argument("-T", "--tool",
		   type=str,
		   choices=["vivado", "quartus", "lattice", "yosys"],
		   help="Specify which tool to run",
		   required=True)

group.add_argument("-a", "--all",
		   action="store_true",
		   help="Run all designs in benchmark")

group.add_argument("-f", "--file",
		   type=str,
		   help="Run all designs in file specified")


args = parser.parse_args()

if (args.tool == "vivado"):
  subprocess.Popen(["vivado", "-version"])
elif (args.tool == "quartus"):
  subprocess.Popen(["quartus_sh", "--version"])
elif (args.tool == "lattice"):
  subprocess.Popen(["diamondc", "-version"])
elif (args.tool == "yosys"):
  subprocess.Popen(["yosys", "-version"])
  

BENCHMARK_FILE = False
if (args.file): 
  BENCHMARK_FILE = args.file

run(args.tool, BENCHMARK_FILE)
