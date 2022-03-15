--
-- VHDL: CPU8BIT TESTBENCH
-- gferrante@opencores.org
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY testbench IS
-- Declarations

END testbench;

LIBRARY ieee, work;
USE ieee.std_logic_1164.all;

LIBRARY std;
USE std.textio.ALL;

ARCHITECTURE struct OF testbench IS

   -- Architecture declarations

   -- Internal signal declarations

   SIGNAL clk         : std_logic;
   SIGNAL nreset	    : std_logic;
   SIGNAL TXD 	    : std_logic;
   SIGNAL RXD 	    : std_logic;
   SIGNAL PORT0_IN    : std_logic_vector(7 downto 0);
   SIGNAL PORT1_IN    : std_logic_vector(7 downto 0);
   SIGNAL PORT0_OUT    : std_logic_vector(7 downto 0);
   SIGNAL PORT1_OUT    : std_logic_vector(7 downto 0);
   SIGNAL IN_INT	    : std_logic_vector(3 downto 0);

   -- Component Declarations

   COMPONENT cpu8bit
    PORT (
	UCLK : IN std_logic;
	nRESET : IN std_logic;
	PORTA_IN : IN std_logic_vector(7 DOWNTO 0);
	PORTB_IN : IN std_logic_vector(7 DOWNTO 0);
	RXD : IN std_logic;
	IN_INT : IN std_logic_vector(3 DOWNTO 0);
	TXD : OUT std_logic;
	PORTA_OUT : OUT std_logic_vector(7 DOWNTO 0);
	PORTB_OUT : OUT std_logic_vector(7 DOWNTO 0)	
	);
   END COMPONENT;
   
   COMPONENT CLOCK
	GENERIC (
		Tclock: TIME := 100 ns		
	);
	PORT (
		clk: out std_logic
	);
   END COMPONENT;

   COMPONENT WORLD
	PORT (
		clk:		in std_logic;
		porta: 	out std_logic_vector(7 downto 0);
		portb: 	out std_logic_vector(7 downto 0);
		in_int: 	out std_logic_vector(3 downto 0);
		rxd: 		out std_logic := '1';
		nreset: 	out std_logic := '1'
		);
   END COMPONENT;
  
   -- Optional embedded configurations
   FOR ALL : CPU8BIT USE ENTITY WORK.CPU8BIT;
   FOR ALL : CLOCK USE ENTITY WORK.CLOCK;
   FOR ALL : WORLD USE ENTITY WORK.WORLD;

begin

   -- Instance port mappings

   I1 : CPU8BIT
      PORT MAP (
		UCLK 		=> clk,
		NRESET 	=> nreset,
		PORTA_IN 	=> PORT0_IN, 
		PORTB_IN 	=> PORT1_IN, 
		RXD 		=> RXD,
		IN_INT 	=> IN_INT,
		TXD		=> TXD,
		PORTA_OUT 	=> PORT0_OUT, 
		PORTB_OUT 	=> PORT1_OUT 
       );

   I2 : CLOCK
      GENERIC MAP (
         tclock 		=> 50 ns
      )
      PORT MAP (
         	clk 		=> clk
      );

I3 : WORLD
      PORT MAP (
		clk		=> clk,
		porta		=> PORT0_IN,
		portb		=> PORT1_IN,
		in_int	=> IN_INT,
		rxd		=> RXD,
		nreset	=> nreset
      );
   
END struct;
