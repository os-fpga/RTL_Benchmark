library ieee; 
use ieee.std_logic_1164.all;

entity Scrambler is 
	port ( 
		Clk				: in std_logic;			              -- System clock
		Scram_Rst		: in std_logic;			              -- Scrambler reset, use for initialization
		
		Data_In 		: in std_logic_vector (63 downto 0);  -- Data input
		Data_Out 		: out std_logic_vector (63 downto 0); -- Data output
		
		Lane_Number		: in std_logic_vector (3 downto 0);   -- Each lane number starts with different scrambler word  
		Scrambler_En	: in std_logic; 					  -- Input valid
		Data_Control_In : in std_logic;                       -- Indicates a control word
		Data_Control_Out: out std_logic;                      -- Output control word indication
		
		Data_Valid_In   : in std_logic;                       -- Input valid
        Data_Valid_Out	: out std_logic;    				  -- Output valid
        Gearboxready    : in std_logic
	);
end Scrambler;

architecture Scrambling of Scrambler is 
	signal Poly : std_logic_vector (57 downto 0);
	signal Shiftreg : std_logic_vector (63 downto 0);	
begin
	shiftreg(63) <= Poly(57) xor Poly(38);
    shiftreg(62) <= Poly(56) xor Poly(37);
    shiftreg(61) <= Poly(55) xor Poly(36);
    shiftreg(60) <= Poly(54) xor Poly(35);
    shiftreg(59) <= Poly(53) xor Poly(34);
    shiftreg(58) <= Poly(52) xor Poly(33);
    shiftreg(57) <= Poly(51) xor Poly(32);
    shiftreg(56) <= Poly(50) xor Poly(31);
    shiftreg(55) <= Poly(49) xor Poly(30);
    shiftreg(54) <= Poly(48) xor Poly(29);
    shiftreg(53) <= Poly(47) xor Poly(28);
    shiftreg(52) <= Poly(46) xor Poly(27);
    shiftreg(51) <= Poly(45) xor Poly(26);
    shiftreg(50) <= Poly(44) xor Poly(25);
    shiftreg(49) <= Poly(43) xor Poly(24);
    shiftreg(48) <= Poly(42) xor Poly(23);
    shiftreg(47) <= Poly(41) xor Poly(22);
    shiftreg(46) <= Poly(40) xor Poly(21);
    shiftreg(45) <= Poly(39) xor Poly(20);
    shiftreg(44) <= Poly(38) xor Poly(19);
    shiftreg(43) <= Poly(37) xor Poly(18);
    shiftreg(42) <= Poly(36) xor Poly(17);
    shiftreg(41) <= Poly(35) xor Poly(16);
    shiftreg(40) <= Poly(34) xor Poly(15);
    shiftreg(39) <= Poly(33) xor Poly(14);
    shiftreg(38) <= Poly(32) xor Poly(13);
    shiftreg(37) <= Poly(31) xor Poly(12);
    shiftreg(36) <= Poly(30) xor Poly(11);
    shiftreg(35) <= Poly(29) xor Poly(10);
    shiftreg(34) <= Poly(28) xor Poly(9);
    shiftreg(33) <= Poly(27) xor Poly(8);
    shiftreg(32) <= Poly(26) xor Poly(7);
    shiftreg(31) <= Poly(25) xor Poly(6);
    shiftreg(30) <= Poly(24) xor Poly(5);
    shiftreg(29) <= Poly(23) xor Poly(4);
    shiftreg(28) <= Poly(22) xor Poly(3);
    shiftreg(27) <= Poly(21) xor Poly(2);
    shiftreg(26) <= Poly(20) xor Poly(1);
    shiftreg(25) <= Poly(19) xor Poly(0);
    shiftreg(24) <= Poly(57) xor Poly(38) xor Poly(18);
    shiftreg(23) <= Poly(56) xor Poly(37) xor Poly(17);
    shiftreg(22) <= Poly(55) xor Poly(36) xor Poly(16);
    shiftreg(21) <= Poly(54) xor Poly(35) xor Poly(15);
    shiftreg(20) <= Poly(53) xor Poly(34) xor Poly(14);
    shiftreg(19) <= Poly(52) xor Poly(33) xor Poly(13);
    shiftreg(18) <= Poly(51) xor Poly(32) xor Poly(12);
    shiftreg(17) <= Poly(50) xor Poly(31) xor Poly(11);
    shiftreg(16) <= Poly(49) xor Poly(30) xor Poly(10);
    shiftreg(15) <= Poly(48) xor Poly(29) xor Poly(9);
    shiftreg(14) <= Poly(47) xor Poly(28) xor Poly(8);
    shiftreg(13) <= Poly(46) xor Poly(27) xor Poly(7);
    shiftreg(12) <= Poly(45) xor Poly(26) xor Poly(6);
    shiftreg(11) <= Poly(44) xor Poly(25) xor Poly(5);
    shiftreg(10) <= Poly(43) xor Poly(24) xor Poly(4);
    shiftreg(9) <= Poly(42) xor Poly(23) xor Poly(3);
    shiftreg(8) <= Poly(41) xor Poly(22) xor Poly(2);
    shiftreg(7) <= Poly(40) xor Poly(21) xor Poly(1);
    shiftreg(6) <= Poly(39) xor Poly(20) xor Poly(0);
    shiftreg(5) <= Poly(57) xor Poly(19);
    shiftreg(4) <= Poly(56) xor Poly(18);
    shiftreg(3) <= Poly(55) xor Poly(17);
    shiftreg(2) <= Poly(54) xor Poly(16);
    shiftreg(1) <= Poly(53) xor Poly(15);
    shiftreg(0) <= Poly(52) xor Poly(14);

	Scramble : process (Clk, Scram_Rst, Data_control_in, lane_number)
	begin
        if(Scram_Rst = '1') then
            Poly                <= (others => '1');
            Poly(57 downto 54)  <= Lane_Number(3 downto 0);
            Data_Out            <= (others => '0');
            Data_Control_Out    <= '0';
            Data_Valid_Out      <= '0';
		elsif (rising_edge(clk)) then
            if (Gearboxready = '1') then
                if (Data_Control_In = '1') then --Checks if incoming data is control word
                    if(Data_In(63 downto 58) = "011110") then       -- Sync words are not scrambled
                        Data_Out <= Data_In;
                    elsif (Data_In(63 downto 58) = "001010") then   -- Scrambler state words are not scrambled
                        Data_Out <= Data_In(63 downto 58) & Poly;
                    else
                        Poly <= shiftreg(57 downto 0);              -- All other control words are scrambled
                        Data_Out <= Data_In xor (Shiftreg(63 downto 58) & Poly(57 downto 0));
                    end if;
                    Data_Control_Out <= '1';    
                else
                    Poly <= shiftreg(57 downto 0);                  -- All data words are scrambled
                    Data_Out <= Data_In xor (Shiftreg(63 downto 58) & Poly(57 downto 0));
                    Data_Control_Out <= '0';    
                end if;
                
                Data_Valid_Out <= Data_Valid_In;
            end if;
        end if;
	end process;
	
end architecture Scrambling;
