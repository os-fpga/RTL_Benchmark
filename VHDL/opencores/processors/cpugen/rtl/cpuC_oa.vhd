-- 	CPUC_OA
--	rel. 2.0
-- 	by 	gferrante@opencores.org
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.CPUC_UTILS.all;

entity CPUC_OA is

	port(
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
end;

architecture OAC_STRUCT of CPUC_OA is

	CONSTANT 	oall_zero	: Cpu_ba	:= (others => '0');
	SIGNAL 	oa_hreg_x	: Cpu_ba;
	SIGNAL 	oa_lreg_x	: Cpu_ia;
	SIGNAL 	daddr_x		: Cpu_bus;
	SIGNAL 	data_ox		: Cpu_dobus;
	SIGNAL 	data_ix		: Cpu_dibus;
	SIGNAL 	data_exp_x	: Cpu_mbus;
	SIGNAL 	data_exp_c	: Cpu_mbus;
	SIGNAL 	data_exp_i	: Cpu_mbus;
	SIGNAL	iadata_x	: Cpu_ma;
	SIGNAL 	ireg_x		: Cpu_mbus;
	SIGNAL 	ireg_c		: Cpu_mbus;
	SIGNAL 	iinc_x		: Cpu_mbus;
	SIGNAL 	iinc_c		: Cpu_mbus;
	SIGNAL 	ireg_i		: Cpu_mbus;
	SIGNAL 	iinc_i		: Cpu_mbus;
	SIGNAL 	ndwe_x		: std_logic;
	SIGNAL 	ndre_x		: std_logic;
	SIGNAL 	int_re_x	: std_logic;
	SIGNAL 	int_re_c	: std_logic;
	SIGNAL 	ireg_we_x	: std_logic;
	SIGNAL 	ireg_we_c	: std_logic;
	SIGNAL 	iinc_we_x	: std_logic;
	SIGNAL 	iinc_we_c	: std_logic;
	SIGNAL 	dexp_we_x	: std_logic;
	SIGNAL 	dexp_we_c	: std_logic;
	SIGNAL 	nreset_v	: Cpu_nreset;

begin

	OA_REGISTERS: process (clk_in,nreset_in)

	begin

		if (nreset_in = nreset_value) then

			ireg_c		<=	(others => '0');
			iinc_c		<=	(others => '0');
			data_exp_c	<=	(others => '0');
			int_re_c	<=	'0';
		 	ireg_we_c	<=	'0';
	 		iinc_we_c	<=	'0';
	 		dexp_we_c	<=	'0';

			nreset_v	<=	RESET_ALL;

		elsif (rising_edge(clk_in)) then

			if (int_start = '1') then
				ireg_i	<=	ireg_x;
				iinc_i	<=	iinc_x;
			end if;
			if (int_stop = '1') then
				ireg_c	<=	ireg_i;
				iinc_c	<=	iinc_i;
			else
				ireg_c	<=	ireg_x;
				iinc_c	<=	iinc_x;
			end if;
			if (int_start = '1') then
				data_exp_i	<=	data_exp_x;
			end if;
			if (int_stop = '1') then
				data_exp_c	<=	data_exp_i;
			else
				data_exp_c	<=	data_exp_x;
			end if;
		 	ireg_we_c	<=	ireg_we_x;
	 		iinc_we_c	<=	iinc_we_x;
	 		dexp_we_c	<=	dexp_we_x;
			int_re_c	<=	int_re_x;
			if (nreset_v	< UNRESET_ALL) then
				nreset_v	<=	unsigned(nreset_v) + 1;
			else
				nreset_v	<=	UNRESET_ALL;
			end if;

		end if;

	end process;


	OA_MANAGER: process (nreset_in, nreset_v, daddr_is, ndre_int, ndre_x, ndwe_int, data_out_int, data_in, 
		  	iinc_c, ireg_c,
			data_exp_c,
			oa_hreg_x,
		 	ireg_we_c,
		 	iinc_we_c,
		 	dexp_we_c,
			oa_lreg_x)

	begin

		oa_lreg_x	<=	daddr_is((OA_LEN - 1) downto 0);

		oa_hreg_x	<=	daddr_is((BUS_LEN - 1) downto OA_LEN);

		ndre_x		<=	ndre_int;
		ndwe_x		<=	ndwe_int;
		daddr_x		<=	daddr_is;
		ireg_x		<=	ireg_c;
		iinc_x		<=	iinc_c;
		data_exp_x	<=	data_exp_c;
		data_ox		<=	data_out_int;
		data_ix		<=	data_in;
		ireg_we_x	<=	'0';
	 	iinc_we_x	<=	'0';
	 	dexp_we_x	<=	'0';

		if ((nreset_in /= nreset_value) and (nreset_v > UNRESET_IU)) then

			if ((oa_hreg_x = oall_zero) and ((ndre_int = '0') or (ndwe_int = '0')))  then

				if (oa_lreg_x = IND_ADD) then
					 daddr_x	<= 	ireg_c;
					ireg_x		<=	unsigned(ireg_c) + unsigned(iinc_c);
				elsif (oa_lreg_x = IND_REG) then
					ndre_x		<=	'1';
					ndwe_x		<=	'1';
					if (ndre_int = '0') then
						data_ix((MBUS_LEN - 1) downto 0)	<=	ireg_c;
						data_ix((DATA_LEN - 1) downto MBUS_LEN)	<=	(others => '0');
					elsif (ndwe_int = '0') then
						ireg_we_x	<=	'1';
					end if;
				elsif (oa_lreg_x = IND_INC) then
					ndre_x		<=	'1';
					ndwe_x		<=	'1';
					if (ndre_int = '0') then
						data_ix((MBUS_LEN - 1) downto 0)	<=	iinc_c;
						data_ix((DATA_LEN - 1) downto MBUS_LEN)	<=	(others => '0');
					elsif (ndwe_int = '0') then
						iinc_we_x	<=	'1';
					end if;
				elsif (oa_lreg_x = DATA_EXP) then
					ndre_x		<=	'1';
					ndwe_x		<=	'1';
					if (ndre_int = '0') then
						data_ix((MBUS_LEN - 1) downto 0)	<=	data_exp_c;
						data_ix((DATA_LEN - 1) downto MBUS_LEN)	<=	(others => '0');
					elsif (ndwe_int = '0') then
						dexp_we_x	<=	'1';
					end if;
				end if;
			end if;
		else
			daddr_x		<=	(others => '0');
			data_ix		<=	(others => '0');
			data_ox		<=	(others => '0');
			ireg_x		<=	(others => '0');
			iinc_x		<=	(others => '0');
			data_exp_x	<=	(others => '0');
			ndre_x		<=	'1';
			ndwe_x		<=	'1';

		end if;

		if ((ndre_int = '0') and (ndre_x = '1')) then
			int_re_x	<=	'1';
		else
			int_re_x	<=	'0';
		end if;

		if (ireg_we_c = '1') then
			ireg_x	<=	data_out_int((MBUS_LEN - 1) downto 0);
		end if;
		if (iinc_we_c = '1') then
			iinc_x	<=	data_out_int((MBUS_LEN - 1) downto 0);
		end if;
		if (dexp_we_c = '1') then
			data_exp_x	<=	data_out_int((MBUS_LEN - 1) downto 0);
		end if;

	end process;

	 adaddr_out_int	<=	daddr_x;
	data_out		<=	data_ox;
	data_in_int		<=	data_ix;
	 iadata_x		<=	data_exp_x & data_is;
	data_is_int		<=	iadata_x((DATA_LEN - 1) downto 0);

	ndre_out_int		<=	ndre_x;
	nadwe_out_int		<=	ndwe_x;

end OAC_STRUCT;

