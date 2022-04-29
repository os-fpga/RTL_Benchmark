------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	adder_n.vhd / entity adder_n
-- 
-- Last Modified:	04/04/2012 
-- 
-- Description: 	512x32-bit fifo
--
--
-- Dependencies: 	FIFO18E1 primitive
--
-- Revision:
--	Revision 1.00 - Architecture
--	Revision 0.01 - File Created
--
--
------------------------------------------------------------------------------------
--
-- NOTICE:
--
-- Copyright DraMCo research group. 2011. This code may be contain portions patented
-- by other third parties!
--
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity fifo_primitive is
    Port ( clk : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0);
           empty : out  STD_LOGIC;
           full : out  STD_LOGIC;
           push : in  STD_LOGIC;
           pop : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  nopop : out STD_LOGIC;
			  nopush : out STD_LOGIC
			  );
end fifo_primitive;

architecture Behavioral of fifo_primitive is
	signal rdcount : std_logic_vector(11 downto 0); -- debugging
	signal wrcount : std_logic_vector(11 downto 0); -- debugging
	
	signal reset_i, pop_i, push_i, empty_i, full_i, wrerr_i, rderr_i : std_logic;
begin
	
	empty <= empty_i;
	full <= full_i;
	
	-- these logical equations need to be extended where necessary
	nopop <= rderr_i or (pop and reset_i);
	nopush <= wrerr_i or (push and reset_i);
	
	pop_i <= pop and (not reset_i);
	push_i <= push and (not reset_i);
	
	-- makes the reset at least three clk_cycles long
	RESET_PROC: process (reset, clk)
		variable clk_counter : integer range 0 to 3 := 3;
	begin
		if reset = '1' then
			reset_i <= '1';
			clk_counter := 3;
		elsif rising_edge(clk) then
			if clk_counter = 0 then
				clk_counter := 0;
				reset_i <= '0';
			else
				clk_counter := clk_counter - 1;
				reset_i <= '1';
			end if;
		end if;
	end process;

   FIFO18E1_inst : FIFO18E1
   generic map (
      ALMOST_EMPTY_OFFSET => X"00080",  -- Sets the almost empty threshold
      ALMOST_FULL_OFFSET => X"00080",   -- Sets almost full threshold
      DATA_WIDTH => 36,                 -- Sets data width to 4, 9, 18, or 36
      DO_REG => 1,                      -- Enable output register (0 or 1) Must be 1 if EN_SYN = "FALSE" 
      EN_SYN => TRUE,                   -- Specifies FIFO as dual-clock ("FALSE") or Synchronous ("TRUE")
      FIFO_MODE => "FIFO18_36",            -- Sets mode to FIFO18 or FIFO18_36
      FIRST_WORD_FALL_THROUGH => FALSE, -- Sets the FIFO FWFT to "TRUE" or "FALSE" 
      INIT => X"000000000",             -- Initial values on output port
      SRVAL => X"000000000"             -- Set/Reset value for output port
   )
   port map (
     -- ALMOSTEMPTY => ALMOSTEMPTY, -- 1-bit almost empty output flag
     -- ALMOSTFULL => ALMOSTFULL,   -- 1-bit almost full output flag
      DO => dout,                   -- 32-bit data output
     -- DOP => DOP,                 -- 4-bit parity data output
      EMPTY => empty_i,             -- 1-bit empty output flag
      FULL => full_i,               -- 1-bit full output flag
      -- WRCOUNT, RDCOUNT: 12-bit (each) FIFO pointers
      RDCOUNT => RDCOUNT,         -- 12-bit read count output
      WRCOUNT => WRCOUNT,         -- 12-bit write count output
      -- WRERR, RDERR: 1-bit (each) FIFO full or empty error
      RDERR => rderr_i,             -- 1-bit read error output
      WRERR => wrerr_i,             -- 1-bit write error
      DI => din,                   -- 32-bit data input
      DIP => "0000",                 -- 4-bit parity input
      RDEN => pop_i,               -- 1-bit read enable input
      REGCE => '1',             -- 1-bit clock enable input
      RST => reset_i,                 -- 1-bit reset input
      RSTREG => reset_i,           -- 1-bit output register set/reset
      -- WRCLK, RDCLK: 1-bit (each) Clocks
      RDCLK => clk,             -- 1-bit read clock input
      WRCLK => clk,             -- 1-bit write clock input
      WREN => push_i                -- 1-bit write enable input
   );

end Behavioral;

