-- 	CPU_DU
--	rel. 2.0
-- 	by gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.CPU_UTILS.all;

entity CPU_DU is
	port(
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
end;

architecture DU_STRUCT of CPU_DU is
	constant all_zero	: Cpu_dbus	:= (others => '0');
	SIGNAL acc    		: Cpu_abus;		-- CARRY 	<= acc(DATA_LEN)
	SIGNAL acc_c    	: Cpu_abus;		-- CARRY 	<= acc(DATA_LEN)
   	SIGNAL data_x		: Cpu_dbus;
	SIGNAL acc_i    	: Cpu_abus;		-- CARRY 	<= acc(DATA_LEN)
	SIGNAL skip_i		: std_logic;
	SIGNAL skip_l		: std_logic;
	SIGNAL nreset_v		: Cpu_nreset;
	SIGNAL code			: OP;
	SIGNAL code_c		: OP;

begin

	DU_REGISTERS: process(clk_in,nreset_in)

	begin

		if (nreset_in = nreset_value) then

			R1: for K in 0 to (ACC_NUM - 1) loop
				acc_c(K)	<=	(others => '0');
			end loop R1;			
			code_c		<=	NOP_I;
			skip_i		<=	'0';
			R2: for K in 0 to (ACC_NUM - 1) loop
				acc_i(K)	<=	(others => '0');
			end loop R2;
			nreset_v	<=	RESET_ALL;

		elsif (rising_edge(clk_in)) then

			R3: for K in 0 to (ACC_NUM - 1) loop
				acc_c(K)	<=	acc(K);
			end loop R3;
			code_c		<=	code;
			if (int_start = '1') then
				R4: for K in 0 to (ACC_NUM - 1) loop
					acc_i(K)	<=	acc(K);
				end loop R4;
				skip_i		<=	skip_l;
			end if;
			if (nreset_v	< UNRESET_ALL) then
				nreset_v	<=	unsigned(nreset_v) + 1;
			else
				nreset_v	<=	UNRESET_ALL;
			end if;

		end if;

	end process;

	DU_ALU: process(nreset_in, nreset_v, valid, code, code_c, class_cu,
				acc_i, skip_i,
				class_du, acc_c, data_x, data_is_int, data_in_int, acc, skip_l)
	begin

		skip_l 		<= 	'0';
		R5: for K in 0 to (ACC_NUM - 1) loop
			acc(K)	<=	acc_c(K);
		end loop R5;		
		code		<=	NOP_I;

		if (class_cu  = TC_DAT) then
			data_x		<= data_is_int;
		else
			data_x		<= data_in_int((DATA_LEN - 1) downto 0);
		end if;

		if ((nreset_in /= nreset_value) and (nreset_v > UNRESET_CU) and (valid = '1')) then

			case class_cu is
				-- OPL
				when TC_OTH 	=>
					case class_du is
						-- ROL
						when TD_ROL =>
							acc(0)	<=	(acc_c(0)((DATA_LEN - 1) downto 0) & acc_c(0)(DATA_LEN));
							code	<=	ROL_I;
						-- ROR
						when TD_ROR =>
							acc(0)	<=	(acc_c(0)(0) & acc_c(0)((DATA_LEN) downto 1));
							code	<=	ROR_I;
						-- SHL
						when TD_SHL =>
							acc(0)	<=	(acc_c(0)((DATA_LEN - 1) downto 0) & '0');
							code	<=	SHL_I;
						-- SHR
						when TD_SHR =>
							acc(0)	<=	('0' & acc_c(0)((DATA_LEN) downto 1));
							code	<=	SHR_I;
						-- NOT
						when TD_NOT =>
							acc(0)	<=	('0' & (not acc_c(0)((DATA_LEN-1) downto 0)));
 							code	<=	NOT_I;
						-- CLA
						when TD_CLA =>
							acc(0)	<=	(others => '0');
 							code	<=	CLA_I;
						-- NOP
						when TD_NOP =>
							code	<=	NOP_I;
						-- SKZ
						when TD_SKZ =>
							if (acc_c(0)((DATA_LEN - 1) downto 0) = all_zero) then skip_l <= '1';
							else  skip_l <= '0';
							end if;
							code	<=	SKZ_I;
						-- SKC
						when TD_SKC =>
							if (acc_c(0)(DATA_LEN) = '1') then skip_l <= '1';
							else  skip_l <= '0';
							end if;
							code	<=	SKC_I;
						-- SKNZ
						when TD_SKNZ =>
							if (acc_c(0)((DATA_LEN - 1) downto 0) /= all_zero) then skip_l <= '1';
							else  skip_l <= '0';
							end if;
							code	<=	SKNZ_I;
						-- SKNC
						when TD_SKNC =>
							if (acc_c(0)(DATA_LEN) = '0') then skip_l <= '1';
							else  skip_l <= '0';
							end if;
							code	<=	SKNC_I;
						-- OTHERS
						when others =>
							code	<=	NOP_I;
					end case;
				-- OPM
				when TC_LDA | TC_DAT	=>

					case class_du is
						-- LDA
						when TD_LDA =>
							acc(0)	<=	('0' & data_x);
							if (class_cu  = TC_DAT) then
								code	<=	LDAI_I;
							else
								code	<=	LDA_I;
							end if;
						-- XOR
						when TD_XOR =>
							acc(0)	<=	(('0' & acc_c(0)((DATA_LEN - 1) downto 0)) xor ('0' & data_x));
							if (class_cu  = TC_DAT) then
								code	<=	XORI_I;
							else
								code	<=	XOR_I;
							end if;
						-- ADD
						when TD_ADD =>
							acc(0)	<=	(('0' & unsigned(acc_c(0)((DATA_LEN - 1) downto 0))) + ('0' & unsigned(data_x)));
							if (class_cu  = TC_DAT) then
								code	<=	ADDI_I;
							else
								code	<=	ADD_I;
							end if;
						-- AND
						when TD_AND =>
							acc(0)	<=	(('0' & acc_c(0)((DATA_LEN - 1) downto 0)) and ('0' & data_x));
							if (class_cu  = TC_DAT) then
								code	<=	ANDI_I;
							else
								code	<=	AND_I;
							end if;
						-- SUB
						when TD_SUB =>
							acc(0)	<=	(('0' & unsigned(acc_c(0)((DATA_LEN - 1) downto 0))) - ('0' & unsigned(data_x)));
							if (class_cu  = TC_DAT) then
								code	<=	SUBI_I;
							else
								code	<=	SUB_I;
							end if;
						-- OR
						when TD_OR =>
							acc(0)	<=	(('0' & acc_c(0)((DATA_LEN - 1) downto 0)) or ('0' & data_x));
							if (class_cu  = TC_DAT) then
								code	<=	ORI_I;
							else
								code	<=	OR_I;
							end if;
						-- OTHERS
						when others =>
							code	<=	NOP_I;
					end case;
				-- OPS
				when TC_STA 	=>
					code	<=	STA_I;
				-- RTS
				when TC_RTS 	=>
					code	<=	RTS_I;
				-- RTI
				when TC_RTI 	=>
					acc(0)	<=	acc_i(0);
					skip_l	<=	skip_i;
					code	<=	RTI_I;
				-- OPJ
				when TC_JMP 	=>
					code	<=	JMP_I;
				-- OPJS
				when TC_JMS 	=>
					code	<=	JMS_I;
		 		when others =>
					code	<=	NOP_I;
			end case;
		else
			if (nreset_v < UNRESET_DU) then

				acc(0)	<= 	(others => '0');
				code	<=	NOP_I;
			else

				acc(0)	<= 	acc_c(0);
				code	<=	code_c;
			end if;

		end if;

	end process;

	data_out_int	<= 	acc_c(0)((DATA_LEN - 1) downto 0);
	skip			<= 	skip_l when (int_start = '0') else '0';

end DU_STRUCT;

