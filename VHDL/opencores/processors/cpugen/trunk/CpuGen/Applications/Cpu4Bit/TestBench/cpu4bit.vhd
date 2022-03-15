-- CPU4BIT 
-- gferrante@opencores.org
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.CPU_UTILS.all;


ENTITY cpu4bit IS
   PORT ( 
	NRESET : IN std_logic;
	CLK : IN std_logic;
	CTRL_DATA_IN : IN std_logic_vector(3 DOWNTO 0);
	PWM_OUT : OUT std_logic;
	nWE_CPU : OUT std_logic;
	CPU_IADDR_OUT : OUT std_logic_vector(7 DOWNTO 0);
	nRE_CPU : OUT std_logic;
	CPU_DADDR_OUT : OUT std_logic_vector(5 DOWNTO 0);
	CPU_DATA_OUT : OUT std_logic_vector(3 DOWNTO 0);
	CTRL_DATA_OUT : OUT std_logic_vector(3 DOWNTO 0)
	);
end cpu4bit;

ARCHITECTURE SCHEMATIC OF cpu4bit IS

   SIGNAL CPU_DATA_IN		:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL CPU_IDATA		:	STD_LOGIC_VECTOR (9 DOWNTO 0);
   SIGNAL CPU_IADDR_DUMMY		:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL RAM_DATA_OUT		:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL PWM_DATA_OUT		:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL CPU_DADDR_DUMMY		:	STD_LOGIC_VECTOR (5 DOWNTO 0);
   SIGNAL CPU_ADADDR_DUMMY		:	STD_LOGIC_VECTOR (5 DOWNTO 0);
   SIGNAL CPU_DATA_OUT_DUMMY		:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL CTRL_DATA_OUT_DUMMY		:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL	nCS_PWM : STD_LOGIC;
   SIGNAL	nWR_RAM : STD_LOGIC;
   SIGNAL	nWE_CPU_DUMMY : STD_LOGIC;
   SIGNAL	nAWE_CPU_DUMMY : STD_LOGIC;
   SIGNAL	nRE_CPU_DUMMY : STD_LOGIC;

   COMPONENT cpu
      PORT ( 		
		iaddr_out: 		out	Cpu_iaddr;
		data_out: 		out	Cpu_dobus;
		daddr_out: 		out	Cpu_daddr;
		adaddr_out: 		out	Cpu_daddr;
		idata_in: 		in	Cpu_ibus;
		data_in: 		in	Cpu_dibus;
		ndre_out:		out	std_logic;
		ndwe_out:		out	std_logic;
		nadwe_out:		out	std_logic;
		nreset_in:		in	std_logic;
		clk_in:		in	std_logic
	);
   END COMPONENT;

   COMPONENT ctrl4cpu
      PORT ( 
		nWR_RAM:		out	std_logic;
		nCS_PWM:		out	std_logic;
		CPU_DATA_IN:		out	std_logic_vector(3 downto 0);
		CTRL_DATA_OUT:		out	std_logic_vector(3 downto 0);
		PWM_DATA_OUT:		out	std_logic_vector(7 downto 0);
		CPU_ADDR_OUT:		in	std_logic_vector(4 downto 0);
		CPU_DATA_OUT:		in	std_logic_vector(3 downto 0);		
		RAM_DATA_OUT:		in	std_logic_vector(3 downto 0);
		CTRL_DATA_IN:		in	std_logic_vector(3 downto 0);
		nWE_CPU:		in	std_logic;
		nRE_CPU:		in	std_logic;
		clk:		in	std_logic;
		nreset:		in	std_logic
	);
   END COMPONENT;

   COMPONENT pwm
      PORT ( 
		pwm_out:		out   std_logic := '0';
		pwm_data:		in	std_logic_vector(7 downto 0);
		addr:			in	std_logic;
		nWR:			in	std_logic;
		nCS_PWM:		in	std_logic;
		pwm_enable:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
   END COMPONENT;

   COMPONENT ram
  	GENERIC(
		DADDR_LEN:		integer:= 8;
		DATA_LEN:		integer:= 8;
	      FILENAME:		STRING:="ram.vin"
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

   COMPONENT rom
  generic(
		IADDR_LEN:		integer:= 8;
		IDATA_LEN:		integer:= 10;
		FILENAME:   	STRING:="rom.vin"
	);    
  port(	
		rom_data_out: 		out 	std_logic_vector((IDATA_LEN - 1) downto 0);
		rom_addr_in: 		in 	std_logic_vector((IADDR_LEN - 1) downto 0);
		clk:		in	std_logic
	);
   END COMPONENT;

BEGIN

   XLXI_1 : cpu
      PORT MAP (
		iaddr_out		=> CPU_IADDR_DUMMY,
		data_out		=> CPU_DATA_OUT_DUMMY,
		daddr_out		=> CPU_DADDR_DUMMY,
		adaddr_out		=> CPU_ADADDR_DUMMY,
		idata_in		=> CPU_IDATA,
		data_in		=> CPU_DATA_IN,
		ndre_out		=> nRE_CPU_DUMMY,
		ndwe_out		=> nWE_CPU_DUMMY,
		nadwe_out		=> nAWE_CPU_DUMMY,
		nreset_in		=> NRESET,
		clk_in		=> CLK	
	);

   XLXI_2 : ctrl4cpu
      PORT MAP (
		nWR_RAM		=> nWR_RAM,
		nCS_PWM		=> nCS_PWM,
		CPU_DATA_IN		=> CPU_DATA_IN,
		CTRL_DATA_OUT		=> CTRL_DATA_OUT_DUMMY,
		PWM_DATA_OUT		=> PWM_DATA_OUT,
		CPU_ADDR_OUT		=> CPU_DADDR_DUMMY(4 downto 0),
		CPU_DATA_OUT		=> CPU_DATA_OUT_DUMMY,	
		RAM_DATA_OUT		=> RAM_DATA_OUT,
		CTRL_DATA_IN		=> CTRL_DATA_IN,
		nWE_CPU		=> nWE_CPU_DUMMY,
		nRE_CPU		=> nRE_CPU_DUMMY,
		clk		=> CLK,
		nreset		=> NRESET
	);

   XLXI_3 : pwm
      PORT MAP (
		pwm_out		=> PWM_OUT,
		pwm_data		=> PWM_DATA_OUT,
		addr			=> CPU_DADDR_DUMMY(2),
		nWR			=> nWE_CPU_DUMMY,
		nCS_PWM		=> nCS_PWM,
		pwm_enable		=> CTRL_DATA_OUT_DUMMY(0),
		clk		=> CLK,
		nreset		=> NRESET
	);

   XLXI_4 : ram
  	GENERIC MAP(
		DADDR_LEN		=> 4,
		DATA_LEN		=> 4,
	        FILENAME			=> "..\ram.vin"
	)    
      PORT MAP (
		ram_data_out	=> RAM_DATA_OUT,
		ram_data_in		=> CPU_DATA_OUT_DUMMY,
		ram_addr_in		=> CPU_DADDR_DUMMY(3 downto 0),
		nwe			=> nWR_RAM,
		nreset		=> NRESET,
		clk			=> CLK
	);

   XLXI_5 : rom
  	GENERIC MAP(
		IADDR_LEN		=> 8,
		IDATA_LEN		=> 10,
	        FILENAME			=> "..\rom.vin"
	)    
      PORT MAP (
		rom_data_out		=> CPU_IDATA,
		rom_addr_in		=> CPU_IADDR_DUMMY,
		clk		=> CLK
	);

	CPU_DADDR_OUT		<=	CPU_DADDR_DUMMY;
	CPU_IADDR_OUT		<=	CPU_IADDR_DUMMY;
	CPU_DATA_OUT		<=	CPU_DATA_OUT_DUMMY;
	CTRL_DATA_OUT		<=	CTRL_DATA_OUT_DUMMY;
	nWE_CPU		<=	nWE_CPU_DUMMY;
	nRE_CPU		<=	nRE_CPU_DUMMY;

END SCHEMATIC;



