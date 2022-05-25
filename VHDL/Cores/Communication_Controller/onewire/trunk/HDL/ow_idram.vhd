----------------------------------------------------------------------------------
--  <c>2018 william b hunter
--    This file is part of ow2rtd.
--
--    ow2rtd is free software: you can redistribute it and/or modify
--    it under the terms of the GNU Lessor General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    ow2rtd is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU Lessor General Public License
--    along with ow2rtd.  If not, see <https://www.gnu.org/licenses/>.
-----------------------------------------------------------------------------------  
--  Create Date: 5/15/2018
--  file: ow_idram.vhd
--  description: stores the list of one wire ids. Each id is 64 bits long. holds upto 32 ids.
--  controls reset the bit counter, inc the bit counter, and write to the current location
--
-----------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
library work;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ow_idram is
  port (
    --global signals
    clk              : in    std_logic;
    --srst             : in    std_logic;  --synchronous reset
    mode             : in    std_logic;  --mode, 1=search, 0=other, used to calc read addr
    idnum            : in    std_logic_vector(4 downto 0); --index of the id to read or write
    idbit            : in    std_logic_vector(5 downto 0); --index of the bit within the id to read or write
    we               : in    std_logic;  --write the currently indexed bit
    wdat             : in    std_logic;  --bit value to write to the currently indexed bit
    rdat             : out   std_logic   --bit value of the currently indexed bit
  );
end ow_idram;


-------------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------------
architecture rtl of ow_idram is

  type mem_type is array (2047 downto 0) of std_logic;
  signal mem : mem_type ;
  attribute syn_ramstyle: string;
  attribute syn_ramstyle of mem: signal is "no_rw_check";
  
  signal rd_addr    : integer range 0 to 2047;
  signal wr_addr    : integer range 0 to 2047;
  signal mem_rdat   : std_logic;
begin


  ------------------------------------------------------
  --                    ADDRESSES                    ---
  ------------------------------------------------------
  --the read idnum has to be calculated for the search mode. In search, we write to the current id,
  --  but read from the previous id. The previous id is needed in order to decide certain branches
  --  in the search algorithm. When we are at the 0th id, there is no previous id, so we just override
  --  this with zeros.
  wr_addr <= to_integer(  unsigned(idnum) & unsigned(idbit)  );
  rd_addr <= to_integer(  unsigned(idnum) & unsigned(idbit)  ) when mode = '0'
        else to_integer(  (unsigned(idnum)-1) & unsigned(idbit)  );
  
	--if in search mode and there is no previous id, then return '0'
  rdat <= '0' when mode = '1' and  idnum = "00000" else mem_rdat;
	

  ------------------------------------------------------
  ---                     WRITE                      ---
  ------------------------------------------------------
  process (clk) -- Write memory.
  begin
    if rising_edge(clk) then
      if (we = '1') then
        --mem(to_integer(unsigned(idnum & idbit))) <= wdat;
        mem(wr_addr) <= wdat;
      end if;
    end if;
  end process;
  
  ------------------------------------------------------
  ---                     READ                       ---
  ------------------------------------------------------
  process (clk) -- Read memory.
  begin
    if rising_edge(clk) then
      mem_rdat <= mem(rd_addr);
    end if;
  end process;

end rtl;