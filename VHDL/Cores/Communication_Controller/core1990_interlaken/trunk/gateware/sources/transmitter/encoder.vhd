library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Encoder is
    port(
        Clk          : in std_logic;                     -- Clock input
        Data_In      : in std_logic_vector(63 downto 0); -- Data input
        Data_Out     : out std_logic_vector(66 downto 0);-- Encoded 67-bit output
        
        Data_Control : in std_logic;                     -- Determines whether the word is data or control
        Data_valid_in: in std_logic;
        Data_valid_out: out std_logic;
        
        Encoder_En   : in std_logic;                     -- Enables the encoder
        Encoder_Rst  : in std_logic;                     -- Resets the encoder
        
        --Offset       : out std_logic_vector(7 downto 0); -- Debug to see the average values of ones and zeros
        Gearboxready : in std_logic
    );
end Encoder;

architecture Encoding of Encoder is
begin

    output : process (clk, Encoder_Rst)
        variable Data_Temp : std_logic_vector(66 downto 0) := (others => '0');
		variable Disparity_Data : integer := 0; -- Disparity of 64 bit data. Inversion bit has to be added at the end.
        variable Offset_V : integer := 32;
        variable Disparity_Running : integer;
	begin
        if (Encoder_Rst = '1') then
            Data_Out    <= (others => '0');
            Data_Temp   := (others => '0');
            --Offset      <= (others => '0');
        elsif (rising_edge(clk)) then 
            if (encoder_en = '1' and Gearboxready = '1') then
                Data_Temp(63 downto 0) := Data_In;
                
                Disparity_Data := 0;  -- Calculating disparity of incoming data
                for i in 63 downto 0 loop
                    if Data_In(i) = '1' then
                        Disparity_Data := Disparity_Data + 1;
                    end if;
                end loop;
                
                Data_Temp(66) := '0'; -- Determine inversion
                if(Disparity_Running >= 32) then
                    if (Disparity_Data >= 32) then
                        Data_Temp(63 downto 0) := not(Data_Temp(63 downto 0));
                        Data_Temp(66) := '1';
                    end if;
                else
                    if (Disparity_Data < 32) then
                        Data_Temp(63 downto 0) := not(Data_Temp(63 downto 0));
                        Data_Temp(66) := '1';
                    end if;
                end if;
                
                if(Data_Control = '1') then   -- Select word type
                    Data_Temp(65 downto 64) := "10"; -- Control word
                else
                    Data_Temp(65 downto 64) := "01"; -- Data word
                end if;
                
                --------------------------------------------
--                Offset_V := 32;       -- Debug to see average transmitted disparity
--                for j in 63 downto 0 loop
--                    if (Data_Temp(j) = '1') then
--                        Offset_V := Offset_V + 1;
--                    else
--                        Offset_V := Offset_V - 1;
--                    end if;
--                end loop;
--                Offset <= std_logic_vector(to_unsigned(Offset_V, Offset'length));
                --------------------------------------------
                
                Disparity_Running := 0; -- Measure disparity in transmitted word
                for j in 63 downto 0 loop
                    if (Data_Temp(j) = '1') then
                        Disparity_Running := Disparity_Running + 1;
                    end if;
                end loop;
                
                Data_Out <= Data_Temp;
            	Data_valid_out <= Data_valid_in;	 
            end if;
        end if;
    end process output;
	
end architecture Encoding;
