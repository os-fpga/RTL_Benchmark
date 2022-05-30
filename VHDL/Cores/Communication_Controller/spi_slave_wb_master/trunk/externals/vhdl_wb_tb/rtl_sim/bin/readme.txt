This directory contains:

readme.txt    This file, explaining simulation environment
init.do       TCL script to be run out of modelsim. Start it from the Modelsim console with "do init.do"
              to initialize the simulation environment. It created all required libs and compiles all sources.
s.do          TCL script to be run out of modelsim. Start it to compile all changed files and start the 
              manual simulation. It assigns the alias "s" to itself which allows it to be run later just by 
              typing s+ENTER
clean.do      TCL script to clean up all waste created by modelsim              

If you want to relocate or copy this project, all file paths in the .mpf file must be adjusted in the copy.
