-- 	CPU_OA
--	rel. 2.0
-- 	by 	gferrante@opencores.org
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.CPU_UTILS.all;

entity CPU_OA is

	port(
		data_in_int:	out Cpu_dibus;
		data_is_int:	out Cpu_dbus;
		data_out:		out Cpu_dobus;
		adaddr_out_int: out	Cpu_daddr;
		ndre_out_int:	out std_logic;
		nadwe_out_int:	out	std_logic;
		ipage:			out Cpu_ipage;
		data_out_int:	in 	Cpu_dobus;
		ndre_int:		in 	std_logic;
		ndwe_int:		in	std_logic;
		daddr_is: 		in	Cpu_bus;
		data_is: 		in	Cpu_mbus;
		data_in:		in 	Cpu_dibus;
		nreset_in:		in	std_logic;
		clk_in:			in	std_logic
	);
end;

architecture OA_STRUCT of CPU_OA is

	CONSTANT 	oall_zero	: Cpu_ba	:= (others => '0');
	SIGNAL 	oa_hreg_x	: Cpu_ba;
	SIGNAL 	oa_lreg_x	: Cpu_ia;
	SIGNAL 	daddr_x		: Cpu_bus;
	SIGNAL 	data_ox		: Cpu_dobus;
	SIGNAL 	data_ix		: Cpu_dibus;
	SIGNAL	iadata_x	: Cpu_mbus;
	SIGNAL 	ipage_x		: Cpu_ipage;
	SIGNAL 	ipage_c		: Cpu_ipage;
	SIGNAL 	ndwe_x		: std_logic;
	SIGNAL 	ndre_x		: std_logic;
	SIGNAL 	int_re_x	: std_logic;
	SIGNAL 	int_re_c	: std_logic;
	SIGNAL 	ipage_we_x	: std_logic;
	SIGNAL 	ipage_we_c	: std_logic;
	SIGNAL 	nreset_v	: Cpu_nreset;

begin

	OA_REGISTERS: process (clk_in,nreset_in)

	begin

		if (nreset_in = nreset_value) then

			ipage_c		<=	(others => '0');
			int_re_c	<=	'0';
	 		ipage_we_c	<=	'0';

			nreset_v	<=	RESET_ALL;

		elsif (rising_edge(clk_in)) then

			ipage_c	<=	ipage_x;
	 		ipage_we_c	<=	ipage_we_x;
			int_re_c	<=	int_re_x;
			if (nreset_v	< UNRESET_ALL) then
				nreset_v	<=	unsigned(nreset_v) + 1;
			else
				nreset_v	<=	UNRESET_ALL;
			end if;

		end if;

	end process;


	OA_MANAGER: process (nreset_in, nreset_v, daddr_is, ndre_int, ndre_x, ndwe_int, data_out_int, data_in, 
			ipage_c,
			oa_hreg_x,
		 	ipage_we_c,
			oa_lreg_x)

	begin

		oa_lreg_x	<=	daddr_is((OA_LEN - 1) downto 0);

		oa_hreg_x	<=	daddr_is((BUS_LEN - 1) downto OA_LEN);

		ndre_x		<=	ndre_int;
		ndwe_x		<=	ndwe_int;
		daddr_x		<=	daddr_is;
		ipage_x		<=	ipage_c;
		data_ox		<=	data_out_int;
		data_ix		<=	data_in;
	 	ipage_we_x	<=	'0';

		if ((nreset_in /= nreset_value) and (nreset_v > UNRESET_IU)) then

			if ((oa_hreg_x = oall_zero) and ((ndre_int = '0') or (ndwe_int = '0')))  then

				if (oa_lreg_x = IND_ADD) then
					ndre_x		<=	ndre_int;
					ndwe_x		<=	ndwe_int;
					daddr_x		<=	daddr_is;
				elsif (oa_lreg_x = ISTR_PAGE) then
					ndre_x		<=	'1';
					ndwe_x		<=	'1';
					if (ndre_int = '0') then
						data_ix((IPAGE_LEN - 1) downto 0)		<=	ipage_c;
						data_ix((DATA_LEN - 1) downto IPAGE_LEN )	<=	(others => '0');
					elsif (ndwe_int = '0') then
						ipage_we_x	<=	'1';
					end if;
				end if;
			end if;
		else
			daddr_x		<=	(others => '0');
			data_ix		<=	(others => '0');
			data_ox		<=	(others => '0');
			ipage_x		<=	(others => '0');
			ndre_x		<=	'1';
			ndwe_x		<=	'1';

		end if;

		if ((ndre_int = '0') and (ndre_x = '1')) then
			int_re_x	<=	'1';
		else
			int_re_x	<=	'0';
		end if;

		if (ipage_we_c = '1') then
			ipage_x	<=	data_out_int((IPAGE_LEN - 1) downto 0);
		end if;

	end process;

	ipage			<=	ipage_c;
	 adaddr_out_int	<=	daddr_x;
	data_out		<=	data_ox;
	data_in_int		<=	data_ix;
	iadata_x		<=	data_is;
	data_is_int		<=	iadata_x((DATA_LEN - 1) downto 0);

	ndre_out_int		<=	ndre_x;
	nadwe_out_int		<=	ndwe_x;

end OA_STRUCT;

