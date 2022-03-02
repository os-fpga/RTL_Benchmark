--
-- pre.vhd
--
-- Cordic pre-processing block
--
--
-- step 1:	determine quadrant and generate absolute value of X and Y
--		Q1: Xnegative
--		Q2: Ynegative
--
-- step 2:	swap X and Y values if Y>X
--		Q3: swapped (Y > X)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity pre is
	port(
		clk	: in std_logic;
		ena	: in std_logic;

		Xi	: in signed(15 downto 0);
		Yi	: in signed(15 downto 0);

		Xo	: out std_logic_vector(15 downto 0);
		Yo	: out std_logic_vector(15 downto 0);
		Q	: out std_logic_vector(2 downto 0));
end entity pre;

architecture dataflow of pre is
	signal Xint1, Yint1		: unsigned(15 downto 0);
	signal Xneg, Yneg, swap	: std_logic;

begin
	--
	-- step 1: Determine absolute value of X and Y, set Xneg and Yneg
	--
	Step1: process(clk, Xi, Yi)
	begin
		if (clk'event and clk = '1') then
			if (ena = '1') then
				Xint1 <= conv_unsigned(abs(Xi), 16);
				Xneg <= Xi(Xi'left);

				Yint1 <= conv_unsigned(abs(Yi), 16);
				Yneg <= Yi(Yi'left);
			end if;
		end if;
	end process Step1;

	--
	-- step 2: Swap X and Y if Y>X
	--
	Step2: process(clk)
		variable Xint2, Yint2	: unsigned(15 downto 0);
	begin
		if (Yint1 > Xint1) then
			swap <= '1';
			Xint2 := Yint1;
			Yint2 := Xint1;
		else
			swap <= '0';
			Xint2 := Xint1;
			Yint2 := Yint1;
		end if;
	
		if(clk'event and clk = '1') then
			if (ena = '1') then
				Xo <= std_logic_vector(Xint2);
				Yo <= std_logic_vector(Yint2);

				Q <= (Yneg, Xneg, swap);
			end if;
		end if;
		end process Step2;

end architecture dataflow;
