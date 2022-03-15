--
-- VHDL: CPU8BIT TESTBENCH
--	gferrante@opencores.org
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

   COMPONENT cpu8bit	-- CPU8BIT_TIMESIM.VHD
	port (
    	TXD 		: out STD_LOGIC; 
    	RXD 		: in STD_LOGIC := 'X'; 
    	NRESET 	: in STD_LOGIC := 'X'; 
    	UCLK 		: in STD_LOGIC := 'X'; 
    	OUT0_REG 	: out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    	OUT1_REG 	: out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    	IN1_REG 	: in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    	IN0_REG 	: in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    	IN_INT 	: in STD_LOGIC_VECTOR ( 3 downto 0 ) 
  	);
   END COMPONENT;
   
   COMPONENT CLOCK
	GENERIC (
		Tclock: TIME := 66 ns		
	);
	PORT (
		clk: out std_logic
	);
   END COMPONENT;

   COMPONENT WORLD
	PORT (
		clk:	in std_logic;
		porta: 	out std_logic_vector(7 downto 0);
		portb: 	out std_logic_vector(7 downto 0);
		in_int: 	out std_logic_vector(3 downto 0);
		rxd: 	out std_logic := '1';
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
			TXD 		=> TXD,
			RXD 		=> RXD,
      		NRESET 	=> nreset,
      		UCLK 		=> clk,
      		OUT0_REG	=> PORT0_OUT,
			OUT1_REG	=> PORT1_OUT,
			IN1_REG	=> PORT0_IN,
			IN0_REG	=> PORT1_IN,
      		IN_INT	=> IN_INT
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
		clk	=> clk,
		porta	=> PORT0_IN,
		portb	=> PORT1_IN,
		in_int	=> IN_INT,
   		rxd 	=> RXD,
		nreset	=> nreset
      );

init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once 
WAIT;                                                       
END PROCESS init;                                           
   
END struct;
