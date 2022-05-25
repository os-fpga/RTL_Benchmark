--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:40:33 12/03/2012
-- Design Name:   
-- Module Name:   R:/CONCERTO/LP/IP Communication/test_spi.vhd
-- Project Name:  fpga_mio10s
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: if_spi
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_spi IS
END test_spi;
 
ARCHITECTURE behavior OF test_spi IS 
 CONSTANT adreg_loadfpga: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(124, 7);
   CONSTANT adreg_spinbr: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(125, 7);
   CONSTANT adreg_spictl: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(126, 7);
   CONSTANT adreg_spidat: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(127, 7);
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT if_spi
       GENERIC (
      div_rate : INTEGER := 2;      -- Diviseur d'horloge système pour obtenir le débit SPI = 2^div_rate
      spiclk_freq : INTEGER := 12
      );
    PORT(
         clk_sys : IN  std_logic;
         rst_n : IN  std_logic;
         spi_csn : OUT  std_logic;
         spi_wpn : OUT  std_logic;
         spi_sdo : OUT  std_logic;
         spi_sdi : IN  std_logic;
         spi_clk : OUT  std_logic;
         tx_dat : IN  std_logic_vector(7 downto 0);
         tx_val : IN  std_logic;
         rx_dat : OUT  std_logic_vector(7 downto 0);
         rx_val : OUT  std_logic;
         rx_next : IN  std_logic;
         type_com : IN  std_logic;
         exec_com : IN  std_logic;
         spi_busy : OUT  std_logic;
         nb_read : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   COMPONENT m25p80
   PORT (
      c : IN std_logic;
      data_in : IN std_logic;
      s : IN std_logic;
      w : IN std_logic;
      hold : IN std_logic;
      data_out : OUT std_logic
      );
   END COMPONENT;

   --Inputs
   signal clk_sys : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal spi_sdi : std_logic := '0';
   signal tx_dat : std_logic_vector(7 downto 0) := (others => '0');
   signal tx_val : std_logic := '0';
   signal rx_next : std_logic := '0';
   signal type_com : std_logic := '0';
   signal exec_com : std_logic := '0';
   signal nb_read : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal spi_csn : std_logic;
   signal spi_wpn : std_logic;
   signal spi_sdo : std_logic;
   signal spi_clk : std_logic;
   signal rx_dat : std_logic_vector(7 downto 0);
   signal rx_val : std_logic;
   signal spi_busy : std_logic;

   -- Clock period definitions
   constant clk_sys_period : time := 22 ns;
 
BEGIN
   rst_n <= '0', '1' after 10 ns;
	-- Instantiate the Unit Under Test (UUT)
   uut: if_spi 
      GENERIC MAP (
         div_rate => 2,
         spiclk_freq => 12)
      PORT MAP (
      
          clk_sys => clk_sys,
          rst_n => rst_n,
          spi_csn => spi_csn,
          spi_wpn => spi_wpn,
          spi_sdo => spi_sdo,
          spi_sdi => spi_sdi,
          spi_clk => spi_clk,
          tx_dat => tx_dat,
          tx_val => tx_val,
          rx_dat => rx_dat,
          rx_val => rx_val,
          rx_next => rx_next,
          type_com => type_com,
          exec_com => exec_com,
          spi_busy => spi_busy,
          nb_read => nb_read
        );

   instflash : m25p80
   PORT MAP(
      c => spi_clk,
      data_in => spi_sdo,
      s => spi_csn,
      w => spi_wpn,
      hold => '1',
      data_out => spi_sdi
      );

   -- Clock process definitions
   clk_sys_process :process
   begin
		clk_sys <= '0';
		wait for clk_sys_period/2;
		clk_sys <= '1';
		wait for clk_sys_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
      -- Commande 06h (WREN)
      wait until rising_edge(clk_sys);
      tx_dat <= x"06";
      tx_val <= '1';
      wait until rising_edge(clk_sys);
      tx_val <= '0';
      wait until rising_edge(clk_sys);
      wait until rising_edge(clk_sys);
      wait until rising_edge(clk_sys);
      type_com <= '0';
      exec_com <= '1';
      wait until spi_busy = '0';

      -- Commande D8h (SE)
      wait until rising_edge(clk_sys);
      tx_dat <= x"D8";
      nb_read <= x"14";
      tx_val <= '1';
      wait until rising_edge(clk_sys);
      tx_dat <= x"01";
      wait until rising_edge(clk_sys);
      tx_dat <= x"02";
      wait until rising_edge(clk_sys);
      tx_dat <= x"03";
      wait until rising_edge(clk_sys);
      tx_val <= '0';
      wait until rising_edge(clk_sys);
      wait until rising_edge(clk_sys);
      wait until rising_edge(clk_sys);
      type_com <= '0';
      exec_com <= '1';
      wait until spi_busy = '0';

      -- Commande 06h (WREN)
      wait until rising_edge(clk_sys);
      tx_dat <= x"06";
      tx_val <= '1';
      wait until rising_edge(clk_sys);
      tx_val <= '0';
      wait until rising_edge(clk_sys);
      wait until rising_edge(clk_sys);
      wait until rising_edge(clk_sys);
      type_com <= '0';
      exec_com <= '1';
      wait until spi_busy = '0';

      -- Commande PP
      wait until rising_edge(clk_sys);
      tx_dat <= x"02";
      tx_val <= '1';
      wait until rising_edge(clk_sys);
      tx_dat <= x"01";
      wait until rising_edge(clk_sys);
      tx_dat <= x"02";
      wait until rising_edge(clk_sys);
      tx_dat <= x"03";
      FOR i IN 0 TO 124 LOOP
         wait until rising_edge(clk_sys);
         tx_dat <= conv_std_logic_vector(i, 8);
      END LOOP;
      wait until rising_edge(clk_sys);
      tx_val <= '0';
      wait until rising_edge(clk_sys);
      wait until rising_edge(clk_sys);
      wait until rising_edge(clk_sys);
      type_com <= '0';
      exec_com <= '1';
      wait until spi_busy = '0';
      wait;
   end process;

END;
