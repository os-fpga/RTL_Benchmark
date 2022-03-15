#--------------------------------------------------------------
#-- HPC-16 Assembler
#--------------------------------------------------------------
#-- project: HPC-16 Microprocessor
#--
#-- ANTLR4 parser Listener Util
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
import re
import math
from antlr4.error.Errors import *

class MyHPC16ListenerUtil:
  
    def __init__(self, fout):
      self.fout = fout
      self.opcode = dict()
      self.regcode = dict()
      self.jcc_opcode = dict()      
      self.alu_opcode = dict()     
      self.shift_opcode = dict()      
      self.setup_opcode()
      self.setup_regcode()
      self.setup_jcc_opcode()
      self.setup_alu_opcode()
      self.setup_shift_opcode()
      
    def setup_shift_opcode(self):      
      self.shift_opcode["sll"] = '0b000'
      self.shift_opcode["slr"] = '0b001'
      self.shift_opcode["sal"] = '0b010'
      self.shift_opcode["sar"] = '0b011'
      self.shift_opcode["rol"] = '0b100'
      self.shift_opcode["ror"] = '0b101'
      self.shift_opcode["rcl"] = '0b110'
      self.shift_opcode["rcr"] = '0b111'

    def setup_alu_opcode(self):
      self.alu_opcode["sub"] = '0b000'
      self.alu_opcode["add"] = '0b001'
      self.alu_opcode["sbb"] = '0b010'
      self.alu_opcode["adc"] = '0b011'
      self.alu_opcode["not"] = '0b100'
      self.alu_opcode["and"] = '0b101'
      self.alu_opcode["or "] = '0b110'
      self.alu_opcode["xor"] = '0b111'
      
    def setup_regcode(self):
      for i in range(16):
        self.regcode['R'+str(i)] = bin(i)
        self.regcode['r'+str(i)] = bin(i)
        
    def setup_jcc_opcode(self):
      self.jcc_opcode ["jo"]  = '0b0000'
      self.jcc_opcode ["jno"] = '0b0001'
      self.jcc_opcode ["jb"] = '0b0010'
      self.jcc_opcode ["jnae"] = '0b0010'
      self.jcc_opcode ["jnb"] = '0b0011'
      self.jcc_opcode ["jae"] = '0b0011'
      self.jcc_opcode ["je"] = '0b0100'
      self.jcc_opcode ["jz"] = '0b0100'
      self.jcc_opcode ["jne"] = '0b0101'
      self.jcc_opcode ["jnz"] = '0b0101'
      self.jcc_opcode ["jbe"] = '0b0110'
      self.jcc_opcode ["jna"] = '0b0110'
      self.jcc_opcode ["jnbe"] = '0b0111'
      self.jcc_opcode ["ja"]   = '0b0111'
      self.jcc_opcode ["js"]   = '0b1000'
      self.jcc_opcode ["jns"]   = '0b1001'
      self.jcc_opcode ["jl"]     = '0b1100'
      self.jcc_opcode ["jnge"]   = '0b1100'
      self.jcc_opcode ["jnl"]   = '0b1101'
      self.jcc_opcode ["jge"]   = '0b1101'
      self.jcc_opcode ["jle"]   = '0b1110'
      self.jcc_opcode ["jng"]   = '0b1110'
      self.jcc_opcode ["jnle"] = '0b1111'
      self.jcc_opcode ["jg"]   = '0b1111'      
        

    def setup_opcode(self):
      self.opcode["mov_reg_reg"] = '0b00000001'
      self.opcode["mov_sp_reg"]  = '0b00000010'
      self.opcode["mov_reg_sp"]  = '0b00000100'

      self.opcode["ld_reg_reg"]           = '0b00001000'
      self.opcode["ld_reg_reg_imm16"]     = '0b00001001'
      self.opcode["ld_reg_sp"]            = '0b00001010'
      self.opcode["ld_reg_sp_imm16"]      = '0b00001100'

      self.opcode["st_reg_reg"]           = '0b00010000'
      self.opcode["st_reg_reg_imm16"]     = '0b00010001'
      self.opcode["st_reg_sp"]            = '0b00010010'
      self.opcode["st_reg_sp_imm16"]      = '0b00010100'

      self.opcode["lbzx_reg_reg"]         = '0b00011000'
      self.opcode["lbzx_reg_reg_imm16"]   = '0b00011100'
      self.opcode["lbsx_reg_reg"]         = '0b00011001'
      self.opcode["lbsx_reg_reg_imm16"]   = '0b00011101'

      self.opcode["sb_reg_reg"]           = '0b00100001'
      self.opcode["sb_reg_reg_imm16"]     = '0b00100010'
        
      self.opcode["inc_reg"]              = '0b00101000'
      self.opcode["dec_reg"]              = '0b00101001'

      self.opcode["alur"]    = '0b00110'   
      self.opcode["shiftr"]  = '0b00111'

      self.opcode["cmp_reg_reg"]          = '0b01000000'
      self.opcode["test_reg_reg"]         = '0b01000101'

      self.opcode["li_reg_imm16"]         = '0b01001001'
      self.opcode["li_sp_imm16"]          = '0b01001010'

      self.opcode["alui"]   = '0b01010'   
      self.opcode["shifti"] = '0b01011'

      self.opcode["cmp_reg_imm16"]        = '0b01100000'
      self.opcode["test_reg_imm16"]       = '0b01100101'

      self.opcode["sub_sp_imm16"]         = '0b01101000'
      self.opcode["add_sp_imm16"]         = '0b01101001'

      self.opcode["push_reg"]             = '0b01110000'
      self.opcode["pushf"]                = '0b01110001'
      self.opcode["pop_reg"]              = '0b01110100'
      self.opcode["popf"]                 = '0b01110101'

      self.opcode["acall_reg"]            = '0b01111001'
      self.opcode["call_reg"]             = '0b01111010'   
      self.opcode["call_imm11"]           = '0b10000'   

      self.opcode["ret"]                  = '0b10001'   
      self.opcode["int_imm4"]             = '0b10010'   
      self.opcode["into"]                 = '0b10011'   
      self.opcode["iret"]                 = '0b10100'

      self.opcode["ajmp"]                 = '0b10101001'

      self.opcode["jmp_reg"]              = '0b10101010'
        
      self.opcode["jmp_imm11"]            = '0b10110' 
        
      self.opcode["jcc"]    = '0b10111'

      self.opcode["clc"]    = '0b11000000'
      self.opcode["stc"]    = '0b11000001'
      self.opcode["cmc"]    = '0b11000010'
      self.opcode["cli"]    = '0b11000100'  
      self.opcode["sti"]    = '0b11000101'   
        
      self.opcode["nop"]    = '0b11110'   
      self.opcode["halt"]   = '0b11111'
      
    def log_error(self, s):
        print("# ERROR", s, "\n", file=self.fout)
        print(s, "\n", file=sys.stderr)        
        raise ParseCancellationException(s)

    def vld_reg(self, r):
      if not r in self.regcode:
        self.log_error("invalid register ===> %s\n" % dest)
        return False
      else :
        return True
      
    def vld_imm_val(self, imm_val, imm_max):
      if imm_val < imm_max:
        return True
      else:
        s = "invalid immediate operand ===> %s\n required a %d-bit value" % (hex(imm_val), int(math.log(imm_max,2)))
        self.log_error(s) 
        return False      

    def get_imm_val(self, imm):
      if re.match("0x", imm):
        return int(imm, 16)
      else:
        return int(imm)
      
    def write_ins(self, ins):
      print(hex(ins), file=self.fout)
        
    def write_info(self, info):
      print(info, file=self.fout)

    def cleanup(self):
      self.fout.close()
        