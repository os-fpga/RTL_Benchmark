--
-- VHDL: CPUC TESTBENCH
-- gferrante@opencores.org
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use work.CPUC_UTILS.all;

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
   SIGNAL INT_IN  	: std_logic;
   SIGNAL DWAIT_IN  	: std_logic;
   SIGNAL NDRE_OUT  	: std_logic;
   SIGNAL NDWE_OUT  	: std_logic;
   SIGNAL NADWE_OUT  	: std_logic;
   SIGNAL IDATA_IN 	: std_logic_vector(31 downto 0);
   SIGNAL DATA_IN		: std_logic_vector(31 downto 0);
   SIGNAL IADDR_OUT	: std_logic_vector(26 downto 0);
   SIGNAL DATA_OUT	: std_logic_vector(31 downto 0);
   SIGNAL DADDR_OUT	: std_logic_vector(26 downto 0);
   SIGNAL ADADDR_OUT	: std_logic_vector(26 downto 0);

   -- Component Declarations

   COMPONENT cpuC
   PORT ( 
		iaddr_out: 	out	Cpu_iaddr;
		data_out: 	out	Cpu_dobus;
		daddr_out: 	out	Cpu_daddr;
		adaddr_out: out	Cpu_daddr;
		idata_in: 	in	Cpu_ibus;
		data_in: 	in	Cpu_dibus;
		ndre_out:	out	std_logic;
		ndwe_out:	out	std_logic;
		nadwe_out:	out	std_logic;
		int_in:	in	std_logic;
		dwait_in:	in	std_logic;
		nreset_in:	in	std_logic;
		clk_in:	in	std_logic
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
		cpu_int: 	out std_logic;
		nreset: 	out std_logic
		);
   END COMPONENT;

   COMPONENT RAM
	GENERIC(
		DADDR_LEN:	integer:= 8;
		DATA_LEN:	integer:= 8;
	      FILENAME:   STRING:="ram.vin"
	);    
  	PORT(	
		ram_data_out: 	out 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_data_in: 	in 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_addr_in: 	in 	std_logic_vector((DADDR_LEN - 1) downto 0);
		nwe:			in	std_logic;
		nreset:		in	std_logic;
		clk:			in	std_logic
	);
   END COMPONENT;

   COMPONENT ROM
	GENERIC(
		IADDR_LEN:	integer:= 8;
		IDATA_LEN:	integer:= 10;
		FILENAME:   STRING:="rom.vin"
	);    
  	PORT(	
		rom_data_out: 	out 	std_logic_vector((IDATA_LEN - 1) downto 0);
		rom_addr_in: 	in 	std_logic_vector((IADDR_LEN - 1) downto 0);
		clk:			in	std_logic
	);
   END COMPONENT;

   -- Optional embedded configurations
   FOR ALL : CPUC USE ENTITY WORK.CPUC;
   FOR ALL : RAM USE ENTITY WORK.RAM;
   FOR ALL : ROM USE ENTITY WORK.ROM;
   FOR ALL : CLOCK USE ENTITY WORK.CLOCK;
   FOR ALL : WORLD USE ENTITY WORK.WORLD;

begin

   -- Instance port mappings

   I1 : CPUC
      PORT MAP (
		iaddr_out		=> IADDR_OUT,
		data_out		=> DATA_OUT,
		daddr_out		=> DADDR_OUT,
		adaddr_out		=> ADADDR_OUT,
		idata_in		=> IDATA_IN,
		data_in		=> DATA_IN,
		ndre_out		=> NDRE_OUT,
		ndwe_out		=> NDWE_OUT,
		nadwe_out		=> NADWE_OUT,
		int_in		=> INT_IN,
		dwait_in		=> DWAIT_IN,
		nreset_in		=> NRESET_IN,
		clk_in		=> CLK_IN
       );

   I2 : CLOCK
      GENERIC MAP (
         tclock 			=> 50 ns
      )
      PORT MAP (
         	clk 			=> CLK_IN
      );

   I3 : WORLD
      PORT MAP (
		clk			=> CLK_IN,
		cpu_int		=> INT_IN,
		nreset		=> NRESET_IN
      );
   
   I4 : ROM
      GENERIC MAP (
		IADDR_LEN		=> 10,
		IDATA_LEN		=> 32,
		FILENAME		=> "..\romT.vin"
      )
      PORT MAP (
		rom_data_out	=> IDATA_IN,
		rom_addr_in		=> IADDR_OUT(9 downto 0),
		clk			=> CLK_IN
      );

   I5 : RAM
      GENERIC MAP (
		DADDR_LEN		=> 10,
		DATA_LEN		=> 32,
	      FILENAME		=> "..\ramT.vin"
      )
      PORT MAP (
		ram_data_out	=> DATA_IN,
		ram_data_in		=> DATA_OUT,
		ram_addr_in		=> DADDR_OUT(9 downto 0),
		nwe			=> NDWE_OUT,
		nreset		=> NRESET_IN,
		clk			=> CLK_IN
      );

      DWAIT_IN		<=	'0';

END struct;
