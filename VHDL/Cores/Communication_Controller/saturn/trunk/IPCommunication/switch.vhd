--============================================================================= 
--  TITRE : SWITCH
--  DESCRIPTION : 
--        - Gère la réception et la transmission d'une ligne série
--			 - Copie du port Rx sur le port Tx avec remise en forme du signal
--        - Gestion du switch entre les sources Tx
--        - Buffurise les données reçues pendant la transmission		

--  FICHIER :        switch.vhd 
--=============================================================================
--  CREATION 
--  DATE	AUTEUR	PROJET	REVISION 
--  29/02/2012	DRA	CONCERTO	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	AUTEUR	PROJET	REVISION 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;



-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY switch IS
   GENERIC (
      nbbit_div : INTEGER := 10);   -- Nombre de bits pour coder le diviseur d'horloge 
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;  -- Clock système
      rst_n    : IN  STD_LOGIC;  -- Reset génrél système
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
      rx_dat   : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);  -- Donnée en cours de réception
      rx_val   : OUT  STD_LOGIC; -- Signal d'écriture dans la méoire de réception

      -- Gestion de la recopie
      sw_ena   : IN  STD_LOGIC;  -- Autorisation du changement d'émetteur
      copy_ena : IN  STD_LOGIC  -- Autorisation de recopie d'un port sur l'autre
      );
END switch;

ARCHITECTURE rtl of switch is
   SIGNAL data_deser       : STD_LOGIC_VECTOR(7 downto 0);  -- Donnée reçue déserialisée
   SIGNAL tx_copy          : STD_LOGIC;                     -- Valeur d'un bit à retransmettre pour la recopie
   SIGNAL rx_wr_buf        : STD_LOGIC;                     -- Pulse d'écriture d'un nouveau caractère reçu
   SIGNAL rx_encours       : STD_LOGIC;                     -- Indique qu'une réception est en cours

   SIGNAL ser_rdy          : STD_LOGIC;                     -- Le sérialisateur est prêt à traiter un nouveau car
   SIGNAL tx_ser           : STD_LOGIC;                     -- Sortie du sérialisateur
   
   SIGNAL sel_ser          : STD_LOGIC;                     -- Sélection de la source série pour le Tx (recopie ou sérialisateur)
   SIGNAL sel_par          : STD_LOGIC;                     -- Sélection de la source parallèle pour le sérialisateur (FIFO de copy ou transmission)
   SIGNAL datatx_mux_c     : STD_LOGIC_VECTOR(7 downto 0);  -- Source parallèle pour le sérialisateur (FIFO de copy ou transmission)
   SIGNAL fifocopy_dout    : STD_LOGIC_VECTOR(7 downto 0);  -- Donnée en sortie de la FIFO de recopie
   SIGNAL start_ser_c      : STD_LOGIC;                     -- Déclenche la sérialisation du mot présent sur datatx_mux_c
   SIGNAL cop_read_c       : STD_LOGIC;                     -- Lit un car dans la FIFO de recopie
   SIGNAL tx_read_c        : STD_LOGIC;                     -- Lit un car dans la mémoire de transmission
   SIGNAL cop_empty        : STD_LOGIC;                     -- FIFO de recopie vide
   SIGNAL cop_clr          : STD_LOGIC;                     -- Purge de la FIFO de recopie
   SIGNAL req_cop_c        : STD_LOGIC;                     -- Indique qu'il y'a ou qu'il va y'avoir un caractère dans la FIFO de recopie
   SIGNAL tempo            : STD_LOGIC_VECTOR(nbbit_div-1 downto 0); -- Tempo de 1 bit
   
   -- Machine d'état de gestion du module
   TYPE switch_state IS (idle_st, txreq_st, wait1bit_st, txproc_st, copproc_st);
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
	COMPONENT serial_rx
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
   
   -- FIFO de stockage des données reçues qui ne peuvent pas être recopiées
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
   --------------------------------------------
   -- Déserialisateur des données reçues sur rx 
   -- et remise en forme (retaillage des durée de bit) pour la recopie
   --------------------------------------------
   inst_serial_rx: serial_rx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys => clk_sys,
		rst_n => rst_n,
      baud_lock => baud_lock,
		tc_divclk => tc_divclk,
		tx => tx_copy,
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
		tx => tx_ser,
		ser_rdy => ser_rdy,
		start_ser => start_ser_c,
		tx_dat => datatx_mux_c
	);

   --------------------------------------------
   -- Machine d'état de gestion de la source de tx
   --   Soit on recopie le rx
   --   Soit on émet des données reçues et stockées dans la FIFO rx
   --   Soit on émet une trame (FIFO externe au module)
   --------------------------------------------
   -- Indique qu'il y'a des données (cop_empty) ou qu'il va y'en avoir (rx_encours et rx_wr_buf et
   -- copy_ena) dans la FIFO de recopie
   req_cop_c <= NOT(cop_empty) OR ((rx_encours OR rx_wr_buf) AND copy_ena);
   man_fsm : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_switch <= idle_st;
         sel_ser <= '0';
         sel_par <= '1';
         cop_clr <= '1';
         tempo   <= (OTHERS => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_switch IS
            WHEN idle_st =>
            -- Dans cet état, la FIO Tx et la FIFO copy sont forcément vides
                              IF (rx_encours = '0') THEN -- Le nouvel état de copy_ena n'est pris en compte que sur une frontière octet
                  sel_ser <= copy_ena;    -- Si la copie n'est pas autorisée, tx est de base sur le sérialisateur
               END IF;
               sel_par <= '1';
               cop_clr <= '1';         -- Par défaut, la FIFO de recopie doit être vide
               IF (tx_empty = '0') THEN
               -- S'il y'a des données à transmettre dans la FIFO externe
                  fsm_switch <= txreq_st;
               END IF;
               
            WHEN txreq_st =>
            -- Etat d'attente que les conditions soient favorables pour changer la source du tx
               IF ((sw_ena = '1' AND rx_encours = '0') OR 
                    (copy_ena = '0')) THEN
               -- Si la recopie est interdite, on change quand on veut
               -- Sinon, il faut attendre d'être entre 2 trames (sw_ena) et qu'on est pas déjà en train de recopier le car suivant
                  sel_ser <= '0';            -- Le tx est sur le sérialisateur
                  sel_par <= '0';            -- Les données du sérialisateur viennent de la FIFO externe
                  cop_clr <= not(copy_ena);  -- Si la recopie est interdite on purge la FIFO de recopie
                  tempo   <= (OTHERS => '0');
                  fsm_switch <= wait1bit_st;
               END IF;

            WHEN wait1bit_st =>
            -- Etat d'attente de 1 bit pour assurer que le STOP bit recopié fait au moins un bit
               IF (tempo = tc_divclk) THEN
                  fsm_switch <= txproc_st;
               ELSE
                  tempo <= tempo + 1;
               END IF;
               
            WHEN txproc_st =>
            -- Etat d'émission des données de la FIFO externe
               IF ((tx_empty = '1') AND (req_cop_c = '1')) THEN
               -- S'il n'y a plus rien à émettre dans la FIFO externe et qu'il y'a des données dans la FIFO de recopie
                  sel_ser <= '0';            -- Le tx est sur le sérialisateur
                  sel_par <= '1';            -- Les données du sérialisateur viennent de la FIFO de recopie
                  cop_clr <= not(copy_ena);
                  fsm_switch <= copproc_st;
               ELSIF ((tx_empty = '1') AND (ser_rdy = '1') AND (req_cop_c = '0')) THEN
               -- Si n'y a plus rien à émettre dans aucune FIFO et que l'émission du dernier car est finie
                  sel_ser <= copy_ena;       -- Le tx est branché sur le rx si la recopie est autorisée
                  sel_par <= '1';
                  cop_clr <= '1';
                  fsm_switch <= idle_st;
               END IF;
                  
            WHEN copproc_st =>
            -- Etat d'émission des données de la FIFO de recopie
               IF ((tx_empty = '0') AND (req_cop_c = '0')) THEN
               -- S'il n'y a plus rien à émettre dans la FIFO de recopie et qu'il y'a des données dans la FIFO externe
                  sel_ser <= '0';            -- Le tx est sur le sérialisateur
                  sel_par <= '0';            -- Les données du sérialisateur viennent de la FIFO externe
                  cop_clr <= not(copy_ena);
                  fsm_switch <= txproc_st;
               ELSIF ((tx_empty = '1') AND (ser_rdy = '1') AND (req_cop_c = '0') AND 
                      (sw_ena = '1' OR copy_ena = '0')) THEN
               -- Si n'y a plus rien à émettre dans aucune FIFO et que l'émission du dernier car est finie
               -- et que soit on est pas au milieu d'une trame (sw_ena = 1) ou bien que la copy n'est pas 
               -- autorisé (dans ce cas on peut switcher quand on veut)
                  sel_ser <= copy_ena;       -- Le tx est branché sur le rx si la recopie est autorisée
                  sel_par <= '1';
                  cop_clr <= '1';
                  fsm_switch <= idle_st;
               END IF;
   
            WHEN OTHERS =>
               fsm_switch <= idle_st;
         END CASE;
      END IF;
   END PROCESS;
   
   -- On lit un mot dans la FIFO de recopie chaque fois que le sérialisateur est prêt et qu'on est dans le bon état
   cop_read_c <= ser_rdy AND NOT(cop_empty) WHEN (fsm_switch = copproc_st) ELSE '0';
   -- On lit un mot dans la FIFO externe chaque fois que le sérialisateur est prêt et qu'on est dans le bon état
   tx_read_c <= ser_rdy AND NOT(tx_empty) WHEN (fsm_switch = txproc_st) ELSE '0';
   tx_rd <= tx_read_c;
   -- A cahque mot lu dans une des FIFO, on active le sérialisateur
   start_ser_c <= cop_read_c OR tx_read_c;
   -- L'entrée du sérialisateur dépend du signal de sélection
   datatx_mux_c <= tx_dat WHEN (sel_par = '0') ELSE fifocopy_dout;
   -- La sortie tx dépend du signal de sélection. Il n'y a pas de problème de glitch car sel_ser ne 
   -- change qu'entre 2 caractère et donc la ligne est IDLE à ce moment là
   tx <= tx_ser WHEN (sel_ser = '0') ELSE tx_copy;
   
   inst_fifo_copy : fifo_copy
   PORT MAP (
      clk => clk_sys,
      srst => cop_clr,
      din => data_deser,
      wr_en => rx_wr_buf,
      rd_en => cop_read_c,
      dout => fifocopy_dout,
      full => OPEN,
      overflow => OPEN,
      empty => cop_empty
   );
   
END rtl;

