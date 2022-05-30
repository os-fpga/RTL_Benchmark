--============================================================================= 
--  TITRE : CON_COMMUNICATION_SIL4
--  DESCRIPTION : 
--        Implémente la pile communication SATURN	coté concentrateur	
--  FICHIER :        con_communication_sil.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION
--  27/04/15   DRA      SATURN   V1.1
--     Augmentation des FIFO fifo_tx pour permettre au pic de stocker
--     d'avantage de trames de commande.
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY con_communication_sil4 IS
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;                    -- Clock système
      rst_n    : IN  STD_LOGIC;                    -- Reset général système
      baudrate : IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- Baudrate en mdoe maitre
      actif    : IN  STD_LOGIC;                    -- Indique que le concentrateur est actif
      ad_con   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Addresse logique du concentrateur (TID)
      top_cycle: IN  STD_LOGIC;                    -- TOP de synchro de début de cycle
      ena_filt_dble : IN STD_LOGIC;                -- Autorise le filtrage des trames en double

      -- Interfaces séries 1 et 2
      rx1      : IN  STD_LOGIC;                    -- Réception série port 1 
      tx1      : OUT STD_LOGIC;                    -- Transmission série port 1
      rx2      : IN  STD_LOGIC;                    -- Réception série port 2
      tx2      : OUT STD_LOGIC;                    -- Transmission série port 2

      copy_ena1: IN  STD_LOGIC;                    -- Autorise la recopie du port 1 sur le port 2
      copy_ena2: IN  STD_LOGIC;                    -- Autorise la recopie du port 2 sur le port 1
     
      -- Interfaces de lecture des trames port 1 côté µC1
      filt_rx1_uc1   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Données applicatives reçues sur port 1
      filt_soc1_uc1  : OUT STD_LOGIC;           -- Indique un début de trame
      filt_rd1_uc1   : IN  STD_LOGIC;           -- Signal de lecture d'un octet de plus
      filt_comdispo1_uc1 : OUT STD_LOGIC;       -- Indique qu'au moins une trame est dispo en mémoire
      layer7_newframe1 : OUT STD_LOGIC;         -- Indique la réception d'une nouvelle trame
      layer7_l2ok1     : OUT STD_LOGIC;         -- Indique que la trame reçue est conforme
      layer7_overflow1 : OUT STD_LOGIC;         -- Indique un débordement de mémoire
      -- Interfaces de lecture des trames port 2 côté µC1
      filt_rx2_uc1   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem port 1
      filt_soc2_uc1  : OUT STD_LOGIC;
      filt_rd2_uc1   : IN  STD_LOGIC;
      filt_comdispo2_uc1 : OUT STD_LOGIC;
      layer7_newframe2 : OUT STD_LOGIC;
      layer7_l2ok2     : OUT STD_LOGIC;
      layer7_overflow2 : OUT STD_LOGIC;
      -- Interfaces de lecture des trames port 1 côté µC1
      filt_rx1_uc2   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Données applicatives reçues sur port 1
      filt_soc1_uc2  : OUT STD_LOGIC;           -- Indique un début de trame
      filt_rd1_uc2   : IN  STD_LOGIC;           -- Signal de lecture d'un octet de plus
      filt_comdispo1_uc2 : OUT STD_LOGIC;       -- Indique qu'au moins une trame est dispo en mémoire
      -- Interfaces de lecture des trames port 2 côté µC1
      filt_rx2_uc2   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem port 1
      filt_soc2_uc2  : OUT STD_LOGIC;
      filt_rd2_uc2   : IN  STD_LOGIC;
      filt_comdispo2_uc2 : OUT STD_LOGIC;

      -- Interfaces de lecture des trames reçues sur le port 1 pour le PCIe
      data_storerx1  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données
      val_storerx1   : OUT STD_LOGIC;              -- Validant du bus data
      sof_storerx1   : OUT STD_LOGIC;              -- Début de trame
      eof_storerx1   : OUT STD_LOGIC;              -- Fin de trame
      crcok_storerx1 : OUT STD_LOGIC;              -- CRC ok pour la trame reçue

      -- Interfaces de lecture des trames reçues sur le port 2 pour le PCIe
      data_storerx2  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem quepour port 1
      val_storerx2   : OUT STD_LOGIC;
      sof_storerx2   : OUT STD_LOGIC;
      eof_storerx2   : OUT STD_LOGIC;
      crcok_storerx2 : OUT STD_LOGIC;

      -- Interface d'écriture des trames côté µC1
      txdat_free       : OUT STD_LOGIC;         -- Indique que le module couche transport Tx est dispo
      acq_stuf         : OUT STD_LOGIC;         -- Indique que la commande d'envoi des caractères 7Fh est terminée

      tx_dat_uc1       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données applicatives à transmettre
      val_txdat_uc1    : IN  STD_LOGIC;         -- Indique un octet dispo sur tx_dat
      tx_sof_uc1       : IN  STD_LOGIC;         -- Indique un début de trame
      tx_eof_uc1       : IN  STD_LOGIC;         -- Indique une fin de trame
      clr_fifo_tx_uc1  : IN  STD_LOGIC;         -- Clear de la FIFO transport Tx
      stuf_phys_uc1    : IN  STD_LOGIC;         -- Pour envoyer des caractères de controle 7Fh
      tx_available_uc1 : IN  STD_LOGIC;         -- Signale au module de communication qu'une trame est en attente d'émission
      tx_commena_uc1   : OUT STD_LOGIC;         -- Autorise l'émission de la trame en attente

      -- Interface d'écriture des trames côté µC2
      tx_dat_uc2       : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données applicatives à transmettre
      val_txdat_uc2    : IN  STD_LOGIC;         -- Indique un octet dispo sur tx_dat
      tx_sof_uc2       : IN  STD_LOGIC;         -- Indique un début de trame
      tx_eof_uc2       : IN  STD_LOGIC;         -- Indique une fin de trame
      clr_fifo_tx_uc2  : IN  STD_LOGIC;         -- Clear de la FIFO transport Tx
      stuf_phys_uc2    : IN  STD_LOGIC;         -- Pour envoyer des caractères de controle 7Fh
      tx_available_uc2 : IN  STD_LOGIC;         -- Signale au module de communication qu'une trame est en attente d'émission
      tx_commena_uc2   : OUT STD_LOGIC;         -- Autorise l'émission de la trame en attente
      
      -- Trames UC1 et UC2 Tx multiplexées vers la passerelle
      tx_dat_pas       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      val_txdat_pas    : OUT STD_LOGIC;
      tx_sof_pas       : OUT STD_LOGIC;
      tx_eof_pas       : OUT STD_LOGIC
      );
END con_communication_sil4;

ARCHITECTURE rtl of con_communication_sil4 is
   -- Définit le nombre de bit nécessaires pour mesurer la durée du bit le plus lent avec l'horloge système
   -- i.e. 1 Bit à 50Kbit/s = 20µs nbbit_div = Log2(96MHz x 20µs)
   CONSTANT nbbit_div      : INTEGER := 11;
   CONSTANT freq_clk       : INTEGER := 96;     -- clk_sys = 96MHz

   -- DFF pour la métastabilité de rx1 et rx2
   SIGNAL rx1_r1, rx1_r2   : STD_LOGIC;
   SIGNAL rx2_r1, rx2_r2   : STD_LOGIC;
   
   -- Diviseur d'horloge pour le baud rate
   SIGNAL tc_divclk        : STD_LOGIC_VECTOR(nbbit_div - 1 DOWNTO 0);  -- Diviseur multiplexé selon le mode
   SIGNAL divclk_autobaud  : STD_LOGIC_VECTOR(nbbit_div - 1 DOWNTO 0);  -- diviseur déterminé par la fonction d'autobaud
   SIGNAL baud_locked      : STD_LOGIC;                  -- Indique que l'algo d'autobaud a convergé

   -- Interfaces du SWITCH1
   SIGNAL layer1_rx1    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de donnée brut reçu sur Rx1
   SIGNAL layer1_val1   : STD_LOGIC;                     -- Validant du flux ded onnée sur Rx1
   SIGNAL sw_ena1       : STD_LOGIC;                     -- Indique qu'on est entre 2 trames en réception
   SIGNAL layer1_tx1    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de donnée brut à transmettre sur Tx1
   SIGNAL layer1_rd1    : STD_LOGIC;                     -- Demande un octet de plus à transmettre sur Tx1
   SIGNAL layer1_empty1 : STD_LOGIC;                     -- Indique que la FIFO de transmission sur Tx1 est vide
   
   -- Interfaces du SWITCH2
   SIGNAL layer1_rx2    : STD_LOGIC_VECTOR(7 DOWNTO 0);     -- Idem que pour le port 1
   SIGNAL layer1_val2   : STD_LOGIC;
   SIGNAL sw_ena2       : STD_LOGIC;
   SIGNAL layer1_tx2    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL layer1_rd2    : STD_LOGIC;
   SIGNAL layer1_empty2 : STD_LOGIC;
   
   -- Interfaces du module layer2_rx1_pic
   SIGNAL layer2_rx1_pic    : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux de données destuffé port 1
   SIGNAL layer2_rxval1_pic : STD_LOGIC;
   SIGNAL layer2_sof1_pic   : STD_LOGIC;
   SIGNAL layer2_eof1_pic   : STD_LOGIC;
   SIGNAL layer2_l2ok1_pic  : STD_LOGIC;   
   SIGNAL dont_keep1        : STD_LOGIC;

   -- Interfaces du module layer2_rx2_pic
   SIGNAL layer2_rx2_pic    : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux de données destuffé port 2
   SIGNAL layer2_rxval2_pic : STD_LOGIC;
   SIGNAL layer2_sof2_pic   : STD_LOGIC;
   SIGNAL layer2_eof2_pic   : STD_LOGIC;
   SIGNAL layer2_l2ok2_pic  : STD_LOGIC;
   SIGNAL dont_keep2        : STD_LOGIC;

   -- Interfaces du module FRAME_STORE1
   SIGNAL layer7_rx1       : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données
   SIGNAL layer7_soc1      : STD_LOGIC;            -- Indique un début de trame
   SIGNAL layer7_rd1       : STD_LOGIC;            -- Signal de elcture d'un octet de plus
   SIGNAL layer7_comdispo1 : STD_LOGIC;            -- Indique qu'au moins une trame est dispo
   SIGNAL overflow_store1  : STD_LOGIC;            -- Indique qu'une trame n'a pas pu être stockée
   SIGNAL overflow_filter1 : STD_LOGIC;            -- Overflow de l'algo de filtrage doubletrame coté 1

   -- Interfaces du module FRAME_STORE2
   SIGNAL layer7_rx2       : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données
   SIGNAL layer7_soc2      : STD_LOGIC;            -- Indique un début de trame
   SIGNAL layer7_rd2       : STD_LOGIC;            -- Signal de elcture d'un octet de plus
   SIGNAL layer7_comdispo2 : STD_LOGIC;            -- Indique qu'au moins une trame est dispo
   SIGNAL overflow_store2  : STD_LOGIC;            -- Indique qu'une trame n'a pas pu être stockée
   SIGNAL overflow_filter2 : STD_LOGIC;            -- Overflow de l'algo de filtrage doubletrame coté 2

   -- Interfaces du module LAYER2_TX
   SIGNAL layer2_txdat     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux ded onnée applicatif à transmettre
   SIGNAL layer2_txval     : STD_LOGIC;
   SIGNAL layer2_progfull1 : STD_LOGIC;                     -- FIFO Tx1 presque pleine
   SIGNAL layer2_progfull2 : STD_LOGIC;                     -- FIFO Tx2 presque pleine
   SIGNAL layer2_full1     : STD_LOGIC;                     -- FIFO Tx1 pleine
   SIGNAL layer2_full2     : STD_LOGIC;                     -- FIFO Tx2 pleine
   SIGNAL txdat_free_buf   : STD_LOGIC;                     -- Indique que le module Tx est dipo pour prendre une donnée

   -- Signaux de multiplexage des écritures des trames Tx par les 2 PIC
   SIGNAL mux_tx       : STD_LOGIC;         -- '0' pour sélectionner le PIC1 comme émetteur, '1' pour le PIC2
   SIGNAL tx_encours   : STD_LOGIC;         -- indique qu'une FIFO Tx d'un des PIC est en cours de transfert
   SIGNAL tx_dat       : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données applicatives à transmettre
   SIGNAL val_txdat    : STD_LOGIC;         -- Indique un octet dispo sur tx_dat
   SIGNAL tx_sof       : STD_LOGIC;         -- Indique un début de trame
   SIGNAL tx_eof       : STD_LOGIC;         -- Indique une fin de trame
   SIGNAL clr_fifo_tx  : STD_LOGIC;         -- Clear de la FIFO transport Tx
   SIGNAL stuf_phys    : STD_LOGIC;         -- Emissiond es octets de stuffing

	COMPONENT autobaud
	PORT(
		clk_sys     : IN STD_LOGIC;
		rst_n       : IN STD_LOGIC;
		rx1         : IN STD_LOGIC;
		val_rx1     : IN STD_LOGIC;
		eof1        : IN STD_LOGIC;
		dat_rx1     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      l2_ok1      : IN STD_LOGIC;
		rx2         : IN STD_LOGIC;
		val_rx2     : IN STD_LOGIC;
		eof2        : IN STD_LOGIC;
		dat_rx2     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      l2_ok2      : IN STD_LOGIC;          
		tc_divclk   : OUT STD_LOGIC_VECTOR(10 downto 0);
		baud_locked : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT switch
   GENERIC (
      nbbit_div : INTEGER := 10);
	PORT(
		clk_sys     : IN STD_LOGIC;
		rst_n       : IN STD_LOGIC;
      baud_lock   : IN  STD_LOGIC;
		tc_divclk   : IN STD_LOGIC_VECTOR(nbbit_div-1 downto 0);
		rx          : IN STD_LOGIC;
		rx_dat      : OUT STD_LOGIC_VECTOR(7 downto 0);
		rx_val      : OUT STD_LOGIC;
		tx          : OUT STD_LOGIC;
		tx_dat      : IN STD_LOGIC_VECTOR(7 downto 0);
		tx_rd       : OUT STD_LOGIC;
		tx_empty    : IN STD_LOGIC;
		sw_ena      : IN STD_LOGIC;
		copy_ena    : IN STD_LOGIC      
		);
	END COMPONENT;
   
	COMPONENT con_layer2_rx
   GENERIC (
      nbbit_div : INTEGER := 10);
	PORT(
		clk_sys     : IN STD_LOGIC;
		rst_n       : IN STD_LOGIC;
      ad_con      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		sw_ena      : OUT STD_LOGIC;
		dat_in      : IN STD_LOGIC_VECTOR(7 downto 0);
		val_in      : IN STD_LOGIC;
		tc_divclk   : IN STD_LOGIC_VECTOR(nbbit_div-1 downto 0);          
      sof_pic     : OUT  STD_LOGIC;
      eof_pic     : OUT  STD_LOGIC;
      l2_ok_pic   : OUT  STD_LOGIC;
      dat_out_pic : OUT  STD_LOGIC_VECTOR(7 downto 0);
      val_out_pic : OUT  STD_LOGIC;
      sof_pas     : OUT  STD_LOGIC;
      eof_pas     : OUT  STD_LOGIC;
      l2_ok_pas   : OUT  STD_LOGIC;
      dat_out_pas : OUT  STD_LOGIC_VECTOR(7 downto 0);
      val_out_pas : OUT  STD_LOGIC
		);
	END COMPONENT;

	COMPONENT frame_store
	PORT(
		clk_sys     : IN STD_LOGIC;
		rst_n       : IN STD_LOGIC;
		dat_in      : IN STD_LOGIC_VECTOR(7 downto 0);
		val_in      : IN STD_LOGIC;
		sof         : IN STD_LOGIC;
		eof         : IN STD_LOGIC;
		l2_ok       : IN STD_LOGIC;
		dat_out     : OUT STD_LOGIC_VECTOR(7 downto 0);
      soc_out     : OUT STD_LOGIC;
		rd_datout   : IN STD_LOGIC;          
		new_frame   : OUT STD_LOGIC;
		com_dispo   : OUT STD_LOGIC;
		l7_ok       : OUT STD_LOGIC;
      overflow    : OUT STD_LOGIC
		);
	END COMPONENT;

   COMPONENT filter_dbl_frame_sil4 IS
   PORT (
      clk_sys              : IN STD_LOGIC;
      rst_n                : IN STD_LOGIC;
      top_cycle            : IN  STD_LOGIC;
      ena_filt_dble        : IN  STD_LOGIC;
      data_port1           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      soc_port1            : IN STD_LOGIC; 
      com_dispo1           : IN STD_LOGIC;
      rd_port1             : OUT STD_LOGIC;
      data_port2           : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      soc_port2            : IN STD_LOGIC;
      com_dispo2           : IN STD_LOGIC;
      rd_port2             : OUT STD_LOGIC;
      data_filt1_uc1       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      soc_filt1_uc1        : OUT STD_LOGIC;
      frm_dispo_filt1_uc1  : OUT STD_LOGIC;
      rd_filt1_uc1         : IN  STD_LOGIC;
      data_filt2_uc1       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      soc_filt2_uc1        : OUT STD_LOGIC;
      frm_dispo_filt2_uc1  : OUT STD_LOGIC;
      rd_filt2_uc1         : IN  STD_LOGIC;
      data_filt1_uc2       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      soc_filt1_uc2        : OUT STD_LOGIC;
      frm_dispo_filt1_uc2  : OUT STD_LOGIC;
      rd_filt1_uc2         : IN  STD_LOGIC;
      data_filt2_uc2       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      soc_filt2_uc2        : OUT STD_LOGIC;
      frm_dispo_filt2_uc2  : OUT STD_LOGIC;
      rd_filt2_uc2         : IN  STD_LOGIC;
      dpram_overflow1      : OUT STD_LOGIC;
      dpram_overflow2      : OUT STD_LOGIC
      );
   END COMPONENT;

   COMPONENT con_layer2_tx
   PORT(
      clk_sys     : IN STD_LOGIC;
      rst_n       : IN STD_LOGIC;
      stuf_phys   : IN  STD_LOGIC;
      acq_stuf    : OUT STD_LOGIC;
      dat_in      : IN STD_LOGIC_VECTOR(7 downto 0);
      val_in      : IN STD_LOGIC;
      sof         : IN STD_LOGIC;
      eof         : IN STD_LOGIC;          
      datin_free  : OUT STD_LOGIC;
      dat_out     : OUT STD_LOGIC_VECTOR(7 downto 0);
      val_out     : OUT STD_LOGIC;
      clr_fifo    : IN   STD_LOGIC;
      progfull1   : IN   STD_LOGIC;
      progfull2   : IN   STD_LOGIC;
      full1       : IN   STD_LOGIC;
      empty1      : IN   STD_LOGIC;
      full2       : IN   STD_LOGIC;
      empty2      : IN   STD_LOGIC
      );
   END COMPONENT;

   COMPONENT fifo_tx
   PORT (
      clk      : IN STD_LOGIC;
      srst     : IN STD_LOGIC;
      din      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en    : IN STD_LOGIC;
      rd_en    : IN STD_LOGIC;
      dout     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full     : OUT STD_LOGIC;
      empty    : OUT STD_LOGIC;
      prog_full: OUT STD_LOGIC
      );
   END COMPONENT;
  
BEGIN
   --------------------------------------------
   -- Gestion de la métastbilité de rx1 et rx2
   --------------------------------------------
   meta : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rx1_r1 <= '1';
         rx1_r2 <= '1';
         rx2_r1 <= '1';
         rx2_r2 <= '1';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         rx1_r1 <= rx1;
         rx1_r2 <= rx1_r1;
         rx2_r1 <= rx2;
         rx2_r2 <= rx2_r1;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Sélection du baud rate fixé par registre ou autobaudrate
   --------------------------------------------
   mux_baud : PROCESS(clk_sys)
   BEGIN
      IF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (actif = '1') THEN
         -- Si le concentrateur est maitre
            CASE baudrate IS
            -- LE baudrateest défini par registre
               WHEN "000" =>
                  tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/50-1, tc_divclk'length);
               WHEN "001" =>
                  tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/100-1, tc_divclk'length);
               WHEN "010" =>
                  tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/200-1, tc_divclk'length);
               WHEN "011" =>
                  tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/500-1, tc_divclk'length);
               WHEN "100" =>
                  tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/1000-1, tc_divclk'length);
               WHEN "101" =>
                  tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/2000-1, tc_divclk'length);
               WHEN "110" =>
                  tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/6000-1, tc_divclk'length);
               WHEN "111" =>
                  tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/12000-1, tc_divclk'length);
               WHEN OTHERS =>
                  NULL;
            END CASE;
         ELSE
         -- Si le cocentrateur n'est pas maitre
            tc_divclk <= divclk_autobaud;       -- C'est l'autobaud qui définit le baudrate
         END IF;
      END IF;
   END PROCESS;

	inst_autobaud: autobaud 
   PORT MAP(
		clk_sys =>  clk_sys,
		rst_n =>    rst_n,
		rx1 =>      rx1_r2,
		rx2 =>      rx2_r2,
		val_rx1 =>  layer1_val1,
		dat_rx1 =>  layer1_rx1,
      eof1 =>     layer2_eof1_pic,
		l2_ok1 =>   layer2_l2ok1_pic,
		val_rx2 =>  layer1_val2,
      dat_rx2 =>  layer1_rx2,
		eof2 =>     layer2_eof2_pic,
		l2_ok2 =>   layer2_l2ok2_pic,
		tc_divclk => divclk_autobaud,
		baud_locked => baud_locked
	);

	inst_switch1: switch 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
      baud_lock =>   baud_locked,
		tc_divclk =>   tc_divclk,
		rx =>          rx1_r2,
		rx_dat =>      layer1_rx1,
		rx_val =>      layer1_val1,
		tx =>          tx2,
		tx_dat =>      layer1_tx2,
		tx_rd =>       layer1_rd2,
		tx_empty =>    layer1_empty2,
		sw_ena =>      sw_ena1,
		copy_ena =>    copy_ena1
	);    
   
	inst_switch2: switch 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
      baud_lock =>   baud_locked,
		tc_divclk =>   tc_divclk,
		rx =>          rx2_r2,
		rx_dat =>      layer1_rx2,
		rx_val =>      layer1_val2,
		tx =>          tx1,
		tx_dat =>      layer1_tx1,
		tx_rd =>       layer1_rd1,
		tx_empty =>    layer1_empty1,
		sw_ena =>      sw_ena2,
		copy_ena =>    copy_ena2
	);    

	inst_layer2_rx1: con_layer2_rx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
      ad_con =>      ad_con,
		sw_ena =>      sw_ena1,
		dat_in =>      layer1_rx1,
		val_in =>      layer1_val1,
		tc_divclk =>   tc_divclk,
		sof_pic =>     layer2_sof1_pic,
		eof_pic =>     layer2_eof1_pic,
		l2_ok_pic =>   layer2_l2ok1_pic,
		dat_out_pic => layer2_rx1_pic,
		val_out_pic => layer2_rxval1_pic,
      sof_pas =>     sof_storerx1,
      eof_pas =>     eof_storerx1,
      l2_ok_pas =>   crcok_storerx1,
      dat_out_pas => data_storerx1,
      val_out_pas => val_storerx1
	);
   
	inst_layer2_rx2: con_layer2_rx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
      ad_con =>      ad_con,
		sw_ena =>      sw_ena2,
		dat_in =>      layer1_rx2,
		val_in =>      layer1_val2,
		tc_divclk =>   tc_divclk,
		sof_pic =>     layer2_sof2_pic,
		eof_pic =>     layer2_eof2_pic,
		l2_ok_pic =>   layer2_l2ok2_pic,
		dat_out_pic => layer2_rx2_pic,
		val_out_pic => layer2_rxval2_pic,
      sof_pas =>     sof_storerx2,
      eof_pas =>     eof_storerx2,
      l2_ok_pas =>   crcok_storerx2,
      dat_out_pas => data_storerx2,
      val_out_pas => val_storerx2
	);

	inst_frame_store1: frame_store 
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
		dat_in =>      layer2_rx1_pic,
		val_in =>      layer2_rxval1_pic,
		sof =>         layer2_sof1_pic,
		eof =>         layer2_eof1_pic,
		l2_ok =>       layer2_l2ok1_pic,
		dat_out =>     layer7_rx1,
      soc_out =>     layer7_soc1,
		rd_datout =>   layer7_rd1,
		new_frame =>   layer7_newframe1,
		com_dispo =>   layer7_comdispo1,
		l7_ok =>       layer7_l2ok1,
      overflow =>    overflow_store1
	);
   layer7_overflow1 <= overflow_store1 OR overflow_filter1;
   
	inst_frame_store2: frame_store 
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
		dat_in =>      layer2_rx2_pic,
		val_in =>      layer2_rxval2_pic,
		sof =>         layer2_sof2_pic,
		eof =>         layer2_eof2_pic,
		l2_ok =>       layer2_l2ok2_pic,
		dat_out =>     layer7_rx2,
      soc_out =>     layer7_soc2,
		rd_datout =>   layer7_rd2,
		new_frame =>   layer7_newframe2,
		com_dispo =>   layer7_comdispo2,
		l7_ok =>       layer7_l2ok2,
      overflow =>    overflow_store2
	);
   layer7_overflow2 <= overflow_store2 OR overflow_filter2;

   inst_dble_filt : filter_dbl_frame_sil4
   PORT MAP(
      clk_sys        => clk_sys,
      rst_n          => rst_n,
      top_cycle      => top_cycle,
      ena_filt_dble  => ena_filt_dble,
      data_port1     => layer7_rx1,
      soc_port1      => layer7_soc1,
      com_dispo1     => layer7_comdispo1,
      rd_port1       => layer7_rd1,
      data_port2     => layer7_rx2,
      soc_port2      => layer7_soc2,
      com_dispo2     => layer7_comdispo2,
      rd_port2       => layer7_rd2,
      data_filt1_uc1 => filt_rx1_uc1,
      soc_filt1_uc1  => filt_soc1_uc1,
      frm_dispo_filt1_uc1=> filt_comdispo1_uc1,
      rd_filt1_uc1   => filt_rd1_uc1,
      data_filt2_uc1 => filt_rx2_uc1,
      soc_filt2_uc1  => filt_soc2_uc1,
      frm_dispo_filt2_uc1=> filt_comdispo2_uc1,
      rd_filt2_uc1   => filt_rd2_uc1,
      data_filt1_uc2 => filt_rx1_uc2,
      soc_filt1_uc2  => filt_soc1_uc2,
      frm_dispo_filt1_uc2=> filt_comdispo1_uc2,
      rd_filt1_uc2   => filt_rd1_uc2,
      data_filt2_uc2 => filt_rx2_uc2,
      soc_filt2_uc2  => filt_soc2_uc2,
      frm_dispo_filt2_uc2=> filt_comdispo2_uc2,
      rd_filt2_uc2   => filt_rd2_uc2,
      dpram_overflow1=> overflow_filter1,
      dpram_overflow2=> overflow_filter2
      );


   arbitrage_tx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         mux_tx      <= '0';
         tx_encours  <= '0';
         tx_commena_uc1 <= '0';
         tx_commena_uc2 <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (tx_encours = '0') THEN
         -- Si une trame n'est pas en cours de recopie
            IF (tx_available_uc1 = '1') THEN
            -- Si le PIC 1 a une trame en attente d'émission
               IF (tx_available_uc2 = '1') THEN
               -- Si le PIC 2 a aussi une trame en attente
                  mux_tx <= NOT(mux_tx);        -- On traite le côté qui n'a pas été traité au coup d'avant (flip-flop)
                  tx_commena_uc1 <= mux_tx;        -- On anticipe le fait que mux_tx aura changé au cycle suvant : ie NOT(NOT(mux_tx))
                  tx_commena_uc2 <= NOT(mux_tx);   -- On anticipe le fait que mux_tx aura changé au cycle suvant : ie NOT(mux_tx)
                  tx_encours  <= '1';           -- On mémorise le fait qu'on a choisi un côté
               ELSE
               -- Si PIC 1 uniquement a quelque chose à transmettre
                  mux_tx      <= '0';           -- On sélecitonne la voie 1
                  tx_commena_uc1 <= '1';           -- On autorise le PIC 1
                  tx_commena_uc2 <= '0';               
                  tx_encours  <= '1';           -- On mémorise le fait qu'on a choisi un côté
               END IF;
            ELSIF (tx_available_uc2 = '1') THEN
            -- Si le PIC1 n'a rien à dire mais le PIC 2 oui
               mux_tx      <= '1';              -- On sélecitonne la voie 2
               tx_commena_uc1 <= '0';
               tx_commena_uc2 <= '1';              -- On autorise le PIC 2
               tx_encours  <= '1';              -- On mémorise le fait qu'on a choisi un côté
            END IF;
         
         ELSE
         -- Si on a choisi un côté
            IF (tx_sof = '1') THEN
            -- On a attend que la transmission commence pour annuler les autorisations
               tx_commena_uc1 <= '0';
               tx_commena_uc2 <= '0';
            END IF;
            IF (tx_eof = '1') THEN
            -- Lorsuq'on voit passer le fin de trame
               tx_encours  <= '0';              -- On autorise la sélection d'une autre voie
            END IF;
         END IF;
      END IF;
   END PROCESS;
   
   tx_dat      <= tx_dat_uc1      WHEN (mux_tx = '0') ELSE tx_dat_uc2;
   val_txdat   <= val_txdat_uc1   WHEN (mux_tx = '0') ELSE val_txdat_uc2;
   tx_sof      <= tx_sof_uc1      WHEN (mux_tx = '0') ELSE tx_sof_uc2;
   tx_eof      <= tx_eof_uc1      WHEN (mux_tx = '0') ELSE tx_eof_uc2;     
   clr_fifo_tx <= clr_fifo_tx_uc1 OR clr_fifo_tx_uc2;
   stuf_phys   <= stuf_phys_uc1   OR stuf_phys_uc2;

   tx_dat_pas    <= tx_dat;
   val_txdat_pas <= val_txdat AND txdat_free_buf; -- On assure que chaque donnée n'est envoyée à la passerelle qu'une seule fois
   tx_sof_pas    <= tx_sof;
   tx_eof_pas    <= tx_eof;
   txdat_free    <= txdat_free_buf;
   inst_layer2_tx: con_layer2_tx 
   PORT MAP(
      clk_sys => clk_sys,
      rst_n => rst_n,
      stuf_phys => stuf_phys,
      acq_stuf => acq_stuf,
      dat_in => tx_dat,
      val_in => val_txdat,
      sof => tx_sof,
      eof => tx_eof,
      datin_free => txdat_free_buf,
      dat_out => layer2_txdat,
      val_out => layer2_txval,
      clr_fifo => clr_fifo_tx,
      progfull1 => layer2_progfull1,
      progfull2 => layer2_progfull2,
      full1     => layer2_full1,
      empty1    => layer1_empty1,
      full2     => layer2_full2,
      empty2    => layer1_empty2
	);
 
   -- La FIFO contient 512 mots, le prog_full est configuré à 500 mots pour laisser une marge de 
   -- stockage avant overflow (voir le module layer2_tx)
   inst_fifo_tx1 : fifo_tx
   PORT MAP (
      clk =>   clk_sys,
      srst =>  clr_fifo_tx,
      din =>   layer2_txdat,
      wr_en => layer2_txval,
      rd_en => layer1_rd1,
      dout =>  layer1_tx1,
      full =>  layer2_full1,
      empty => layer1_empty1,
      prog_full => layer2_progfull1
   );

   inst_fifo_tx2 : fifo_tx
   PORT MAP (
      clk =>   clk_sys,
      srst =>  clr_fifo_tx,
      din =>   layer2_txdat,
      wr_en => layer2_txval,
      rd_en => layer1_rd2,
      dout =>  layer1_tx2,
      full =>  layer2_full2,
      empty => layer1_empty2,
      prog_full => layer2_progfull2
   );
   
END rtl;

