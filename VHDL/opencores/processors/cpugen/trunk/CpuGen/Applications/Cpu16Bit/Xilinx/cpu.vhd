-- 	CPU
--	rel. 2.0
-- 	by gferrante@opencores.org
--


library ieee;
use ieee.std_logic_1164.all;
use work.CPU_UTILS.all;


entity CPU is

	port(
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
end;

architecture CPU_ARCH of CPU is

   SIGNAL pc_mux		: Cpu_imux;
   SIGNAL data_is		: Cpu_mbus;

   SIGNAL ndre_out_int	: std_logic;
   SIGNAL nadwe_out_int	: std_logic;
   SIGNAL adaddr_out_int: Cpu_daddr;

   SIGNAL data_out_int	: Cpu_dobus;
   SIGNAL data_in_int	: Cpu_dibus;
   SIGNAL data_is_int	: Cpu_dbus;
   SIGNAL daddr_is		: Cpu_bus;
   SIGNAL ext_addr		: Cpu_bus;
   SIGNAL class_cu		: Cpu_cclass;
   SIGNAL class_du		: Cpu_dclass;
   SIGNAL int_start		: std_logic;
   SIGNAL int_stop		: std_logic;
   SIGNAL dwait_valid	: std_logic;
   SIGNAL ndre_int		: std_logic;
   SIGNAL ndwe_int		: std_logic;
   SIGNAL valid			: std_logic;
   SIGNAL skip			: std_logic;

   -- Component Declarations

   -- ISTRUCTION UNIT

   COMPONENT CPU_IU
   	PORT (
		iaddr_out:		out Cpu_iaddr;
	 	saddr_out:		out Cpu_iaddr;
	 	ipush_out:		out	std_logic;
	 	ipop_out:		out	std_logic;
		pc_mux:			in 	Cpu_imux;
		ext_addr: 		in	Cpu_bus;
	    saddr_in:		in 	Cpu_iaddr;
		nreset_in:		in	std_logic;
		clk_in:			in	std_logic
   	);
   END COMPONENT;

   -- CONTROL UNIT

   COMPONENT CPU_CU
   	PORT (
		class_cu: 	out	Cpu_cclass;
		class_du: 	out	Cpu_dclass;
		valid:		out std_logic;
		int_start:	out std_logic;
		int_stop:	out std_logic;
		ndre_int:	out std_logic;
		ndwe_int:	out std_logic;
		daddr_is: 	out	Cpu_bus;
		data_is: 	out	Cpu_mbus;
		pc_mux:		out Cpu_imux;
		ext_addr: 	out	Cpu_bus;
		skip:		in 	std_logic;
		int_in:		in 	std_logic;
		dwait_in:	in 	std_logic;
		iwait_in:	in 	std_logic;
		idata_in: 	in	Cpu_ibus;
		nreset_in:	in	std_logic;
		clk_in:		in	std_logic
   	);
   END COMPONENT;

   -- DATA UNIT

   COMPONENT CPU_DU
   	PORT (
		skip:			out std_logic;
		data_out_int: 	out Cpu_dobus;
		data_in_int: 	in 	Cpu_dibus;
		data_is_int: 	in 	Cpu_dbus;
		class_cu: 		in	Cpu_cclass;
		class_du: 		in	Cpu_dclass;
		valid:			in	std_logic;
   		int_start: 		in	std_logic;
		nreset_in:		in	std_logic;
		clk_in:			in	std_logic
   	);
   END COMPONENT;

   -- WRITE DELAY

   COMPONENT CPU_WD	
	PORT(	
		daddr_out:		out	Cpu_daddr;
		ndwe_out:		out std_logic;
		adaddr_out_int:	in	Cpu_daddr;
		ndre_out_int:	in	std_logic;
		nadwe_out_int:	in	std_logic;
		nreset_in:		in	std_logic;
		clk_in:			in	std_logic
	);
   END COMPONENT;

   -- OVER ADDRESSING UNIT

   COMPONENT CPU_OA
   	PORT (
		data_in_int:	out Cpu_dibus;
		data_is_int:	out Cpu_dbus;
		data_out:		out Cpu_dobus;
		adaddr_out_int: out	Cpu_daddr;
		ndre_out_int:	out std_logic;
		nadwe_out_int:	out	std_logic;
		data_out_int:	in 	Cpu_dobus;
		int_start:		in 	std_logic;
		int_stop:		in 	std_logic;
		ndre_int:		in 	std_logic;
		ndwe_int:		in	std_logic;
		daddr_is: 		in	Cpu_bus;
		data_is: 		in	Cpu_mbus;
		data_in:		in 	Cpu_dibus;
		nreset_in:		in	std_logic;
		clk_in:			in	std_logic
   	);
   END COMPONENT;

   FOR ALL : CPU_IU USE ENTITY WORK.CPU_IU;
   FOR ALL : CPU_CU USE ENTITY WORK.CPU_CU;
   FOR ALL : CPU_DU USE ENTITY WORK.CPU_DU;
   FOR ALL : CPU_OA USE ENTITY WORK.CPU_OA;
   FOR ALL : CPU_WD USE ENTITY WORK.CPU_WD;

begin

   -- Instance port mappings.

   I1 : CPU_IU
      PORT MAP (
		iaddr_out	=> iaddr_out,
		saddr_out	=> saddr_out,
		ipush_out	=> ipush_out,
		ipop_out	=> ipop_out,
		saddr_in	=> saddr_in,
		pc_mux		=> pc_mux,
		ext_addr	=> ext_addr,
		nreset_in	=> nreset_in,
		clk_in		=> clk_in
       );

   I2 : CPU_CU
      PORT MAP (
		daddr_is	=> daddr_is,
		data_is		=> data_is,
		class_cu	=> class_cu,
		class_du	=> class_du,
		pc_mux		=> pc_mux,
		ext_addr	=> ext_addr,
		idata_in	=> idata_in,
		valid		=> valid,
		ndre_int	=> ndre_int,
		ndwe_int	=> ndwe_int,
		int_start	=> int_start,
		int_stop	=> int_stop,
		int_in		=> int_in,
   		skip		=> skip,
		dwait_in	=> dwait_in,
		iwait_in	=> iwait_in,
		nreset_in	=> nreset_in,
		clk_in		=> clk_in
       );

   I3 : CPU_DU
      PORT MAP (
		data_out_int	=> data_out_int,
		data_in_int		=> data_in_int,
		data_is_int		=> data_is_int,
		class_cu		=> class_cu,
		class_du		=> class_du,
		valid			=> valid,
		int_start		=> int_start,
		skip			=> skip,
		nreset_in		=> nreset_in,
		clk_in			=> clk_in
       );

   I4 : CPU_OA
      PORT MAP (
		adaddr_out_int	=> adaddr_out_int,
		data_out		=> data_out,
		data_in_int		=> data_in_int,
		data_is_int		=> data_is_int,
		data_in			=> data_in,
		data_out_int	=> data_out_int,
		daddr_is		=> daddr_is,
		data_is			=> data_is,
		ndre_out_int	=> ndre_out_int,
		nadwe_out_int	=> nadwe_out_int,
		int_stop		=> int_stop,
		int_start		=> int_start,
		ndre_int		=> ndre_int,
		ndwe_int		=> ndwe_int,
		nreset_in		=> nreset_in,
		clk_in			=> clk_in
       );

   I5 : CPU_WD
      PORT MAP (
		daddr_out		=> daddr_out,
		ndwe_out		=> ndwe_out,
		adaddr_out_int	=> adaddr_out_int,
		ndre_out_int	=> ndre_out_int,
		nadwe_out_int	=> nadwe_out_int,
		nreset_in		=> nreset_in,
		clk_in			=> clk_in
	);

	ndre_out	<=	ndre_out_int;
	nadwe_out	<= 	nadwe_out_int;
	adaddr_out	<= 	adaddr_out_int;

end CPU_ARCH;
