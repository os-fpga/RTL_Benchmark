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

   SIGNAL clk               : std_logic;
   SIGNAL nreset	    	    : std_logic;
   SIGNAL pwm_out           : std_logic;
   SIGNAL nWE_CPU 	    : std_logic;
   SIGNAL nRE_CPU 	    : std_logic;

   SIGNAL CPU_IADDR 	    : std_logic_vector(7 downto 0);
   SIGNAL CPU_DADDR 	    : std_logic_vector(5 downto 0);
   SIGNAL CPU_DATA_OUT 	    : std_logic_vector(3 downto 0);

   SIGNAL ctrl_out          : std_logic_vector(3 downto 0);
   SIGNAL ctrl_in           : std_logic_vector(3 downto 0);	

   -- Component Declarations

   COMPONENT cpu4bit
    PORT (
    nre_cpu : out STD_LOGIC; 
    nwe_cpu : out STD_LOGIC; 
    pwm_out : out STD_LOGIC; 
    nreset : in STD_LOGIC := 'X'; 
    clk : in STD_LOGIC := 'X'; 
    cpu_daddr : out STD_LOGIC_VECTOR ( 5 downto 0 ); 
    ctrl_data_out : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    cpu_iaddr : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    cpu_data_out : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    ctrl_data_in : in STD_LOGIC_VECTOR ( 3 downto 0 ) 
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
		CTRL_DATA_IN :	out std_logic_vector(3 DOWNTO 0);
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
		CLK => clk, 
		NRESET => nreset, 
		PWM_OUT => pwm_out, 
		nWE_CPU => nWE_CPU,
		nRE_CPU => nRE_CPU, 
		CTRL_DATA_IN => ctrl_in, 
		CPU_DATA_OUT => CPU_DATA_OUT, 
		CPU_IADDR => CPU_IADDR, 
		CTRL_DATA_OUT => ctrl_out, 
		CPU_DADDR => CPU_DADDR
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
		CTRL_DATA_IN => ctrl_in,
		nreset 	=> nreset
      );

init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once 

WAIT;                                                       
END PROCESS init;                                           
   
END struct;
