-------------------------------------------------------
-- Design Name : Clock Divider for PDP8 
-- File Name   : divider.vhd
-- Function    : Heartbeat and uart baud clk generator
-- Coder       : Ian Schofield
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

entity divider is
    port (
        sysclk      :in  std_logic;
        dtxclk       :out std_logic;
        drxclk       :out std_logic;
        hbt         :out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;
architecture rtl of divider is

signal txdiv : STD_LOGIC_VECTOR(11 downto 0):=X"000";
signal leddiv : STD_LOGIC_VECTOR(31 downto 0):=X"00000000";
signal rxdiv : STD_LOGIC_VECTOR(7 downto 0):=X"00";
signal ledval : STD_LOGIC:='0';
signal txbit : STD_LOGIC:='0';
signal rxbit : STD_LOGIC:='0';


begin

PROCESS(sysclk) BEGIN
	IF sysclk = '1' AND sysclk'EVENT THEN
	 txdiv<=txdiv+1;
	 leddiv<=leddiv+1;
	 rxdiv<=rxdiv+1;
	 if (txdiv=217) then
	  txdiv<=O"0000";
	  txbit<=not txbit;
	  dtxclk<=txbit;
	 end if;
	 if (rxdiv=13) then
	  rxdiv<=X"00";
	  rxbit<=not rxbit;
	  drxclk<=rxbit;
	 end if;
	 if (leddiv=20000000) then
	  leddiv<=X"00000000";
	  ledval<= not ledval;
	  hbt<="111" & ledval;
	 end if;
	end if;
	END PROCESS;

end architecture;

