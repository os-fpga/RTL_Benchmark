--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- miniMIPS Superscalar Processor : Instruction extraction stage        --
-- based on miniMIPS Processor                                          --
--                                                                      --
--                                                                      --
-- Author : Miguel Cafruni                                              --
-- miguel_cafruni@hotmail.com                                           --
--                                                      December 2018   --
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.pack_mips.all;

entity pps_ei is
port (
  clock : in std_logic;
  reset : in std_logic;
  clear : in std_logic;    -- Clear the pipeline stage
  stop_all : in std_logic; -- Evolution locking signal
  
  -- Asynchronous inputs
  stop_ei : in std_logic;  -- Lock the EI_adr and Ei_instr registers
  genop : in std_logic;    -- Send nops

  -- Bus controler interface
  CTE_instr : in bus32;    -- Instruction from the memory
  ETC_adr : out bus32;     -- Address to read in memory

  -- Synchronous inputs from PF stage
  PF_pc : in bus32;        -- Current value of the pc

  -- Synchronous outputs to DI stage
  EI_instr : out bus32;    -- Read interface
  EI_adr : out bus32;      -- Address from the read instruction
  EI_it_ok : out std_logic -- Allow hardware interruptions
);
end pps_ei;

architecture rtl of pps_ei is
begin

  ETC_adr <= PF_pc; -- Connexion of the PC to the memory address bus

  -- Set the results
  process (clock)
  begin
    if rising_edge(clock) then
      if reset='1' then
        EI_instr <= INS_NOP;
        EI_adr <= (others => '0');
        EI_it_ok <= '0';
      elsif stop_all='0' then
        if clear='1' then
          -- Clear the stage
          EI_instr <= INS_NOP;
          EI_it_ok <= '0';
        elsif genop='1' and stop_ei='0' then
          -- Send a nop
          EI_instr <= INS_NOP;
          EI_it_ok <= '1';
        elsif stop_ei='0' then
          -- Normal evolution
          EI_adr <= PF_pc;
          EI_instr <= CTE_instr;
          EI_it_ok <= '1';
        end if;
      end if;
    end if;
  end process;
end rtl;
