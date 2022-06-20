library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity sinetest is
end entity sinetest;

architecture OneKHzsine of sinetest is

type SineArray is array (integer range 0 to 38) of unsigned (7 downto 0);
signal Sine : unsigned(7 downto 0) := (others => '0');
signal Data, NewData : SineArray;
signal SineToFIR : std_logic_vector(7 downto 0);

component FinalBalancedFIR IS 
PORT (
	Load : IN std_logic;
	Ct0 : OUT std_logic;
	Ct1 : OUT std_logic;
	nRST : IN std_logic;
	Ct2 : OUT std_logic;
	Ct3 : OUT std_logic;
	Total10 : OUT std_logic;
	Total11 : OUT std_logic;
	Total12 : OUT std_logic;
	Total13 : OUT std_logic;
	Total14 : OUT std_logic;
	Total15 : OUT std_logic;
	Qco0 : OUT std_logic;
	Qco1 : OUT std_logic;
	Qco2 : OUT std_logic;
	Qco3 : OUT std_logic;
	Qco4 : OUT std_logic;
	Qco5 : OUT std_logic;
	Qco6 : OUT std_logic;
	Qco7 : OUT std_logic;
	Dsg0 : IN std_logic;
	Dsg1 : IN std_logic;
	Dsg2 : IN std_logic;
	Dsg3 : IN std_logic;
	Dsg4 : IN std_logic;
	Dsg5 : IN std_logic;
	Dsg6 : IN std_logic;
	Dsg7 : IN std_logic;
	Total0 : OUT std_logic;
	Total1 : OUT std_logic;
	Total2 : OUT std_logic;
	Total3 : OUT std_logic;
	Total4 : OUT std_logic;
	Total5 : OUT std_logic;
	Total6 : OUT std_logic;
	Total7 : OUT std_logic;
	Total8 : OUT std_logic;
	Total9 : OUT std_logic;
	Clk : IN std_logic;
	nCt0 : OUT std_logic;
	nCt1 : OUT std_logic;
	nCt2 : OUT std_logic;
	nCt3 : OUT std_logic;
	Qsg0 : OUT std_logic;
	Qsg1 : OUT std_logic;
	Qsg2 : OUT std_logic;
	Qsg3 : OUT std_logic;
	Qsg4 : OUT std_logic;
	Qsg5 : OUT std_logic;
	Qsg6 : OUT std_logic;
	Qsg7 : OUT std_logic;
	Dco0 : IN std_logic;
	Dco1 : IN std_logic;
	Dco2 : IN std_logic;
	Dco3 : IN std_logic;
	Dco4 : IN std_logic;
	Dco5 : IN std_logic;
	Dco6 : IN std_logic;
	Dco7 : IN std_logic
); 
END component;

signal Ct_tb, nCt_tb : std_logic_vector(3 downto 0);
signal SigOut_tb, Dco_tb, Coeff_tb : std_logic_vector(7 downto 0);
signal Clk_tb, nRST_tb : std_logic := '0';
signal Load_tb : std_logic;
signal Total_tb : std_logic_vector(15 downto 0);

begin

-- 1kHz sine wave 8-bit representation
Data(0) <= CONV_UNSIGNED(0,8);
Data(1) <= CONV_UNSIGNED(3,8);
Data(2) <= CONV_UNSIGNED(10,8);
Data(3) <= CONV_UNSIGNED(18,8);
Data(4) <= CONV_UNSIGNED(30,8);
Data(5) <= CONV_UNSIGNED(44,8);
Data(6) <= CONV_UNSIGNED(60,8);
Data(7) <= CONV_UNSIGNED(77,8);
Data(8) <= CONV_UNSIGNED(96,8);
Data(9) <= CONV_UNSIGNED(116,8);
Data(10) <= CONV_UNSIGNED(135,8);
Data(11) <= CONV_UNSIGNED(155,8);
Data(12) <= CONV_UNSIGNED(174,8);
Data(13) <= CONV_UNSIGNED(191,8);
Data(14) <= CONV_UNSIGNED(207,8);
Data(15) <= CONV_UNSIGNED(221,8);
Data(16) <= CONV_UNSIGNED(232,8);
Data(17) <= CONV_UNSIGNED(241,8);
Data(18) <= CONV_UNSIGNED(248,8);
Data(19) <= CONV_UNSIGNED(251,8);
Data(20) <= CONV_UNSIGNED(248,8);
Data(21) <= CONV_UNSIGNED(241,8);
Data(22) <= CONV_UNSIGNED(232,8);
Data(23) <= CONV_UNSIGNED(221,8);
Data(24) <= CONV_UNSIGNED(207,8);
Data(25) <= CONV_UNSIGNED(191,8);
Data(26) <= CONV_UNSIGNED(174,8);
Data(27) <= CONV_UNSIGNED(155,8);
Data(28) <= CONV_UNSIGNED(135,8);
Data(29) <= CONV_UNSIGNED(116,8);
Data(30) <= CONV_UNSIGNED(96,8);
Data(31) <= CONV_UNSIGNED(77,8);
Data(32) <= CONV_UNSIGNED(60,8);
Data(33) <= CONV_UNSIGNED(44,8);
Data(34) <= CONV_UNSIGNED(30,8);
Data(35) <= CONV_UNSIGNED(18,8);
Data(36) <= CONV_UNSIGNED(10,8);
Data(37) <= CONV_UNSIGNED(3,8);
Data(38) <= CONV_UNSIGNED(0,8);

NewData(0) <= CONV_UNSIGNED(10,8);
NewData(1) <= CONV_UNSIGNED(174,8);
NewData(2) <= CONV_UNSIGNED(232,8);
NewData(3) <= CONV_UNSIGNED(60,8);


-- 1kHz sine wave, sampled at 40kHz
process is
begin
--  for i in 0 to 38 loop
  for i in 0 to 3 loop
    if(i = 0) then
        Sine <= "00001010";
    else
        --Sine <= Data(i);
        Sine <= NewData(i);
    end if;
    wait for 250 us;
  end loop;
end process;

SineToFIR <= std_logic_vector(Sine);

FIR : FinalBalancedFIR
PORT MAP( 
	Load => Load_tb,
	Ct0 => Ct_tb(0),
	Ct1 => Ct_tb(1),
	nRST => nRST_tb,
	Ct2 => Ct_tb(2),
	Ct3 => Ct_tb(3),
	Total10 => Total_tb(10),
	Total11 => Total_tb(11),
	Total12 => Total_tb(12),
	Total13 => Total_tb(13),
	Total14 => Total_tb(14),
	Total15 => Total_tb(15),
	Qco0 => Coeff_tb(0),
	Qco1 => Coeff_tb(1),
	Qco2 => Coeff_tb(2),
	Qco3 => Coeff_tb(3),
	Qco4 => Coeff_tb(4),
	Qco5 => Coeff_tb(5),
	Qco6 => Coeff_tb(6),
	Qco7 => Coeff_tb(7),
	Dsg0 => SineToFIR(0),
	Dsg1 => SineToFIR(1),
	Dsg2 => SineToFIR(2),
	Dsg3 => SineToFIR(3),
	Dsg4 => SineToFIR(4),
	Dsg5 => SineToFIR(5),
	Dsg6 => SineToFIR(6),
	Dsg7 => SineToFIR(7),
	Total0 => Total_tb(0),
	Total1 => Total_tb(1),
	Total2 => Total_tb(2),
	Total3 => Total_tb(3),
	Total4 => Total_tb(4),
	Total5 => Total_tb(5),
	Total6 => Total_tb(6),
	Total7 => Total_tb(7),
	Total8 => Total_tb(8),
	Total9 => Total_tb(9),
	Clk => Clk_tb,
	nCt0 => nCt_tb(0),
	nCt1 => nCt_tb(1),
	nCt2 => nCt_tb(2),
	nCt3 => nCt_tb(3),
	Qsg0 => SigOut_tb(0),
	Qsg1 => SigOut_tb(1),
	Qsg2 => SigOut_tb(2),
	Qsg3 => SigOut_tb(3),
	Qsg4 => SigOut_tb(4),
	Qsg5 => SigOut_tb(5),
	Qsg6 => SigOut_tb(6),
	Qsg7 => SigOut_tb(7),
	Dco0 => Dco_tb(0),
	Dco1 => Dco_tb(1),
	Dco2 => Dco_tb(2),
	Dco3 => Dco_tb(3),
	Dco4 => Dco_tb(4),
	Dco5 => Dco_tb(5),
	Dco6 => Dco_tb(6),
	Dco7 => Dco_tb(7)
); 

nRST_tb <= '1' after 210 ns;
Clk_tb <= not Clk_tb after 125 us;
Load_tb <= '0', '1' after 310 ns, '0' after 410 ns, -- one load
						'1' after 510 ns, '0' after 610 ns,
						'1' after 710 ns, '0' after 810 ns, -- three loads
						'1' after 910 ns, '0' after 1010 ns,
						'1' after 1110 ns, '0' after 1210 ns, -- five loads
						'1' after 1310 ns, '0' after 1410 ns,
						'1' after 1510 ns, '0' after 1610 ns, -- seven loads
						'1' after 1710 ns, '0' after 1810 ns,
						'1' after 1910 ns, '0' after 2010 ns, -- nine loads
						'1' after 2110 ns, '0' after 2210 ns,
						'1' after 2310 ns, '0' after 2410 ns, -- eleven loads
						'1' after 2510 ns, '0' after 2610 ns,
						'1' after 2710 ns, '0' after 2810 ns, -- thirteen loads
						'1' after 2910 ns, '0' after 3010 ns,
						'1' after 3110 ns, '0' after 3210 ns; -- fifteen loads
-- PROPER COEFFICIENTS
Dco_tb(7 downto 0) <= "10000110", "00000000" after 500 ns, "00001000" after 700 ns, "00000000" after 900 ns,
"10001110" after 1100 ns, "00000000" after 1300 ns, "00101001" after 1500 ns, "01000000" after 1700 ns, "00101001" after 1900 ns,
"00000000" after 2100 ns, "10001110" after 2300 ns, "00000000" after 2500 ns, "00001000" after 2700 ns,
"00000000" after 2900 ns, "10000110" after 3100 ns;



end architecture;