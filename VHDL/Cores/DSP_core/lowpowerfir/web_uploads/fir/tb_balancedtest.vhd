LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_balancedtest is
end entity;



architecture behavioural of tb_balancedtest is

COMPONENT FinalBalancedFIR IS PORT (
	Load : IN std_logic;
	nRST : IN std_logic;
	Ct0 : OUT std_logic;
	Ct1 : OUT std_logic;
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
	nCt0 : OUT std_logic;
	nCt1 : OUT std_logic;
	nCt2 : OUT std_logic;
	nCt3 : OUT std_logic;
	Clk : IN std_logic;
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



signal Dsg_tb, Dco_tb, Qsg_tb, Qco_tb : std_logic_vector(7 downto 0);
--signal Szero_tb, Sone_tb : std_logic_vector(15 downto 0);
--signal Input : std_logic := '1';
signal Clk_tb, nRST_tb : std_logic := '0';
signal Load_tb : std_logic;
signal Total_tb : std_logic_vector(15 downto 0);
signal Count_tb, nCount_tb : std_logic_vector(3 downto 0);


begin

CFTO : FinalBalancedFIR PORT MAP(
	Load => Load_tb,
	nRST => nRST_tb,
	Clk => Clk_tb,
--	Signed0 => Signed0_tb,
--	Signed1 => Signed1_tb,
--	Enable => Enable_tb,
	Ct0 => Count_tb(0),
	Ct1 => Count_tb(1),
	Ct2 => Count_tb(2),
	Ct3 => Count_tb(3),
	nCt0 => nCount_tb(0),
	nCt1 => nCount_tb(1),
	nCt2 => nCount_tb(2),
	nCt3 => nCount_tb(3),
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
	Total10 => Total_tb(10),
	Total11 => Total_tb(11),
	Total12 => Total_tb(12),
	Total13 => Total_tb(13),
	Total14 => Total_tb(14),
	Total15 => Total_tb(15),
	Qco0 => Qco_tb(0),
	Qco1 => Qco_tb(1),
	Qco2 => Qco_tb(2),
	Qco3 => Qco_tb(3),
	Qco4 => Qco_tb(4),
	Qco5 => Qco_tb(5),
	Qco6 => Qco_tb(6),
	Qco7 => Qco_tb(7),
	Dsg0 => Dsg_tb(0),
	Dsg1 => Dsg_tb(1),
	Dsg2 => Dsg_tb(2),
	Dsg3 => Dsg_tb(3),
	Dsg4 => Dsg_tb(4),
	Dsg5 => Dsg_tb(5),
	Dsg6 => Dsg_tb(6),
	Dsg7 => Dsg_tb(7),
	Qsg0 => Qsg_tb(0),
	Qsg1 => Qsg_tb(1),
	Qsg2 => Qsg_tb(2),
	Qsg3 => Qsg_tb(3),
	Qsg4 => Qsg_tb(4),
	Qsg5 => Qsg_tb(5),
	Qsg6 => Qsg_tb(6),
	Qsg7 => Qsg_tb(7),
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
Clk_tb <= not Clk_tb after 1750 ns;

--Dsg_tb(7 downto 0) <= "00000000", "00000001" after 3375 ns, "00000010" after 6375 ns, "00000011" after 7875 ns,
--								"00000100" after 9375 ns, "00000101" after 10875 ns;

Dsg_tb(7 downto 0) <= "00000000", "00000001" after 11260 ns, "00000000" after 13880 ns;

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
--, '1' after 710 ns, '0' after 810 ns;



-- Coefficients, 1 and 2, expected output 0,2,3,5,8,11,14,15....
--Dco_tb(7 downto 0) <= "00000001", "00000010" after 500 ns;--, "00000100" after 700 ns;

-- Coefficients -1 and 2, expected output 0,2,1,3,4,5,6,5...
--Dco_tb(7 downto 0) <= "10000001", "00000010" after 500 ns;

-- PROPER COEFFICIENTS
Dco_tb(7 downto 0) <= "10000101", "00000000" after 500 ns, "00001001" after 700 ns, "00000000" after 900 ns,
"10001101" after 1100 ns, "00000000" after 1300 ns, "00101001" after 1500 ns, "01000001" after 1700 ns, "00101001" after 1900 ns,
"00000000" after 2100 ns, "10001101" after 2300 ns, "00000000" after 2500 ns, "00001001" after 2700 ns,
"00000000" after 2900 ns, "10000101" after 3100 ns;

-- TEST COEFFICIENTS
--Dco_tb(7 downto 0) <= "00000001", "00000010" after 500 ns, "00000011" after 700 ns, "00000100" after 900 ns,
--"00000101" after 1100 ns, "00000110" after 1300 ns, "00000111" after 1500 ns, "00001000" after 1700 ns, "00001001" after 1900 ns,
--"00001010" after 2100 ns, "00001011" after 2300 ns, "00001100" after 2500 ns, "00001101" after 2700 ns,
--"00001110" after 2900 ns, "00001111" after 3100 ns;


--Enable_tb <= '1'; -- Enable whole circuit

--if (Signed0_tb = '0' and Signed1_tb = '0') then
--	Total <= signed(Szero_tb(15 downto 0)) + signed(Sone_tb(15 downto 0));
--elsif (Signed0_tb = '1' and Signed1_tb = '1') then
--	Total <= signed(Szero_tb(15 downto 0)) + signed(Sone_tb(15 downto 0)) + 2;
--else
--	Total <= signed(Szero_tb(15 downto 0)) + signed(Sone_tb(15 downto 0))+ 1;
--end if

--Total		<= signed(Szero_tb(15 downto 0)) + signed(Sone_tb(15 downto 0)) when (Signed0_tb = '0' and Signed1_tb = '0') else
--					signed(Szero_tb(15 downto 0)) + signed(Sone_tb(15 downto 0)) + 2 when (Signed0_tb = '1' and Signed1_tb = '1') else
--					signed(Szero_tb(15 downto 0)) + signed(Sone_tb(15 downto 0)) + 1;

end architecture behavioural;

