/*
#--------------------------------------------------------------
#-- HPC-16 Assembler
#--------------------------------------------------------------
#-- project: HPC-16 Microprocessor
#--
#-- ANTLR4 grammar on HPC-16 Assembler
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
*/

grammar HPC16;

prog : stat+;

stat : asm_inst? NEWLINE;  

asm_inst : 'mov' REG ',' REG                                # mov_reg_reg
         | 'mov' STK_PTR ',' REG                            # mov_sp_reg
         | 'mov' REG ',' STK_PTR                            # mov_reg_sp 
         | 'ld' REG ',' '(' REG ')'                         # ld_reg_reg
         | 'ld' REG ',' '(' REG '+' IMM ')'                 # ld_reg_reg_imm16
         | 'ld' REG ',' '(' STK_PTR ')'                     # ld_reg_sp
         | 'ld' REG ',' '(' STK_PTR '+' IMM ')'             # ld_reg_sp_imm16
         | 'st' REG ',' '(' REG ')'                         # st_reg_reg
         | 'st' REG ',' '(' REG '+' IMM ')'                 # st_reg_reg_imm16
         | 'st' REG ',' '(' STK_PTR ')'                     # st_reg_sp
         | 'st' REG ',' '(' STK_PTR '+' IMM ')'             # st_reg_sp_imm16
         | 'lbzx' REG ',' '(' REG ')'                       # lbzx_reg_reg
         | 'lbzx' REG ',' '(' REG '+' IMM ')'               # lbzx_reg_reg_imm16
         | 'lbsx' REG ',' '(' REG ')'                       # lbsx_reg_reg
         | 'lbsx' REG ',' '(' REG '+' IMM ')'               # lbsx_reg_reg_imm16    
         | 'sb' REG ',' '(' REG ')'                         # sb_reg_reg
         | 'sb' REG ',' '(' REG '+' IMM ')'                 # sb_reg_reg_imm16
         | 'li' REG ',' IMM                                 # li_reg_imm16
         | 'li' STK_PTR ',' IMM                             # li_sp_imm16    
         | 'inc' REG                                        # inc_reg
         | 'dec' REG                                        # dec_reg
         | 'sub' REG ',' REG                                # sub_reg_reg
         | 'and' REG ',' REG                                # and_reg_reg         
         | 'add' REG ',' REG                                # add_reg_reg                  
         | 'adc' REG ',' REG                                # adc_reg_reg
         | 'sbb' REG ',' REG                                # sbb_reg_reg
         | 'or' REG ',' REG                                 # or_reg_reg
         | 'xor' REG ',' REG                                # xor_reg_reg         
         | 'not' REG                                        # not_reg
         | 'sub' REG ',' IMM                                # sub_reg_imm16
         | 'and' REG ',' IMM                                # and_reg_imm16         
         | 'add' REG ',' IMM                                # add_reg_imm16                  
         | 'adc' REG ',' IMM                                # adc_reg_imm16
         | 'sbb' REG ',' IMM                                # sbb_reg_imm16
         | 'or' REG ',' IMM                                 # or_reg_imm16
         | 'xor' REG ',' IMM                                # xor_reg_imm16   
         | 'add' STK_PTR ',' IMM                            # add_sp_imm16
         | 'sub' STK_PTR ',' IMM                            # sub_sp_imm16
         | 'cmp' REG ',' REG                                # cmp_reg_reg
         | 'test' REG ',' REG                               # test_reg_reg
         | 'cmp' REG ',' IMM                                # cmp_reg_imm16
         | 'test' REG ',' IMM                               # test_reg_imm16     
         | 'sll' REG ',' REG                                # sll_reg_reg
         | 'slr' REG ',' REG                                # slr_reg_reg
         | 'sal' REG ',' REG                                # sal_reg_reg
         | 'sar' REG ',' REG                                # sar_reg_reg         
         | 'rol' REG ',' REG                                # rol_reg_reg
         | 'ror' REG ',' REG                                # ror_reg_reg
         | 'rcl' REG ',' REG                                # rcl_reg_reg
         | 'rcr' REG ',' REG                                # rcr_reg_reg         
         | 'sll' REG ',' IMM                                # sll_reg_imm4
         | 'slr' REG ',' IMM                                # slr_reg_imm4
         | 'sal' REG ',' IMM                                # sal_reg_imm4
         | 'sar' REG ',' IMM                                # sar_reg_imm4         
         | 'rol' REG ',' IMM                                # rol_reg_imm4
         | 'ror' REG ',' IMM                                # ror_reg_imm4
         | 'rcl' REG ',' IMM                                # rcl_reg_imm4
         | 'rcr' REG ',' IMM                                # rcr_reg_imm4         
         | 'push' REG                                       # push_reg
         | 'pushf'                                          # pushf
         | 'pop' REG                                        # pop_reg
         | 'popf'                                           # popf
         | 'acall' '(' REG ')'                              # acall_reg
         | 'call' '(' REG ')'                               # call_reg
         | 'call' '(' IMM ')'                               # call_imm11
         | 'ret'                                            # ret
         | 'iret'                                           # iret 
         | 'clc'                                            # clc
         | 'stc'                                            # stc
         | 'cmc'                                            # cmc
         | 'cli'                                            # cli
         | 'sti'                                            # sti
         | 'int' IMM                                        # int_imm4
         | 'into'                                           # into
         | 'ajmp' '(' REG ')'                               # ajmp
         | 'jmp' '(' REG ')'                                # jmp_reg
         | 'jmp' '(' IMM ')'                                # jmp_imm11
         | 'nop'                                            # nop
         | 'hlt'                                            # halt
         | 'jo'   IMM                                       # jo_imm7                               
         | 'jno'  IMM                                       # jno_imm7
         | 'jb'   IMM                                       # jb_imm7
         | 'jnae' IMM                                       # jnae_imm7
         | 'jnb'  IMM                                       # jnb_imm7
         | 'jae'  IMM                                       # jae_imm7
         | 'je'   IMM                                       # je_imm7
         | 'jz'   IMM                                       # jz_imm7
         | 'jne'  IMM                                       # jne_imm7
         | 'jnz'  IMM                                       # jnz_imm7
         | 'jbe'  IMM                                       # jbe_imm7
         | 'jna'  IMM                                       # jna_imm7
         | 'jnbe' IMM                                       # jnbe_imm7
         | 'ja'   IMM                                       # ja_imm7
         | 'js'   IMM                                       # js_imm7
         | 'jns'  IMM                                       # jns_imm7
         | 'jl'   IMM                                       # jl_imm7
         | 'jnge' IMM                                       # jnge_imm7
         | 'jnl'  IMM                                       # jnl_imm7
         | 'jge'  IMM                                       # jge_imm7
         | 'jle'  IMM                                       # jle_imm7
         | 'jng'  IMM                                       # jng_imm7
         | 'jnle' IMM                                       # jnle_imm7
         | 'jg'   IMM                                       # jg_imm7  
         ;
         
REG : [Rr][0-9]+;

IMM : [0-9]+
    | '0x'[0-9a-fA-F]+
    ;

STK_PTR : 'SP'
        | 'sp'
        ;

WS : [ \t]+ -> skip ;
LINE_COMMENT : '#' .*? '\r'? '\n' -> skip ; // Match "#" stuff '\n'
NEWLINE : '\r'?'\n';



