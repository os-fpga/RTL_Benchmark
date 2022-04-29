-- $Id: output.vhdl,v 1.1.1.1 2005-12-06 02:47:47 arif_endro Exp $
-------------------------------------------------------------------------------
-- Title       : Output
-- Project     : Mini AES 128 
-------------------------------------------------------------------------------
-- File        : output.vhdl
-- Author      : "Arif E. Nugroho" <arif_endro@yahoo.com>
-- Created     : 2005/12/03
-- Last update : 
-- Simulators  : ModelSim SE PLUS 6.0
-- Synthesizers: ISE Xilinx 6.3i
-- Target      : 
-------------------------------------------------------------------------------
-- Description : Output file to analize and record output of test bench.
-------------------------------------------------------------------------------
-- Copyright (C) 2005 Arif E. Nugroho
-- This VHDL design file is an open design; you can redistribute it and/or
-- modify it and/or implement it after contacting the author
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 
--         THIS SOURCE FILE MAY BE USED AND DISTRIBUTED WITHOUT RESTRICTION
-- PROVIDED THAT THIS COPYRIGHT STATEMENT IS NOT REMOVED FROM THE FILE AND THAT
-- ANY DERIVATIVE WORK CONTAINS THE ORIGINAL COPYRIGHT NOTICE AND THE
-- ASSOCIATED DISCLAIMER.
-- 
-------------------------------------------------------------------------------
-- 
--         THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
-- IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
-- EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
-- PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
-- OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
-- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
-- OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity output is
  port (
    clock          : in std_logic;
    enc            : in std_logic;
    done           : in std_logic;
    test_iteration : in integer;
    verifier       : in std_logic_vector (127 downto 000);
    data_o         : in std_logic_vector (127 downto 000)
    );
end output;

architecture test_bench of output is

  file out_enc_file_ptr : text open write_mode is "ecb_tbl_result_enc.txt";
  file out_dec_file_ptr : text open write_mode is "ecb_tbl_result_dec.txt";
  signal failed         : integer := 0;
  signal passed         : integer := 0;

begin

  process (clock)
    variable out_line                     : line;
  begin
    if (clock = '1' and clock'event) then
      if (done = '1') then
        write(out_line, string'("Test ====> "));
        write(out_line, test_iteration);
        if ( enc = '0') then
          writeline(out_enc_file_ptr, out_line);
        else
          writeline(out_dec_file_ptr, out_line);
        end if;
        write(out_line, string'("Expected : "));
        write(out_line, verifier);
        if ( enc = '0') then
          writeline(out_enc_file_ptr, out_line);
        else
          writeline(out_dec_file_ptr, out_line);
        end if;
        write(out_line, string'("Got      : "));
        write(out_line, data_o);
        if ( enc = '0') then
          writeline(out_enc_file_ptr, out_line);
        else
          writeline(out_dec_file_ptr, out_line);
        end if;
        write(out_line, string'("Status   : "));
        if (verifier = data_o ) then
          write (out_line, string'("OK"));
          passed <= passed + 1;
        else
          write (out_line, string'("FAILED"));
          failed <= failed + 1;
        end if;
        if ( enc = '0') then
          writeline(out_enc_file_ptr, out_line);
        else
          writeline(out_dec_file_ptr, out_line);
        end if;

      end if;

    end if;

  end process;

end test_bench;
