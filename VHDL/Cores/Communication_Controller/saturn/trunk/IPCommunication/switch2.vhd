--============================================================================= 
--  TITRE : SWITCH
--  DESCRIPTION : 
--        - Gère la réception et la transmission d'une ligne série
--			 - Copie octet par octet du port Rx sur le port Tx
--        - Gestion du switch entre les sources Tx (recopie du port Rx sur Tx ou tranmission d'une trame)
--        - Buffurise les données reçues pendant la transmission		

--  FICHIER :        switch2.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--  18/09/2014 DRA      SATURN   V1.1
--       Prise en comtpe du SW_ENA pour détecter l'inter trame
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

ENTITY switch IS
   GENERIC (
      nbbit_div : INTEGER := 10);   -- Nombre de bits pour coder le diviseur d'horloge 
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;  -- Clock système
      rst_n    : IN  STD_LOGIC;  -- Reset général système
      baud_lock: IN  STD_LOGIC;  -- Indique que le baudrate est calé

      -- Interface série
      tc_divclk: IN  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0); -- Diviseur de l'horloge système pour le baudrate
      rx       : IN  STD_LOGIC;  -- Réception série    
      tx       : OUT  STD_LOGIC; -- Transmission série
      
      -- Interface avec la mémoire de transmission
      tx_dat   : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);  -- Prochaine donnée à transmettre
      tx_empty : IN  STD_LOGIC;  -- Mémoire de transmission vide
      tx_rd    : OUT  STD_LOGIC; -- Lecture de la donnée suivante à transmettre

      -- Interface avec la mémoire de réception
      rx_dat   : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);  -- Octet déserialisé
      rx_val   : OUT  STD_LOGIC; -- Signal d'écriture dans la méoire de réception

      -- Gestion de la recopie
      sw_ena   : IN  STD_LOGIC;  -- A '1' entre 2 trames sur le port Rx (RFU)
      copy_ena : IN  STD_LOGIC;   -- Autorisation de recopie du Rx sur Tx;
		etat		: OUT  STD_LOGIC
      );
END switch;

ARCHITECTURE rtl of switch is
   SIGNAL data_deser       : STD_LOGIC_VECTOR(7 downto 0);  -- Donnée reçue déserialisée
   SIGNAL rx_wr_buf        : STD_LOGIC;                     -- Pulse d'écriture d'un nouveau caractère reçu
   SIGNAL rx_encours       : STD_LOGIC;                     -- Indique qu'une déserialisation est en cours
   SIGNAL fifo_cop_wren    : STD_LOGIC;                     -- Signal d'écriture dans la FIFO de recopie
   SIGNAL ser_rdy          : STD_LOGIC;                     -- Le sérialisateur est prêt à traiter un nouveau car
   SIGNAL sel_par          : STD_LOGIC;                     -- Sélection de la source parallèle pour le sérialisateur (FIFO de copy ou transmission)
   SIGNAL datatx_mux_c     : STD_LOGIC_VECTOR(7 downto 0);  -- Source parallèle pour le sérialisateur (FIFO de copy ou transmission)
   SIGNAL fifocopy_dout    : STD_LOGIC_VECTOR(7 downto 0);  -- Donnée en sortie de la FIFO de recopie
   SIGNAL start_ser_c      : STD_LOGIC;                     -- Déclenche la sérialisation du mot présent sur datatx_mux_c
   SIGNAL cop_read_c       : STD_LOGIC;                     -- Lit un car dans la FIFO de recopie
   SIGNAL tx_read_c        : STD_LOGIC;                     -- Lit un car dans la mémoire de transmission
   SIGNAL cop_empty        : STD_LOGIC;                     -- FIFO de recopie vide
   SIGNAL cop_clr          : STD_LOGIC;                     -- Purge de la FIFO de recopie
   SIGNAL req_cop_c        : STD_LOGIC;                     -- Indique qu'il y'a ou qu'il va y'avoir un caractère dans la FIFO de recopie
   SIGNAL rx_wr_buf_r      : STD_LOGIC;
   SIGNAL rx_wr_buf_rr      : STD_LOGIC;
   -- Machine d'état de gestion du module
   TYPE switch_state IS (copproc_st, txproc_st);
   SIGNAL fsm_switch       : switch_state;
   
   -- Composant de serialisation
   COMPONENT serial_tx
	GENERIC (
      nbbit_div : INTEGER := 10);
   PORT(
		clk_sys     : IN std_logic;
		rst_n       : IN std_logic;
		tc_divclk   : IN std_logic_vector(nbbit_div-1 downto 0);
		start_ser   : IN std_logic;
		tx_dat      : IN std_logic_vector(7 downto 0);          
		tx          : OUT std_logic;
		ser_rdy     : OUT std_logic
		);
	END COMPONENT;

   -- Composant de déserialisation
	COMPONENT serial_rx2
	GENERIC (
      nbbit_div : INTEGER := 10);
	PORT(
		clk_sys     : IN std_logic;
		rst_n       : IN std_logic;
      baud_lock   : IN  STD_LOGIC;
		tc_divclk   : IN std_logic_vector(nbbit_div-1 downto 0);
		rx          : IN std_logic;          
		tx          : OUT std_logic;
      busy        : OUT STD_LOGIC;
		val         : OUT std_logic;
		rx_dat      : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
   
   -- FIFO de stockage des données reçues
   -- La FIFO est en FWFT
   COMPONENT fifo_copy
   PORT (
      clk      : IN STD_LOGIC;
      srst     : IN STD_LOGIC;
      din      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en    : IN STD_LOGIC;
      rd_en    : IN STD_LOGIC;
      dout     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full     : OUT STD_LOGIC;
      overflow : OUT STD_LOGIC;
      empty    : OUT STD_LOGIC
      );
   END COMPONENT;
   
BEGIN
	etat <= '0' when (fsm_switch = copproc_st) else '1';
   --------------------------------------------
   -- Déserialisateur des données reçues sur rx 
   --------------------------------------------
   inst_serial_rx: serial_rx2 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys => clk_sys,
		rst_n => rst_n,
      baud_lock => baud_lock,
		tc_divclk => tc_divclk,
		tx => OPEN,
		rx => rx,
      busy => rx_encours,
		val => rx_wr_buf,
		rx_dat => data_deser
	);
   rx_dat <= data_deser;
   rx_val <= rx_wr_buf;
   
   --------------------------------------------
   -- Sérialise sur 10 bits une donnée 8 bits en entrée 
   --------------------------------------------
   inst_serial_tx: serial_tx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys => clk_sys,
		rst_n => rst_n,
		tc_divclk => tc_divclk,
		tx => tx,
		ser_rdy => ser_rdy,
		start_ser => start_ser_c,
		tx_dat => datatx_mux_c
	);

   --------------------------------------------
   -- Machine d'état de gestion de la source de tx
   --   Soit on recopie des données reçues et stockées dans la FIFO rx
   --   Soit on émet une trame (FIFO externe au module)
   --------------------------------------------
   -- Indique qu'il y'a des données (cop_empty) ou qu'il va y'en avoir (rx_encours et rx_wr_buf et
   -- copy_ena) dans la FIFO de recopie
   req_cop_c <= NOT(cop_empty) OR ((rx_encours OR rx_wr_buf OR rx_wr_buf_r OR rx_wr_buf_rr) AND copy_ena);
   -- Tant que le baudrate n'est pas locké on garde la FIFO de recopie en reset
   cop_clr <= NOT(baud_lock);    --NOT(copy_ena) OR NOT(baud_lock);
   -- On lit un mot dans la FIFO de recopie chaque fois que le sérialisateur est prêt et qu'on est dans le bon état
   cop_read_c <= ser_rdy AND NOT(cop_empty) WHEN (fsm_switch = copproc_st) ELSE '0';
   -- On lit un mot dans la FIFO externe chaque fois que le sérialisateur est prêt et qu'on est dans le bon état
   tx_read_c <= ser_rdy AND NOT(tx_empty) WHEN (fsm_switch = txproc_st) ELSE '0';
   tx_rd <= tx_read_c;  -- Signal de lecture de la FIFO externe
   -- A chaque mot lu dans une des FIFO, on active le sérialisateur
   start_ser_c <= cop_read_c OR tx_read_c;
   -- L'entrée du sérialisateur dépend du signal de sélection (i.e. recopie ou transmission d'une trame)
   datatx_mux_c <= tx_dat WHEN (sel_par = '0') ELSE fifocopy_dout;
   
   man_fsm : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_switch <= copproc_st;
         sel_par <= '1';
         rx_wr_buf_r <= '0';
         rx_wr_buf_rr <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         rx_wr_buf_r <= rx_wr_buf;
         rx_wr_buf_rr <= rx_wr_buf_r;
         CASE fsm_switch IS               
            WHEN copproc_st =>
            -- Etat d'émission des données de la FIFO de recopie
               IF ((tx_empty = '0') AND (req_cop_c = '0') AND (ser_rdy = '1') AND (sw_ena = '1')) THEN
               -- S'il y'a des données à transmettre dans la FIFO externe (tx_empty = 0) et (qu'il n'y a pas de données
               -- a trasnmettre dans la FIFO de copie ou qu'il n'y en aura pas bientôt)(req_cop_c = 0), et que le dernier
               -- octet est fini d'envoyer (ser_rdy = 1)
                  sel_par <= '0';            -- Les données du sérialisateur viennent de la FIFO externe
                  fsm_switch <= txproc_st;   -- On va émettre une trame
               END IF;

            WHEN txproc_st =>
            -- Etat d'émission des données de la FIFO externe
               IF (tx_empty = '1') THEN
               -- S'il n'y a plus de données à transmettre
                  sel_par <= '1';            -- Les données du sérialisateur viennent de la FIFO de recopie
                  fsm_switch <= copproc_st;  -- Par défaut on est toujours dans cet état
               END IF;
                     
            WHEN OTHERS =>
               fsm_switch <= copproc_st;
         END CASE;
      END IF;
   END PROCESS;
   
   fifo_cop_wren <= rx_wr_buf AND copy_ena;  -- On n'écrit dans la FIFO de copie que si la recopie est autorisée
   inst_fifo_copy : fifo_copy
   PORT MAP (
      clk => clk_sys,
      srst => cop_clr,
      din => data_deser,
      wr_en => fifo_cop_wren,
      rd_en => cop_read_c,
      dout => fifocopy_dout,
      full => OPEN,
      overflow => OPEN,
      empty => cop_empty
   );
   
END rtl;

