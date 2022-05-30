--============================================================================= 
--  TITRE : TOP_FPGACOSIL4
--  DESCRIPTION : 
--        Module TOP du FPGA du Concentrateur SIL4
--
--  FICHIER :        top_fpgacosil4.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  06/10/2015	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

LIBRARY work;
USE work.package_saturn.ALL;

ENTITY top_fpgacosil4 IS
   GENERIC (
      reg_version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10"    -- Version du firmware
      );
   PORT (
      clk_24      : IN  STD_LOGIC;     -- Horloge principale � 24MHz
      rst_n       : IN  STD_LOGIC;     -- Reset principal de la carte
      rstfpga_uc1n: IN  STD_LOGIC;     -- Reset issu du PIC32
      rstfpga_uc2n: IN  STD_LOGIC;     -- Reset issu du PIC32
      led_confok  : OUT STD_LOGIC;     -- Pilotage de la led rouge
      led_run     : OUT STD_LOGIC;     -- Pilotage de la 1�re LED verte
      led_fail    : OUT STD_LOGIC;     -- Pilotage de la 2�me LED verte
      power_rstn  : IN  STD_LOGIC;     -- Indique que l'alim 3.3V du PIC est coup�e
      interrupt   : IN  STD_LOGIC;     -- Signal d'interruption issu du SWITCH
      prog_b      : IN  STD_LOGIC;     -- Force la reprog du FPGA
      rst_switchn : OUT STD_LOGIC;
   
      -- Interfaces ports s�ries
      ls485_de1   : OUT STD_LOGIC;     -- Signal d'autorisation � �mettre de la LS1
      ls485_ren1  : OUT STD_LOGIC;     -- Signal d'autorisation � �mettre de la LS1
      ls485_rx1   : IN  STD_LOGIC;     -- Signal de r�ception de la LS1
      ls485_tx1   : OUT STD_LOGIC;     -- Signal d'�mission de la LS1

      ls485_de2   : OUT STD_LOGIC;     -- Signal d'autorisation � �mettre de la LS2
      ls485_ren2  : OUT STD_LOGIC;     -- Signal d'autorisation � �mettre de la LS2
      ls485_rx2   : IN  STD_LOGIC;     -- Signal de r�ception de la LS2
      ls485_tx2   : OUT STD_LOGIC;     -- Signal d'�mission de la LS2

      -- Interface PMP (Interface PIC1)
      pmd_uc1        : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Bus Data / Adresse
      pmall_uc1      : IN STD_LOGIC;   -- Latch des LSB de l'adresse
      pmalh_uc1      : IN STD_LOGIC;   -- Latch des MSB de l'adresse
      pmrd_uc1       : IN STD_LOGIC;   -- Signal de read
      pmwr_uc1       : IN STD_LOGIC;   -- Signal de write

      -- Interface PMP (Interface PIC1)
      pmd_uc2        : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Bus Data / Adresse
      pmall_uc2      : IN STD_LOGIC;   -- Latch des LSB de l'adresse
      pmalh_uc2      : IN STD_LOGIC;   -- Latch des MSB de l'adresse
      pmrd_uc2       : IN STD_LOGIC;   -- Signal de read
      pmwr_uc2       : IN STD_LOGIC;   -- Signal de write
      cmd_fpga_pmp2  : OUT STD_LOGIC;  -- Signal d'activation des ADUM vers le FPGA (NOT(pmrd_uc2)) 

      -- Interface de pilotage des Alim isol�es
      cdehigh_5vid   : OUT STD_LOGIC;  -- Commande du 5V de la puce Dallas
      cdelow_5vid    : OUT STD_LOGIC;
      cdehigh_5vls1  : OUT STD_LOGIC;  -- Commande du 5V du port s�rie LS1 + Maintenance 1
      cdelow_5vls1   : OUT STD_LOGIC;
      cdehigh_5vls2  : OUT STD_LOGIC;  -- Commande du 5V du port s�rie LS2
      cdelow_5vls2   : OUT STD_LOGIC;
      cdehigh_5vlsm2 : OUT STD_LOGIC;  -- Commande du 5V maintenance 2
      cdelow_5vlsm2  : OUT STD_LOGIC;
      cdehigh_5vcan  : OUT STD_LOGIC;  -- Commande du 5V CAN
      cdelow_5vcan   : OUT STD_LOGIC;
          
      -- Interface PCIe
      pci_rstn    : IN  STD_LOGIC;     -- Reset de l'interface PCIe
      pci_exp_txp : OUT STD_LOGIC;     -- Signal diff�rentiel Tx PCIe
      pci_exp_txn : OUT STD_LOGIC;
      pci_exp_rxp : IN  STD_LOGIC;     -- Signal diff�rentiel Rx PCIe
      pci_exp_rxn : IN  STD_LOGIC;
      pci_clk_p   : IN  STD_LOGIC;     -- Signal diff�rentiel Clock PCIe
      pci_clk_n   : IN  STD_LOGIC;
      pci_waken   : OUT STD_LOGIC;     -- Signal de r�veil PCIe (RFU)
      pci_spare   : IN  STD_LOGIC;     -- Signal en spare

      -- Interface SPI (programmation de la flash de configuration)
      wp_flashn      : OUT STD_LOGIC;  -- Autorisation d'�criture dans la flash SPI
      cclk           : OUT STD_LOGIC;  -- Horloge d'acc�s � la flash SPI
      din_miso       : IN  STD_LOGIC;  -- Data s�rie en lecture SPI
      mosi           : OUT STD_LOGIC;  -- Data s�rie en �criture SPI
      cso_b          : OUT STD_LOGIC;  -- Chip select SPI

      -- Interface PMP Spare avec la passerelle
      uc_pmd      : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      uc_pmrd     : IN STD_LOGIC;
      uc_pmwr     : IN STD_LOGIC;
      uc_pmall    : IN STD_LOGIC;
      uc_pmalh    : IN STD_LOGIC;
      uc_pmacs1   : IN STD_LOGIC;
      uc_pmacs2   : IN STD_LOGIC;

      -- Interface SPI Spare avec la passerelle
      uc_sck      : IN STD_LOGIC;
      uc_ssn      : IN STD_LOGIC;
      uc_sdi      : IN STD_LOGIC;
      uc_sdo      : IN STD_LOGIC;
      
      -- Interface Spare avec les PIC
      pic_rx         : IN  STD_LOGIC;
      pic_tx         : OUT STD_LOGIC;
      pic_spare_uc1  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      pic_sck        : IN  STD_LOGIC;
      pic_sdi        : IN  STD_LOGIC;
      pic_sdo        : OUT STD_LOGIC;
      pic_ssn        : IN  STD_LOGIC;
      pic_spare_uc2  : IN  STD_LOGIC_VECTOR(4 DOWNTO 2);
      
      -- Spare
      ext_pull       : IN  STD_LOGIC;
      tp             : OUT STD_LOGIC_VECTOR(27 DOWNTO 21)
      );
END top_fpgacosil4;

ARCHITECTURE rtl of top_fpgacosil4 is
   -- signaux utilis�s pour les fonctions syst�mes
   SIGNAL clk_sys        : STD_LOGIC:= '0';              -- Horloge syst�me = 2 x clk_24
   SIGNAL clk_48         : STD_LOGIC:= '0';              -- Pour r�cup�rer l'horloge CLKx2 � la sortie du DCM
   SIGNAL clk_96         : STD_LOGIC:= '0';              -- Pour r�cup�rer l'horloge CLKFX � la sortie du DCM
   SIGNAL clk_dna        : STD_LOGIC:= '0';              -- Horloge � 1 MHz pour lire le DNA
   SIGNAL clk_pcie       : STD_LOGIC:= '0';              -- Horloge � 62.5 MHz issue de l'I/F PCIe
   SIGNAL rst_dcm        : STD_LOGIC:= '0';              -- Signal de reset du DCM
   SIGNAL rst_picn       : STD_LOGIC;                    -- Reset activ� par les 2 PIC � la fois
   SIGNAL rstdna_n       : STD_LOGIC:= '0';              -- reset resynchronis� sur clk_dna
   SIGNAL rst96_n        : STD_LOGIC:= '0';              -- reset resynchronis� sur clk96
   SIGNAL rstpcie_n      : STD_LOGIC := '0';             -- Pour filtrer le reset entrant
   SIGNAL dcm_locked     : STD_LOGIC:= '0';              -- Signal de lock du DCM
   SIGNAL cpt_blink      : STD_LOGIC_VECTOR(23 DOWNTO 0); -- Compteur pour le blink de la led run
   SIGNAL iid            : STD_LOGIC_VECTOR(63 DOWNTO 0); -- Valeur d'IID
   SIGNAL iid_rdy        : STD_LOGIC;                    -- Indique que le IID a �t� r�cup�r�

   -- Signaux d'interface entre le module de comm et le module spi PIC
   SIGNAL tid           : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- TID utilis� par le concentrateur
   SIGNAL cpy1          : STD_LOGIC;                     -- Autorise la copie du port 1 sur le port 2
   SIGNAL cpy2          : STD_LOGIC;                     -- Autorise la copie du port 2 sur le port 1
   SIGNAL repli         : STD_LOGIC;                     -- Indique que le cocnentrateur est en mode repli
   SIGNAL topcyc        : STD_LOGIC;                     -- Un pulse � chaque d�but de cycle
   SIGNAL topcyc1       : STD_LOGIC;                     -- Un pulse � chaque d�but de cycle g�n�r� par PIC 1
   SIGNAL topcyc2       : STD_LOGIC;                     -- Un pulse � chaque d�but de cycle g�n�r� par PIC 2
   SIGNAL ena_filt_dble : STD_LOGIC;                     -- Autorise le filtrage des trames en double
   SIGNAL lanscan1      : STD_LOGIC;                     -- Indique � l'autre PIC qu'on veut faire un LANSCAN
   SIGNAL lanscan2      : STD_LOGIC;                     -- Indique que l'autre PIC est pr�t � faire un LANSCAN
   SIGNAL synchro1      : STD_LOGIC;                     -- Indique � l'autre PIC qu'on vient d'�mettre une synchro
   SIGNAL ack_synchro1  : STD_LOGIC;                     -- Indique que l'autre PIC a bien not� la nouvelle synchro
   SIGNAL sync_num1     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Num�ro du cyle en cours qu'on vient d'�mettre
   SIGNAL synchro2      : STD_LOGIC;                     -- Indique que l'autre PIC a �mis une trame de synchro
   SIGNAL ack_synchro2  : STD_LOGIC;                     -- Acquitte la trame de synhcro �mise par l'auter PIC
   SIGNAL sync_num2     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Num�ro du cyle en cours que l'autre PIC vient d'�mettre
   SIGNAL invcrc1       : STD_LOGIC_VECTOR(15 DOWNTO 0); -- CRC des invariants calcul� par le PIC1
   SIGNAL invcrc2       : STD_LOGIC_VECTOR(15 DOWNTO 0); -- CRC des invariants calcul� par le PIC1

   -- Interface de gestion des donn�es applicatives re�ues sur le port 1, c�t� �C1
   SIGNAL filt_rx1_uc1  : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Dbus de onn�es extraites de la trame
   SIGNAL filt_soc1_uc1 : STD_LOGIC;              -- Indique un d�but de trame
   SIGNAL filt_rd1_uc1  : STD_LOGIC;              -- Demande une donn�e applicative de plus
   SIGNAL filt_comdispo1_uc1: STD_LOGIC;          -- Indique que des donn�es applicatives sont en attentes
   SIGNAL l7_newframe1  : STD_LOGIC;              -- Indique la r�ception d'une nouvelle trame
   SIGNAL l7_l2ok1      : STD_LOGIC;              -- Indique que la trame re�u est correcte (format + CRC)
   SIGNAL l7_overflow1  : STD_LOGIC;              -- Indique que la m�moire de stockage a d�bord�
   -- Interface de gestion des donn�es applicatives re�ues sur le port 2, c�t� �C1
   SIGNAL filt_rx2_uc1  : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Idem
   SIGNAL filt_soc2_uc1 : STD_LOGIC;
   SIGNAL filt_rd2_uc1  : STD_LOGIC;
   SIGNAL filt_comdispo2_uc1: STD_LOGIC;
   SIGNAL l7_newframe2  : STD_LOGIC;
   SIGNAL l7_l2ok2      : STD_LOGIC;
   SIGNAL l7_overflow2  : STD_LOGIC;
   -- Interface de gestion des donn�es applicatives re�ues sur le port 1, c�t� �C2
   SIGNAL filt_rx1_uc2  : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Dbus de onn�es extraites de la trame
   SIGNAL filt_soc1_uc2 : STD_LOGIC;              -- Indique un d�but de trame
   SIGNAL filt_rd1_uc2  : STD_LOGIC;              -- Demande une donn�e applicative de plus
   SIGNAL filt_comdispo1_uc2: STD_LOGIC;          -- Indique que des donn�es applicatives sont en attentes
   -- Interface de gestion des donn�es applicatives re�ues sur le port 2, c�t� �C2
   SIGNAL filt_rx2_uc2  : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Idem
   SIGNAL filt_soc2_uc2 : STD_LOGIC;
   SIGNAL filt_rd2_uc2  : STD_LOGIC;
   SIGNAL filt_comdispo2_uc2: STD_LOGIC;

   -- Interface de gestion des donn�es applicatives � transmettre cot� �C1
   SIGNAL txdat_free    : STD_LOGIC;              -- Indique que le module transport en tx est dispo
   SIGNAL acq_stuf      : STD_LOGIC;              -- Signal d'acquittement du train de fanions 7Fh

   SIGNAL tx_dat_uc1    : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Bis de donn�es applicatives
   SIGNAL val_txdat_uc1 : STD_LOGIC;              -- Indique une donn�e valide sur tx_dat
   SIGNAL tx_sof_uc1    : STD_LOGIC;              -- Indique un d�but de trame � transmettre
   SIGNAL tx_eof_uc1    : STD_LOGIC;              -- Indique une fin de trame � transmettre
   SIGNAL clr_fifo_tx_uc1: STD_LOGIC;             -- Permet d'effacer la FIFO d'emission
   SIGNAL stuf_phys_uc1 : STD_LOGIC;                     -- Signal de g�n�ration d'un train de fanions 7Fh sur les LS1 et LS2
   SIGNAL tx_available_uc1 : STD_LOGIC;           -- Signale au module de communication qu'une trame est en attente d'�mission
   SIGNAL tx_commena_uc1: STD_LOGIC;              -- Autorise l'�mission de la trame en attente
   -- Interface de gestion des donn�es applicatives � transmettre cot� �C2
   SIGNAL tx_dat_uc2    : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Bis de donn�es applicatives
   SIGNAL val_txdat_uc2 : STD_LOGIC;              -- Indique une donn�e valide sur tx_dat
   SIGNAL tx_sof_uc2    : STD_LOGIC;              -- Indique un d�but de trame � transmettre
   SIGNAL tx_eof_uc2    : STD_LOGIC;              -- Indique une fin de trame � transmettre
   SIGNAL clr_fifo_tx_uc2: STD_LOGIC;             -- Permet d'effacer la FIFO d'emission
   SIGNAL stuf_phys_uc2 : STD_LOGIC;              -- Signal de g�n�ration d'un train de fanions 7Fh sur les LS1 et LS2
   SIGNAL tx_available_uc2 : STD_LOGIC;           -- Signale au module de communication qu'une trame est en attente d'�mission
   SIGNAL tx_commena_uc2: STD_LOGIC;              -- Autorise l'�mission de la trame en attente

   -- Pilotage des alim (PWM)
   SIGNAL cpt_cde       : STD_LOGIC_VECTOR(5 DOWNTO 0);  -- Compteur pour g�n�rer les pulses de commande des alims isol�es
   SIGNAL toggle_cde    : STD_LOGIC;                     -- Pour savoir quelle voie de la commadne alim est active
   SIGNAL cde_high      : STD_LOGIC;                     -- Commande directe pour les alims isol�es
   SIGNAL cde_low       : STD_LOGIC;                     -- Commande inverse pour les alims isol�es
   
   -- Signaux du bus local de l'interface PCIe
   SIGNAL rd_addr       : STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 downto 0); -- Bus d'@ en lecture
   SIGNAL rd_data       : STD_LOGIC_VECTOR(31 downto 0);                -- Donn�es lues sur le bus local
   SIGNAL rd_be         : STD_LOGIC_VECTOR(3 downto 0);                 -- Byte Enable en lecture
   SIGNAL rd_en         : STD_LOGIC;                                    -- Signal d'ordre de lecture
   SIGNAL wr_addr       : STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 downto 0); -- Bus d'@ en �criture
   SIGNAL wr_data       : STD_LOGIC_VECTOR(31 downto 0);                -- Donn�es � �crire sur le bus local
   SIGNAL wr_be         : STD_LOGIC_VECTOR(3 downto 0);                 -- Byte enable en �criture
   SIGNAL wr_en         : STD_LOGIC;                                    -- Signal d'ordre d'�criture
   SIGNAL wr_busy       : STD_LOGIC;                                    -- Indique que le bus local est occup� en �criture
   SIGNAL link_up_n     : STD_LOGIC;                                    -- Indique le lien PCIe est �tabli avec le host
   SIGNAL dma_req       : STD_LOGIC;                     -- Requ�te d'un DMA
   SIGNAL dma_add_dest  : STD_LOGIC_VECTOR(31 downto 0); -- Adresse de estination (cot� PC) pour le DMA
   SIGNAL dma_compl     : STD_LOGIC;                     -- Indique que le DMA est fini
   SIGNAL dma_read      : STD_LOGIC;                     -- Ordre de lecture pour fetcher une donn�e suppl�mentaire � envoyer par DMA
   SIGNAL dma_ack       : STD_LOGIC;                     -- Indique que la demande de DMA est accept�e         
   SIGNAL dma_size      : STD_LOGIC_VECTOR(7 downto 0);  -- Nombre de mots de 32 bits � tansf�rer par DMA
   SIGNAL dma_data      : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Donn�es � transmettre par DMA (fetch�e par dma_read)
   SIGNAL dma_timestamp : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- LSB du num�ro de cycle en cours
   
   -- Signaux de gestion du module memory_map
   SIGNAL rst_regn      : STD_LOGIC;                     -- Reset interne pilot� par registre
   SIGNAL actif         : STD_LOGIC;                     -- Indique que le concentrateur est actif
   SIGNAL store_enable  : STD_LOGIC;                     -- Autorise le transfert DMA des trames incidentes
   SIGNAL rx_flushn     : STD_LOGIC;                     -- Reset du module DMA
   SIGNAL dma_inprogress: STD_LOGIC;                     -- A 1 tant que le module DMA est en cours de transfert
   SIGNAL update_ena    : STD_LOGIC;                     -- Autorise la mise � jour de la m�moire TX_PER
   SIGNAL baudrate      : STD_LOGIC_VECTOR(2 DOWNTO 0);  -- Code du baudrate de communication (entre 50Kbits et 12MBits)
   SIGNAL dma_base_pa   : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Adresse physique de base pour les DMA (cot� PC)
   SIGNAL bufferrx1_full: STD_LOGIC_VECTOR(31 DOWNTO 0); -- Indique les zones de stockages des trames Rx1 encore pleines
   SIGNAL bufferrx2_full: STD_LOGIC_VECTOR(31 DOWNTO 0); -- Indique les zones de stockages des trames Rx2 encore pleines
   SIGNAL buffertx_full : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Indique les zones de stockages des trames Tx encore pleines
   SIGNAL newframe_rx1  : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Indique la zone de stockage d'une nouvelle trame Rx1
   SIGNAL newframe_rx2  : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Indique la zone de stockage d'une nouvelle trame Rx2
   SIGNAL newframe_tx   : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Indique la zone de stockage d'une nouvelle trame Tx
   SIGNAL rx1_overflow  : STD_LOGIC;                     -- Indique la perte d'une trame sur RX1 faute de place en m�moire
   SIGNAL rx2_overflow  : STD_LOGIC;                     -- Indique la perte d'une trame sur RX2 faute de place en m�moire
   SIGNAL tx_overflow   : STD_LOGIC;                     -- Indique la perte d'une trame sur TX faute de place en m�moire
   SIGNAL rx1_badformat : STD_LOGIC;                     -- Indique une trame re�ue avec un mauvais format ou mauvais CRC sur Rx1
   SIGNAL rx2_badformat : STD_LOGIC;                     -- Indique une trame re�ue avec un mauvais format ou mauvais CRC sur Rx2
   SIGNAL actif_passifn : STD_LOGIC;                     -- Signale � la passerelle si le cocnentrateur est actif ou pas
   SIGNAL cpy_r1, cpy_r2: STD_LOGIC;                     -- Pour changemenet d'horloge de cpy1/cpy2 vers actif_passifn

   -- Signaux du flux de donn�es entrant sur les LS pour envoyer vers PCIe synchrone de clk_96
   SIGNAL data_storerx1 : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donn�es � stocker en m�moire avant DMA
   SIGNAL val_storerx1  : STD_LOGIC;                     -- Validant du bus data_store(signal write)
   SIGNAL sof_storerx1  : STD_LOGIC;                     -- Indique un d�but de trame (nouvelle trame). Synchrone du 1er octet envoy�
   SIGNAL eof_storerx1  : STD_LOGIC;                     -- Indique que la trame est finie (plus de donn�es � envoyer)
   SIGNAL crcok_storerx1: STD_LOGIC;                     -- Indique que le CRC et le format est bon (sycnhrone de eof) 
   SIGNAL data_storerx2 : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem pour RX2  
   SIGNAL val_storerx2  : STD_LOGIC;                    
   SIGNAL sof_storerx2  : STD_LOGIC;                    
   SIGNAL eof_storerx2  : STD_LOGIC;                    
   SIGNAL crcok_storerx2: STD_LOGIC;                     
   -- Signaux de multiplexage des �critures des trames Tx par les 2 PIC
   SIGNAL tx_dat       : STD_LOGIC_VECTOR(7 DOWNTO 0);   -- Flux de donn�es applicatives � transmettre
   SIGNAL val_txdat    : STD_LOGIC;                      -- Indique un octet dispo sur tx_dat
   SIGNAL tx_sof       : STD_LOGIC;                      -- Indique un d�but de trame
   SIGNAL tx_eof       : STD_LOGIC;                      -- Indique une fin de trame

   -- Signaux des flux de donn�es entrant et sortant sur les LS pour envoyer vers PCIe synchrone de clk_pcie
   SIGNAL data_pcie_rx1 : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donn�es � stocker en m�moire avant DMA
   SIGNAL val_pcie_rx1  : STD_LOGIC;                     -- Validant du bus data_store(signal write)
   SIGNAL sof_pcie_rx1  : STD_LOGIC;                     -- Indique un d�but de trame (nouvelle trame). Synchrone du 1er octet envoy�
   SIGNAL eof_pcie_rx1  : STD_LOGIC;                     -- Indique que la trame est finie (plus de donn�es � envoyer)
   SIGNAL crcok_pcie_rx1: STD_LOGIC;                     -- Indique que le CRC et le format est bon (sycnhrone de eof) 
   SIGNAL data_pcie_rx2 : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem pour RX2  
   SIGNAL val_pcie_rx2  : STD_LOGIC;                    
   SIGNAL sof_pcie_rx2  : STD_LOGIC;                    
   SIGNAL eof_pcie_rx2  : STD_LOGIC;                    
   SIGNAL crcok_pcie_rx2: STD_LOGIC;                     
   SIGNAL data_pcie_tx  : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem pour TX  
   SIGNAL val_pcie_tx   : STD_LOGIC;                    
   SIGNAL sof_pcie_tx   : STD_LOGIC;                    
   SIGNAL eof_pcie_tx   : STD_LOGIC;     
   
   -- Signaux de gestion du module d'acc�s � la PROM de cofniguration FPGA
   SIGNAL txprom_dat  : STD_LOGIC_VECTOR(7 downto 0);    -- Donn�e/commande � �crire
   SIGNAL txprom_val  : STD_LOGIC;                       -- Indique une donn�e disponible sur txprom_dat
   SIGNAL rxprom_dat  : STD_LOGIC_VECTOR(7 downto 0);    -- Donn�e lue dans la PROM
   SIGNAL rxprom_val  : STD_LOGIC;                       -- Indique une donn�e disponible sur rxprom_dat
   SIGNAL rxprom_next : STD_LOGIC;                       -- Demande une dnouvelle donn�e sur rxprom_dat
   SIGNAL prom_type_com: STD_LOGIC;                      -- D�finit le type de commande � ex�cuter (R ou W)
   SIGNAL prom_exec_com: STD_LOGIC;                      -- Lance l'ex�cution d'une commande d'acc�s � la PROM
   SIGNAL prom_busy   : STD_LOGIC;                       -- Indique que le module est occup�
   SIGNAL prom_nbread : STD_LOGIC_VECTOR(7 DOWNTO 0);    -- Nombre d 'octets � lire avec une commande de lecture
   SIGNAL prom_rstn   : STD_LOGIC;                       -- reset du module d'acc�s � la PROM

   COMPONENT if_pcie
   GENERIC
   (
      fast_train : BOOLEAN := FALSE;
      nbbit_add  : INTEGER := 13
   );
   PORT
   (
      pci_exp_txp : OUT STD_LOGIC;
      pci_exp_txn : OUT STD_LOGIC;
      pci_exp_rxp : IN  STD_LOGIC;
      pci_exp_rxn : IN  STD_LOGIC;

      sys_clk_p   : IN  STD_LOGIC;
      sys_clk_n   : IN  STD_LOGIC;
      sys_reset_n : IN  STD_LOGIC;

      dma_req     : IN  STD_LOGIC;
      dma_compl   : OUT STD_LOGIC;
      dma_ack     : OUT STD_LOGIC;
      dma_add_dest: IN  STD_LOGIC_VECTOR(31 downto 0);
      dma_data    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      dma_read    : OUT STD_LOGIC;
      dma_size    : IN  STD_LOGIC_VECTOR(7 downto 0);

      --Local Bus
      rd_addr     : OUT STD_LOGIC_VECTOR(nbbit_add-1 downto 0);
      rd_data     : IN STD_LOGIC_VECTOR(31 downto 0);
      rd_be       : OUT STD_LOGIC_VECTOR(3 downto 0);
      rd_en       : OUT STD_LOGIC;
      wr_addr     : OUT STD_LOGIC_VECTOR(nbbit_add-1 downto 0);
      wr_data     : OUT STD_LOGIC_VECTOR(31 downto 0);
      wr_be       : OUT STD_LOGIC_VECTOR(3 downto 0);
      wr_en       : OUT STD_LOGIC;  
      wr_busy     : IN STD_LOGIC;
      clk_local   : OUT STD_LOGIC;
      rst_local_n : OUT STD_LOGIC;
      link_up_n   : OUT STD_LOGIC
   );
   END COMPONENT;

   COMPONENT memory_map IS
   GENERIC (
      reg_version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10"
      );
   PORT (
      clk_sys        : IN  STD_LOGIC;
      rst_n          : IN  STD_LOGIC;
      iid            : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
      actif_passifn  : IN  STD_LOGIC;
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
      testpoint      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
   END COMPONENT;

   COMPONENT manage_dma
   PORT (
      clk_sys           : IN  STD_LOGIC;
      rst_n             : IN  STD_LOGIC;
      store_enable      : IN  STD_LOGIC;
      data_storerx1     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_storerx1      : IN  STD_LOGIC;                    
      sof_storerx1      : IN  STD_LOGIC;                    
      eof_storerx1      : IN  STD_LOGIC;                    
      crcok_storerx1    : IN  STD_LOGIC;                    
      data_storerx2     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); 
      val_storerx2      : IN  STD_LOGIC;                    
      sof_storerx2      : IN  STD_LOGIC;                    
      eof_storerx2      : IN  STD_LOGIC;                   
      crcok_storerx2    : IN  STD_LOGIC;                   
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
   
   COMPONENT con_communication_sil4
   PORT (
      clk_sys           : IN  STD_LOGIC;
      rst_n             : IN  STD_LOGIC;
      baudrate          : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
      actif             : IN  STD_LOGIC;
      ad_con            : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      top_cycle         : IN  STD_LOGIC;
      ena_filt_dble     : IN  STD_LOGIC;
      rx1               : IN  STD_LOGIC;
      tx1               : OUT STD_LOGIC;
      rx2               : IN  STD_LOGIC;
      tx2               : OUT STD_LOGIC;
      copy_ena1         : IN  STD_LOGIC;
      copy_ena2         : IN  STD_LOGIC;
      filt_rx1_uc1      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      filt_soc1_uc1     : OUT STD_LOGIC;
      filt_rd1_uc1      : IN  STD_LOGIC;
      filt_comdispo1_uc1: OUT STD_LOGIC;
      layer7_newframe1  : OUT STD_LOGIC;
      layer7_l2ok1      : OUT STD_LOGIC;
      layer7_overflow1  : OUT STD_LOGIC;
      filt_rx2_uc1      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      filt_soc2_uc1     : OUT STD_LOGIC;
      filt_rd2_uc1      : IN  STD_LOGIC;
      filt_comdispo2_uc1: OUT STD_LOGIC;
      layer7_newframe2  : OUT STD_LOGIC;
      layer7_l2ok2      : OUT STD_LOGIC;
      layer7_overflow2  : OUT STD_LOGIC;
      filt_rx1_uc2      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      filt_soc1_uc2     : OUT STD_LOGIC;
      filt_rd1_uc2      : IN  STD_LOGIC;
      filt_comdispo1_uc2: OUT STD_LOGIC;
      filt_rx2_uc2      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      filt_soc2_uc2     : OUT STD_LOGIC;
      filt_rd2_uc2      : IN  STD_LOGIC;
      filt_comdispo2_uc2: OUT STD_LOGIC;
      data_storerx1     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_storerx1      : OUT STD_LOGIC;
      sof_storerx1      : OUT STD_LOGIC;
      eof_storerx1      : OUT STD_LOGIC;
      crcok_storerx1    : OUT STD_LOGIC;
      data_storerx2     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_storerx2      : OUT STD_LOGIC;
      sof_storerx2      : OUT STD_LOGIC;
      eof_storerx2      : OUT STD_LOGIC;
      crcok_storerx2    : OUT STD_LOGIC;
      txdat_free        : OUT STD_LOGIC;         
      acq_stuf          : OUT STD_LOGIC;         
      tx_dat_uc1        : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_txdat_uc1     : IN  STD_LOGIC;
      tx_sof_uc1        : IN  STD_LOGIC;
      tx_eof_uc1        : IN  STD_LOGIC;
      clr_fifo_tx_uc1   : IN  STD_LOGIC;
      stuf_phys_uc1     : IN  STD_LOGIC;
      tx_available_uc1  : IN  STD_LOGIC;
      tx_commena_uc1    : OUT STD_LOGIC;
      tx_dat_uc2        : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_txdat_uc2     : IN  STD_LOGIC;
      tx_sof_uc2        : IN  STD_LOGIC;
      tx_eof_uc2        : IN  STD_LOGIC;
      clr_fifo_tx_uc2   : IN  STD_LOGIC;
      stuf_phys_uc2     : IN  STD_LOGIC;
      tx_available_uc2  : IN  STD_LOGIC;
      tx_commena_uc2    : OUT STD_LOGIC;
      tx_dat_pas       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_txdat_pas    : OUT STD_LOGIC;
      tx_sof_pas       : OUT STD_LOGIC;
      tx_eof_pas       : OUT STD_LOGIC     
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
      enafiltdble : OUT STD_LOGIC;
      lanscan_prg : OUT STD_LOGIC;                   
      lanscan_ack : IN  STD_LOGIC;                   
      new_sync_out: OUT STD_LOGIC;                   
      sync_out_ack: IN  STD_LOGIC;                   
      sync_num_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      new_sync_in : IN  STD_LOGIC;                   
      sync_in_ack : OUT STD_LOGIC;                   
      sync_num_in : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      invcrc_out  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      invcrc_in   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
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
      clr_fifo_tx : OUT STD_LOGIC;
      stuf_phys   : OUT STD_LOGIC;
      acq_stuf    : IN  STD_LOGIC;
      tx_available: OUT STD_LOGIC;
      tx_commena  : IN  STD_LOGIC;
      txprom_dat  : OUT STD_LOGIC_VECTOR(7 downto 0);
      txprom_val  : OUT STD_LOGIC; 
      rxprom_dat  : IN  STD_LOGIC_VECTOR(7 downto 0);
      rxprom_val  : IN  STD_LOGIC;
      rxprom_next : OUT STD_LOGIC;
      prom_type_com: OUT STD_LOGIC;
      prom_exec_com: OUT STD_LOGIC;
      prom_busy   : IN  STD_LOGIC;
      prom_nbread : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      prom_rstn   : OUT STD_LOGIC
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
      
   COMPONENT readmac
   GENERIC (
      sim_dna_value : STD_LOGIC_VECTOR(59 DOWNTO 0) :=  X"123456789ABCDEF");
   PORT (
      clk_sys  : IN  STD_LOGIC;
      rst_n    : IN  STD_LOGIC;
      mac      : OUT  STD_LOGIC_VECTOR(63 downto 0);
      mac_rdy  : OUT  STD_LOGIC
      );
   END COMPONENT;
   
   COMPONENT if_promspi
   GENERIC (
      div_rate    : INTEGER := 1;
      spiclk_freq : INTEGER := 10
      );
   PORT (
      clk_sys     : IN  STD_LOGIC;
      rst_n       : IN  STD_LOGIC;
      spi_csn     : OUT STD_LOGIC;
      spi_wpn     : OUT STD_LOGIC;
      spi_sdo     : OUT STD_LOGIC;
      spi_sdi     : IN  STD_LOGIC;
      spi_clk     : OUT STD_LOGIC;
      tx_dat      : IN  STD_LOGIC_VECTOR(7 downto 0);
      tx_val      : IN  STD_LOGIC; 
      rx_dat      : OUT STD_LOGIC_VECTOR(7 downto 0);
      rx_val      : OUT STD_LOGIC;
      rx_next     : IN  STD_LOGIC;
      type_com    : IN  STD_LOGIC;
      exec_com    : IN  STD_LOGIC;
      spi_busy    : OUT STD_LOGIC;
      nb_read     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
   END COMPONENT;
    
BEGIN
   ---------------------------------------------------
   -- Gestion des interfaces syst�me
   ---------------------------------------------------
   rst_switchn <= '1';  					      -- Pas de reset switch lors d'un reset FPGA par le PIC pour �viter � la passerelle de perdre le r�seau
   rst_picn <= rstfpga_uc1n OR rstfpga_uc2n; -- Le FPGA est resett� si les 2 PIC sont en reset
   rst_dcm <= NOT(rst_picn);                 -- Le reset DCM est actif � '1'
   

   DCM_SP_inst : DCM_SP
   generic map (
      CLKDV_DIVIDE => 16.0,                  -- CLKDV divide value
                                             -- (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
      CLKFX_DIVIDE => 1,                     -- Divide value on CLKFX outputs - D - (1-32)
      CLKFX_MULTIPLY => 4,                   -- Multiply value on CLKFX outputs - M - (2-32)
      CLKIN_DIVIDE_BY_2 => FALSE,            -- CLKIN divide by two (TRUE/FALSE)
      CLKIN_PERIOD => 41.7,                  -- Input clock period specified in nS
      CLKOUT_PHASE_SHIFT => "NONE",          -- Output phase shift (NONE, FIXED, VARIABLE)
      CLK_FEEDBACK => "2X",                  -- Feedback source (NONE, 1X, 2X)
      DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", -- SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      DFS_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DLL_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DSS_MODE => "NONE",                    -- Unsupported - Do not change value
      DUTY_CYCLE_CORRECTION => TRUE,         -- Unsupported - Do not change value
      FACTORY_JF => X"c080",                 -- Unsupported - Do not change value
      PHASE_SHIFT => 0,                      -- Amount of fixed phase shift (-255 to 255)
      STARTUP_WAIT => FALSE                  -- Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
   )
   port map (
      CLK0 => OPEN,           -- 1-bit output: 0 degree clock output
      CLK180 => OPEN,         -- 1-bit output: 180 degree clock output
      CLK270 => OPEN,         -- 1-bit output: 270 degree clock output
      CLK2X => clk_48,        -- 1-bit output: 2X clock frequency clock output
      CLK2X180 => OPEN,       -- 1-bit output: 2X clock frequency, 180 degree clock output
      CLK90 => OPEN,          -- 1-bit output: 90 degree clock output
      CLKDV => clk_dna,       -- 1-bit output: Divided clock output
      CLKFX => clk_96,        -- 1-bit output: Digital Frequency Synthesizer output (DFS)
      CLKFX180 => OPEN,       -- 1-bit output: 180 degree CLKFX output
      LOCKED => dcm_locked,   -- 1-bit output: DCM_SP Lock Output
      PSDONE => OPEN,         -- 1-bit output: Phase shift done output
      STATUS => OPEN,         -- 8-bit output: DCM_SP status output
      CLKFB => clk_sys,       -- 1-bit input: Clock feedback input
      CLKIN => clk_24,        -- 1-bit input: Clock input
      DSSEN => '0',           -- 1-bit input: Unsupported, specify to GND.
      PSCLK => '0',           -- 1-bit input: Phase shift clock input
      PSEN => '0',            -- 1-bit input: Phase shift enable
      PSINCDEC => '0',        -- 1-bit input: Phase shift increment/decrement input
      RST => rst_dcm          -- 1-bit input: Active high reset input
   );
   
   BUFG_inst : BUFG
   port map (
      O => clk_sys, 
      I => clk_48 
   );

   --Resynhcronisation du signal DCM_LOCKED sur clk_dna
   PROCESS (clk_dna, rst_picn)
   BEGIN
      IF (rst_picn = '0') THEN
         rstdna_n <= '0';
      ELSIF (clk_dna'EVENT AND clk_dna = '1') THEN
         rstdna_n <= dcm_locked;
      END IF;
   END PROCESS;

   --Compteur en free running pour la LED OK � 2Hz
   PROCESS (clk_24)
   BEGIN
      IF (clk_24'EVENT AND clk_24 = '1') THEN
         cpt_blink <= cpt_blink + 1;
      END IF;
   END PROCESS;
   
   led_fail <= NOT(repli);                   -- quand repli = '1' on affiche du rouge fixe
   led_run  <= '1' WHEN (repli = '1') ELSE   -- Si repli = '0' on affiche du vert � 2Hz
               cpt_blink(cpt_blink'LEFT);    -- P�riode de la led run � 700ms
   led_confok <= '0';                        -- D�s que le FPGA est configur� on allume la LED verte 

   -----------------------------------------------
   -- Instantiation du module de r�cup�ration de l'@ IID
   -----------------------------------------------
   inst_readiid : readmac
   GENERIC MAP(
      sim_dna_value => X"123456789ABCDEF")
   PORT MAP (
      clk_sys  => clk_dna,    -- Utilise une horloge � 2MHz MAX
      rst_n    => rstdna_n,
      mac      => iid,
      mac_rdy  => iid_rdy
      );

   --Resynhcronisation du signal IID_RDY sur clk_96
   PROCESS (clk_96, rst_picn)
   BEGIN
      IF (rst_picn = '0') THEN
         rst96_n <= '0';
      ELSIF (clk_96'EVENT AND clk_96 = '1') THEN
         rst96_n <= iid_rdy;
      END IF;
   END PROCESS;

   ------------------------------
   -- Instantiation du module PCIe
   ------------------------------
   inst_pcieif : if_pcie
   GENERIC MAP (
      nbbit_add => NBBIT_ADD_LOCAL
      )
   PORT MAP(
      pci_exp_txp => pci_exp_txp,
      pci_exp_txn => pci_exp_txn,
      pci_exp_rxp => pci_exp_rxp,
      pci_exp_rxn => pci_exp_rxn,
      sys_clk_p   => pci_clk_p,
      sys_clk_n   => pci_clk_n,
      -- Le GPIO pci_rstn est mal g�r� par la passerelle. On utlise en gusie de reset un signal avec une pull up externe.
      sys_reset_n => ext_pull,		--pci_rstn,
      dma_req     => dma_req,
      dma_compl   => dma_compl,
      dma_ack     => dma_ack,
      dma_add_dest=> dma_add_dest,
      dma_data    => dma_data,
      dma_read    => dma_read,
      dma_size    => dma_size,
      rd_addr     => rd_addr,
      rd_data     => rd_data,
      rd_be       => rd_be,
      rd_en       => rd_en,
      wr_addr     => wr_addr,
      wr_data     => wr_data,
      wr_be       => wr_be,
      wr_en       => wr_en,
      wr_busy     => wr_busy,
      clk_local   => clk_pcie,
      rst_local_n => rstpcie_n,
      link_up_n   => link_up_n
   );
   pci_waken <= '0';
   
   ------------------------------
   -- Instantiation du module mapping m�moire
   ------------------------------
   PROCESS (clk_pcie, rstpcie_n)
   BEGIN
      IF (rstpcie_n = '0') THEN
         cpy_r1 <= '1';
         cpy_r2 <= '1';         
         actif_passifn <= '1';
      ELSIF (clk_pcie'EVENT AND clk_pcie = '1') THEN
         cpy_r1 <= NOT(cpy1 AND cpy2);
         cpy_r2 <= cpy_r1;
         actif_passifn <= cpy_r2;
      END IF;
   END PROCESS;

   inst_mem : memory_map
   GENERIC MAP(
      reg_version => reg_version)
   PORT MAP (
      clk_sys        => clk_pcie,
      rst_n          => rstpcie_n,
      iid            => iid,
      actif_passifn  => actif_passifn,
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
		clk_96			=> clk_96,
      testpoint      => OPEN --spare
   );
   
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
      dma_base_pa    => dma_base_pa,
      dma_timestamp  => dma_timestamp
   ); 

   -----------------------------------------------
   -- Instantiation du module de communication
   -----------------------------------------------
   -- Les 2 drivers RS485 sont toujours autoris�s � �mettre
   ls485_de1 <= '1';
   ls485_de2 <= '1';
   -- Les 2 drivers RS485 sont toujorus autoris�s � recevoir
   ls485_ren1 <= '0';
   ls485_ren2 <= '0';

   inst_comm : con_communication_sil4 
   PORT MAP (
      clk_sys           => clk_96,
      rst_n             => rst96_n,
      baudrate          => baudrate,
      actif             => actif,
      ad_con            => tid,
      top_cycle         => topcyc,
      ena_filt_dble     => ena_filt_dble,
      rx1               => ls485_rx1,
      tx1               => ls485_tx1,
      rx2               => ls485_rx2,
      tx2               => ls485_tx2,
      copy_ena1         => cpy1,
      copy_ena2         => cpy2,
      filt_rx1_uc1      => filt_rx1_uc1,
      filt_soc1_uc1     => filt_soc1_uc1,
      filt_rd1_uc1      => filt_rd1_uc1,
      filt_comdispo1_uc1=> filt_comdispo1_uc1,
      layer7_newframe1  => l7_newframe1,
      layer7_l2ok1      => l7_l2ok1,
      layer7_overflow1  => l7_overflow1,
      filt_rx2_uc1      => filt_rx2_uc1,
      filt_soc2_uc1     => filt_soc2_uc1,
      filt_rd2_uc1      => filt_rd2_uc1,
      filt_comdispo2_uc1=> filt_comdispo2_uc1,
      layer7_newframe2  => l7_newframe2,
      layer7_l2ok2      => l7_l2ok2,
      layer7_overflow2  => l7_overflow2,
      filt_rx1_uc2      => filt_rx1_uc2,
      filt_soc1_uc2     => filt_soc1_uc2,
      filt_rd1_uc2      => filt_rd1_uc2,
      filt_comdispo1_uc2=> filt_comdispo1_uc2,
      filt_rx2_uc2      => filt_rx2_uc2,
      filt_soc2_uc2     => filt_soc2_uc2,
      filt_rd2_uc2      => filt_rd2_uc2,
      filt_comdispo2_uc2=> filt_comdispo2_uc2,
      data_storerx1     => data_storerx1,
      val_storerx1      => val_storerx1,
      sof_storerx1      => sof_storerx1,
      eof_storerx1      => eof_storerx1,
      crcok_storerx1    => crcok_storerx1,
      data_storerx2     => data_storerx2,
      val_storerx2      => val_storerx2,
      sof_storerx2      => sof_storerx2,
      eof_storerx2      => eof_storerx2,
      crcok_storerx2    => crcok_storerx2,
      txdat_free        => txdat_free,
      acq_stuf          => acq_stuf,
      tx_dat_uc1        => tx_dat_uc1,
      val_txdat_uc1     => val_txdat_uc1,
      tx_sof_uc1        => tx_sof_uc1,
      tx_eof_uc1        => tx_eof_uc1,
      clr_fifo_tx_uc1   => clr_fifo_tx_uc1,
      stuf_phys_uc1     => stuf_phys_uc1,
      tx_available_uc1  => tx_available_uc1,
      tx_commena_uc1    => tx_commena_uc1,
      tx_dat_uc2        => tx_dat_uc2,
      val_txdat_uc2     => val_txdat_uc2,
      tx_sof_uc2        => tx_sof_uc2,
      tx_eof_uc2        => tx_eof_uc2,
      clr_fifo_tx_uc2   => clr_fifo_tx_uc2,
      stuf_phys_uc2     => stuf_phys_uc2,
      tx_available_uc2  => tx_available_uc2,
      tx_commena_uc2    => tx_commena_uc2,
      tx_dat_pas        => tx_dat,
      val_txdat_pas     => val_txdat,
      tx_sof_pas        => tx_sof,
      tx_eof_pas        => tx_eof
   );

   -----------------------------------------------
   -- Instantiation du module d'interface PIC PMP 1
   -----------------------------------------------
   topcyc <= topcyc1 OR topcyc2;
   inst_pic1 : if_picpmp
   GENERIC MAP (
      version => reg_version)
   PORT MAP (
      clk_sys      => clk_96,
      rst_n        => rst96_n,
      pmd          => pmd_uc1,
      pmall        => pmall_uc1,
      pmalh        => pmalh_uc1,
      pmrd         => pmrd_uc1,
      pmwr         => pmwr_uc1,
      iid          => iid,
		tid          => tid,
      cpy1         => cpy1,
      cpy2         => cpy2,
      repli        => repli,
      baudrate     => baudrate,
      actif        => actif,
      topcyc       => topcyc1,
      enafiltdble  => ena_filt_dble,
      lanscan_prg  => lanscan1,
      lanscan_ack  => lanscan2,
      new_sync_out => synchro1,
      sync_out_ack => ack_synchro1,
      sync_num_out => sync_num1,
      new_sync_in  => synchro2,
      sync_in_ack  => ack_synchro2,
      sync_num_in  => sync_num2,
      invcrc_out   => invcrc1,
      invcrc_in    => invcrc2,
      l7_rx1       => filt_rx1_uc1,
      l7_soc1      => filt_soc1_uc1,
      l7_rd1       => filt_rd1_uc1,
      l7_comdispo1 => filt_comdispo1_uc1,
      l7_newframe1 => l7_newframe1,
      l7_l2ok1     => l7_l2ok1,
      l7_overflow1 => l7_overflow1,
      l7_rx2       => filt_rx2_uc1,
      l7_soc2      => filt_soc2_uc1,
      l7_rd2       => filt_rd2_uc1,
      l7_comdispo2 => filt_comdispo2_uc1,
      l7_newframe2 => l7_newframe2,
      l7_l2ok2     => l7_l2ok2,
      l7_overflow2 => l7_overflow2,
      tx_dat       => tx_dat_uc1,
      val_txdat    => val_txdat_uc1,
      tx_sof       => tx_sof_uc1,
      tx_eof       => tx_eof_uc1,
      txdat_free   => txdat_free,
      clr_fifo_tx  => clr_fifo_tx_uc1,
      stuf_phys    => stuf_phys_uc1,
      acq_stuf     => acq_stuf,
      tx_available => tx_available_uc1,
      tx_commena   => tx_commena_uc1,
		txprom_dat   => txprom_dat,
      txprom_val   => txprom_val,
      rxprom_dat   => rxprom_dat,
      rxprom_val   => rxprom_val,
      rxprom_next  => rxprom_next,
      prom_type_com=> prom_type_com,
      prom_exec_com=> prom_exec_com,
      prom_busy    => prom_busy,
      prom_nbread  => prom_nbread,
      prom_rstn    => prom_rstn
      );

   -----------------------------------------------
   -- Instantiation du module d'interface PIC PMP 2
   -----------------------------------------------
   cmd_fpga_pmp2 <= NOT(pmrd_uc2);  -- On autorise l'ADUM � nous fournir ses donn�es tout le temps, sauf en rd ou le FPGA drive le PMD
   --cmd_fpga_pmp2 <=(pmrd_uc2);  
	inst_pic2 : if_picpmp
   GENERIC MAP (
      version => reg_version)
   PORT MAP (
      clk_sys      => clk_96,
      rst_n        => rst96_n,
      pmd          => pmd_uc2,
      pmall        => pmall_uc2,
      pmalh        => pmalh_uc2,
      pmrd         => pmrd_uc2,
      pmwr         => pmwr_uc2,
      iid          => iid,
		tid          => OPEN,
      cpy1         => OPEN,
      cpy2         => OPEN,
      repli        => OPEN,
      baudrate     => OPEN,
      actif        => OPEN,
      topcyc       => topcyc2,
      enafiltdble  => OPEN,		
      lanscan_prg  => lanscan2,
      lanscan_ack  => lanscan1,
      new_sync_out => synchro2,
      sync_out_ack => ack_synchro2,
      sync_num_out => sync_num2,
      new_sync_in  => synchro1,
      sync_in_ack  => ack_synchro1,
      sync_num_in  => sync_num1,
      invcrc_out   => invcrc2,
      invcrc_in    => invcrc1,      
      l7_rx1       => filt_rx1_uc2,
      l7_soc1      => filt_soc1_uc2,
      l7_rd1       => filt_rd1_uc2,
      l7_comdispo1 => filt_comdispo1_uc2,
      l7_newframe1 => l7_newframe1,
      l7_l2ok1     => l7_l2ok1,
      l7_overflow1 => l7_overflow1,
      l7_rx2       => filt_rx2_uc2,
      l7_soc2      => filt_soc2_uc2,
      l7_rd2       => filt_rd2_uc2,
      l7_comdispo2 => filt_comdispo2_uc2,
      l7_newframe2 => l7_newframe2,
      l7_l2ok2     => l7_l2ok2,
      l7_overflow2 => l7_overflow2,
      tx_dat       => tx_dat_uc2,
      val_txdat    => val_txdat_uc2,
      tx_sof       => tx_sof_uc2,
      tx_eof       => tx_eof_uc2,
      txdat_free   => txdat_free,
      clr_fifo_tx  => clr_fifo_tx_uc2,
      stuf_phys    => stuf_phys_uc2,
      acq_stuf     => acq_stuf,
      tx_available => tx_available_uc2,
      tx_commena   => tx_commena_uc2,
		txprom_dat   => OPEN,
      txprom_val   => OPEN,
      rxprom_dat   => x"00",
      rxprom_val   => '0',
      rxprom_next  => OPEN,
      prom_type_com=> OPEN,
      prom_exec_com=> OPEN,
      prom_busy    => '0',
      prom_nbread  => OPEN,
      prom_rstn    => OPEN
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

   inst_chgclk_tx : flux_chgclk
   PORT MAP(
      clks     => clk_96,
      clkd     => clk_pcie,
      rst_n    => rst96_n,
      datas    => tx_dat,
      vals     => val_txdat,
      sofs     => tx_sof,
      eofs     => tx_eof,
      crcoks   => '1',
      datad    => data_pcie_tx,
      vald     => val_pcie_tx,
      sofd     => sof_pcie_tx,
      eofd     => eof_pcie_tx,
      crcokd   => OPEN
      );

   -----------------------------------------------
   -- Instantiation du module d'interface SPI de programmation de la PROM
   -----------------------------------------------
   int_promspi :  if_promspi
   GENERIC MAP(
      div_rate    => 3,          -- Diviseur de l'horlgoe syst�me
      spiclk_freq => 12          -- Fr�quence de l'horlgoe du SPI
      )
   PORT MAP(
      clk_sys     => clk_96,
      rst_n       => prom_rstn,
      spi_csn     => cso_b,
      spi_wpn     => wp_flashn,
      spi_sdo     => mosi,
      spi_sdi     => din_miso,
      spi_clk     => cclk,
      tx_dat      => txprom_dat,
      tx_val      => txprom_val,
      rx_dat      => rxprom_dat,
      rx_val      => rxprom_val,
      rx_next     => rxprom_next,
      type_com    => prom_type_com,
      exec_com    => prom_exec_com,
      spi_busy    => prom_busy,
      nb_read     => prom_nbread
      ); 

   ---------------------------------------
   -- Compteur en free running pour la g�n�ration � 300KHz de la commande des alims isol�es des RS
   ---------------------------------------
   PROCESS (clk_24)
   BEGIN
      IF (clk_24'EVENT AND clk_24 = '1') THEN
         IF (cpt_cde = CONV_STD_LOGIC_VECTOR(41, cpt_cde'LENGTH)) THEN
         -- A la demi p�riode (i.e = 42 x 40ns)
            cpt_cde <= (OTHERS => '0');  
            cde_high <= '0';              -- Commande directe
            cde_low <= '0';               -- Commande � 180�
            toggle_cde <= NOT(toggle_cde);
         ELSE
            cpt_cde <= cpt_cde + 1;
            IF (cpt_cde = CONV_STD_LOGIC_VECTOR(0, cpt_cde'LENGTH)) THEN
               cde_high <= toggle_cde;
               cde_low <= NOT(toggle_cde);               
            END IF;
         END IF;
      END IF;
   END PROCESS;
   cdehigh_5vid   <= cde_high;
   cdelow_5vid    <= cde_low;
   cdehigh_5vls1  <= cde_high;
   cdelow_5vls1   <= cde_low;
   cdehigh_5vls2  <= cde_high;
   cdelow_5vls2   <= cde_low;
   cdehigh_5vlsm2 <= cde_high;
   cdelow_5vlsm2  <= cde_low;
   cdehigh_5vcan  <= cde_high;
   cdelow_5vcan   <= cde_low;

   ----------------------------------------
   -- Signaux Spare
   ----------------------------------------
   uc_pmd   <= (OTHERS => 'Z');
   pic_tx   <= 'Z';
   pic_sdo  <= 'Z';
   tp(27)   <= pic_ssn OR pic_sdi OR pic_sck OR pic_spare_uc1(0) OR pic_spare_uc1(1) OR pic_spare_uc1(2) OR pic_spare_uc1(3) OR
               pic_spare_uc2(4) OR pic_spare_uc2(3) OR pic_spare_uc2(2) OR
               pic_rx OR uc_sdo OR uc_sdi OR uc_ssn OR uc_sck OR uc_pmacs2 OR uc_pmacs1 OR uc_pmalh OR uc_pmall OR
               uc_pmwr OR uc_pmrd OR pci_spare OR prog_b OR interrupt OR power_rstn;
   tp(26 DOWNTO 21) <= (OTHERS => '0');

END rtl;

