--
-- VHDL: CPU16BIT TESTBENCH
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

   SIGNAL CLK_IN        : std_logic;
   SIGNAL NRESET_IN	: std_logic;
   SIGNAL CPU_INT  	: std_logic;
   SIGNAL NRE_EXT 	: std_logic;
   SIGNAL NWE_EXT 	: std_logic;
   SIGNAL NCS_EXT 	: std_logic;
   SIGNAL ADDR_OUT_EXT	: std_logic_vector(9 downto 0);
   SIGNAL DATA_IN_EXT 	: std_logic_vector(15 downto 0);
   SIGNAL DATA_OUT_EXT	: std_logic_vector(15 downto 0);

   -- Component Declarations

   COMPONENT cpu16bit
   PORT ( 
    NCS_EXT : out STD_LOGIC; 
    NRE_EXT : out STD_LOGIC; 
    NWE_EXT : out STD_LOGIC; 
    NRESET_IN : in STD_LOGIC := 'X'; 
    CPU_INT : in STD_LOGIC := 'X'; 
    CLK_IN : in STD_LOGIC := 'X'; 
    ADDR_OUT_EXT : out STD_LOGIC_VECTOR ( 9 downto 0 ); 
    DATA_OUT_EXT : out STD_LOGIC_VECTOR ( 15 downto 0 ); 
    DATA_IN_EXT : in STD_LOGIC_VECTOR ( 15 downto 0 ) 
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
		clk:		in  std_logic;
		nwe:		in  std_logic;
		ncs:		in  std_logic;
		port_out: 	in  std_logic_vector(15 downto 0);
		port_in: 	out std_logic_vector(15 downto 0);
		cpu_int: 	out std_logic;
		nreset: 	out std_logic
		);
   END COMPONENT;
  
   -- Optional embedded configurations
   FOR ALL : CPU16BIT USE ENTITY WORK.CPU16BIT;
   FOR ALL : CLOCK USE ENTITY WORK.CLOCK;
   FOR ALL : WORLD USE ENTITY WORK.WORLD;

begin

   -- Instance port mappings

   I1 : CPU16BIT
      PORT MAP (
		CLK_IN		=> CLK_IN,  	
		NRESET_IN 		=> NRESET_IN,
		CPU_INT 		=> CPU_INT,
		DATA_IN_EXT		=> DATA_IN_EXT,
		DATA_OUT_EXT	=> DATA_OUT_EXT,
		ADDR_OUT_EXT	=> ADDR_OUT_EXT,
		NRE_EXT 		=> NRE_EXT,
		NWE_EXT 		=> NWE_EXT,
		NCS_EXT 		=> NCS_EXT
       );

   I2 : CLOCK
      GENERIC MAP (
         tclock 		=> 50 ns
      )
      PORT MAP (
         	clk 		=> CLK_IN
      );

I3 : WORLD
      PORT MAP (
		clk			=> CLK_IN,
		nwe			=> NWE_EXT,
		ncs			=> NCS_EXT,
		port_out		=> DATA_OUT_EXT,
		port_in		=> DATA_IN_EXT,
		cpu_int		=> CPU_INT,
		nreset		=> NRESET_IN
      );
   
END struct;
