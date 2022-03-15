library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity ram_ex is
    port (
        clk, reset, en, r_w: in STD_LOGIC;
        aBus: in STD_LOGIC_VECTOR(7 downto 0);
        dBus: inout STD_LOGIC_VECTOR(7 downto 0)
    );
end ram_ex;

architecture ramArch of ram_ex is
type ram_typ is array(0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
signal ram: ram_typ;
begin
	process(clk) begin
		if clk'event and clk = '1' then
 			if en = '1' and r_w = '0' then
  				ram(conv_integer(unsigned(aBus))) <= dBus;
			end if;
		end if;
	end process;
	
	dBus <= ram(conv_integer(unsigned(aBus)))
  			when reset = '0' and en = '1' and r_w = '1' else
			"ZZZZZZZZZZZZZZZZ";
end ramArch;


