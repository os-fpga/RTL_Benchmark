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

ENTITY rxtx_tb IS
END rxtx_tb;

ARCHITECTURE rtl of rxtx_tb is
   SIGNAL rx_dat    : STD_LOGIC_VECTOR(7 downto 0);  -- Donn�e re�ue d�serialis�e
   SIGNAL val     : STD_LOGIC;                     -- Pulse d'�criture d'un nouveau caract�re re�u
   SIGNAL rx_encours       : STD_LOGIC;                     -- Indique qu'une d�serialisation est en cours
   SIGNAL ser_rdy          : STD_LOGIC;                     -- Le s�rialisateur est pr�t � traiter un nouveau car
   SIGNAL start_ser          : STD_LOGIC;                     -- S�lection de la source parall�le pour le s�rialisateur (FIFO de copy ou transmission)
   CONSTANT nbbit_div   : INTEGER := 10;   -- Nombre de bits pour coder le diviseur d'horloge 
   SIGNAL clk_sys1      :  STD_LOGIC := '1';  -- Clock syst�me
   SIGNAL clk_sys2      :  STD_LOGIC := '1';  -- Clock syst�me
   SIGNAL rst_n         :  STD_LOGIC := '0';  -- Reset g�n�ral syst�me
   SIGNAL baud_lock     :  STD_LOGIC := '1';  -- Indique que le baudrate est cal�
   SIGNAL tc_divclk     :  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0):= "0000000111"; -- Diviseur de l'horloge syst�me pour le baudrate
   SIGNAL rx            :  STD_LOGIC;  -- R�ception s�rie    
   SIGNAL datatx        :  STD_LOGIC_VECTOR (7 DOWNTO 0) := x"00";  -- Prochaine donn�e � transmettre


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
   
   
BEGIN
   clk_sys1 <= NOT(clk_sys1) AFTER 3999 ps;
   clk_sys2 <= NOT(clk_sys2) AFTER 4001 ps;
   rst_n <= '0', '1' after 10 ns;

   inst_serial_rx: serial_rx2 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys => clk_sys2,
		rst_n => rst_n,
      baud_lock => baud_lock,
		tc_divclk => tc_divclk,
		tx => OPEN,
		rx => rx,
      busy => rx_encours,
		val => val,
		rx_dat => rx_dat
	);
   
   inst_serial_tx: serial_tx 
   GENERIC MAP (
      nbbit_div => nbbit_div)
   PORT MAP(
		clk_sys => clk_sys1,
		rst_n => rst_n,
		tc_divclk => tc_divclk,
		tx => rx,
		ser_rdy => ser_rdy,
		start_ser => start_ser,
		tx_dat => datatx
	);
   
   start_ser <= ser_rdy;
   process(clk_sys1)
   begin
      IF (rising_edge(clk_sys1)) THEN
         IF (ser_rdy = '1') THEN
            datatx <= datatx + 1;
         END IF;
      END IF;
   end process;

   
END rtl;

