--============================================================================= 
--  TITRE : IF_PROMSPI
--  DESCRIPTION : 
--        Implémente une interface SPI master avec une vitesse de clk_sys / div_rate 
--        Le bus parallèle accepte en entrée un flux de données à écrire et fourni 
--        en sortie un flux de données lues.
--        Il supporte 2 types de commandes selon type_com et sur ordre de exec_com
--          type_com    |           opération
--             0        | Emet sur SPI la totalité des octets fournis précédemment sur TX_DAT
--             1        | Emet sur SPI la totalité des octets fournis précédemment sur TX_DAT
--                      | et récupère en lecture sur SPI nb_read octet et les met à disposition
--                      | sur RX_DAT
--  FICHIER :        if_promspi.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY if_promspi IS
   GENERIC (
      div_rate    : INTEGER := 1;      -- Diviseur d'horloge système pour obtenir le débit SPI = 2^div_rate
      spiclk_freq : INTEGER := 10      -- Fréquence horloge SPI (MHz) = freq(clk_sys)/2^div_rate
      );
   PORT (
      -- Ports système
      clk_sys     : IN  STD_LOGIC;  -- Clock système à 20 MHz
      rst_n       : IN  STD_LOGIC;  -- Reset général système

      -- Interface série
      spi_csn     : OUT STD_LOGIC;  -- CS de la mémoire SPI
      spi_wpn     : OUT STD_LOGIC;  -- Write Protect de la mémoire SPI
      spi_sdo     : OUT STD_LOGIC;  -- Data Write
      spi_sdi     : IN  STD_LOGIC;  -- Data Read
      spi_clk     : OUT STD_LOGIC;  -- SPI Clock en (CPOL, CPHA) = (0, 0)
      
      -- Interface parallèle
      tx_dat      : IN  STD_LOGIC_VECTOR(7 downto 0);  -- Commande + Données à transmettre en SPI
      tx_val      : IN  STD_LOGIC;                     -- Validant du bus tx_dat
      rx_dat      : OUT STD_LOGIC_VECTOR(7 downto 0);  -- Données lues sur le bus SPI
      rx_val      : OUT STD_LOGIC;                     -- Signal indiquant la validité de la donnée sur le bus rx
      rx_next     : IN  STD_LOGIC;                     -- Indique qu'il ya des donénes dans la FIFO de réception
      type_com    : IN  STD_LOGIC;                     -- Code du type de commande à éxécuter
      exec_com    : IN  STD_LOGIC;                     -- Ordre d'exécution de la commande codée par type_com
      spi_busy    : OUT STD_LOGIC;                     -- Signale que l'interface SPI est occupée avec une commande
      nb_read     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0)   -- Nombre d'octets à lire pour les commandes de type READ
      );
END if_promspi;

ARCHITECTURE rtl of if_promspi is
   CONSTANT com_wronly  : STD_LOGIC := '0';                       -- Commande de type Write Only
   CONSTANT com_wrrd    : STD_LOGIC := '1';                       -- Commande de type Write + Read (nb_read)
   SIGNAL rst           : STD_LOGIC;                              -- Reset des FIFO Tx et Rx
   SIGNAL div_clk       : STD_LOGIC_VECTOR(div_rate-1 DOWNTO 0);  -- Compteur pour diviser l'horloge système
   SIGNAL rise_clk      : STD_LOGIC;                              -- Front montant de l'horloge SPI
   SIGNAL fall_clk      : STD_LOGIC;                              -- Front descendant de l'horloge SPI
   SIGNAL fallclk_r     : STD_LOGIC;                              -- Front descendant de l'horloge SPI retardé d'un clk
   SIGNAL mask_clk      : STD_LOGIC;                              -- Signal de masque de l'horloge SPI
   SIGNAL cpt_bit       : STD_LOGIC_VECTOR(2 DOWNTO 0);           -- Compteur de bit pour le ser/deser
   SIGNAL cpt_byt       : STD_LOGIC_VECTOR(7 DOWNTO 0);           -- Compteur d'octets pour la réception
   SIGNAL fifotx_rd     : STD_LOGIC;                              -- Signal de lecture de la FIFO Tx
   SIGNAL data_tx       : STD_LOGIC_VECTOR(7 DOWNTO 0);           -- Data lue dans la FIFO Tx
   SIGNAL fifotx_empty  : STD_LOGIC;                              -- FIFO Tx vide
   SIGNAL fiforx_wr     : STD_LOGIC;                              -- Signal d'écriture dans la FIFO Rx
   SIGNAL fiforx_empty  : STD_LOGIC;                              -- FIFO Rx vide
   SIGNAL shifter_tx    : STD_LOGIC_VECTOR(7 DOWNTO 0);           -- Serialisateur
   SIGNAL shifter_rx    : STD_LOGIC_VECTOR(7 DOWNTO 0);           -- Déserialisateur
   SIGNAL read_stat     : STD_LOGIC;                              -- A 1 lors d'une lecture du registre de status
   SIGNAL latch_typcom  : STD_LOGIC;                              -- Pour mémoriser le type de commande
   
   -- Machine d'état de gestion des commandes
   TYPE fsmspi_typ IS (idle_st, latchcom_st, sendcom_st, getdat_st, releasecs_st, readstat_st, endcom_st);
   SIGNAL fsm_spi    : fsmspi_typ;
   
   -- FIFO (256 x 8bits) TX et RX en FWFT
   COMPONENT fifo_spi
   PORT (
      clk   : IN STD_LOGIC;
      rst   : IN STD_LOGIC;
      din   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en : IN STD_LOGIC;
      rd_en : IN STD_LOGIC;
      dout  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full  : OUT STD_LOGIC;
      empty : OUT STD_LOGIC
      );
   END COMPONENT;

BEGIN
   rst <= NOT(rst_n);
   
   ------------------------------------------
   -- Process de generation de la clock SPI
   ------------------------------------------
   gen_clk : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         div_clk <= (OTHERS => '0');
         fallclk_r <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         div_clk <= div_clk + 1;
         fallclk_r <= fall_clk;
      END IF;
   END PROCESS;
   spi_clk <= mask_clk AND div_clk(div_clk'LEFT);     -- La clock est active en fonction de la machine d'état
   -- rise_clk est actif au cycle qui précède le front montant effectif
   rise_clk <= '1' WHEN (div_clk = CONV_STD_LOGIC_VECTOR(2**(div_rate-1)-1, div_rate)) ELSE '0';
   -- fall_clk est actif au cycle qui précède le front descendant effectif
   fall_clk <= '1' WHEN (div_clk = CONV_STD_LOGIC_VECTOR(2**div_rate-1, div_rate)) ELSE '0';

   -------------------------------------------------
   -- Machine d'état d'exécution des commandes SPI
   -------------------------------------------------
   spi_sdo <= shifter_tx(7);           -- On SER les data MSB first
   spi_wpn <= '1';                     -- L'écriture est toujours autorisée dans la flash
   man_fm : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_spi <= idle_st;
         spi_csn <= '1';
         mask_clk <= '0';
         spi_busy <= '1';              -- En reset, on indique le SPI est inutilisable
         shifter_tx <= (OTHERS => '0');
         fifotx_rd <= '0';
         shifter_rx <= (OTHERS => '0');
         fiforx_wr <= '0';
         read_stat <= '0';
         latch_typcom <= '0';
         cpt_bit <= "000";
         cpt_byt <= (OTHERS => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_spi IS
            WHEN idle_st =>
            -- Etat d'attente d'une nouvelle commande à envoyer
               IF (exec_com = '1' AND fifotx_empty = '0') THEN
               -- Si on reçoit une nouvelle commande et si il y'a effectivement des octets à transmettre
                  spi_busy <= '1';           -- On signale qu'on est occupé
                  latch_typcom <= type_com;  -- On mémorise le type de la commande
                  fsm_spi <= latchcom_st;
               ELSE
                  spi_busy <= '0';
               END IF;

            WHEN latchcom_st =>
            -- Etat d'attent du 1er front montant de sclk
               IF (rise_clk = '1') THEN
                  spi_csn <= '0';         -- On active la Flash
                  cpt_bit <= "000";       -- On initialise le compteur de bit de façon à traiter le 1er octet (cf état suivant)
                  read_stat <= '0';       -- Par défaut, on ne lit pas encore le registre de status
                  fsm_spi <= sendcom_st;  -- On va envoyer la commande
               END IF;
            
            WHEN sendcom_st =>
            -- Etat de transmission de la commande
               IF (fall_clk = '1') THEN
               -- Sur chaque front descendant de la clock SPI
                  IF (cpt_bit = "000") THEN
                  -- Si on a transmis tous les bits (ou bien aucun pour le premier passage)
                     cpt_bit <= "111";
                     IF (fifotx_empty = '0' AND read_stat = '0') THEN
                     -- S'il reste des octets à transmettre et qu'on est pas en train de lire de status
                     -- note : si read_stat = 1 et fifo Tx n'est pas vide est un cas d'erreur
                        shifter_tx <= data_tx;  -- On va le SER
                        fifotx_rd <= '1';       -- On lit l'octet suivant dans la FIFO
                     ELSE
                     -- Si on a fini de transmettre les octets
                        IF (latch_typcom = com_wrrd or read_stat = '1') THEN
                        -- Si c'est une commande de type WR+RD ou bien si on lit le registre de staut
                           cpt_byt <= nb_read;     -- On va lire nb_read octets (ou une infinité si read_stat)
                           fsm_spi <= getdat_st;
                        ELSE
                        -- Si c'est une commande WR only
                           mask_clk <= '0';           -- On masque l'horloge
                           fsm_spi <= releasecs_st;   -- on va préparer la lecture du status
                        END IF;
                     END IF;
                  ELSE
                  -- Si on a pas SER tous les bits de l'octets
                     shifter_tx <= shifter_tx(6 DOWNTO 0) & '0';
                     cpt_bit <= cpt_bit - 1;
                     fifotx_rd <= '0';
                  END IF;
               ELSE
               -- On s'assure que le read dans la FIFO Tx ne dure qu'un cycle
                  fifotx_rd <= '0';
                  IF (fallclk_r = '1') THEN
                  -- Ici, on s'assure que le masque de l'horloge est enclenché un cycle d'horloge après le front descendant effectif
                  -- de la clock spi (évite les glitches)
                     mask_clk <= '1';
                  END IF;
               END IF;

            WHEN getdat_st =>
            -- Etat de réception des données de la FIFO
            -- Quand on arrive ici la première fois, nb_bit vaut déjà "111"
               IF (rise_clk = '1') THEN
               -- On échantillone sur front montant de la clock SPI
                  shifter_rx <= shifter_rx(6 DOWNTO 0) & spi_sdi; -- On DESER MSB first
               END IF;
               IF (fall_clk = '1') THEN
                  IF (cpt_bit = "000") THEN
                  -- Si on a DESER les 8 bits
                     fiforx_wr <= NOT(read_stat);          -- On stocke la donnée dans la FIFO Rx si c'est pas une lecture de status
                     IF ((latch_typcom = com_wrrd AND cpt_byt = CONV_STD_LOGIC_VECTOR(1, cpt_byt'LENGTH)) OR
                         (read_stat = '1' AND spi_sdi = '0')) THEN
                     -- Si c'est une commande WR+RD(nb_read) et qu'on a reçu les nb_read octets ou bien
                     -- on était en train de lire le registre de status et le LSB (WIP) du registre de status est nul
                        mask_clk <= '0';         -- On a fini
                        read_stat <= '0';
                        fsm_spi <= endcom_st;
                     ELSE
                     -- Si on doit encore récupérer des octets
                        cpt_byt <= cpt_byt - 1;
                     END IF;
                     cpt_bit <= "111";
                  ELSE
                  -- Si on n'a pas encore 7 bits
                     cpt_bit <= cpt_bit - 1;
                     fiforx_wr <= '0';
                  END IF;
               ELSE
               -- On s'assure que le signal de WR dans la FIFO Rx ne dure que 1 cycle
                  fiforx_wr <= '0';
               END IF;
               
            WHEN releasecs_st =>
            -- Etat de relachement du CS avant envoie de la commande de lecture du status.
               IF (rise_clk = '1') THEN
                  spi_csn <= '1';
                  -- On ajuste la tempo pour assurer que le release du CS fait bien 100ns quel que soit la clock SPI
                  cpt_byt <= CONV_STD_LOGIC_VECTOR(100*spiclk_freq/1000+1, cpt_byt'LENGTH);
                  fsm_spi <= readstat_st;
               END IF;

            WHEN readstat_st =>
            -- Etat de temporisation avant d'envoyer la commande de lecture du status 
               IF (rise_clk = '1') THEN
                  cpt_byt <= cpt_byt - 1;
               END IF;
               IF (fall_clk = '1' AND cpt_byt = CONV_STD_LOGIC_VECTOR(0, cpt_byt'LENGTH)) THEN
                  spi_csn <= '0';            -- On recommence un cycle SPI
                  cpt_bit <= "111";
                  shifter_tx <= x"05";       -- On force la transmission de la commande de lecture du status
                  read_stat <= '1';
                  fsm_spi <= sendcom_st;
               END IF;

            WHEN endcom_st =>
            -- Etat de fin, on attend un front montant de la clock SPI pour désactiver le CS.
               fiforx_wr <= '0';
               IF (rise_clk = '1') THEN
                  spi_busy <= '0';
                  spi_csn <= '1';
                  fsm_spi <= idle_st;
               END IF;
            
            WHEN OTHERS =>
               fsm_spi <= idle_st;
         END CASE;
      END IF;
   END PROCESS;

   inst_fiftx : fifo_spi
   PORT MAP (
      clk =>   clk_sys,
      rst =>   rst,
      din =>   tx_dat,
      wr_en => tx_val,
      rd_en => fifotx_rd,
      dout =>  data_tx,
      full =>  OPEN,
      empty => fifotx_empty
   );

   inst_fifrx : fifo_spi
   PORT MAP (
      clk =>   clk_sys,
      rst =>   rst,
      din =>   shifter_rx,
      wr_en => fiforx_wr,
      rd_en => rx_next,
      dout =>  rx_dat,
      full =>  OPEN,
      empty => fiforx_empty
   );
   rx_val <= NOT(fiforx_empty);

END rtl;

