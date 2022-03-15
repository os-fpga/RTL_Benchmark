LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use work.CPU_UTILS.all;


ENTITY cpu16bit IS 
	port
	(
		nreset_in :  IN  STD_LOGIC;
		clk_in :  IN  STD_LOGIC;
		cpu_int :  IN  STD_LOGIC;
		DATA_IN_EXT :  IN  STD_LOGIC_VECTOR(15 downto 0);
		NRE_EXT :  OUT  STD_LOGIC;
		NWE_EXT :  OUT  STD_LOGIC;
		NCS_EXT :  OUT  STD_LOGIC;
		ADDR_OUT_EXT :  OUT  STD_LOGIC_VECTOR(9 downto 0);
		DATA_OUT_EXT :  OUT  STD_LOGIC_VECTOR(15 downto 0)
	);
END cpu16bit;

ARCHITECTURE bdf_type OF cpu16bit IS 

component ram
  generic(
		DADDR_LEN:	integer:= 8;
		DATA_LEN:	integer:= 8;
	      FILENAME:   STRING:="ram.vin"
	);    
  port(	
		ram_data_out: 	out 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_data_in: 	in 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_addr_in: 	in 	std_logic_vector((DADDR_LEN - 1) downto 0);
		nwe:			in	std_logic;
		nreset:		in	std_logic;
		clk:			in	std_logic
	);
end component;

component cpu
	PORT(
		saddr_out:	out	Cpu_iaddr;
		ipush_out:	out	std_logic;
		ipop_out:	out	std_logic;
		saddr_in:	in	Cpu_iaddr;
		iaddr_out: 	out	Cpu_iaddr;
		data_out: 	out	Cpu_dobus;
		daddr_out: 	out	Cpu_daddr;
		adaddr_out: out	Cpu_daddr;
		idata_in: 	in	Cpu_ibus;
		data_in: 	in	Cpu_dibus;
		ndre_out:	out	std_logic;
		ndwe_out:	out	std_logic;
		nadwe_out:	out	std_logic;
		int_in:		in	std_logic;
		dwait_in:	in	std_logic;
		iwait_in:	in	std_logic;
		nreset_in:	in	std_logic;
		clk_in:		in	std_logic
	);
end component;

component stack_t
   GENERIC(
		DATA_LEN:	integer:= 8;
		DEEP_LEN:	integer:= 8
	);    
   PORT(	
		saddr_in: 		out 	std_logic_vector((DATA_LEN - 1) downto 0);
		saddr_out: 		in 	std_logic_vector((DATA_LEN - 1) downto 0);
		ipush_out: 		in 	std_logic;
		ipop_out:		in	std_logic;
		nreset_in:		in	std_logic;
		clk_in:		in	std_logic
	);
end component;

component h2v
  generic(
		MADDR_LEN:	integer:= 10
	);    	
	port(
		maddr:		out	std_logic_vector((MADDR_LEN - 1) downto 0);							
		iwait_out:	out std_logic;
		iaddr:		in	std_logic_vector((MADDR_LEN - 1) downto 0);		
		daddr:		in	std_logic_vector((MADDR_LEN - 1) downto 0);				
		ndre_in:	in	std_logic;
		nadwe_in:	in	std_logic;
		dwait_in:	in	std_logic;		
		nreset_in:	in	std_logic;
		clk_in:		in	std_logic
	);
end component;

component ctrl16cpu
	generic(
		DADDR_LEN:	integer:= 10;
		DATA_LEN:	integer:= 16
	);
	port(
		nWE_RAM:		out	std_logic;		
		nCS_EXT:		out	std_logic;								
		nACS_EXT:		out	std_logic;								
		DATA_OUT:		out	std_logic_vector((DATA_LEN - 1) downto 0);
		DATA_IN_RAM:	in	std_logic_vector((DATA_LEN - 1) downto 0);
		DATA_IN_EXT:	in	std_logic_vector((DATA_LEN - 1) downto 0);		
		ADADDR_IN:		in	std_logic_vector((DADDR_LEN - 1) downto 0);	
		nADWE_CPU:		in	std_logic;	
		nreset_in:		in	std_logic;				
		clk_in:			in	std_logic
	);
end component;

component waitstategen
	generic(
		DADDR_LEN:	integer:= 10;
		DATA_LEN:	integer:= 16;
		NWAIT:		std_logic_vector(7 downto 0):= "00000111"
	);
	port(	
		dwait_out:			out std_logic;
		cpu_data_in_m:		out	std_logic_vector((DATA_LEN - 1) downto 0);
		cpu_daddr_out:		out	std_logic_vector((DADDR_LEN - 1) downto 0);
		ndre_out:			out	std_logic;
		ndwe_out:			out	std_logic;			
		cpu_data_in:		in	std_logic_vector((DATA_LEN - 1) downto 0);
		cpu_adaddr_out_m: 	in	std_logic_vector((DADDR_LEN - 1) downto 0);	
		nacs_wait:			in	std_logic;			
		ndre_in:			in	std_logic;
		nadwe_in:			in	std_logic;							
		nreset_in:			in	std_logic;
		clk_in:				in	std_logic
	);
end component;

signal	CPU_ADADDR_OUT :  STD_LOGIC_VECTOR(11 downto 0);
signal	CPU_DATA_IN :  STD_LOGIC_VECTOR(15 downto 0);
signal	CPU_DATA_IN_M :  STD_LOGIC_VECTOR(15 downto 0);
signal	CPU_DATA_OUT :  STD_LOGIC_VECTOR(15 downto 0);
signal	CPU_IADDR_OUT :  STD_LOGIC_VECTOR(11 downto 0);
signal	CPU_nADWE :  STD_LOGIC;
signal	CPU_nDRE :  STD_LOGIC;
signal	DWAIT_IN :  STD_LOGIC;
signal	MEM_DATA_OUT :  STD_LOGIC_VECTOR(15 downto 0);
signal	NACS_EXT :  STD_LOGIC;
signal	nWE_RAM :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(9 downto 0);
signal	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(11 downto 0);
signal	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
signal	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(11 downto 0);


BEGIN 



inst : ram
  GENERIC MAP(
		DADDR_LEN	=>	10,
		DATA_LEN	=>	16,
	      FILENAME	=>	"..\rom.vin"
	)    
  PORT MAP(	
		ram_data_out	=> MEM_DATA_OUT,
		ram_data_in 	=> CPU_DATA_OUT,
		ram_addr_in		=> SYNTHESIZED_WIRE_0,
		nwe			=> nWE_RAM,
		nreset		=> nreset_in,
		clk			=> clk_in
	);

inst1 : cpu
PORT MAP(
		int_in => cpu_int,
		 dwait_in => DWAIT_IN,
		 iwait_in => SYNTHESIZED_WIRE_1,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 data_in => CPU_DATA_IN_M,
		 idata_in => MEM_DATA_OUT,
		 saddr_in => SYNTHESIZED_WIRE_2,
		 ipush_out => SYNTHESIZED_WIRE_3,
		 ipop_out => SYNTHESIZED_WIRE_4,
		 ndre_out => CPU_nDRE,
		 nadwe_out => CPU_nADWE,
		 adaddr_out => CPU_ADADDR_OUT,
		 data_out => CPU_DATA_OUT,
		 iaddr_out => CPU_IADDR_OUT,
		 saddr_out => SYNTHESIZED_WIRE_5
);

inst2 : stack_t
   GENERIC MAP(
		DATA_LEN		=>	12,
		DEEP_LEN		=>	8
	)    
   PORT MAP(	
		saddr_in		=> SYNTHESIZED_WIRE_2,
		saddr_out		=> SYNTHESIZED_WIRE_5,
		ipush_out		=> SYNTHESIZED_WIRE_3,
		ipop_out		=> SYNTHESIZED_WIRE_4,
		nreset_in		=> nreset_in,
		clk_in		=> clk_in
	);

inst3 : h2v
GENERIC MAP(10)
PORT MAP(ndre_in => CPU_nDRE,
		 nadwe_in => CPU_nADWE,
		 dwait_in => DWAIT_IN,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 daddr => CPU_ADADDR_OUT(9 downto 0),
		 iaddr => CPU_IADDR_OUT(9 downto 0),
		 iwait_out => SYNTHESIZED_WIRE_1,
		 maddr => SYNTHESIZED_WIRE_0);

inst4 : ctrl16cpu
GENERIC MAP(10,16)
PORT MAP(nADWE_CPU => CPU_nADWE,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 ADADDR_IN => CPU_ADADDR_OUT(9 downto 0),
		 DATA_IN_EXT => DATA_IN_EXT,
		 DATA_IN_RAM => MEM_DATA_OUT,
		 nWE_RAM => nWE_RAM,
		 nCS_EXT => NCS_EXT,
		 nACS_EXT => NACS_EXT,
		 DATA_OUT => CPU_DATA_IN);
DATA_OUT_EXT <= CPU_DATA_OUT;


inst5 : waitstategen
GENERIC MAP(10,16,"00000111")
PORT MAP(nacs_wait => NACS_EXT,
		 ndre_in => CPU_nDRE,
		 nadwe_in => CPU_nADWE,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 cpu_adaddr_out_m => CPU_ADADDR_OUT(9 downto 0),
		 cpu_data_in => CPU_DATA_IN,
		 dwait_out => DWAIT_IN,
		 ndre_out => NRE_EXT,
		 ndwe_out => NWE_EXT,
		 cpu_daddr_out => ADDR_OUT_EXT,
		 cpu_data_in_m => CPU_DATA_IN_M);

END; 