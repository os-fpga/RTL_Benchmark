library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_Trivium_Module is
    -- Port();
end testbench_Trivium_Module;

architecture Behavioral of testbench_Trivium_Module is

    -------------------------------
    --------- COMPONENTS ----------
    -------------------------------
    
    component Trivium_Module
        Generic ( DATA_LENGTH : integer := 80 );
        Port ( cipher_text : out STD_LOGIC;
        
               clock : in STD_LOGIC;
               init  : in STD_LOGIC;
               
               K  : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);
               IV : in STD_LOGIC_VECTOR (DATA_LENGTH-1 downto 0);
               
               open_text : in STD_LOGIC
               );
    end component;
    
    -------------------------------
    ----------- SIGNALS -----------
    -------------------------------
    
    signal klok       : std_logic := '0';
    signal initialize : std_logic := '0';
    signal o_text     : std_logic := '1';
    
    signal K  : std_logic_vector(79 downto 0) := (others => '0'); 
    signal IV : std_logic_vector(79 downto 0) := (others => '0'); 
    
    signal result : std_logic;

begin

    UUT : Trivium_Module port map(result, klok, initialize, K, IV, o_text);
    
    klok <= not klok after 20 ns;
    o_text <= not o_text after 40 ns;
    
    test : process
    begin
        initialize <= '1';
        wait for 5 ns;
        initialize <= '0';
        wait;
    end process test;

end Behavioral;