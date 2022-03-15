--
-- VHDL: CPU4BIT TESTBENCH
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

   SIGNAL clk               	: std_logic;
   SIGNAL nreset	    	    	: std_logic;
   SIGNAL pwm_out           	: std_logic;
   SIGNAL nWE_CPU 	 	: std_logic;
   SIGNAL nRE_CPU 		: std_logic;

   SIGNAL CPU_IADDR_OUT		: std_logic_vector(7 downto 0);
   SIGNAL CPU_DADDR_OUT 	: std_logic_vector(5 downto 0);
   SIGNAL CPU_DATA_OUT 	    	: std_logic_vector(3 downto 0);

   SIGNAL ctrl_out          	: std_logic_vector(3 downto 0);
   SIGNAL ctrl_in           	: std_logic_vector(3 downto 0);	

   -- Component Declarations

   COMPONENT cpu4bit
    PORT (
	nreset : 		IN std_logic;
	clk : 		IN std_logic;
	ctrl_data_in: 		IN std_logic_vector(3 DOWNTO 0);
	pwm_out : 		OUT std_logic;
	nWE_CPU : 		OUT std_logic;
	CPU_IADDR_OUT : OUT std_logic_vector(7 DOWNTO 0);
	nRE_CPU : 		OUT std_logic;
	CPU_DADDR_OUT : OUT std_logic_vector(5 DOWNTO 0);
	CPU_DATA_OUT : 	OUT std_logic_vector(3 DOWNTO 0);
	CTRL_DATA_OUT : OUT std_logic_vector(3 DOWNTO 0)
	);
   END COMPONENT;
   
   COMPONENT CLOCK
   GENERIC (
      tclock : TIME := 50 ns
   );
   PORT (
      clk: 		out   std_logic
   );
   END COMPONENT;

   COMPONENT WORLD
   PORT (
		clk:	in std_logic;
		ctrl_data_in:	out std_logic_vector(3 DOWNTO 0);
		nreset: out std_logic
   );
   END COMPONENT;
  
   -- Optional embedded configurations
   FOR ALL : CPU4BIT USE ENTITY WORK.CPU4BIT;
   FOR ALL : CLOCK USE ENTITY WORK.CLOCK;
   FOR ALL : WORLD USE ENTITY WORK.WORLD;

begin

   -- Instance port mappings

   I1 : CPU4BIT
      PORT MAP (
		nreset		=> nreset,
		clk		=> clk,
		ctrl_data_in		=> ctrl_in,
		pwm_out 		=> pwm_out,
		nWE_CPU 		=> nWE_CPU,
		CPU_IADDR_OUT 		=> CPU_IADDR_OUT, 
		nRE_CPU 		=> nRE_CPU,
		CPU_DADDR_OUT 		=> CPU_DADDR_OUT,
		CPU_DATA_OUT 		=> CPU_DATA_OUT,
		CTRL_DATA_OUT 		=> ctrl_out	
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
		clk 		=> clk,
		ctrl_data_in => ctrl_in,
		nreset 	=> nreset
      );

init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once 
WAIT;                                                       
END PROCESS init;                                           
   
END struct;
