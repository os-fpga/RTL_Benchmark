#--------------------------------------------------------------
#-- HPC-16 Assembler
#--------------------------------------------------------------
#-- project: HPC-16 Microprocessor
#--
#-- ANTLR4 parser Listener
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

import sys
import re
import math
from antlr4 import *
from HPC16Listener import HPC16Listener
from MyHPC16ListenerUtil import MyHPC16ListenerUtil

class MyHPC16Listener(HPC16Listener):
 
    def __init__(self, fout):
      self.debug = 1
      self.util = MyHPC16ListenerUtil(fout)
      super(MyHPC16Listener, self).__init__()

    # Enter a parse tree produced by HPC16Parser#prog.
    def enterProg(self, ctx):
        pass

    # Exit a parse tree produced by HPC16Parser#prog.
    def exitProg(self, ctx):
        self.util.cleanup()

    def enterStat(self, ctx):
      if self.debug:
        st = "#"
        for i in range(ctx.getChildCount()):
          st = st + " " + ctx.getChild(i).getText()
        self.util.write_info(st.rstrip())      

    # Exit a parse tree produced by HPC16Parser#mov_reg_reg.
    def exitMov_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["mov_reg_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)        

    # Exit a parse tree produced by HPC16Parser#mov_sp_reg.
    def exitMov_sp_reg(self, ctx):
        err = False
        src = ctx.REG().getText()
        err = not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["mov_sp_reg"], 2) << 8
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)        

    # Exit a parse tree produced by HPC16Parser#mov_reg_sp.
    def exitMov_reg_sp(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest) 
        if not err:
          ins = 0
          ins = int(self.util.opcode["mov_reg_sp"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4 
          self.util.write_ins(ins)        
      
    # Exit a parse tree produced by HPC16Parser#ld_reg_reg.
    def exitLd_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["ld_reg_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)        

    def enterLd_reg_reg_imm16(self, ctx):
      if self.debug:
        self.util.write_info("# ld %s, (%s + %s)" % 
                             (ctx.REG(0).getText(), ctx.REG(1).getText()),   )      
        
    # Exit a parse tree produced by HPC16Parser#ld_reg_reg_imm16.
    def exitLd_reg_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src) or not self.util.vld_imm_val(imm, 2**16)

        if not err:
          ins = 0
          ins = int(self.util.opcode["ld_reg_reg_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)  
          self.util.write_ins(imm)


    # Exit a parse tree produced by HPC16Parser#ld_reg_sp.
    def exitLd_reg_sp(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest) 
        if not err:
          ins = 0
          ins = int(self.util.opcode["ld_reg_sp"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)        

    # Exit a parse tree produced by HPC16Parser#ld_reg_sp_imm16.
    def exitLd_reg_sp_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)

        if not err:
          ins = 0
          ins = int(self.util.opcode["ld_reg_sp_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)  
          self.util.write_ins(imm)

    # Exit a parse tree produced by HPC16Parser#st_reg_reg.
    def exitSt_reg_reg(self, ctx):
        err = False
        src = ctx.REG(0).getText()
        dest = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["st_reg_reg"], 2) << 8
          ins = ins | int(self.util.regcode[src], 2) << 4
          ins = ins | int(self.util.regcode[dest], 2) 
          self.util.write_ins(ins)        

    # Exit a parse tree produced by HPC16Parser#st_reg_reg_imm16.
    def exitSt_reg_reg_imm16(self, ctx):
        err = False
        src = ctx.REG(0).getText()
        dest = ctx.REG(1).getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src) or not self.util.vld_imm_val(imm, 2**16)

        if not err:
          ins = 0
          ins = int(self.util.opcode["st_reg_reg_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[src], 2) << 4
          ins = ins | int(self.util.regcode[dest], 2) 
          self.util.write_ins(ins)  
          self.util.write_ins(imm)

    # Exit a parse tree produced by HPC16Parser#st_reg_sp.
    def exitSt_reg_sp(self, ctx):
        err = False
        src = ctx.REG().getText()
        err = not self.util.vld_reg(src)

        if not err:
          ins = 0
          ins = int(self.util.opcode["st_reg_sp"], 2) << 8
          ins = ins | int(self.util.regcode[src], 2) << 4
          self.util.write_ins(ins)  

    # Exit a parse tree produced by HPC16Parser#st_reg_sp_imm16.
    def exitSt_reg_sp_imm16(self, ctx):
        err = False
        src = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())        
        err = not self.util.vld_reg(src) or not self.util.vld_imm_val(imm, 2**16)

        if not err:
          ins = 0
          ins = int(self.util.opcode["st_reg_sp_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[src], 2) << 4
          self.util.write_ins(ins)   
          self.util.write_ins(imm)


    # Exit a parse tree produced by HPC16Parser#lbzx_reg_reg.
    def exitLbzx_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["lbzx_reg_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)        


    # Exit a parse tree produced by HPC16Parser#lbzx_reg_reg_imm16.
    def exitLbzx_reg_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src) or not self.util.vld_imm_val(imm, 2**16)

        if not err:
          ins = 0
          ins = int(self.util.opcode["lbzx_reg_reg_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)  
          self.util.write_ins(imm)

    # Exit a parse tree produced by HPC16Parser#lbsx_reg_reg.
    def exitLbsx_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["lbsx_reg_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)        

    # Exit a parse tree produced by HPC16Parser#lbsx_reg_reg_imm16.
    def exitLbsx_reg_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src) or not self.util.vld_imm_val(imm, 2**16)

        if not err:
          ins = 0
          ins = int(self.util.opcode["lbsx_reg_reg_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)  
          self.util.write_ins(imm)

    # Exit a parse tree produced by HPC16Parser#sb_reg_reg.
    def exitSb_reg_reg(self, ctx):
        err = False
        src = ctx.REG(0).getText()
        dest = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["sb_reg_reg"], 2) << 8
          ins = ins | int(self.util.regcode[src], 2) << 4
          ins = ins | int(self.util.regcode[dest], 2) 
          self.util.write_ins(ins)        

    # Exit a parse tree produced by HPC16Parser#sb_reg_reg_imm16.
    def exitSb_reg_reg_imm16(self, ctx):
        err = False
        src = ctx.REG(0).getText()
        dest = ctx.REG(1).getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src) or not self.util.vld_imm_val(imm, 2**16)

        if not err:
          ins = 0
          ins = int(self.util.opcode["sb_reg_reg_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[src], 2) << 4
          ins = ins | int(self.util.regcode[dest], 2) 
          self.util.write_ins(ins)  
          self.util.write_ins(imm)
          
    # Exit a parse tree produced by HPC16Parser#li_reg_imm16.
    def exitLi_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["li_reg_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)  
          self.util.write_ins(imm)
          

    # Exit a parse tree produced by HPC16Parser#li_sp_imm16.
    def exitLi_sp_imm16(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["li_sp_imm16"], 2) << 8
          self.util.write_ins(ins)  
          self.util.write_ins(imm)


    # Exit a parse tree produced by HPC16Parser#inc_reg.
    def exitInc_reg(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest) 
        if not err:
          ins = 0
          ins = int(self.util.opcode["inc_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)  

    # Exit a parse tree produced by HPC16Parser#dec_reg.
    def exitDec_reg(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest) 
        if not err:
          ins = 0
          ins = int(self.util.opcode["dec_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)  

    # Exit a parse tree produced by HPC16Parser#sub_reg_reg.
    def exitSub_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alur"], 2) << 11
          ins = ins | int(self.util.alu_opcode["sub"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#and_reg_reg.
    def exitAnd_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alur"], 2) << 11
          ins = ins | int(self.util.alu_opcode["and"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#add_reg_reg.
    def exitAdd_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alur"], 2) << 11
          ins = ins | int(self.util.alu_opcode["add"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#adc_reg_reg.
    def exitAdc_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alur"], 2) << 11
          ins = ins | int(self.util.alu_opcode["adc"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#sbb_reg_reg.
    def exitSbb_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alur"], 2) << 11
          ins = ins | int(self.util.alu_opcode["sbb"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#or_reg_reg.
    def exitOr_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alur"], 2) << 11
          ins = ins | int(self.util.alu_opcode["or"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#xor_reg_reg.
    def exitXor_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alur"], 2) << 11
          ins = ins | int(self.util.alu_opcode["xor"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#not_reg.
    def exitNot_reg(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest)         
        if not err:
          ins = 0
          ins = int(self.util.opcode["alur"], 2) << 11
          ins = ins | int(self.util.alu_opcode["not"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#sub_reg_imm16.
    def exitSub_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alui"], 2) << 11
          ins = ins | int(self.util.alu_opcode["sub"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)
          self.util.write_ins(imm)          

    # Exit a parse tree produced by HPC16Parser#and_reg_imm16.
    def exitAnd_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alui"], 2) << 11
          ins = ins | int(self.util.alu_opcode["and"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)
          self.util.write_ins(imm)          

    # Exit a parse tree produced by HPC16Parser#add_reg_imm16.
    def exitAdd_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alui"], 2) << 11
          ins = ins | int(self.util.alu_opcode["add"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)
          self.util.write_ins(imm)          

    # Exit a parse tree produced by HPC16Parser#adc_reg_imm16.
    def exitAdc_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alui"], 2) << 11
          ins = ins | int(self.util.alu_opcode["adc"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)
          self.util.write_ins(imm)          

    # Exit a parse tree produced by HPC16Parser#sbb_reg_imm16.
    def exitSbb_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alui"], 2) << 11
          ins = ins | int(self.util.alu_opcode["sbb"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)
          self.util.write_ins(imm)          


    # Exit a parse tree produced by HPC16Parser#or_reg_imm16.
    def exitOr_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alui"], 2) << 11
          ins = ins | int(self.util.alu_opcode["or"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)
          self.util.write_ins(imm)          

    # Exit a parse tree produced by HPC16Parser#xor_reg_imm16.
    def exitXor_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["alui"], 2) << 11
          ins = ins | int(self.util.alu_opcode["xor"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)
          self.util.write_ins(imm)          


    # Exit a parse tree produced by HPC16Parser#add_sp_imm16.
    def exitAdd_sp_imm16(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["add_sp_imm16"], 2) << 8
          self.util.write_ins(ins)
          self.util.write_ins(imm)                    

    # Exit a parse tree produced by HPC16Parser#sub_sp_imm16.
    def exitSub_sp_imm16(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**16)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["sub_sp_imm16"], 2) << 8
          self.util.write_ins(ins)
          self.util.write_ins(imm)                    

    # Exit a parse tree produced by HPC16Parser#cmp_reg_reg.
    def exitCmp_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["cmp_reg_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)        

    # Exit a parse tree produced by HPC16Parser#test_reg_reg.
    def exitTest_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) or not self.util.vld_reg(src)
        if not err:
          ins = 0
          ins = int(self.util.opcode["test_reg_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)        

    # Exit a parse tree produced by HPC16Parser#cmp_reg_imm16.
    def exitCmp_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)
        if not err:
          ins = 0
          ins = int(self.util.opcode["cmp_reg_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4        
          self.util.write_ins(ins) 
          self.util.write_ins(imm)

    # Exit a parse tree produced by HPC16Parser#test_reg_imm16.
    def exitTest_reg_imm16(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**16)
        if not err:
          ins = 0
          ins = int(self.util.opcode["test_reg_imm16"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4        
          self.util.write_ins(ins) 
          self.util.write_ins(imm)


    # Exit a parse tree produced by HPC16Parser#sll_reg_reg.
    def exitSll_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["shiftr"], 2) << 11
          ins = ins | int(self.util.shift_opcode["sll"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#slr_reg_reg.
    def exitSlr_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["shiftr"], 2) << 11
          ins = ins | int(self.util.shift_opcode["slr"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#sal_reg_reg.
    def exitSal_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["shiftr"], 2) << 11
          ins = ins | int(self.util.shift_opcode["sal"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#sar_reg_reg.
    def exitSar_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["shiftr"], 2) << 11
          ins = ins | int(self.util.shift_opcode["sar"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#rol_reg_reg.
    def exitRol_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["shiftr"], 2) << 11
          ins = ins | int(self.util.shift_opcode["rol"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#ror_reg_reg.
    def exitRor_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["shiftr"], 2) << 11
          ins = ins | int(self.util.shift_opcode["ror"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#rcl_reg_reg.
    def exitRcl_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["shiftr"], 2) << 11
          ins = ins | int(self.util.shift_opcode["rcl"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#rcr_reg_reg.
    def exitRcr_reg_reg(self, ctx):
        err = False
        dest = ctx.REG(0).getText()
        src = ctx.REG(1).getText()
        err = not self.util.vld_reg(dest) and not self.util.vld_reg(src)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["shiftr"], 2) << 11
          ins = ins | int(self.util.shift_opcode["rcr"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | int(self.util.regcode[src], 2) 
          self.util.write_ins(ins)
    

    # Exit a parse tree produced by HPC16Parser#sll_reg_imm4.
    def exitSll_reg_imm4(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**4)
        if not err:
          ins = 0
          ins = int(self.util.opcode["shifti"], 2) << 11
          ins = ins | int(self.util.shift_opcode["sll"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | imm 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#slr_reg_imm4.
    def exitSlr_reg_imm4(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**4)
        if not err:
          ins = 0
          ins = int(self.util.opcode["shifti"], 2) << 11
          ins = ins | int(self.util.shift_opcode["slr"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | imm 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#sal_reg_imm4.
    def exitSal_reg_imm4(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**4)
        if not err:
          ins = 0
          ins = int(self.util.opcode["shifti"], 2) << 11
          ins = ins | int(self.util.shift_opcode["sal"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | imm 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#sar_reg_imm4.
    def exitSar_reg_imm4(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**4)
        if not err:
          ins = 0
          ins = int(self.util.opcode["shifti"], 2) << 11
          ins = ins | int(self.util.shift_opcode["sar"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | imm 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#rol_reg_imm4.
    def exitRol_reg_imm4(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**4)
        if not err:
          ins = 0
          ins = int(self.util.opcode["shifti"], 2) << 11
          ins = ins | int(self.util.shift_opcode["rol"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | imm 
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#ror_reg_imm4.
    def exitRor_reg_imm4(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**4)
        if not err:
          ins = 0
          ins = int(self.util.opcode["shifti"], 2) << 11
          ins = ins | int(self.util.shift_opcode["ror"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | imm 
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#rcl_reg_imm4.
    def exitRcl_reg_imm4(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**4)
        if not err:
          ins = 0
          ins = int(self.util.opcode["shifti"], 2) << 11
          ins = ins | int(self.util.shift_opcode["rcl"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | imm 
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#rcr_reg_imm4.
    def exitRcr_reg_imm4(self, ctx):
        err = False
        dest = ctx.REG().getText()
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_reg(dest) or not self.util.vld_imm_val(imm, 2**4)
        if not err:
          ins = 0
          ins = int(self.util.opcode["shifti"], 2) << 11
          ins = ins | int(self.util.shift_opcode["rcr"], 2) << 8          
          ins = ins | int(self.util.regcode[dest], 2) << 4
          ins = ins | imm 
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#push_reg.
    def exitPush_reg(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest)
        if not err:
          ins = 0
          ins = int(self.util.opcode["push_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#pushf.
    def exitPushf(self, ctx):
        ins = 0
        ins = int(self.util.opcode["pushf"], 2) << 8
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#pop_reg.
    def exitPop_reg(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest)
        if not err:
          ins = 0
          ins = int(self.util.opcode["pop_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) << 4
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#popf.
    def exitPopf(self, ctx):
        ins = 0
        ins = int(self.util.opcode["popf"], 2) << 8
        self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#acall_reg.
    def exitAcall_reg(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest) 
        if not err:
          ins = 0
          ins = int(self.util.opcode["acall_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) 
          self.util.write_ins(ins)  


    # Exit a parse tree produced by HPC16Parser#call_reg.
    def exitCall_reg(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest) 
        if not err:
          ins = 0
          ins = int(self.util.opcode["call_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) 
          self.util.write_ins(ins)  



    # Exit a parse tree produced by HPC16Parser#call_imm11.
    def exitCall_imm11(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**11)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["call_imm11"], 2) << 11
          ins = ins | imm
          self.util.write_ins(ins)  
          

    # Exit a parse tree produced by HPC16Parser#ret.
    def exitRet(self, ctx):
        ins = 0
        ins = int(self.util.opcode["ret"], 2) << 11
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#iret.
    def exitIret(self, ctx):
        ins = 0
        ins = int(self.util.opcode["iret"], 2) << 11
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#clc.
    def exitClc(self, ctx):
        ins = 0
        ins = int(self.util.opcode["clc"], 2) << 8
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#slc.
    def exitStc(self, ctx):
        ins = 0
        ins = int(self.util.opcode["stc"], 2) << 8
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#cmc.
    def exitCmc(self, ctx):
        ins = 0
        ins = int(self.util.opcode["cmc"], 2) << 8
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#cli.
    def exitCli(self, ctx):
        ins = 0
        ins = int(self.util.opcode["cli"], 2) << 8
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#sti.
    def exitSti(self, ctx):
        ins = 0
        ins = int(self.util.opcode["sti"], 2) << 8
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#int_imm4.
    def exitInt_imm4(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**4)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["int_imm4"], 2) << 11
          ins = ins | imm
          self.util.write_ins(ins)  

    # Exit a parse tree produced by HPC16Parser#into.
    def exitInto(self, ctx):
        ins = 0
        ins = int(self.util.opcode["into"], 2) << 11
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#ajmp.
    def exitAjmp(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest) 
        if not err:
          ins = 0
          ins = int(self.util.opcode["ajmp"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) 
          self.util.write_ins(ins)  


    # Exit a parse tree produced by HPC16Parser#jmp_reg.
    def exitJmp_reg(self, ctx):
        err = False
        dest = ctx.REG().getText()
        err = not self.util.vld_reg(dest) 
        if not err:
          ins = 0
          ins = int(self.util.opcode["jmp_reg"], 2) << 8
          ins = ins | int(self.util.regcode[dest], 2) 
          self.util.write_ins(ins)  

    # Exit a parse tree produced by HPC16Parser#jmp_imm11.
    def exitJmp_imm11(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**11)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jmp_imm11"], 2) << 11
          ins = ins | imm
          self.util.write_ins(ins)  

    # Exit a parse tree produced by HPC16Parser#nop.
    def exitNop(self, ctx):
        ins = 0
        ins = int(self.util.opcode["nop"], 2) << 11
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#halt.
    def exitHalt(self, ctx):
        ins = 0
        ins = int(self.util.opcode["halt"], 2) << 11
        self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jo_imm7.
    def exitJo_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jo"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jno_imm7.
    def exitJno_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jno"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jb_imm7.
    def exitJb_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jb"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jnae_imm7.
    def exitJnae_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jnae"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jnb_imm7.
    def exitJnb_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jnb"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#jae_imm7.
    def exitJae_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jae"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)
          


    # Exit a parse tree produced by HPC16Parser#je_imm7.
    def exitJe_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["je"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jz_imm7.
    def exitJz_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jz"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jne_imm7.
    def exitJne_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jne"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jnz_imm7.
    def exitJnz_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jnz"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jbe_imm7.
    def exitJbe_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jbe"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jna_imm7.
    def exitJna_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jna"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jnbe_imm7.
    def exitJnbe_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jnbe"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#ja_imm7.
    def exitJa_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["ja"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#js_imm7.
    def exitJs_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["js"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jns_imm7.
    def exitJns_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jns"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jl_imm7.
    def exitJl_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jl"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jnge_imm7.
    def exitJnge_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jnge"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jnl_imm7.
    def exitJnl_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jnl"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#jge_imm7.
    def exitJge_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jge"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#jle_imm7.
    def exitJle_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jle"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#jng_imm7.
    def exitJng_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jng"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)


    # Exit a parse tree produced by HPC16Parser#jnle_imm7.
    def exitJnle_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jnle"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)

    # Exit a parse tree produced by HPC16Parser#jg_imm7.
    def exitJg_imm7(self, ctx):
        err = False
        imm = self.util.get_imm_val(ctx.IMM().getText())
        err = not self.util.vld_imm_val(imm, 2**7)        
        if not err:
          ins = 0
          ins = int(self.util.opcode["jcc"], 2) << 11        
          ins = ins | (imm >> 4) << 8
          ins = ins | int(self.util.jcc_opcode["jg"], 2) << 4
          ins = ins | (imm & 0x0f)
          self.util.write_ins(ins)


