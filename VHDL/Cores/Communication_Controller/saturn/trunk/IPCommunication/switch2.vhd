--============================================================================= 
--  TITRE : SWITCH
--  DESCRIPTION : 
--        - G�re la r�ception et la transmission d'une ligne s�rie
--			 - Copie octet par octet du port Rx sur le port Tx
--        - Gestion du switch entre les sources Tx (recopie du port Rx sur Tx ou tranmission d'une trame)
--        - Buffurise les donn�es re�ues pendant la transmission		

--  FICHIER :        switch2.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--  18/09/2014 DRA      SATURN   V1.1
--       Prise en comtpe du SW_ENA pour d�tecter l'inter trame
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
      -- Ports syst�me
      clk_sys  : IN  STD_LOGIC;  -- Clock syst�me
      rst_n    : IN  STD_LOGIC;  -- Reset g�n�ral syst�me
      baud_lock: IN  STD_LOGIC;  -- Indique que le baudrate est cal�

      -- Interface s�rie
      tc_divclk: IN  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0); -- Diviseur de l'horloge syst�me pour le baudrate
      rx       : IN  STD_LOGIC;  -- R�ception s�rie    
      tx       : OUT  STD_LOGIC; -- Transmission s�rie
      
      -- Interface avec la m�moire de transmission
      tx_dat   : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);  -- Prochaine donn�e � transmettre
      tx_empty : IN  STD_LOGIC;  -- M�moire de transmission vide
      tx_rd    : OUT  STD_LOGIC; -- Lecture de la donn�e suivante � transmettre

      -- Interface avec la m�moire de r�ception
      rx_dat   : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);  -- Octet d�serialis�
      rx_val   : OUT  STD_LOGIC; -- Signal d'�criture dans la m�oire de r�ception

      -- Gestion de la recopie
      sw_ena   : IN  STD_LOGIC;  -- A '1' entre 2 trames sur le port Rx (RFU)
      copy_ena : IN  STD_LOGIC;   -- Autorisation de recopie du Rx sur Tx;
		etat		: OUT  STD_LOGIC
      );
END switch;

ARCHITECTURE rtl of switch is
   SIGNAL data_deser       : STD_LOGIC_VECTOR(7 downto 0);  -- Donn�e re�ue d�serialis�e
   SIGNAL rx_wr_buf        : STD_LOGIC;                     -- Pulse d'�criture d'un nouveau caract�re re�u
   SIGNAL rx_encours       : STD_LOGIC;                     -- Indique qu'une d�serialisation est en cours
   SIGNAL fifo_cop_wren    : STD_LOGIC;                     -- Signal d'�criture dans la FIFO de recopie
   SIGNAL ser_rdy          : STD_LOGIC;                     -- Le s�rialisateur est pr�t � traiter un nouveau car
   SIGNAL sel_par          : STD_LOGIC;                     -- S�lection de la source parall�le pour le s�rialisateur (FIFO de copy ou transmission)
   SIGNAL datatx_mux_c     : STD_LOGIC_VECTOR(7 downto 0);  -- Source parall�le pour le s�rialisateur (FIFO de copy ou transmission)
   SIGNAL fifocopy_dout    : STD_LOGIC_VECTOR(7 downto 0);  -- Donn�e en sortie de la FIFO de recopie
   SIGNAL start_ser_c      : STD_LOGIC;                     -- D�clenche la s�rialisation du mot pr�sent sur datatx_mux_c
   SIGNAL cop_read_c       : STD_LOGIC;                     -- Lit un car dans la FIFO de recopie
   SIGNAL tx_read_c        : STD_LOGIC;                     -- Lit un car dans la m�moire de transmission
   SIGNAL cop_empty        : STD_LOGIC;                     -- FIFO de recopie vide
   SIGNAL cop_clr          : STD_LOGIC;                     -- Purge de la FIFO de recopie
   SIGNAL req_cop_c        : STD_LOGIC;                     -- Indique qu'il y'a ou qu'il va y'avoir un caract�re dans la FIFO de recopie
   SIGNAL rx_wr_buf_r      : STD_LOGIC;
   SIGNAL rx_wr_buf_rr      : STD_LOGIC;
   -- Machine d'�tat de gestion du module
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

   -- Composant de d�serialisation
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
   
   -- FIFO de stockage des donn�es re�ues
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
   -- D�serialisateur des donn�es re�ues sur rx 
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
   -- S�rialise sur 10 bits une donn�e 8 bits en entr�e 
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
   -- Machine d'�tat de gestion de la source de tx
   --   Soit on recopie des donn�es re�ues et stock�es dans la FIFO rx
   --   Soit on �met une trame (FIFO externe au module)
   --------------------------------------------
   -- Indique qu'il y'a des donn�es (cop_empty) ou qu'il va y'en avoir (rx_encours et rx_wr_buf et
   -- copy_ena) dans la FIFO de recopie
   req_cop_c <= NOT(cop_empty) OR ((rx_encours OR rx_wr_buf OR rx_wr_buf_r OR rx_wr_buf_rr) AND copy_ena);
   -- Tant que le baudrate n'est pas lock� on garde la FIFO de recopie en reset
   cop_clr <= NOT(baud_lock);    --NOT(copy_ena) OR NOT(baud_lock);
   -- On lit un mot dans la FIFO de recopie chaque fois que le s�rialisateur est pr�t et qu'on est dans le bon �tat
   cop_read_c <= ser_rdy AND NOT(cop_empty) WHEN (fsm_switch = copproc_st) ELSE '0';
   -- On lit un mot dans la FIFO externe chaque fois que le s�rialisateur est pr�t et qu'on est dans le bon �tat
   tx_read_c <= ser_rdy AND NOT(tx_empty) WHEN (fsm_switch = txproc_st) ELSE '0';
   tx_rd <= tx_read_c;  -- Signal de lecture de la FIFO externe
   -- A chaque mot lu dans une des FIFO, on active le s�rialisateur
   start_ser_c <= cop_read_c OR tx_read_c;
   -- L'entr�e du s�rialisateur d�pend du signal de s�lection (i.e. recopie ou transmission d'une trame)
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
            -- Etat d'�mission des donn�es de la FIFO de recopie
               IF ((tx_empty = '0') AND (req_cop_c = '0') AND (ser_rdy = '1') AND (sw_ena = '1')) THEN
               -- S'il y'a des donn�es � transmettre dans la FIFO externe (tx_empty = 0) et (qu'il n'y a pas de donn�es
               -- a trasnmettre dans la FIFO de copie ou qu'il n'y en aura pas bient�t)(req_cop_c = 0), et que le dernier
               -- octet est fini d'envoyer (ser_rdy = 1)
                  sel_par <= '0';            -- Les donn�es du s�rialisateur viennent de la FIFO externe
                  fsm_switch <= txproc_st;   -- On va �mettre une trame
               END IF;

            WHEN txproc_st =>
            -- Etat d'�mission des donn�es de la FIFO externe
               IF (tx_empty = '1') THEN
               -- S'il n'y a plus de donn�es � transmettre
                  sel_par <= '1';            -- Les donn�es du s�rialisateur viennent de la FIFO de recopie
                  fsm_switch <= copproc_st;  -- Par d�faut on est toujours dans cet �tat
               END IF;
                     
            WHEN OTHERS =>
               fsm_switch <= copproc_st;
         END CASE;
      END IF;
   END PROCESS;
   
   fifo_cop_wren <= rx_wr_buf AND copy_ena;  -- On n'�crit dans la FIFO de copie que si la recopie est autoris�e
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

