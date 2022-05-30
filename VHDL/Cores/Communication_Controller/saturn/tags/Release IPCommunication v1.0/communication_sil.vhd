--============================================================================= 
--  TITRE : COMMUNICATION_SIL
--  DESCRIPTION : 
--        Implémente la pile communication des MIO sécuritaire
--  FICHIER :        communication_sil.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--  18/09/14   DRA      SATURN   1.1
--    Evolution du module switch (prise en compte du signal SW_ENA) 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY communication_sil IS
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;     -- Clock système
      rst_n    : IN  STD_LOGIC;     -- Reset général système
      ad_mio   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- TID du MIO

      -- Interfaces séries 1 et 2
      rx1       : IN  STD_LOGIC;    -- Réception série port 1
      tx1       : OUT STD_LOGIC;    -- Transmission série port 1
      rx2       : IN  STD_LOGIC;    -- Réception série port 2
      tx2       : OUT STD_LOGIC;    -- Transmission série port 2

      copy_ena1 : IN  STD_LOGIC;    -- Autorise la copy du port 1 sur le port 2
      copy_ena2 : IN  STD_LOGIC;    -- Autorise la copy du port 2 sur le port 1
     
      -- Interfaces de lecture des trames port 1
      layer7_rx1       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Données applicatives reçues sur port 1
      layer7_soc1      : OUT STD_LOGIC;         -- Indique un début de trame
      layer7_rd1       : IN  STD_LOGIC;         -- Signal de lecture d'un octet de plus
      layer7_newframe1 : OUT STD_LOGIC;         -- Indique la réception d'une nouvelle trame
      layer7_comdispo1 : OUT STD_LOGIC;         -- Indique qu'au moins une trame est dispo en mémoire
      layer7_l2ok1     : OUT STD_LOGIC;         -- Indique que la trame reçue est conforme
      layer7_overflow1 : OUT STD_LOGIC;         -- Indique un débordement de mémoire
      activity1        : OUT STD_LOGIC;         -- Indique du trafic sur le port 1
     
      -- Interfaces de lecture des trames port 2
      layer7_rx2       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem port 1
      layer7_soc2      : OUT STD_LOGIC;
      layer7_rd2       : IN  STD_LOGIC;
      layer7_newframe2 : OUT STD_LOGIC;
      layer7_comdispo2 : OUT STD_LOGIC;
      layer7_l2ok2     : OUT STD_LOGIC;
      layer7_overflow2 : OUT STD_LOGIC;
      activity2        : OUT STD_LOGIC;         -- Indique du trafic sur le port 2

      -- Interface d'écriture des trames
      tx_dat           : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données applicatives à transmettre
      val_txdat        : IN  STD_LOGIC;         -- Indique un octet dispo sur tx_dat
      tx_sof           : IN  STD_LOGIC;         -- Indique un début de trame
      tx_eof           : IN  STD_LOGIC;         -- Indique une fin de trame
      txdat_free       : OUT STD_LOGIC;         -- Indique que le module couche transport Tx est dispo
      clr_fifo_tx      : IN  STD_LOGIC          -- Clear de la FIFO transport Tx
      );
END communication_sil;

ARCHITECTURE rtl of communication_sil is
   -- Définit le nombre de bit nécessaires pour mesurer la durée du bit le plus lent avec l'horloge système
   -- i.e. 1 Bit à 50Kbit/s = 20µs nbbit_div = Log2(96MHz x 20µs)
   CONSTANT nbbit_div      : INTEGER := 11;

   -- DFF pour la métastabilité de rx1 et rx2
   SIGNAL rx1_r1, rx1_r2 : STD_LOGIC;
   SIGNAL rx2_r1, rx2_r2 : STD_LOGIC;
   
   -- Diviseur d'horloge pour le baud rate
   SIGNAL tc_divclk     : STD_LOGIC_VECTOR(nbbit_div - 1 DOWNTO 0);  -- Termianl count du diviseur
   SIGNAL baud_locked   : STD_LOGIC;                                 -- Indique que l'autobaud est locké

   -- Interfaces du SWITCH1
   SIGNAL layer1_rx1    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de donnée déserialisé (Rx)
   SIGNAL layer1_val1   : STD_LOGIC;                     -- Indique un octet valide sur layer1_rx1
   SIGNAL sw_ena1       : STD_LOGIC;                     -- Indique qu'on est en réception entre 2 trames sur port 1
   SIGNAL layer1_tx1    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de donnée à sérialiser (Tx)
   SIGNAL layer1_rd1    : STD_LOGIC;                     -- Demande un octet de plus à transmettre
   SIGNAL layer1_empty1 : STD_LOGIC;                     -- Indique qu'aucun octet n'est en attente de serialsiation
   
   -- Interfaces du SWITCH2
   SIGNAL layer1_rx2    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem port 1
   SIGNAL layer1_val2   : STD_LOGIC;
   SIGNAL sw_ena2       : STD_LOGIC;
   SIGNAL layer1_tx2    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL layer1_rd2    : STD_LOGIC;
   SIGNAL layer1_empty2 : STD_LOGIC;
   
   -- Interfaces du module LAYER2_RX1
   SIGNAL layer2_rx1    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données applicatives destuffé
   SIGNAL layer2_rxval1 : STD_LOGIC;                     -- Indique un octet valide sur layer2_rx1
   SIGNAL layer2_sof1   : STD_LOGIC;                     -- Indique un  début de trame
   SIGNAL layer2_eof1   : STD_LOGIC;                     -- Indqiue une fin de trame
   SIGNAL layer2_l2ok1  : STD_LOGIC;                     -- Indique que la trame reçue est correcte

   -- Interfaces du module LAYER2_RX2
   SIGNAL layer2_rx2    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Idem que port 1
   SIGNAL layer2_rxval2 : STD_LOGIC;
   SIGNAL layer2_sof2   : STD_LOGIC;
   SIGNAL layer2_eof2   : STD_LOGIC;
   SIGNAL layer2_l2ok2  : STD_LOGIC;   

   -- Interfaces du module LAYER2_TX
   SIGNAL layer2_txdat     : STD_LOGIC_VECTOR(7 DOWNTO 0);-- Flux de donnée stuffé + CRC transport
   SIGNAL layer2_txval     : STD_LOGIC;                  -- Indique un octet valide sur layer2_txdat
   SIGNAL layer2_progfull1 : STD_LOGIC;                  -- La FIFO de données Tx port 1 est presque pleine
   SIGNAL layer2_progfull2 : STD_LOGIC;                  -- La FIFO de données Tx port 2 est presque pleine
   SIGNAL layer2_full1     : STD_LOGIC;                  -- La FIFO de données Tx port 1 est pleine
   SIGNAL layer2_full2     : STD_LOGIC;                  -- La FIFO de données Tx port 2 est pleine
   
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
		copy_ena    : IN STD_LOGIC;
      etat		   : OUT  STD_LOGIC      
		);
	END COMPONENT;
   
	COMPONENT layer2_rx
   GENERIC (
      nbbit_div : INTEGER := 10);
	PORT(
		clk_sys     : IN STD_LOGIC;
		rst_n       : IN STD_LOGIC;
		tc_divclk   : IN STD_LOGIC_VECTOR(nbbit_div-1 downto 0);          
		ad_mio      : IN STD_LOGIC_VECTOR(7 downto 0);
		dat_in      : IN STD_LOGIC_VECTOR(7 downto 0);
		val_in      : IN STD_LOGIC;
		dat_out     : OUT STD_LOGIC_VECTOR(7 downto 0);
		val_out     : OUT STD_LOGIC;
		sw_ena      : OUT STD_LOGIC;
		sof         : OUT STD_LOGIC;
		eof         : OUT STD_LOGIC;
		l2_ok       : OUT STD_LOGIC
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

   COMPONENT layer2_tx
   PORT(
      clk_sys     : IN STD_LOGIC;
      rst_n       : IN STD_LOGIC;
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

   -- La FIFO contient 512 mots, le prog_full est configuré à 500 mots pour laisser une marge de 
   -- stockage avant overflow (voir le module layer2_tx)
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

	inst_autobaud: autobaud 
   PORT MAP(
		clk_sys =>  clk_sys,
		rst_n =>    rst_n,
		rx1 =>      rx1_r2,
		rx2 =>      rx2_r2,
		val_rx1 =>  layer1_val1,
		dat_rx1 =>  layer1_rx1,
      eof1 =>     layer2_eof1,
		l2_ok1 =>   layer2_l2ok1,
		val_rx2 =>  layer1_val2,
      dat_rx2 =>  layer1_rx2,
		eof2 =>     layer2_eof2,
		l2_ok2 =>   layer2_l2ok2,
		tc_divclk => tc_divclk,
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
		copy_ena =>    copy_ena1,
      etat =>        OPEN
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
		copy_ena =>    copy_ena2,
      etat =>        OPEN
	);    

	inst_layer2_rx1: layer2_rx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
		tc_divclk =>   tc_divclk,
      ad_mio =>      ad_mio,
		dat_in =>      layer1_rx1,
		val_in =>      layer1_val1,
		dat_out =>     layer2_rx1,
		val_out =>     layer2_rxval1,
		sof =>         layer2_sof1,
		eof =>         layer2_eof1,
		l2_ok =>       layer2_l2ok1,
		sw_ena =>      sw_ena1
	);
   activity1 <= layer2_eof1;

	inst_layer2_rx2: layer2_rx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
		tc_divclk =>   tc_divclk,
      ad_mio =>      ad_mio,
		dat_in =>      layer1_rx2,
		val_in =>      layer1_val2,
		dat_out =>     layer2_rx2,
		val_out =>     layer2_rxval2,
		sof =>         layer2_sof2,
		eof =>         layer2_eof2,
		l2_ok =>       layer2_l2ok2,
		sw_ena =>      sw_ena2
	);
   activity2 <= layer2_eof2;  

	inst_frame_store1: frame_store 
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
		dat_in =>      layer2_rx1,
		val_in =>      layer2_rxval1,
		sof =>         layer2_sof1,
		eof =>         layer2_eof1,
		l2_ok =>       layer2_l2ok1,
		dat_out =>     layer7_rx1,
      soc_out =>     layer7_soc1,
		rd_datout =>   layer7_rd1,
		new_frame =>   layer7_newframe1,
		com_dispo =>   layer7_comdispo1,
		l7_ok =>       layer7_l2ok1,
      overflow =>    layer7_overflow1
	);
   
	inst_frame_store2: frame_store 
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
		dat_in =>      layer2_rx2,
		val_in =>      layer2_rxval2,
		sof =>         layer2_sof2,
		eof =>         layer2_eof2,
		l2_ok =>       layer2_l2ok2,
		dat_out =>     layer7_rx2,
      soc_out =>     layer7_soc2,
		rd_datout =>   layer7_rd2,
		new_frame =>   layer7_newframe2,
		com_dispo =>   layer7_comdispo2,
		l7_ok =>       layer7_l2ok2,
      overflow =>    layer7_overflow2    
	);
   
   inst_layer2_tx: layer2_tx 
   PORT MAP(
      clk_sys => clk_sys,
      rst_n => rst_n,
      dat_in => tx_dat,
      val_in => val_txdat,
      sof => tx_sof,
      eof => tx_eof,
      datin_free => txdat_free,
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

