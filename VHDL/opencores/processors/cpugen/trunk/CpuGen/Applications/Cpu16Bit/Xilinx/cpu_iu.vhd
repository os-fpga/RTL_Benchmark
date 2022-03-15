-- 	CPU_IU
--	rel. 2.0
-- 	by gferrante@opencores.org
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.CPU_UTILS.all;

entity CPU_IU is

	port(
		iaddr_out:	out Cpu_iaddr;
 		saddr_out:	out Cpu_iaddr;
 		ipush_out:	out	std_logic;
 		ipop_out:	out	std_logic;
		pc_mux:		in 	Cpu_imux;
		ext_addr: 	in	Cpu_bus;
 		saddr_in:	in 	Cpu_iaddr;
		nreset_in:	in	std_logic;
		clk_in:		in	std_logic
	);
end;

architecture IU_STRUCT of CPU_IU is

	SIGNAL 	pc				: Cpu_iaddr;
	SIGNAL 	iaddr_x			: Cpu_iaddr;
	SIGNAL 	eaddr_x			: Cpu_iaddr;
	SIGNAL 	nreset_v		: Cpu_nreset;

begin

	IU_REGISTERS: process (clk_in,nreset_in)

	begin

		if (nreset_in = nreset_value) then

			pc			<=	(others => '0');
			nreset_v	<=	RESET_ALL;

		elsif (rising_edge(clk_in)) then

			pc				<=	iaddr_x;
			if (nreset_v	< UNRESET_ALL) then
				nreset_v	<=	unsigned(nreset_v) + 1;
			else
				nreset_v	<=	UNRESET_ALL;
			end if;

		end if;

	end process;

	IU_FETCH: process (pc_mux, pc, ext_addr,
		eaddr_x,
		saddr_in,
		nreset_in, nreset_v)

	begin

		if ((nreset_in /= nreset_value) and (nreset_v > UNRESET_IU)) then

			case pc_mux is
				when NEXT_I	=>
					iaddr_x			<= 	(unsigned(pc) + 1);
					 ipush_out	<=	'0';
					 ipop_out		<=	'0';
					 saddr_out	<=	saddr_in;
				when SAME_I	=>
					iaddr_x			<= 	pc;
					 ipush_out	<=	'0';
					 ipop_out		<=	'0';
					 saddr_out	<=	saddr_in;
				when EXT_I	=>
					 iaddr_x		<= 	ext_addr;
					 ipush_out	<=	'0';
					 ipop_out		<=	'0';
					 saddr_out	<=	saddr_in;
				when EXTS_I	=>
					 ipush_out	<=	'1';
					 ipop_out		<=	'0';
					 saddr_out	<=	(unsigned(pc) + 1);
					 iaddr_x		<= 	ext_addr;
				when INTSN_I	=>
					 ipush_out	<=	'1';
					 ipop_out		<=	'0';
					 saddr_out	<=	(unsigned(pc) + 1);
					iaddr_x			<= 	INT_ADDR;
				when INTSS_I	=>
					 ipush_out	<=	'1';
					 ipop_out		<=	'0';
					 saddr_out	<=	pc;
					iaddr_x			<= 	INT_ADDR;
				when INTSE_I	=>
					 eaddr_x		<= 	ext_addr;
					 ipush_out	<=	'1';
					 ipop_out		<=	'0';
					 saddr_out	<=	eaddr_x;
					iaddr_x			<= 	INT_ADDR;
				when STACK_I	=>
					 ipush_out	<=	'0';
					 ipop_out		<=	'1';
					 saddr_out	<=	saddr_in;
					 iaddr_x		<= 	saddr_in;
				when others		=>
					 ipush_out	<=	'0';
					 ipop_out		<=	'0';
					 saddr_out	<=	saddr_in;
					iaddr_x			<= 	(others => '0');
			end case;
		else
			 ipush_out	<=	'0';
			 ipop_out		<=	'0';
			 saddr_out	<=	saddr_in;
			iaddr_x 		<= 	(others => '0');
		end if;

	end process;

	iaddr_out		<=	iaddr_x;

end IU_STRUCT;
