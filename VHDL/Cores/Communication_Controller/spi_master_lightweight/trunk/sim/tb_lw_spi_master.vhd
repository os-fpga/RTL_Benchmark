LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_lw_spi_master IS
END tb_lw_spi_master;
 
ARCHITECTURE behavior OF tb_lw_spi_master IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lw_spi_master
    PORT(
         clk_i : IN  std_logic;
         en_i : IN  std_logic;
         mosi_data_i : IN  std_logic_vector(7 downto 0);
         miso_data_o : OUT  std_logic_vector(7 downto 0);
         data_ready_o : OUT  std_logic;
         cs_o : OUT  std_logic;
         sclk_o : OUT  std_logic;
         mosi_o : OUT  std_logic;
         miso_i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal en_i : std_logic := '0';
   signal mosi_data_i : std_logic_vector(7 downto 0) := (others => '0');
   signal miso_i : std_logic := '0';

 	--Outputs
   signal miso_data_o : std_logic_vector(7 downto 0);
   signal data_ready_o : std_logic;
   signal cs_o : std_logic;
   signal sclk_o : std_logic;
   signal mosi_o : std_logic;

   -- Clock period definitions
-- Clock period definitions
constant clk_i_period 	: time := 20 ns;
constant sckPeriod 		: time := 200 ns;

signal SPISIGNAL : std_logic_vector(7 downto 0) := (others => '0');
signal spiWrite : std_logic := '0';
signal spiWriteDone : std_logic := '0';   
 
BEGIN


 
-- Instantiate the Unit Under Test (UUT)
uut: lw_spi_master PORT MAP (
clk_i => clk_i,
en_i => en_i,
mosi_data_i => mosi_data_i,
miso_data_o => miso_data_o,
data_ready_o => data_ready_o,
cs_o => cs_o,
sclk_o => sclk_o,
mosi_o => mosi_o,
miso_i => miso_i
);

-- Clock process definitions
clk_i_process :process
begin
	clk_i <= '0';
	wait for clk_i_period/2;
	clk_i <= '1';
	wait for clk_i_period/2;
end process;

SPIWRITE_P : process begin

	wait until rising_edge(spiWrite);

	-- for cpol = 1 cpha = 1
	-- for cpol = 0 cpha = 0
	
	miso_i <= SPISIGNAL(7);
	wait until falling_edge(sclk_o);
	miso_i <= SPISIGNAL(6);
	wait until falling_edge(sclk_o);
	miso_i <= SPISIGNAL(5);
	wait until falling_edge(sclk_o);
	miso_i <= SPISIGNAL(4);
	wait until falling_edge(sclk_o);
	miso_i <= SPISIGNAL(3);
	wait until falling_edge(sclk_o);
	miso_i <= SPISIGNAL(2);
	wait until falling_edge(sclk_o);
	miso_i <= SPISIGNAL(1);
	wait until falling_edge(sclk_o);
	miso_i <= SPISIGNAL(0);
	
	-- for cpol = 0 cpha = 1
	-- for cpol = 1 cpha = 0
	
	-- miso_i <= SPISIGNAL(7);
	-- wait until rising_edge(sclk_o);
	-- miso_i <= SPISIGNAL(6);
	-- wait until rising_edge(sclk_o);
	-- miso_i <= SPISIGNAL(5);
	-- wait until rising_edge(sclk_o);
	-- miso_i <= SPISIGNAL(4);
	-- wait until rising_edge(sclk_o);
	-- miso_i <= SPISIGNAL(3);
	-- wait until rising_edge(sclk_o);
	-- miso_i <= SPISIGNAL(2);
	-- wait until rising_edge(sclk_o);
	-- miso_i <= SPISIGNAL(1);
	-- wait until rising_edge(sclk_o);
	-- miso_i <= SPISIGNAL(0);	

	spiWriteDone    <= '1';
	wait for 1 ps;
	spiWriteDone    <= '0';

end process;
 

-- Stimulus process
stim_proc: process
begin		
  -- hold reset state for 100 ns.
  wait for 100 ns;	

  wait for clk_i_period*10;

  -- insert stimulus here 
	
----------------------------------------------------------------
--	-- CPOL,CPHA = 00
	en_i 		<= '1';  
	
	-- write 0xA7, read 0xB2
	mosi_data_i	<= x"A7";
	wait until falling_edge(cs_o);
	SPISIGNAL <= x"B2";
	spiWrite    <= '1';
	wait until rising_edge(spiWriteDone);
	spiWrite    <= '0';
	
	-- write 0xB8, read 0xC3
	wait until rising_edge(data_ready_o);
	mosi_data_i	<= x"B8";	
	wait until falling_edge(data_ready_o);
	SPISIGNAL <= x"C3";
	spiWrite    <= '1';
	wait until rising_edge(spiWriteDone);
	spiWrite    <= '0';
	en_i 		<= '0';  

----------------------------------------------------------------
--	-- CPOL,CPHA = 10
--	en_i 		<= '1';  
--	
--	-- write 0xA7, read 0xB2
--	mosi_data_i	<= x"A7";
--	wait until falling_edge(cs_o);
--	wait for 50 ns;
--	SPISIGNAL <= x"B2";
--	spiWrite    <= '1';
--	wait until rising_edge(spiWriteDone);
--	spiWrite    <= '0';
--	
--	-- write 0xB8, read 0xC3
--	wait until rising_edge(data_ready_o);
--	mosi_data_i	<= x"B8";	
--	wait until falling_edge(data_ready_o);
--	SPISIGNAL <= x"C3";
--	spiWrite    <= '1';
--	wait until rising_edge(spiWriteDone);
--	spiWrite    <= '0';
--	en_i 		<= '0'; 

----------------------------------------------------------------
	-- CPOL,CPHA = 01
--	en_i 		<= '1';  
--	
--	-- write 0xA7, read 0xB2
--	mosi_data_i	<= x"A7";
--	wait until falling_edge(cs_o);
--	wait until rising_edge(sclk_o);
--	SPISIGNAL <= x"B2";
--	spiWrite    <= '1';
--	wait until rising_edge(spiWriteDone);
--	spiWrite    <= '0';
--	
--	-- write 0xB8, read 0xC3
--	wait until rising_edge(data_ready_o);
--	mosi_data_i	<= x"B8";	
--	wait until rising_edge(sclk_o);
--	SPISIGNAL <= x"C3";
--	spiWrite    <= '1';
--	wait until rising_edge(spiWriteDone);
--	spiWrite    <= '0';
--	en_i 		<= '0'; 
	
----------------------------------------------------------------
--	-- CPOL,CPHA = 11
--	en_i 		<= '1';  
--	
--	-- write 0xA7, read 0xB2
--	mosi_data_i	<= x"A7";
--	wait until falling_edge(cs_o);
--	wait until falling_edge(sclk_o);
--	SPISIGNAL <= x"B2";
--	spiWrite    <= '1';
--	wait until rising_edge(spiWriteDone);
--	spiWrite    <= '0';
--	
--	-- write 0xB8, read 0xC3
--	wait until rising_edge(data_ready_o);
--	mosi_data_i	<= x"B8";	
--	wait until falling_edge(sclk_o);
--	SPISIGNAL <= x"C3";
--	spiWrite    <= '1';
--	wait until rising_edge(spiWriteDone);
--	spiWrite    <= '0';
--	en_i 		<= '0'; 	


	
	wait for 1 us;
	
	assert false
	report "SIM DONE"
	severity failure;
end process;

END;
