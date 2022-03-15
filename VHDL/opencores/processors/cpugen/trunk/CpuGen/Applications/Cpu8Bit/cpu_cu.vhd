-- 	CPU_CU
--	rel. 2.0
-- 	by gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.CPU_UTILS.all;

entity CPU_CU is
	port(
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
		idata_in: 	in	Cpu_ibus;
		nreset_in:	in	std_logic;
		clk_in:		in	std_logic
	);
end;

architecture CU_STRUCT of CPU_CU is

	SIGNAL idata_x		: Cpu_ibus;
	SIGNAL idata_c		: Cpu_ibus;
	SIGNAL daddr_x		: Cpu_bus;
	SIGNAL daddr_c		: Cpu_bus;
	SIGNAL data_is_x	: Cpu_mbus;
	SIGNAL data_is_c	: Cpu_mbus;
	SIGNAL valid_b		: std_logic;
	SIGNAL valid_x		: std_logic;
	SIGNAL valid_c		: std_logic;
	SIGNAL skip_x		: std_logic;
	SIGNAL skip_c		: std_logic;
	SIGNAL TC_x			: Cpu_cclass;
	SIGNAL TC_c			: Cpu_cclass;
	SIGNAL TD_x			: Cpu_dclass;
	SIGNAL TD_c			: Cpu_dclass;
	SIGNAL S_x			: Cpu_status;
	SIGNAL S_c			: Cpu_status;
	SIGNAL E_x			: Cpu_event;
	SIGNAL E_c			: Cpu_event;
	SIGNAL pc_mux_x		: Cpu_imux;
	SIGNAL pc_mux_b		: Cpu_imux;
	SIGNAL ndre_x		: std_logic;
	SIGNAL ndwe_x		: std_logic;
	SIGNAL ndre_b		: std_logic;
	SIGNAL ndwe_b		: std_logic;
	SIGNAL int_start_x	: std_logic;
	SIGNAL int_stop_x	: std_logic;
	SIGNAL int_start_c	: std_logic;
	SIGNAL int_stop_c	: std_logic;
	SIGNAL nreset_v		: Cpu_nreset;
	SIGNAL C_store_c	: std_logic;
	SIGNAL C_store_x	: std_logic;
	SIGNAL C_mem_c		: std_logic;
	SIGNAL C_mem_x		: std_logic;
	SIGNAL C_dvalid		: std_logic;
	SIGNAL C_rti		: std_logic;
	SIGNAL C_rts		: std_logic;
	SIGNAL C_jmp		: std_logic;
	SIGNAL C_jms		: std_logic;
	SIGNAL C_raw		: std_logic;

begin

	CU_REGISTERS: process (clk_in,nreset_in)

	begin

		if (nreset_in = nreset_value) then

			S_c			<=	RESET;
			E_c			<=	NONE_E;
			idata_c		<=	(others => '0');
			daddr_c		<=	(others => '0');
			data_is_c	<=	(others => '0');
			valid_c		<=	'0';
			skip_c		<=	'0';
			TC_c		<=	TC_OTH;
			TD_c		<=	TD_NOP;
			int_start_c	<=	'0';
			int_stop_c	<=	'0';
			nreset_v	<=	RESET_ALL;

		elsif (rising_edge(clk_in)) then

			S_c			<=	S_x;
			E_c			<=	E_x;
			skip_c		<=	skip_x;
			valid_c		<=	valid_x;
			idata_c		<=	idata_x;
			data_is_c	<=	data_is_x;
			TC_c		<=	TC_x;
			TD_c		<=	TD_x;
			daddr_c		<=	daddr_x;
			int_start_c	<=	int_start_x;
			int_stop_c	<=	int_stop_x;
			if (nreset_v	< UNRESET_ALL) then
				nreset_v	<=	unsigned(nreset_v) + 1;
			else
				nreset_v	<=	UNRESET_ALL;
			end if;

		end if;

	end process;

	CU_DECODE: process (nreset_in, idata_x, daddr_x)

	begin

		daddr_x 	<=	idata_x((BUS_LEN + CODE_LEN - 1) downto (CODE_LEN));
		data_is_x	<=	idata_x((MBUS_LEN + CODE_LEN - 1) downto (CODE_LEN));

		if (nreset_in /= nreset_value) then

			case idata_x((CODE_LEN - 1) downto 0) is
				when M_LK	=>
					case daddr_x((ICODE_LEN - 1) downto 0) is
						-- NOP
						when M_LK_NOP		 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_NOP;
						-- ROL
						when M_LK_ROL		 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_ROL;
						-- ROR
						when M_LK_ROR		 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_ROR;
						-- SHL
						when M_LK_SHL		 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_SHL;
						-- SHR
						when M_LK_SHR		 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_SHR;
						-- NOT
						when M_LK_NOT		 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_NOT;
						-- CLA
						when M_LK_CLA		 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_CLA;
						-- SKZ
						when M_LK_SKZ	 	=>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_SKZ;
						-- SKC
						when M_LK_SKC		 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_SKC;
						-- SKNZ
						when M_LK_SKNZ	 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_SKNZ;
						-- SKNC
						when M_LK_SKNC	 =>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_SKNC;
						-- RTS
						when M_LK_RTS		 =>
							TC_x 	<= TC_RTS;
							TD_x 	<= TD_NOP;
						-- RTI
						when M_LK_RTI		 =>
							TC_x 	<= TC_RTI;
							TD_x 	<= TD_NOP;
						-- OTHERS
						when others	=>
							TC_x 	<= TC_OTH;
							TD_x 	<= TD_NOP;
					end case;
				-- OPJ
				when M_J	=>
					TC_x 	<= TC_JMP;
					TD_x 	<= TD_NOP;
				-- OPJS
				when M_JS	=>
					TC_x 	<= TC_JMS;
					TD_x 	<= TD_NOP;
				-- OPS
				when M_S	=>
					TC_x 	<= TC_STA;
					TD_x 	<= TD_NOP;
				-- OPM
				when others	=>
					if (idata_x(CODE_LEN - 1) = '0') then
						TC_x 	<= TC_LDA;
					else
						TC_x 	<= TC_DAT;
					end if;
					TD_x	<= '0' & idata_x((CODE_LEN - 2) downto 0);
			end case;

		else

			TC_x 	<= TC_OTH;
			TD_x 	<= TD_NOP;

		end if;

	end process;

	CU_CONDITIONS: process (nreset_in, nreset_v, skip_x, skip_c, S_c, TC_x, TC_c,
					C_store_c, C_store_x, C_mem_c, C_mem_x)

	begin

		if ((nreset_in /= nreset_value) and (nreset_v > UNRESET_IU)) then

			if ((skip_c = '0') and (TC_c = TC_STA)) then
				C_store_c	<= '1';
			else
				C_store_c	<= '0';
			end if;
			if ((skip_x = '0') and (TC_x = TC_STA)) then
				C_store_x	<= '1';
			else
				C_store_x	<= '0';
			end if;
			if ((skip_c = '0') and (TC_c = TC_LDA)) then
				C_mem_c		<= '1';
			else
				C_mem_c		<= '0';
			end if;
			if ((skip_x = '0') and (TC_x = TC_LDA)) then
				C_mem_x		<= '1';
			else
				C_mem_x		<= '0';
			end if;
			if ((C_store_c = '1') or (C_mem_c = '1')) then
				C_dvalid	<= '1';
			else
				C_dvalid	<= '0';
			end if;
			if ((TC_x = TC_RTI) and (skip_x = '0') and (S_c = INTERRUPT)) then
				C_rti		<= '1';
			else
				C_rti		<= '0';
			end if;
			if ((TC_x = TC_RTS) and (skip_x = '0')) then
				C_rts		<= '1';
			else
				C_rts		<= '0';
			end if;
			if ((TC_x = TC_JMP) and (skip_x = '0')) then
				C_jmp		<= '1';
			else
				C_jmp		<= '0';
			end if;
			if ((TC_x = TC_JMS) and (skip_x = '0')) then
				C_jms		<= '1';
			else
				C_jms		<= '0';
			end if;
			if ((C_store_c = '1') and (C_mem_x = '1')) then
				C_raw		<= '1';
			else
				C_raw		<= '0';
			end if;

		else

			C_store_c	<= '0';
			C_store_x	<= '0';
			C_mem_c		<= '0';
			C_mem_x		<= '0';
			C_dvalid	<= '0';
			C_rti		<= '0';
			C_rts		<= '0';
			C_jmp		<= '0';
			C_jms		<= '0';
			C_raw		<= '0';

		end if;

	end process;

	CU_EVENT: process (nreset_in, nreset_v,
	int_in, int_stop_c,
	skip_c, S_c, E_c, TC_x, TC_c)

	begin

		E_x		<=	NONE_E;

		if ((nreset_in /= nreset_value) and (nreset_v > UNRESET_IU)) then

			if ((int_in = '1') and (S_c = NORMAL) and (int_stop_c = '0')) then  -- WAIT 2 CLOCKS AFTER RTI TO AVOID LOCKS
				E_x		<=	INT_E;
			else
				E_x		<=	NONE_E;
			end if;
		end if;

	end process;

	CU_PCMUX: process (nreset_in, nreset_v, E_x, C_jmp, C_jms, C_rti, C_rts, C_raw, skip_x)

	begin

		if ((nreset_in /= nreset_value) and (nreset_v > UNRESET_IU)) then

			if (skip_x = '1') then
				if (E_x = INT_E) then
					pc_mux_b	<= INTSN_I;
				else
					pc_mux_b	<= NEXT_I;
				end if;
			elsif (C_jmp = '1') then			-- JMP
				if (E_x = INT_E) then
					pc_mux_b	<= INTSE_I;
				else
					pc_mux_b	<= EXT_I;
				end if;
			elsif (C_jms = '1') then			-- JMS
				if (E_x = INT_E) then
					pc_mux_b	<= INTSS_I;
				else
					pc_mux_b	<= EXTS_I;
				end if;
			elsif (C_rti = '1') then	-- RTI and INTERRUPT STATE
				pc_mux_b	<= STACK_I;
			elsif (C_rts = '1') then			-- RTS
				if (E_x = INT_E) then
					pc_mux_b	<= INTSS_I;
				else
					pc_mux_b	<= STACK_I;
				end if;
			elsif (C_raw = '1') then			-- RTS
				if (E_x = INT_E) then
					pc_mux_b	<= INTSS_I;
				else
					pc_mux_b	<= SAME_I;
				end if;
			else						-- ELSE
				if (E_x = INT_E) then
					pc_mux_b	<= INTSN_I;
				else
					pc_mux_b	<= NEXT_I;
				end if;
			end if;
		else
				pc_mux_b	<= NEXT_I;

		end if;

	end process;

	CU_UPDATE: process (skip_x, C_store_c, C_store_x, C_raw, C_mem_x)

	begin

		if (skip_x = '1') then
			valid_b 	<= '0';
			ndre_b 		<= '1';
			ndwe_b 		<= '1';
		else
			if (C_raw = '1') then	-- RAW
				ndwe_b 	<= '1';
				ndre_b 	<= '1';
				valid_b <= '0';
			elsif (C_store_x = '1') then			-- NEXT WRITE
				ndwe_b 	<= '0';
				ndre_b 	<= '1';
				valid_b <= '1';
			else							-- ELSE
				if (C_mem_x = '1') then
					ndre_b 	<= '0';
				else
					ndre_b 	<= '1';
				end if;
				ndwe_b 	<= '1';
				valid_b <= '1';
			end if;

		end if;

	end process;

	CU_CONTROL: process (nreset_in, nreset_v, E_x, E_c, skip_c, S_c, pc_mux_b, idata_in,
				int_start_c, int_stop_c,
				C_rti, skip, valid_b, ndwe_b, ndre_b, C_dvalid, C_store_c, C_store_x, C_mem_x)

	begin

		idata_x 	<=	idata_in;

		if (nreset_v < UNRESET_CU) then -- (reset or starting)
			skip_x		<=	skip;
			pc_mux_x	<=	NEXT_I;
			valid_x		<=	'0';
			ndre_x		<=	'1';
			ndwe_x		<=	'1';
			int_start_x	<=	'0';
			int_stop_x	<=	'0';
			S_x			<=	NORMAL;	-- NORMAL STATE

		else

			if (E_x = INT_E)	then		
				skip_x		<= skip;
				pc_mux_x	<= pc_mux_b;
				valid_x 	<= valid_b;
				ndwe_x 		<= ndwe_b;
				ndre_x 		<= ndre_b;
				int_start_x	<=	'1';
				int_stop_x	<=	'0';
				S_x 		<= 	INTERRUPT;
			else					-- 	(NONE)
				skip_x		<= skip;
				pc_mux_x	<= pc_mux_b;
				valid_x 	<= valid_b;
				ndwe_x 		<= ndwe_b;
				ndre_x 		<= ndre_b;
				if (C_rti = '1') then	-- RTI
					int_start_x	<=	'0';
					int_stop_x	<=	'1';
					S_x 		<= 	NORMAL;
				else
					int_start_x	<=	'0';
					int_stop_x	<=	'0';
					S_x			<=	S_c;
				end if;

			end if;

		end if;

	end process;

	CU_OUTPUT: process (daddr_x, daddr_c, data_is_c, data_is_x,
				pc_mux_x, valid_c, valid_x,  ndre_x, ndwe_x, idata_in, 
				int_start_c,int_stop_x,
				C_store_c, TC_x,TD_x,TC_c,TD_c)

	begin
		class_cu	<=	TC_c;
		class_du	<=	TD_c;
		data_is		<=	data_is_c;
		pc_mux		<=	pc_mux_x;
		ext_addr	<=	idata_in((ISTR_LEN - 1) downto CODE_LEN);
		daddr_is	<=	daddr_x;
		ndre_int	<=	ndre_x;	
		ndwe_int	<=	ndwe_x;	
		int_start	<=	int_start_c;
		int_stop	<=	int_stop_x;
		valid 		<= 	valid_c;
	end process;

end CU_STRUCT;



