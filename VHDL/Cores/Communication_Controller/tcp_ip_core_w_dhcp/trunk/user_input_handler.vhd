----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:01 10/19/2014 
-- Design Name: 
-- Module Name:    user_input_handler - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity user_input_handler is
    Port ( CLK_IN 				: in  STD_LOGIC;
           RX_IN 					: in  STD_LOGIC;
           TX_OUT 				: out  STD_LOGIC;
           
			  TEXT_ADDR_IN 		: in  STD_LOGIC_VECTOR (11 downto 0);
           TEXT_DATA_OUT 		: out STD_LOGIC_VECTOR (7 downto 0);
           FONT_ADDR_IN 		: in  STD_LOGIC_VECTOR (11 downto 0);
           FONT_DATA_OUT 		: out STD_LOGIC_VECTOR (7 downto 0);
           CURSORPOS_X_OUT 	: out STD_LOGIC_VECTOR (7 downto 0);
           CURSORPOS_Y_OUT 	: out STD_LOGIC_VECTOR (7 downto 0);
			  
			  ADDR_OUT				: out STD_LOGIC_VECTOR(7 downto 0);
			  DATA_IN				: in STD_LOGIC_VECTOR(7 downto 0);
			  
			  ETH_COMMAND_OUT			: out STD_LOGIC_VECTOR(3 downto 0);
			  ETH_COMMAND_EN_OUT		: out STD_LOGIC;
			  ETH_COMMAND_CMPLT_IN	: in STD_LOGIC;
			  ETH_COMMAND_ERR_IN		: in STD_LOGIC_VECTOR(7 downto 0);
			  
			  CLK_1HZ_IN	: in STD_LOGIC
			  
--			  DEBUG_OUT				: out STD_LOGIC_VECTOR(7 downto 0);
--			  DEBUG_OUT2			: out STD_LOGIC_VECTOR(7 downto 0)
			  );			  
end user_input_handler;

architecture Behavioral of user_input_handler is

	COMPONENT uart
	Generic (
		CLK_FREQ	: integer := 50;		-- Main frequency (MHz)
		SER_FREQ	: integer := 9600		-- Baud rate (bps)
	);
	Port (
		-- Control
		clk			: in	std_logic;							-- Main clock
		rst			: in	std_logic;							-- Main reset
		-- External Interface
		rx			: in	std_logic;								-- RS232 received serial data
		tx			: out	std_logic;								-- RS232 transmitted serial data
		-- RS232/UART Configuration
		par_en		: in	std_logic;							-- Parity bit enable
		-- uPC Interface
		tx_req		: in	std_logic;							-- Request SEND of data
		tx_end		: out	std_logic;							-- Data SENDED
		tx_data		: in	std_logic_vector(7 downto 0);	-- Data to transmit
		rx_ready		: out	std_logic;							-- Received data ready to uPC read
		rx_data		: out	std_logic_vector(7 downto 0)	-- Received data 
	);
	END COMPONENT;
	
	COMPONENT TDP_RAM
		Generic (G_DATA_A_SIZE 	:natural :=32;
					G_ADDR_A_SIZE	:natural :=9;
					G_RELATION		:natural :=3;
					G_INIT_ZERO		:boolean := true;
					G_INIT_FILE		:string :="");--log2(SIZE_A/SIZE_B)
		Port ( CLK_A_IN 	: in  STD_LOGIC;
				 WE_A_IN 	: in  STD_LOGIC;
				 ADDR_A_IN 	: in  STD_LOGIC_VECTOR (G_ADDR_A_SIZE-1 downto 0);
				 DATA_A_IN	: in  STD_LOGIC_VECTOR (G_DATA_A_SIZE-1 downto 0);
				 DATA_A_OUT	: out  STD_LOGIC_VECTOR (G_DATA_A_SIZE-1 downto 0);
				 CLK_B_IN 	: in  STD_LOGIC;
				 WE_B_IN 	: in  STD_LOGIC;
				 ADDR_B_IN 	: in  STD_LOGIC_VECTOR (G_ADDR_A_SIZE+G_RELATION-1 downto 0);
				 DATA_B_IN 	: in  STD_LOGIC_VECTOR (G_DATA_A_SIZE/(2**G_RELATION)-1 downto 0);
				 DATA_B_OUT : out STD_LOGIC_VECTOR (G_DATA_A_SIZE/(2**G_RELATION)-1 downto 0));
	END COMPONENT;

	COMPONENT FONT_MEM
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT hex_to_ascii is
    Port ( CLK_IN 			: in  STD_LOGIC;
           CONV_IN 			: in  STD_LOGIC;
           HEX_IN 			: in  STD_LOGIC_VECTOR (3 downto 0);
           ASCII_OUT 		: out  STD_LOGIC_VECTOR (7 downto 0);
           CONV_DONE_OUT 	: out  STD_LOGIC);
	END COMPONENT;
	
	COMPONENT bin_to_bcd
    Port ( CLK_IN 			: in  STD_LOGIC;
           CONV_IN 			: in  STD_LOGIC;
           BIN_IN 			: in  STD_LOGIC_VECTOR (7 downto 0);
           BCD_OUT 			: out  STD_LOGIC_VECTOR (11 downto 0);
           CONV_DONE_OUT 	: out  STD_LOGIC);
	END COMPONENT;
	
subtype slv is std_logic_vector;

constant C_backspace_cmnd 	: std_logic_vector(7 downto 0) := X"80";
constant C_esc_cmnd 			: std_logic_vector(7 downto 0) := X"81";
constant C_enter_cmnd 		: std_logic_vector(7 downto 0) := X"82";
constant C_new_line_cmnd 	: std_logic_vector(7 downto 0) := X"83";
constant C_clear_cmnd 		: std_logic_vector(7 downto 0) := X"84";
constant C_no_op_cmnd 		: std_logic_vector(7 downto 0) := X"FF";

constant C_space_char : std_logic_vector(7 downto 0) := X"20";

constant C_max_char			: std_logic_vector(11 downto 0) 	:= X"C2F"; -- 3119 (zero indexed)
constant C_page_height 		: std_logic_vector(7 downto 0) 	:= X"26"; -- 39 (zero indexed)
constant C_page_width  		: std_logic_vector(7 downto 0) 	:= X"4F"; -- 80 (zero indexed)
constant C_page_width_p1 	: std_logic_vector(7 downto 0) 	:= X"50"; -- 80

constant C_clear_command 						: std_logic_vector(15 downto 0) 	:= X"18B0";
constant C_show_network_all_command 		: std_logic_vector(15 downto 0) 	:= X"A653";
constant C_show_network_enabled_command 	: std_logic_vector(15 downto 0) 	:= X"D9A2";
constant C_show_mac_command 					: std_logic_vector(15 downto 0) 	:= X"D952";
constant C_show_ip_setting_command 			: std_logic_vector(15 downto 0) 	:= X"E2BA";
constant C_show_ip_command 					: std_logic_vector(15 downto 0) 	:= X"6C54";
constant C_show_cloud_ip_command 			: std_logic_vector(15 downto 0) 	:= X"413F";
constant C_show_tcp_port_command 			: std_logic_vector(15 downto 0) 	:= X"46C3";
constant C_show_ping_enabled_command 		: std_logic_vector(15 downto 0) 	:= X"95B0";
constant C_set_network_init_command 		: std_logic_vector(15 downto 0) 	:= X"1853";
constant C_connect_local_command 			: std_logic_vector(15 downto 0) 	:= X"00FE";
constant C_connect_cloud_command 			: std_logic_vector(15 downto 0) 	:= X"004C";

signal C_net_enabled_message_addr 	: std_logic_vector(8 downto 0) := '0'&X"00";
signal C_mac_message_addr 				: std_logic_vector(8 downto 0) := '0'&X"16";
signal C_show_ip_setting_addr			: std_logic_vector(8 downto 0) := '0'&X"25";
signal C_show_ip_addr 					: std_logic_vector(8 downto 0) := '0'&X"33";
signal C_show_cloud_ip_addr			: std_logic_vector(8 downto 0) := '0'&X"41";
signal C_local_connect_addr			: std_logic_vector(8 downto 0) := '0'&X"8B";
signal C_cloud_connect_addr			: std_logic_vector(8 downto 0) := '0'&X"9C";
signal C_unknown_messge_addr 			: std_logic_vector(8 downto 0) := '1'&X"00";
signal C_true_message_addr 			: std_logic_vector(8 downto 0) := '1'&X"14";
signal C_false_message_addr 			: std_logic_vector(8 downto 0) := '1'&X"19";
signal C_success_message_addr 		: std_logic_vector(8 downto 0) := '1'&X"1F";
signal C_failed_message_addr 			: std_logic_vector(8 downto 0) := '1'&X"27";
signal C_dynamic_addr 					: std_logic_vector(8 downto 0) := '1'&X"2E";
signal C_static_addr 					: std_logic_vector(8 downto 0) := '1'&X"36";

signal C_end_of_message_char : std_logic_vector(7 downto 0) := X"FF";

type SLV_BYTE_ARRAY16 is array (0 to 15) of std_logic_vector(7 downto 0);
constant prompt_array_inst : SLV_BYTE_ARRAY16 := ( X"20", X"76", X"61", X"75", X"6C", X"74", X"7E", X"24",
																	 X"20", X"20", X"20", X"20", X"20", X"20", X"20", X"20");
constant C_prompt_array_length : std_logic_vector(3 downto 0) := "1001";
signal prompt_ram_index : unsigned(3 downto 0) := (others => '0');

signal startup_count : unsigned(27 downto 0) := X"17D7840"; -- 1 sec @ 25 MHz

signal char_buf_wr, char_cmd_wr : std_logic := '0';
signal char_buf_wr_addr : unsigned(11 downto 0) := (others => '0');
signal char_buf_wr_data : std_logic_vector(7 downto 0) := (others => '0');
signal ocrx, ocry : unsigned(7 downto 0) := (others => '0');
signal char_buf_x_coord : unsigned(7 downto 0);
signal debug2 : unsigned(7 downto 0) := (others => '0');
signal show_ip_start_addr : std_logic_vector(7 downto 0) := (others => '0');

signal keyboard_data, keyboard_data_buf : std_logic_vector(7 downto 0) := (others => '0');
signal keyboard_rd, handle_backspace, handle_enter : std_logic := '0';

type SLV_BYTE_ARRAY32 is array (0 to 31) of std_logic_vector(7 downto 0);
signal command_ram_inst : SLV_BYTE_ARRAY32 := (others => (others => '0'));
signal command_ram_index, command_ram_index_max : unsigned(4 downto 0) := (others => '0');
signal command_hash : unsigned(15 downto 0) := (others => '0');

signal screen_wr_buf_byte, screen_rd_buf_byte : std_logic_vector(7 downto 0);
signal screen_wr_buffer_index : unsigned(4 downto 0) := (others => '0');
signal screen_buf_we : std_logic := '0';
signal screen_rd_buffer_index : unsigned(4 downto 0) := (others => '0');
signal screen_msg_addr : unsigned(8 downto 0) := (others => '0');
signal screen_msg_char : std_logic_vector(7 downto 0);

signal networking_enabled, dhcp_enabled : std_logic := '0';

signal eth_command : std_logic_vector(3 downto 0) := X"0";
signal eth_command_en, eth_command_cmplt : std_logic := '0';
signal eth_command_err : std_logic_vector(7 downto 0);

signal hex_conv, hex_conv_done : std_logic := '0';
signal hex_val : std_logic_vector(3 downto 0) := X"0";
signal ascii_val : std_logic_vector(7 downto 0) := X"00";
signal addr : unsigned(7 downto 0);

signal bcd_conv, bcd_conv_done : std_logic := '0';
signal bin_val : std_logic_vector(7 downto 0) := (others => '0');
signal bcd_val : std_logic_vector(11 downto 0) := (others => '0');

signal clk_1hz : std_logic := '0';
signal dhcp_second_count, tcp_second_count : unsigned(3 downto 0);

type HANDLE_KEYBOARD_ST is (	STARTUP_DELAY,
										PRINT_COMMAND_PROMPT0,
										PRINT_COMMAND_PROMPT1,
										PRINT_COMMAND_PROMPT2,
										IDLE,
										PARSE_KEY_PRESSED,
										HANDLE_KEY_PRESSED0,
										HANDLE_KEY_PRESSED1,
										HANDLE_COMMAND,
										HANDLE_BACKSPACE0,
										HANDLE_BACKSPACE1,
										HANDLE_BACKSPACE2,
										HANDLE_BACKSPACE3,
										HANDLE_BACKSPACE4,
										HANDLE_COMMAND_SUBMIT0,
										HANDLE_COMMAND_SUBMIT1,
										HANDLE_COMMAND_SUBMIT2,
										HANDLE_COMMAND_SUBMIT3,
										HANDLE_COMMAND_SUBMIT4,
										NEW_LINE_W_NEW_PROMPT0,
										NEW_LINE_W_NEW_PROMPT1,
										REPORT_UNKNOWN_COMMAND1,
										REPORT_UNKNOWN_COMMAND2,
										REPORT_UNKNOWN_COMMAND3,
										REPORT_UNKNOWN_COMMAND4,
										HANDLE_CLEAR_COMMAND0,
										HANDLE_CLEAR_COMMAND1,
										HANDLE_NETWORK_INIT_COMMAND0,
										HANDLE_NETWORK_INIT_COMMAND1,
										HANDLE_NETWORK_ENABLED_COMMAND0,
										HANDLE_NETWORK_ENABLED_COMMAND1,
										HANDLE_NETWORK_ENABLED_COMMAND2,
										HANDLE_NETWORK_ENABLED_COMMAND3,
										HANDLE_NETWORK_ENABLED_COMMAND4,
										HANDLE_NETWORK_ENABLED_COMMAND5,
										HANDLE_SHOW_MAC_COMMAND0,
										HANDLE_SHOW_MAC_COMMAND1,
										HANDLE_SHOW_MAC_COMMAND2,
										HANDLE_SHOW_MAC_COMMAND3,
										HANDLE_SHOW_MAC_COMMAND4,
										HANDLE_SHOW_MAC_COMMAND5,
										HANDLE_SHOW_MAC_COMMAND6,
										HANDLE_SHOW_MAC_COMMAND7,
										HANDLE_SHOW_MAC_COMMAND8,
										HANDLE_SHOW_MY_IP_COMMAND,
										HANDLE_SHOW_CLOUD_IP_COMMAND,
										HANDLE_SHOW_IP_COMMAND0,
										HANDLE_SHOW_IP_COMMAND1,
										HANDLE_SHOW_IP_COMMAND2,
										HANDLE_SHOW_IP_COMMAND3,
										HANDLE_SHOW_IP_COMMAND4,
										HANDLE_SHOW_IP_COMMAND5,
										HANDLE_SHOW_IP_COMMAND6,
										HANDLE_SHOW_IP_COMMAND7,
										HANDLE_SHOW_IP_COMMAND8,
										HANDLE_SHOW_IP_COMMAND9,
										HANDLE_SHOW_IP_SETTING_COMMAND0,
										HANDLE_SHOW_IP_SETTING_COMMAND1,
										HANDLE_SHOW_IP_SETTING_COMMAND2,
										HANDLE_SHOW_IP_SETTING_COMMAND3,
										HANDLE_SHOW_IP_SETTING_COMMAND4,
										HANDLE_SHOW_IP_SETTING_COMMAND5,
										HANDLE_CONNECT_LOCAL0,
										HANDLE_CONNECT_LOCAL1,
										HANDLE_CONNECT_LOCAL2,
										HANDLE_CONNECT_LOCAL3,
										HANDLE_CONNECT_CLOUD_COMMAND0,
										HANDLE_CONNECT_CLOUD_COMMAND1,
										HANDLE_CONNECT_CLOUD_COMMAND2,
										HANDLE_CONNECT_CLOUD_COMMAND3,
										HANDLE_CONNECT_CLOUD_COMMAND4,
										HANDLE_CONNECT_CLOUD_COMMAND5,
										CONNECT_DHCP_COMMAND0,
										CONNECT_DHCP_COMMAND1,
										CONNECT_DHCP_COMMAND2,
										CONNECT_DHCP_COMMAND3,
										CONNECT_DHCP_COMMAND4,
										CONNECT_DHCP_COMMAND5,
										CONNECT_DHCP_COMMAND6,
										CONNECT_DHCP_COMMAND7,
										CANCEL_DHCP_CONNECT0,
										CONNECT_STATIC_COMMAND0,
										CONNECT_STATIC_COMMAND1,
										PRINT_COMMAND_RESULT0,
										PRINT_COMMAND_RESULT1);
										
signal hk_state, hk_next_state, hk_prev_state, hk_cached_state : HANDLE_KEYBOARD_ST := STARTUP_DELAY;

type SCREEN_BUF_ST is (		SB_IDLE,
									SB_PARSE_NEW_BYTE,
									SB_HANDLE_CHARACTER0,
									SB_HANDLE_CHARACTER1,
									SB_HANDLE_COMMAND,
									SB_HANDLE_BACKSPACE,
									SB_HANDLE_NEW_LINE,
									SB_HANDLE_CLEAR);

signal sb_state, sb_next_state : SCREEN_BUF_ST := SB_IDLE;

begin

	clk_1hz <= CLK_1HZ_IN;

--	DEBUG_OUT <= slv(command_hash(15 downto 8));
--	DEBUG_OUT2 <= slv(command_hash(7 downto 0));

	---- CONVERT UART DATA TO KEYBOARD DATA ----

	uart_inst : uart
	GENERIC MAP (
		CLK_FREQ	=> 25,
		SER_FREQ	=> 9600)
	Port Map (
		clk		=> CLK_IN,
		rst		=> '0',
		rx			=> RX_IN,
		tx			=> TX_OUT,
		par_en	=> '1',
		tx_req	=> '0',
		tx_end	=> open,
		tx_data	=> (others => '0'),
		rx_ready	=> keyboard_rd,
		rx_data	=> keyboard_data);

	---- HANDLE KEYBOARD DATA ----

   HK_SYNC_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			hk_state <= hk_next_state;
			hk_prev_state <= hk_state;
			startup_count <= startup_count - 1;
      end if;
   end process;
	
	HK_NEXT_STATE_DECODE: process (hk_state, startup_count, handle_backspace, keyboard_rd, prompt_ram_index, keyboard_data,
												command_ram_index, command_ram_index_max, command_hash, DATA_IN, dhcp_enabled, clk_1hz, dhcp_second_count, 
													tcp_second_count, bcd_conv_done, addr, hex_conv_done, networking_enabled, screen_msg_char, C_end_of_message_char, 
														hk_cached_state)
   begin
      hk_next_state <= hk_state;  --default is to stay in current state
      case (hk_state) is
			when STARTUP_DELAY =>
				if startup_count = X"00000000" then
					hk_next_state <= PRINT_COMMAND_PROMPT0;
				end if;
			when PRINT_COMMAND_PROMPT0 =>
				hk_next_state <= PRINT_COMMAND_PROMPT1;
			when PRINT_COMMAND_PROMPT1 =>
				hk_next_state <= PRINT_COMMAND_PROMPT2;
			when PRINT_COMMAND_PROMPT2 =>
				if prompt_ram_index = unsigned(C_prompt_array_length) then
					hk_next_state <= IDLE;
				else
					hk_next_state <= PRINT_COMMAND_PROMPT1;
				end if;
         
			when IDLE =>
				if keyboard_rd = '1' then
					hk_next_state <= PARSE_KEY_PRESSED;
				end if;
			when PARSE_KEY_PRESSED =>
				if keyboard_data(7) = '0' then
					hk_next_state <= HANDLE_KEY_PRESSED0;
				else
					hk_next_state <= HANDLE_COMMAND;
				end if;
				
			when HANDLE_KEY_PRESSED0 =>
				hk_next_state <= HANDLE_KEY_PRESSED1;
			when HANDLE_KEY_PRESSED1 =>			
				hk_next_state <= IDLE;
			
			when HANDLE_COMMAND =>
				if keyboard_data = C_backspace_cmnd then
					hk_next_state <= HANDLE_BACKSPACE0;
				elsif keyboard_data = C_enter_cmnd then
					if command_ram_index = "00000" then 
						hk_next_state <= NEW_LINE_W_NEW_PROMPT0;
					else
						hk_next_state <= HANDLE_COMMAND_SUBMIT0;
					end if;
				else
					hk_next_state <= IDLE;
				end if;
			
			when HANDLE_BACKSPACE0 =>
				if command_ram_index = "00000" then
					hk_next_state <= IDLE;
				else
					hk_next_state <= HANDLE_BACKSPACE1;
				end if;
			when HANDLE_BACKSPACE1 =>
				hk_next_state <= HANDLE_BACKSPACE2;
			when HANDLE_BACKSPACE2 =>
				hk_next_state <= HANDLE_BACKSPACE3;
			when HANDLE_BACKSPACE3 =>
				hk_next_state <= HANDLE_BACKSPACE4;
			when HANDLE_BACKSPACE4 =>
				hk_next_state <= IDLE;
				
			when HANDLE_COMMAND_SUBMIT0 =>
				hk_next_state <= HANDLE_COMMAND_SUBMIT1;
			when HANDLE_COMMAND_SUBMIT1 =>
				hk_next_state <= HANDLE_COMMAND_SUBMIT2;
			when HANDLE_COMMAND_SUBMIT2 =>
				if command_ram_index = command_ram_index_max then
					hk_next_state <= HANDLE_COMMAND_SUBMIT3;
				else
					hk_next_state <= HANDLE_COMMAND_SUBMIT1;
				end if;
			when HANDLE_COMMAND_SUBMIT3 =>
				hk_next_state <= HANDLE_COMMAND_SUBMIT4;
			when HANDLE_COMMAND_SUBMIT4 =>
				if command_hash = unsigned(C_clear_command) then
					hk_next_state <= HANDLE_CLEAR_COMMAND0;
				elsif command_hash = unsigned(C_show_network_enabled_command) then
					hk_next_state <= HANDLE_NETWORK_ENABLED_COMMAND0;
				elsif command_hash = unsigned(C_set_network_init_command) then
					hk_next_state <= HANDLE_NETWORK_INIT_COMMAND0;
				elsif command_hash = unsigned(C_show_mac_command) then
					hk_next_state <= HANDLE_SHOW_MAC_COMMAND0;
				elsif command_hash = unsigned(C_connect_local_command) then
					hk_next_state <= HANDLE_CONNECT_LOCAL0;
				elsif command_hash = unsigned(C_show_ip_command) then
					hk_next_state <= HANDLE_SHOW_MY_IP_COMMAND;
				elsif command_hash = unsigned(C_show_ip_setting_command) then
					hk_next_state <= HANDLE_SHOW_IP_SETTING_COMMAND0;
				elsif command_hash = unsigned(C_show_cloud_ip_command) then
					hk_next_state <= HANDLE_SHOW_CLOUD_IP_COMMAND;
				elsif command_hash = unsigned(C_connect_cloud_command) then
					hk_next_state <= HANDLE_CONNECT_CLOUD_COMMAND0;
				else
					hk_next_state <= REPORT_UNKNOWN_COMMAND1;
				end if;
			
			when HANDLE_SHOW_IP_SETTING_COMMAND0 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache HANDLE_SHOW_IP_SETTING_COMMAND1
			when HANDLE_SHOW_IP_SETTING_COMMAND1 =>
				hk_next_state <= HANDLE_SHOW_IP_SETTING_COMMAND2;
			when HANDLE_SHOW_IP_SETTING_COMMAND2 =>
				hk_next_state <= HANDLE_SHOW_IP_SETTING_COMMAND3;
			when HANDLE_SHOW_IP_SETTING_COMMAND3 =>
				if DATA_IN(0) = '1' then
					hk_next_state <= HANDLE_SHOW_IP_SETTING_COMMAND4;
				else
					hk_next_state <= HANDLE_SHOW_IP_SETTING_COMMAND5;
				end if;
			when HANDLE_SHOW_IP_SETTING_COMMAND4 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache NEW_LINE_W_NEW_PROMPT0
			when HANDLE_SHOW_IP_SETTING_COMMAND5 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache NEW_LINE_W_NEW_PROMPT0
			
			when HANDLE_CONNECT_LOCAL0 =>
				hk_next_state <= HANDLE_CONNECT_LOCAL1;
			when HANDLE_CONNECT_LOCAL1 =>
				hk_next_state <= HANDLE_CONNECT_LOCAL2;
			when HANDLE_CONNECT_LOCAL2 =>
				hk_next_state <= HANDLE_CONNECT_LOCAL3;
			when HANDLE_CONNECT_LOCAL3 =>
				if dhcp_enabled = '1' then
					hk_next_state <= CONNECT_DHCP_COMMAND0;
				else
					hk_next_state <= CONNECT_STATIC_COMMAND0;
				end if;
			
			when CONNECT_DHCP_COMMAND0 =>
				hk_next_state <= CONNECT_DHCP_COMMAND1;
			when CONNECT_DHCP_COMMAND1 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache CONNECT_DHCP_COMMAND2
				
			when CONNECT_DHCP_COMMAND2 => -- TODO RENAME!
				if clk_1hz = '1' then
					hk_next_state <= CONNECT_DHCP_COMMAND3;
				end if;
			when CONNECT_DHCP_COMMAND3 =>
				hk_next_state <= CONNECT_DHCP_COMMAND4;
			when CONNECT_DHCP_COMMAND4 =>
				hk_next_state <= CONNECT_DHCP_COMMAND5;
			when CONNECT_DHCP_COMMAND5 =>
				if DATA_IN(0) = '1' or DATA_IN(1) = '1' then
					hk_next_state <= CONNECT_DHCP_COMMAND6;
				elsif dhcp_second_count > X"9" then
					hk_next_state <= CANCEL_DHCP_CONNECT0;
				else
					hk_next_state <= CONNECT_DHCP_COMMAND2;
				end if;
			when CONNECT_DHCP_COMMAND6 => -- RENAME TO "PRINT SUCCESS"
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache NEW_LINE_W_NEW_PROMPT0
			when CONNECT_DHCP_COMMAND7 => -- RENAME TO "PRINT FAILED"
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache NEW_LINE_W_NEW_PROMPT0
			
			when CANCEL_DHCP_CONNECT0 =>
				hk_next_state <= CONNECT_DHCP_COMMAND7;
			
			when CONNECT_STATIC_COMMAND0 =>
				hk_next_state <= CONNECT_STATIC_COMMAND1; -- TODO REMOVE REDUNDANT STATE?
			when CONNECT_STATIC_COMMAND1 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache CONNECT_DHCP_COMMAND2
			
			when HANDLE_CONNECT_CLOUD_COMMAND0 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache HANDLE_CONNECT_CLOUD_COMMAND1;
			when HANDLE_CONNECT_CLOUD_COMMAND1 =>
				if clk_1hz = '1' then
					hk_next_state <= HANDLE_CONNECT_CLOUD_COMMAND2;
				end if;
			when HANDLE_CONNECT_CLOUD_COMMAND2 =>
				hk_next_state <= HANDLE_CONNECT_CLOUD_COMMAND3;
			when HANDLE_CONNECT_CLOUD_COMMAND3 =>
				hk_next_state <= HANDLE_CONNECT_CLOUD_COMMAND4;
			when HANDLE_CONNECT_CLOUD_COMMAND4 =>
				if DATA_IN(0) = '1' then
					hk_next_state <= CONNECT_DHCP_COMMAND6;
				elsif tcp_second_count > X"9" then
					hk_next_state <= HANDLE_CONNECT_CLOUD_COMMAND5;
				else
					hk_next_state <= HANDLE_CONNECT_CLOUD_COMMAND1;
				end if;
			when HANDLE_CONNECT_CLOUD_COMMAND5 =>
				hk_next_state <= CONNECT_DHCP_COMMAND7;
			
			when HANDLE_SHOW_CLOUD_IP_COMMAND =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND0;
			when HANDLE_SHOW_MY_IP_COMMAND =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND0;
			
			when HANDLE_SHOW_IP_COMMAND0 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache HANDLE_SHOW_IP_COMMAND1
			when HANDLE_SHOW_IP_COMMAND1 =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND2;
			when HANDLE_SHOW_IP_COMMAND2 =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND3;
			when HANDLE_SHOW_IP_COMMAND3 =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND4;
			when HANDLE_SHOW_IP_COMMAND4 =>
				if bcd_conv_done = '1' then
					hk_next_state <= HANDLE_SHOW_IP_COMMAND5;
				end if;
			when HANDLE_SHOW_IP_COMMAND5 =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND6;
			when HANDLE_SHOW_IP_COMMAND6 =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND7;
			when HANDLE_SHOW_IP_COMMAND7 =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND8;
			when HANDLE_SHOW_IP_COMMAND8 =>
				if addr = X"0C" or addr = X"10" then
					hk_next_state <= NEW_LINE_W_NEW_PROMPT0;
				else
					hk_next_state <= HANDLE_SHOW_IP_COMMAND9;
				end if;
			when HANDLE_SHOW_IP_COMMAND9 =>
				hk_next_state <= HANDLE_SHOW_IP_COMMAND2;
			
			when HANDLE_CLEAR_COMMAND0 =>
				hk_next_state <= HANDLE_CLEAR_COMMAND1;
			when HANDLE_CLEAR_COMMAND1 =>
				hk_next_state <= PRINT_COMMAND_PROMPT0;
				
			when HANDLE_NETWORK_INIT_COMMAND0 =>
				hk_next_state <= HANDLE_NETWORK_INIT_COMMAND1;
			when HANDLE_NETWORK_INIT_COMMAND1 =>
				hk_next_state <= PRINT_COMMAND_PROMPT0;
			
			when HANDLE_SHOW_MAC_COMMAND0 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache HANDLE_SHOW_MAC_COMMAND1
			when HANDLE_SHOW_MAC_COMMAND1 =>
				hk_next_state <= HANDLE_SHOW_MAC_COMMAND2;
			when HANDLE_SHOW_MAC_COMMAND2 =>
				hk_next_state <= HANDLE_SHOW_MAC_COMMAND3;
			when HANDLE_SHOW_MAC_COMMAND3 =>
				hk_next_state <= HANDLE_SHOW_MAC_COMMAND4;
			when HANDLE_SHOW_MAC_COMMAND4 =>
				if hex_conv_done = '1' then
					hk_next_state <= HANDLE_SHOW_MAC_COMMAND5;
				end if;
			when HANDLE_SHOW_MAC_COMMAND5 =>
				hk_next_state <= HANDLE_SHOW_MAC_COMMAND6;
			when HANDLE_SHOW_MAC_COMMAND6 =>
				if hex_conv_done = '1' then
					hk_next_state <= HANDLE_SHOW_MAC_COMMAND7;
				end if;
			when HANDLE_SHOW_MAC_COMMAND7 =>
				if addr > X"05" then
					hk_next_state <= NEW_LINE_W_NEW_PROMPT0;
				else
					hk_next_state <= HANDLE_SHOW_MAC_COMMAND8;
				end if;
			when HANDLE_SHOW_MAC_COMMAND8 =>	
				hk_next_state <= HANDLE_SHOW_MAC_COMMAND2;
			
			when HANDLE_NETWORK_ENABLED_COMMAND0 =>
				hk_next_state <= HANDLE_NETWORK_ENABLED_COMMAND1;
			when HANDLE_NETWORK_ENABLED_COMMAND1 =>
				hk_next_state <= HANDLE_NETWORK_ENABLED_COMMAND2;
			when HANDLE_NETWORK_ENABLED_COMMAND2 =>
				hk_next_state <= PRINT_COMMAND_RESULT0; -- cache HANDLE_NETWORK_ENABLED_COMMAND3
			when HANDLE_NETWORK_ENABLED_COMMAND3 =>
				if networking_enabled = '1' then
					hk_next_state <= HANDLE_NETWORK_ENABLED_COMMAND4;
				else
					hk_next_state <= HANDLE_NETWORK_ENABLED_COMMAND5;
				end if;
			when HANDLE_NETWORK_ENABLED_COMMAND4 =>
				hk_next_state <= PRINT_COMMAND_RESULT0;
			when HANDLE_NETWORK_ENABLED_COMMAND5 =>
				hk_next_state <= PRINT_COMMAND_RESULT0;
			
			when NEW_LINE_W_NEW_PROMPT0 =>
				hk_next_state <= NEW_LINE_W_NEW_PROMPT1;
			when NEW_LINE_W_NEW_PROMPT1 =>
				hk_next_state <= PRINT_COMMAND_PROMPT0;

			when REPORT_UNKNOWN_COMMAND1 =>
				hk_next_state <= REPORT_UNKNOWN_COMMAND2;
			when REPORT_UNKNOWN_COMMAND2 =>
				hk_next_state <= REPORT_UNKNOWN_COMMAND3;
			when REPORT_UNKNOWN_COMMAND3 =>
				if command_ram_index = command_ram_index_max then
					hk_next_state <= REPORT_UNKNOWN_COMMAND4;
				else
					hk_next_state <= REPORT_UNKNOWN_COMMAND2;
				end if;
			when REPORT_UNKNOWN_COMMAND4 =>
				hk_next_state <= PRINT_COMMAND_RESULT0;
			
			when PRINT_COMMAND_RESULT0 =>
				hk_next_state <= PRINT_COMMAND_RESULT1;
			when PRINT_COMMAND_RESULT1 =>
				if screen_msg_char = C_end_of_message_char then
					hk_next_state <= hk_cached_state;
				else
					hk_next_state <= PRINT_COMMAND_RESULT1;
				end if;
				
		end case;
	end process;

	process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if hk_state = PRINT_COMMAND_PROMPT0 then
				prompt_ram_index <= X"0";
			elsif hk_state = PRINT_COMMAND_PROMPT1 then
				prompt_ram_index <= prompt_ram_index + 1;
			end if;
		end if;
	end process;
	
	process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if hk_state = PRINT_COMMAND_PROMPT1 then
				screen_wr_buf_byte <= prompt_array_inst(to_integer(prompt_ram_index));
			elsif hk_state = HANDLE_KEY_PRESSED0 then
				screen_wr_buf_byte <= keyboard_data;
			elsif hk_state = HANDLE_BACKSPACE1 then
				screen_wr_buf_byte <= C_backspace_cmnd;
			elsif hk_state = HANDLE_BACKSPACE2 then
				screen_wr_buf_byte <= X"20";
			elsif hk_state = HANDLE_BACKSPACE3 then
				screen_wr_buf_byte <= C_backspace_cmnd;
			elsif hk_state = NEW_LINE_W_NEW_PROMPT0 then
				screen_wr_buf_byte <= C_new_line_cmnd;
			elsif hk_state = HANDLE_COMMAND_SUBMIT3 then
				screen_wr_buf_byte <= C_new_line_cmnd;
			elsif hk_state = REPORT_UNKNOWN_COMMAND2 then
				screen_wr_buf_byte <= command_ram_inst(to_integer(command_ram_index));
			elsif hk_state = PRINT_COMMAND_RESULT1 then
				screen_wr_buf_byte <= screen_msg_char;
			elsif hk_state = HANDLE_CLEAR_COMMAND0 then
				screen_wr_buf_byte <= C_clear_cmnd;
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND5 then
				screen_wr_buf_byte <= ascii_val;
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND7 then
				screen_wr_buf_byte <= ascii_val;
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND8 then
				screen_wr_buf_byte <= X"3A";
			elsif hk_state = CONNECT_DHCP_COMMAND3 then
				screen_wr_buf_byte <= X"2E";
			elsif hk_state = HANDLE_SHOW_IP_COMMAND5 then
				screen_wr_buf_byte <= X"3"&bcd_val(11 downto 8);
			elsif hk_state = HANDLE_SHOW_IP_COMMAND6 then
				screen_wr_buf_byte <= X"3"&bcd_val(7 downto 4);
			elsif hk_state = HANDLE_SHOW_IP_COMMAND7 then
				screen_wr_buf_byte <= X"3"&bcd_val(3 downto 0);
			elsif hk_state = HANDLE_SHOW_IP_COMMAND9 then
				screen_wr_buf_byte <= X"2E";
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND2 then
				screen_wr_buf_byte <= X"2E";
			end if;
			if hk_prev_state = PRINT_COMMAND_PROMPT1 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_KEY_PRESSED0 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_BACKSPACE1 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_BACKSPACE2 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_BACKSPACE3 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = NEW_LINE_W_NEW_PROMPT0 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_COMMAND_SUBMIT3 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = REPORT_UNKNOWN_COMMAND2 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = PRINT_COMMAND_RESULT1 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_CLEAR_COMMAND0 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_SHOW_MAC_COMMAND5 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_SHOW_MAC_COMMAND7 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_SHOW_MAC_COMMAND8 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = CONNECT_DHCP_COMMAND3 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_SHOW_IP_COMMAND5 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_SHOW_IP_COMMAND6 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_SHOW_IP_COMMAND7 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_SHOW_IP_COMMAND9 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			elsif hk_prev_state = HANDLE_CONNECT_CLOUD_COMMAND2 then
				screen_wr_buffer_index <= screen_wr_buffer_index + 1;
			end if;
			if hk_state = PRINT_COMMAND_PROMPT1 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_KEY_PRESSED0 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_BACKSPACE1 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_BACKSPACE2 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_BACKSPACE3 then
				screen_buf_we <= '1';
			elsif hk_state = NEW_LINE_W_NEW_PROMPT0 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_COMMAND_SUBMIT3 then
				screen_buf_we <= '1';
			elsif hk_state = REPORT_UNKNOWN_COMMAND2 then
				screen_buf_we <= '1';
			elsif hk_state = PRINT_COMMAND_RESULT1 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_CLEAR_COMMAND0 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND5 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND7 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND8 then
				screen_buf_we <= '1';
			elsif hk_state = CONNECT_DHCP_COMMAND3 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_SHOW_IP_COMMAND5 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_SHOW_IP_COMMAND6 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_SHOW_IP_COMMAND7 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_SHOW_IP_COMMAND9 then
				screen_buf_we <= '1';
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND2 then
				screen_buf_we <= '1';
			else
				screen_buf_we <= '0';
			end if;
		end if;
	end process;
	
	process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if hk_state = HANDLE_KEY_PRESSED0 then
				command_ram_inst(to_integer(command_ram_index)) <= keyboard_data;
			end if;
			if hk_state = HANDLE_KEY_PRESSED0 then
				command_ram_index <= command_ram_index + 1;
			elsif hk_state = HANDLE_BACKSPACE1 then
				command_ram_index <= command_ram_index - 1;
			elsif hk_state = HANDLE_COMMAND_SUBMIT0 then
				command_ram_index <= "00000";
			elsif hk_state = HANDLE_COMMAND_SUBMIT1 then
				command_ram_index <= command_ram_index + 1;
			elsif hk_state = HANDLE_COMMAND_SUBMIT3 then
				command_ram_index <= "00000";
			elsif hk_state = REPORT_UNKNOWN_COMMAND1 then
				command_ram_index <= "00000";
			elsif hk_state = REPORT_UNKNOWN_COMMAND2 then
				command_ram_index <= command_ram_index + 1;
			elsif hk_state = REPORT_UNKNOWN_COMMAND4 then
				command_ram_index <= "00000";
			end if;
			if hk_state = HANDLE_COMMAND_SUBMIT0 then
				command_ram_index_max <= command_ram_index;
			end if;
			if hk_state = HANDLE_COMMAND_SUBMIT0 then
				command_hash <= (others => '0');
			elsif hk_state = HANDLE_COMMAND_SUBMIT1 then
				command_hash <= command_hash + RESIZE(unsigned(command_ram_inst(to_integer(command_ram_index))), 16);
			elsif hk_state = HANDLE_COMMAND_SUBMIT2 then
				command_hash(15 downto 1) <= command_hash(14 downto 0);
				command_hash(0) <= command_hash(15);
			end if;
		end if;
	end process;
	
	screen_buffer : TDP_RAM
	Generic Map ( G_DATA_A_SIZE 	=> screen_wr_buf_byte'length,
					  G_ADDR_A_SIZE	=> screen_wr_buffer_index'length,
					  G_RELATION		=> 0, --log2(SIZE_A/SIZE_B)
					  G_INIT_ZERO		=> false,
					  G_INIT_FILE		=> "./coe_dir/ascii_space.coe")
   Port Map ( CLK_A_IN 		=> CLK_IN,
				  WE_A_IN 		=> screen_buf_we,
				  ADDR_A_IN 	=> slv(screen_wr_buffer_index),
				  DATA_A_IN		=> screen_wr_buf_byte,
				  DATA_A_OUT	=> open,
				  CLK_B_IN 		=> CLK_IN,
				  WE_B_IN 		=> '0',
				  ADDR_B_IN 	=> slv(screen_rd_buffer_index),
				  DATA_B_IN 	=> X"00",
				  DATA_B_OUT 	=> screen_rd_buf_byte);

	---- SCREEN MEMORY ----

   SB_SYNC_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			sb_state <= sb_next_state;
      end if;
   end process;

   SB_NEXT_STATE_DECODE: process (sb_state, screen_rd_buffer_index, screen_wr_buffer_index, screen_rd_buf_byte, char_buf_wr_addr)
   begin
      sb_next_state <= sb_state;  --default is to stay in current state
      case (sb_state) is
         when SB_IDLE =>
            if screen_rd_buffer_index /= screen_wr_buffer_index then
					sb_next_state <= SB_PARSE_NEW_BYTE;
				end if;
				
			when SB_PARSE_NEW_BYTE =>
				if screen_rd_buf_byte(7) = '0' then
					sb_next_state <= SB_HANDLE_CHARACTER0;
				else
					sb_next_state <= SB_HANDLE_COMMAND;
				end if;
         
			when SB_HANDLE_CHARACTER0 =>
            sb_next_state <= SB_HANDLE_CHARACTER1;
			when SB_HANDLE_CHARACTER1 =>
            sb_next_state <= SB_IDLE;
				
         when SB_HANDLE_COMMAND =>
				if screen_rd_buf_byte = C_backspace_cmnd then
					sb_next_state <= SB_HANDLE_BACKSPACE;
				elsif screen_rd_buf_byte = C_new_line_cmnd then
					sb_next_state <= SB_HANDLE_NEW_LINE;
				elsif screen_rd_buf_byte = C_clear_cmnd then
					sb_next_state <= SB_HANDLE_CLEAR;
				else
					sb_next_state <= SB_IDLE;
				end if;
				
			when SB_HANDLE_BACKSPACE =>
				sb_next_state <= SB_IDLE;
         when SB_HANDLE_NEW_LINE =>
				sb_next_state <= SB_IDLE;
			when SB_HANDLE_CLEAR =>
				if char_buf_wr_addr = X"001" then
					sb_next_state <= SB_IDLE;
				end if;
				
      end case;
   end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if sb_state = SB_HANDLE_CHARACTER0 then
				char_buf_wr <= '1';
			elsif sb_state = SB_HANDLE_CLEAR then
				char_buf_wr <= '1';
			else
				char_buf_wr <= '0';
			end if;
			if sb_state = SB_HANDLE_CHARACTER0 then
				char_buf_wr_data <= screen_rd_buf_byte;
			elsif sb_state = SB_HANDLE_CLEAR then
				char_buf_wr_data <= X"20";
			end if;
			if sb_state = SB_HANDLE_CHARACTER0 then
				screen_rd_buffer_index <= screen_rd_buffer_index + 1;
			elsif sb_state = SB_HANDLE_COMMAND then
				screen_rd_buffer_index <= screen_rd_buffer_index + 1;
			end if;
			char_buf_x_coord <= unsigned(C_page_width_p1) - unsigned(ocrx);
			if sb_state = SB_HANDLE_CHARACTER1 then
				char_buf_wr_addr <= char_buf_wr_addr + 1;
			elsif sb_state = SB_HANDLE_BACKSPACE then
				char_buf_wr_addr <= char_buf_wr_addr - 1;
			elsif sb_state = SB_HANDLE_CLEAR then
				char_buf_wr_addr <= char_buf_wr_addr - 1;
			elsif sb_state = SB_HANDLE_NEW_LINE then
				char_buf_wr_addr <= char_buf_wr_addr + RESIZE(char_buf_x_coord, 12);
			end if;
		end if;
	end process;

	char_buf : TDP_RAM
	Generic Map ( G_DATA_A_SIZE 	=> TEXT_DATA_OUT'length,
					  G_ADDR_A_SIZE	=> TEXT_ADDR_IN'length,
					  G_RELATION		=> 0, --log2(SIZE_A/SIZE_B)
					  G_INIT_ZERO		=> false,
					  G_INIT_FILE		=> "./coe_dir/ascii_space.coe")
   Port Map ( CLK_A_IN 		=> CLK_IN,
				  WE_A_IN 		=> '0',
				  ADDR_A_IN 	=> TEXT_ADDR_IN,
				  DATA_A_IN		=> X"00",
				  DATA_A_OUT	=> TEXT_DATA_OUT,
				  CLK_B_IN 		=> CLK_IN,
				  WE_B_IN 		=> char_buf_wr,
				  ADDR_B_IN 	=> slv(char_buf_wr_addr),
				  DATA_B_IN 	=> char_buf_wr_data,
				  DATA_B_OUT 	=> open);

	
	---- HANDLE CURSOR POSITION ----	

	CURSORPOS_X_OUT <= slv(ocrx);
	CURSORPOS_Y_OUT <= slv(ocry);
	
	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if sb_state = SB_HANDLE_CHARACTER1 then
				if slv(ocrx) = C_page_width and slv(ocry) /= C_page_height then
					ocrx <= X"00";
				else
					ocrx <= ocrx + 1;
				end if;
				if slv(ocrx) = C_page_width then
					if slv(ocry) /= C_page_height then
						ocry <= ocry + 1;
					end if;
				end if;
			elsif sb_state = SB_HANDLE_BACKSPACE then
				if slv(ocrx) = X"00" and slv(ocry) /= X"00" then
					ocrx <= unsigned(C_page_width);
				else
					ocrx <= ocrx - 1;
				end if;
				if slv(ocrx) = X"00" then
					if ocry /= X"00" then
						ocry <= ocry - 1;
					end if;
				end if;
			elsif sb_state = SB_HANDLE_NEW_LINE then
				ocrx <= X"00";
				ocry <= ocry + 1;
			elsif sb_state = SB_HANDLE_CLEAR then
				ocrx <= X"00";
				ocry <= X"00";
			end if;
		end if;
	end process;

	--- Font/Character Pixel Map --

	Font_Mem_inst : FONT_MEM
	  PORT MAP (
		 clka 	=> CLK_IN,
		 wea 		=> "0",
		 addra 	=> FONT_ADDR_IN,
		 dina 	=> (others => '0'),
		 douta 	=> FONT_DATA_OUT);

	--- Screen Messages Ram ---
	
	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if hk_state = REPORT_UNKNOWN_COMMAND4 then
				screen_msg_addr <= unsigned(C_unknown_messge_addr);
			elsif hk_state = HANDLE_NETWORK_ENABLED_COMMAND2 then
				screen_msg_addr <= unsigned(C_net_enabled_message_addr);
			elsif hk_state = HANDLE_NETWORK_ENABLED_COMMAND4 then
				screen_msg_addr <= unsigned(C_true_message_addr);
			elsif hk_state = HANDLE_NETWORK_ENABLED_COMMAND5 then
				screen_msg_addr <= unsigned(C_false_message_addr);
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND0 then
				screen_msg_addr <= unsigned(C_mac_message_addr);
			elsif hk_state = CONNECT_DHCP_COMMAND1 then
				screen_msg_addr <= unsigned(C_local_connect_addr);
			elsif hk_state = CONNECT_STATIC_COMMAND1 then
				screen_msg_addr <= unsigned(C_local_connect_addr);
			elsif hk_state = CONNECT_DHCP_COMMAND6 then
				screen_msg_addr <= unsigned(C_success_message_addr);
			elsif hk_state = CONNECT_DHCP_COMMAND7 then
				screen_msg_addr <= unsigned(C_failed_message_addr);
			elsif hk_state = HANDLE_SHOW_MY_IP_COMMAND then
				screen_msg_addr <= unsigned(C_show_ip_addr);
			elsif hk_state = HANDLE_SHOW_CLOUD_IP_COMMAND then
				screen_msg_addr <= unsigned(C_show_cloud_ip_addr);
			elsif hk_state = HANDLE_SHOW_IP_SETTING_COMMAND0 then
				screen_msg_addr <= unsigned(C_show_ip_setting_addr);
			elsif hk_state = HANDLE_SHOW_IP_SETTING_COMMAND4 then
				screen_msg_addr <= unsigned(C_dynamic_addr);
			elsif hk_state = HANDLE_SHOW_IP_SETTING_COMMAND5 then
				screen_msg_addr <= unsigned(C_static_addr);
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND0 then
				screen_msg_addr <= unsigned(C_cloud_connect_addr);
			else
				screen_msg_addr <= screen_msg_addr + 1;
			end if;
			if hk_state = REPORT_UNKNOWN_COMMAND4 then
				hk_cached_state <= NEW_LINE_W_NEW_PROMPT0;
			elsif hk_state = HANDLE_NETWORK_ENABLED_COMMAND2 then
				hk_cached_state <= HANDLE_NETWORK_ENABLED_COMMAND3;
			elsif hk_state = HANDLE_NETWORK_ENABLED_COMMAND4 then
				hk_cached_state <= NEW_LINE_W_NEW_PROMPT0;
			elsif hk_state = HANDLE_NETWORK_ENABLED_COMMAND5 then
				hk_cached_state <= NEW_LINE_W_NEW_PROMPT0;
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND0 then
				hk_cached_state <= HANDLE_SHOW_MAC_COMMAND1;
			elsif hk_state = CONNECT_DHCP_COMMAND1 then
				hk_cached_state <= CONNECT_DHCP_COMMAND2;
			elsif hk_state = CONNECT_STATIC_COMMAND1 then
				hk_cached_state <= CONNECT_DHCP_COMMAND2;
			elsif hk_state = CONNECT_DHCP_COMMAND6 then
				hk_cached_state <= NEW_LINE_W_NEW_PROMPT0;
			elsif hk_state = CONNECT_DHCP_COMMAND7 then
				hk_cached_state <= NEW_LINE_W_NEW_PROMPT0;
			elsif hk_state = HANDLE_SHOW_IP_COMMAND0 then
				hk_cached_state <= HANDLE_SHOW_IP_COMMAND1;
			elsif hk_state = HANDLE_SHOW_IP_SETTING_COMMAND0 then
				hk_cached_state <= HANDLE_SHOW_IP_SETTING_COMMAND1;
			elsif hk_state = HANDLE_SHOW_IP_SETTING_COMMAND4 then
				hk_cached_state <= NEW_LINE_W_NEW_PROMPT0;
			elsif hk_state = HANDLE_SHOW_IP_SETTING_COMMAND5 then
				hk_cached_state <= NEW_LINE_W_NEW_PROMPT0;
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND0 then
				hk_cached_state <= HANDLE_CONNECT_CLOUD_COMMAND1;
			end if;
		end if;
	end process;
	
	screen_msg : TDP_RAM
	Generic Map ( G_DATA_A_SIZE 	=> screen_msg_char'length,
					  G_ADDR_A_SIZE	=> screen_msg_addr'length,
					  G_RELATION		=> 0, --log2(SIZE_A/SIZE_B)
					  G_INIT_ZERO		=> false,
					  G_INIT_FILE		=> "./coe_dir/screen_msg.coe")
   Port Map ( CLK_A_IN 		=> CLK_IN,
				  WE_A_IN 		=> '0',
				  ADDR_A_IN 	=> slv(screen_msg_addr),
				  DATA_A_IN		=> X"00",
				  DATA_A_OUT	=> screen_msg_char,
				  CLK_B_IN 		=> CLK_IN,
				  WE_B_IN 		=> '0',
				  ADDR_B_IN 	=> '0'&X"00",
				  DATA_B_IN 	=> X"00",
				  DATA_B_OUT 	=> open);

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if hk_state = HANDLE_SHOW_MAC_COMMAND3 then
				hex_val <= DATA_IN(7 downto 4);
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND5 then
				hex_val <= DATA_IN(3 downto 0);
			end if;
			if hk_state = HANDLE_SHOW_MAC_COMMAND3 then
				hex_conv <= '1';
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND5 then
				hex_conv <= '1';
			else
				hex_conv <= '0';
			end if;
		end if;
	end process;	

	hex_to_ascii_inst : hex_to_ascii
    Port Map ( CLK_IN 			=> CLK_IN,
					CONV_IN 			=> hex_conv,
					HEX_IN 			=> hex_val,
					ASCII_OUT 		=> ascii_val,
					CONV_DONE_OUT 	=> hex_conv_done);

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if hk_state = HANDLE_SHOW_IP_COMMAND3 then
				bin_val <= DATA_IN(7 downto 0);
			end if;
			if hk_state = HANDLE_SHOW_IP_COMMAND3 then
				bcd_conv <= '1';
			else
				bcd_conv <= '0';
			end if;
		end if;
	end process;

	bin_to_bcd_inst : bin_to_bcd
    Port Map ( CLK_IN 			=> CLK_IN,
					CONV_IN 			=> bcd_conv,
					BIN_IN 			=> bin_val,
					BCD_OUT 			=> bcd_val,
					CONV_DONE_OUT 	=> bcd_conv_done);

	--- Bus DATA/ADDR Handling --
	
	ETH_COMMAND_EN_OUT <= eth_command_en;
	ETH_COMMAND_OUT <= eth_command;
	eth_command_cmplt <= ETH_COMMAND_CMPLT_IN;
	eth_command_err <= ETH_COMMAND_ERR_IN;
	
	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if hk_state = HANDLE_NETWORK_INIT_COMMAND0 then
				eth_command <= X"3";
			elsif hk_state = CONNECT_DHCP_COMMAND0 then
				eth_command <= X"4";
			elsif hk_state = CONNECT_STATIC_COMMAND0 then
				eth_command <= X"5";
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND0 then
				eth_command <= X"6";
			elsif hk_state = CANCEL_DHCP_CONNECT0 then
				eth_command <= X"7";
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND5 then
				eth_command <= X"9";
			end if;
			if hk_state = HANDLE_NETWORK_INIT_COMMAND0 then
				eth_command_en <= '1';
			elsif hk_state = CONNECT_DHCP_COMMAND0 then
				eth_command_en <= '1';
			elsif hk_state = CONNECT_STATIC_COMMAND0 then
				eth_command_en <= '1';
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND0 then
				eth_command_en <= '1';
			elsif hk_state = CANCEL_DHCP_CONNECT0 then
				eth_command_en <= '1';
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND5 then
				eth_command_en <= '1';
			else
				eth_command_en <= '0';
			end if;
			if hk_state = CONNECT_DHCP_COMMAND0 or hk_state = CONNECT_STATIC_COMMAND0 then
				dhcp_second_count <= X"0";
			elsif hk_state = CONNECT_DHCP_COMMAND3 then
				dhcp_second_count <= dhcp_second_count + 1;
			end if;
			if hk_state = HANDLE_CONNECT_CLOUD_COMMAND0 then
				tcp_second_count <= X"0";
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND3 then
				tcp_second_count <= tcp_second_count + 1;
			end if;
		end if;
	end process;
	
	ADDR_OUT <= slv(addr);
	
	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if hk_state = HANDLE_NETWORK_ENABLED_COMMAND0 then
				addr <= X"00";
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND1 then
				addr <= X"01";
			elsif hk_state = HANDLE_SHOW_MAC_COMMAND7 then
				addr <= addr + 1;
			elsif hk_state = HANDLE_CONNECT_LOCAL0 then
				addr <= X"07";
			elsif hk_state = HANDLE_SHOW_IP_SETTING_COMMAND1 then
				addr <= X"07";
			elsif hk_state = CONNECT_DHCP_COMMAND3 then
				addr <= X"08";
			elsif hk_state = HANDLE_SHOW_IP_COMMAND1 then
				addr <= unsigned(show_ip_start_addr);
			elsif hk_state = HANDLE_SHOW_IP_COMMAND8 then
				addr <= addr + 1;
			elsif hk_state = HANDLE_CONNECT_CLOUD_COMMAND2 then
				addr <= X"11";
			end if;
			if hk_state = HANDLE_NETWORK_ENABLED_COMMAND2 then
				networking_enabled <= DATA_IN(0);
			end if;
			if hk_state = HANDLE_CONNECT_LOCAL2 then
				dhcp_enabled <= DATA_IN(0);
			end if;
			if hk_state = HANDLE_SHOW_MY_IP_COMMAND then
				show_ip_start_addr <= X"09";
			elsif hk_state = HANDLE_SHOW_CLOUD_IP_COMMAND then
				show_ip_start_addr <= X"0D";
			end if;
		end if;
	end process;

end Behavioral;

