--============================================================================= 
--  TITRE : COMMUNICATION
--  DESCRIPTION : 
--        Implémente la pile communication des MIO de SATURN sans PIC32 
--        Le module read_mac maintien les autres modules en reset
--        tant que l'adresse MAC n'a pas été récupérée
--  FICHIER :        communication.vhd 
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


ENTITY communication IS
   GENERIC (
      reg_typemio : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";   -- Type du MIO
      reg_version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";   -- Version du MIO
      ad_ref      : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"80";   -- Adresse des registres à émettre sur trame de synchro
      sz_ref      : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"04"    -- Nb otets à émettre sur trame de synchro
      );
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;                       -- Clock système
      rst_n    : IN  STD_LOGIC;                       -- Reset général système
      iid      : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);   -- IID du MIO
      sync_lock   : OUT STD_LOGIC;
      
      -- Interfaces séries 1 et 2
      rx1       : IN  STD_LOGIC;                      -- Réception série    
      tx1       : OUT  STD_LOGIC;                     -- Transmission série
      rx2       : IN  STD_LOGIC;                      -- Réception série    
      tx2       : OUT  STD_LOGIC;                     -- Transmission série

      -- Bus d'accès à la zone métier du MIO
      datout_write: OUT STD_LOGIC_VECTOR(7 downto 0); -- Données à écrire sur l'interface externe
      datout_read : IN STD_LOGIC_VECTOR(7 downto 0);  -- Données lues sur l'interface externe
      ad_out      : OUT STD_LOGIC_VECTOR(6 downto 0); -- Adresse d'écriture et de lecture des données externe
      wr_out      : OUT STD_LOGIC;                    -- Signal d'écriture sur l'interface externe
      rd_out      : OUT STD_LOGIC;                    -- Signal de lecture sur l'interface externe
      
      -- Signaux de pilotage du SPI de la PROM de config du FPGA
      reload_fpgan: OUT STD_LOGIC;                    -- Ordre de reconfig du FPGA
      spi_csn  : OUT  STD_LOGIC;                      -- CS de la PROM
      spi_wpn  : OUT  STD_LOGIC;                      -- Write protect de la PROM
      spi_sdo  : OUT  STD_LOGIC;                      -- Serial Data vers la PROM
      spi_sdi  : IN  STD_LOGIC;                       -- Serial Data venant de la PROM
      spi_clk  : OUT  STD_LOGIC;                       -- clock série vers la PROM
		spare	   : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
      );
END communication;

ARCHITECTURE rtl of communication is
   -- Définit le nombre de bit nécessaires pour mesurer la durée du bit le plus lent avec l'horloge système
   -- i.e. 1 Bit à 50Kbit/s = 20µs nbbit_div = Log2(96MHz x 20µs)
   CONSTANT nbbit_div      : INTEGER := 11;

   -- DFF pour la métastabilité de rx1 et rx2
   SIGNAL rx1_r1, rx1_r2 : STD_LOGIC;        -- Pour la metastabilité sur Rx1
   SIGNAL rx2_r1, rx2_r2 : STD_LOGIC;        -- Pour la metastabilité sur Rx2
   
   SIGNAL tc_divclk     : STD_LOGIC_VECTOR(nbbit_div - 1 DOWNTO 0); -- Diviseur d'horloge pour le baud rate
   SIGNAL baud_locked   : STD_LOGIC;                     -- Indique que l'autobaudrate a convergé
   SIGNAL tid           : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- TID du MIO

   -- Interfaces du SWITCH1
   SIGNAL layer1_rx1    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de donnée déserialisé (Rx)
   SIGNAL layer1_val1   : STD_LOGIC;                     -- Indique un octet valide sur layer1_rx1
   SIGNAL sw_ena1       : STD_LOGIC;                     -- Indique qu'on est en réception entre 2 trames sur port 1
   SIGNAL layer1_tx1    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de donnée à sérialiser (Tx)
   SIGNAL layer1_rd1    : STD_LOGIC;                     -- Demande un octet de plus à transmettre
   SIGNAL layer1_empty1 : STD_LOGIC;                     -- Indique qu'aucun octet n'est en attente de serialsiation
   SIGNAL copy_ena1     : STD_LOGIC;
   
   -- Interfaces du SWITCH2
   SIGNAL layer1_rx2    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL layer1_val2   : STD_LOGIC;
   SIGNAL sw_ena2       : STD_LOGIC;
   SIGNAL layer1_tx2    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL layer1_rd2    : STD_LOGIC;
   SIGNAL layer1_empty2 : STD_LOGIC;
   SIGNAL copy_ena2     : STD_LOGIC;
   
   -- Interfaces du module LAYER2_RX1
   SIGNAL layer2_rx1    : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de données applicatives destuffé
   SIGNAL layer2_rxval1 : STD_LOGIC;                     -- Indique un octet valide sur layer2_rx1
   SIGNAL layer2_sof1   : STD_LOGIC;                     -- Indique un  début de trame
   SIGNAL layer2_eof1   : STD_LOGIC;                     -- Indqiue une fin de trame
   SIGNAL layer2_l2ok1  : STD_LOGIC;                     -- Indique que la trame reçue est correcte

   -- Interfaces du module LAYER2_RX2
   SIGNAL layer2_rx2    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL layer2_rxval2 : STD_LOGIC;
   SIGNAL layer2_sof2   : STD_LOGIC;
   SIGNAL layer2_eof2   : STD_LOGIC;
   SIGNAL layer2_l2ok2  : STD_LOGIC;   

   -- Interfaces du module FRAME_STORE1 (couche applicative)
   SIGNAL layer7_rx1       : STD_LOGIC_VECTOR(7 DOWNTO 0);-- Données applicatives reçues sur port 1
   SIGNAL layer7_soc1      : STD_LOGIC;                   -- Indique un début de trame
   SIGNAL layer7_rd1       : STD_LOGIC;                   -- Signal de lecture d'un octet de plus
   SIGNAL layer7_newframe1 : STD_LOGIC;                   -- Indique la réception d'une nouvelle trame
   SIGNAL layer7_comdispo1 : STD_LOGIC;                   -- Indique qu'au moins une trame est dispo en mémoire
   SIGNAL layer7_l7ok1     : STD_LOGIC;                   -- Indique que la trame reçue est conforme
   SIGNAL layer7_overflow1 : STD_LOGIC;                   -- Indique un débordement de mémoire
  
   -- Interfaces du module FRAME_STORE2
   SIGNAL layer7_rx2       : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL layer7_soc2      : STD_LOGIC;
   SIGNAL layer7_rd2       : STD_LOGIC;
   SIGNAL layer7_newframe2 : STD_LOGIC;
   SIGNAL layer7_comdispo2 : STD_LOGIC;
   SIGNAL layer7_l7ok2     : STD_LOGIC;
   SIGNAL layer7_overflow2 : STD_LOGIC;

   -- Interface d'écriture des trames à émettre
   SIGNAL tx_dat           : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donnée applicative à émettre
   SIGNAL val_txdat        : STD_LOGIC;                     -- Indique un octet dispo sur tx_dat
   SIGNAL tx_sof           : STD_LOGIC;                     -- Indique un début de trame
   SIGNAL tx_eof           : STD_LOGIC;                     -- Indique une fin de trame
   SIGNAL txdat_free       : STD_LOGIC;                     -- Indique que le module couche transport Tx est dispo
   SIGNAL clr_fifo_tx      : STD_LOGIC;                     -- Clear de la FIFO transport Tx

   -- Interfaces du module LAYER2_TX
   SIGNAL layer2_txdat     : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Flux de donnée stuffé + CRC transport
   SIGNAL layer2_txval     : STD_LOGIC;                     -- Indique un octet valide sur layer2_txdat
   SIGNAL layer2_progfull1 : STD_LOGIC;                     -- La FIFO de données Tx port 1 est presque pleine
   SIGNAL layer2_progfull2 : STD_LOGIC;                     -- La FIFO de données Tx port 2 est presque pleine
   SIGNAL layer2_full1     : STD_LOGIC;                     -- La FIFO de données Tx port 1 est pleine
   SIGNAL layer2_full2     : STD_LOGIC;                     -- La FIFO de données Tx port 2 est pleine
   
   -- Interface de pilotage du module SPI de programmation de la PROM FPGA
   SIGNAL spitx_dat        : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Data + commande à sérialiser
   SIGNAL spitx_val        : STD_LOGIC;                     -- Validant de spitx_dat
   SIGNAL spirx_dat        : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Data reçue
   SIGNAL spirx_val        : STD_LOGIC;                     -- Indique des données dispo dans spirx_val
   SIGNAL spirx_next       : STD_LOGIC;                     -- Lit un octet de plus dans spirx_val
   SIGNAL spi_typecom      : STD_LOGIC;                     -- Type de commande à éxécuter
   SIGNAL spi_execcom      : STD_LOGIC;                     -- Ordre d'exécution d'une commande
   SIGNAL spi_busy         : STD_LOGIC;                     -- Indique que le module SPI est occupé
   SIGNAL spi_nbread       : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Nombre d 'octets à lire avec une commande de lecture
   SIGNAL spi_rstn         : STD_LOGIC;                     -- Reset du module SPI
	SIGNAL etat1, etat2	   : STD_LOGIC;

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
		etat		: OUT  STD_LOGIC      
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

	COMPONENT com_exec
      GENERIC (
      freq_clksys : INTEGER := 48;
      reg_typemio : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";   -- Type du MIO
      reg_version : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";   -- Version du MIO
      ad_ref      : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"80";
      sz_ref      : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"04"
      );
	PORT(
		clk_sys     : IN STD_LOGIC;
		rst_n       : IN STD_LOGIC;
		tid         : OUT STD_LOGIC_VECTOR(7 downto 0);
      iid         : IN  STD_LOGIC_VECTOR(63 downto 0);
      sync_lock   : OUT STD_LOGIC;
		datout_read : IN STD_LOGIC_VECTOR(7 downto 0);
		datout_write: OUT STD_LOGIC_VECTOR(7 downto 0);
		ad_out      : OUT STD_LOGIC_VECTOR(6 downto 0);
		wr_out      : OUT STD_LOGIC;
      rd_out      : OUT STD_LOGIC;                    
		activity1   : IN STD_LOGIC;
		activity2   : IN STD_LOGIC;
		datin1      : IN STD_LOGIC_VECTOR(7 downto 0);
      socin1      : IN STD_LOGIC;
		new_frame1  : IN STD_LOGIC;
		com_dispo1  : IN STD_LOGIC;
		l7_ok1      : IN STD_LOGIC;
      l7_overflow1: IN STD_LOGIC;
		datin2      : IN STD_LOGIC_VECTOR(7 downto 0);
      socin2      : IN STD_LOGIC;
		new_frame2  : IN STD_LOGIC;
		com_dispo2  : IN STD_LOGIC;
		l7_ok2      : IN STD_LOGIC;
      l7_overflow2: IN STD_LOGIC;
		datsent_free: IN STD_LOGIC;          
		rd_datin1   : OUT STD_LOGIC;
		rd_datin2   : OUT STD_LOGIC;
		datsent     : OUT STD_LOGIC_VECTOR(7 downto 0);
		valsent     : OUT STD_LOGIC;
		sof         : OUT STD_LOGIC;
		eof         : OUT STD_LOGIC;
      clr_fifo_tx : OUT STD_LOGIC;
      copy_ena1   : OUT STD_LOGIC;
      copy_ena2   : OUT STD_LOGIC;
      reload_fpgan: OUT STD_LOGIC;
      spitx_dat   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      spitx_val   : OUT STD_LOGIC;
      spirx_dat   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      spirx_val   : IN  STD_LOGIC;
      spirx_next  : OUT STD_LOGIC;
      spi_typecom : OUT STD_LOGIC;
      spi_execcom : OUT STD_LOGIC;
      spi_busy    : IN  STD_LOGIC;
      spi_nbread  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      spi_rstn    : OUT STD_LOGIC
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
   
   COMPONENT if_promspi
   GENERIC (
      div_rate : INTEGER := 3;      -- Diviseur d'horloge système pour obtenir le débit SPI = 2^div_rate
      spiclk_freq : INTEGER := 12
      );
   PORT(
      clk_sys  : IN  std_logic;
      rst_n    : IN  std_logic;
      spi_csn  : OUT  std_logic;
      spi_wpn  : OUT  std_logic;
      spi_sdo  : OUT  std_logic;
      spi_sdi  : IN  std_logic;
      spi_clk  : OUT  std_logic;
      tx_dat   : IN  std_logic_vector(7 downto 0);
      tx_val   : IN  std_logic;
      rx_dat   : OUT  std_logic_vector(7 downto 0);
      rx_val   : OUT  std_logic;
      rx_next  : IN  std_logic;
      type_com : IN  std_logic;
      exec_com : IN  std_logic;
      spi_busy : OUT  std_logic;
      nb_read  : IN  std_logic_vector(7 downto 0)
      );
    END COMPONENT;
   
BEGIN
	spare <= etat2 & etat1 & sw_ena2 & sw_ena1 & copy_ena2 & copy_ena1;
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
		etat => etat1
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
		etat => etat2
	);    

	inst_layer2_rx1: layer2_rx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
		tc_divclk =>   tc_divclk,
      ad_mio =>      tid,
		dat_in =>      layer1_rx1,
		val_in =>      layer1_val1,
		dat_out =>     layer2_rx1,
		val_out =>     layer2_rxval1,
		sof =>         layer2_sof1,
		eof =>         layer2_eof1,
		l2_ok =>       layer2_l2ok1,
		sw_ena =>      sw_ena1
	);

	inst_layer2_rx2: layer2_rx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys =>     clk_sys,
		rst_n =>       rst_n,
		tc_divclk =>   tc_divclk,
      ad_mio =>      tid,
		dat_in =>      layer1_rx2,
		val_in =>      layer1_val2,
		dat_out =>     layer2_rx2,
		val_out =>     layer2_rxval2,
		sof =>         layer2_sof2,
		eof =>         layer2_eof2,
		l2_ok =>       layer2_l2ok2,
		sw_ena =>      sw_ena2
	);

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
		l7_ok =>       layer7_l7ok1,
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
		l7_ok =>       layer7_l7ok2,
      overflow =>    layer7_overflow2    
	);
   
   inst_comexec: com_exec
   GENERIC MAP(
      freq_clksys => 96,
      reg_typemio => reg_typemio,
      reg_version => reg_version,
      ad_ref      => ad_ref,
      sz_ref      => sz_ref
      )
   PORT MAP(
      clk_sys     => clk_sys,
      rst_n       => rst_n,
      tid         => tid,
      iid         => iid,
      sync_lock   => sync_lock,
      datout_write=> datout_write,
      datout_read => datout_read,
      ad_out      => ad_out,
      wr_out      => wr_out,
      rd_out      => rd_out,
      activity1   => layer2_eof1,
      activity2   => layer2_eof2,
      datin1      => layer7_rx1,
      socin1      => layer7_soc1,
      rd_datin1   => layer7_rd1,
      new_frame1  => layer7_newframe1,
      com_dispo1  => layer7_comdispo1,
      l7_ok1      => layer7_l7ok1,
      l7_overflow1=> layer7_overflow1,
      datin2      => layer7_rx2,
      socin2      => layer7_soc2,
      rd_datin2   => layer7_rd2,
      new_frame2  => layer7_newframe2,
      com_dispo2  => layer7_comdispo2,
      l7_ok2      => layer7_l7ok2,
      l7_overflow2=> layer7_overflow2,
      datsent     => tx_dat,
      valsent     => val_txdat,
      sof         => tx_sof,
      eof         => tx_eof,
      datsent_free=> txdat_free,
      clr_fifo_tx => clr_fifo_tx,
      copy_ena1   => copy_ena1,
      copy_ena2   => copy_ena2,
      reload_fpgan=> reload_fpgan,
      spitx_dat   => spitx_dat,
      spitx_val   => spitx_val,
      spirx_dat   => spirx_dat,
      spirx_val   => spirx_val,
      spirx_next  => spirx_next,
      spi_typecom => spi_typecom,
      spi_execcom => spi_execcom,
      spi_busy    => spi_busy,
      spi_nbread  => spi_nbread,
      spi_rstn    => spi_rstn
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
   
   inst_flash : if_promspi 
   GENERIC MAP (
      div_rate => 3,
      spiclk_freq => 12)
   PORT MAP (
      clk_sys =>  clk_sys,
      rst_n =>    spi_rstn,
      spi_csn =>  spi_csn,
      spi_wpn =>  spi_wpn,
      spi_sdo =>  spi_sdo,
      spi_sdi =>  spi_sdi,
      spi_clk =>  spi_clk,
      tx_dat =>   spitx_dat,
      tx_val =>   spitx_val,
      rx_dat =>   spirx_dat,
      rx_val =>   spirx_val,
      rx_next =>  spirx_next,
      type_com => spi_typecom,
      exec_com => spi_execcom,
      spi_busy => spi_busy,
      nb_read =>  spi_nbread
        );

END rtl;

