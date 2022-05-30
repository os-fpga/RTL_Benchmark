--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:29:20 04/02/2014
-- Design Name:   
-- Module Name:   R:/CONCERTO SIL2/LP/FPGA Concentrateur SIL2/fpga_cosil2/top_fpgacosil2_tb.vhd
-- Project Name:  fpga_cosil2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_fpgacosil2
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_fpgacosil2_tb IS
END top_fpgacosil2_tb;
 
ARCHITECTURE behavior OF top_fpgacosil2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_fpgacosil2
    PORT(
      clk_24      : IN  STD_LOGIC;     -- Horloge principale à 24MHz
      clk_25      : IN  STD_LOGIC;     -- Horloge spare à 25MHz
      rst_n       : IN  STD_LOGIC;     -- Reset principal de la carte
      rst_fpgan   : IN  STD_LOGIC;     -- Reset issu du PIC32
      led_confok  : OUT STD_LOGIC;     -- Pilotage de la led rouge
      led_run     : OUT STD_LOGIC;     -- Pilotage de la 1ère LED verte
      led_fail    : OUT STD_LOGIC;     -- Pilotage de la 2ème LED verte
      power_rstn  : IN  STD_LOGIC;     -- Indique que l'alim 3.3V du PIC est coupée
      rst_switchn : OUT STD_LOGIC;     -- Gestion du reset du SWITCH
      interrupt   : IN  STD_LOGIC;     -- Signal d'interruption issu du SWITCH
      prog_b      : IN  STD_LOGIC;     -- Force la reprog du FPGA
   
      -- Interfaces ports séries
      ls485_de1   : OUT STD_LOGIC;     -- Signal d'autorisation à émettre de la LS1
      ls485_ren1  : OUT STD_LOGIC;     -- Signal d'autorisation à émettre de la LS1
      ls485_rx1   : IN  STD_LOGIC;     -- Signal de réception de la LS1
      ls485_tx1   : OUT STD_LOGIC;     -- Signal d'émission de la LS1

      ls485_de2   : OUT STD_LOGIC;     -- Signal d'autorisation à émettre de la LS2
      ls485_ren2  : OUT STD_LOGIC;     -- Signal d'autorisation à émettre de la LS2
      ls485_rx2   : IN  STD_LOGIC;     -- Signal de réception de la LS2
      ls485_tx2   : OUT STD_LOGIC;     -- Signal d'émission de la LS2

      -- Interface PMP (Interface PIC)
      pmd            : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Bus Data / Adresse
      pmall          : IN STD_LOGIC;   -- Latch des LSB de l'adresse
      pmalh          : IN STD_LOGIC;   -- Latch des MSB de l'adresse
      pmrd           : IN STD_LOGIC;   -- Signal de read
      pmwr           : IN STD_LOGIC;   -- Signal de write

      -- Interface de pilotage des Alim isolées
      cdehigh_5vid   : OUT STD_LOGIC;
      cdelow_5vid    : OUT STD_LOGIC;
      cdehigh_5vls1  : OUT STD_LOGIC;
      cdelow_5vls1   : OUT STD_LOGIC;
      cdehigh_5vls2  : OUT STD_LOGIC;
      cdelow_5vls2   : OUT STD_LOGIC;
      cdehigh_5vlsm2 : OUT STD_LOGIC;
      cdelow_5vlsm2  : OUT STD_LOGIC;
      cdehigh_5vcan  : OUT STD_LOGIC;
      cdelow_5vcan   : OUT STD_LOGIC;
          
      -- Interface PCIe
      pci_rstn    : IN  STD_LOGIC;
      pci_exp_txp : OUT STD_LOGIC;
      pci_exp_txn : OUT STD_LOGIC;
      pci_exp_rxp : IN  STD_LOGIC;
      pci_exp_rxn : IN  STD_LOGIC;
      pci_clk_p   : IN  STD_LOGIC;
      pci_clk_n   : IN  STD_LOGIC;
      pci_waken   : OUT STD_LOGIC;     
      pci_spare   : IN  STD_LOGIC;

      -- Interface Spare avec la passerelle
      uc_pmd      : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      uc_pmrd     : IN STD_LOGIC;
      uc_pmwr     : IN STD_LOGIC;
      uc_pmall    : IN STD_LOGIC;
      uc_pmalh    : IN STD_LOGIC;
      uc_pmacs1   : IN STD_LOGIC;
      uc_pmacs2   : IN STD_LOGIC;
      uc_sck      : IN STD_LOGIC;
      uc_ssn      : IN STD_LOGIC;
      uc_sdi      : IN STD_LOGIC;
      uc_sdo      : IN STD_LOGIC;
      
      -- Interface I2C
      sda         : IN STD_LOGIC;
      scl         : IN STD_LOGIC;
      
      -- Interface SPI (programmation de la flash de configuration)
      wp_flashn      : OUT STD_LOGIC;     -- Autorisation d'écriture dans la flash SPI
      cclk           : OUT STD_LOGIC;     -- Horloge d'accès à la flash SPI
      din_miso       : IN  STD_LOGIC;     -- Data série en lecture SPI
      mosi           : OUT STD_LOGIC;     -- Data série en écriture SPI
      cso_b          : OUT STD_LOGIC;     -- Chip select SPI
      
      -- Interface Spare avec le PIC
      pic_rx         : IN  STD_LOGIC;
      pic_tx         : OUT STD_LOGIC;
      pic_spare      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      pic_sck        : IN  STD_LOGIC;
      pic_sdi        : IN  STD_LOGIC;
      pic_sdo        : OUT STD_LOGIC;
      pic_ssn        : IN  STD_LOGIC;
      
      -- Spare
      tp             : OUT STD_LOGIC_VECTOR(28 DOWNTO 22);
      spare          : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_24 : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal rst_fpgan : std_logic := '0';
   signal power_rstn : std_logic := '0';
   signal ls485_rx1 : std_logic := '0';
   signal ls485_rx2 : std_logic := '0';
   signal pmall : std_logic := '0';
   signal pmalh : std_logic := '0';
   signal pmrd : std_logic := '0';
   signal pmwr : std_logic := '0';
   signal pci_rstn : std_logic := '0';
   signal pci_exp_rxp : std_logic := '0';
   signal pci_exp_rxn : std_logic := '0';
   signal pci_clk_p : std_logic := '1';
   signal pci_clk_n : std_logic := '0';
   signal din_miso : std_logic := '0';

	--BiDirs
   signal pmd : std_logic_vector(7 downto 0) := "ZZZZZZZZ";

 	--Outputs
   signal led_confok : std_logic;
   signal led_run : std_logic;
   signal led_fail : std_logic;
   signal ls485_de1 : std_logic;
   signal ls485_ren1 : std_logic;
   signal ls485_tx1 : std_logic;
   signal ls485_de2 : std_logic;
   signal ls485_ren2 : std_logic;
   signal ls485_tx2 : std_logic;
   signal cdehigh_5vid : std_logic;
   signal cdelow_5vid : std_logic;
   signal cdehigh_5vls1 : std_logic;
   signal cdelow_5vls1 : std_logic;
   signal cdehigh_5vls2 : std_logic;
   signal cdelow_5vls2 : std_logic;
   signal pci_exp_txp : std_logic;
   signal pci_exp_txn : std_logic;
   signal pci_waken : std_logic;
   signal wp_flashn : std_logic;
   signal cclk : std_logic;
   signal mosi : std_logic;
   signal cso_b : std_logic;

   -- Clock period definitions
   constant clk_24_period : time := 42 ns;
   constant pci_period : time := 10 ns;
 
BEGIN
   rst_n <= '0', '1' after 200 ns;
   clk_24 <= NOT(clk_24) after clk_24_period/2;
   pci_clk_p <= NOT(pci_clk_p) after pci_period/2;
   pci_clk_n <= NOT(pci_clk_n) after pci_period/2;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_fpgacosil2 PORT MAP (
          clk_24 => clk_24,
          rst_n => rst_n,
          rst_fpgan => rst_fpgan,
          led_confok => led_confok,
          led_run => led_run,
          led_fail => led_fail,
          power_rstn => power_rstn,
          ls485_de1 => ls485_de1,
          ls485_ren1 => ls485_ren1,
          ls485_rx1 => ls485_rx1,
          ls485_tx1 => ls485_tx1,
          ls485_de2 => ls485_de2,
          ls485_ren2 => ls485_ren2,
          ls485_rx2 => ls485_rx2,
          ls485_tx2 => ls485_tx2,
          pmd => pmd,
          pmall => pmall,
          pmalh => pmalh,
          pmrd => pmrd,
          pmwr => pmwr,
          cdehigh_5vid => cdehigh_5vid,
          cdelow_5vid => cdelow_5vid,
          cdehigh_5vls1 => cdehigh_5vls1,
          cdelow_5vls1 => cdelow_5vls1,
          cdehigh_5vls2 => cdehigh_5vls2,
          cdelow_5vls2 => cdelow_5vls2,
          pci_rstn => pci_rstn,
          pci_exp_txp => pci_exp_txp,
          pci_exp_txn => pci_exp_txn,
          pci_exp_rxp => pci_exp_rxp,
          pci_exp_rxn => pci_exp_rxn,
          pci_clk_p => pci_clk_p,
          pci_clk_n => pci_clk_n,
          pci_waken => pci_waken,
          pci_spare => '0',
          wp_flashn => wp_flashn,
          cclk => cclk,
          din_miso => din_miso,
          mosi => mosi,
          cso_b => cso_b,
          pic_spare => "0000",
          clk_25 => '0',
          interrupt => '0',
          prog_b => '0',
      --uc_pmd      => "00000000",
      uc_pmrd     => '0',
      uc_pmwr     => '0',
      uc_pmall    => '0',
      uc_pmalh    => '0',
      uc_pmacs1   => '0',
      uc_pmacs2   => '0',
      uc_sck      => '0',
      uc_ssn      => '0',
      uc_sdi      => '0',
      uc_sdo      => '0',
      sda         => '0',
      scl         => '0',
      pic_rx      => '0',
      pic_sck     => '0',
      pic_sdi     => '0',
      pic_ssn     => '0' 
        );


   pmd <= (others => 'Z');
   pmall <= '0';
   pmwr <= '0';
   pmrd <= not(pmrd) after 100 ns;

END;
