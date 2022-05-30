--============================================================================= 
--  TITRE : TOP_MIOSIL2
--  DESCRIPTION : 
--        Module TOP du FPGA MIO SIL2
--
--  FICHIER :        top_miosil2.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION
--  18/09/14   DRA      SATURN   1.1
--    Evolution du module con_communication 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

ENTITY top_miosil2 IS
   GENERIC (
      reg_version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"11"    -- Version du firmware
      );
   PORT (
      -- Ports système
      clk_24      : IN  STD_LOGIC;     -- Clock principale à 24MHz
      rst_n       : IN  STD_LOGIC;     -- Reset principal de la carte
      rst_fpgan   : IN  STD_LOGIC;     -- Reset issu du PIC32
      led_confok  : OUT STD_LOGIC;     -- Pilotage de la led rouge
      led_run     : OUT STD_LOGIC;     -- Pilotage de la 1ère LED verte
      led_fail    : OUT STD_LOGIC;     -- Pilotage de la 2ème LED verte
      power_rstn  : IN  STD_LOGIC;     -- Indique que l'alim 3.3V du PIC est coupée
   
      -- Interfaces ports séries
      ls485_de1   : OUT STD_LOGIC;     -- Signal d'autorisation à émettre de la LS1
      ls485_ren1  : OUT STD_LOGIC;     -- Signal d'autorisation à émettre de la LS1
      ls485_rx1   : IN  STD_LOGIC;     -- Signal de réception de la LS1
      ls485_tx1   : OUT STD_LOGIC;     -- Signal d'émission de la LS1

      ls485_de2   : OUT STD_LOGIC;     -- Signal d'autorisation à émettre de la LS2
      ls485_ren2  : OUT STD_LOGIC;     -- Signal d'autorisation à émettre de la LS2
      ls485_rx2   : IN  STD_LOGIC;     -- Signal de réception de la LS2
      ls485_tx2   : OUT STD_LOGIC;     -- Signal d'émission de la LS2

      -- Interface SPI (Interface PIC)
      pic_sclk    : IN  STD_LOGIC;
      pic_sdi     : OUT STD_LOGIC;
      pic_sdo     : IN  STD_LOGIC;
      pic_ssn     : IN  STD_LOGIC;

      -- Interface de pilotage des Alim isolées
      cdehigh_5vid   : OUT STD_LOGIC;
      cdelow_5vid    : OUT STD_LOGIC;
      cdehigh_5vls1  : OUT STD_LOGIC;
      cdelow_5vls1   : OUT STD_LOGIC;
      cdehigh_5vls2  : OUT STD_LOGIC;
      cdelow_5vls2   : OUT STD_LOGIC;

      -- Interface SPI (programmation de la flash de configuration)
      wp_flashn      : OUT STD_LOGIC;     -- Autorisation d'écriture dans la flash SPI
      cclk           : OUT STD_LOGIC;     -- Horloge d'accès à la flash SPI
      din_miso       : IN  STD_LOGIC;     -- Data série en lecture SPI
      mosi           : OUT STD_LOGIC;     -- Data série en écriture SPI
      cso_b          : OUT STD_LOGIC;     -- Chip select SPI
      
      -- Spare et RFU
      cde_diag1      : IN STD_LOGIC;
      cde_diag2      : IN STD_LOGIC;
      pic_tx         : IN STD_LOGIC;
      pic_rx         : OUT STD_LOGIC;
      pic_spare      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      prog_b         : IN  STD_LOGIC;
      pic_refclki    : IN  STD_LOGIC;
      tp7            : OUT STD_LOGIC;
      tp8            : OUT STD_LOGIC;
      tp9            : OUT STD_LOGIC;
      spare          : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
END top_miosil2;

ARCHITECTURE rtl of top_miosil2 is
   -- signaux utilisés pour les fonctions systèmes
   SIGNAL clk_sys        : STD_LOGIC:= '0';      -- Horloge système = 2 x clk_24
   SIGNAL clk_48         : STD_LOGIC:= '0';      -- Pour récupérer l'horloge CLKx2 à la sortie du DCM
   SIGNAL clk_96         : STD_LOGIC:= '0';      -- Pour récupérer l'horloge CLKFX à la sortie du DCM
   SIGNAL clk_dna        : STD_LOGIC:= '0';      -- Horloge à 1 MHz pour lire le DNA
   SIGNAL rst_dcm        : STD_LOGIC:= '0';      -- Signal de reset du DCM
   SIGNAL rstdna_n       : STD_LOGIC:= '0';      -- reset resynchronisé sur clk_dna
   SIGNAL rst96_n        : STD_LOGIC:= '0';      -- reset resynchronisé sur clk96
   SIGNAL dcm_locked     : STD_LOGIC:= '0';      -- Signal de lock du DCM
   SIGNAL cpt_blink      : STD_LOGIC_VECTOR(23 DOWNTO 0); -- Compteur pour le blink de la led run
   SIGNAL iid            : STD_LOGIC_VECTOR(63 DOWNTO 0); -- Valeur DNA du FPGA
   SIGNAL iid_rdy        : STD_LOGIC;            -- Indique que le IID a été récupéré

   -- Signaux d'interface entre le module de communication et le module SPI PIC
   SIGNAL tid         : STD_LOGIC_VECTOR(7 DOWNTO 0); -- TID que la COM doit utiliser pour ce MIO
   SIGNAL cpy1        : STD_LOGIC;              -- Autorise la copie du port 1 sur le port 2
   SIGNAL cpy2        : STD_LOGIC;              -- Autorise la copie du port 2 sur le port 1
   SIGNAL repli       : STD_LOGIC;              -- Indique que le MIO est en mode repli
   -- Interface de gestion des données applicatives reçues sur le port 1
   SIGNAL l7_rx1      : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Dbus de onnées extraites de la trame
   SIGNAL l7_soc1     : STD_LOGIC;              -- Indique un début de trame
   SIGNAL l7_rd1      : STD_LOGIC;              -- Demande une donnée applicative de plus
   SIGNAL l7_comdispo1: STD_LOGIC;              -- Indique que des données applicatives sont en attentes
   SIGNAL l7_newframe1: STD_LOGIC;              -- Indique la réception d'une nouvelle trame
   SIGNAL l7_l2ok1    : STD_LOGIC;              -- Indique que la trame reçu est correcte (format + CRC)
   SIGNAL l7_overflow1: STD_LOGIC;              -- Indique que la mémoire de stockage a débordé
   SIGNAL activity1   : STD_LOGIC;              -- Indique du trafic sur le port 1
   -- Interface de gestion des données applicatives reçues sur le port 2
   SIGNAL l7_rx2      : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Idem
   SIGNAL l7_soc2     : STD_LOGIC;
   SIGNAL l7_rd2      : STD_LOGIC;
   SIGNAL l7_comdispo2: STD_LOGIC;
   SIGNAL l7_newframe2: STD_LOGIC;
   SIGNAL l7_l2ok2    : STD_LOGIC;
   SIGNAL l7_overflow2: STD_LOGIC;
   SIGNAL activity2   : STD_LOGIC;
   -- Interface de gestion des données applicatives à transmettre
   SIGNAL tx_dat      : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Bis de données applicatives
   SIGNAL val_txdat   : STD_LOGIC;              -- Indique une donnée valide sur tx_dat
   SIGNAL tx_sof      : STD_LOGIC;              -- Indique un début de trame à transmettre
   SIGNAL tx_eof      : STD_LOGIC;              -- Indique une fin de trame à transmettre
   SIGNAL txdat_free  : STD_LOGIC;              -- Indique que le module transport en tx est dispo
   SIGNAL clr_fifo_tx : STD_LOGIC;              -- Permet d'effacer la FIFO d'emission
   -- Signaux de gestion de l'interface SPI
   SIGNAL sclk        : STD_LOGIC;
   SIGNAL sdi         : STD_LOGIC;
   SIGNAL sdo         : STD_LOGIC;
   SIGNAL ssn         : STD_LOGIC;

   -- Signaux de gestion du module d'accès à la PROM de cofniguration FPGA
   SIGNAL txprom_dat  : STD_LOGIC_VECTOR(7 downto 0); -- Donnée/commande à écrire
   SIGNAL txprom_val  : STD_LOGIC;                    -- Indique une donnée disponible sur txprom_dat
   SIGNAL rxprom_dat  : STD_LOGIC_VECTOR(7 downto 0); -- Donnée lue dans la PROM
   SIGNAL rxprom_val  : STD_LOGIC;                    -- Indique une donnée disponible sur rxprom_dat
   SIGNAL rxprom_next : STD_LOGIC;                    -- Demande une dnouvelle donnée sur rxprom_dat
   SIGNAL prom_type_com: STD_LOGIC;                   -- Définit le type de commande à exécuter (R ou W)
   SIGNAL prom_exec_com: STD_LOGIC;                   -- Lance l'exécution d'une commande d'accès à la PROM
   SIGNAL prom_busy   : STD_LOGIC;                    -- Indique que le module est occupé
   SIGNAL prom_nbread : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Nombre d 'octets à lire avec une commande de lecture
   SIGNAL prom_rstn   : STD_LOGIC;                    -- reset du module d'accès à la PROM
 
   -- Pilotage des Alims (PWM)
   SIGNAL cpt_cde       : STD_LOGIC_VECTOR(5 DOWNTO 0);  -- Compteur pour générer les pulses de commande des alims isolées
   SIGNAL toggle_cde    : STD_LOGIC;                  -- Pour savoir quelle voie de la commadne alim est active
   SIGNAL cde_high      : STD_LOGIC;                  -- Signal de pilotage MOSFET
   SIGNAL cde_low       : STD_LOGIC;                  -- Signal de piltoage MOSFET

   COMPONENT communication_sil 
   PORT (
      clk_sys        : IN  STD_LOGIC;
      rst_n          : IN  STD_LOGIC;
      ad_mio         : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
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
      activity1        : OUT STD_LOGIC;
      layer7_rx2       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      layer7_soc2      : OUT STD_LOGIC;
      layer7_rd2       : IN  STD_LOGIC;
      layer7_newframe2 : OUT STD_LOGIC;
      layer7_comdispo2 : OUT STD_LOGIC;
      layer7_l2ok2     : OUT STD_LOGIC;
      layer7_overflow2 : OUT STD_LOGIC;
      activity2        : OUT STD_LOGIC;
      tx_dat           : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_txdat        : IN  STD_LOGIC;
      tx_sof           : IN  STD_LOGIC;
      tx_eof           : IN  STD_LOGIC;
      txdat_free       : OUT STD_LOGIC;
      clr_fifo_tx      : IN  STD_LOGIC
      );
   END COMPONENT;

   COMPONENT readmac
   GENERIC (
      sim_dna_value : STD_LOGIC_VECTOR(59 DOWNTO 0) :=  X"023456789ABCDEF");
   PORT (
      clk_sys  : IN  STD_LOGIC;  
      rst_n    : IN  STD_LOGIC;  
      mac      : OUT  STD_LOGIC_VECTOR(63 downto 0);
      mac_rdy  : OUT  STD_LOGIC 
      );
   END COMPONENT;

   COMPONENT if_picspi
   GENERIC (
      version : STD_LOGIC_VECTOR(7 DOWNTO 0));
   PORT (
      clk_sys  : IN  STD_LOGIC;
      rst_n    : IN  STD_LOGIC;
      sclk     : IN  STD_LOGIC;
      sdi      : IN  STD_LOGIC;
      sdo      : OUT STD_LOGIC;
      ssn      : IN  STD_LOGIC;
      iid      : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
      tid      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      cpy1     : OUT STD_LOGIC;
      cpy2     : OUT STD_LOGIC;
      repli        : OUT STD_LOGIC;
      l7_rx1       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      l7_soc1      : IN  STD_LOGIC;
      l7_rd1       : OUT STD_LOGIC;
      l7_comdispo1 : IN  STD_LOGIC;
      l7_newframe1 : IN  STD_LOGIC;
      l7_l2ok1     : IN  STD_LOGIC;
      l7_overflow1 : IN  STD_LOGIC;
      activity1    : IN  STD_LOGIC;      
      l7_rx2       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      l7_soc2      : IN  STD_LOGIC;
      l7_rd2       : OUT STD_LOGIC;
      l7_comdispo2 : IN  STD_LOGIC;
      l7_newframe2 : IN  STD_LOGIC;
      l7_l2ok2     : IN  STD_LOGIC;
      l7_overflow2 : IN  STD_LOGIC;
      activity2    : IN  STD_LOGIC;
      tx_dat       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_txdat    : OUT STD_LOGIC;
      tx_sof       : OUT STD_LOGIC;
      tx_eof       : OUT STD_LOGIC;
      txdat_free   : IN  STD_LOGIC;
      clr_fifo_tx  : OUT STD_LOGIC;
      txprom_dat   : OUT STD_LOGIC_VECTOR(7 downto 0);
      txprom_val   : OUT STD_LOGIC; 
      rxprom_dat   : IN  STD_LOGIC_VECTOR(7 downto 0);
      rxprom_val   : IN  STD_LOGIC;
      rxprom_next  : OUT STD_LOGIC;
      prom_type_com: OUT STD_LOGIC;
      prom_exec_com: OUT STD_LOGIC;
      prom_busy    : IN  STD_LOGIC;
      prom_nbread  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      prom_rstn    : OUT STD_LOGIC
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
   -- Gestion des interfaces système
   ---------------------------------------------------
   rst_dcm <= NOT(rst_fpgan);                -- Le reset généré par le PIC déclenche un reset général

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
   PROCESS (clk_dna, rst_fpgan)
   BEGIN
      IF (rst_fpgan = '0') THEN
         rstdna_n <= '0';
      ELSIF (clk_dna'EVENT AND clk_dna = '1') THEN
         rstdna_n <= dcm_locked;
      END IF;
   END PROCESS;
   
   --Compteur en free running pour la LED OK à 2Hz
   PROCESS (clk_24)
   BEGIN
      IF (clk_24'EVENT AND clk_24 = '1') THEN
         cpt_blink <= cpt_blink + 1;
      END IF;
   END PROCESS;
   
   led_fail <= NOT(repli);                   -- quand repli = '1' on affiche du rouge fixe
   led_run  <= '1' WHEN (repli = '1') ELSE   -- Si repli = '0' on affiche du vert à 2Hz
               cpt_blink(cpt_blink'LEFT);    -- Période de la led run à 700ms
   led_confok <= '0';                        -- Dès que le FPGA est configuré on allume la LED verte 

   -----------------------------------------------
   -- Instantiation du module de récupération de l'@ IID
   -----------------------------------------------
   inst_readiid : readmac
   GENERIC MAP(
      sim_dna_value => X"123456789ABCDEF")
   PORT MAP (
      clk_sys  => clk_dna,    -- Utilise une horloge à 2MHz MAX
      rst_n    => rstdna_n,   -- Autorisé dès que la DCM est lockée
      mac      => iid,
      mac_rdy  => iid_rdy
      );

   --Resynhcronisation sur l'horloge à 96MHz
   PROCESS (clk_96, rst_fpgan)
   BEGIN
      IF (rst_fpgan = '0') THEN
         rst96_n <= '0';
      ELSIF (clk_96'EVENT AND clk_96 = '1') THEN
         rst96_n <= iid_rdy;
      END IF;
   END PROCESS;      
   
   -----------------------------------------------
   -- Instantiation du module de communication
   -----------------------------------------------
   -- Les 2 drivers RS485 sont toujours autorisés à émettre
   ls485_de1 <= '1';
   ls485_de2 <= '1';
   -- Les 2 drivers RS485 sont toujours autorisés à recevoir
   ls485_ren1 <= '0';
   ls485_ren2 <= '0';
   
   inst_comm : communication_sil 
   PORT MAP (
      clk_sys        => clk_96,
      rst_n          => rst96_n,
      ad_mio         => tid,
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
      activity1        => activity1,      
      layer7_rx2       => l7_rx2,
      layer7_soc2      => l7_soc2,
      layer7_rd2       => l7_rd2,
      layer7_newframe2 => l7_newframe2,
      layer7_comdispo2 => l7_comdispo2,
      layer7_l2ok2     => l7_l2ok2,
      layer7_overflow2 => l7_overflow2,
      activity2        => activity2,
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
   inst_pic : if_picspi
   GENERIC MAP(
      version => reg_version)
   PORT MAP (
      clk_sys  => clk_96,
      rst_n    => rst96_n,
      sclk     => sclk,
      sdi      => sdi,
      sdo      => sdo,
      ssn      => ssn,
      iid      => iid,
      tid      => tid,
      cpy1     => cpy1,
      cpy2     => cpy2,
      repli    => repli,
      l7_rx1   => l7_rx1,
      l7_soc1  => l7_soc1,
      l7_rd1   => l7_rd1,
      l7_comdispo1 => l7_comdispo1,
      l7_newframe1 => l7_newframe1,
      l7_l2ok1     => l7_l2ok1,
      l7_overflow1 => l7_overflow1,
      activity1    => activity1,
      l7_rx2       => l7_rx2,
      l7_soc2      => l7_soc2,
      l7_rd2       => l7_rd2,
      l7_comdispo2 => l7_comdispo2,
      l7_newframe2 => l7_newframe2,
      l7_l2ok2     => l7_l2ok2,
      l7_overflow2 => l7_overflow2,
      activity2    => activity2,
      tx_dat       => tx_dat,
      val_txdat    => val_txdat,
      tx_sof       => tx_sof,
      tx_eof       => tx_eof,
      txdat_free   => txdat_free,
      clr_fifo_tx  => clr_fifo_tx,
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
   -- Instantiation du module d'interface SPI de programmation de la PROM
   -----------------------------------------------
   int_promspi :  if_promspi
   GENERIC MAP(
      div_rate    => 3,          -- Diviseur de l'horlgoe système
      spiclk_freq => 12          -- Fréquence de 'lhorlgoe du SPI
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
   -- Compteur en free running pour la génération à 300KHz de la commande des alims isolées des LS
   ---------------------------------------
   PROCESS (clk_24)  -- Process nopn soumis au reset pour disposer des alims tout le temps
   BEGIN
      IF (clk_24'EVENT AND clk_24 = '1') THEN
         IF (cpt_cde = CONV_STD_LOGIC_VECTOR(41, cpt_cde'LENGTH)) THEN
         -- A la demi période (i.e = 42 x 40ns), on passe en temsp de repos pour les 2 MOSFET (non recouvrement)
            cpt_cde <= (OTHERS => '0');  
            cde_high <= '0';              -- Commande directe
            cde_low <= '0';               -- Commande à 180°
            toggle_cde <= NOT(toggle_cde);
         ELSE
            cpt_cde <= cpt_cde + 1;
            IF (cpt_cde = CONV_STD_LOGIC_VECTOR(0, cpt_cde'LENGTH)) THEN
               cde_high <= toggle_cde;       -- high et low ne doivent jamais être à '1' en même temps
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

   ----------------------------------------
   -- Isolation des signaux vers le PIC quand le 3.3V du PIC est off
   ----------------------------------------
   sclk    <= pic_sclk;
   sdi     <= pic_sdo;
   pic_sdi <= sdo WHEN (power_rstn = '1') ELSE 'Z';
   ssn     <= pic_ssn;

   ----------------------------------------
   -- Gestion des SPARE et RFU
   ----------------------------------------
   pic_rx <= 'Z';
   tp7    <= '0';
   tp8    <= '0';
   tp9 <= rst_fpgan OR cde_diag1 OR cde_diag2 OR pic_tx OR pic_spare(0) OR pic_spare(1) OR pic_spare(2)
          OR pic_spare(3) OR prog_b OR pic_refclki;
   spare  <= (OTHERS => '0');

END rtl;

