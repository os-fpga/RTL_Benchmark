-- 	CPUT_IU
--	rel. 2.0
-- 	by gferrante@opencores.org
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.CPUT_UTILS.all;

entity CPUT_IU is

	port(
		iaddr_out:	out Cpu_iaddr;
		pc_mux:		in 	Cpu_imux;
		ext_addr: 	in	Cpu_bus;
		nreset_in:	in	std_logic;
		clk_in:		in	std_logic
	);
end;

architecture IUT_STRUCT of CPUT_IU is

	SIGNAL 	pc				: Cpu_iaddr;
	SIGNAL 	iaddr_x			: Cpu_iaddr;
	SIGNAL 	eaddr_x			: Cpu_iaddr;
	SIGNAL 	stack_addrs		: stack_area;
	SIGNAL 	stack_addrs_c   : stack_area;
	SIGNAL 	nreset_v		: Cpu_nreset;

begin

	IU_REGISTERS: process (clk_in,nreset_in)

	begin

		if (nreset_in = nreset_value) then

			pc			<=	(others => '0');
			nreset_v	<=	RESET_ALL;

		elsif (rising_edge(clk_in)) then

			pc				<=	iaddr_x;
			stack_addrs_c 	<=	stack_addrs;
			if (nreset_v	< UNRESET_ALL) then
				nreset_v	<=	unsigned(nreset_v) + 1;
			else
				nreset_v	<=	UNRESET_ALL;
			end if;

		end if;

	end process;

	IU_FETCH: process (pc_mux, pc, ext_addr,
		eaddr_x,
		stack_addrs_c, 
		nreset_in, nreset_v)

	begin

		if ((nreset_in /= nreset_value) and (nreset_v > UNRESET_IU)) then

			case pc_mux is
				when NEXT_I	=>
					iaddr_x		<= 	(unsigned(pc) + 1);
					stack_addrs	<= 	stack_addrs_c;
				when SAME_I	=>
					iaddr_x		<= 	pc;
					stack_addrs	<= 	stack_addrs_c;
				when EXT_I	=>
				    iaddr_x		<= 	ext_addr;
					stack_addrs	<= 	stack_addrs_c;
				when EXTS_I	=>
					stack_addrs((STACK_SIZE - 1) downto 0)	<= stack_addrs_c((STACK_SIZE - 2) downto 0) & (unsigned(pc) + 1);
					iaddr_x		<= 	ext_addr;
				when INTSN_I	=>
					stack_addrs((STACK_SIZE - 1) downto 0)	<= stack_addrs_c((STACK_SIZE - 2) downto 0) & (unsigned(pc) + 1);
					iaddr_x		<= 	INT_ADDR;
				when INTSS_I	=>
					stack_addrs((STACK_SIZE - 1) downto 0)	<= stack_addrs_c((STACK_SIZE - 2) downto 0) & pc;
					iaddr_x		<= 	INT_ADDR;
				when INTSE_I	=>
					eaddr_x		<= 	ext_addr;
					stack_addrs((STACK_SIZE - 1) downto 0)	<= stack_addrs_c((STACK_SIZE - 2) downto 0) & eaddr_x;
					iaddr_x		<= 	INT_ADDR;
				when STACK_I	=>
					iaddr_x		<= stack_addrs_c(0);
					stack_addrs((STACK_SIZE - 2) downto 0)	<= stack_addrs_c((STACK_SIZE - 1) downto 1);
					stack_addrs(STACK_SIZE - 1)	<= (others => '0');
				when others		=>
					iaddr_x		<= 	(others => '0');
					stack_addrs		<= 	stack_addrs_c;
			end case;
		else
			iaddr_x 	<= 	(others => '0');
			stack_addrs	<= 	stack_addrs_c;
		end if;

	end process;

	iaddr_out		<=	iaddr_x;

end IUT_STRUCT;

