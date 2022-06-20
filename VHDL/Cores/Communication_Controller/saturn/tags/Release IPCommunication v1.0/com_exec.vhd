--============================================================================= 
--  TITRE : COM_EXEC
--  DESCRIPTION : 
--       Exécute les actions codées dans la trame applicative 
--       Gère des registres Internes (zone d'adresse de 0 à 7F)
--       Gère les écritures et lectures des registres externes 
--       (zone d'adresse de 80 à FF)

--  FICHIER :        com_exec.vhd 
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

ENTITY com_exec IS
   GENERIC (
      freq_clksys : INTEGER := 48;                    -- Fréquence de l'horloge système en MHz
      reg_typemio : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";  -- Type du MIO
      reg_version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";  -- Version du MIO
      ad_ref      : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"80";  -- Adresse des registre à transmettre sur synchro
      sz_ref      : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"04"   -- Nombre d'octets à transmetrte sur synchro
      );
   PORT (
      -- Ports système
      clk_sys     : IN  STD_LOGIC;                    -- Clock système
      rst_n       : IN  STD_LOGIC;                    -- Reset général système
      tid         : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Adresse affectée au MIO (8F au reset)
      iid         : IN  STD_LOGIC_VECTOR(63 downto 0);-- Adresse IID du composant
      sync_lock   : OUT STD_LOGIC;                    -- Indique qu'on est calé sur une synchro

      -- Interfaces vers le bloc métier
      datout_write: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Données à écrire sur l'interface externe
      datout_read : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Données lues sur l'interface externe
      ad_out      : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- Adresse d'écriture et de lecture des données externes
      wr_out      : OUT STD_LOGIC;                    -- Signal d'écriture sur l'interface externe
      rd_out      : OUT STD_LOGIC;                    -- Signal de lecture sur l'interface externe
      
      -- Interfaces vers les modules layer2_rx
      activity1   : IN STD_LOGIC;                     -- 1 pulse indique qu'il y'a de l'activité sur le port de com 1
      activity2   : IN STD_LOGIC;                     -- 1 pulse indique qu'il y'a de l'activité sur le port de com 2
      
      -- Interfaces vers le module frame_store1
      datin1      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Données utiles de la couche applicative (commande, @, data)
      socin1      : IN STD_LOGIC;                     -- Indique que l'octet sur datin1 est le 1er d'une commande
      rd_datin1   : OUT STD_LOGIC;                    -- Signal de lecture d'un nouvel octet applicatif
      new_frame1  : IN STD_LOGIC;                     -- 1 Pulse indique qu'une nouvelle trame est disponible
      l7_ok1      : IN STD_LOGIC;                     -- 1 Pulse indique que la nouvelle trame est conforme du point de vue layer 7
      l7_overflow1: IN STD_LOGIC;                     -- Indique un débordement de la mémoire de frame_store
      com_dispo1  : IN STD_LOGIC;                     -- A 1 tant qu'il y'a des données de commande à traiter dans la DPRAM

      -- Interfaces vers le module frame_store2
      datin2      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Données utiles de la couche applicative (commande, @, data)
      socin2      : IN STD_LOGIC;                     -- Indique que l'octet sur datin2 est le 1er d'une commande
      rd_datin2   : OUT STD_LOGIC;                    -- Signal de lecture d'un nouvel octet applicatif
      new_frame2  : IN STD_LOGIC;                     -- 1 Pulse indique qu'une nouvelle trame est disponible
      l7_ok2      : IN STD_LOGIC;                     -- 1 Pulse indique que la nouvelle trame est conforme du point de vue layer 7
      l7_overflow2: IN STD_LOGIC;                     -- Indique un débordement de la mémoire de frame_store
      com_dispo2  : IN STD_LOGIC;                     -- A 1 tant qu'il y'a des données de commande à traiter dans la DPRAM

      -- Interfaces ver le module layer2_tx
      datsent     : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux de données applicatives à émettre
                                                       -- La première donnée du flux qui suit le sof est l'@ de destination
      valsent     : OUT  STD_LOGIC;                    -- validant du bus datsent
      sof         : OUT  STD_LOGIC;                    -- Indique le début d'une trame à émettre
      eof         : OUT STD_LOGIC;                     -- Indique le dernier octet de la trame à émettre
      datsent_free: IN  STD_LOGIC;                     -- Indique que le module layer2_tx a pris en compte l'octet datsent
      clr_fifo_tx : OUT STD_LOGIC;                     -- Signal de purge de la FIFO Tx

      -- Interface vers les modules switch
      copy_ena1   : OUT STD_LOGIC;                     -- Autorise la copie de Rx1 sur Tx2
      copy_ena2   : OUT STD_LOGIC;                     -- Autorise la copie de Rx2 sur Tx1
      
      -- Interface de pilotage du module SPI
      reload_fpgan: OUT STD_LOGIC;                     -- Ordre de reconfiguration du FPGA
      spitx_dat   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Data + commande à sérialiser
      spitx_val   : OUT STD_LOGIC;                     -- Validant de spitx_dat
      spirx_dat   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Data reçue
      spirx_val   : IN STD_LOGIC;                      -- Indique des données dispo dans spirx_val
      spirx_next  : OUT STD_LOGIC;                     -- Lit un octet de plus dans spirx_val
      spi_typecom : OUT STD_LOGIC;                     -- Type de commande à éxécuter
      spi_execcom : OUT STD_LOGIC;                     -- Ordre d'exécution d'une commande
      spi_busy    : IN  STD_LOGIC;                     -- Indique que le module SPI est occupé
      spi_nbread  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Nombre d 'octets à lire avec une commande de lecture
      spi_rstn    : OUT STD_LOGIC                      -- Reset du module SPI
      );
END com_exec;

ARCHITECTURE rtl OF com_exec IS
   CONSTANT typ_sync     : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";  -- Type pour trame de synchronisation
   CONSTANT typ_reqnoseq : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"08";  -- Type pour trame de requête non sécuritaire
   CONSTANT typ_repnoseq : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"80";  -- Type pour trame de réponse non sécuritaire
   CONSTANT typ_atttid   : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"3C";  -- Type pour trame d'attribution de TID
   CONSTANT com_write    : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"01";  -- Commande d'écriture dans une requête non sec
   CONSTANT com_read     : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"02";  -- Commande de lecture dans une requête non sec


   -- Définition des adresses des registres internes
   CONSTANT adreg_mac   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(0, 7);
   CONSTANT adreg_iid   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(8, 7);
   CONSTANT adreg_typ   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(16, 7);
   CONSTANT adreg_ver   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(17, 7);
   CONSTANT adreg_verpic: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(18, 7);
   CONSTANT adreg_tid   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(19, 7);
   CONSTANT adreg_sid   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(20, 7);
   -- CONSTANT adreg_outrep: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(23, 7);
   CONSTANT adreg_tcyc  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(24, 7);
   CONSTANT adreg_status: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(25, 7);
   --CONSTANT adreg_cnfrep: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(26, 7);
   --CONSTANT adreg_cnfcyc: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(27, 7);
   CONSTANT adreg_adref : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(28, 7);
   CONSTANT adreg_szref : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(29, 7);
   CONSTANT adreg_toco1 : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(30, 7);
   CONSTANT adreg_toco2 : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(31, 7);
   --CONSTANT adreg_seq   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(32, 7);
   CONSTANT adreg_toac1 : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(33, 7);
   CONSTANT adreg_toac2 : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(34, 7);
   CONSTANT adreg_sync  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(35, 7);
   CONSTANT adreg_for   : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(36, 7);
   CONSTANT adreg_conf  : STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(37, 7);
   CONSTANT adreg_loadfpga: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(124, 7);
   CONSTANT adreg_spinbr: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(125, 7);
   CONSTANT adreg_spictl: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(126, 7);
   CONSTANT adreg_spidat: STD_LOGIC_VECTOR(6 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(127, 7);
   
   -- Définition des registres internes
   SIGNAL reg_tid       : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_config    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_status    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_adref     : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_szref     : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_cpttoco1  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_cpttoco2  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_cpttoac1  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_cpttoac2  : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_cptsync   : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_cptfor    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_tcyc      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_spinbr    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_spictl    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL reg_loadfpga  : STD_LOGIC_VECTOR(7 DOWNTO 0);

   -- Signaux de gestion du cycle
   SIGNAL synchro       : STD_LOGIC;               -- 1 Pulse sur réception d'1 trame de synchro valide
   SIGNAL start_cycle   : STD_LOGIC;               -- 1 Pulse indique le début d'un cycle (sur synhcro ou timer interne)
   SIGNAL tc_tcyc       : STD_LOGIC_VECTOR(15 DOWNTO 0); -- Pour calculer reg_tcyc * 100
   SIGNAL mescycle      : STD_LOGIC_VECTOR(16 DOWNTO 0); -- compteur de mesure de périodes de 10us
   SIGNAL mes10us       : STD_LOGIC_vector(10 DOWNTO 0); -- Compteur de période de clk_sys pour mesurer 10us
   SIGNAL synchro_lock  : STD_LOGIC;               -- A 0 tant qu'on a pas reçu une première synchro
   SIGNAL win_syncbefore: STD_LOGIC;               -- Signal de validité d'une syncro en avance (dernier quart d'un cycle de com)
   SIGNAL win_syncafter : STD_LOGIC;               -- Signal de validité d'une synchro en retard (premier quart d'un cycle de com)
   SIGNAL synchro_miss  : STD_LOGIC;               -- 1 Pulse à 1 indique qu'on a pas reçu de trame de synhcro sur une durée de 1.125xTcyc
   SIGNAL cpt_seq       : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Compteur de numéro de cycle de communication en cours
   SIGNAL mem_sync      : STD_LOGIC;               -- Pour mémoriser le fait que le start_cycle est issue d'une trame de synchro
                                                         
   -- Signaux de gestion des monitoring
   SIGNAL mem_activity1 : STD_LOGIC;               -- Pour mémoriser une activité sur le port 1 entre 2 synchros
   SIGNAL mem_activity2 : STD_LOGIC;               -- Pour mémoriser une activité sur le port 2entre 2 synchros
   SIGNAL err_toco      : STD_LOGIC;               -- 1 Pulse indique une trame réçue sur un port mais pas sur l'autre
   SIGNAL voie_toco     : STD_LOGIC;               -- 0 pour err_toco sur le port 1, 1 pour err_toco sur le port 2

   -- Signaux d'interprétation et d'exécution des commandes
   SIGNAL datin         : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Données applicatives à traiter (voie 1 ou 2 multiplexée)
   SIGNAL rd_com        : STD_LOGIC;                     -- Ordre de fetch d'un nouvel octet de donnée applicative 
   SIGNAL com_dispo     : STD_LOGIC;                     -- Multiplexage de com_dispo 1 ou 2 selon la voie
   SIGNAL rd_combuf     : STD_LOGIC;                     -- Buffer provisoire pour multiplexer rd_com
   SIGNAL sel_voie      : STD_LOGIC;                     -- A 0 si on traite la voie 1, a 1 si on traite la voie 2
   SIGNAL typ_field     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Pour mémoriser le type de trame
   SIGNAL seq_field     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Pour mémoriser le champ SEQ de la trmae de synhcro
   SIGNAL com_field     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Pour mémoriser le champ COM d'une trame de requête non secu
   --SIGNAL ad_source     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Pour mémoriser l'adresse de l'expéditeur de la commande
   SIGNAL oldcom1       : STD_LOGIC_vector(9 DOWNTO 0);  -- Pour stocker jusqu'à 3 commandes
   SIGNAL oldcom2       : STD_LOGIC_vector(9 DOWNTO 0);  -- MSB = voie de réception de la commande, MSB - 1 : le registre est libre (0) ou occupé (1)
   SIGNAL oldcom3       : STD_LOGIC_vector(9 DOWNTO 0);  -- 8 LSB : champs TYP de la commande enregistrée 
   SIGNAL store_com     : STD_LOGIC;                     -- 1 pulse pour enregistrer la commande en cours dans un oldcomx
   SIGNAL delete_com    : STD_LOGIC;                     -- 1 pulse pour effacer la commande en cours des oldcomx
   SIGNAL com_recue     : STD_LOGIC;                     -- A 1 si la commande en cours a déjà été enregistrée dans un oldcomx
   SIGNAL synchro_valide: STD_LOGIC;                     -- A 1 si la commande en cours est une synchrone valide
   SIGNAL iid_temp      : STD_LOGIC_vector(63 DOWNTO 0); -- Registre à décalage pour la réception de l'adresse IID
   SIGNAL cpt_byt       : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Compteur d'octets en émission ou réception
   SIGNAL wr            : STD_LOGIC;                     -- Signal d'écriture d'un octet à l'adresse ad_buf
   SIGNAL rd            : STD_LOGIC;                     -- Signal de lecture d'un octet à l'adresse ad_buf
   SIGNAL rd_r          : STD_LOGIC;                     -- Pour retarder le signal rd de 1 cycle
   SIGNAL ad_buf        : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Adresse de lecture ou d'écriture
   SIGNAL wr_int        : STD_LOGIC;                     -- Signal d'écriture si ad_buf pointe sur un registre interne
   SIGNAL rd_int        : STD_LOGIC;                     -- Signal de lecture si ad_buf pointe sur un registre interne
   SIGNAL dataread      : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Multiplexeur pour la lecture
   SIGNAL memadbuf7     : STD_LOGIC;                     -- Pour latcher le MSB du adbus lors d'une lecture
   SIGNAL datawrite     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Pour latcher les données à écrire
   SIGNAL datint_read   : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Multiplexeur pour la lecture des registres internes
   SIGNAL socin         : STD_LOGIC;                     -- Multiplexage des signaux socinx
   SIGNAL synchro_outwin: STD_LOGIC;                     -- A 1 sur une synchro en dehors des fenêtres autorisées
   -- Signaux de gestion des SYNC absents
   SIGNAL cpt_syncmiss  : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Compteur de trames de synhcro absentes

   -- Machine d'état de gestion du module
   TYPE comexec_type IS (idle_st, rectyp_st, getadsrce_st, attribtid_st, purgesidsync_st, getseq_st, purgecrcsync_st, getadbuf_st, getnr_st, getcom_st, 
                         writebyt_st, startframe_st, sendseq_st, sendcom_st, sendsrce_st, sendadr_st, sendnr_st, senddata_st, 
                         sendstatus_st, endframe_st,purgecom_st);
   SIGNAL fsm_comexec   : comexec_type;
   


begin
   --------------------------------------------
   -- Affectation des sorties de configuration du module
   --------------------------------------------
   sync_lock <= synchro_lock;    -- Indique que le module est calé sur une synchro
   tid <= reg_tid;               -- Adresse attribuée au MIO à destination des autres modules
   copy_ena1 <= reg_config(0);   -- Autorisation de recopie du port 1 sur le port 2
   copy_ena2 <= reg_config(1);   -- Autorisationd e recopie du port 2 sur le port 1
   clr_fifo_tx <= '0';           -- On n'utilsie pas le clr des FIFO Tx pour l'instant
   spi_typecom <= reg_spictl(0); -- Type de commande sur le port SPI PROM
   spi_execcom <= reg_spictl(3); -- Lance l'exécution d'une commande SPI PROM
   spi_rstn <= reg_spictl(4);    -- Reset du module SPI PROM
   spi_nbread <= reg_spinbr;     -- Nombre d'octets à lire avec une commande lecture en PROM FPGA
 
   --------------------------------------------
   -- Gestion du signal de reprogrammation du FPGA
   --------------------------------------------
   gest_progb : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reload_fpgan <= '1';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (reg_spictl(4) = '0') THEN
         -- Tant que le reset du module SPI est actif
            reload_fpgan <= '1';             -- On fait rien
         ELSIF (reg_loadfpga = x"31") THEN
         -- Si le module SPI est actif et qu'on trouve la valeur magique dan le registre
            reload_fpgan <= '0';             -- On force la reprogrammation
         END IF;
      END IF;
   END PROCESS;
   
   --------------------------------------------
   -- Gestion des bus d'accès mémoire 
   --    interne (module SPI inclus)
   --    externe
   --------------------------------------------
   ad_out <= ad_buf(6 DOWNTO 0);    -- Bus d'accès aux registres externes (7 bits de long)
   datout_write <= datawrite;       -- Donnée à écrire dans un registre externe
   wr_int <= wr AND NOT(ad_buf(7)); -- On écrit un registre interne selon le MSB de l'@
   -- On lit un registre interne selon le MSB de l'@
   rd_int <= rd AND datsent_free AND NOT(ad_buf(7));  -- On ne lit rien si le module destination n'est pas prêt
   wr_out <= wr AND ad_buf(7);      -- On écrit un registre externe selon le MSB de l'@
   -- On lit un registre externe selon le MSB de l'@
   rd_out <= rd AND datsent_free AND ad_buf(7);       -- On ne lit rien si le module destination n'est pas prêt 

   -- On écrit dans la FIFO de commande SPI si signal d'écriture à l'adresse de la FIFO
   spitx_val <= wr_int WHEN (ad_buf(6 DOWNTO 0) =  adreg_spidat) ELSE '0';
   spitx_dat <= datawrite;          -- la donnée est directement sur le bus d'écriture (passe pas par un regditre)

   -- On fetche un octet de plus dans la FIFO de lecture SPI si signal de lecture à l'adresse de la FIFO
   spirx_next<= rd_int WHEN (ad_buf(6 DOWNTO 0) =  adreg_spidat) ELSE '0';   

   --------------------------------------------
   -- Gestion de la lecture sur le bus interne
   --------------------------------------------
   gest_readint : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         datint_read <= (others => '0');
         memadbuf7 <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_int = '1') THEN
            CASE ad_buf(6 DOWNTO 0) IS
            -- Décodage du registre lu en focntion de l'adresse du registre
               WHEN adreg_mac   | adreg_mac+1 | adreg_mac+2 | adreg_mac+3 |
                    adreg_mac+4 | adreg_mac+5 | adreg_mac+6 | adreg_mac+7 => datint_read <= x"FF";
               WHEN adreg_iid =>    datint_read <= iid( 7 DOWNTO  0);
               WHEN adreg_iid+1 =>  datint_read <= iid(15 DOWNTO  8);  
               WHEN adreg_iid+2 =>  datint_read <= iid(23 DOWNTO 16);
               WHEN adreg_iid+3 =>  datint_read <= iid(31 DOWNTO 24);
               WHEN adreg_iid+4 =>  datint_read <= iid(39 DOWNTO 32);
               WHEN adreg_iid+5 =>  datint_read <= iid(47 DOWNTO 40);
               WHEN adreg_iid+6 =>  datint_read <= iid(55 DOWNTO 48);
               WHEN adreg_iid+7 =>  datint_read <= iid(63 DOWNTO 56);
               WHEN adreg_typ =>    datint_read <= reg_typemio;
               WHEN adreg_ver =>    datint_read <= reg_version;
					WHEN adreg_verpic => datint_read <= x"00";
               WHEN adreg_tid =>    datint_read <= reg_tid;
               WHEN adreg_sid   | adreg_sid+1 | adreg_sid+2 => datint_read <= x"FF";
               WHEN adreg_tcyc =>   datint_read <= reg_tcyc;
               WHEN adreg_status => datint_read <= reg_status;
               WHEN adreg_adref =>  datint_read <= reg_adref;
               WHEN adreg_szref =>  datint_read <= reg_szref;
               WHEN adreg_toco1 =>  datint_read <= reg_cpttoco1;
               WHEN adreg_toco2 =>  datint_read <= reg_cpttoco2;
               WHEN adreg_toac1 =>  datint_read <= reg_cpttoac1;
               WHEN adreg_toac2 =>  datint_read <= reg_cpttoac2;
               WHEN adreg_sync =>   datint_read <= reg_cptsync;
               WHEN adreg_for =>    datint_read <= reg_cptfor;
               WHEN adreg_conf =>   datint_read <= reg_config;
               WHEN adreg_spinbr => datint_read <= reg_spinbr;
               WHEN adreg_spictl => datint_read <= spirx_val & reg_spictl(6 DOWNTO 4) & spi_busy & reg_spictl(2 DOWNTO 0);
               WHEN adreg_spidat => datint_read <= spirx_dat;
               WHEN OTHERS =>       datint_read <= reg_status;
            END CASE;
         END IF;
         IF (rd = '1') THEN
         -- sur une lecture, que ce soit interne ou externe
            memadbuf7 <= ad_buf(7);       -- On mémrosie quelle zone mémoire était lue
         END IF;
      END IF;
   END PROCESS;
   -- Lorsqu'on lit une donnée, on multiplexe soit le bus externe, soit les registres internes selon le MSB de l'adresse de lecture
   dataread <= datout_read WHEN memadbuf7 = '1' ELSE datint_read;

   --------------------------------------------
   -- Gestion des écritures dans les registres internes de configuration
   -- L'écriture dans les registres internes de status est gérée au cas par cas.
   --------------------------------------------
   gest_wrreg : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_config <= x"03";
         reg_adref  <= ad_ref;
         reg_szref  <= sz_ref;
         reg_tcyc   <= x"FF";
         reg_spinbr   <= x"00";
         reg_loadfpga <= x"00";
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (wr_int = '1') THEN
            CASE ad_buf(6 DOWNTO 0) IS
            -- Mise à jour du registre en focntion du décodage de l'adresse du registre
               WHEN adreg_conf =>
                  reg_config <= datawrite;
               WHEN adreg_adref =>
                  reg_adref <= datawrite;
               WHEN adreg_szref =>
                  reg_szref <= datawrite;
               WHEN adreg_tcyc =>
                  reg_tcyc <=  datawrite;
               WHEN adreg_loadfpga =>
                  IF (reg_spictl(4) = '1') THEN
                  -- On autorise la mise à jour du registre que si le reste SPI est relaché
                     reg_loadfpga <= datawrite;
                  END IF;
               WHEN adreg_spinbr =>
                  reg_spinbr <= datawrite;
               WHEN OTHERS =>
                  NULL;
            END CASE;
         END IF;
         IF (wr_int = '1' AND ad_buf(6 DOWNTO 0) = adreg_spictl) THEN     
            reg_spictl <= datawrite;
         ELSE
         -- On s'assure que le pulse de commande du SPI ne dure qu'un seul cycle
            reg_spictl(3) <= '0';
         END IF;
      END IF;
   END PROCESS;
   
   ----------------------------------
   -- Gestion du registre de status
   ----------------------------------
   gest_stat : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
      -- Par défaut le bit REP est à 1
         reg_status <= x"80";
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_int = '1' AND ad_buf(6 DOWNTO 0) = adreg_status) OR 
            (fsm_comexec = sendstatus_st AND datsent_free = '1') THEN
         -- Le registre status est resetté à chaque lecture
            reg_status <= x"00";
         ELSE
            IF (err_toco = '1') THEN
            -- Gestion du bit CNR (trame non reçue sur un des ports)
               reg_status(0) <= '1';
            END IF;
            -- Bit ESE non implémenté
            IF (start_cycle = '1' AND mem_activity1 = '0') THEN
            -- Gestion du bit NA1 (pas d'activité sur le port 1)
               reg_status(2) <= '1';
            END IF;
            IF (start_cycle = '1' AND mem_activity2 = '0') THEN
            -- Gestion du bit NA2 (pas d'activité sur le port 2)
               reg_status(3) <= '1';
            END IF;
            IF (synchro_miss = '1') THEN
            -- Gestion du bit NTS (pas de trame de synhcro)
               reg_status(4) <= '1';
            END IF;
            IF (new_frame1 = '1' AND l7_ok1 = '0') OR
               (new_frame2 = '1' AND l7_ok2 = '0') THEN
            -- Gestion du bit BFO (format de trame non supporté)
               reg_status(5) <= '1';
            END IF;
            reg_status(6) <= sel_voie;
            reg_status(7) <= '0';
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Gestion de la synchro
   --------------------------------------------
   gest_sync : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cpt_syncmiss <= (others => '0');
         synchro_lock <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (synchro_outwin = '1' AND synchro_lock = '1') THEN
         -- Sur synchro en dehors de la fenêtre alors qu'on est déjà locké
            cpt_syncmiss <= (others => '0');    -- On annule le compteur de trame de sync manquante
            synchro_lock <= '0';                -- On se délocke de la synchro d'avant
         ELSE
            IF (synchro = '1') THEN
            -- Sur chaque trame de synchro traitée
               synchro_lock <= '1';
               cpt_syncmiss <= (others => '0');   
            ELSIF (synchro_miss = '1') THEN
            -- Sur chaque cycle sans trame de synchro
               IF (cpt_syncmiss /= x"FF") THEN
               -- On comtpe de 0 à 255 et on s'arrêt de compter
                  cpt_syncmiss <= cpt_syncmiss + 1;
               ELSE
                  synchro_lock <= '0';          -- On considère qu'on a perdu la synchro au bout de 255 cycles sans synchro
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Gestion du temps de cycle de communication
   --------------------------------------------
   gest_cycle : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         mes10us <= (others => '0');
         mescycle <= CONV_STD_LOGIC_VECTOR(1, mescycle'LENGTH);
         tc_tcyc <= (OTHERS => '0');
         start_cycle <= '0';
         win_syncbefore <= '0';
         win_syncafter <= '0';
         synchro_miss <= '0';
         cpt_seq <= (others => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         --tc_tcyc <= reg_tcyc * 100;       -- reg_tcyc est en périodes de 1ms mais la mesure se fait en périodes de 10us
         tc_tcyc <= EXT(reg_tcyc & "000000", tc_tcyc'LENGTH) + EXT(reg_tcyc & "00000", tc_tcyc'LENGTH) + EXT(reg_tcyc & "00", tc_tcyc'LENGTH);
         IF (synchro = '1') THEN
         -- Si on a reçu une trame de synchro valide
            mes10us <= (others => '0');            -- Compteur de durée de 10us
            mescycle <= CONV_STD_LOGIC_VECTOR(1, mescycle'LENGTH);   -- Compteur de périodes de 10us (compte de 1 à TCYC)
            start_cycle <= '1';                    -- On indique au module un début de cycle
            win_syncbefore <= '0';                 -- On a plus besoin de la fenêtre de validité de synchro en avance
            win_syncafter <= '1';                  -- Par contre, onpeut recevoir une synchro en retard
            synchro_miss <= '0';                   
            cpt_seq <= seq_field;                  -- Le numéro de cycle est celui de la commande
         ELSE
            IF (mes10us = CONV_STD_LOGIC_VECTOR(freq_clksys*10-1, mes10us'length)) THEN
            -- Toutes les 10 us
               mes10us <= (others => '0');
               IF (mescycle = ('0' & tc_tcyc) + ("0000" & tc_tcyc(tc_tcyc'LEFT DOWNTO 3))) THEN
               -- Si on a mesuré 1.125xTCYC
                  win_syncbefore <= '0';           -- Les fenêtres de validité sont annulées
                  win_syncafter <= '0';
                  -- On remet le compteur à 0.125xTCYC pour mesure 1 TCYC entre 0.125 et 1.125TCYC
                  mescycle <= ("0000" & tc_tcyc(tc_tcyc'LEFT DOWNTO 3)) + 1;
                  synchro_miss <= '1';             -- On indique qu'on a manqué une synchro sur la période précédente
                  start_cycle <= '1';              -- On démarre un cycle sur ordre interne (pas de trame de synchro)
               ELSE
               -- Si on a pas encore atteind le 1.125xTCYC
                  mescycle <= mescycle + 1;
                  IF (mescycle = ('0' & tc_tcyc) - ("0000" & tc_tcyc(tc_tcyc'LEFT DOWNTO 3))) THEN
                  -- Si on est à 0.875x TCYC
                     win_syncbefore <= '1';        -- On active le signal de validité en avance de la synchro
                     win_syncafter <= '0';         -- Par contre la synchro en retard ne serait pas valide
                  ELSIF (mescycle = ('0' & tc_tcyc)) THEN
                  -- Si on est pile à TCYC
                     win_syncbefore <= '0';
                     win_syncafter <= '1';         -- On active le signal de validité en retard de la synchro
                     cpt_seq <= cpt_seq + 1;       -- On est dans le numéro de cycle suivant
                  ELSIF (mescycle = ("0000" & tc_tcyc(tc_tcyc'LEFT DOWNTO 3))) THEN
                  -- Si on est pile à 0.125xTCYC
                     win_syncafter <= '0';         -- On annule le signal de validité en retard de la synchro
                 END IF;
               END IF;
            ELSE
            -- pour tous les autres états dans le cycle
               start_cycle <= '0';                 -- On assure que les signaux ne durent qu'un clk
               synchro_miss <= '0';
               mes10us <= mes10us + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Gestion des compteurs de monitoring
   --------------------------------------------
   -- Compteur de trames avec un mauvais format (champs invalides, CRC faux, ...)
   gest_for : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_cptfor <= (others => '0');   
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_int = '1' AND ad_buf(6 DOWNTO 0) = adreg_for) THEN
         -- Le registre est remis à 0 ou à 1 lors d'une lecture selon la condition de génération
            IF (new_frame1 = '1' AND l7_ok1 = '0') OR (new_frame2 = '1' AND l7_ok2 = '0') THEN
               reg_cptfor(0) <= '1';
            ELSE
               reg_cptfor(0) <= '0';
            END IF;
            reg_cptfor(7 DOWNTO 1) <= "0000000";
         ELSIF (reg_cptfor /= x"FF") THEN
            IF (new_frame1 = '1' AND l7_ok1 = '0') OR
               (new_frame2 = '1' AND l7_ok2 = '0') THEN
            -- Sur réception d'une nouvelle trame avec un mauvais format quel que soit le port
               reg_cptfor <= reg_cptfor + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   -- Compteur d'absence de trame de synchro
   gest_abssync : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_cptsync <= (others => '0');   
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_int = '1' AND ad_buf(6 DOWNTO 0) = adreg_sync) THEN
         -- Le registre est remis à 0 ou à 1 lors d'une lecture selon la condition de génération
            reg_cptsync <= "0000000" & synchro_miss;
         ELSIF (reg_cptsync /= x"FF") THEN
            IF (synchro_miss = '1') THEN
               reg_cptsync <= reg_cptsync + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   -- Compteur de cycles sans activité sur le port 1
   gest_toac1 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_cpttoac1 <= (others => '0');
         mem_activity1 <= '1';         
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_int = '1' AND ad_buf(6 DOWNTO 0) = adreg_toac1) THEN
         -- Le registre est remis à 0 ou à 1 lors d'une lecture selon la condition de génération         
            IF (start_cycle = '1' AND mem_activity1 = '0') THEN
               reg_cpttoac1(0) <= '1';
            ELSE
               reg_cpttoac1(0) <= '0';
            END IF;
            reg_cpttoac1(7 DOWNTO 1) <= "0000000";
         ELSIF (reg_cpttoac1 /= x"FF") THEN
            IF (start_cycle = '1' AND mem_activity1 = '0') THEN
            -- A chaque début de cycle, si on a pas eu du tout d'activité
               reg_cpttoac1 <= reg_cpttoac1 + 1;
            END IF;
         END IF;
         IF (activity1 = '1') THEN
         -- Bascule JK de mémorisation d'activité
            mem_activity1 <= '1';
         ELSIF (start_cycle = '1') THEN
         -- Remise à 0 à chaque début de cycle
            mem_activity1 <= '0';
         END IF; 
      END IF;
   END PROCESS;

   -- Compteur de cycles sans activité sur le port 2
   gest_toac2 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_cpttoac2 <= (others => '0');
         mem_activity2 <= '1';         
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_int = '1' AND ad_buf(6 DOWNTO 0) = adreg_toac2) THEN
         -- Le registre est remis à 0 ou à 1 lors d'une lecture selon la condition de génération         
            IF (start_cycle = '1' AND mem_activity2 = '0') THEN
               reg_cpttoac2(0) <= '1';
            ELSE
               reg_cpttoac2(0) <= '0';
            END IF;
            reg_cpttoac2(7 DOWNTO 1) <= "0000000";
         ELSIF (reg_cpttoac2 /= x"FF") THEN
            IF (start_cycle = '1' AND mem_activity2 = '0') THEN
               reg_cpttoac2 <= reg_cpttoac2 + 1;
            END IF;
         END IF;
         IF (activity2 = '1') THEN
            mem_activity2 <= '1';
         ELSIF (start_cycle = '1') THEN
            mem_activity2 <= '0';
         END IF; 
      END IF;
   END PROCESS;

   -- Compteur de trames reçues sur le port 2 mais pas sur le port 1 durant le cycle
   gest_toco1 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_cpttoco1 <= (others => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_int = '1' AND ad_buf(6 DOWNTO 0) = adreg_toco1) THEN
         -- Sur lecture du registre, remise à 0 ou à 1 du compteur selon la condition de généraltion de l'évènement
            IF (err_toco = '1' AND voie_toco = '0') THEN
               reg_cpttoco1(0) <= '1';
            ELSE
               reg_cpttoco1(0) <= '0';
            END IF;
            reg_cpttoco1(7 DOWNTO 1) <= "0000000";
         ELSIF (reg_cpttoco1 /= x"FF") THEN
            IF (err_toco = '1' AND voie_toco = '0') THEN
            -- Si on a une trame absente (err_toco) sur le voie 1 (voie_toco)
               reg_cpttoco1 <= reg_cpttoco1 + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   -- Compteur de trames reçues sur le port 1 mais pas sur le port 2 durant le cycle
   gest_toco2 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         reg_cpttoco2 <= (others => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_int = '1' AND ad_buf(6 DOWNTO 0) = adreg_toco2) THEN
            IF (err_toco = '1' AND voie_toco = '1') THEN
               reg_cpttoco2(0) <= '1';
            ELSE
               reg_cpttoco2(0) <= '0';
            END IF;
            reg_cpttoco2(7 DOWNTO 1) <= "0000000";
         ELSIF (reg_cpttoco2 /= x"FF") THEN
            IF (err_toco = '1' AND voie_toco = '1') THEN
            -- Si on a une trame absente (err_toco) sur le voie 2 (voie_toco)
               reg_cpttoco2 <= reg_cpttoco2 + 1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- multiplexage des données selon si on traite la voie 1 ou la voie 2
   --------------------------------------------
   datin <= datin1 WHEN (sel_voie = '0') ELSE datin2;    -- Sélection de la donnée à traiter
   socin <= socin1 WHEN (sel_voie = '0') ELSE socin2;    -- Sélection du signal soc selon la voie
   rd_datin1 <= rd_combuf WHEN (sel_voie = '0') ELSE '0';-- On lit un octet de plus dans le bon buffer
   rd_datin2 <= rd_combuf WHEN (sel_voie = '1') ELSE '0';
   com_dispo <= com_dispo1 WHEN (sel_voie = '0') ELSE com_dispo2; -- Il y'a une commande dispo sur la voie sélectionnée
   
   -- Condition de lecture dans une méoire de commande. Si on est en purge, on lit jusqu'à la trame suivante 
   -- ou bien que la méoire soit vide
   rd_combuf <= rd_com AND com_dispo AND NOT(socin) WHEN (fsm_comexec = purgecom_st) ELSE 
                rd_com AND com_dispo;
  
   --------------------------------------------
   -- Mémorisation des commandes déjà reçues dans le cycle
   -- Format des oldcom
   --    MSB : Voie où la commande a été reçue
   --  MSB-1 : Le oldcom est occupé (une commande est mémorisée)
   --  8 LSB : champs de la commande
   -- Les oldcom sont gérés comme une FIFO (oldcom1 est le premier remplit)
   --------------------------------------------
   mem_oldcom : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         oldcom1 <= (others => '0');
         oldcom2 <= (others => '0');
         oldcom3 <= (others => '0');
         err_toco <= '0'; 
         voie_toco <= '0';
         mem_sync <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (synchro = '1') THEN
         -- mem_sync est une bascule JK de mémorisation de réception d'une trame de synchro dans le cycle en cours
            mem_sync <= '1';
         ELSIF (start_cycle = '1') THEN
         -- A chaque début de cycle (qu'il soit sur réception de synchro ou timer)
            mem_sync <= '0';
         END IF;
         IF (start_cycle = '1') THEN
         -- Au début d'un cycle
            IF (mem_sync = '1') THEN
            -- Si ce cycle a été induit par une trame de synchro
            -- On utilise typ_sync (en dur) au lieu de typ_field car typ_field est écrasé pour la trame réflexe
               oldcom1 <= sel_voie & '1' & typ_sync; -- On mémorise la commande
               oldcom2(8) <= '0';         -- Au début d'un cycle initié par une trame de synchro
               oldcom3(8) <= '0';         -- On purge les FIFO oldcom
            END IF;
            IF (oldcom1(8) = '1') THEN 
            -- Si la première case mémoire n'était pas vide
               err_toco <= '1';              -- Ca veut dire qu'une commande d'une cycle précédent n'a pas eu sa jumelle 
               voie_toco <= NOT(oldcom1(9)); -- On va incrémenter le compteur opposé au port
            ELSE
               err_toco <= '0';
            END IF;
         ELSIF (store_com = '1') THEN
         -- Sur réception d'un ordre de stockage de la commande, on cherche la première case vide
            IF (oldcom1(8) = '0') THEN
               oldcom1 <= sel_voie & '1' & typ_field;
            ELSIF (oldcom2(8) = '0') THEN
               oldcom2 <= sel_voie & '1' & typ_field;
            ELSIF (oldcom3(8) = '0') THEN
               oldcom3 <= sel_voie & '1' & typ_field;
            ELSE
            -- Si pas de case vide, on jette la plus vieille et on stoke à la fin de la file
               oldcom1 <= oldcom2;
               oldcom2 <= oldcom3;
               oldcom3 <= sel_voie & '1' & typ_field;
            END IF;
            err_toco <= '0';
         ELSIF (delete_com = '1') THEN
         -- Sur réception d'un ordre d'effacement (i.e. la commande en cours a déjà été reçue, donc on l'efface de la mémoire)
            IF (oldcom1 = NOT(sel_voie) & '1' & typ_field) THEN
            -- En principe, il faut que ce soit la première disponible car elles arrivent forcément dans le même ordre sur les 2 ports
               oldcom1 <= oldcom2;              -- On efface la première en recopiant la 2ème et la 3ème
               oldcom2 <= oldcom3;     
               oldcom3(8) <= '0';               -- On vide la 3ème case
               err_toco <= '0';                           
            ELSIF (oldcom2 = NOT(sel_voie) & '1' & typ_field) THEN
            -- Si la commande en cours est stockée en 2ème position, ça veut dire que la commande stockée
            -- en première position a été perdue sur l'autre port
               oldcom1 <= oldcom3;              -- On jette les 2 premières mémoires
               oldcom2(8) <= '0';
               oldcom3(8) <= '0';
               err_toco <= '1';                 -- On indique l'erreur   
               voie_toco <= NOT(oldcom1(9));    -- et sur quelle voie il y'a eu l'erreur
            ELSIF (oldcom3 = NOT(sel_voie) & '1' & typ_field) THEN
            -- Si la commande en cours est stockée en 3ème position, ça veut dire que les commandes stockées
            -- en première et deuxième position ont été perdues sur l'autre port. On a donc 2 erreurs à enregistrer
            -- On purge la mémoire 1 et 3 et on indiquee une erreur. On garde la mémoire 2 en mémoire 1 pour traiter l'erreur
            -- à la prochaine commande ou au début du cycle suivant
               oldcom1 <= oldcom2;              -- On purge donc toutes les mémoires
               oldcom2(8) <= '0';
               oldcom3(8) <= '0';
               err_toco <= '1';                 -- On indique l'erreur               
               voie_toco <= NOT(oldcom1(9));    -- et sur quelle voie il y'a eu l'erreur
            END IF;
         ELSE
            err_toco <= '0';                    -- Pour assurer qu'il ne dure qu'un seul cycle
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Machine d'état de gestion du module
   --------------------------------------------
   -- Une commande est déjà reçue sur l'autre port si elle dans une des 3 cases mémoires
   com_recue <= '1' WHEN ((oldcom1 = NOT(sel_voie) & '1' & datin) OR
                          (oldcom2 = NOT(sel_voie) & '1' & datin) OR
                          (oldcom3 = NOT(sel_voie) & '1' & datin)) ELSE '0';   
   
   -- Une trame de synchro est valide si c'est la première (synchro_lock = '0') ou bien si elle est
   -- dans la fenêtre de validité en avance avec SEQ = cpt_seq+1 ou bien si elle est dans la
   -- fenêtre de validité en retard avec SEQ = cpt_seq
   synchro_valide <= '1' WHEN (typ_field = typ_sync AND 
                              (synchro_lock = '0' OR
                              (win_syncbefore = '1' AND datin = cpt_seq + 1) OR
                              (win_syncafter = '1' AND datin = cpt_seq))) ELSE '0';

   man_fsm : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_comexec <= idle_st;
         sel_voie <= '1';
         cpt_byt <= (others => '0');
         reg_tid <= x"8F";
         wr <= '0';
         rd <= '0';
         rd_r <= '0';
         ad_buf <= (others => '0');
         --ad_source <= (others => '0');     -- Inutilisé car les TID sdestination sont en dur (multicast)
         store_com <= '0';
         delete_com <= '0';
         synchro_outwin <= '0';
         rd_com <= '0';
         sof <= '0';
         eof <= '0';
         datsent <= (others => '0');
         valsent <= '0';
         datawrite <= (others => '0');
         synchro <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_comexec IS
            WHEN idle_st =>
            -- Etat d'attente de données disponibles dans les modules frame_ana
               wr <= '0';
               rd <= '0';
               synchro <= '0';
               store_com <= '0';
               delete_com <= '0';
               synchro_outwin <= '0';
               sof <= '0';
               eof <= '0';
               valsent <= '0';
               IF (com_dispo1 = '1' AND (com_dispo2 = '0' OR sel_voie = '1')) THEN
               -- On s'assure qu'on traite par alternance une voie et puis l'autre. On traite la voie 1 que si y'a
               -- des données a traiter et que soit la voie 2 est vide soit on a traité la voie 2 au coup d'avant
                  sel_voie <= '0';              -- Sélection de la voie de traitement
                  rd_com <= '1';                -- On demande un octet de plus par anticipation
                  fsm_comexec <= rectyp_st;
               ELSIF (com_dispo2 = '1') THEN
               -- Si on des données dans la voie 2
                  sel_voie <= '1';              -- Sélection de la voie à traiter
                  rd_com <= '1';
                  fsm_comexec <= rectyp_st;
               ELSE
                  rd_com <= '0';
               END IF;
               
            WHEN rectyp_st =>
            -- Etat d'enregistrement du type de commande
               typ_field <= datin;    -- Mémorise la partie typ
               IF (com_recue = '0') THEN
               -- Si on a pas déjà reçu cette com dans ce cycle
                  fsm_comexec <= getadsrce_st;     -- 
                  IF (datin /= typ_sync) THEN
                  -- Si c'est pas une synchro, on l'enregistre. La synchro est mémorisée lors du start_cycle
                     store_com <= '1';
                  END IF;
               ELSE
               -- Si on a déjà reçu cette commande
                  delete_com <= '1';         -- On efface la commande des mémoires
                  fsm_comexec <= purgecom_st;-- On va purger la mémoire sans faire l'action associée
               END IF;
             
            WHEN getadsrce_st =>  
            -- Etat de récupération de l'adresse source de la commande
               --ad_source <= datin;
               store_com <= '0';
               delete_com <= '0';
               -- On va traiter la commande en fonction de son type
               IF (typ_field = typ_sync) THEN
               -- Si c'est une trame de synchro
                  cpt_byt <= x"01";
                  fsm_comexec <= purgesidsync_st;  -- On va purger le SID de la trame de synhcro
               ELSIF (typ_field = typ_atttid) THEN
               -- Si c'est une commande type attribution de TID
                  cpt_byt <= x"08";             -- On se prépare à recevoir l'@ IID (8 octets)
                  fsm_comexec <= attribtid_st;
               ELSIF (typ_field = typ_reqnoseq) THEN
               -- Si c'est une commande non sécu
                  fsm_comexec <= getcom_st;
               ELSE
               -- Si c'est une trame qu'on ne sait pas traiter, on va la purger
                  rd_com <= '0';
                  fsm_comexec <= purgecom_st;
               END IF;

            WHEN purgesidsync_st =>
            -- Etat d'attente de récupération du SID de la trame de synhcro (on n'en fait rien)
               cpt_byt <= cpt_byt - 1;
               IF (cpt_byt = "00") THEN
                  fsm_comexec <= getseq_st;
               END IF;

            WHEN getseq_st =>
            -- Etat de réception du compteur de séquence de la trame de SYNC
               seq_field <= datin;
               IF (synchro_valide = '1') THEN
               -- Si le champ SEQ est valable
                  rd_com <= '1';                -- On continu de lire pour supprimer le CRC
                  synchro <= '1';               -- On signale une synchro valide
                  IF (reg_config(3) = '1') THEN
                  -- Si on est autorisé à émettre la trame de réponse réflexe
                  -- On va d'abord purger les 2 CRC de la commande
                     fsm_comexec <= purgecrcsync_st;
                     cpt_byt <= x"01";
                  ELSE
                  -- Si on n'est pas autorisé à émettre la trame réflexe
                     fsm_comexec <= purgecom_st;   -- On va purger la commande
                  END IF;
               ELSE
                  IF (win_syncbefore = '0' AND win_syncafter = '0') THEN
                  -- Si on a reçu une trame de synchro en dehors des fenêtres de validité
                     synchro_outwin <= '1';
                  END IF;               
                  fsm_comexec <= purgecom_st;
                  rd_com <= '0';
               END IF;

            WHEN purgecrcsync_st =>
            -- Etat de purge des 2 octets de CRC de la trmae de synchro
               synchro <= '0';
               cpt_byt <= cpt_byt - 1;
               IF (cpt_byt = "00") THEN
                  -- Si on a fini de purger le CRC de la trame de synchro
                  fsm_comexec <= startframe_st; -- On va émettre une trame
                  sof <= '1';
                  datsent <= x"F0";             -- Le 1er octet à envoyer est l'adresse de destination (i.e multicast concentrateur)
                  valsent <= '1';               -- On valide l'octet sorti
                  ad_buf <= reg_adref;          -- l'@ des données à émettre est donnée par ce registre
                  cpt_byt <= reg_szref;         -- le nombre d'octets à émettre est donné par ce registre
                  rd_com <= '0';
               END IF;

            WHEN attribtid_st =>
            -- Etat d'exécution d'une trame d'attribution de TID
               iid_temp <= datin & iid_temp(63 DOWNTO 8);   -- On récupère l'@ IID octet par octet
               cpt_byt <= cpt_byt - 1;
               IF (cpt_byt = x"00") THEN
               -- Si on reçu les 8 octets
                  IF (iid_temp = iid) THEN
                  -- Si l@ IID reçue correspond à l'@ IID du module
                     reg_tid <= datin;                    -- On mémorise le nouveau TID
                  END IF;
                  fsm_comexec <= idle_st;
                  rd_com <= '0';
               END IF;

            WHEN getcom_st =>
            -- Etat de récupération de l'octet de commande de la trame de requête non sécu
               com_field <= datin;
               rd_com <= '1';
               fsm_comexec <= getnr_st;

            WHEN getnr_st =>
            -- Etat de récupération du nombre d'octets à traiter dans la requête, que ce soit une écriture ou une lecture
               cpt_byt <= datin;
               rd_com <= '1';
               fsm_comexec <= getadbuf_st;

            WHEN getadbuf_st =>
            -- Etat de récupération de l'adresse où lire ou écrire
               ad_buf <= datin;
               IF (com_field = com_write) THEN
               -- Si c'est une commande d'écriture
                  fsm_comexec <= writebyt_st;
                  rd_com <= '1';
               ELSIF (com_field = com_read) THEN
               -- Si c'est une commande de lecture
                  fsm_comexec <= startframe_st; -- On va émettre une trame
                  sof <= '1';                   -- On signale au module layer2_Tx qu'on veut émettre une trame
                  datsent <= x"F0";             -- Le 1er octet à envoyer est l'adresse de destination (i.e multicast concentrateur)
                  valsent <= '1';               -- On valide l'octet sorti
                  rd_com <= '0';                -- On ne lit plus rien de la commande pour l'instant
               ELSE               -- Si c'est autre chose, il y'a eu un problème de desynchronisation -> on va purger la mémoire de commande
                  fsm_comexec <= purgecom_st;
                  rd_com <= '0';
               END IF;
         
            WHEN writebyt_st =>
            -- Etat d'écriture d'une séquence d'octets
               datawrite <= datin;
               wr <= '1';
               cpt_byt <= cpt_byt - 1 ;
               IF (wr = '1' AND (ad_buf /= ('0' & adreg_spidat)) AND ad_buf /= x"FF") THEN            
               -- on n'incrémente l'adresse que si le WR a été effectué
               -- Si on accède à la FIFO SPI, le registre d'addresse reste bloqué à cette valeur
                  ad_buf <= ad_buf + 1;
               END IF;
               IF (cpt_byt = x"01") THEN
               -- Si on a traité tous les octets
                  rd_com <= '0';             -- On arrête de lire dans la commande
                  fsm_comexec <= idle_st;    -- Mais le signal de wr reste actif un cycle de plus (remis à 0 dans idle)
               END IF;
               
            WHEN startframe_st =>
               -- Prépare l'envoie d'une trame
               synchro <= '0';   -- Le signal de synhcro ne doit durer qu'1 pulse
               IF (datsent_free = '1') THEN
               -- Si le 1er octet est en cours de traitement, l'octet suivant est le TYPE
                  sof <= '0';             -- Le sof a été pris en compte
                  datsent <= x"80";       -- Type de réponse non sécu
                  valsent <= '1';
                  fsm_comexec <= sendsrce_st;
               END IF;
               
            WHEN sendsrce_st =>
            -- Envoie l'@ source (i.e l'@ du MIO) de la trame à émettre
               IF (datsent_free = '1') THEN
                  datsent <= reg_tid;   
                  valsent <= '1';
                  fsm_comexec <= sendcom_st;
               END IF;

            WHEN sendcom_st =>
            -- Envoie du numéro de séquence courante
               IF (datsent_free = '1') THEN
                  IF (typ_field = typ_sync) THEN
                  -- Si on répond à une trame de synchro
                     datsent <= x"01";
                  ELSE
                  -- Si on répond à une trame de requête
                     datsent <= x"02";
                  END IF;
                  valsent <= '1';
                  fsm_comexec <= sendnr_st;
               END IF;

            WHEN sendnr_st =>
            -- Envoie du nombre d 'octets lus
               IF (datsent_free = '1') THEN
                  datsent <= cpt_byt;   
                  valsent <= '1';
                  fsm_comexec <= sendadr_st;
               END IF;

            WHEN sendadr_st =>
            -- Envoie de l'adresse ou on a lu les octets
               IF (datsent_free = '1') THEN
                  datsent <= ad_buf;   
                  rd <= '1';
                  rd_r <= '0';
                  valsent <= '1';
                  fsm_comexec <= senddata_st;
               END IF;

            WHEN senddata_st =>
            -- Envoie les octets lus. rd_r est utilisé pour signaler que la donnée en lecture est disponible.
            -- Il est décalé de 1 cycle par rappott à rd 
               IF (rd = '1' AND datsent_free = '1') THEN
                  rd_r <= '1';
                  IF ((ad_buf /= ('0' & adreg_spidat)) AND ad_buf /= x"FF") THEN
                  -- Si on accède à la FIFO rx du SPI, on reste calé sur cette adresse
                     ad_buf <= ad_buf + 1;
                  END IF;
                  cpt_byt <= cpt_byt - 1;
               END IF;
               IF (datsent_free = '1') THEN
               -- Si le module layer2_tx est dispo pour prendre la donnée
                  IF (cpt_byt = x"01") THEN
                     rd <= '0';                       -- Il ne faut plus lire en mémoire
                  END IF;
                  IF (rd_r = '1') THEN
                  -- Si le module layer2_tx est dispo et qu'une donnée est dispo
                     datsent <= dataread;         -- On l'envoie
                     valsent <= '1';
                     IF (cpt_byt = x"00") THEN
                     -- Si c'est la dernière donnée
                        IF (typ_field = typ_sync) THEN
                        -- Si on répond à une trame de synchro
                           fsm_comexec <= sendstatus_st; -- Il faut envoyer l'octet de status
                        ELSE
                        -- Si c'est une requête normale
                           fsm_comexec <= endframe_st; -- On a fini
                           eof <= '1';
                        END IF;
                     END IF;
                  ELSE
                  -- S'il n'y a pas dedonnée prête (cas se présente quand on rentre dans cet état et qu'on a pas encore lu)  
                     valsent <= '0';         -- On indique au module layer2_tx qu'il n'y a pas de nouvelle donnée
                  END IF;
               END IF;

            WHEN sendstatus_st =>
            -- Envoie du registre de status
               IF (datsent_free = '1') THEN
                  datsent <= reg_status;
                  valsent <= '1';
                  eof <= '1';
                  fsm_comexec <= endframe_st;
               END IF;

            WHEN endframe_st =>
            -- Gestion de la fin d'envoie d'une trame
               IF (datsent_free = '1') THEN
                  eof <= '0';
                  valsent <= '0';
                  fsm_comexec <= idle_st;
               END IF;

            WHEN purgecom_st =>
            -- Purge la mémoire de commande pour se recaler au début de la commande suivante
            -- en cas de problème ou en cas de commande déjà reçue
               store_com <= '0';
               delete_com <= '0';
               synchro_outwin <= '0';
               IF (sel_voie = '0') THEN
                  IF (com_dispo1 = '1' AND socin1 = '0') THEN
                  -- On lit jusqu'à ce qu'il n'y ait plus de commande ou qu'on ait atteind le début de la commande suivante
                     rd_com <= '1';
                  ELSE
                     rd_com <= '0';
                     fsm_comexec <= idle_st;
                  END IF;
               ELSE
                  IF (com_dispo2 = '1' AND socin2 = '0') THEN
                     rd_com <= '1';
                  ELSE
                     rd_com <= '0';
                     fsm_comexec <= idle_st;
                  END IF;
               END IF;
               
            WHEN OTHERS =>
               fsm_comexec <= idle_st;
         END CASE;
      END IF;
   END PROCESS;

end rtl;

