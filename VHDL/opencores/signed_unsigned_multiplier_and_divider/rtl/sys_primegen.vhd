----------------------------------------------------------------------------------
-- Company: @Home
-- Engineer: zpekic@hotmail.com
-- 
-- Create Date: 02/26/2018 11:13:02 PM
-- Design Name: Prime number finder
-- Module Name: sys_prime - Behavioral
-- Project Name: Wrapper around signed/unsigned multiply/divide
-- Target Devices: https://www.micro-nova.com/mercury/ + Baseboard
-- Input devices: 
-- 	https://store.digilentinc.com/pmod-kypd-16-button-keypad/ (use when SW(0) is off)
-- 	https://www.parallax.com/product/28024 (use when SW(0) is on, RX = PMOD(0), TX = PMOD(4), RST = N/C, GND = PMOD_GND)
-- Tool Versions: ISE 14.7 (nt)
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.99 - Kinda works...
-- Additional Comments:
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.sys_primegen_package.all;
entity sys_primegen is
    Port ( 
				-- 50MHz on the Mercury board
				CLK: in std_logic;
				-- Master reset button on Mercury board
				USR_BTN: in std_logic; 
				-- Switches on baseboard
				-- SW(0) -- 0 enter Arg0 and Arg1 using PMOD keyboard, 1 enter using serial (UART)
				-- SW(1) -- 0 (16/16 or 16*16), 1 (32/16 - divide only)   
				-- SW(2) -- 0 (unsigned), 1 (signed)
				-- SW(3) -- 0 (multiply), 1 (divide)
				-- SW(4) -- 0 manual mode (see SW3, 2, 1), 1 find prime numbers using microcoded program
				-- SW(6 downto 5) -- system clock speed 
				--   0   0	1Hz	(can be used with SS mode)
				--   0   1	1024Hz (can be used with SS mode)
				--   1   0  6.125MHz
				--   1   1  25MHz
				-- SW(7)
				--   0   single step mode off (BTN3 should be pressed once to start the system)
				--   1   single step mode on (use with BTN3)
				SW: in std_logic_vector(7 downto 0); 
				-- Push buttons on baseboard
				-- BTN0 - LED display select 0
				-- BTN1 - LED display select 1
				-- BTN2 - start the multiply or divide operation, or find prime algorithm
				-- BTN3 - single step clock cycle forward if in SS mode (NOTE: single press on this button is needed after reset to unlock SS circuit)
				BTN: in std_logic_vector(3 downto 0); 
				-- Stereo audio output on baseboard
				--AUDIO_OUT_L, AUDIO_OUT_R: out std_logic;
				-- 7seg LED on baseboard 
				A_TO_G: out std_logic_vector(6 downto 0); 
				AN: out std_logic_vector(3 downto 0); 
				DOT: out std_logic; 
				-- 4 LEDs on Mercury board
				LED: out std_logic_vector(3 downto 0);
				-- ADC interface
				-- channel	input
				-- 0			Audio Left
				-- 1 			Audio Right
				-- 2			Temperature
				-- 3			Light	
				-- 4			Pot
				-- 5			Channel 5 (free)
				-- 6			Channel 6 (free)
				-- 7			Channel 7 (free)
				--ADC_MISO: in std_logic;
				--ADC_MOSI: out std_logic;
				--ADC_SCK: out std_logic;
				--ADC_CSN: out std_logic;
				--PMOD interface
				PMOD: inout std_logic_vector(7 downto 0)

          );
end sys_primegen;

architecture Structural of sys_primegen is

component clock_divider is
    Port ( reset : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           slow : out  STD_LOGIC_VECTOR (11 downto 0);
			  baud : out STD_LOGIC_VECTOR(7 downto 0);
           fast : out  STD_LOGIC_VECTOR (4 downto 0)
			 );
end component;

component clocksinglestepper is
    Port ( reset : in STD_LOGIC;
           clock0_in : in STD_LOGIC;
           clock1_in : in STD_LOGIC;
           clock2_in : in STD_LOGIC;
           clock3_in : in STD_LOGIC;
           clocksel : in STD_LOGIC_VECTOR(1 downto 0);
           modesel : in STD_LOGIC;
           singlestep : in STD_LOGIC;
           clock_out : out STD_LOGIC);
end component;

component debouncer8channel is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           signal_raw : in  STD_LOGIC_VECTOR(7 downto 0);
           signal_debounced : out  STD_LOGIC_VECTOR(7 downto 0));
end component;

component fourdigitsevensegled is
    Port ( -- inputs
			  data : in  STD_LOGIC_VECTOR (15 downto 0);
           digsel : in  STD_LOGIC_VECTOR (1 downto 0);
           showdigit : in  STD_LOGIC_VECTOR (3 downto 0);
           showdot : in  STD_LOGIC_VECTOR (3 downto 0);
           showsegments : in  STD_LOGIC;
			  -- outputs
           anode : out  STD_LOGIC_VECTOR (3 downto 0);
           segment : out  STD_LOGIC_VECTOR (7 downto 0)
			 );
end component;

component signedmultiplier is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
			  mode: in STD_LOGIC_VECTOR(1 downto 0);
			  dividend32: in STD_LOGIC;
           arg0h : in  STD_LOGIC_VECTOR (15 downto 0);
           arg0l : in  STD_LOGIC_VECTOR (15 downto 0);
           arg1 : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0);
           ready : out  STD_LOGIC;
           error : out  STD_LOGIC;
           zero : out  STD_LOGIC;
           sign : out  STD_LOGIC;
			  debug : out STD_LOGIC_VECTOR(3 downto 0)
			  );
end component;

component bin2bcd is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           bin : in  STD_LOGIC_VECTOR (15 downto 0);
			  ready : out  STD_LOGIC;
           bcd : out  STD_LOGIC_VECTOR (23 downto 0);
			  debug: out STD_LOGIC_VECTOR(3 downto 0));
end component;

component PmodKYPD is
    Port ( 
           clk : in  STD_LOGIC;
			  reset: in STD_LOGIC;
			  bcdmode: in STD_LOGIC;
           Col : out  STD_LOGIC_VECTOR (3 downto 0);
			  Row : in  STD_LOGIC_VECTOR (3 downto 0);
			  key_code: out  STD_LOGIC_VECTOR (3 downto 0);
			  key_down: out STD_LOGIC
         );
end component;

component UART is
    Generic (
        CLK_FREQ      : integer := 50e6;   -- system clock frequency in Hz
        BAUD_RATE     : integer := 115200; -- baud rate value
        PARITY_BIT    : string  := "none"; -- type of parity: "none", "even", "odd", "mark", "space"
        USE_DEBOUNCER : boolean := True    -- enable/disable debouncer
    );
    Port (
        CLK         : in  std_logic; -- system clock
        RST         : in  std_logic; -- high active synchronous reset
        -- UART INTERFACE
        UART_TXD    : out std_logic; -- serial transmit data
        UART_RXD    : in  std_logic; -- serial receive data
        -- USER DATA INPUT INTERFACE
        DATA_IN     : in  std_logic_vector(7 downto 0); -- input data
        DATA_SEND   : in  std_logic; -- when DATA_SEND = 1, input data are valid and will be transmit
        BUSY        : out std_logic; -- when BUSY = 1, transmitter is busy and you must not set DATA_SEND to 1
        -- USER DATA OUTPUT INTERFACE
        DATA_OUT    : out std_logic_vector(7 downto 0); -- output data
        DATA_VLD    : out std_logic; -- when DATA_VLD = 1, output data are valid
        FRAME_ERROR : out std_logic  -- when FRAME_ERROR = 1, stop bit was invalid
    );
end component;

component rom32x32 is
    Port ( nCS : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (4 downto 0);
           d : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component sequencer is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           operation : in  STD_LOGIC_VECTOR (2 downto 0);
           condition : in  STD_LOGIC;
           directvalue : in  STD_LOGIC_VECTOR (7 downto 0);
           uIP : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component alu_with_hex2ascii is
    Port ( a : in  STD_LOGIC_VECTOR (15 downto 0);
           b : in  STD_LOGIC_VECTOR (15 downto 0);
			  bcdmode: in STD_LOGIC;
           operation : in  STD_LOGIC_VECTOR (2 downto 0);
           carry_in : in  STD_LOGIC;
           carry_out : out  STD_LOGIC;
           zero : out  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (15 downto 0));
end component;


signal Reset: std_logic;
signal clock_main: std_logic;
signal switch: std_logic_vector(7 downto 0);
signal button: std_logic_vector(3 downto 0);
signal led_bus: std_logic_vector(19 downto 0);
signal display0, display1: std_logic_vector(15 downto 0);
signal flash: std_logic;
signal freq2k, freq1k, freq512, freq256, freq128, freq64, freq32, freq16, freq8, freq4, freq2, freq1: std_logic;
signal freq38400, freq19200, freq9600, freq4800, freq2400, freq1200, freq600, freq300: std_logic;
signal freq25M, freq12M5, freq6M25, freq3M125, freq1M5625: std_logic;

signal arg0, arg1: std_logic_vector(31 downto 0);
signal key_pulse, rxd_pulse: std_logic;
signal key_code: std_logic_vector(3 downto 0);
signal result: std_logic_vector(31 downto 0);
alias prod_h: std_logic_vector(15 downto 0) is result(31 downto 16);
alias prod_l: std_logic_vector(15 downto 0) is result(15 downto 0);
alias quotient: std_logic_vector(15 downto 0) is result(31 downto 16);
alias remainder: std_logic_vector(15 downto 0) is result(15 downto 0);

signal sm_ready, sm_error, sm_zero, sm_sign: std_logic;
signal sm_control: std_logic_vector(3 downto 0);
signal sm_input1, sm_input0l, sm_input0h: std_logic_vector(15 downto 0);

--signal txd_data: std_logic_vector(7 downto 0);
signal txd_busy, txd: std_logic;
signal rxd_data: std_logic_vector(7 downto 0);
signal rxd_valid, rxd_valid_delayed, rxd_error, uart_send: std_logic;
signal rxd_pulsecnt: integer range 0 to 15;
signal kbd_col: std_logic_vector(3 downto 0);
signal rxd_code: std_logic_vector(4 downto 0);
signal input_pulse: std_logic;
signal input_code: std_logic_vector(3 downto 0);
signal send_previous, send_current: std_logic_vector(7 downto 0);

-- specialized "CPU" ---
signal condition: std_logic;
signal uIP: std_logic_vector(7 downto 0);
signal alu_c, alu_z: std_logic;
signal n, m, i: std_logic_vector(15 downto 0);
signal alu_y, alu_a, alu_b: std_logic_vector(15 downto 0);
signal i_bcd, n_bcd: std_logic_vector(23 downto 0);
signal i_bcdready, n_bcdready: std_logic;

signal uInstruction: std_logic_vector(31 downto 0);
alias u_value: std_logic_vector(7 downto 0) is uInstruction(31 downto 24);
alias u_muxa: std_logic_vector(2 downto 0) is uInstruction(23 downto 21);
alias u_muxb: std_logic_vector(2 downto 0) is uInstruction(20 downto 18);
alias u_alu:  std_logic_vector(2 downto 0) is uInstruction(17 downto 15);
alias u_ci: std_logic is uInstruction(14);
alias u_i: std_logic is uInstruction(13);
alias u_m: std_logic is uInstruction(12);
alias u_n: std_logic is uInstruction(11);
alias u_mode: std_logic_vector(1 downto 0) is uInstruction(10 downto 9);
alias u_multdiv: std_logic is uInstruction(8);
alias u_uart: std_logic is uInstruction(7);
alias u_opsequence: std_logic_vector(2 downto 0) is uInstruction(6 downto 4);
alias u_condselect: std_logic_vector(3 downto 0) is uInstruction(3 downto 0);
-- HACKHACK "faked" ucode control signals
signal u_i2bcdstart: std_logic;
signal u_n2bcdstart: std_logic;

begin
   
	 Reset <= USR_BTN;

	-- DISPLAY
	flash <= (not sm_error) or freq2; -- blink in hold bus mode!
	 
	display0 <= result(15 downto 0) when switch(4) = '0' else uIP & uInstruction(7 downto 0);
	display1 <= result(31 downto 16) when switch(4) = '0' else alu_y;
	
	with button(1 downto 0) select
		led_bus(15 downto 0) <= display0 when "00",
										display1 when "01",
										arg0(15 downto 0) when "10",
										arg1(15 downto 0) when others;
		
	 LED(3 downto 2) <= sm_sign & sm_zero when switch(4) = '0' else alu_c & condition;  
	 LED(1) <= sm_ready; 
	 LED(0) <= clock_main;  
    led4x7: fourdigitsevensegled port map ( 
			  -- inputs
			  data => led_bus(15 downto 0),
           digsel(1) => freq1k,
			  digsel(0) => freq2k,
           showdigit(3) => flash,
           showdigit(2) => flash,
           showdigit(1) => flash,
           showdigit(0) => flash,
           showdot => led_bus(19 downto 16),
           showsegments => '1',
			  -- outputs
           anode => AN,
           segment(6 downto 0) => A_TO_G(6 downto 0),
			  segment(7) => DOT
			 );

    -- FREQUENCY GENERATOR
    one_sec: clock_divider port map 
    (
        clock => CLK,
        reset => Reset,
        slow(11) => freq1, -- 1Hz
        slow(10) => freq2, -- 2Hz
        slow(9) => freq4, -- 4Hz
        slow(8) => freq8, -- 8Hz
        slow(7) => freq16,  -- 16Hz
        slow(6) => freq32,  -- 32Hz
        slow(5) => freq64,  -- 64Hz
        slow(4) => freq128,  -- 128Hz
        slow(3) => freq256,  -- 256Hz
        slow(2) => freq512,  -- 512Hz
        slow(1) => freq1k,  -- 1024Hz
        slow(0) => freq2k,  -- 2048Hz
		  baud(7) => freq300,
		  baud(6) => freq600,		  
		  baud(5) => freq1200,
		  baud(4) => freq2400,
		  baud(3) => freq4800,
		  baud(2) => freq9600,
		  baud(1) => freq19200,
		  baud(0) => freq38400,
		  fast(4) => freq1M5625,
		  fast(3) => freq3M125,
		  fast(2) => freq6M25,
		  fast(1) => freq12M5,
		  fast(0) => freq25M
    );

	-- DEBOUNCE the 8 switches and 4 buttons
    debouncer_sw: debouncer8channel port map (
        clock => freq256,
        reset => Reset,
        signal_raw => SW,
        signal_debounced => switch
    );

    debouncer_btn: debouncer8channel port map (
        clock => freq256,
        reset => Reset,
        signal_raw(7 downto 4) => "1111", --PMOD(3 downto 0),
        signal_raw(3 downto 0) => BTN(3 downto 0),
		  signal_debounced(7 downto 4) => open,
        signal_debounced(3 downto 0) => button
    );
	
	-- Single step by each clock cycle, slow or fast
	ss: clocksinglestepper port map (
        reset => Reset,
        clock0_in => freq2,
        clock1_in => freq2k,
        clock2_in => freq6M25,
        clock3_in => freq12M5,
        clocksel => switch(6 downto 5),
        modesel => switch(7),
        singlestep => button(3),
        clock_out => clock_main
    );
	 
	-- UART for serial input / output
	sio: UART 
	 generic map 
	 (
		--CLK_FREQ => 100e6,
		BAUD_RATE => 57600
		--PARITY_BIT => "even"
		--USE_DEBOUNCER => false
	 )
	 port map 
	 (
        CLK => CLK,
        RST => Reset,
        -- UART INTERFACE
        UART_TXD => txd, -- serial transmit data
        UART_RXD => PMOD(4), -- serial receive data
        -- USER DATA INPUT INTERFACE
        DATA_IN  => alu_y(7 downto 0),
        DATA_SEND => uart_send,
        BUSY  => txd_busy,
        -- USER DATA OUTPUT INTERFACE
        DATA_OUT => rxd_data,
        DATA_VLD => rxd_valid,
        FRAME_ERROR => rxd_error
    );

	-- KEYBOARD
	kbd: PmodKYPD Port map
			( clk => freq1k, 
			  reset => reset,
			  bcdmode => '0',
           Col(3) => kbd_col(3), --PMOD(0), -- out
           Col(2) => kbd_col(2), --PMOD(1),
           Col(1) => kbd_col(1), --PMOD(2),
           Col(0) => kbd_col(0), --PMOD(3),
			  Row(3) => PMOD(4), -- in
			  Row(2) => PMOD(5),
			  Row(1) => PMOD(6),
			  Row(0) => PMOD(7),
			  key_code => key_code,
			  key_down => key_pulse			  
			);	 
	
-- output to PMOD is either keyboard columns or UART TXD	
PMOD(3 downto 0) <= kbd_col(0) & kbd_col(1) & kbd_col(2) & kbd_col(3) when switch(0) = '0' else "111" & txd;
input_pulse <= key_pulse when switch(0) = '0' else rxd_pulse;
input_code <= key_code when switch(0) = '0' else rxd_code(3 downto 0);

-- convert from 8-bit ASCII to hex
gethexcode: process(rxd_data, rxd_valid, rxd_error)
begin
	if (rising_edge(rxd_valid)) then
		if (rxd_error = '1') then
			rxd_code <= "01111";
		else
			case rxd_data is
				when X"30" => rxd_code <= "10000"; -- 0
				when X"31" => rxd_code <= "10001";
				when X"32" => rxd_code <= "10010";
				when X"33" => rxd_code <= "10011";
				when X"34" => rxd_code <= "10100";
				when X"35" => rxd_code <= "10101";
				when X"36" => rxd_code <= "10110";
				when X"37" => rxd_code <= "10111";
				when X"38" => rxd_code <= "11000";
				when X"39" => rxd_code <= "11001"; -- 9
				when X"41" => rxd_code <= "11010"; -- A
				when X"42" => rxd_code <= "11011"; -- B
				when X"43" => rxd_code <= "11100"; -- C
				when X"44" => rxd_code <= "11101"; -- D
				when X"45" => rxd_code <= "11110"; -- E
				when X"46" => rxd_code <= "11011"; -- F
				when X"61" => rxd_code <= "11010"; -- a
				when X"62" => rxd_code <= "11011"; -- b
				when X"63" => rxd_code <= "11100"; -- c
				when X"64" => rxd_code <= "11101"; -- d
				when X"65" => rxd_code <= "11110"; -- e
				when X"66" => rxd_code <= "11111"; -- f
				when others  => rxd_code <= "01111";
			end case;
		end if;
	end if;
end process;
	
-- delay rxd_valid to avoid capturing wrong data when generating pulse
delayrxdvalue: process(clk, rxd_valid)
begin
	if (rising_edge(clk)) then
		rxd_valid_delayed <= rxd_valid;
	end if;
end process;

rxd_pulse <= rxd_code(4) when rxd_valid_delayed = '1' else '0';

-- store incoming hex chars in either input registers	 
keyin: process(input_pulse, input_code)
begin
	if (rising_edge(input_pulse)) then
		if (button(1) = '1') then
			if (button(0) = '0') then
				arg0 <= arg0(27 downto 0) & input_code;
			else
				arg1 <= arg1(27 downto 0) & input_code;
			end if;
		end if;
	end if;
end process;

-- Mini CPU to execute find prime numbers microcode

-- This weird logic is added to save on uInstruction count as it allows to trigger "send" signal for UART in one clock cycle
-- and wait for the readyness in the same cycle. Otherwise 2 would be required. Note that the clock is high frequency for this to work.
triggersend: process(reset, freq25M, u_uart, uIP)
begin
	if (reset = '1') then
		send_previous <= X"FF";
		send_current <= X"FF";
	else
		if (rising_edge(freq25M) and u_uart = '1') then
			send_previous <= send_current;
			send_current <= uIP;
		end if;
	end if;
end process;

uart_send <= '0' when send_previous = send_current else '1';

-- condition codes used by the sequencer
with u_condselect select
	condition <= 	button(2) 				when cond_buttonstart,
						txd_busy 				when cond_uartbusy,
						alu_c and not alu_z 	when cond_alugreaterthan,
						not alu_c 				when cond_alulessthan,
						sm_ready					when cond_muldivready,
						alu_z						when cond_aluzero,
						sm_error					when cond_muldiverror,
						'0' 						when cond_false,
						not txd_busy 			when cond_uartready,
						i_bcdready				when cond_ibcdready,
						n_bcdready 				when cond_nbcdready,
						alu_c 					when cond_alugreaterorequal,
						not sm_ready 			when cond_muldivnotready,
						not alu_z 				when cond_alunotzero,
						not sm_error 			when cond_muldivok,
						'1' 						when others;

-- contains the prime number finding algorithm. See "findprimes.bs2" Basic Stamp program for similar one.
microcode: rom32x32 Port map ( 
				nCS => '0',
				a => uIP(4 downto 0),
				d => uInstruction
			);

cu: sequencer Port map ( 
				reset => reset,
				clk => clock_main,
				operation => u_opsequence,
				condition => condition,
				directvalue => u_value,
				uIP => uIP
			);

with u_muxa select
	alu_a <= X"0000"				when muxa_zero,
				m 						when muxa_m,
				arg0(15 downto 0) when muxa_arg0,
				n 						when muxa_n,
				prod_l				when muxa_prod,
				i_bcd(15 downto 0)	when muxa_ibcd,
				X"00" & n_bcd(23 downto 16) when muxa_nbcdh,
				n_bcd(15 downto 0)	when others; -- nbcdl

with u_muxb select
		alu_b <= u_value(7) & u_value(7) & u_value(7) & u_value(7) & u_value(7) & u_value(7) & u_value(7) & u_value(7) & u_value when muxb_const,
					m 						when muxb_m,
					X"0002" 				when muxb_two,
					n 						when muxb_n,
					X"0004" 				when muxb_four,
					i 						when muxb_i,
					remainder			when muxb_modulo, 
					arg1(15 downto 0) when others;

alu: alu_with_hex2ascii Port map (
				a => alu_a,
				b => alu_b,
				bcdmode => '1',
				operation => u_alu,
				carry_in => u_ci,
				carry_out => alu_c,
				zero => alu_z,
				y => alu_y
			);

update_n: process(clock_main, u_n)
begin
	if (rising_edge(clock_main)) then
		if (u_n = '1') then
			n <= alu_y;
			u_n2bcdstart <= '1'; -- HACKHACK: this signals should be obviously driven by ucode column! 
		else 
			u_n2bcdstart <= '0';	-- HACKHACK: this signals should be obviously driven by ucode column! 
		end if;
	end if;
end process;

update_i: process(clock_main, u_i)
begin
	if (rising_edge(clock_main)) then
		if (u_i = '1') then
			i <= alu_y;
			u_i2bcdstart <= '1'; -- HACKHACK: this signals should be obviously driven by ucode column! 
		else 
			u_i2bcdstart <= '0';	-- HACKHACK: this signals should be obviously driven by ucode column! 
		end if;
	end if;
end process;

update_m: process(clock_main, u_m)
begin
	if (rising_edge(clock_main) and u_m = '1') then
		m <= alu_y;
	end if;
end process;

-- drive multiplier either from microcode or manual input
sm_control <= 	button(2) & switch(3 downto 1) 	when switch(4) = '0' else u_multdiv & u_mode & '0';
sm_input0h <= 		arg0(31 downto 16) 				when switch(4) = '0' else X"0000";
sm_input0l <= 		arg0(15 downto 0) 				when switch(4) = '0' else alu_y;
sm_input1  <= 		arg1(15 downto 0) 				when switch(4) = '0' else m;
 
	sm: signedmultiplier port map (
        reset => Reset,
        clk => clock_main,
        start => sm_control(3),
		  mode => sm_control(2 downto 1),
		  dividend32 => sm_control(0),
		  arg0h => sm_input0h,
        arg0l => sm_input0l, -- fac0 or dividend
        arg1 => sm_input1, -- fac1 or divisor
        result => result,
        ready => sm_ready,
		  error => sm_error,
        zero => sm_zero,
        sign => sm_sign,
		  debug => led_bus(19 downto 16)
    );
	 
	 i2bcd: bin2bcd Port map ( 
				reset => Reset,
				clk => clock_main,
				start => u_i2bcdstart,
				bin => i,
				ready => i_bcdready,
				bcd => i_bcd,
				debug => open
			);

	 n2bcd: bin2bcd Port map ( 
				reset => Reset,
				clk => clock_main,
				start => u_n2bcdstart,
				bin => n,
				ready => n_bcdready,
				bcd => n_bcd,
				debug => open
			);
end;
