--============================================================================= 
--  TITRE : IF_PICPMP
--  DESCRIPTION : 
--       Assure l'interface avec le PIC32 à travers un lien PMP
--       Implémente les registres mémoires tels que définis dans le HSI

--  FICHIER :        if_picpmp.vhd 
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

ENTITY if_picpmp IS
   GENERIC (
      version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10");  -- Version du FPGA
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;                       -- Clock système
      rst_n    : IN  STD_LOGIC;                       -- Reset général système

      -- Interface PMP (Interface PIC)
      pmd      : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Bus parallèle multiplexé Adresse/data
      pmall    : IN STD_LOGIC;                        -- Latche des LSB des adresses
      pmalh    : IN STD_LOGIC;                        -- Latche des MSB des adresses
      pmrd     : IN STD_LOGIC;                        -- Signal de lecture
      pmwr     : IN STD_LOGIC;                        -- Signal d'écriture

      -- Interface avec les autres modules du FPGA
      -- Tous ces signaux sont synchrones de clk_sys
      -- Signaux de configurations
      iid          : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);-- Identifiant IID du FPGA
      tid          : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);-- Identifiant TID du FPGA
      cpy1         : OUT STD_LOGIC;                   -- Autorise la recopie du port 1 sur port 2
      cpy2         : OUT STD_LOGIC;                   -- Autorise la recopie du port 2 sur port 1
      repli        : OUT STD_LOGIC;                   -- Indique que le module est en repli (gestion des LED)
      baudrate     : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);-- Baudrate en mdoe maitre
      actif        : OUT STD_LOGIC;                   -- Indique que le concentrateur est actif
      topcyc       : OUT STD_LOGIC;                   -- Un pulse indique un début de cycle
      enafiltdble  : OUT STD_LOGIC;                   -- Autorise le filtrage des trames en double
      lanscan_prg  : OUT STD_LOGIC;                   -- Indique à l'autre PIC qu'on veut faire un LANSCAN
      lanscan_ack  : IN  STD_LOGIC;                   -- Indique que l'autre PIC est prêt à faire un LANSCAN
      new_sync_out : OUT STD_LOGIC;                   -- Indique à l'autre PIC qu'on vient d'émettre une synchro
      sync_out_ack : IN  STD_LOGIC;                   -- Indique que l'autre PIC a bien noté la nouvelle synchro
      sync_num_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);-- Numéro du cyle en cours qu'on vient d'émettre
      new_sync_in  : IN  STD_LOGIC;                   -- Indique que l'autre PIC a émis une trame de synchro
      sync_in_ack  : OUT STD_LOGIC;                   -- Acquitte la trame de synhcro émise par l'auter PIC
      sync_num_in  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);-- Numéro du cyle en cours que l'autre PIC vient d'émettre
      invcrc_out   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);  -- CRC d'invariant à donner à l'autre PIC
      invcrc_in    : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);  -- CRC d'invariant donné par l'autre PIC
      
      -- Interfaces de lecture des trames port 1
      l7_rx1       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données reçues sur port 1
      l7_soc1      : IN  STD_LOGIC;                   -- Indique le début d'une trame
      l7_rd1       : OUT STD_LOGIC;                   -- Signal de lecture d'une donnée supplémentaire
      l7_comdispo1 : IN  STD_LOGIC;                   -- Indique qu'il y'a au moins une trame de dispo
      l7_newframe1 : IN  STD_LOGIC;                   -- Indique la réception d'une nouvelle trame
      l7_l2ok1     : IN  STD_LOGIC;                   -- Indique si la couche transport est bonne ou non
      l7_overflow1 : IN  STD_LOGIC;                   -- Indique un overflow sur réception
     
         -- Interfaces de lecture des trames port 2
      l7_rx2       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données reçues sur port 2
      l7_soc2      : IN  STD_LOGIC;                   -- Indique le début d'une trame
      l7_rd2       : OUT STD_LOGIC;                   -- Signal de lecture d'une donnée supplémentaire
      l7_comdispo2 : IN  STD_LOGIC;                   -- Indique qu'il y'a au moins une trame de dispo
      l7_newframe2 : IN  STD_LOGIC;                   -- Indique la réception d'une nouvelle trame
      l7_l2ok2     : IN  STD_LOGIC;                   -- Indique si la couche transport est bonne ou non
      l7_overflow2 : IN  STD_LOGIC;                   -- Indique un overflow sur réception

      -- Interface d'écriture des trames
      tx_dat       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données à transmettre sur les 2 ports
      val_txdat    : OUT STD_LOGIC;                   -- Validant de chaque octet
      tx_sof       : OUT STD_LOGIC;                   -- Indique le début d'une trame
      tx_eof       : OUT STD_LOGIC;                   -- Indique la fin d'une trame
      txdat_free   : IN  STD_LOGIC;                   -- Indique que la couche transport en tx est libre
      clr_fifo_tx  : OUT STD_LOGIC;                   -- Permet de purger les FIFO Tx
      stuf_phys    : OUT STD_LOGIC;                   -- Demande d'émettre uine série de stuffing sur le port RS
      acq_stuf     : IN  STD_LOGIC;                   -- Indique que la commande stuffing a été exécutée
      tx_available : OUT STD_LOGIC;                   -- Signale au module de communication qu'une trame est en attente d'émission
      tx_commena   : IN  STD_LOGIC;                   -- Autorise l'émission de la trame en attente

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
END if_picpmp;

ARCHITECTURE rtl of if_picpmp is
   TYPE fsmtx_state IS (idle_st, senddat_st);
   SIGNAL fsm_tx  : fsmtx_state;

   TYPE fsmrx_state IS (idle_st, pump_st, recdat_st, waitnotempty_st);
   SIGNAL fsm_rx  : fsmrx_state;

   -- Définition du Mapping mémoire des registre PMP
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
   CONSTANT adreg_confrp   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(18, 7);
   CONSTANT adreg_promtx   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(19, 7);
   CONSTANT adreg_promrx   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(20, 7);
   CONSTANT adreg_promctl  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(21, 7);
   CONSTANT adreg_promnbrd : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(22, 7);
   CONSTANT adreg_crosspic : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(23, 7);
   CONSTANT adreg_numcyc   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(24, 7);
   CONSTANT adreg_invcrcmsb: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(25, 7);
   CONSTANT adreg_invcrclsb: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(26, 7);
   
   -- Déclaration des registres internes
   SIGNAL reg_tid       : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_ctl       : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_stat      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_rx1size   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_rx2size   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_txfree    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_fiforx1   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_fiforx2   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_confrp    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_promctl   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_promnbrd  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_crosspic  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_numcyc    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_invcrc    : STD_LOGIC_VECTOR(15 DOWNTO 0);

   -- Signaux de gestion de l'interface PMP
   SIGNAL buswrite         : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donnée à écrire depuis le bus
   SIGNAL busread          : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donnée lue sur le bus
   SIGNAL adreg            : STD_LOGIC_VECTOR(6 DOWNTO 0);  -- Bus d'adresse d'accès des registres PMP
   SIGNAL wr_reg           : STD_LOGIC;                     -- 1 Pulse pour ecrire le registre buswrite
   SIGNAL rd_reg           : STD_LOGIC;                     -- 1 pulse pour lire le registre busread
   SIGNAL pmrd_r           : STD_LOGIC_VECTOR(2 DOWNTO 0);  -- Pour le front du signal pmrd
   SIGNAL pmwr_r           : STD_LOGIC_VECTOR(2 DOWNTO 0);  -- Pour le front du signal pmwr
   SIGNAL pmall_r          : STD_LOGIC_VECTOR(2 DOWNTO 0);  -- Pour le front du signal pmall
   SIGNAL pulse_pmall      : STD_LOGIC;                     -- 1 pulse sur front de pmall

   -- Signaux de gestion interne
   SIGNAL bfo1    : STD_LOGIC;                           -- 1 pulse pour une trame reçue avec un format format sur port 1
   SIGNAL bfo2    : STD_LOGIC;                           -- 1 pulse pour une trame reçue avec un format format sur port 2
   
   SIGNAL difftx_free   : STD_LOGIC_VECTOR(11 DOWNTO 0); -- Pour calculer le nombre d'octets libres dans la FIFO Tx
   SIGNAL fifotx_datacnt: STD_LOGIC_VECTOR(11 DOWNTO 0); -- Nombre d'octets stockés dans la FIFO Tx
   SIGNAL wr_datatx     : STD_LOGIC;                     -- Signal d'écriture dans la FIFO Tx
   SIGNAL rd_datatx     : STD_LOGIC;                     -- Signal de lecture dans la FIFO Tx
   SIGNAL datatx_rd     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux lu dans la FIFO Tx
   SIGNAL fifotx_empty  : STD_LOGIC;                     -- FIFO Tx vide
   SIGNAL rst_fifotx    : STD_LOGIC;                     -- Pour clearer la FIFO Tx
   SIGNAL cpt_tx        : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Compteur d'octets à transmettre
   SIGNAL start_tx      : STD_LOGIC;                     -- Déclenche l'émission de la trame stockée dans la FIFO Tx
   SIGNAL clr_starttx   : STD_LOGIC;                     -- Reset de la commande d'émission
   SIGNAL mem_stuf      : STD_LOGIC;                     -- Mémorise la demande d'émission de caractères 7Eh
   
   SIGNAL fiforx_datacnt1: STD_LOGIC_VECTOR(10 DOWNTO 0);-- Nombre d 'octets dans la FIFO Rx1
   SIGNAL rd_datarx1     : STD_LOGIC;                    -- Lecture d'un octet dans la FIFO Rx1
   SIGNAL fiforx_empty1  : STD_LOGIC;                    -- FIFO Rx1 vide

   SIGNAL fiforx_datacnt2: STD_LOGIC_VECTOR(10 DOWNTO 0);-- Nombre d 'octets dans la FIFO Rx2
   SIGNAL rd_datarx2     : STD_LOGIC;                    -- Lecture d'un octet dans la FIFO Rx2
   SIGNAL fiforx_empty2  : STD_LOGIC;                    -- FIFO Rx2 vide

   SIGNAL l7_rd          : STD_LOGIC;           -- Signal de lecture dans le buffer applicatif Rx1 ou Rx2
   SIGNAL l7_rd1buf      : STD_LOGIC;           -- Signal de lecture dans la buffer applciatif Rx1      
   SIGNAL l7_rd2buf      : STD_LOGIC;           -- Signal de lecture dans la buffer applciatif Rx2
   SIGNAL sel_voie       : STD_LOGIC;           -- Sélection de la voie 1 ou 1
   SIGNAL frm2           : STD_LOGIC;           -- Indique une trame dispo dans le buffer Rx1
   SIGNAL frm1           : STD_LOGIC;           -- Indique une trame dispo dans le buffer Rx2
   SIGNAL comdispo       : STD_LOGIC;           -- Au moins une trame dispo dans le buffer sélectionné
   SIGNAL soc            : STD_LOGIC;           -- Indique un début de trame sur la voie sélectionnée

   COMPONENT fifotx_pmp
   PORT (
      rst      : IN STD_LOGIC;
      clk      : IN STD_LOGIC;
      din      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en    : IN STD_LOGIC;
      rd_en    : IN STD_LOGIC;
      dout     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full     : OUT STD_LOGIC;
      empty    : OUT STD_LOGIC;
      data_count : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
      );
   END COMPONENT;
   
   COMPONENT fiforx_pmp
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
   -- Process de gestion du PMP
   --------------------------------------------
   pmd <= busread WHEN pmrd = '1' ELSE (OTHERS => 'Z');  -- On place une donnée sur le bus synchrone à pmrd
   
   getadd : PROCESS(pmall)
   BEGIN
      IF (pmall'EVENT AND pmall = '1') THEN
      -- On latche les LSB du bus d'address
         adreg <= pmd(6 DOWNTO 0);
      END IF;      
   END PROCESS;
   
   getdat : PROCESS(pmwr)
   BEGIN
      IF (pmwr'EVENT AND pmwr = '0') THEN
      -- On latche la donnée à écrire sur front descendant de pmwr
         buswrite <= pmd;
      END IF;      
   END PROCESS;
   
   -- Gestion de la metastabiltié des signaux pmall, pmrd et pmwr pour passsage à clk_sys
   front_sig : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         pmall_r <= (OTHERS => '0');
         pmrd_r  <= (OTHERS => '0');
         pmwr_r  <= (OTHERS => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         pmall_r <= pmall_r(1 DOWNTO 0) & pmall;
         pmrd_r <= pmrd_r(1 DOWNTO 0) & pmrd;
         pmwr_r <= pmwr_r(1 DOWNTO 0) & pmwr;
      END IF;
   END PROCESS;
   pulse_pmall <= NOT(pmall_r(2)) AND pmall_r(1);  -- Front montant de pmall
   rd_reg <= NOT(pmrd_r(2)) AND pmrd_r(1);         -- Front montant de pmrd
   wr_reg <= pmwr_r(2) AND NOT(pmwr_r(1));         -- Front descendant de pmwr


   --------------------------------------------
   -- Process de gestion du Read en focntion de l'adresse(MUX)
   --------------------------------------------
   mux_read: PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         busread <= (OTHERS => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (pulse_pmall = '1') THEN
         -- Sur front montant de pmall (l'adresse a été latchée)
            CASE adreg IS
               WHEN adreg_iid    => busread <= iid(63 DOWNTO 56);
               WHEN adreg_iid+1  => busread <= iid(55 DOWNTO 48);
               WHEN adreg_iid+2  => busread <= iid(47 DOWNTO 40);
               WHEN adreg_iid+3  => busread <= iid(39 DOWNTO 32);
               WHEN adreg_iid+4  => busread <= iid(31 DOWNTO 24);
               WHEN adreg_iid+5  => busread <= iid(23 DOWNTO 16);
               WHEN adreg_iid+6  => busread <= iid(15 DOWNTO 8);
               WHEN adreg_iid+7  => busread <= iid(7 DOWNTO 0);
               WHEN adreg_tid    => busread <= reg_tid;
               WHEN adreg_ctl    => busread <= reg_ctl(7 DOWNTO 6) & mem_stuf & reg_ctl(4 DOWNTO 0);
               WHEN adreg_stat   => busread <= reg_stat;
               WHEN adreg_rxsize1=> busread <= reg_rx1size;
               WHEN adreg_rxsize2=> busread <= reg_rx2size;
               WHEN adreg_txfree => busread <= reg_txfree;
               WHEN adreg_fiforx1=> busread <= reg_fiforx1;
               WHEN adreg_fiforx2=> busread <= reg_fiforx2;
               -- WHEN adreg_fifotx => busread <= dummy  -- Ce registre est Write Only
               WHEN adreg_version=> busread <= version;
               WHEN adreg_confrp => busread <= reg_confrp;
               WHEN adreg_promctl=> busread <= rxprom_val & reg_promctl(6 DOWNTO 4) & prom_busy & reg_promctl(2 DOWNTO 0);
               WHEN adreg_promnbrd=>busread <= reg_promnbrd;
               -- WHEN adreg_promtx => data_rdspi <= dummy  -- Ce registre est Write Only
               WHEN adreg_promrx=>  busread <= rxprom_dat;
               WHEN adreg_crosspic  => busread <= reg_crosspic;
               WHEN adreg_numcyc    => busread <= sync_num_in;
               WHEN adreg_invcrcmsb => busread <= invcrc_in(15 DOWNTO 8);
               WHEN adreg_invcrclsb => busread <= invcrc_in(7 DOWNTO 0);
               WHEN OTHERS       => busread <= reg_stat;
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
         reg_tid <= x"8F";
         reg_ctl <= x"84";
         reg_confrp <= x"00";
         reg_promctl <= x"00";
         reg_promnbrd <= x"00";
         reg_crosspic <= x"00";
         reg_numcyc   <= x"00";
         reg_invcrc   <= x"0000";
         mem_stuf <= '0';
			sync_in_ack <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (wr_reg = '1') THEN
         -- Sur front descendant de pmwr (la donnée a été latchée dans buswrite)
            CASE adreg IS
               WHEN adreg_tid => 
                  reg_tid    <= buswrite;
               WHEN adreg_ctl => 
                  reg_ctl(7 DOWNTO 4)    <= buswrite(7 DOWNTO 4);
                  reg_ctl(2 DOWNTO 0)    <= buswrite(2 DOWNTO 0);
               WHEN adreg_confrp => 
                  reg_confrp <= buswrite;
               WHEN adreg_promnbrd => 
                  reg_promnbrd <= buswrite;
               WHEN adreg_numcyc =>
                  reg_numcyc  <= buswrite;
               WHEN adreg_invcrcmsb =>
                  reg_invcrc(15 DOWNTO 8) <= buswrite;
               WHEN adreg_invcrclsb =>
                  reg_invcrc(7 DOWNTO 0)  <= buswrite;
               WHEN OTHERS =>
            END CASE;
         END IF;
         IF (clr_starttx = '1') THEN
         -- Condition de reset du start_tx
            reg_ctl(3) <= '0';
         ELSE
            IF (wr_reg = '1') AND (adreg = adreg_ctl) AND (buswrite(3) = '1') THEN
            -- On ne peut écrire qu'un '1' dans le registre start_tx
               reg_ctl(3) <= '1';
            END IF;
         END IF;         
         IF (acq_stuf = '1') THEN
         -- condition de reset de l'ordre de stuffing
            mem_stuf <= '0';
         ELSE
            IF (wr_reg = '1') AND (adreg = adreg_ctl) AND (buswrite(5) = '1') THEN
            -- On ne peut écrire qu'un '1' dans le registre stuf_phys
               mem_stuf <= '1';
            END IF;
         END IF;
         IF (wr_reg = '1' AND adreg = adreg_promctl) THEN
            reg_promctl <= buswrite;
         ELSE
         -- Le bit 3 ne doit durer qu'un seul coup de clk_sys
            reg_promctl(3) <= '0';
         END IF;
         IF (wr_reg = '1' AND adreg = adreg_crosspic) THEN
            reg_crosspic(0) <= buswrite(0);
            reg_crosspic(2) <= buswrite(2);
            IF (buswrite(3) = '1') THEN
               sync_in_ack <= '1';
            END IF;
         ELSE
            sync_in_ack <= '0';
            IF (sync_out_ack = '1') THEN
               reg_crosspic(2) <= '0';
            END IF;
         END IF;
         reg_crosspic(1) <= lanscan_ack;
         reg_crosspic(3) <= new_sync_in;
      END IF;
   END PROCESS;
   -- Affectation des bits de controle et de configuration
   cpy1        <= reg_ctl(0);
   cpy2        <= reg_ctl(1);
   rst_fifotx  <= reg_ctl(2);
   start_tx    <= reg_ctl(3);   
   topcyc      <= reg_ctl(4);
   enafiltdble <= reg_ctl(6);
   repli       <= reg_ctl(7);
   actif       <= reg_confrp(0);
   baudrate    <= reg_confrp(3 DOWNTO 1);
   tid         <= reg_tid;
   stuf_phys   <= mem_stuf;
   sync_num_out<= reg_numcyc;
   lanscan_prg <= reg_crosspic(0);
   new_sync_out<= reg_crosspic(2);
   invcrc_out  <= reg_invcrc;

   --------------------------------------------
   -- Process de gestion du registre de status
   --------------------------------------------
   bfo1 <= l7_newframe1 AND NOT(l7_l2ok1);   -- Définition d'une mauvaise trame sur port 1
   bfo2 <= l7_newframe2 AND NOT(l7_l2ok2);   -- Définition d'une mauvaise trame sur port 2
   
   gest_stat : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_stat(7 DOWNTO 2) <= (OTHERS => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
      -- Les bits passent à '1' sur évènement et sont remis à '0' par un WOC
         IF (bfo1 = '1') THEN
         -- Si l'évènement est actif (plus prioritaire que le WOC) on le mémorise
            reg_stat(2) <= '1';
         ELSIF (wr_reg = '1' AND adreg = adreg_stat) THEN
         -- Si on écrit dans le registre
            reg_stat(2) <= reg_stat(2) AND NOT(buswrite(2));-- Un '1' dans le registre force à '0'. Un '0' laisse inchangé
         END IF;
         IF (bfo2 = '1') THEN
            reg_stat(3) <= '1';
         ELSIF (wr_reg = '1' AND adreg = adreg_stat) THEN
            reg_stat(3) <= reg_stat(3) AND NOT(buswrite(3));
         END IF;
         IF (l7_overflow1 = '1') THEN
            reg_stat(4) <= '1';
         ELSIF (wr_reg = '1' AND adreg = adreg_stat) THEN
            reg_stat(4) <= reg_stat(4) AND NOT(buswrite(4));
         END IF;
         IF (l7_overflow2 = '1') THEN
            reg_stat(5) <= '1';
         ELSIF (wr_reg = '1' AND adreg = adreg_stat) THEN
            reg_stat(5) <= reg_stat(5) AND NOT(buswrite(5));
         END IF;
			reg_stat(6) <= NOT(fifotx_empty);
			reg_stat(7) <= '0';
      END IF; 
   END PROCESS;
   reg_stat(1 DOWNTO 0) <= frm2 & frm1;

   -------------------------------------------------
   -- Signaux de gestion de l'I/F SPI vers la PROM
   -------------------------------------------------
   txprom_dat     <= buswrite;    -- Le registre est géré par le module PROM (affectation combinatoire)
   -- Le validant correspondant à un ordre d'écriture valide
   txprom_val     <= wr_reg WHEN (adreg =  adreg_promtx) ELSE '0';
   -- On récupère une donnée de plus dans la FIFO PROM avec une elcture valide
   rxprom_next    <= rd_reg WHEN (adreg =  adreg_promrx) ELSE '0';
   -- Affectation des signaux de controle
   prom_type_com  <= reg_promctl(0);
   prom_exec_com  <= reg_promctl(3);
   prom_rstn      <= reg_promctl(4);
   prom_nbread    <= reg_promnbrd;
   
   --------------------------------------------
   -- Process de gestion de la FIFO Tx
   --------------------------------------------
   difftx_free <= "100000000001" - fifotx_datacnt; -- Calcul du nombre d'octets dispo dans la FIFO 257-cnt
   reg_txfree <= x"FF" WHEN difftx_free(11 DOWNTO 8) /= "0000" ELSE  -- Si txfree >=256 on tronque le résultat
                     difftx_free(7 DOWNTO 0);              -- Sinon on donne le résultat

   -- Condition d'écriture d'un octet dans la FIFO TX
   wr_datatx <= '1' WHEN (wr_reg = '1' AND adreg = adreg_fifotx) ELSE '0';
   
   clr_fifo_tx <= '0';              -- Spare pour l'instant on ne fait pas de clear de la fifo tx aval

   -- On lit un octet dans la FIFO TX au début lorsqu'on détecte qu'elle n'est plus vide
   -- ou bien en cours de transfert lorsque le module suivant est dispo
   rd_datatx <= '1' WHEN ((fsm_tx = idle_st AND fifotx_empty = '0' AND start_tx = '1' AND tx_commena = '1') OR
                          (fsm_tx = senddat_st AND txdat_free = '1' AND fifotx_empty = '0')) ELSE
                    '0';

   val_txdat <= NOT(fifotx_empty) WHEN (fsm_tx = idle_st) ELSE '1';
   tx_dat <= datatx_rd;    -- Flux de donnée à transmettre lu dans la FIFO Tx
   -- Le EOF es tsynchrone de la dernière donnée transmise
   tx_eof <= txdat_free WHEN (fsm_tx = senddat_st AND cpt_tx = "00000001") ELSE '0';
   tx_available <= NOT(fifotx_empty) AND start_tx;
   -------------------------------------------
   -- Machine d'état de gestion de la transmission
   -- Attend l'ordre de transmission start_tx
   -- Lit la taille de la trame à transmettre (1er octet)
   -- Emet les octets qui suivent
   -------------------------------------------
   gest_fsm_tx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_tx <= idle_st;
         tx_sof       <= '0';
         cpt_tx       <= (OTHERS => '0');
         clr_starttx  <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_tx IS
            WHEN idle_st  => 
            -- Etat d'attente de données dans la FIFO TX
               IF (fifotx_empty = '0' AND start_tx = '1' AND tx_commena = '1') THEN
               -- Si il y'a des données dans la FIFO TX et qu'on reçoit l'ordre d'émettre et que l'arbitrage du module 
               -- de communication nosu autorise à émettre
                  cpt_tx <= datatx_rd;       -- On initialise le compteur avec la longueur de la trame
                  fsm_tx <= senddat_st;      -- On va transmettre des données
                  tx_sof <= '1';             -- On active le sof pour signaler un début de trame
                  clr_starttx <= '1';        -- Indique qu'on a pris en compte l'ordre de transmission
               END IF;

            WHEN senddat_st =>
            -- Etat de transfert d'une donnée
               clr_starttx <= '0';           -- On annule le clear du start_tx pour permettre au soiftde le remettre 
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

   inst_fiftx : fifotx_pmp
   PORT MAP (
      rst      => rst_fifotx,
      clk      => clk_sys,
      din      => buswrite,
      wr_en    => wr_datatx,
      rd_en    => rd_datatx,
      dout     => datatx_rd,
      full     => OPEN,
      empty    => fifotx_empty,
      data_count => fifotx_datacnt
   );                     
   
   --------------------------------------------
   -- Process de gestion des FIFO Rx
   --------------------------------------------
   -- On lit la bonne FIFO selon l'adresse du registre
   rd_datarx1 <= '1' WHEN (rd_reg = '1' AND adreg = adreg_fiforx1) ELSE '0';
   rd_datarx2 <= '1' WHEN (rd_reg = '1' AND adreg = adreg_fiforx2) ELSE '0';

   -- Odre de lecture dans le bon buffer selon la voie sélectionnée
   l7_rd1buf <= (l7_rd AND NOT(sel_voie) AND comdispo AND NOT(soc)) WHEN (fsm_rx = recdat_st) ELSE 
                (l7_rd AND NOT(sel_voie));
   l7_rd1 <= l7_rd1buf;
   l7_rd2buf <= (l7_rd AND sel_voie AND comdispo AND NOT(soc)) WHEN (fsm_rx = recdat_st) ELSE 
                (l7_rd AND sel_voie);
   l7_rd2 <= l7_rd2buf;
   
   -- Dispo des trames en fonction de la voie sélectionnée
   comdispo <= l7_comdispo1 WHEN (sel_voie = '0') ELSE l7_comdispo2;
   -- Début de trame en fonction de la voie sélectionnée
   soc <= l7_soc1 WHEN (sel_voie = '0') ELSE l7_soc2;

   ----------------------------------
   -- Machine d'état de récupération des trames dans le buffer applicatif
   -- et stockage dans la FIFO correspondante
   -- Les trames sont remontées une par une en alternant voie 1 / voie 2
   ----------------------------------
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
               frm1 <= NOT(fiforx_empty1);      -- On échantillonne la présence de trames pour être sur 
               frm2 <= NOT(fiforx_empty2);      -- qu'on ne traite que des trames entières
               IF ((l7_comdispo1 = '1' AND fiforx_empty1 = '1') AND 
                   (l7_comdispo2 = '0' OR  fiforx_empty2 = '0' OR sel_voie = '1')) THEN
               -- Si on a des trames en voie1 et qu'il n'y en a pas déjà une dans la FIFO
               -- Et que soit on peut traiter la voie 2 (pas de trame ou FIFO non vide) soit
               -- on a traité la voie 2 au coup d'avant
                  sel_voie <= '0';              -- On va traiter la voie 1
                  l7_rd <= '1';                 -- On lit en continu
                  fsm_rx <= pump_st;
               ELSIF (l7_comdispo2 = '1' AND fiforx_empty2 = '1') THEN
               -- si on peut traiter la voie 2
                  sel_voie <= '1';
                  l7_rd <= '1';
                  fsm_rx <= pump_st;
               ELSE
                  l7_rd <= '0';
               END IF;
               
            WHEN pump_st =>
            -- Etat d'attente pour amorcer la lecture de la mémoire applicative
               fsm_rx <= recdat_st;

            WHEN recdat_st =>
            -- Etat d'écriture des données jusqu'à ce que la mémoire applicative soit vide
            -- ou qu'on rencontre un début de trame
               IF (soc = '1' OR comdispo = '0') THEN
                  l7_rd <= '0';
                  fsm_rx <= waitnotempty_st;
               END IF;
               
            WHEN waitnotempty_st =>
            -- Etat d'attente que la FIFO soit indiquée comme non vide
            -- pour ne pas être rerentrant dans l'algo
               IF ((fiforx_empty1 = '0' AND sel_voie = '0') OR
                  (fiforx_empty2 = '0' AND sel_voie = '1')) THEN
                  frm1 <= NOT(sel_voie);
                  frm2 <= sel_voie;
                  fsm_rx <= idle_st;
               END IF;

            WHEN OTHERS =>
               fsm_rx <= idle_st;            
         END CASE;
      END IF;
   END PROCESS;

   inst_fifrx1 : fiforx_pmp
   PORT MAP (
      rst      => NOT(rst_n),
      clk      => clk_sys,
      din      => l7_rx1,
      wr_en    => l7_rd1buf,
      rd_en    => rd_datarx1,
      dout     => reg_fiforx1,
      full     => OPEN,
      empty    => fiforx_empty1,
      data_count => fiforx_datacnt1
   );                     
   -- Taille de la trame dans la FIFO : 255 si >= 256, sinon Nb octets dans la FIFO
   reg_rx1size <= x"FF" WHEN fiforx_datacnt1(10 DOWNTO 8) /= "000" ELSE
                      fiforx_datacnt1(7 DOWNTO 0);

   inst_fifrx2 : fiforx_pmp
   PORT MAP (
      rst      => NOT(rst_n),
      clk      => clk_sys,
      din      => l7_rx2,
      wr_en    => l7_rd2buf,
      rd_en    => rd_datarx2,
      dout     => reg_fiforx2,
      full     => OPEN,
      empty    => fiforx_empty2,
      data_count => fiforx_datacnt2
   );                     
   -- Taille de la trame dans la FIFO : 255 si >= 256, sinon Nb octets dans la FIFO
   reg_rx2size <= x"FF" WHEN fiforx_datacnt2(10 DOWNTO 8) /= "000" ELSE
                      fiforx_datacnt2(7 DOWNTO 0);
   
END rtl;

