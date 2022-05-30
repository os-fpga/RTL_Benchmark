--============================================================================= 
--  TITRE : IF_PICSPI
--  DESCRIPTION : 
--       Assure l'interface avec le PIC32 à travers un lien SPI
--       Implémente les registres mémoires tels que définis dans le HSI

--  FICHIER :        if_picspi.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	         AUTEUR	PROJET	REVISION 
--  24/11/2014    DRA      SATURN   1.01
--  Modification de l'état des bits recopie au reset pour être conforme 
--  à l'exigence CON-PRO-0110
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

ENTITY if_picspi_sil4 IS
   GENERIC (
      version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10");
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;  -- Clock système
      rst_n    : IN  STD_LOGIC;  -- Reset général système

      -- Interface SPI
      sclk     : IN  STD_LOGIC;  -- Clock SPI
      sdi      : IN  STD_LOGIC;  -- Bit IN SPI
      sdo      : OUT STD_LOGIC;  -- Bit OUT SPI
      ssn      : IN  STD_LOGIC;  -- CSn SPI

      -- Interface avec les autres modules du FPGA
      -- Tous ces signaux sont synchrones de clk_sys ou bien considérés statiques (comme IID)
      -- Signaux de configurations
      iid      : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);   -- Identifiant IID du FPGA
      tid      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);    -- Identifiant TID du FPGA
      cpy1     : OUT STD_LOGIC;                       -- Autorise la recopie du port 1 sur port 2
      cpy2     : OUT STD_LOGIC;                       -- Autorise la recopie du port 2 sur port 1
      repli    : OUT STD_LOGIC;                       -- Indique que le module est en repli (gestion des LED)
      topcyc       : OUT STD_LOGIC;
      enafiltdble  : OUT STD_LOGIC;
      
      -- Interfaces de lecture des trames port 1
      l7_rx1       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données reçues sur port 1
      l7_soc1      : IN  STD_LOGIC;                   -- Indique le début d'une trame
      l7_rd1       : OUT STD_LOGIC;                   -- Signal de lecture d'une donnée supplémentaire
      l7_comdispo1 : IN  STD_LOGIC;                   -- Indique qu'il y'a au moins une trame de dispo
      l7_newframe1 : IN  STD_LOGIC;                   -- Indique la réception d'une nouvelle trame
      l7_l2ok1     : IN  STD_LOGIC;                   -- Indique si la couche transport est bonne ou non
      l7_overflow1 : IN  STD_LOGIC;                   -- Indique un overflow sur réception
      activity1    : IN  STD_LOGIC;                   -- Indique une trame sur le port 1 (couche 2)
     
         -- Interfaces de lecture des trames port 2
      l7_rx2       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données reçues sur port 2
      l7_soc2      : IN  STD_LOGIC;                   -- Indique le début d'une trame
      l7_rd2       : OUT STD_LOGIC;                   -- Signal de lecture d'une donnée supplémentaire
      l7_comdispo2 : IN  STD_LOGIC;                   -- Indique qu'il y'a au moins une trame de dispo
      l7_newframe2 : IN  STD_LOGIC;                   -- Indique la réception d'une nouvelle trame
      l7_l2ok2     : IN  STD_LOGIC;                   -- Indique si la couche transport est bonne ou non
      l7_overflow2 : IN  STD_LOGIC;                   -- Indique un overflow sur réception
      activity2    : IN  STD_LOGIC;                   -- Indique une trame sur le port 2 (couche 2)

      -- Interface d'écriture des trames
      tx_dat       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données à transmettre sur les 2 ports
      val_txdat    : OUT STD_LOGIC;                   -- Validant de chaque octet
      tx_sof       : OUT STD_LOGIC;                   -- Indique le début d'une trame
      tx_eof       : OUT STD_LOGIC;                   -- Indique la fin d'une trame
      txdat_free   : IN  STD_LOGIC;                   -- Indique que la couche transport en tx est libre
      clr_fifo_tx  : OUT STD_LOGIC;                   -- Permet de purger les FIFO Tx
      
      -- Gestion de l'interface SPI PROM
      txprom_dat   : OUT STD_LOGIC_VECTOR(7 downto 0);-- Donnée + commandes à écrire dans le module de reprog
      txprom_val   : OUT STD_LOGIC;                   -- Validant de txprom_data
      rxprom_dat   : IN  STD_LOGIC_VECTOR(7 downto 0);-- Donnée lue depuis le module de reprog
      rxprom_val   : IN  STD_LOGIC;                   -- Indique qu'il y a des données à lire dans le module de reprog
      rxprom_next  : OUT STD_LOGIC;                   -- Lit une donnée de plus sur txprom_dat
      prom_type_com: OUT STD_LOGIC;                   -- Type de commande à exécuter (RD ou WR)
      prom_exec_com: OUT STD_LOGIC;                   -- Lance une commande dans le module de reprog
      prom_busy    : IN  STD_LOGIC;                   -- Indique que le module de reprog est occupé
      prom_nbread  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);-- Nombre d'octet qu'il faut lire avec une commande de lecture
      prom_rstn    : OUT STD_LOGIC                    -- Reset du module de reprog
      );
END if_picspi_sil4;

ARCHITECTURE rtl of if_picspi_sil4 is
   TYPE fsmtx_state IS (idle_st, senddat_st);         -- Machine d'état d'émission sur le SPI
   SIGNAL fsm_tx  : fsmtx_state;

   TYPE fsmrx_state IS (idle_st, pump_st, recdat_st, waitnotempty_st);  -- Machine de réception sur SPI
   SIGNAL fsm_rx  : fsmrx_state;

   -- Définition du Mapping mémoire des registre SPI
   CONSTANT adreg_iid      : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0, 7);
   CONSTANT adreg_tid      : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(8, 7);
   CONSTANT adreg_ctl      : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(9, 7);
   CONSTANT adreg_stat     : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(10, 7);
   CONSTANT adreg_rxsize1  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(11, 7);
   CONSTANT adreg_rxsize2  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(12, 7);
   CONSTANT adreg_txfree   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(13, 7);
   CONSTANT adreg_fiforx1  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(14, 7);
   CONSTANT adreg_fiforx2  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(15, 7);
   CONSTANT adreg_fifotx   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(16, 7);
   CONSTANT adreg_version  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(17, 7);
   CONSTANT adreg_promtx   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(18, 7);
   CONSTANT adreg_promrx   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(19, 7);
   CONSTANT adreg_promctl  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(20, 7);
   CONSTANT adreg_promnbrd : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(21, 7);
   CONSTANT adreg_trafic   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(22, 7);
   
   -- Définition des registres internes
   SIGNAL reg_tid_spi      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_ctl_spi      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_stat_spi     : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_rx1size_spi  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_rx2size_spi  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_txfree_spi   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_fiforx1_spi  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_fiforx2_spi  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_promctl      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_promnbrd     : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_trafic       : STD_LOGIC_VECTOR(7 DOWNTO 0);
   
   -- Signaux de gestion de l'interface SPI
   SIGNAL cpt_bitspi       : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Compte le nombre de bits sur un cycle SPI
   SIGNAL cptbit_tx        : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Compte le nombre de bits en Tx sur le SPI
   SIGNAL adrd_spi         : STD_LOGIC_VECTOR(6 DOWNTO 0); -- Bus d'adresse d'accès des registres SPI en rd
   SIGNAL adwr_spi         : STD_LOGIC_VECTOR(6 DOWNTO 0); -- Bus d'adresse d'accès des registres SPI en wr
   SIGNAL rwn_spi          : STD_LOGIC;                    -- Mémorise le type d'accès SPI R/Wn
   SIGNAL dat_adn          : STD_LOGIC;                    -- Indique si l'octet en cours sur SPI est une data ou l'adresse
   SIGNAL shifter_spirx    : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Registre à déclage de réception SPI
   SIGNAL shifter_spitx    : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Registre à déclage d'émission SPI
   SIGNAL spi_encours      : STD_LOGIC;                    -- Indique un cycle SPI en cours
   SIGNAL data_rdspi       : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Donnée lue à l'adresse adrd_spi
   SIGNAL wr_reg           : STD_LOGIC;                    -- 1 Pulse pour écrire le registre adwr_spi
   SIGNAL rd_reg           : STD_LOGIC;                    -- 1 pulse pour lire le registre adrd_spi
   SIGNAL latch_rdspi      : STD_LOGIC;                    -- 1 pulse pour latcher la donnée de adrd_spi (lecture non effective pour les FIFO)
   SIGNAL sclk_rise        : STD_LOGIC;                    -- Détection du front montant de sclk
   SIGNAL ssn_rise         : STD_LOGIC;                    -- Détection front montant de ssn avec clk_sys
   SIGNAL ssn_fall         : STD_LOGIC;                    -- Détection front descendant de ssn avec clk_sys
   SIGNAL ssnr             : STD_LOGIC_VECTOR(2 DOWNTO 0); -- DFF pour métastab et détection de front de ssn avec clk_sys
   SIGNAL sclkr            : STD_LOGIC_VECTOR(2 DOWNTO 0); -- DFF pour métastab et détection de front de sclk avec clk_sys
   SIGNAL front_ssn        : STD_LOGIC;                    -- Détection de front descendant sur ssn avec sclk
   SIGNAL sdi_delayed      : STD_LOGIC;                    -- sdi retardé pour intégrer les timing PIC (Tcko)

   -- Signaux de gestion interne et changement d'horloge
   SIGNAL difftx_free   : STD_LOGIC_VECTOR(10 DOWNTO 0);   -- Pour calculer la taille dispo en FIFO Tx sur 8 bits
   SIGNAL fifotx_datacnt: STD_LOGIC_VECTOR(10 DOWNTO 0);   -- Pour récuper le nb d'octets utilisé en FIFO Tx
   SIGNAL wr_datatx_spi : STD_LOGIC;                       -- Ordre d'écriture dans la FIFO Tx
   SIGNAL rd_datatx_sys : STD_LOGIC;                       -- Ordre de lecture dans la FIFO Tx
   SIGNAL datatx_rd_sys : STD_LOGIC_VECTOR(7 DOWNTO 0);    -- Donnée lue dans la FIFO Tx
   SIGNAL fifotx_empty  : STD_LOGIC;                       -- Indique une FFIO Tx vide
   SIGNAL rst_fifotx    : STD_LOGIC;                       -- Effacement FIFO Tx
   SIGNAL cpt_tx        : STD_LOGIC_VECTOR(7 DOWNTO 0);    -- Compteur d'octet pour relire la FIFO Tx
   SIGNAL start_tx      : STD_LOGIC;                       -- Déclenche l'émission d'une trame stockée en FIFO Tx
   SIGNAL clr_starttx   : STD_LOGIC;                       -- Indique que la trame en FIFO Tx a été émise
   
   SIGNAL fiforx_datacnt1: STD_LOGIC_VECTOR(10 DOWNTO 0);  -- Nombre d'octet stockés dans FIFO Rx1
   SIGNAL rd_datarx_spi1 : STD_LOGIC;                      -- Ordre de lecture dans la FIFO Rx1
   SIGNAL fiforx_empty1  : STD_LOGIC;                      -- FIFO Rx1 vide

   SIGNAL fiforx_datacnt2: STD_LOGIC_VECTOR(10 DOWNTO 0);  -- Nombre d'octet stockés dans FIFO Rx2
   SIGNAL rd_datarx_spi2 : STD_LOGIC;                      -- Ordre de lecture dans la FIFO Rx2
   SIGNAL fiforx_empty2  : STD_LOGIC;                      -- FIFO Rx2 vide

   SIGNAL l7_rd          : STD_LOGIC;                      -- Demande un octet de plus sur le bus l7_rx1 ou l7_rx2
   SIGNAL l7_rd1buf      : STD_LOGIC;                      -- Demande un octet de plus sur le bus l7_rx1
   SIGNAL l7_rd2buf      : STD_LOGIC;                      -- Demande un octet de plus sur le bus l7_rx2
   SIGNAL sel_voie       : STD_LOGIC;                      -- sélectionne la voie 1 ou 2 pour récupérer des donnée l7
   SIGNAL frm1           : STD_LOGIC;                      -- Indique que des données sont dispo en FIFO Rx1
   SIGNAL frm2           : STD_LOGIC;                      -- Indique que des données sont dispo en FIFO Rx2
   SIGNAL comdispo       : STD_LOGIC;                      -- Indique une trame l7 dispo sur la voie sélectionnée
   SIGNAL soc            : STD_LOGIC;                      -- Indqiue un début de trame pour la voie sélectionnée

   SIGNAL mem_activity1  : STD_LOGIC;                      -- Pour mémoriser une acitivté sur le port 1
   SIGNAL mem_activity2  : STD_LOGIC;                      -- Pour mémoriser une acitivté sur le port 2
   
   COMPONENT fifotx_spi
   PORT (
      rst      : IN STD_LOGIC;
      clk      : IN STD_LOGIC;
      din      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en    : IN STD_LOGIC;
      rd_en    : IN STD_LOGIC;
      dout     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full     : OUT STD_LOGIC;
      empty    : OUT STD_LOGIC;
      data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
   END COMPONENT;
   
   COMPONENT fiforx_spi
   PORT (
      rst      : IN STD_LOGIC;
      clk      : IN STD_LOGIC;
      din      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en    : IN STD_LOGIC;
      rd_en    : IN STD_LOGIC;
      dout     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full     : OUT STD_LOGIC;
      empty    : OUT STD_LOGIC;
      data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
   END COMPONENT;

BEGIN
   --------------------------------------------
   -- Module de Delay du SDI
   --------------------------------------------
   IODELAY2_inst : IODELAY2
   generic map (
      COUNTER_WRAPAROUND => "WRAPAROUND", -- "STAY_AT_LIMIT" or "WRAPAROUND" 
      DATA_RATE => "SDR",                 -- "SDR" or "DDR" 
      DELAY_SRC => "IDATAIN",             -- "IO", "ODATAIN" or "IDATAIN" 
      IDELAY2_VALUE => 0,                 -- Delay value when IDELAY_MODE="PCI" (0-255)
      IDELAY_MODE => "NORMAL",            -- "NORMAL" or "PCI" 
      IDELAY_TYPE => "FIXED",             -- "FIXED", "DEFAULT", "VARIABLE_FROM_ZERO", "VARIABLE_FROM_HALF_MAX" 
                                          -- or "DIFF_PHASE_DETECTOR" 
      IDELAY_VALUE => 71,                 -- Amount of taps for fixed input delay (0-255) : Calé à 2.8ns
      ODELAY_VALUE => 0,                  -- Amount of taps fixed output delay (0-255)
      SERDES_MODE => "NONE",              -- "NONE", "MASTER" or "SLAVE" 
      SIM_TAPDELAY_VALUE => 71            -- Per tap delay used for simulation in ps
   )
   port map (
      BUSY => OPEN,         -- 1-bit output: Busy output after CAL
      DATAOUT => sdi_delayed,-- 1-bit output: Delayed data output to ISERDES/input register
      DATAOUT2 => OPEN,     -- 1-bit output: Delayed data output to general FPGA fabric
      DOUT => OPEN,         -- 1-bit output: Delayed data output
      TOUT => OPEN,         -- 1-bit output: Delayed 3-state output
      CAL => '0',           -- 1-bit input: Initiate calibration input
      CE => '0',            -- 1-bit input: Enable INC input
      CLK => '0',           -- 1-bit input: Clock input
      IDATAIN => sdi,       -- 1-bit input: Data input (connect to top-level port or I/O buffer)
      INC => '0',           -- 1-bit input: Increment / decrement input
      IOCLK0 => '0',        -- 1-bit input: Input from the I/O clock network
      IOCLK1 => '0',        -- 1-bit input: Input from the I/O clock network
      ODATAIN => '0',       -- 1-bit input: Output data input from output register or OSERDES2.
      RST => '0',           -- 1-bit input: Reset to zero or 1/2 of total delay period
      T => '0'              -- 1-bit input: 3-state input signal
   );

   --------------------------------------------
   -- Process de desérialisation du SDI (sur sclk)
   --------------------------------------------
   serrx_spi : PROCESS(sclk)
   BEGIN
      IF (sclk'EVENT AND sclk = '1') THEN
         shifter_spirx <= shifter_spirx(6 DOWNTO 0) & sdi_delayed;  -- On déserialise tout le temps
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Process de sérialisation du SDo (sur sclk)
   --------------------------------------------
   sertx_spi : PROCESS(sclk, ssn)
   BEGIN
      IF (ssn = '1') THEN
      -- Tant que le ssn n'est pas actif, on reste inactif
         shifter_spitx <= (OTHERS => '0');
         cptbit_tx <= "000";
         front_ssn <= '1';
      ELSIF (sclk'EVENT and sclk = '0') THEN
      -- Sur front descendant de sclk
         front_ssn <= '0';                      -- On mémorise le 1er coup d'horloge suite à ssn
         cptbit_tx <= cptbit_tx + 1;            -- a chaque sclk on compte 1 bit
         IF (cptbit_tx = "000")THEN
         -- Pour le 1er sclk de chaque octet
            IF (front_ssn = '1') THEN
            -- si c'est le 1er octet (front_ssn pas encore à '0')
               shifter_spitx <= reg_stat_spi;   -- On va émettre le registre de status
            ELSE
            -- si c'eux sont les octets suivants, on va émettre la donnée lue dans un registre
               shifter_spitx <= data_rdspi;
            END IF;
         ELSE
         -- Pour tous les autres bist, on fait un shift
            shifter_spitx <= shifter_spitx(6 DOWNTO 0) & '0';
         END IF;
      END IF;
   END PROCESS;
   sdo <= shifter_spitx(7);

   --------------------------------------------
   -- Process de gestion d'un cycle SPI
   -- Un cycle SPI permet de lire et d'écrire si besoin le même registre
   -- Un cycle SPI permet de traiter un nombre variable d'octet inconnu au départ
   -- Pour des raions de timing, la lecture d'un registre est anticipée
   -- mais rendue effective que si le PIC la veut vraiment (i.e. le cycle SPI n'est pas 
   -- interrompu avant)
   --------------------------------------------
   managespi : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         ssnr <= "111";
         sclkr <= "111";
         spi_encours <= '0';
         cpt_bitspi <= "000";
         dat_adn <= '0';
         rwn_spi <= '0';
         adrd_spi <= (OTHERS => '0');
         rd_reg <= '0';
         latch_rdspi <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         ssnr <= ssnr(1 DOWNTO 0) & ssn;        -- Pour détecter les fronts de ssn à clk_sys
         sclkr <= sclkr(1 DOWNTO 0) & sclk;     -- Pour détecter les fronts de sclk à clk_sys
         IF (ssn_fall = '1') THEN
         -- Initialisations sur activation de ssn
            spi_encours <= '1';                 -- On est en cours de traitement
            cpt_bitspi <= "000";                -- On comtpe les bits à partir de 0
            dat_adn <= '0';                     -- Le 1er octet traité sera l'adresse du registre accédé
         ELSIF (ssn_rise = '1') THEN
         -- A la fin du scycle spi
            spi_encours <= '0';
         ELSE
         -- On a détecté un front descendant de ssn ou bien on est hors cycle spi
            IF (spi_encours = '1') THEN
            -- Si on est dans un cycle spi
               IF (sclk_rise = '1') THEN
               -- Sur chaque front montant de sclk
                  cpt_bitspi <= cpt_bitspi + 1;       -- On comtpe un bit de plus
                  IF (cpt_bitspi = "110") THEN
                  -- Si on a déjà reçu 7 bits, le prochain front montant est pour le 8ème en réception
                     IF (dat_adn = '0') THEN
                     -- Si c'est le 1er octet de la trame SPI
                        adrd_spi  <= shifter_spirx(6 DOWNTO 0);  -- On mémorise l'adresse d'accès
                     ELSE
                     -- Si c'est une donnée
                        adwr_spi <= adrd_spi;    -- On mémorise l'adresse ou on vient de lire pour éventuellement pouvoir écrire
                        IF (adrd_spi /= adreg_fiforx1 AND 
                            adrd_spi /= adreg_fiforx2 AND
                            adrd_spi /= adreg_fifotx  AND
                            adrd_spi /= adreg_promtx  AND
                            adrd_spi /= adreg_promrx) THEN
                        -- Si on accède à un registre qui n'est pas une FIFO, on incrémente le pointeur d'@
                           adrd_spi <= adrd_spi + 1;
                        END IF;
                     END IF;
                     latch_rdspi <= '1';     -- On va latcher la donéne disponible à l'adresse pointée par adrd_spi
                  ELSIF (cpt_bitspi = "111") THEN
                  -- Si on est au 8ème coup d'horloge
                     dat_adn <= '1';         -- On va traiter des donnée à l'octet suivant
                     IF (dat_adn = '0') THEN
                     -- Si c'est le 1er octet de la trame SPI
                        rwn_spi <= shifter_spirx(0);  -- On mémorise si c'est une écriture ou une elcture
                     END IF;
                  ELSIF (cpt_bitspi = "000") THEN
                  -- Si on commence un cycle, et qu'on traite des données et qu'on est en lecture
                     rd_reg <= dat_adn AND rwn_spi;   -- On lit effectivement la donnée dans la registre (utilse pour les FIFO)
                  END IF;
               ELSE
               -- En dehors des front de sclk, on assure que les signaux de lecture ne durent qu'un cycle
                  rd_reg <= '0';
                  latch_rdspi <= '0';
               END IF;
            ELSE
            -- En dehors d'un cycle SPI, on assure qu'on fait pas de lecture non voulue
               rd_reg <= '0';
               latch_rdspi <= '0';            
            END IF;
         END IF;
      END IF;
   END PROCESS;
   -- On écrit une donnée dans un registre si:
   --   - on triate des données
   --   - on a reçu les 8 bits de données
   --   - on a détecté un front montant de sclk
   --   - on est en write
   wr_reg <= dat_adn AND NOT(rwn_spi) WHEN (sclk_rise = '1' AND cpt_bitspi = "111") ELSE '0';
   -- Décodage du front descendant de ssn
   ssn_fall <= ssnr(2) AND NOT(ssnr(1));
   -- Décodage du front montant de ssn
   ssn_rise <= NOT(ssnr(2)) AND ssnr(1);
   -- Décodage du front montant de sclk
   sclk_rise <= NOT(sclkr(2)) AND sclkr(1);

   --------------------------------------------
   -- Process de latch d'un registre en lecture
   --------------------------------------------
   mux_read: PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         data_rdspi <= (OTHERS => '0');
      ELSIF (clk_sys'event AND clk_sys ='1') THEN
         IF (latch_rdspi = '1') THEN
         -- Le letch est piloté par le module de gestion SPI
            CASE adrd_spi IS
               WHEN adreg_iid    => data_rdspi <= iid(63 DOWNTO 56);
               WHEN adreg_iid+1  => data_rdspi <= iid(55 DOWNTO 48);
               WHEN adreg_iid+2  => data_rdspi <= iid(47 DOWNTO 40);
               WHEN adreg_iid+3  => data_rdspi <= iid(39 DOWNTO 32);
               WHEN adreg_iid+4  => data_rdspi <= iid(31 DOWNTO 24);
               WHEN adreg_iid+5  => data_rdspi <= iid(23 DOWNTO 16);
               WHEN adreg_iid+6  => data_rdspi <= iid(15 DOWNTO 8);
               WHEN adreg_iid+7  => data_rdspi <= iid(7 DOWNTO 0);
               WHEN adreg_tid    => data_rdspi <= reg_tid_spi;
               WHEN adreg_ctl    => data_rdspi <= reg_ctl_spi;
               WHEN adreg_stat   => data_rdspi <= reg_stat_spi;
               WHEN adreg_rxsize1=> data_rdspi <= reg_rx1size_spi;
               WHEN adreg_rxsize2=> data_rdspi <= reg_rx2size_spi;
               WHEN adreg_txfree => data_rdspi <= reg_txfree_spi;
               WHEN adreg_fiforx1=> data_rdspi <= reg_fiforx1_spi;
               WHEN adreg_fiforx2=> data_rdspi <= reg_fiforx2_spi;
               -- WHEN adreg_fifotx => data_rdspi <= dummy  -- Ce registre est Write Only
               WHEN adreg_version=> data_rdspi <= version;
               WHEN adreg_promctl=> data_rdspi <= rxprom_val & reg_promctl(6 DOWNTO 4) & prom_busy & reg_promctl(2 DOWNTO 0);
               WHEN adreg_promnbrd=>data_rdspi <= reg_promnbrd;
               -- WHEN adreg_promtx => data_rdspi <= dummy  -- Ce registre est Write Only
               WHEN adreg_promrx=> data_rdspi <= rxprom_dat;
               WHEN adreg_trafic=> data_rdspi <= reg_trafic;
               WHEN OTHERS       => data_rdspi <= reg_stat_spi;
            END CASE;
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Process de gestion des écritures dans les registres
   --------------------------------------------
   write_reg : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_tid_spi <= x"8F";
         reg_ctl_spi <= x"84";
         reg_promctl <= x"00";
         reg_promnbrd <= x"00";
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (wr_reg = '1') THEN
         -- L'écriture est pilotée par le module de gestion SPI
            CASE adwr_spi IS
               WHEN adreg_tid  => reg_tid_spi <= shifter_spirx;
               WHEN adreg_ctl  => 
               -- Le bit 3 du registre de controle est traqité à part
                  reg_ctl_spi(7 DOWNTO 5) <= shifter_spirx(7 DOWNTO 5);
                  reg_ctl_spi(2 DOWNTO 0) <= shifter_spirx(2 DOWNTO 0);
               WHEN adreg_promnbrd => reg_promnbrd <= shifter_spirx;
               WHEN OTHERS =>
            END CASE;
         END IF;
         IF (clr_starttx = '1') THEN
         -- Si on a fini de traiter une trame en Tx
            reg_ctl_spi(3) <= '0';     -- On l'indique dans le bit concerné
         ELSE
            IF (wr_reg = '1') AND (adwr_spi = adreg_ctl) AND (shifter_spirx(3) = '1') THEN
            -- Le PIC de peut écrire que un '1' dans le bit 3 du registre de controle
               reg_ctl_spi(3) <= '1';
            END IF;
         END IF;
         IF (wr_reg = '1' AND adwr_spi = adreg_promctl) THEN
            reg_promctl <= shifter_spirx;
         ELSE
         -- Le bit 3 ne doit durer qu'un seul coup de clk_sys
            reg_promctl(3) <= '0';
         END IF;
      END IF;
   END PROCESS;
   -- Affectation des sorties en fonction des registres internes
   cpy1        <= reg_ctl_spi(0);
   cpy2        <= reg_ctl_spi(1);
   rst_fifotx  <= reg_ctl_spi(2);
   start_tx    <= reg_ctl_spi(3);
   topcyc      <= reg_ctl_spi(4);
   enafiltdble <= reg_ctl_spi(6);
   repli       <= reg_ctl_spi(7);
   tid         <= reg_tid_spi;

   --------------------------------------------
   -- Process de gestion du registre de status
   -- Les bits de status mémorisent un évènement
   -- Ils ne sont remis à '0' que par ériture d'un '1'
   --------------------------------------------
   gest_stat : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_stat_spi(7 DOWNTO 2) <= (OTHERS => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (l7_newframe1 = '1' AND l7_l2ok1 = '0') THEN
         -- Détection d'une trame erronnée sur Rx1
            reg_stat_spi(2) <= '1';
         ELSIF (wr_reg = '1' AND adwr_spi = adreg_stat) THEN
            reg_stat_spi(2) <= reg_stat_spi(2) AND NOT(shifter_spirx(2));
         END IF;
         IF (l7_newframe2 = '1' AND l7_l2ok2 = '0') THEN
         -- Détection d'une trame erronnée sur Rx2
            reg_stat_spi(3) <= '1';
         ELSIF (wr_reg = '1' AND adwr_spi = adreg_stat) THEN
            reg_stat_spi(3) <= reg_stat_spi(3) AND NOT(shifter_spirx(3));
         END IF;
         IF (l7_overflow1 = '1') THEN
         -- Détection d'un overflow sur Rx1
            reg_stat_spi(4) <= '1';
         ELSIF (wr_reg = '1' AND adwr_spi = adreg_stat) THEN
            reg_stat_spi(4) <= reg_stat_spi(4) AND NOT(shifter_spirx(4));
         END IF;
         IF (l7_overflow2 = '1') THEN
         -- Détection d'un overflow sur Rx1
            reg_stat_spi(5) <= '1';
         ELSIF (wr_reg = '1' AND adwr_spi = adreg_stat) THEN
            reg_stat_spi(5) <= reg_stat_spi(5) AND NOT(shifter_spirx(5));
         END IF;
         reg_stat_spi(6) <= NOT(fifotx_empty);  -- Indique que la FIFO Tx n'est pas vide
      END IF; 
   END PROCESS;
   reg_stat_spi(1 DOWNTO 0) <= frm2 & frm1;  -- Indication que les FIFO Rx sont pas vides

   --------------------------------------------
   -- Process de gestion du registre TRAFIC
   --------------------------------------------
   gest_trafic : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_trafic <= x"03";
         mem_activity1 <= '1';
         mem_activity2 <= '1';
      ELSIF (clk_sys'EVENT AND clk_sys = '1') THEN
         IF (wr_reg = '1' AND adwr_spi = adreg_ctl AND shifter_spirx(4) = '1') THEN
         -- Si on a une indication de début de cycle
            reg_trafic <= "000000" & mem_activity2 & mem_activity1;  -- On met à jour le registre traffic
            mem_activity1 <= activity1;                     -- On réinit la mémorisation de trafic
            mem_activity2 <= activity2;
         ELSE
         -- Entre 2 début de cycle
            IF (activity1 = '1') THEN
            -- Si activité sur le port 1, on le mémorise
               mem_activity1 <= '1';
            END IF;
            IF (activity2 = '1') THEN
               mem_activity2 <= '1';
            END IF;
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Process de gestion de la FIFO Tx
   --------------------------------------------
   difftx_free <= "10000000010" - fifotx_datacnt; -- Calcul du nombre d'octets dispo dans la FIFO 1026-cnt
   reg_txfree_spi <= x"FF" WHEN difftx_free(10 DOWNTO 8) /= "000" ELSE  -- Si txfree >=256 on tronque le résultat à 255
                     difftx_free(7 DOWNTO 0);              -- Sinon on donne le résultat

   -- Condition d'écriture d'un octet dans la FIFO TX
   wr_datatx_spi <= '1' WHEN (wr_reg = '1' AND adwr_spi = adreg_fifotx) ELSE '0';
   
   clr_fifo_tx <= '0';              -- Spare pour l'instant on ne fait pas de clear de la fifo tx aval

   -- On lit un octet dans la FIFO TX au début lorsuq'on détecte qu'elle n'est plus vide et que le PIC demande de transmettre (start_tx)
   -- ou bien en cours de transfert lorsque le module suivant est dispo
   rd_datatx_sys <= '1' WHEN ((fsm_tx = idle_st AND fifotx_empty = '0' AND start_tx = '1') OR
                              (fsm_tx = senddat_st AND txdat_free = '1' AND fifotx_empty = '0')) ELSE
                    '0';

   -- Le valdiant est toujours actif en état d'attente pour démarrer de suite
   -- En téta de transmission, il est conditionné au niveau de remplissage
   val_txdat <= NOT(fifotx_empty) WHEN (fsm_tx = idle_st) ELSE '1';
   -- Donnée lue dans la FIFO à transmettre
   tx_dat <= datatx_rd_sys;
   -- La fin de trame est valide si le module suivant est dispo
   tx_eof <= txdat_free WHEN (fsm_tx = senddat_st AND cpt_tx = "00000001") ELSE '0';

   gest_fsm_tx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_tx <= idle_st;
         tx_sof    <= '0';
         cpt_tx    <= (OTHERS => '0');
         clr_starttx <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_tx IS
            WHEN idle_st  => 
            -- Etat d'attente de données dans la FIFO TX
               IF (fifotx_empty = '0' AND start_tx = '1') THEN
               -- Si il y'a des données dans la FIFO TX et que le PIC ordonne le Tx
                  cpt_tx <= datatx_rd_sys;   -- On initialise le compteur avec la longueur de la trame (1er octet dans la FIFO)
                  fsm_tx <= senddat_st;      -- On va transmettre des données
                  tx_sof <= '1';             -- On active le sof pour signaler un début de trame
                  clr_starttx <= '1';        -- On indique qu'on a pris en compte l'ordre de Tx
               END IF;

            WHEN senddat_st =>
            -- Etat de transfert d'une donnée
               clr_starttx <= '0';           -- Ne dure qu'un seul cycle
               IF (txdat_free = '1') THEN
               -- Les données restent sur le bus tx_dat tant que le module suivant n'est pas libre
               -- i.e. tant qu'il a pas latché la donnée actuelle
                  cpt_tx <= cpt_tx - 1;         -- Dans ce cas on enregistre une donnee de moins
                  tx_sof <= '0';                -- On peut annuler le sof car on est sur que le module suivant l'a pris en comtpe
                  IF (cpt_tx = "00000001") THEN -- Lors du dernier octet à transmettre
                     fsm_tx <= idle_st;         -- On a fini
                  END IF;
               END IF;
            
            WHEN OTHERS =>
               fsm_tx <= idle_st;            
         END CASE;
      END IF;
   END PROCESS;

   inst_fiftx : fifotx_spi
   PORT MAP (
      rst      => rst_fifotx,
      clk      => clk_sys,
      din      => shifter_spirx,
      wr_en    => wr_datatx_spi,
      rd_en    => rd_datatx_sys,
      dout     => datatx_rd_sys,
      full     => OPEN,
      empty    => fifotx_empty,
      data_count => fifotx_datacnt
   );                     
   
   --------------------------------------------
   -- Process de gestion des FIFO Rx
   --------------------------------------------
   -- Ordre de lecture dans les FIFO Rx
   rd_datarx_spi1 <= '1' WHEN (rd_reg = '1' AND adrd_spi = adreg_fiforx1) ELSE '0';
   rd_datarx_spi2 <= '1' WHEN (rd_reg = '1' AND adrd_spi = adreg_fiforx2) ELSE '0';

   -- On transfère des données dans la FIFO Rx trame par trame. On s'arrête
   l7_rd1buf <= (l7_rd AND NOT(sel_voie) AND comdispo AND NOT(soc)) WHEN (fsm_rx = recdat_st) ELSE 
                (l7_rd AND NOT(sel_voie));
   l7_rd1 <= l7_rd1buf;
   l7_rd2buf <= (l7_rd AND sel_voie AND comdispo AND NOT(soc)) WHEN (fsm_rx = recdat_st) ELSE 
                (l7_rd AND sel_voie);
   l7_rd2 <= l7_rd2buf;
   
   comdispo <= l7_comdispo1 WHEN (sel_voie = '0') ELSE l7_comdispo2;
   soc <= l7_soc1 WHEN (sel_voie = '0') ELSE l7_soc2;

   gest_fsm_rx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         l7_rd <= '0';
         sel_voie <= '0';         
         fsm_rx <= idle_st;
         frm2 <= '0';
         frm1 <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_rx IS
            WHEN idle_st  => 
            -- Etat d'attente qu'une FIFO Rx1 ou Rx2 soit vide et qu'il y'ait une trame disponible
            -- sur la voie correspondante
               frm1 <= NOT(fiforx_empty1);      -- On indique s'il y'a des trames en FIFO Rx
               frm2 <= NOT(fiforx_empty2);
               IF ((l7_comdispo1 = '1' AND fiforx_empty1 = '1') AND 
                   (l7_comdispo2 = '0' OR  fiforx_empty2 = '0' OR sel_voie = '1')) THEN
               -- On ne recopie que si la FIFO de destination est vide pour garantir qu'on ne stocke qu'une trame à la fois
               -- On fait un coup la FIFO Rx1 un coup la Rx2 pour équilibrer les niveaux
                  sel_voie <= '0';        -- On sélectionne la voie Rx1
                  l7_rd <= '1';           -- On commence à lire dans la DPRAM
                  fsm_rx <= pump_st;
               ELSIF (l7_comdispo2 = '1' AND fiforx_empty2 = '1') THEN
                  sel_voie <= '1';
                  l7_rd <= '1';
                  fsm_rx <= pump_st;
               ELSE
                  l7_rd <= '0';
               END IF;
               
            WHEN pump_st =>
            -- Etat d'amorçgae du flux entre l'ordre de lecture et la mise à disposition de la donnée
               fsm_rx <= recdat_st;

            WHEN recdat_st =>
            -- Etat de lecture de chaque octet de la trame
               IF (soc = '1' OR comdispo = '0') THEN
               -- On s'arrête sur le début de la trame suivante ou bien sur une DPRAM vide
                  l7_rd <= '0';
                  fsm_rx <= waitnotempty_st;
               END IF;
               
            WHEN waitnotempty_st =>
            -- Etat d'attente que la FIFO de la voie sélectionnée soit indiquée comme non vide
            -- Etat important pour garantir qu'on est pas réentrant dans la machine
            -- en cas de plusieurs petites trames dispo en DPRAM et donc garantir qu'on a
            -- une seule trame en FIFO Rx
               IF ((fiforx_empty1 = '0' AND sel_voie = '0') OR
                  (fiforx_empty2 = '0' AND sel_voie = '1')) THEN
                  fsm_rx <= idle_st;
               END IF;

            WHEN OTHERS =>
               fsm_rx <= idle_st;            
         END CASE;
      END IF;
   END PROCESS;

   inst_fifrx1 : fiforx_spi
   PORT MAP (
      rst      => NOT(rst_n),
      clk      => clk_sys,
      din      => l7_rx1,
      wr_en    => l7_rd1buf,
      rd_en    => rd_datarx_spi1,
      dout     => reg_fiforx1_spi,
      full     => OPEN,
      empty    => fiforx_empty1,
      data_count => fiforx_datacnt1
   );                     
   -- Taille de la trame dans la FIFO : 255 si >= 256, sinon Nb octets dans la FIFO
   reg_rx1size_spi <= x"FF" WHEN fiforx_datacnt1(10 DOWNTO 8) /= "000" ELSE
                      fiforx_datacnt1(7 DOWNTO 0);

   inst_fifrx2 : fiforx_spi
   PORT MAP (
      rst      => NOT(rst_n),
      clk      => clk_sys,
      din      => l7_rx2,
      wr_en    => l7_rd2buf,
      rd_en    => rd_datarx_spi2,
      dout     => reg_fiforx2_spi,
      full     => OPEN,
      empty    => fiforx_empty2,
      data_count => fiforx_datacnt2
   );                     
   -- Taille de la trame dans la FIFO : 255 si >= 256, sinon Nb octets dans la FIFO
   reg_rx2size_spi <= x"FF" WHEN fiforx_datacnt2(10 DOWNTO 8) /= "000" ELSE
                      fiforx_datacnt2(7 DOWNTO 0);

   -------------------------------------------------
   -- Signaux de gestion de l'I/F SPI vers la PROM
   -------------------------------------------------
   txprom_dat     <= shifter_spirx;    -- Le registre est géré par le module PROM (affectation combinatoire)
   -- Le validant correspondant à un ordre d'écriture valide
   txprom_val     <= wr_reg WHEN (adwr_spi =  adreg_promtx) ELSE '0';
   -- On récupère une donnée de plsu dans la FIFO PROM avec une elcture valide
   rxprom_next    <= rd_reg WHEN (adrd_spi =  adreg_promrx) ELSE '0';
   -- Affectation des signaux de controle
   prom_type_com  <= reg_promctl(0);
   prom_exec_com  <= reg_promctl(3);
   prom_rstn      <= reg_promctl(4);
   prom_nbread    <= reg_promnbrd;

END rtl;

