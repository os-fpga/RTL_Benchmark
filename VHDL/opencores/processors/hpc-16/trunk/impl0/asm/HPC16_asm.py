#!/usr/bin/python
#--------------------------------------------------------------
#-- HPC-16 Assembler
#--------------------------------------------------------------
#-- project: HPC-16 Microprocessor
#--
#-- usage: HPC16_asm.py <input_file>
#--
#-- 
#--
#-- Author: M. Umair Siddiqui (umairsiddiqui@opencores.org)
#---------------------------------------------------------------
#------------------------------------------------------------------------------------
#--                                                                                --
#--    Copyright (c) 2015, M. Umair Siddiqui all rights reserved                   --
#--                                                                                --
#--    This file is part of HPC-16.                                                --
#--                                                                                --
#--    HPC-16 is free software; you can redistribute it and/or modify              --
#--    it under the terms of the GNU Lesser General Public License as published by --
#--    the Free Software Foundation; either version 2.1 of the License, or         --
#--    (at your option) any later version.                                         --
#--                                                                                --
#--    HPC-16 is distributed in the hope that it will be useful,                   --
#--    but WITHOUT ANY WARRANTY; without even the implied warranty of              --
#--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               --
#--    GNU Lesser General Public License for more details.                         --
#--                                                                                --
#--    You should have received a copy of the GNU Lesser General Public License    --
#--    along with HPC-16; if not, write to the Free Software                       --
#--    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   --
#--                                                                                --
#------------------------------------------------------------------------------------

from __future__ import print_function
import sys
import os
import re
from antlr4 import *
from HPC16Lexer import HPC16Lexer
from HPC16Parser import HPC16Parser
from MyHPC16Listener import MyHPC16Listener
from antlr4.error.ErrorStrategy import BailErrorStrategy
from antlr4.error.Errors import *

def start():
  if len(sys.argv) < 2:
    usage()
    sys.exit(1)
  input_stream = FileStream(sys.argv[1])  
  a, _ = os.path.splitext(os.path.basename(sys.argv[1]))  
  fout_name = a + "_asm_out.txt"
  
  fout = open(fout_name, 'w')
  
  lexer = HPC16Lexer(input_stream)
  
  token_stream = CommonTokenStream(lexer)
  parser = HPC16Parser(token_stream)
  parser._errHandler = BailErrorStrategy()

  try :
    tree = parser.prog()
    walker = ParseTreeWalker()    
    walker.walk(MyHPC16Listener(fout), tree)  
  except ParseCancellationException, e: 
    print(sys.argv[0], "\nERROR Found invalid instruction\n in:", sys.argv[1], file=sys.stderr)
    fout.close()
  else:
    fout.close()
    mkrom_vhdl_sim(fout_name, a + "_init_ram.txt")
    
    

def mkrom_vhdl_sim(fin_name , fout_name):
  fin  = open(fin_name, 'r')
  fout = open(fout_name, 'w')
  lc = 0
  for line in fin:
    if not re.match("^#", line):
      b = "{:#018b}".format(int(line, 16))      
      s = str(lc) + ":" + b[2:]
      print(s, file=fout)
      lc = lc + 1
  
  fin.close()
  fout.close()
  

def usage():
  print("usage:\n", sys.argv[0], "<input file>\n",  file=sys.stderr)
  
  
  
if __name__ == '__main__':
  start()




