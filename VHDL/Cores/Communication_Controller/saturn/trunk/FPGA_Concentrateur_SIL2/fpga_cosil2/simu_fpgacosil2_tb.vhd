--============================================================================= 
--  TITRE : TOP_FPGACONC
--  DESCRIPTION : 
--        Module TOP du FPGA du COncentrateur		

--  FICHIER :        top_fpgaconc.vhd 
--=============================================================================
--  CREATION 
--  DATE	AUTEUR	PROJET	REVISION 
--  10/04/2012	DRA	CONCERTO	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	AUTEUR	PROJET	REVISION 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

LIBRARY work;
USE work.package_saturn.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.

ENTITY simu_fpgacosil2_tb IS
END simu_fpgacosil2_tb;

ARCHITECTURE rtl of simu_fpgacosil2_tb is
   -- signaux utilisés pour les fonctions systèmes
   SIGNAL clk_96         : STD_LOGIC:= '0';      -- Pour récupérer l'horloge CLKx2 à la sortie du DCM
   SIGNAL clk_pcie       : STD_LOGIC:= '0';      -- Horloge à 62.5 MHz issue de l'I/F PCIe
   SIGNAL rst96_n        : STD_LOGIC:= '0';      -- reset resynchronisé sur clk96
   SIGNAL rstpcie_n      : STD_LOGIC := '0';     -- Pour filtrer le reset entrant
   SIGNAL iid            : STD_LOGIC_VECTOR(63 DOWNTO 0) := x"0123456789ABCDEF";

   -- Signaux d'interface entre le module de comm et le module spi PIC
   SIGNAL tid         : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL cpy1        : STD_LOGIC;
   SIGNAL cpy2        : STD_LOGIC;
   SIGNAL repli       : STD_LOGIC;
   SIGNAL topcyc      : STD_LOGIC;
   SIGNAL l7_rx1      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL l7_soc1     : STD_LOGIC;
   SIGNAL l7_rd1      : STD_LOGIC;
   SIGNAL l7_comdispo1: STD_LOGIC;
   SIGNAL l7_newframe1: STD_LOGIC;
   SIGNAL l7_l2ok1    : STD_LOGIC;
   SIGNAL l7_overflow1: STD_LOGIC;
   SIGNAL l7_rx2      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL l7_soc2     : STD_LOGIC;
   SIGNAL l7_rd2      : STD_LOGIC;
   SIGNAL l7_comdispo2: STD_LOGIC;
   SIGNAL l7_newframe2: STD_LOGIC;
   SIGNAL l7_l2ok2    : STD_LOGIC;
   SIGNAL l7_overflow2: STD_LOGIC;
   SIGNAL tx_dat      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL val_txdat   : STD_LOGIC;
   SIGNAL tx_sof      : STD_LOGIC;
   SIGNAL tx_eof      : STD_LOGIC;
   SIGNAL txdat_free  : STD_LOGIC;
   SIGNAL clr_fifo_tx : STD_LOGIC;

   -- Signaux du bus local de l'interface PCIe
   SIGNAL rd_addr       : STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 downto 0); -- Bus d'@ en lecture
   SIGNAL rd_data       : STD_LOGIC_VECTOR(31 downto 0);                -- Données lues sur le bus local
   SIGNAL rd_be         : STD_LOGIC_VECTOR(3 downto 0);                 -- Byte Enable en lecture
   SIGNAL rd_en         : STD_LOGIC;                                    -- Signal d'ordre de lecture
   SIGNAL wr_addr       : STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 downto 0); -- Bus d'@ en écriture
   SIGNAL wr_data       : STD_LOGIC_VECTOR(31 downto 0);                -- Données à écrire sur le bus local
   SIGNAL wr_be         : STD_LOGIC_VECTOR(3 downto 0);                 -- Byte enable en écriture
   SIGNAL wr_en         : STD_LOGIC;                                    -- Signal d'ordre d'écriture
   SIGNAL wr_busy       : STD_LOGIC;                                    -- Indique que le bus local est occupé en écriture
   SIGNAL link_up_n     : STD_LOGIC;                                    -- Indique le lien PCIe est étali avec le host
   SIGNAL dma_req       : STD_LOGIC;                     -- Requête d'un DMA
   SIGNAL dma_add_dest  : STD_LOGIC_VECTOR(31 downto 0); -- Adresse de estination (coté PC) pour le DMA
   SIGNAL dma_compl     : STD_LOGIC;                     -- Indique le DMA est fini
   SIGNAL dma_read      : STD_LOGIC;                     -- Ordre de lecture pour fetcher une donnée supplémentaire à envoyer par DMA
   SIGNAL dma_ack       : STD_LOGIC;                     -- Indique que la demande de DMA est acceptée         
   SIGNAL dma_size      : STD_LOGIC_VECTOR(7 downto 0);  -- Nombre de mots de 32 bits à tansférer par DMA
   SIGNAL dma_data      : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Données à transmettre par DMA (fetchée par dma_read)
   SIGNAL dma_timestamp : STD_LOGIC_VECTOR(7 DOWNTO 0);
   
   -- Signaux de gestion du module memory_map
   SIGNAL rst_regn       : STD_LOGIC;                    -- Reset interne piloté par registre
   SIGNAL actif          : STD_LOGIC;                    -- Indique que le concentrateur est actif
   SIGNAL store_enable   : STD_LOGIC;                    -- Autorise le transfert DMA des trames incidentes
   SIGNAL rx_flushn      : STD_LOGIC;
   SIGNAL dma_inprogress : STD_LOGIC;                    -- A 1 tant que le module DMA est en cours de transfert
   SIGNAL update_ena     : STD_LOGIC;                    -- Autorise la mise à jour de la mémoire TX_PER
   SIGNAL baudrate       : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Code du baudrate de communication (entre 50Kbits et 12MBits)
   SIGNAL tx_ena_periodic: STD_LOGIC_VECTOR(31 DOWNTO 0);-- Autorisation à émettre d'une zone périodique
   SIGNAL tx_ena_aper    : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Autorisation à émettre d'une zone apériodique
   SIGNAL clr_txena_aper : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Ordre de remise à 0 d'une zone de transmission apériodique
   SIGNAL dma_base_pa    : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Adresse physique de base pour les DMA (coté PC)
   SIGNAL bufferrx1_full : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Indique les zones de stockages des trames Rx1 encore pleines
   SIGNAL bufferrx2_full : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Indique les zones de stockages des trames Rx2 encore pleines
   SIGNAL buffertx_full  : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Indique les zones de stockages des trames Tx encore pleines
   SIGNAL newframe_rx1   : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Indique la zone de stockage d'une nouvelle trame Rx1
   SIGNAL newframe_rx2   : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Indique la zone de stockage d'une nouvelle trame Rx2
   SIGNAL newframe_tx    : STD_LOGIC_VECTOR(31 DOWNTO 0);-- Indique la zone de stockage d'une nouvelle trame Tx
   SIGNAL rx1_overflow   : STD_LOGIC;                    -- Indique la perte d'une trame sur RX1 faute de place en mémoire
   SIGNAL rx2_overflow   : STD_LOGIC;                    -- Indique la perte d'une trame sur RX2 faute de place en mémoire
   SIGNAL tx_overflow    : STD_LOGIC;                    -- Indique la perte d'une trame sur TX faute de place en mémoire
   SIGNAL rx1_badformat  : STD_LOGIC;                    -- Indique une trame reçue avec un mauvais format ou mauvais CRC sur Rx1
   SIGNAL rx2_badformat  : STD_LOGIC;                    -- Indique une trame reçue avec un mauvais format ou mauvais CRC sur Rx2
   SIGNAL addrr_tx       : STD_LOGIC_VECTOR(14 DOWNTO 0);-- @ de lecture des zones TXAPER et TXPER
   SIGNAL data_tx        : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données lues dans les zones TXAPER et TXPER
   SIGNAL rd_datatx      : STD_LOGIC;                    -- Signal de lecture dans une res mémoire APER ou PER

   -- Signaux du flux de données entrant sur les LS pour envoyer vers PCIe synchrone de clk_96
   SIGNAL data_storerx1  : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données à stocker en mémoire avant DMA
   SIGNAL val_storerx1   : STD_LOGIC;                    -- Validant du bus data_store(signal write)
   SIGNAL sof_storerx1   : STD_LOGIC;                    -- Indique un début de trame (nouvelle trame). Synchrone du 1er octet envoyé
   SIGNAL eof_storerx1   : STD_LOGIC;                    -- Indique que la trame est finie (plus de données à envoyer)
   SIGNAL crcok_storerx1 : STD_LOGIC;                    -- Indique que le CRC et le format est bon (sycnhrone de eof) 
   SIGNAL data_storerx2  : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Idem pour RX2  
   SIGNAL val_storerx2   : STD_LOGIC;                    
   SIGNAL sof_storerx2   : STD_LOGIC;                    
   SIGNAL eof_storerx2   : STD_LOGIC;                    
   SIGNAL crcok_storerx2 : STD_LOGIC;                     
   SIGNAL tx_val         : STD_LOGIC;                    -- Pour valider les données Tx vers le PCIe

   -- Signaux du flux de données entrant sur les LS pour envoyer vers PCIe synchrone de clk_pcie
   SIGNAL data_pcie_rx1  : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données à stocker en mémoire avant DMA
   SIGNAL val_pcie_rx1   : STD_LOGIC;                    -- Validant du bus data_store(signal write)
   SIGNAL sof_pcie_rx1   : STD_LOGIC;                    -- Indique un début de trame (nouvelle trame). Synchrone du 1er octet envoyé
   SIGNAL eof_pcie_rx1   : STD_LOGIC;                    -- Indique que la trame est finie (plus de données à envoyer)
   SIGNAL crcok_pcie_rx1 : STD_LOGIC;                    -- Indique que le CRC et le format est bon (sycnhrone de eof) 
   SIGNAL data_pcie_rx2 : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Idem pour RX2  
   SIGNAL val_pcie_rx2  : STD_LOGIC;                    
   SIGNAL sof_pcie_rx2  : STD_LOGIC;                    
   SIGNAL eof_pcie_rx2  : STD_LOGIC;                    
   SIGNAL crcok_pcie_rx2: STD_LOGIC;                     
   SIGNAL data_pcie_tx  : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Idem pour TX  
   SIGNAL val_pcie_tx   : STD_LOGIC;                    
   SIGNAL sof_pcie_tx   : STD_LOGIC;                    
   SIGNAL eof_pcie_tx   : STD_LOGIC;                    

   SIGNAL rst_n : std_logic;
   SIGNAL ls485_rx1 : std_logic;
   SIGNAL ls485_tx1 : std_logic;
   SIGNAL ls485_rx2 : std_logic;
   SIGNAL ls485_tx2 : std_logic;
   SIGNAL pmd : std_logic_vector(7 downto 0);
   SIGNAL pmall : std_logic;
   SIGNAL pmalh : std_logic;
   SIGNAL pmrd : std_logic;
   SIGNAL pmwr : std_logic;

   COMPONENT memory_map IS
   GENERIC (
      reg_version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10"    -- Version du firmware
      );
   PORT (
      clk_sys        : IN  STD_LOGIC;
      rst_n          : IN  STD_LOGIC;
      iid            : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
      rd_addr        : IN  STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 DOWNTO 0);
      rd_data        : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      rd_be          : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      rd_en          : IN  STD_LOGIC;
      wr_addr        : IN  STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 DOWNTO 0);
      wr_data        : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      wr_be          : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      wr_en          : IN  STD_LOGIC;  
      wr_busy        : OUT STD_LOGIC;
      rst_regn       : OUT STD_LOGIC;
      store_enable   : OUT STD_LOGIC;
      dma_inprogress : IN  STD_LOGIC;
      update_ena     : IN  STD_LOGIC;
      rx_flushn      : OUT STD_LOGIC;
      topcyc         : IN  STD_LOGIC;
      tx_ena_periodic: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      tx_ena_aper    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      clr_txena_aper : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      dma_base_pa    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      dma_timestamp  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      bufferrx1_full : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      bufferrx2_full : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      buffertx_full  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      newframe_rx1   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      newframe_rx2   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      newframe_tx    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      rx1_overflow   : IN  STD_LOGIC;
      rx2_overflow   : IN  STD_LOGIC;
      tx_overflow    : IN  STD_LOGIC;
      rx1_badformat  : IN  STD_LOGIC;
      rx2_badformat  : IN  STD_LOGIC;
		clk_96			: IN  STD_LOGIC;
		rd_force			: IN  STD_LOGIC;
		data_force		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		empty_force		: OUT STD_LOGIC;
      addrr_tx       : IN  STD_LOGIC_VECTOR(14 DOWNTO 0);
      data_tx        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      rd_datatx      : IN  STD_LOGIC;
      testpoint      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT manage_dma
   PORT (
      clk_sys           : IN  STD_LOGIC;  -- Clock système à 62.5MHz
      rst_n             : IN  STD_LOGIC;  -- Reset général système
      store_enable      : IN  STD_LOGIC;
      data_storerx1     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données à stocker.  
      val_storerx1      : IN  STD_LOGIC;                    -- Validant du bus data_store(signal write)
      sof_storerx1      : IN  STD_LOGIC;                    -- Indique und début de trame (nouvelle trame). Synchrone du 1er octet envoyé
      eof_storerx1      : IN  STD_LOGIC;                    -- Indique que la trame est finie (plsu de données à envoyer)
      crcok_storerx1    : IN  STD_LOGIC;                    -- Indique que le CRC est bon ou pas (si 
      data_storerx2     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données à stocker.  
      val_storerx2      : IN  STD_LOGIC;                    -- Validant du bus data_store(signal write)
      sof_storerx2      : IN  STD_LOGIC;                    -- Indique und début de trame (nouvelle trame). Synchrone du 1er octet envoyé
      eof_storerx2      : IN  STD_LOGIC;                    -- Indique que la trame est finie (plsu de données à envoyer)
      crcok_storerx2    : IN  STD_LOGIC;                    -- Indique que le CRC est bon ou pas (si 
      data_storetx      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  
      val_storetx       : IN  STD_LOGIC;                    
      sof_storetx       : IN  STD_LOGIC;                    
      eof_storetx       : IN  STD_LOGIC;                    
      newframe_rx1      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      newframe_rx2      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      newframe_tx       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      bufferrx1_full    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);      
      bufferrx2_full    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      buffertx_full     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      rx1_overflow      : OUT STD_LOGIC;
      rx2_overflow      : OUT STD_LOGIC;
      tx_overflow       : OUT STD_LOGIC;
      rx1_badformat     : OUT STD_LOGIC;
      rx2_badformat     : OUT STD_LOGIC;
      dma_inprogress    : OUT STD_LOGIC;
      dma_req           : OUT STD_LOGIC;
      dma_size          : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      dma_ack           : IN  STD_LOGIC;
      dma_compl         : IN  STD_LOGIC;
      dma_read          : IN  STD_LOGIC;
      dma_data          : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      dma_add_dest      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      dma_base_pa       : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      dma_timestamp     : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
   );  
   END COMPONENT;
   
   COMPONENT con_communication_sil
   PORT (
      clk_sys        : IN  STD_LOGIC;
      rst_n          : IN  STD_LOGIC;
      baudrate       : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
      actif          : IN  STD_LOGIC;
      rx1            : IN  STD_LOGIC;
      tx1            : OUT STD_LOGIC;
      rx2            : IN  STD_LOGIC;
      tx2            : OUT STD_LOGIC;
      copy_ena1      : IN  STD_LOGIC;
      copy_ena2      : IN  STD_LOGIC;
      layer7_rx1       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      layer7_soc1      : OUT STD_LOGIC;
      layer7_rd1       : IN  STD_LOGIC;
      layer7_newframe1 : OUT STD_LOGIC;
      layer7_comdispo1 : OUT STD_LOGIC;
      layer7_l2ok1     : OUT STD_LOGIC;
      layer7_overflow1 : OUT STD_LOGIC;
      layer7_rx2       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      layer7_soc2      : OUT STD_LOGIC;
      layer7_rd2       : IN  STD_LOGIC;
      layer7_newframe2 : OUT STD_LOGIC;
      layer7_comdispo2 : OUT STD_LOGIC;
      layer7_l2ok2     : OUT STD_LOGIC;
      layer7_overflow2 : OUT STD_LOGIC;
      data_storerx1    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_storerx1     : OUT STD_LOGIC;
      sof_storerx1     : OUT STD_LOGIC;
      eof_storerx1     : OUT STD_LOGIC;
      crcok_storerx1   : OUT STD_LOGIC;
      data_storerx2    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_storerx2     : OUT STD_LOGIC;
      sof_storerx2     : OUT STD_LOGIC;
      eof_storerx2     : OUT STD_LOGIC;
      crcok_storerx2   : OUT STD_LOGIC;
      tx_dat           : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_txdat        : IN  STD_LOGIC;
      tx_sof           : IN  STD_LOGIC;
      tx_eof           : IN  STD_LOGIC;
      txdat_free       : OUT STD_LOGIC;
      clr_fifo_tx      : IN  STD_LOGIC
      );
   END COMPONENT;

   COMPONENT if_picpmp
   GENERIC (
      version : STD_LOGIC_VECTOR(7 DOWNTO 0));
   PORT (
      clk_sys     : IN  STD_LOGIC;
      rst_n       : IN  STD_LOGIC;
      pmd         : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      pmall       : IN STD_LOGIC;
      pmalh       : IN STD_LOGIC;
      pmrd        : IN STD_LOGIC;
      pmwr        : IN STD_LOGIC;
      iid         : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
      tid         : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      cpy1        : OUT STD_LOGIC;
      cpy2        : OUT STD_LOGIC;
      repli       : OUT STD_LOGIC;
      baudrate    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      actif       : OUT STD_LOGIC; 
      topcyc      : OUT STD_LOGIC;
      l7_rx1      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      l7_soc1     : IN  STD_LOGIC;
      l7_rd1      : OUT STD_LOGIC;
      l7_comdispo1: IN  STD_LOGIC;
      l7_newframe1: IN  STD_LOGIC;
      l7_l2ok1    : IN  STD_LOGIC;
      l7_overflow1: IN  STD_LOGIC;
      l7_rx2      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      l7_soc2     : IN  STD_LOGIC;
      l7_rd2      : OUT STD_LOGIC;
      l7_comdispo2: IN  STD_LOGIC;
      l7_newframe2: IN  STD_LOGIC;
      l7_l2ok2    : IN  STD_LOGIC;
      l7_overflow2: IN  STD_LOGIC;
      tx_dat      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_txdat   : OUT STD_LOGIC;
      tx_sof      : OUT STD_LOGIC;
      tx_eof      : OUT STD_LOGIC;
      txdat_free  : IN  STD_LOGIC;
      clr_fifo_tx : OUT STD_LOGIC
      );
   END COMPONENT;

   COMPONENT flux_chgclk
   PORT (
      clks     : IN  STD_LOGIC;
      clkd     : IN  STD_LOGIC;
      rst_n    : IN  STD_LOGIC;
      datas    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      vals     : IN  STD_LOGIC;
      sofs     : IN  STD_LOGIC;
      eofs     : IN  STD_LOGIC;
      crcoks   : IN  STD_LOGIC;
      datad    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      vald     : OUT STD_LOGIC;
      sofd     : OUT STD_LOGIC;
      eofd     : OUT STD_LOGIC;
      crcokd   : OUT STD_LOGIC
      );
   END COMPONENT;

   COMPONENT serial_tx
	GENERIC (
      nbbit_div : INTEGER := 10);
   PORT(
		clk_sys     : IN STD_LOGIC;
		rst_n       : IN STD_LOGIC;
		tc_divclk   : IN STD_LOGIC_VECTOR(nbbit_div-1 downto 0);
		start_ser   : IN STD_LOGIC;
		tx_dat      : IN STD_LOGIC_VECTOR(7 downto 0);          
		tx          : OUT STD_LOGIC;
		ser_rdy     : OUT STD_LOGIC
		);
	END COMPONENT;
 
   constant clk_96_period : time := 10416 ps;
   constant pci_period : time := 10 ns;

   -- Stimulis port 1
   CONSTANT simclk1_period : time := clk_96_period * 1.01;
   SIGNAL simclk1             : STD_LOGIC := '0';
   SIGNAL ser_rdy1            : STD_LOGIC;
   SIGNAL start_ser1          : STD_LOGIC := '0';
   SIGNAL tx_dat1             : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
   FILE   frames1             : TEXT OPEN READ_MODE IS "frames1.txt";
   
   -- Stimulis port 2
   CONSTANT simclk2_period    : time := clk_96_period * 0.99;
   SIGNAL simclk2             : STD_LOGIC := '0';
   SIGNAL ser_rdy2            : STD_LOGIC;
   SIGNAL start_ser2          : STD_LOGIC := '0';
   SIGNAL tx_dat2             : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
   SIGNAL rx2                 : STD_LOGIC := '0';
   FILE   frames2             : TEXT OPEN READ_MODE IS "frames2.txt"; 

   -- Stimulis port PMP
   CONSTANT pbclk_period  : time := 12500 ps;
   signal pbclk : std_logic := '0';
   FILE   framespmp           : TEXT OPEN READ_MODE IS "frames_pmp.txt"; 
 
BEGIN
   rstpcie_n <= '0', '1' after 200 ns;
   rst_n <= '0', '1' after 200 ns;
   clk_96 <= NOT(clk_96) after clk_96_period/2;
   clk_pcie <= NOT(clk_pcie) after pci_period/2;
   simclk1 <= NOT(simclk1) AFTER simclk1_period/2;
   simclk2 <= NOT(simclk2) AFTER simclk2_period/2;
   pbclk <= NOT(pbclk) AFTER pbclk_period/2;


   PROCESS (clk_96, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rst96_n <= '0';
      ELSIF (clk_96'EVENT AND clk_96 = '1') THEN
         rst96_n <= '1';
      END IF;
   END PROCESS;

   ------------------------------
   -- Instantiation du module mémoire
   ------------------------------
   inst_mem : memory_map
   GENERIC MAP(
      reg_version => x"25")
   PORT MAP (
      clk_sys        => clk_pcie,
      rst_n          => rstpcie_n,
      iid            => iid,
      rd_addr        => rd_addr,
      rd_data        => rd_data,
      rd_be          => rd_be,
      rd_en          => rd_en,
      wr_addr        => wr_addr,
      wr_data        => wr_data,
      wr_be          => wr_be,
      wr_en          => wr_en,
      wr_busy        => wr_busy,
      rst_regn       => rst_regn,
      store_enable   => store_enable,
      dma_inprogress => dma_inprogress,
      update_ena     => '1',
      rx_flushn      => rx_flushn,
      topcyc         => topcyc,
      tx_ena_periodic=> tx_ena_periodic,
      tx_ena_aper    => tx_ena_aper,
      clr_txena_aper => clr_txena_aper,
      dma_base_pa    => dma_base_pa,
      dma_timestamp  => dma_timestamp,
      bufferrx1_full => bufferrx1_full,
      bufferrx2_full => bufferrx2_full,
      buffertx_full  => buffertx_full,
      newframe_rx1   => newframe_rx1,
      newframe_rx2   => newframe_rx2,
      newframe_tx    => newframe_tx,
      rx1_overflow   => rx1_overflow,
      rx2_overflow   => rx2_overflow,
      tx_overflow    => tx_overflow,
      rx1_badformat  => rx1_badformat,
      rx2_badformat  => rx2_badformat,
		clk_96			=> '0',
		rd_force			=> '0',
		data_force		=> open,
		empty_force		=> open,
      addrr_tx       => addrr_tx,
      data_tx        => data_tx,
      rd_datatx      => rd_datatx,
      testpoint      => open
   );

   PROCESS
   BEGIN
      rd_addr <= (OTHERS => '0');
      rd_en <= '0';
      wr_addr <= (OTHERS => '0');
      wr_data <= (OTHERS => '0');
      wr_en <= '0';
      WAIT FOR 1 us;
      WAIT UNTIL clk_pcie'EVENT AND clk_pcie = '1';
      wr_addr <= x"0002";
      wr_data <= x"01000000";
      wr_en <= '1';
      WAIT UNTIL clk_pcie'EVENT AND clk_pcie = '1';
      wr_en <= '0';
      WAIT;
   END PROCESS;
   

   ------------------------------
   -- Gestion du DMA
   ------------------------------
   inst_dma : manage_dma
   PORT MAP (
      clk_sys        => clk_pcie,
      rst_n          => rx_flushn,
      store_enable   => store_enable,
      data_storerx1  => data_pcie_rx1,
      val_storerx1   => val_pcie_rx1,
      sof_storerx1   => sof_pcie_rx1,
      eof_storerx1   => eof_pcie_rx1,
      crcok_storerx1 => crcok_pcie_rx1,
      data_storerx2  => data_pcie_rx2,
      val_storerx2   => val_pcie_rx2,
      sof_storerx2   => sof_pcie_rx2,
      eof_storerx2   => eof_pcie_rx2,
      crcok_storerx2 => crcok_pcie_rx2,
      data_storetx   => data_pcie_tx,
      val_storetx    => val_pcie_tx,
      sof_storetx    => sof_pcie_tx,
      eof_storetx    => eof_pcie_tx,
      newframe_rx1   => newframe_rx1,
      newframe_rx2   => newframe_rx2,
      newframe_tx    => newframe_tx,
      bufferrx1_full => bufferrx1_full,
      bufferrx2_full => bufferrx2_full,
      buffertx_full  => buffertx_full,
      rx1_overflow   => rx1_overflow,
      rx2_overflow   => rx2_overflow,
      tx_overflow    => tx_overflow,
      rx1_badformat  => rx1_badformat,
      rx2_badformat  => rx2_badformat,
      dma_inprogress => dma_inprogress,
      dma_req        => dma_req,
      dma_size       => dma_size,
      dma_ack        => dma_ack,
      dma_compl      => dma_compl,
      dma_read       => dma_read,
      dma_data       => dma_data,
      dma_add_dest   => dma_add_dest,
      dma_base_pa    => x"12345678",
      dma_timestamp  => x"12"
   ); 

   -----------------------------------------------
   -- Instantiation du module de communication
   -----------------------------------------------
   inst_comm : con_communication_sil 
   PORT MAP (
      clk_sys        => clk_96,
      rst_n          => rst96_n,
      baudrate       => baudrate,
      actif          => actif,
      rx1            => ls485_rx1,
      tx1            => ls485_tx1,
      rx2            => ls485_rx2,
      tx2            => ls485_tx2,
      copy_ena1      => cpy1,
      copy_ena2      => cpy2,
      layer7_rx1     => l7_rx1,
      layer7_soc1    => l7_soc1,
      layer7_rd1     => l7_rd1,
      layer7_newframe1 => l7_newframe1,
      layer7_comdispo1 => l7_comdispo1,
      layer7_l2ok1     => l7_l2ok1,
      layer7_overflow1 => l7_overflow1,
      layer7_rx2       => l7_rx2,
      layer7_soc2      => l7_soc2,
      layer7_rd2       => l7_rd2,
      layer7_newframe2 => l7_newframe2,
      layer7_comdispo2 => l7_comdispo2,
      layer7_l2ok2     => l7_l2ok2,
      layer7_overflow2 => l7_overflow2,
      data_storerx1    => data_storerx1,
      val_storerx1     => val_storerx1,
      sof_storerx1     => sof_storerx1,
      eof_storerx1     => eof_storerx1,
      crcok_storerx1   => crcok_storerx1,
      data_storerx2    => data_storerx2,
      val_storerx2     => val_storerx2,
      sof_storerx2     => sof_storerx2,
      eof_storerx2     => eof_storerx2,
      crcok_storerx2   => crcok_storerx2,
      tx_dat           => tx_dat,
      val_txdat        => val_txdat,
      tx_sof           => tx_sof,
      tx_eof           => tx_eof,
      txdat_free       => txdat_free,
      clr_fifo_tx      => clr_fifo_tx
   );

   -----------------------------------------------
   -- Instantiation du module d'interface PIC
   -----------------------------------------------
   inst_pic : if_picpmp
   GENERIC MAP (
      version => x"25")
   PORT MAP (
      clk_sys      => clk_96,
      rst_n        => rst96_n,
      pmd          => pmd,
      pmall        => pmall,
      pmalh        => pmalh,
      pmrd         => pmrd,
      pmwr         => pmwr,
      iid          => iid,
      tid          => tid,
      cpy1         => cpy1,
      cpy2         => cpy2,
      repli        => repli,
      baudrate     => baudrate,
      actif        => actif,
      topcyc       => topcyc,
      l7_rx1       => l7_rx1,
      l7_soc1      => l7_soc1,
      l7_rd1       => l7_rd1,
      l7_comdispo1 => l7_comdispo1,
      l7_newframe1 => l7_newframe1,
      l7_l2ok1     => l7_l2ok1,
      l7_overflow1 => l7_overflow1,
      l7_rx2       => l7_rx2,
      l7_soc2      => l7_soc2,
      l7_rd2       => l7_rd2,
      l7_comdispo2 => l7_comdispo2,
      l7_newframe2 => l7_newframe2,
      l7_l2ok2     => l7_l2ok2,
      l7_overflow2 => l7_overflow2,
      tx_dat       => tx_dat,
      val_txdat    => val_txdat,
      tx_sof       => tx_sof,
      tx_eof       => tx_eof,
      txdat_free   => txdat_free,
      clr_fifo_tx  => clr_fifo_tx
      );

   --------------------------------------------
   -- Changement d'horloge des flux RX1, RX2, TX
   --------------------------------------------
   inst_chgclk_rx1 : flux_chgclk
   PORT MAP(
      clks     => clk_96,
      clkd     => clk_pcie,
      rst_n    => rst96_n,
      datas    => data_storerx1,
      vals     => val_storerx1,
      sofs     => sof_storerx1,
      eofs     => eof_storerx1,
      crcoks   => crcok_storerx1,
      datad    => data_pcie_rx1,
      vald     => val_pcie_rx1,
      sofd     => sof_pcie_rx1,
      eofd     => eof_pcie_rx1,
      crcokd   => crcok_pcie_rx1
      );

   inst_chgclk_rx2 : flux_chgclk
   PORT MAP(
      clks     => clk_96,
      clkd     => clk_pcie,
      rst_n    => rst96_n,
      datas    => data_storerx2,
      vals     => val_storerx2,
      sofs     => sof_storerx2,
      eofs     => eof_storerx2,
      crcoks   => crcok_storerx2,
      datad    => data_pcie_rx2,
      vald     => val_pcie_rx2,
      sofd     => sof_pcie_rx2,
      eofd     => eof_pcie_rx2,
      crcokd   => crcok_pcie_rx2
      );

   tx_val <= txdat_free AND val_txdat;   -- On assure que chaque donnée n'est stockée qu'une seule fois
   inst_chgclk_tx : flux_chgclk
   PORT MAP(
      clks     => clk_96,
      clkd     => clk_pcie,
      rst_n    => rst96_n,
      datas    => tx_dat,
      vals     => tx_val,
      sofs     => tx_sof,
      eofs     => tx_eof,
      crcoks   => '1',
      datad    => data_pcie_tx,
      vald     => val_pcie_tx,
      sofd     => sof_pcie_tx,
      eofd     => eof_pcie_tx,
      crcokd   => OPEN
      );

   
   -------------------------------------------------
   -- TB
   -------------------------------------------------
   PROCESS
      VARIABLE lread      : LINE;
      VARIABLE comments   : CHARACTER;
      VARIABLE nb_byte    : INTEGER;    
      VARIABLE time_frame : TIME;
      VARIABLE value      : STD_LOGIC_VECTOR(7 downto 0);
   BEGIN
      start_ser1 <= '0';
      tx_dat1 <= (OTHERS => '0');
      WHILE NOT ENDFILE(frames1) LOOP
         READLINE(frames1, lread);
         READ(lread, comments);
         IF comments/='#' THEN         -- the line is not a comment line
            READ(lread, time_frame);    -- read the obsolute time to send the frame
            IF (comments = 'A' OR comments = 'a') THEN
               WAIT FOR time_frame - NOW;  -- until an absolute time
            ELSE
               WAIT FOR time_frame;
            END IF;
            READ(lread, nb_byte);        
            WHILE (nb_byte > 0) LOOP
               IF (ser_rdy1 = '0') THEN
                  WAIT UNTIL ser_rdy1 = '1';
               END IF;
               WAIT UNTIL simclk1'EVENT and simclk1 = '0';
               HREAD(lread, value);
               tx_dat1 <= value;
               start_ser1 <= '1';
               WAIT UNTIL simclk1'EVENT and simclk1 = '0';
               start_ser1 <= '0';
               nb_byte := nb_byte - 1 ;
            END LOOP; 
         END IF;
      END LOOP; 
      WAIT;    
   END PROCESS;

   inst_serial_tx1: serial_tx 
   GENERIC MAP (
      nbbit_div => 11)
   PORT MAP(
		clk_sys => simclk1,
		rst_n => rst_n,
		tc_divclk => CONV_STD_LOGIC_VECTOR(7,11),
		tx => ls485_rx1,
		ser_rdy => ser_rdy1,
		start_ser => start_ser1,
		tx_dat => tx_dat1
	);

   PROCESS
      VARIABLE lread      : LINE;
      VARIABLE comments   : CHARACTER;
      VARIABLE nb_byte    : INTEGER;    
      VARIABLE time_frame : TIME;
      VARIABLE value      : STD_LOGIC_VECTOR(7 downto 0);
   BEGIN
      start_ser2 <= '0';
      tx_dat2 <= (OTHERS => '0');
      WHILE NOT ENDFILE(frames2) LOOP
         READLINE(frames2, lread);
         READ(lread, comments);
         IF comments/='#' THEN         -- the line is not a comment line
            READ(lread, time_frame);    -- read the obsolute time to send the frame
            IF (comments = 'A' OR comments = 'a') THEN
               WAIT FOR time_frame - NOW;  -- until an absolute time
            ELSE
               WAIT FOR time_frame;
            END IF;
            READ(lread, nb_byte);        
            WHILE (nb_byte > 0) LOOP
               IF (ser_rdy2 = '0') THEN
                  WAIT UNTIL ser_rdy2 = '1';
               END IF;
               WAIT UNTIL simclk2'EVENT and simclk2 = '0';
               HREAD(lread, value);
               tx_dat2 <= value;
               start_ser2 <= '1';
               WAIT UNTIL simclk2'EVENT and simclk2 = '0';
               start_ser2 <= '0';
               nb_byte := nb_byte - 1 ;
            END LOOP; 
         END IF;
      END LOOP; 
      WAIT;    
   END PROCESS;

   inst_serial_tx2: serial_tx 
   GENERIC MAP (
      nbbit_div => 11)
   PORT MAP(
		clk_sys => simclk2,
		rst_n => rst_n,
		tc_divclk => CONV_STD_LOGIC_VECTOR(7,11),
		tx => ls485_rx2,
		ser_rdy => ser_rdy2,
		start_ser => start_ser2,
		tx_dat => tx_dat2
	);

   PROCESS
      VARIABLE lread      : LINE;
      VARIABLE comments   : CHARACTER;
      VARIABLE nb_byte    : INTEGER;    
      VARIABLE time_frame : TIME;
      VARIABLE value      : STD_LOGIC_VECTOR(7 downto 0);
      VARIABLE com        : STD_LOGIC_VECTOR(7 downto 0);
      VARIABLE add        : STD_LOGIC_VECTOR(7 downto 0);
   BEGIN
      pmd <= (OTHERS => 'Z');
      pmall <= '0';
      pmalh <= '0';
      pmrd <= '0';
      pmwr <= '0';
      WHILE NOT ENDFILE(framespmp) LOOP
         READLINE(framespmp, lread);
         READ(lread, comments);
         IF comments/='#' THEN         -- the line is not a comment line
            READ(lread, time_frame);    -- read the obsolute time to send the frame
            IF (comments = 'A' OR comments = 'a') THEN
               WAIT FOR time_frame - NOW;  -- until an absolute time
            ELSE
               WAIT FOR time_frame;
            END IF;
            READ(lread, nb_byte);
            HREAD(lread, value);
            com := value;
            add := '0' & com(7 DOWNTO 1);
            nb_byte := nb_byte - 1;
            WAIT UNTIL pbclk'EVENT and pbclk = '1';
            WHILE (nb_byte > 0) LOOP
               HREAD(lread, value);
               pmd <= add;
               WAIT UNTIL pbclk'EVENT and pbclk = '1';
               pmall <= '1';
               WAIT UNTIL pbclk'EVENT and pbclk = '1';
               pmall <= '0';
               WAIT UNTIL pbclk'EVENT and pbclk = '1';
               pmd <= x"00";
               WAIT UNTIL pbclk'EVENT and pbclk = '1';
               pmalh <= '1';
               WAIT UNTIL pbclk'EVENT and pbclk = '1';
               pmalh <= '0';
               WAIT UNTIL pbclk'EVENT and pbclk = '1';
               IF (com(0) = '1') THEN
                  pmd <= (OTHERS => 'Z');
                  WAIT UNTIL pbclk'EVENT and pbclk = '1';
                  pmrd <= '1';
                  WAIT UNTIL pbclk'EVENT and pbclk = '1';
                  pmrd <= '0';
               ELSE
                  pmd <= value;
                  pmwr <= '1';
                  WAIT UNTIL pbclk'EVENT and pbclk = '1';
                  pmwr <= '0';
                  WAIT UNTIL pbclk'EVENT and pbclk = '1';
                  WAIT UNTIL pbclk'EVENT and pbclk = '1';
                  pmd <= (OTHERS => 'Z');
               END IF;
               nb_byte := nb_byte - 1;
               IF (add /= x"0E" AND add /= x"0F" AND add /= x"10") THEN
                  add := add + 1;
               END IF;
            END LOOP; 
         END IF;
      END LOOP; 
      WAIT;    
   END PROCESS;

END rtl;

