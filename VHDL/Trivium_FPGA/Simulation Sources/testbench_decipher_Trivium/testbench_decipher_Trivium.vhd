library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_decipher_Trivium is
    -- Port();
end testbench_decipher_Trivium;

architecture Behavioral of testbench_decipher_Trivium is

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
    
    signal klok        : std_logic := '0';
    signal initialize1 : std_logic := '0';
    signal initialize2 : std_logic := '0';
    signal o_text      : std_logic := '1';
    
    signal K  : std_logic_vector(79 downto 0) := (others => '0'); 
    signal IV : std_logic_vector(79 downto 0) := (others => '0'); 
    
    signal result_encipher : std_logic;
    signal result_decipher : std_logic;

begin

    Trivium_Module_encipher : Trivium_Module port map(result_encipher, klok, initialize1, K, IV, o_text);
     
    Trivium_Module_decipher : Trivium_Module port map(result_decipher, klok, initialize2, K, IV, result_encipher);
    
    klok <= not klok after 20 ns;
    o_text <= not o_text after 40 ns;
    initialize2 <= '1' when initialize1 = '1' and rising_edge(klok);
    
    test : process
    begin
        initialize1 <= '1';
        wait for 40 ns;
        initialize1 <= '0';
        wait;
    end process test;

end Behavioral;