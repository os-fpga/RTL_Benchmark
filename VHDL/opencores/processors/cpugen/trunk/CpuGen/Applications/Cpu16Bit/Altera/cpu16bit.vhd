-- Copyright (C) 1991-2003 Altera Corporation
-- Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
-- support information,  device programming or simulation file,  and any other
-- associated  documentation or information  provided by  Altera  or a partner
-- under  Altera's   Megafunction   Partnership   Program  may  be  used  only
-- to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
-- other  use  of such  megafunction  design,  netlist,  support  information,
-- device programming or simulation file,  or any other  related documentation
-- or information  is prohibited  for  any  other purpose,  including, but not
-- limited to  modification,  reverse engineering,  de-compiling, or use  with
-- any other  silicon devices,  unless such use is  explicitly  licensed under
-- a separate agreement with  Altera  or a megafunction partner.  Title to the
-- intellectual property,  including patents,  copyrights,  trademarks,  trade
-- secrets,  or maskworks,  embodied in any such megafunction design, netlist,
-- support  information,  device programming or simulation file,  or any other
-- related documentation or information provided by  Altera  or a megafunction
-- partner, remains with Altera, the megafunction partner, or their respective
-- licensors. No other licenses, including any licenses needed under any third
-- party's intellectual property, are provided herein.

-- PROGRAM "Quartus II"
-- VERSION "Version 3.0 Build 223 08/14/2003 Service Pack 1 SJ Web Edition"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY cpu16bit IS 
	port
	(
		clk_in :  IN  STD_LOGIC;
		nreset_in :  IN  STD_LOGIC;
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

component lpm_ram_dq
	PORT(wren : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(9 downto 0);
		 data : IN STD_LOGIC_VECTOR(15 downto 0);
		 q : OUT STD_LOGIC_VECTOR(15 downto 0)
	);
end component;

component cpu
	PORT(int_in : IN STD_LOGIC;
		 dwait_in : IN STD_LOGIC;
		 iwait_in : IN STD_LOGIC;
		 nreset_in : IN STD_LOGIC;
		 clk_in : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(15 downto 0);
		 idata_in : IN STD_LOGIC_VECTOR(15 downto 0);
		 saddr_in : IN STD_LOGIC_VECTOR(11 downto 0);
		 ipush_out : OUT STD_LOGIC;
		 ipop_out : OUT STD_LOGIC;
		 ndre_out : OUT STD_LOGIC;
		 ndwe_out : OUT STD_LOGIC;
		 nadwe_out : OUT STD_LOGIC;
		 adaddr_out : OUT STD_LOGIC_VECTOR(11 downto 0);
		 daddr_out : OUT STD_LOGIC_VECTOR(11 downto 0);
		 data_out : OUT STD_LOGIC_VECTOR(15 downto 0);
		 iaddr_out : OUT STD_LOGIC_VECTOR(11 downto 0);
		 saddr_out : OUT STD_LOGIC_VECTOR(11 downto 0)
	);
end component;

component stack
	PORT(ipush_out : IN STD_LOGIC;
		 ipop_out : IN STD_LOGIC;
		 nreset_in : IN STD_LOGIC;
		 clk_in : IN STD_LOGIC;
		 saddr_out : IN STD_LOGIC_VECTOR(11 downto 0);
		 saddr_in : OUT STD_LOGIC_VECTOR(11 downto 0)
	);
end component;

component h2v
	PORT(ndre_in : IN STD_LOGIC;
		 nadwe_in : IN STD_LOGIC;
		 dwait_in : IN STD_LOGIC;
		 nreset_in : IN STD_LOGIC;
		 clk_in : IN STD_LOGIC;
		 daddr : IN STD_LOGIC_VECTOR(9 downto 0);
		 iaddr : IN STD_LOGIC_VECTOR(9 downto 0);
		 iwait_out : OUT STD_LOGIC;
		 maddr : OUT STD_LOGIC_VECTOR(9 downto 0)
	);
end component;

component ctrl16cpu
	PORT(nAWE_CPU : IN STD_LOGIC;
		 nreset_in : IN STD_LOGIC;
		 clk_in : IN STD_LOGIC;
		 ADADDR_IN : IN STD_LOGIC_VECTOR(9 downto 0);
		 DATA_IN_EXT : IN STD_LOGIC_VECTOR(15 downto 0);
		 DATA_IN_RAM : IN STD_LOGIC_VECTOR(15 downto 0);
		 nWE_RAM : OUT STD_LOGIC;
		 nCS_EXT : OUT STD_LOGIC;
		 nACS_EXT : OUT STD_LOGIC;
		 DATA_OUT : OUT STD_LOGIC_VECTOR(15 downto 0)
	);
end component;

component waitstategen
	PORT(nacs_wait : IN STD_LOGIC;
		 ndre_in : IN STD_LOGIC;
		 nadwe_in : IN STD_LOGIC;
		 nreset_in : IN STD_LOGIC;
		 clk_in : IN STD_LOGIC;
		 cpu_adaddr_out_m : IN STD_LOGIC_VECTOR(9 downto 0);
		 cpu_data_in : IN STD_LOGIC_VECTOR(15 downto 0);
		 dwait_out : OUT STD_LOGIC;
		 ndre_out : OUT STD_LOGIC;
		 ndwe_out : OUT STD_LOGIC;
		 cpu_daddr_out : OUT STD_LOGIC_VECTOR(9 downto 0);
		 cpu_data_in_m : OUT STD_LOGIC_VECTOR(15 downto 0)
	);
end component;

signal	CPU_ADADDR_OUT_M :  STD_LOGIC_VECTOR(11 downto 0);
signal	CPU_DATA_IN :  STD_LOGIC_VECTOR(15 downto 0);
signal	CPU_DATA_IN_M :  STD_LOGIC_VECTOR(15 downto 0);
signal	CPU_DATA_OUT :  STD_LOGIC_VECTOR(15 downto 0);
signal	CPU_IADDR_OUT :  STD_LOGIC_VECTOR(11 downto 0);
signal	CPU_nADWE_M :  STD_LOGIC;
signal	CPU_nDRE_M :  STD_LOGIC;
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



b2v_inst : lpm_ram_dq
PORT MAP(wren => nWE_RAM,
		 clock => clk_in,
		 address => SYNTHESIZED_WIRE_0,
		 data => CPU_DATA_OUT,
		 q => MEM_DATA_OUT);

b2v_inst1 : cpu
PORT MAP(int_in => cpu_int,
		 dwait_in => DWAIT_IN,
		 iwait_in => SYNTHESIZED_WIRE_1,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 data_in => CPU_DATA_IN_M,
		 idata_in => MEM_DATA_OUT,
		 saddr_in => SYNTHESIZED_WIRE_2,
		 ipush_out => SYNTHESIZED_WIRE_3,
		 ipop_out => SYNTHESIZED_WIRE_4,
		 ndre_out => CPU_nDRE_M,
		 nadwe_out => CPU_nADWE_M,
		 adaddr_out => CPU_ADADDR_OUT_M,
		 data_out => CPU_DATA_OUT,
		 iaddr_out => CPU_IADDR_OUT,
		 saddr_out => SYNTHESIZED_WIRE_5);

b2v_inst11 : stack
PORT MAP(ipush_out => SYNTHESIZED_WIRE_3,
		 ipop_out => SYNTHESIZED_WIRE_4,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 saddr_out => SYNTHESIZED_WIRE_5,
		 saddr_in => SYNTHESIZED_WIRE_2);

b2v_inst2 : h2v
GENERIC MAP(10)
PORT MAP(ndre_in => CPU_nDRE_M,
		 nadwe_in => CPU_nADWE_M,
		 dwait_in => DWAIT_IN,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 daddr => CPU_ADADDR_OUT_M(9 downto 0),
		 iaddr => CPU_IADDR_OUT(9 downto 0),
		 iwait_out => SYNTHESIZED_WIRE_1,
		 maddr => SYNTHESIZED_WIRE_0);

b2v_inst3 : ctrl16cpu
GENERIC MAP(10,16)
PORT MAP(nAWE_CPU => CPU_nADWE_M,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 ADADDR_IN => CPU_ADADDR_OUT_M(9 downto 0),
		 DATA_IN_EXT => DATA_IN_EXT,
		 DATA_IN_RAM => MEM_DATA_OUT,
		 nWE_RAM => nWE_RAM,
		 nCS_EXT => NCS_EXT,
		 nACS_EXT => NACS_EXT,
		 DATA_OUT => CPU_DATA_IN);
DATA_OUT_EXT <= CPU_DATA_OUT;


b2v_inst4 : waitstategen
GENERIC MAP(10,16,"00000111")
PORT MAP(nacs_wait => NACS_EXT,
		 ndre_in => CPU_nDRE_M,
		 nadwe_in => CPU_nADWE_M,
		 nreset_in => nreset_in,
		 clk_in => clk_in,
		 cpu_adaddr_out_m => CPU_ADADDR_OUT_M(9 downto 0),
		 cpu_data_in => CPU_DATA_IN,
		 dwait_out => DWAIT_IN,
		 ndre_out => NRE_EXT,
		 ndwe_out => NWE_EXT,
		 cpu_daddr_out => ADDR_OUT_EXT,
		 cpu_data_in_m => CPU_DATA_IN_M);

END; 