----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:04 12/10/2014 
-- Design Name: 
-- Module Name:    eth_mod - Behavioral 
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
-- TODO: Have 'G_ENABLE_DHCP' Generic and comment all statements that rely on dhcp with '#ifdef end'
-- TODO: Get correct version of 'sf.conf' and add it to repository
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity eth_mod is
	Generic ( G_FUNCTION 	:string :="client" );
    Port ( 
			CLK_IN 		: in STD_LOGIC;
			CLK_1HZ_IN	: in STD_LOGIC;

			-- Command interface
			INIT_ENC28J60 	: in 	STD_LOGIC;
			DHCP_CONNECT 	: in 	STD_LOGIC;
			ERROR_OUT 		: out  STD_LOGIC_VECTOR (7 downto 0);

			-- Debug Interface
			DEBUG_IN		: in 	STD_LOGIC_VECTOR(2 downto 0);
			DEBUG_OUT		: out  STD_LOGIC_VECTOR (15 downto 0);

			-- TCP Connection Interface
			TCP_CONNECTION_ACTIVE_OUT 	: out STD_LOGIC;
			TCP_RD_DATA_AVAIL_OUT 		: out STD_LOGIC;
			TCP_RD_DATA_EN_IN 			: in STD_LOGIC;
			TCP_RD_DATA_OUT 			: out STD_LOGIC_VECTOR (7 downto 0);
			TCP_WR_DATA_POSSIBLE_OUT	: out STD_LOGIC;
			TCP_WR_DATA_EN_IN 			: in STD_LOGIC;
			TCP_WR_DATA_FLUSH_IN		: in STD_LOGIC;
			TCP_WR_DATA_IN 				: in STD_LOGIC_VECTOR (7 downto 0);		

			-- Eth SPI interface
			SDI_OUT 	: out  STD_LOGIC;
			SDO_IN 		: in  STD_LOGIC;
			SCLK_OUT 	: out  STD_LOGIC;
			CS_OUT 		: out  STD_LOGIC );
end eth_mod;

architecture Behavioral of eth_mod is

	COMPONENT spi_mod
		Port ( 	CLK_IN 				: in  STD_LOGIC;
					RST_IN 				: in  STD_LOGIC;
					
					WR_CONTINUOUS_IN 	: in  STD_LOGIC;
					WE_IN 				: in  STD_LOGIC;
					WR_ADDR_IN			: in 	STD_LOGIC_VECTOR (7 downto 0);
					WR_DATA_IN 			: in  STD_LOGIC_VECTOR (7 downto 0);
					WR_DATA_CMPLT_OUT	: out STD_LOGIC;
					
					RD_CONTINUOUS_IN 				: in  STD_LOGIC;
					RD_IN					: in	STD_LOGIC;
					RD_WIDTH_IN 		: in  STD_LOGIC;
					RD_ADDR_IN 			: in  STD_LOGIC_VECTOR (7 downto 0);
					RD_DATA_OUT 		: out STD_LOGIC_VECTOR (7 downto 0);
					RD_DATA_CMPLT_OUT	: out STD_LOGIC;
					
					SLOW_CS_EN_IN			  : in STD_LOGIC;
					OPER_CMPLT_POST_CS_OUT : out STD_LOGIC;
					
					SDI_OUT				: out STD_LOGIC;
					SDO_IN				: in 	STD_LOGIC;
					SCLK_OUT				: out STD_LOGIC;
					CS_OUT				: out STD_LOGIC);
	END COMPONENT;
	
	COMPONENT checksum_calc
    Port ( CLK_IN 						: in  STD_LOGIC;
           RST_IN 						: in  STD_LOGIC;
           CHECKSUM_CALC_IN 			: in  STD_LOGIC;
           START_ADDR_IN 				: in  STD_LOGIC_VECTOR (10 downto 0);
           COUNT_IN 						: in  STD_LOGIC_VECTOR (10 downto 0);
           VALUE_IN 						: in  STD_LOGIC_VECTOR (7 downto 0);
           VALUE_ADDR_OUT 				: out  STD_LOGIC_VECTOR (10 downto 0);
			  CHECKSUM_INIT_IN			: in  STD_LOGIC_VECTOR (15 downto 0);
			  CHECKSUM_SET_INIT_IN		: in  STD_LOGIC;
			  CHECKSUM_ODD_LENGTH_IN	: in  STD_LOGIC;
           CHECKSUM_OUT 				: out STD_LOGIC_VECTOR (15 downto 0);
           CHECKSUM_DONE_OUT 			: out STD_LOGIC);
	END COMPONENT;
	
	COMPONENT TCP_FIFO
	  PORT (
		 clk 				: IN STD_LOGIC;
		 din 				: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 wr_en 			: IN STD_LOGIC;
		 rd_en 			: IN STD_LOGIC;
		 dout 			: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 full 			: OUT STD_LOGIC;
		 almost_full 	: OUT STD_LOGIC;
		 empty 			: OUT STD_LOGIC;
		 data_count 	: OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT lfsr32_mod
		 Port ( CLK_IN 		: in  STD_LOGIC;
				  SEED_IN 		: in  STD_LOGIC_VECTOR(31 downto 0);
				  SEED_EN_IN 	: in  STD_LOGIC;
				  VAL_OUT 		: out STD_LOGIC_VECTOR(31 downto 0));
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
	
	COMPONENT Packet_Definition
	  PORT (
		 clka 	: IN STD_LOGIC;
		 addra 	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 douta 	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;

subtype slv is std_logic_vector;

constant C_250us	: unsigned(15 downto 0) := X"61A8";
constant C_200ms	: unsigned(24 downto 0) := '1'&X"312D00";
constant C_100ms	: unsigned(23 downto 0) := X"989680";
constant C_20ms 	: unsigned(20 downto 0) := '1'&X"E8480";

constant C_init_cmnds_start_addr 	: std_logic_vector(7 downto 0) := X"01";
constant C_init_cmnds_max_addr 		: std_logic_vector(7 downto 0) := X"7F";

constant C_arp_reply_frame_addr 			: std_logic_vector(10 downto 0) := "000"&X"80";
constant C_icmp_reply_frame_addr 		: std_logic_vector(10 downto 0) := "000"&X"AB";
constant C_dhcp_discover_frame_addr 	: std_logic_vector(10 downto 0) := "001"&X"24";
constant C_dhcp_request_frame_addr 		: std_logic_vector(10 downto 0) := "010"&X"86";
constant C_arp_request_frame_addr 		: std_logic_vector(10 downto 0) := "100"&X"67";
constant C_tcp_packet_frame_addr 		: std_logic_vector(10 downto 0) := "100"&X"92";
constant C_tcp_tx_packet_frame_addr 	: std_logic_vector(10 downto 0) := "100"&X"F4";

constant C_arp_reply_length 		: std_logic_vector(15 downto 0) := X"002A";
constant C_icmp_reply_length 		: std_logic_vector(15 downto 0) := X"0062";
constant C_dhcp_discover_length 	: std_logic_vector(15 downto 0) := X"0156";
constant C_dhcp_request_length 	: std_logic_vector(15 downto 0) := X"015C";
constant C_arp_request_length 	: std_logic_vector(15 downto 0) := X"002A";
constant C_tcp_packet_length 		: std_logic_vector(15 downto 0) := X"0042";

constant C_ARP_Packet_Type 		: std_logic_vector(15 downto 0) := X"0806";
constant C_IP_Packet_Type 			: std_logic_vector(15 downto 0) := X"0800";
constant C_ICMP_Protocol_Number	: std_logic_vector(7 downto 0) := X"01";
constant C_UDP_Protocol_Number	: std_logic_vector(7 downto 0) := X"11";
constant C_TCP_Protocol_Number	: std_logic_vector(7 downto 0) := X"06";
constant C_IPV4_Protocol_Number	: std_logic_vector(3 downto 0) := X"4";
constant C_DHCP_Source_Port		: std_logic_vector(15 downto 0) := X"0043";
constant C_DHCP_Dest_Port			: std_logic_vector(15 downto 0) := X"0044";
constant C_dhcp_magic_cookie		: std_logic_vector(31 downto 0) := X"63825363";

constant C_tcp_syn_ack_flags	: std_logic_vector(7 downto 0) := X"12";
constant C_tcp_syn_flags			: std_logic_vector(7 downto 0) := X"02";

constant C_tcp_ack_flags			: std_logic_vector(7 downto 0) := X"10";
constant C_tcp_fin_ack_flags		: std_logic_vector(7 downto 0) := X"11";
constant C_tcp_psh_ack_flags		: std_logic_vector(7 downto 0) := X"18";

constant C_ICMP_Ping_Length 		: std_logic_vector(15 downto 0) := X"0054";
constant C_ARP_Request 				: std_logic_vector(7 downto 0) := X"01";
constant C_ARP_Reply			 		: std_logic_vector(7 downto 0) := X"02";

constant C_rx_pointer_min : unsigned(15 downto 0) := X"0000";
constant C_rx_pointer_max : unsigned(15 downto 0) := X"0FFF";
constant C_tx_base_addr1  : unsigned(15 downto 0) := X"1000";
constant C_tx_base_addr2  : unsigned(15 downto 0) := X"1800";

signal spi_we, spi_wr_continuous, spi_wr_cmplt, spi_rd_continuous : std_logic := '0';
signal spi_rd, spi_rd_width, spi_rd_cmplt, spi_oper_cmplt : std_logic := '0';
signal spi_wr_addr, spi_wr_data, spi_rd_addr, spi_data_rd : std_logic_vector(7 downto 0) := (others => '0');

signal frame_addr : std_logic_vector(10 downto 0);
signal frame_data : std_logic_vector(15 downto 0);
signal frame_data_rd, frame_rd_cmplt, slow_cs_en : std_logic := '0';
signal network_interface_enabled : std_logic := '0';

signal command_cmplt, command_trig, command_en_in_p 	: std_logic := '0';
signal init_cmnd_addr 	: unsigned(7 downto 0);

signal interrupt_counter 			: unsigned(15 downto 0) := (others => '0');
signal next_packet_pointer			: std_logic_vector(15 downto 0) := (others => '0');
signal previous_packet_pointer	: unsigned(15 downto 0) := (others => '0');
signal eir_register					: std_logic_vector(7 downto 0) := (others => '0');

signal rx_packet_ram_we, handle_rx_packet, rx_packet_handled : std_logic := '0';
signal debug_rx_flag, debug_rx_flag1, debug_rx_flag2  : std_logic := '0';
signal rx_packet_ram_we_addr, rx_packet_ram_we_addr_buf : unsigned(10 downto 0) := (others => '0');
signal rx_packet_ram_rd_addr : unsigned(10 downto 0) := (others => '0');
signal rx_packet_rd2_addr : unsigned(10 downto 0) := (others => '0');
signal rx_packet_rd_data, rx_packet_rd_data2 : std_logic_vector(7 downto 0);
signal rx_packet_status_vector, arp_target_ip_addr, arp_source_ip_addr : std_logic_vector(31 downto 0);
signal rx_packet_type 			: std_logic_vector(15 downto 0);
signal rx_packet_source_mac 	: std_logic_vector(47 downto 0);
signal send_arp_reply, send_arp_request : std_logic := '0';
signal send_icmp_reply, send_dhcp_discover, send_dhcp_request : std_logic := '0';
signal arp_opcode : std_logic_vector(7 downto 0);

signal tx_packet_ram_we, tx_packet_config_cmplt : std_logic := '0';
signal tx_packet_ram_we_addr, tx_packet_ram_rd_addr : unsigned(10 downto 0) := (others => '0');
signal tx_packet_ram_we_addr_buf : unsigned(10 downto 0) := (others => '0');
signal tx_packet_rd_data, tx_packet_ram_data : std_logic_vector(7 downto 0);
signal tx_packet_rd_data2 : std_logic_vector(7 downto 0);
signal handle_tx_packet : std_logic := '0';

signal ip_addr  			: std_logic_vector(31 downto 0) := X"C0A80166"; 		-- 192.168.1.102
signal mac_addr 			: std_logic_vector(47 downto 0) := X"8066F23D547A";
signal ip_identification 	: std_logic_vector(15 downto 0);
signal ping_enable 			: std_logic := '1';
signal dhcp_enable 			: std_logic := '0';
signal dhcp_addr_locked, static_addr_locked 	: std_logic := '0';

signal client_ip_addr : std_logic_vector(31 downto 0) := X"C0A80100";	-- 192.168.1.0 should be set dynamically upon TCP connection ??
signal client_mac_addr : std_logic_vector(47 downto 0) := X"000000000000";

--signal cloud_ip_addr : std_logic_vector(31 downto 0) := X"76D2707C"; -- 118.210.112.124
signal cloud_ip_addr : std_logic_vector(31 downto 0) := X"C0A80100"; -- 192.168.1.0

signal tx_packet_frame_addr :unsigned(10 downto 0);
signal tx_packet_length, tx_packet_length_counter, tx_packet_end_pointer :unsigned(15 downto 0);
signal prev_tx_packet_end_pointer :unsigned(15 downto 0);
signal doing_tx_packet_config, tx_packet_frame_data_rd : std_logic := '0';
signal packet_instruction, packet_data : std_logic_vector(7 downto 0);
signal tx_packet_ready_for_transmission : std_logic := '0';
signal send_prev_packet_waiting, trigger_send_prev_packet : std_logic := '0';
signal trigger_close_connection, wait_for_tcp_window_size_update : std_logic := '0';
signal tx_base_addr, tx_base_addr_prev : unsigned(15 downto 0);
signal tx_base_addr_select : std_logic := '0';

signal ip_packet_version  			: std_logic_vector(3 downto 0);
signal ip_packet_protocol 			: std_logic_vector(7 downto 0);
signal ip_packet_header_length	: std_logic_vector(7 downto 0);
signal ip_packet_destination_ip 	: std_logic_vector(31 downto 0);
signal ip_packet_length, ip_packet_length_debug 			: std_logic_vector(15 downto 0); -- TODO remove debug
signal total_packet_length 		: unsigned(15 downto 0);

signal lfsr_val : std_logic_vector(31 downto 0);
signal calc_checksum, checksum_calc_done : std_logic := '0';
signal checksum_start_addr, checksum_addr, checksum_wr_addr : std_logic_vector(10 downto 0);
signal checksum_count : unsigned(10 downto 0);
signal checksum : std_logic_vector(15 downto 0);
signal checksum_initial_value : std_logic_vector(15 downto 0);
signal checksum_set_initial_value, checksum_odd_length : std_logic;

signal command : std_logic_vector(3 downto 0);
signal poll_interrupt_reg, command_waiting : std_logic;
signal poll_counter : unsigned(3 downto 0) := (others => '1');

signal dhcp_transaction_id : std_logic_vector(31 downto 0) := X"CA805562";
signal transaction_id_rd : std_logic_vector(31 downto 0) := X"00000000";

signal udp_source_port, udp_dest_port : std_logic_vector(15 downto 0);
signal dhcp_your_ip_addr, dhcp_server_ip_addr, dhcp_magic_cookie : std_logic_vector(31 downto 0);

signal expecting_dhcp_offer, expecting_dhcp_ack, expecting_arp_reply : std_logic := '0';
signal expecting_syn_ack, ack_required, trigger_ack : std_logic := '0';
signal dhcp_option_addr : unsigned(10 downto 0);
signal dhcp_option, dhcp_option_length, dhcp_message_type : std_logic_vector(7 downto 0);

signal packet_definition_addr : std_logic_vector(10 downto 0);
signal packet_definition_data : std_logic_vector(15 downto 0);

signal client_port 	: std_logic_vector(15 downto 0) := (others => '0');
signal listen_port 	: std_logic_vector(15 downto 0) := X"0DA2";
signal tcp_sequence_number, tcp_acknowledge_number : unsigned(31 downto 0) := (others => '0');
signal tcp_sequence_number_previous_ack, tcp_ack_number_previous_ack : unsigned(31 downto 0) := (others => '0');
signal tcp_ack_number_previous_ack1, tcp_ack_number_previous_ack2, tcp_ack_number_previous_ack3 : unsigned(31 downto 0) := (others => '0');
signal tcp_ack_number_previous_ack4, tcp_ack_number_previous_ack5, tcp_ack_number_previous_ack6 : unsigned(31 downto 0) := (others => '0');
signal tcp_sequence_number_p1 : unsigned(31 downto 0) := (others => '0');
signal tcp_flags : std_logic_vector(7 downto 0) := (others => '0');
signal window_size : unsigned(11 downto 0) := X"E00";
signal requested_data_size : unsigned(11 downto 0);
signal send_tcp_ack_packet, cancel_dhcp_connect : std_logic := '0';
signal send_tcp_tx_packet : std_logic := '0';
signal tcp_connection_active, close_tcp_connection, cancel_tcp_connection : std_logic := '0';
signal tcp_ip_identification : unsigned(15 downto 0);

signal rx_tcp_source_port, rx_tcp_dest_port : std_logic_vector(15 downto 0) := (others => '0');
signal rx_tcp_seq_number, rx_tcp_ack_number : std_logic_vector(31 downto 0) := (others => '0');
signal rx_tcp_window_size_shifted : std_logic_vector(31 downto 0) := (others => '0'); 
signal rx_tcp_window_size, rx_tcp_checksum : std_logic_vector(15 downto 0) := (others => '0');
signal rx_tcp_flags, rx_tcp_option, rx_tcp_header_length : std_logic_vector(7 downto 0) := (others => '0');
signal rx_tcp_option_length : unsigned(7 downto 0);
signal rx_tcp_window_shift : std_logic_vector(3 downto 0);
signal tcp_option_addr, next_protocol_start_addr : unsigned(10 downto 0);
signal rx_data_length, prev_rx_data_length : unsigned(15 downto 0);
signal rx_data_start_addr : unsigned(10 downto 0);
signal resend_ack_packet, fin_received, syn_ack_packet : std_logic := '0';
signal sent_syn_ack : std_logic := '0';
signal fin_received_p, trigger_fin_ack : std_logic := '0';

signal tcp_rx_data_we, tcp_rd_data_available, tcp_data_rd_en : std_logic := '0';
signal tcp_rx_ram_almost_full : std_logic := '0';
signal tcp_rd_data_count, tcp_wr_data_count 	: std_logic_vector(11 downto 0) := (others => '0');
signal tcp_rx_data 									: unsigned(7 downto 0) := (others => '0');
signal tcp_rx_data_rd_data 						: std_logic_vector(7 downto 0) := (others => '0');

signal tcp_wr_data_possible, tcp_wr_data_en, tcp_tx_data_rd : std_logic := '0';
signal tcp_wr_data_flush, tcp_data_flush_waiting : std_logic := '0';
signal large_tx_packet_waiting : std_logic := '0';
signal tcp_wr_data, tcp_tx_data : std_logic_vector(7 downto 0) := (others => '0');
signal tx_bytes_to_send, tx_total_packet_length, tx_packet_data_counter : unsigned(11 downto 0) := (others => '0');
signal tx_total_packet_length_inc_mac, tx_total_packet_length_checksum 	: unsigned(11 downto 0) := (others => '0');
signal tx_packet_no_ack_timeout : unsigned(23 downto 0) := C_100ms;
signal tx_packet_timeout_counter, tx_packet_timeout_counter_prev : unsigned(7 downto 0) := X"00";
signal tx_timeout_counter : unsigned(20 downto 0);
signal tx_packets_no_ack : unsigned(3 downto 0) := X"0";

signal clk_1hz, clk_1hz_prev : std_logic := '0';
signal init_enc28j60_waiting, dhcp_connect_waiting, tcp_connect_waiting : std_logic := '0';
signal rx_kbytes_sec, tx_kbytes_sec : unsigned(11 downto 0);
signal rx_bytes_counter, tx_bytes_counter : unsigned(21 downto 0);

signal ack_countdown : unsigned(15 downto 0);
signal num_packets : std_logic_vector(7 downto 0) := (others => '0');

type ETH_ST is (	IDLE,
						TRIGGER_DHCP_DISCOVER,
						TRIGGER_ARP_REQUEST,
						TRIGGER_CANCEL_DHCP_CONNECT,
						TRIGGER_CLOSE_TCP_CONNECTION,
						TRIGGER_CANCEL_TCP_CONNECTION,
						HANDLE_INIT_CMND0,
						HANDLE_INIT_CMND1,
						HANDLE_INIT_CMND2,
						HANDLE_INIT_CMND3,
						HANDLE_INIT_CMND4,
						HANDLE_INIT_CMND5,
						HANDLE_INIT_CMND6,
						SERVICE_INTERRUPT0,
						SERVICE_INTERRUPT1,
						SERVICE_INTERRUPT2,
						SERVICE_INTERRUPT3,
						SERVICE_INTERRUPT4,
						SERVICE_INTERRUPT5,
						SERVICE_INTERRUPT6,
						SERVICE_INTERRUPT7,
						SERVICE_INTERRUPT8,
						HANDLE_TX_INTERRUPT0,
						HANDLE_TX_INTERRUPT1,
						HANDLE_TX_INTERRUPT2,
						HANDLE_RX_INTERRUPT0,
						HANDLE_RX_INTERRUPT1,
						HANDLE_RX_INTERRUPT2,
						HANDLE_RX_INTERRUPT3,
						HANDLE_RX_INTERRUPT4,
						HANDLE_RX_INTERRUPT5,
						HANDLE_RX_INTERRUPT6,
						HANDLE_RX_INTERRUPT7,
						HANDLE_RX_INTERRUPT8,
						HANDLE_RX_INTERRUPT9,
						HANDLE_RX_INTERRUPT10,
						HANDLE_RX_INTERRUPT11,
						HANDLE_RX_INTERRUPT12,
						HANDLE_RX_INTERRUPT13,
						HANDLE_RX_INTERRUPT14,
						HANDLE_RX_INTERRUPT15,
						HANDLE_RX_INTERRUPT16,
						HANDLE_RX_INTERRUPT17,
						CHECK_IF_ACK_WAITING,
						TRIGGER_ACK_PACKET,
						TRIGGER_TCP_TX0,
						TRIGGER_TCP_TX1,
						TRIGGER_TCP_TX2,
						COPY_RX_PACKET_TO_BUF0,
						COPY_RX_PACKET_TO_BUF1,
						COPY_RX_PACKET_TO_BUF2,
						COPY_RX_PACKET_TO_BUF3,
						COPY_RX_PACKET_TO_BUF4,
						COPY_RX_PACKET_TO_BUF5,
						COPY_RX_PACKET_TO_BUF6,
						PRE_TX_TRANSMIT0,
						PRE_TX_TRANSMIT1,
						PRE_TX_TRANSMIT2,
						PRE_TX_TRANSMIT3,
						PRE_TX_TRANSMIT4,
						PRE_TX_TRANSMIT5,
						HANDLE_TX_TRANSMIT0,
						HANDLE_TX_TRANSMIT1,
						HANDLE_TX_TRANSMIT2,
						HANDLE_TX_TRANSMIT3,
						HANDLE_TX_TRANSMIT4,
						HANDLE_TX_TRANSMIT5,
						HANDLE_TX_TRANSMIT6,
						HANDLE_TX_TRANSMIT7,
						HANDLE_TX_TRANSMIT8,
						HANDLE_TX_TRANSMIT9,
						HANDLE_TX_TRANSMIT10,
						HANDLE_TX_TRANSMIT_PRE11,
						HANDLE_TX_TRANSMIT11,
						HANDLE_TX_TRANSMIT12,
						HANDLE_TX_TRANSMIT13,
						HANDLE_TX_TRANSMIT14,
						HANDLE_TX_TRANSMIT15,
						HANDLE_TX_TRANSMIT16,
						HANDLE_TX_TRANSMIT17,
						HANDLE_TX_TRANSMIT18,
						HANDLE_TX_TRANSMIT19,
						HANDLE_TX_TRANSMIT20,
						HANDLE_TX_TRANSMIT21,
						HANDLE_TX_TRANSMIT22,
						HANDLE_TX_TRANSMIT_PREV0,
						HANDLE_TX_TRANSMIT_PREV1,
						HANDLE_TX_TRANSMIT_PREV2,
						HANDLE_TX_TRANSMIT_PREV3,
						HANDLE_TX_TRANSMIT_PREV4,
						HANDLE_TX_TRANSMIT_PREV5,
						HANDLE_TX_TRANSMIT_PREV6,
						HANDLE_TX_TRANSMIT_PREV7,
						HANDLE_TX_TRANSMIT_PREV8,
						HANDLE_TX_TRANSMIT_PREV9,
						HANDLE_TX_TRANSMIT_PREV10,
						HANDLE_TX_TRANSMIT_PREV11,
						HANDLE_TX_TRANSMIT_PREV12,
						HANDLE_TX_TRANSMIT_PREV13,
						HANDLE_TX_TRANSMIT_PREV14,
						HANDLE_TX_TRANSMIT_PREV15,
						HANDLE_TX_TRANSMIT_PREV16,
						WAIT_FOR_TRANSMIT_CMPLT,
						RESEND_ACK_IN_BUFFER);

signal eth_state, eth_next_state : ETH_ST := IDLE;
signal state_debug_sig : unsigned(7 downto 0);

type PACKET_HANDLER_ST is (	IDLE,
										PARSE_SOURCE_MAC0,
										PARSE_SOURCE_MAC1,
										PARSE_SOURCE_MAC2,
										PARSE_SOURCE_MAC3,
										PARSE_SOURCE_MAC4,
										PARSE_SOURCE_MAC5,
										PARSE_SOURCE_MAC6,
										PARSE_SOURCE_MAC7,
										PARSE_PACKET_TYPE0,
										PARSE_PACKET_TYPE1,
										PARSE_PACKET_TYPE2,
										PARSE_PACKET_TYPE3,
										PARSE_PACKET_TYPE4,
										HANDLE_ARP_PACKET0,
										HANDLE_ARP_PACKET1,
										HANDLE_ARP_PACKET2,
										HANDLE_ARP_PACKET3,
										HANDLE_ARP_REQUEST0,
										HANDLE_ARP_REQUEST1,
										HANDLE_ARP_REQUEST2,
										HANDLE_ARP_REQUEST3,
										HANDLE_ARP_REQUEST4,
										HANDLE_ARP_REQUEST5,
										HANDLE_ARP_REQUEST6,
										HANDLE_ARP_REQUEST7,
										HANDLE_ARP_REQUEST8,
										HANDLE_ARP_REQUEST9,
										HANDLE_ARP_REQUEST10,
										HANDLE_ARP_REQUEST11,
										HANDLE_ARP_REQUEST12,
										HANDLE_ARP_REQUEST13,
										HANDLE_ARP_REPLY0,
										HANDLE_ARP_REPLY1,
										HANDLE_ARP_REPLY2,
										HANDLE_ARP_REPLY3,
										HANDLE_ARP_REPLY4,
										HANDLE_ARP_REPLY5,
										HANDLE_ARP_REPLY6,
										HANDLE_ARP_REPLY7,
										TRIGGER_ARP_REPLY,
										HANDLE_IP_PACKET0,
										HANDLE_IP_PACKET1,
										HANDLE_IP_PACKET2,
										HANDLE_IP_PACKET3,
										HANDLE_IP_PACKET4,
										HANDLE_IP_PACKET5,
										HANDLE_IP_PACKET6,
										HANDLE_IP_PACKET7,
										HANDLE_IP_PACKET8,
										HANDLE_IP_PACKET9,
										HANDLE_IP_PACKET10,
										HANDLE_IP_PACKET11,
										HANDLE_IP_PACKET12,
										PRE_ICMP_PACKET_REPLY,
										TRIGGER_ICMP_PACKET_REPLY,
										PARSE_UDP_PACKET0,
										PARSE_UDP_PACKET1,
										PARSE_UDP_PACKET2,
										PARSE_UDP_PACKET3,
										PARSE_UDP_PACKET4,
										PARSE_UDP_PACKET5,
										PARSE_UDP_PACKET_TYPE0,
										PARSE_UDP_PACKET_TYPE1,
										PARSE_DHCP_PACKET0,
										PARSE_DHCP_PACKET1,
										PARSE_DHCP_PACKET2,
										PARSE_DHCP_PACKET3,
										PARSE_DHCP_PACKET4,
										PARSE_DHCP_PACKET5,
										PARSE_DHCP_PACKET6,
										PARSE_DHCP_PACKET7,
										PARSE_DHCP_PACKET8,
										PARSE_DHCP_PACKET9,
										PARSE_DHCP_PACKET10,
										PARSE_DHCP_PACKET11,
										PARSE_DHCP_PACKET12,
										PARSE_DHCP_PACKET13,
										PARSE_DHCP_PACKET14,
										PARSE_DHCP_PACKET15,
										PARSE_DHCP_PACKET16,
										PARSE_DHCP_PACKET17,
										PARSE_DHCP_PACKET18,
										PARSE_DHCP_PACKET19,
										PARSE_DHCP_PACKET20,
										PARSE_DHCP_PACKET21,
										PARSE_DHCP_PACKET22,
										PARSE_DHCP_PACKET23,
										PARSE_DHCP_PACKET24,
										CHECK_OFFER_EXPECTED,
										TRIGGER_DHCP_REQUEST,
										HANDLE_DHCP_ACK0,
										HANDLE_DHCP_ACK1,
										HANDLE_DHCP_ACK2,
										HANDLE_DHCP_ACK3,
										HANDLE_DHCP_ACK4,
										HANDLE_DHCP_ACK5,
										HANDLE_DHCP_ACK6,
										HANDLE_DHCP_ACK7,
										HANDLE_DHCP_ACK8,
										PARSE_TCP_PACKET0,
										PARSE_TCP_PACKET1,
										PARSE_TCP_PACKET2,
										PARSE_TCP_PACKET3,
										PARSE_TCP_PACKET4,
										PARSE_TCP_PACKET5,
										PARSE_TCP_PACKET6,
										PARSE_TCP_PACKET7,
										PARSE_TCP_PACKET8,
										PARSE_TCP_PACKET9,
										PARSE_TCP_PACKET10,
										PARSE_TCP_PACKET11,
										PARSE_TCP_PACKET12,
										PARSE_TCP_PACKET13,
										PARSE_TCP_PACKET14,
										PARSE_TCP_PACKET15,
										PARSE_TCP_PACKET16,
										PARSE_TCP_PACKET17,
										PARSE_TCP_PACKET18,
										PARSE_TCP_PACKET19,
										PARSE_TCP_PACKET20,
										PARSE_TCP_PACKET21,
										PARSE_TCP_PACKET22,
										PARSE_TCP_PACKET23,
										PARSE_TCP_PACKET24,
										PARSE_TCP_PACKET25,
										PARSE_TCP_PACKET26,
										PARSE_TCP_PACKET27,
										CHECK_TCP_SYN_PACKET0,
										CHECK_TCP_SYN_PACKET1,
										CHECK_TCP_SYN_PACKET2,
										CHECK_TCP_SYN_PACKET3,
										CHECK_TCP_SYN_PACKET4,
										CHECK_TCP_SYN_PACKET5,
										CHECK_TCP_PSH_ACK_PACKET0,
										CHECK_TCP_PSH_ACK_PACKET1,
										CHECK_TCP_PSH_ACK_PACKET2,
										CHECK_TCP_PSH_ACK_PACKET3,
										READ_TCP_RX_DATA,
										TRIGGER_TCP_ACK0,
										TRIGGER_TCP_ACK1,
										TRIGGER_TCP_ACK2,
										TRIGGER_TCP_ACK3,
										RESEND_ACK,
										CHECK_IF_DATA_TO_SEND,
										TRIGGER_TCP_PSH_ACK0,
										TRIGGER_TCP_PSH_ACK1,
										CHECK_TCP_WINDOW_SIZE,
										RX_TCP_WINDOW_TOO_SMALL,
										TRIGGER_TCP_PSH_ACK2,
										TRIGGER_TCP_PSH_ACK3,
										COMPLETE
									);
										
signal packet_handler_state, packet_handler_next_state : PACKET_HANDLER_ST := IDLE;					

type TX_PACKET_CONFIG_ST is (	IDLE,
										INIT_ARP_REPLY_METADATA,
										INIT_ARP_REQUEST_METADATA,
										INIT_ICMP_REPLY_METADATA,
										INIT_DHCP_DISCOVER_METADATA,
										INIT_DHCP_REQUEST_METADATA,
										INIT_TCP_PACKET_METADATA,
										INIT_TCP_TX_PACKET_METADATA,
										CANCEL_DHCP_CONNECT_ST,
										TCP_CONNECTION_CLOSED,
										CANCEL_TCP_CONNECTION_ST,
										READ_PACKET_BYTE0,
										READ_PACKET_BYTE1,
										HANDLE_PACKET_INSTRUCTION0,
										HANDLE_PACKET_INSTRUCTION1,
										SET_RX_PACKET_ADDR_LOWER_BYTE,
										SET_RX_PACKET_ADDR_UPPER_BYTE,
										SET_CHECKSUM_LENGTH_LSB,
										SET_CHECKSUM_LENGTH_MSB,
										SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH0,
										SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH1,
										SET_CHECKSUM_START_ADDR_LSB,
										SET_CHECKSUM_START_ADDR_MSB,
										SET_CHECKSUM_WR_ADDR_LSB,
										SET_CHECKSUM_WR_ADDR_MSB,
										MOVE_TX_PACKET_WR_ADDR,
										SET_NEW_TRANSACTION_ID,
										SET_CHECKSUM_START_VAL_LSB,
										SET_CHECKSUM_START_VAL_MSB,
										SET_CHECKSUM_INITIAL_VALUE_TX_PACKET,
										TRIGGER_CHECKSUM_LOAD_INITIAL_VALUE,
										TRIG_CHECKSUM_CALC,
										WAIT_FOR_CHECKSUM_CMPLT,
										INIT_LOAD_TX_PACKET_DATA,
										LOAD_TX_PACKET_DATA,
										COMPLETE
									);
										
signal tx_packet_state, tx_packet_next_state : TX_PACKET_CONFIG_ST := IDLE;

begin
	
	--DEBUG_OUT(15 downto 8) <= X"00";
	--DEBUG_OUT(15 downto 4) <= X"000";
	--DEBUG_OUT(15 downto 12) <= (others => '0');
	--DEBUG_OUT(15 downto 12) <= slv(interrupt_counter(3 downto 0));
	--DEBUG_OUT <= slv(rx_data_length);
	--DEBUG_OUT <= udp_source_port when DEBUG_IN = '0' else udp_dest_port;
	--DEBUG_OUT <= rx_tcp_source_port when DEBUG_IN = '0' else rx_tcp_dest_port;
	--DEBUG_OUT <= rx_tcp_window_size when DEBUG_IN(0) = '0' else X"000"&rx_tcp_window_shift;
	--DEBUG_OUT <= rx_tcp_window_size_shifted(31 downto 16) when DEBUG_IN(0) = '0' else rx_tcp_window_size_shifted(15 downto 0);
	--DEBUG_OUT(11 downto 0) <= slv(window_size);
	--DEBUG_OUT(7 downto 0) <= slv(rx_tcp_option_length);
	--DEBUG_OUT <= "00000"&slv(tcp_option_addr);
	--DEBUG_OUT(7 downto 4) <= X"0";
	--DEBUG_OUT(15 downto 8) <= ip_packet_protocol;
	--DEBUG_OUT(15 downto 8) <= rx_tcp_option;
	--DEBUG_OUT <= X"00" & slv(rx_tcp_option) when DEBUG_IN = '0' else rx_tcp_window_shift & slv(rx_tcp_option_length);
	--DEBUG_OUT <= dhcp_option & dhcp_option_length;
	--DEBUG_OUT(7 downto 0) <= slv(init_cmnd_addr);
	--DEBUG_OUT(7 downto 0) <= slv(state_debug_sig);
	--DEBUG_OUT(7 downto 0) <= slv(eir_register);
	--DEBUG_OUT <= spi_wr_addr & spi_wr_data;
	--DEBUG_OUT <= next_packet_pointer;
	--DEBUG_OUT <= rx_packet_status_vector(15 downto 0) when DEBUG_IN = '0' else rx_packet_status_vector(31 downto 16);
	--DEBUG_OUT <= rx_packet_source_mac(15 downto 0) when DEBUG_IN = '0' else rx_packet_source_mac(31 downto 16);
	--DEBUG_OUT <= arp_target_ip_addr(15 downto 0) when DEBUG_IN = '0' else arp_target_ip_addr(31 downto 16);
	--DEBUG_OUT <= arp_source_ip_addr(15 downto 0) when DEBUG_IN = '0' else arp_source_ip_addr(31 downto 16);
	--DEBUG_OUT <= dhcp_your_ip_addr(15 downto 0) when DEBUG_IN = '0' else dhcp_your_ip_addr(31 downto 16);
	--DEBUG_OUT <= slv(tcp_acknowledge_number(15 downto 0)) when DEBUG_IN(1) = '0' else slv(tcp_acknowledge_number(31 downto 16));
	--DEBUG_OUT <= slv(tcp_ack_number_previous_ack(15 downto 0)) when DEBUG_IN = '0' else slv(tcp_ack_number_previous_ack(31 downto 16));
	--DEBUG_OUT(11 downto 0) <= slv(requested_data_size);
	--DEBUG_OUT(7 downto 0) <= tx_packet_rd_data;
	--DEBUG_OUT <= rx_packet_type;
	--DEBUG_OUT <= slv(tx_packet_end_pointer);
	--DEBUG_OUT(3 downto 0) <= ip_packet_version;
	--DEBUG_OUT(7 downto 0) <= X"0"&"0"&debug_rx_flag2&debug_rx_flag1&debug_rx_flag;
	--DEBUG_OUT(7 downto 0) <= slv(num_packets);
	--DEBUG_OUT(7 downto 0) <= slv(tcp_tx_data);
	--DEBUG_OUT(3 downto 0) <= slv(tx_packet_ack_timeout_occur);
	--DEBUG_OUT(11 downto 0) <= slv(rx_kbytes_sec);
	DEBUG_OUT(15 downto 0) <= slv(interrupt_counter);
	--DEBUG_OUT(15 downto 0) <= slv(tx_base_addr);
	--DEBUG_OUT(15 downto 0) <= slv(checksum);
	--DEBUG_OUT(15 downto 0) <= slv(checksum_initial_value);
	--DEBUG_OUT(10 downto 0) <= slv(rx_data_start_addr);
	--DEBUG_OUT(11 downto 0) <= slv(tcp_wr_data_count);
	
	packet_definition_addr <= frame_addr when doing_tx_packet_config = '0' else slv(tx_packet_frame_addr);
	frame_data <= packet_definition_data;
	frame_rd_cmplt <= '1';
	
	clk_1hz <= CLK_1HZ_IN;

	---- HANDLE COMMANDS ----
	
	INT_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if packet_handler_state = CHECK_TCP_SYN_PACKET0 then
				interrupt_counter <= interrupt_counter + 1;
			end if;
		end if;
	end process;

   SYNC_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			eth_state <= eth_next_state;
      end if;
   end process;

	NEXT_STATE_DECODE: process (eth_state, command, command_waiting, init_cmnd_addr, poll_interrupt_reg,
											frame_data, tx_packet_ready_for_transmission, spi_oper_cmplt, 
												eir_register, previous_packet_pointer, next_packet_pointer, rx_packet_handled, 
													tx_packet_length_counter, spi_rd_cmplt, spi_wr_cmplt)
   begin
      eth_next_state <= eth_state;  --default is to stay in current state
      case (eth_state) is
         when IDLE =>
				if init_enc28j60_waiting = '1' then
					eth_next_state <= HANDLE_INIT_CMND0;
				elsif dhcp_connect_waiting = '1' then
					eth_next_state <= TRIGGER_DHCP_DISCOVER;
				elsif send_prev_packet_waiting = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV0;
				elsif resend_ack_packet = '1' then
					eth_next_state <= RESEND_ACK_IN_BUFFER;
				elsif tx_packet_ready_for_transmission = '1' then
					eth_next_state <= PRE_TX_TRANSMIT0;
				elsif tcp_data_flush_waiting = '1' then
					eth_next_state <= TRIGGER_TCP_TX0;
				elsif large_tx_packet_waiting = '1' then
					eth_next_state <= TRIGGER_TCP_TX0;
				else
					eth_next_state <= SERVICE_INTERRUPT0;
				end if;

			when HANDLE_INIT_CMND0 =>
				eth_next_state <= HANDLE_INIT_CMND1;
			when HANDLE_INIT_CMND1 =>
				eth_next_state <= HANDLE_INIT_CMND2;
			when HANDLE_INIT_CMND2 =>
				if frame_rd_cmplt = '1' then
					if frame_data = X"0000" then
						eth_next_state <= HANDLE_INIT_CMND6;
					else
						eth_next_state <= HANDLE_INIT_CMND3;
					end if;
				end if;
			when HANDLE_INIT_CMND3 =>
				eth_next_state <= HANDLE_INIT_CMND4;
			when HANDLE_INIT_CMND4 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_INIT_CMND5;
				end if;
			when HANDLE_INIT_CMND5 =>
				if slv(init_cmnd_addr) = C_init_cmnds_max_addr then
					eth_next_state <= HANDLE_INIT_CMND6;
				else
					eth_next_state <= HANDLE_INIT_CMND1;
				end if;
			when HANDLE_INIT_CMND6 =>
				eth_next_state <= IDLE;
			
			when TRIGGER_DHCP_DISCOVER =>
				eth_next_state <= IDLE;
			when TRIGGER_ARP_REQUEST =>
				eth_next_state <= IDLE;
			when TRIGGER_CANCEL_DHCP_CONNECT =>
				eth_next_state <= IDLE;
			when TRIGGER_CLOSE_TCP_CONNECTION =>
				eth_next_state <= IDLE;
			when TRIGGER_CANCEL_TCP_CONNECTION =>
				eth_next_state <= IDLE;
			
			when SERVICE_INTERRUPT0 =>
				eth_next_state <= SERVICE_INTERRUPT1;
			when SERVICE_INTERRUPT1 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= SERVICE_INTERRUPT2;
				end if;
			when SERVICE_INTERRUPT2 =>
				eth_next_state <= SERVICE_INTERRUPT3;
			when SERVICE_INTERRUPT3 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= SERVICE_INTERRUPT4;
				end if;
			when SERVICE_INTERRUPT4 =>
				eth_next_state <= SERVICE_INTERRUPT5;
			when SERVICE_INTERRUPT5 =>
				if eir_register(6) = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT0;
				elsif eir_register(3) = '1' then
					eth_next_state <= HANDLE_TX_INTERRUPT0;
				else
					eth_next_state <= SERVICE_INTERRUPT6;
				end if;
			when HANDLE_TX_INTERRUPT0 =>
				eth_next_state <= HANDLE_TX_INTERRUPT1;
			when HANDLE_TX_INTERRUPT1 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_INTERRUPT2;
				end if;
			when HANDLE_TX_INTERRUPT2 =>
				eth_next_state <= SERVICE_INTERRUPT6;
			when HANDLE_RX_INTERRUPT0 =>
				eth_next_state <= HANDLE_RX_INTERRUPT1;
			when HANDLE_RX_INTERRUPT1 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT2;
				end if;
			when HANDLE_RX_INTERRUPT2 =>
				eth_next_state <= HANDLE_RX_INTERRUPT3;
			when HANDLE_RX_INTERRUPT3 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT4;
				end if;
			when HANDLE_RX_INTERRUPT4 =>
				eth_next_state <= COPY_RX_PACKET_TO_BUF0;
			
			when COPY_RX_PACKET_TO_BUF0 =>
				eth_next_state <= COPY_RX_PACKET_TO_BUF1;
			when COPY_RX_PACKET_TO_BUF1 =>
				eth_next_state <= COPY_RX_PACKET_TO_BUF2;
			when COPY_RX_PACKET_TO_BUF2 =>
				if spi_rd_cmplt = '1' then
					eth_next_state <= COPY_RX_PACKET_TO_BUF3;
				end if;
			when COPY_RX_PACKET_TO_BUF3 =>
				eth_next_state <= COPY_RX_PACKET_TO_BUF4;
			when COPY_RX_PACKET_TO_BUF4 =>
				if slv(previous_packet_pointer) = next_packet_pointer then
					eth_next_state <= COPY_RX_PACKET_TO_BUF5;
				else
					eth_next_state <= COPY_RX_PACKET_TO_BUF1;
				end if;
			when COPY_RX_PACKET_TO_BUF5 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= COPY_RX_PACKET_TO_BUF6;
				end if;
			when COPY_RX_PACKET_TO_BUF6 =>
				if rx_packet_handled = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT5;
				end if;
			
			when HANDLE_RX_INTERRUPT5 =>
				eth_next_state <= HANDLE_RX_INTERRUPT6;
			when HANDLE_RX_INTERRUPT6 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT7;
				end if;
			when HANDLE_RX_INTERRUPT7 =>
				eth_next_state <= HANDLE_RX_INTERRUPT8;
			when HANDLE_RX_INTERRUPT8 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT9;
				end if;
			when HANDLE_RX_INTERRUPT9 =>
				eth_next_state <= HANDLE_RX_INTERRUPT10;
			when HANDLE_RX_INTERRUPT10 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT11;
				end if;
			when HANDLE_RX_INTERRUPT11 =>
				eth_next_state <= HANDLE_RX_INTERRUPT12;
			when HANDLE_RX_INTERRUPT12 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT13;
				end if;
			when HANDLE_RX_INTERRUPT13 =>
				eth_next_state <= HANDLE_RX_INTERRUPT14;
			when HANDLE_RX_INTERRUPT14 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT15;
				end if;
			when HANDLE_RX_INTERRUPT15 =>
				eth_next_state <= HANDLE_RX_INTERRUPT16;
			when HANDLE_RX_INTERRUPT16 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_RX_INTERRUPT17;
				end if;
			when HANDLE_RX_INTERRUPT17 =>
				eth_next_state <= SERVICE_INTERRUPT6;
				
			when CHECK_IF_ACK_WAITING =>
				if ack_required = '1' then
					eth_next_state <= TRIGGER_ACK_PACKET;
				else
					eth_next_state <= IDLE;
				end if;
			when TRIGGER_ACK_PACKET =>
				if packet_handler_state = TRIGGER_TCP_ACK0 then
					eth_next_state <= IDLE;
				end if;
				
			when TRIGGER_TCP_TX0 =>
				if tcp_wr_data_count = X"000" or tx_packets_no_ack > X"1" then
					eth_next_state <= IDLE;
				else
					eth_next_state <= TRIGGER_TCP_TX1;
				end if;
			when TRIGGER_TCP_TX1 =>
				if packet_handler_state = RX_TCP_WINDOW_TOO_SMALL then
					eth_next_state <= IDLE;
				elsif packet_handler_state = TRIGGER_TCP_PSH_ACK2 then
					eth_next_state <= TRIGGER_TCP_TX2;
				end if;
			when TRIGGER_TCP_TX2 =>
				if tx_packet_ready_for_transmission = '1' then
					eth_next_state <= PRE_TX_TRANSMIT0;
				end if;
				
			when SERVICE_INTERRUPT6 =>
				eth_next_state <= SERVICE_INTERRUPT7;
			when SERVICE_INTERRUPT7 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= SERVICE_INTERRUPT8;
				end if;
			when SERVICE_INTERRUPT8 =>
				eth_next_state <= CHECK_IF_ACK_WAITING;
			
			when PRE_TX_TRANSMIT0 =>
				eth_next_state <= PRE_TX_TRANSMIT1;
			when PRE_TX_TRANSMIT1 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= PRE_TX_TRANSMIT2;
				end if;
			when PRE_TX_TRANSMIT2 =>
				eth_next_state <= PRE_TX_TRANSMIT3;
			when PRE_TX_TRANSMIT3 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= PRE_TX_TRANSMIT4;
				end if;
			when PRE_TX_TRANSMIT4 =>
				eth_next_state <= PRE_TX_TRANSMIT5;
			when PRE_TX_TRANSMIT5 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT0;
				end if;
			when HANDLE_TX_TRANSMIT0 =>
				eth_next_state <= HANDLE_TX_TRANSMIT1;
			when HANDLE_TX_TRANSMIT1 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT2;
				end if;
			when HANDLE_TX_TRANSMIT2 =>
				eth_next_state <= HANDLE_TX_TRANSMIT3;
			when HANDLE_TX_TRANSMIT3 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT4;
				end if;
			when HANDLE_TX_TRANSMIT4 =>
				eth_next_state <= HANDLE_TX_TRANSMIT5;
			when HANDLE_TX_TRANSMIT5 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT6;
				end if;
			when HANDLE_TX_TRANSMIT6 =>
				eth_next_state <= HANDLE_TX_TRANSMIT7;
			when HANDLE_TX_TRANSMIT7 =>
				if tx_packet_length_counter = X"0000" then
					eth_next_state <= HANDLE_TX_TRANSMIT_PRE11;
				else
					eth_next_state <= HANDLE_TX_TRANSMIT8;
				end if;
			when HANDLE_TX_TRANSMIT8 =>
				eth_next_state <= HANDLE_TX_TRANSMIT9;
			when HANDLE_TX_TRANSMIT9 =>
				eth_next_state <= HANDLE_TX_TRANSMIT10;
			when HANDLE_TX_TRANSMIT10 =>
				if spi_wr_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT7;
				end if;
			when HANDLE_TX_TRANSMIT_PRE11 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT11;
				end if;
			when HANDLE_TX_TRANSMIT11 =>
				eth_next_state <= HANDLE_TX_TRANSMIT12;
			when HANDLE_TX_TRANSMIT12 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT13;
				end if;
			when HANDLE_TX_TRANSMIT13 =>
				eth_next_state <= HANDLE_TX_TRANSMIT14;
			when HANDLE_TX_TRANSMIT14 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT15;
				end if;
			when HANDLE_TX_TRANSMIT15 =>
				eth_next_state <= HANDLE_TX_TRANSMIT16;
			when HANDLE_TX_TRANSMIT16 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT17;
				end if;
			when HANDLE_TX_TRANSMIT17 =>
				eth_next_state <= HANDLE_TX_TRANSMIT18;
			when HANDLE_TX_TRANSMIT18 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT19;
				end if;
			when HANDLE_TX_TRANSMIT19 =>
				eth_next_state <= HANDLE_TX_TRANSMIT20;
			when HANDLE_TX_TRANSMIT20 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT21;
				end if;
			when HANDLE_TX_TRANSMIT21 =>
				if spi_data_rd(3) = '1' then -- TX has completed
					eth_next_state <= HANDLE_TX_TRANSMIT22;
				else
					eth_next_state <= HANDLE_TX_TRANSMIT19;
				end if;
			when HANDLE_TX_TRANSMIT22 =>
				eth_next_state <= IDLE;
				
			when HANDLE_TX_TRANSMIT_PREV0 =>
				eth_next_state <= HANDLE_TX_TRANSMIT_PREV1;
			when HANDLE_TX_TRANSMIT_PREV1 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV2;
				end if;
			when HANDLE_TX_TRANSMIT_PREV2 =>
				eth_next_state <= HANDLE_TX_TRANSMIT_PREV3;
			when HANDLE_TX_TRANSMIT_PREV3 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV4;
				end if;
			when HANDLE_TX_TRANSMIT_PREV4 =>
				eth_next_state <= HANDLE_TX_TRANSMIT_PREV5;
			when HANDLE_TX_TRANSMIT_PREV5 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV6;
				end if;
			when HANDLE_TX_TRANSMIT_PREV6 =>
				eth_next_state <= HANDLE_TX_TRANSMIT_PREV7;
			when HANDLE_TX_TRANSMIT_PREV7 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV8;
				end if;
			when HANDLE_TX_TRANSMIT_PREV8 =>
				eth_next_state <= HANDLE_TX_TRANSMIT_PREV9;
			when HANDLE_TX_TRANSMIT_PREV9 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV10;
				end if;
			when HANDLE_TX_TRANSMIT_PREV10 =>
				eth_next_state <= HANDLE_TX_TRANSMIT_PREV11;
			when HANDLE_TX_TRANSMIT_PREV11 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV12;
				end if;
			when HANDLE_TX_TRANSMIT_PREV12 =>
				eth_next_state <= HANDLE_TX_TRANSMIT_PREV13;
			when HANDLE_TX_TRANSMIT_PREV13 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV14;
				end if;
			when HANDLE_TX_TRANSMIT_PREV14 =>
				eth_next_state <= HANDLE_TX_TRANSMIT_PREV15;
			when HANDLE_TX_TRANSMIT_PREV15 =>
				if spi_oper_cmplt = '1' then
					eth_next_state <= HANDLE_TX_TRANSMIT_PREV16;
				end if;
			when HANDLE_TX_TRANSMIT_PREV16 =>
				eth_next_state <= WAIT_FOR_TRANSMIT_CMPLT;
			when WAIT_FOR_TRANSMIT_CMPLT =>
				if tx_timeout_counter = '0'&X"00000" then
					eth_next_state <= PRE_TX_TRANSMIT0;
				end if;

			when RESEND_ACK_IN_BUFFER =>
				eth_next_state <= HANDLE_TX_TRANSMIT15;
				
		end case;
	end process;

	WR_CONTINUOUS_PROC :process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if eth_state = HANDLE_TX_TRANSMIT6 then
				spi_wr_continuous <= '1';
			elsif tx_packet_length_counter = X"0000" then
				spi_wr_continuous <= '0';
			end if;
		end if;
	end process;
	
	POLL_INT_PROC :process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			poll_counter <= poll_counter - 1;
			if poll_counter = X"0" then
				poll_interrupt_reg <= '1';
			else
				poll_interrupt_reg <= '0';
			end if;
			if INIT_ENC28J60 = '1' then
				init_enc28j60_waiting <= '1';
			elsif eth_state = HANDLE_INIT_CMND0 then
				init_enc28j60_waiting <= '0';
			end if;
			if DHCP_CONNECT = '1' then
				dhcp_connect_waiting <= '1';
			elsif eth_state = TRIGGER_DHCP_DISCOVER then
				dhcp_connect_waiting <= '0';
			end if;
			if eth_state = TRIGGER_TCP_TX0 or tx_packets_no_ack > X"1" 
					or wait_for_tcp_window_size_update = '1' then
				tcp_data_flush_waiting <= '0';
			elsif tcp_wr_data_flush = '1' and tcp_connection_active = '1' then
				tcp_data_flush_waiting <= '1';
			end if;
			if unsigned(tcp_wr_data_count) < X"580" or tcp_connection_active = '0' 
					or tx_packets_no_ack > X"1" or wait_for_tcp_window_size_update = '1' then
				large_tx_packet_waiting <= '0';
			else
				large_tx_packet_waiting <= '1';
			end if;
			if trigger_send_prev_packet = '1' then
				send_prev_packet_waiting <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV0 then
				send_prev_packet_waiting <= '0';
			end if;
		end if;
	end process;
	
	TX_PACKET_LENGTH_PROC :process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if eth_state = HANDLE_TX_TRANSMIT5 then
				tx_packet_length_counter <= tx_packet_length;
			elsif eth_state = HANDLE_TX_TRANSMIT9 then
				tx_packet_length_counter <= tx_packet_length_counter - 1;
			end if;
			if eth_state = HANDLE_TX_TRANSMIT5 then
				tx_packet_ram_rd_addr <= "00000000000";
			elsif eth_state = HANDLE_TX_TRANSMIT9 then
				tx_packet_ram_rd_addr <= tx_packet_ram_rd_addr + 1;
			end if;
		end if;
	end process;
	
   INIT_ADDR_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = HANDLE_INIT_CMND0 then
				init_cmnd_addr <= unsigned(C_init_cmnds_start_addr);
			elsif eth_state = HANDLE_INIT_CMND3 then
				init_cmnd_addr <= init_cmnd_addr + 1;
			end if;
      end if;
   end process;
	
   SLOW_CS_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = HANDLE_INIT_CMND0 then
				slow_cs_en <= '1';
			elsif eth_state = IDLE then
				slow_cs_en <= '0';
			end if;
      end if;
   end process;
	
   FRAME_ADDR_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = HANDLE_INIT_CMND1 then
				frame_addr <= "000" & slv(init_cmnd_addr);
			end if;
      end if;
   end process;
	
	SETTINGS_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = HANDLE_INIT_CMND0 then
				network_interface_enabled <= '0';
			elsif eth_state = HANDLE_INIT_CMND6 then
				network_interface_enabled <= '1'; -- TODO add disable code
			end if;
		end if;
	end process;

	SPI_WR_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = HANDLE_INIT_CMND3 then
				spi_we <= '1';
			elsif eth_state = SERVICE_INTERRUPT0 then
				spi_we <= '1';
			elsif eth_state = SERVICE_INTERRUPT6 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_INTERRUPT0 then
				spi_we <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT5 then
				spi_we <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT7 then
				spi_we <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT9 then
				spi_we <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT11 then
				spi_we <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT13 then
				spi_we <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT15 then
				spi_we <= '1';
			elsif eth_state = PRE_TX_TRANSMIT0 then
				spi_we <= '1';
			elsif eth_state = PRE_TX_TRANSMIT2 then
				spi_we <= '1';
			elsif eth_state = PRE_TX_TRANSMIT4 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT0 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT2 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT4 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT6 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT11 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT13 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT15 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT17 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV0 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV2 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV4 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV6 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV8 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV10 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV12 then
				spi_we <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV14 then
				spi_we <= '1';
			else
				spi_we <= '0';
			end if;
      end if;
   end process;
	
	SPI_ADDR_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = HANDLE_INIT_CMND3 then
				spi_wr_addr <= frame_data(15 downto 8);
			elsif eth_state = SERVICE_INTERRUPT0 then
				spi_wr_addr <= X"BB";
			elsif eth_state = HANDLE_TX_INTERRUPT0 then
				spi_wr_addr <= X"BC";
			elsif eth_state = HANDLE_RX_INTERRUPT5 then
				spi_wr_addr <= X"BF";
			elsif eth_state = HANDLE_RX_INTERRUPT7 then
				spi_wr_addr <= X"4C";
			elsif eth_state = HANDLE_RX_INTERRUPT9 then
				spi_wr_addr <= X"4D";
			elsif eth_state = HANDLE_RX_INTERRUPT11 then
				spi_wr_addr <= X"40";
			elsif eth_state = HANDLE_RX_INTERRUPT13 then
				spi_wr_addr <= X"41";	
			elsif eth_state = HANDLE_RX_INTERRUPT15 then
				spi_wr_addr <= X"9E";
			elsif eth_state = SERVICE_INTERRUPT6 then
				spi_wr_addr <= X"9B";
			elsif eth_state = PRE_TX_TRANSMIT0 then
				spi_wr_addr <= X"BF";
			elsif eth_state = PRE_TX_TRANSMIT2 then
				spi_wr_addr <= X"42";
			elsif eth_state = PRE_TX_TRANSMIT4 then
				spi_wr_addr <= X"43";
			elsif eth_state = HANDLE_TX_TRANSMIT0 then
				spi_wr_addr <= X"44";
			elsif eth_state = HANDLE_TX_TRANSMIT2 then
				spi_wr_addr <= X"45";
			elsif eth_state = HANDLE_TX_TRANSMIT4 then
				spi_wr_addr <= X"7A";
			elsif eth_state = HANDLE_TX_TRANSMIT6 then
				spi_wr_addr <= X"7A";
			elsif eth_state = HANDLE_TX_TRANSMIT11 then
				spi_wr_addr <= X"46";
			elsif eth_state = HANDLE_TX_TRANSMIT13 then
				spi_wr_addr <= X"47";
			elsif eth_state = HANDLE_TX_TRANSMIT15 then
				spi_wr_addr <= X"BC";
			elsif eth_state = HANDLE_TX_TRANSMIT17 then
				spi_wr_addr <= X"9F";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV0 then
				spi_wr_addr <= X"BF";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV2 then
				spi_wr_addr <= X"42";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV4 then
				spi_wr_addr <= X"43";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV6 then
				spi_wr_addr <= X"44";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV8 then
				spi_wr_addr <= X"45";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV10 then
				spi_wr_addr <= X"46";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV12 then
				spi_wr_addr <= X"47";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV14 then
				spi_wr_addr <= X"9F";
			end if;
      end if;
   end process;
	
	SPI_DATA_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = HANDLE_INIT_CMND3 then
				spi_wr_data <= frame_data(7 downto 0);
			elsif eth_state = SERVICE_INTERRUPT0 then
				spi_wr_data <= X"80";
			elsif eth_state = HANDLE_TX_INTERRUPT0 then
				spi_wr_data <= X"08";
			elsif eth_state = HANDLE_RX_INTERRUPT5 then
				spi_wr_data <= X"03";
			elsif eth_state = HANDLE_RX_INTERRUPT7 then
				spi_wr_data <= next_packet_pointer(7 downto 0);
			elsif eth_state = HANDLE_RX_INTERRUPT9 then
				spi_wr_data <= next_packet_pointer(15 downto 8);
			elsif eth_state = HANDLE_RX_INTERRUPT11 then
				spi_wr_data <= next_packet_pointer(7 downto 0);
			elsif eth_state = HANDLE_RX_INTERRUPT13 then
				spi_wr_data <= next_packet_pointer(15 downto 8);
			elsif eth_state = HANDLE_RX_INTERRUPT15 then
				spi_wr_data <= X"40";
			elsif eth_state = SERVICE_INTERRUPT6 then
				spi_wr_data <= X"80";
			elsif eth_state = PRE_TX_TRANSMIT0 then
				spi_wr_data <= X"03";
			elsif eth_state = PRE_TX_TRANSMIT2 then
				spi_wr_data <= slv(tx_base_addr(7 downto 0));
			elsif eth_state = PRE_TX_TRANSMIT4 then
				spi_wr_data <= slv(tx_base_addr(15 downto 8));
			elsif eth_state = HANDLE_TX_TRANSMIT0 then
				spi_wr_data <= slv(tx_base_addr(7 downto 0));
			elsif eth_state = HANDLE_TX_TRANSMIT2 then
				spi_wr_data <= slv(tx_base_addr(15 downto 8));
			elsif eth_state = HANDLE_TX_TRANSMIT4 then
				spi_wr_data <= X"00";
			elsif eth_state = HANDLE_TX_TRANSMIT6 then
				spi_wr_data <= tx_packet_rd_data;
			elsif eth_state = HANDLE_TX_TRANSMIT10 then
				spi_wr_data <= tx_packet_rd_data;
			elsif eth_state = HANDLE_TX_TRANSMIT11 then
				spi_wr_data <= slv(tx_packet_end_pointer(7 downto 0));
			elsif eth_state = HANDLE_TX_TRANSMIT13 then
				spi_wr_data <= slv(tx_packet_end_pointer(15 downto 8));
			elsif eth_state = HANDLE_TX_TRANSMIT15 then
				spi_wr_data <= X"08";
			elsif eth_state = HANDLE_TX_TRANSMIT17 then
				spi_wr_data <= X"08";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV0 then
				spi_wr_data <= X"03";
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV2 then
				spi_wr_data <= slv(tx_base_addr(7 downto 0));
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV4 then
				spi_wr_data <= slv(tx_base_addr(15 downto 8));
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV6 then
				spi_wr_data <= slv(tx_base_addr(7 downto 0));
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV8 then
				spi_wr_data <= slv(tx_base_addr(15 downto 8));
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV10 then
				spi_wr_data <= slv(prev_tx_packet_end_pointer(7 downto 0));
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV12 then
				spi_wr_data <= slv(prev_tx_packet_end_pointer(15 downto 8));
			elsif eth_state = HANDLE_TX_TRANSMIT_PREV14 then
				spi_wr_data <= X"08";
			end if;
      end if;
   end process;
	
	COMMAND_CMPLT_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state /= IDLE and eth_next_state = IDLE then
				command_cmplt <= '1';
			elsif eth_state /= IDLE and eth_next_state /= IDLE then
				command_cmplt <= '0';
			end if;
      end if;
   end process;
	
	SPI_RD_ADDR_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = SERVICE_INTERRUPT2 then
				spi_rd_addr <= X"1C";
			elsif eth_state = HANDLE_RX_INTERRUPT0 then
				spi_rd_addr <= X"3A";
			elsif eth_state = HANDLE_RX_INTERRUPT2 then
				spi_rd_addr <= X"3A";
			elsif eth_state = COPY_RX_PACKET_TO_BUF1 then
				spi_rd_addr <= X"3A";
			elsif eth_state = HANDLE_TX_TRANSMIT19 then
				spi_rd_addr <= X"1C";
			end if;
      end if;
   end process;

	SPI_RD_FLAG_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = SERVICE_INTERRUPT2 then
				spi_rd <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT0 then
				spi_rd <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT2 then
				spi_rd <= '1';
			elsif eth_state = COPY_RX_PACKET_TO_BUF1 then
				spi_rd <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT19 then
				spi_rd <= '1';
			else
				spi_rd <= '0';
			end if;
      end if;
   end process;

	RD_CONTINUOUS_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = COPY_RX_PACKET_TO_BUF1 then
				spi_rd_continuous <= '1';
			elsif eth_state = COPY_RX_PACKET_TO_BUF5 then
				spi_rd_continuous <= '0';
			end if;
      end if;
   end process;

	ENC_VERSION_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = SERVICE_INTERRUPT4 then
				eir_register <= spi_data_rd;
			end if;
			if eth_state = HANDLE_RX_INTERRUPT2 then
				next_packet_pointer(7 downto 0) <= spi_data_rd;
			end if;
			if eth_state = HANDLE_RX_INTERRUPT4 then
				next_packet_pointer(15 downto 8) <= spi_data_rd;
			end if;
      end if;
   end process;

------------------------- RX PACKET --------------------------------

	handle_rx_packet <= '1' when eth_state = COPY_RX_PACKET_TO_BUF6 else '0';
	trigger_ack <= '1' when eth_state = TRIGGER_ACK_PACKET else '0';
	handle_tx_packet <= '1' when eth_state = TRIGGER_TCP_TX1 else '0';
	
	process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = HANDLE_RX_INTERRUPT0 then
				debug_rx_flag <= '1';
			elsif eth_state = HANDLE_RX_INTERRUPT17 then
				debug_rx_flag <= '0';
			end if;
		end if;
	end process;

	RX_PACKET_WR_ADDR: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if eth_state = COPY_RX_PACKET_TO_BUF0 then
				rx_packet_ram_we_addr_buf <= "00000000000";
			elsif eth_state = COPY_RX_PACKET_TO_BUF3 then
				rx_packet_ram_we_addr_buf <= rx_packet_ram_we_addr_buf + 1;
			end if;
			if eth_state = HANDLE_RX_INTERRUPT5 then
				previous_packet_pointer <= unsigned(next_packet_pointer);
			elsif eth_state = COPY_RX_PACKET_TO_BUF3 then
				if previous_packet_pointer = C_rx_pointer_max then
					previous_packet_pointer <= C_rx_pointer_min;
				else
					previous_packet_pointer <= previous_packet_pointer + 1;
				end if;
			end if;
		end if;
	end process;

	rx_packet_ram_we <= '1' when eth_state = COPY_RX_PACKET_TO_BUF3 else '0';
	rx_packet_ram_we_addr <= rx_packet_ram_we_addr_buf when doing_tx_packet_config = '0' else rx_packet_rd2_addr;

	RX_PACKET_RAM : TDP_RAM
		Generic Map (	G_DATA_A_SIZE 	=> spi_data_rd'length,
							G_ADDR_A_SIZE	=> rx_packet_ram_we_addr'length,
							G_RELATION		=> 0, --log2(SIZE_A/SIZE_B)
							G_INIT_ZERO		=> true,
							G_INIT_FILE		=> "")
		Port Map ( CLK_A_IN 	=> CLK_IN,
				 WE_A_IN 		=> rx_packet_ram_we,
				 ADDR_A_IN 		=> slv(rx_packet_ram_we_addr),
				 DATA_A_IN		=> spi_data_rd,
				 DATA_A_OUT		=> rx_packet_rd_data2,
				 CLK_B_IN 		=> CLK_IN,
				 WE_B_IN 		=> '0',
				 ADDR_B_IN 		=> slv(rx_packet_ram_rd_addr),
				 DATA_B_IN 		=> X"00",
				 DATA_B_OUT 	=> rx_packet_rd_data);

	PH_SYNC_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			packet_handler_state <= packet_handler_next_state;
      end if;
   end process;

	rx_packet_handled <= '1' when packet_handler_state = COMPLETE else '0';
	
	send_arp_reply <= '1' when packet_handler_state = TRIGGER_ARP_REPLY else '0';
	send_icmp_reply <= '1' when packet_handler_state = TRIGGER_ICMP_PACKET_REPLY else '0';
	send_dhcp_request <= '1' when packet_handler_state = TRIGGER_DHCP_REQUEST else '0';
	send_tcp_ack_packet <= '1' when packet_handler_state = TRIGGER_TCP_ACK3 else '0';
	send_tcp_tx_packet <= '1' when packet_handler_state = TRIGGER_TCP_PSH_ACK2 else '0';
	
	send_arp_request <= '1' when eth_state = TRIGGER_ARP_REQUEST else '0';
	send_dhcp_discover <= '1' when eth_state = TRIGGER_DHCP_DISCOVER else '0';
	cancel_dhcp_connect <= '1' when eth_state = TRIGGER_CANCEL_DHCP_CONNECT else '0';
	close_tcp_connection <= '1' when eth_state = TRIGGER_CLOSE_TCP_CONNECTION else '0';
	cancel_tcp_connection <= '1' when eth_state = TRIGGER_CANCEL_TCP_CONNECTION else '0';

	PH_NEXT_STATE_DECODE: process (packet_handler_state, handle_rx_packet, rx_packet_status_vector(23), rx_tcp_flags, 
												rx_packet_type, arp_target_ip_addr, rx_tcp_option, tcp_option_addr, total_packet_length,
													rx_tcp_option_length, arp_opcode, expecting_arp_reply, ip_addr, tx_packet_config_cmplt,
														ip_packet_version, ip_packet_destination_ip, dhcp_enable, dhcp_addr_locked, ip_packet_protocol,
															ip_packet_length, udp_source_port, udp_dest_port, dhcp_transaction_id, transaction_id_rd,
																dhcp_magic_cookie, dhcp_option, dhcp_option_length, dhcp_option_addr, expecting_syn_ack,
																	dhcp_message_type, expecting_dhcp_offer, expecting_dhcp_ack, rx_tcp_source_port,
																		listen_port, rx_tcp_dest_port, client_port, ping_enable, rx_tcp_header_length, tcp_sequence_number_p1, 
																			rx_tcp_ack_number, tcp_sequence_number, tcp_acknowledge_number, rx_tcp_seq_number, rx_packet_ram_rd_addr,
																				tx_packet_state)
   begin
      packet_handler_next_state <= packet_handler_state;  --default is to stay in current state
      case (packet_handler_state) is
         when IDLE =>
				if tx_packet_state = IDLE then 		-- only configure new packet if currently not transmitting a packet
					if handle_rx_packet = '1' then
						packet_handler_next_state <= PARSE_SOURCE_MAC0;
					elsif trigger_ack = '1' then
						packet_handler_next_state <= TRIGGER_TCP_ACK0;
					elsif handle_tx_packet = '1' then
						packet_handler_next_state <= CHECK_IF_DATA_TO_SEND;
					end if;
				end if;
			when PARSE_SOURCE_MAC0 =>
				packet_handler_next_state <= PARSE_SOURCE_MAC1;
			when PARSE_SOURCE_MAC1 =>
				packet_handler_next_state <= PARSE_SOURCE_MAC2;
			when PARSE_SOURCE_MAC2 =>
				packet_handler_next_state <= PARSE_SOURCE_MAC3;
			when PARSE_SOURCE_MAC3 =>
				packet_handler_next_state <= PARSE_SOURCE_MAC4;
			when PARSE_SOURCE_MAC4 =>
				packet_handler_next_state <= PARSE_SOURCE_MAC5;
			when PARSE_SOURCE_MAC5 =>
				packet_handler_next_state <= PARSE_SOURCE_MAC6;
			when PARSE_SOURCE_MAC6 =>
				packet_handler_next_state <= PARSE_SOURCE_MAC7;
			when PARSE_SOURCE_MAC7 =>
				packet_handler_next_state <= PARSE_PACKET_TYPE0;
			when PARSE_PACKET_TYPE0 =>
				packet_handler_next_state <= PARSE_PACKET_TYPE1;
			when PARSE_PACKET_TYPE1 =>
				packet_handler_next_state <= PARSE_PACKET_TYPE2;
			when PARSE_PACKET_TYPE2 =>
				packet_handler_next_state <= PARSE_PACKET_TYPE3;
			when PARSE_PACKET_TYPE3 =>
				packet_handler_next_state <= PARSE_PACKET_TYPE4;
			when PARSE_PACKET_TYPE4 =>
				if rx_packet_type = C_ARP_Packet_Type then
					packet_handler_next_state <= HANDLE_ARP_PACKET0;
				elsif rx_packet_type = C_IP_Packet_Type then
					packet_handler_next_state <= HANDLE_IP_PACKET0;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			
			when HANDLE_ARP_PACKET0 =>
				packet_handler_next_state <= HANDLE_ARP_PACKET1;
			when HANDLE_ARP_PACKET1 =>
				packet_handler_next_state <= HANDLE_ARP_PACKET2;
			when HANDLE_ARP_PACKET2 =>
				packet_handler_next_state <= HANDLE_ARP_PACKET3;
			when HANDLE_ARP_PACKET3 =>
				if arp_opcode = C_ARP_Request then
					packet_handler_next_state <= HANDLE_ARP_REQUEST0;
				elsif arp_opcode = C_ARP_Reply then
					packet_handler_next_state <= HANDLE_ARP_REPLY0;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
				
			when HANDLE_ARP_REPLY0 =>
				if expecting_arp_reply = '1' then
					packet_handler_next_state <= HANDLE_ARP_REPLY1;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when HANDLE_ARP_REPLY1 =>
				packet_handler_next_state <= HANDLE_ARP_REPLY2;
			when HANDLE_ARP_REPLY2 =>
				packet_handler_next_state <= HANDLE_ARP_REPLY3;	
			when HANDLE_ARP_REPLY3 =>
				packet_handler_next_state <= HANDLE_ARP_REPLY4;
			when HANDLE_ARP_REPLY4 =>
				packet_handler_next_state <= HANDLE_ARP_REPLY5;
			when HANDLE_ARP_REPLY5 =>
				packet_handler_next_state <= HANDLE_ARP_REPLY6;
			when HANDLE_ARP_REPLY6 =>
				packet_handler_next_state <= HANDLE_ARP_REPLY7;
			when HANDLE_ARP_REPLY7 =>
				packet_handler_next_state <= COMPLETE;
			
			when HANDLE_ARP_REQUEST0 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST1;
			when HANDLE_ARP_REQUEST1 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST2;
			when HANDLE_ARP_REQUEST2 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST3;
			when HANDLE_ARP_REQUEST3 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST4;
			when HANDLE_ARP_REQUEST4 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST5;
			when HANDLE_ARP_REQUEST5 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST6;
			when HANDLE_ARP_REQUEST6 =>
				if arp_target_ip_addr = ip_addr then
					packet_handler_next_state <= HANDLE_ARP_REQUEST7;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when HANDLE_ARP_REQUEST7 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST8;
			when HANDLE_ARP_REQUEST8 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST9;
			when HANDLE_ARP_REQUEST9 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST10;
			when HANDLE_ARP_REQUEST10 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST11;
			when HANDLE_ARP_REQUEST11 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST12;
			when HANDLE_ARP_REQUEST12 =>
				packet_handler_next_state <= HANDLE_ARP_REQUEST13;
			when HANDLE_ARP_REQUEST13 =>
				packet_handler_next_state <= TRIGGER_ARP_REPLY;
				
			when TRIGGER_ARP_REPLY =>
				if tx_packet_config_cmplt = '1' then
					packet_handler_next_state <= COMPLETE;
				end if;
				
			when HANDLE_IP_PACKET0 =>
				packet_handler_next_state <= HANDLE_IP_PACKET1;
			when HANDLE_IP_PACKET1 =>
				packet_handler_next_state <= HANDLE_IP_PACKET2;
			when HANDLE_IP_PACKET2 =>
				packet_handler_next_state <= HANDLE_IP_PACKET3;
			when HANDLE_IP_PACKET3 =>
				packet_handler_next_state <= HANDLE_IP_PACKET4;
			when HANDLE_IP_PACKET4 =>
				packet_handler_next_state <= HANDLE_IP_PACKET5;
			when HANDLE_IP_PACKET5 =>
				packet_handler_next_state <= HANDLE_IP_PACKET6;
			when HANDLE_IP_PACKET6 =>
				packet_handler_next_state <= HANDLE_IP_PACKET7;
			when HANDLE_IP_PACKET7 =>
				packet_handler_next_state <= HANDLE_IP_PACKET8;
			when HANDLE_IP_PACKET8 =>
				packet_handler_next_state <= HANDLE_IP_PACKET9;
			when HANDLE_IP_PACKET9 =>
				packet_handler_next_state <= HANDLE_IP_PACKET10;
			when HANDLE_IP_PACKET10 =>
				if ip_packet_version = C_IPV4_Protocol_Number then
					packet_handler_next_state <= HANDLE_IP_PACKET11;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when HANDLE_IP_PACKET11 =>
				if ip_packet_destination_ip = ip_addr then
					packet_handler_next_state <= HANDLE_IP_PACKET12;
				elsif dhcp_enable = '1' and dhcp_addr_locked = '0' then
					packet_handler_next_state <= HANDLE_IP_PACKET12;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when HANDLE_IP_PACKET12 =>
				if ip_packet_protocol = C_ICMP_Protocol_Number then
					packet_handler_next_state <= PRE_ICMP_PACKET_REPLY;
				elsif ip_packet_protocol = C_UDP_Protocol_Number then
					packet_handler_next_state <= PARSE_UDP_PACKET0;
				elsif ip_packet_protocol = C_TCP_Protocol_Number then
					packet_handler_next_state <= PARSE_TCP_PACKET0;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			
			when PRE_ICMP_PACKET_REPLY =>
				if ip_packet_length = C_ICMP_Ping_Length and ping_enable = '1' then
					packet_handler_next_state <= TRIGGER_ICMP_PACKET_REPLY;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when TRIGGER_ICMP_PACKET_REPLY =>
				if tx_packet_config_cmplt = '1' then
					packet_handler_next_state <= COMPLETE;
				end if;
				
			when PARSE_UDP_PACKET0 =>
				packet_handler_next_state <= PARSE_UDP_PACKET1;
			when PARSE_UDP_PACKET1 =>
				packet_handler_next_state <= PARSE_UDP_PACKET2;
			when PARSE_UDP_PACKET2 =>
				packet_handler_next_state <= PARSE_UDP_PACKET3;
			when PARSE_UDP_PACKET3 =>
				packet_handler_next_state <= PARSE_UDP_PACKET4;
			when PARSE_UDP_PACKET4 =>
				packet_handler_next_state <= PARSE_UDP_PACKET5;
			when PARSE_UDP_PACKET5 =>
				packet_handler_next_state <= PARSE_UDP_PACKET_TYPE0;
			when PARSE_UDP_PACKET_TYPE0 =>
				if udp_source_port = C_DHCP_Source_Port then
					packet_handler_next_state <= PARSE_UDP_PACKET_TYPE1;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when PARSE_UDP_PACKET_TYPE1 =>
				if udp_dest_port = C_DHCP_Dest_Port then
					packet_handler_next_state <= PARSE_DHCP_PACKET0;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
				
			when PARSE_DHCP_PACKET0 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET1;
			when PARSE_DHCP_PACKET1 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET2;
			when PARSE_DHCP_PACKET2 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET3;
			when PARSE_DHCP_PACKET3 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET4;
			when PARSE_DHCP_PACKET4 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET5;
			when PARSE_DHCP_PACKET5 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET6;
			when PARSE_DHCP_PACKET6 =>
				if dhcp_transaction_id = transaction_id_rd then
					packet_handler_next_state <= PARSE_DHCP_PACKET7;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when PARSE_DHCP_PACKET7 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET8;
			when PARSE_DHCP_PACKET8 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET9;
			when PARSE_DHCP_PACKET9 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET10;
			when PARSE_DHCP_PACKET10 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET11;
			when PARSE_DHCP_PACKET11 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET12;
			when PARSE_DHCP_PACKET12 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET13;
			when PARSE_DHCP_PACKET13 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET14;
			when PARSE_DHCP_PACKET14 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET15;
			when PARSE_DHCP_PACKET15 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET16;
			when PARSE_DHCP_PACKET16 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET17;
			when PARSE_DHCP_PACKET17 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET18;
			when PARSE_DHCP_PACKET18 =>
				if C_dhcp_magic_cookie = dhcp_magic_cookie then
					packet_handler_next_state <= PARSE_DHCP_PACKET19;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			
			when PARSE_DHCP_PACKET19 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET20;
			when PARSE_DHCP_PACKET20 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET21;
			when PARSE_DHCP_PACKET21 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET22;
			when PARSE_DHCP_PACKET22 =>
				packet_handler_next_state <= PARSE_DHCP_PACKET23;
			when PARSE_DHCP_PACKET23 =>
				if dhcp_option = X"35" and dhcp_option_length = X"01" then
					packet_handler_next_state <= PARSE_DHCP_PACKET24;
				elsif dhcp_option = X"FF" then
					packet_handler_next_state <= COMPLETE;
				elsif RESIZE(dhcp_option_addr, 16) > total_packet_length then
					packet_handler_next_state <= COMPLETE;
				else
					packet_handler_next_state <= PARSE_DHCP_PACKET19;
				end if;
			when PARSE_DHCP_PACKET24 =>
				if dhcp_message_type = X"02" then -- dhcp offer
					packet_handler_next_state <= CHECK_OFFER_EXPECTED;
				elsif dhcp_message_type = X"04" then -- dhcp decline
					packet_handler_next_state <= COMPLETE;
				elsif dhcp_message_type = X"05" then -- dhcp acknowledge
					packet_handler_next_state <= HANDLE_DHCP_ACK0;
				elsif dhcp_message_type = X"06" then -- dhcp negative acknowledge
					packet_handler_next_state <= COMPLETE;
				elsif dhcp_message_type = X"07" then -- dhcp release
					packet_handler_next_state <= COMPLETE;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			
			when CHECK_OFFER_EXPECTED =>
				if expecting_dhcp_offer = '1' then
					packet_handler_next_state <= TRIGGER_DHCP_REQUEST;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when TRIGGER_DHCP_REQUEST =>
				if tx_packet_config_cmplt = '1' then
					packet_handler_next_state <= COMPLETE;
				end if;
			
			when HANDLE_DHCP_ACK0 =>
				if expecting_dhcp_ack = '1' then
					packet_handler_next_state <= HANDLE_DHCP_ACK1;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when HANDLE_DHCP_ACK1 =>
				packet_handler_next_state <= HANDLE_DHCP_ACK2;
			when HANDLE_DHCP_ACK2 =>
				packet_handler_next_state <= HANDLE_DHCP_ACK3;
			when HANDLE_DHCP_ACK3 =>
				packet_handler_next_state <= HANDLE_DHCP_ACK4;
			when HANDLE_DHCP_ACK4 =>
				packet_handler_next_state <= HANDLE_DHCP_ACK5;
			when HANDLE_DHCP_ACK5 =>
				packet_handler_next_state <= HANDLE_DHCP_ACK6;
			when HANDLE_DHCP_ACK6 =>
				packet_handler_next_state <= HANDLE_DHCP_ACK7;
			when HANDLE_DHCP_ACK7 =>
				packet_handler_next_state <= HANDLE_DHCP_ACK8;
			when HANDLE_DHCP_ACK8 =>
				packet_handler_next_state <= COMPLETE;
			
			when PARSE_TCP_PACKET0 =>
				packet_handler_next_state <= PARSE_TCP_PACKET1;
			when PARSE_TCP_PACKET1 =>
				packet_handler_next_state <= PARSE_TCP_PACKET2;
			when PARSE_TCP_PACKET2 =>
				packet_handler_next_state <= PARSE_TCP_PACKET3;
			when PARSE_TCP_PACKET3 =>
				packet_handler_next_state <= PARSE_TCP_PACKET4;
			when PARSE_TCP_PACKET4 =>
				packet_handler_next_state <= PARSE_TCP_PACKET5;
			when PARSE_TCP_PACKET5 =>
				if rx_tcp_source_port = client_port then
					packet_handler_next_state <= PARSE_TCP_PACKET6;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when PARSE_TCP_PACKET6 =>
				if rx_tcp_dest_port = listen_port then
					packet_handler_next_state <= PARSE_TCP_PACKET7;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when PARSE_TCP_PACKET7 =>
				packet_handler_next_state <= PARSE_TCP_PACKET8;
			when PARSE_TCP_PACKET8 =>
				packet_handler_next_state <= PARSE_TCP_PACKET9;
			when PARSE_TCP_PACKET9 =>
				packet_handler_next_state <= PARSE_TCP_PACKET10;
			when PARSE_TCP_PACKET10 =>
				packet_handler_next_state <= PARSE_TCP_PACKET11;
			when PARSE_TCP_PACKET11 =>
				packet_handler_next_state <= PARSE_TCP_PACKET12;
			when PARSE_TCP_PACKET12 =>
				packet_handler_next_state <= PARSE_TCP_PACKET13;
			when PARSE_TCP_PACKET13 =>
				packet_handler_next_state <= PARSE_TCP_PACKET14;
			when PARSE_TCP_PACKET14 =>
				packet_handler_next_state <= PARSE_TCP_PACKET15;
			when PARSE_TCP_PACKET15 =>
				packet_handler_next_state <= PARSE_TCP_PACKET16;
			when PARSE_TCP_PACKET16 =>
				packet_handler_next_state <= PARSE_TCP_PACKET17;
			when PARSE_TCP_PACKET17 =>
				packet_handler_next_state <= PARSE_TCP_PACKET18;
			when PARSE_TCP_PACKET18 =>
				packet_handler_next_state <= PARSE_TCP_PACKET19;	
			when PARSE_TCP_PACKET19 =>
				if rx_tcp_flags(4 downto 1) = X"1" and tcp_connection_active = '0' then -- SYN PACKET (READ OPTIONS)
					packet_handler_next_state <= PARSE_TCP_PACKET20;
				else
					packet_handler_next_state <= PARSE_TCP_PACKET25;
				end if;
			when PARSE_TCP_PACKET20 =>
				packet_handler_next_state <= PARSE_TCP_PACKET21;
			when PARSE_TCP_PACKET21 =>
				packet_handler_next_state <= PARSE_TCP_PACKET22;
			when PARSE_TCP_PACKET22 =>
				packet_handler_next_state <= PARSE_TCP_PACKET23;
			when PARSE_TCP_PACKET23 =>
				packet_handler_next_state <= PARSE_TCP_PACKET24;
			when PARSE_TCP_PACKET24 =>
				if rx_tcp_option = X"03" then
					packet_handler_next_state <= PARSE_TCP_PACKET25;
				elsif rx_tcp_option = X"01" then
					packet_handler_next_state <= PARSE_TCP_PACKET26;
				elsif RESIZE(tcp_option_addr, 16) > total_packet_length then
					packet_handler_next_state <= COMPLETE;
				else
					packet_handler_next_state <= PARSE_TCP_PACKET27;
				end if;
			when PARSE_TCP_PACKET25 =>
				if rx_tcp_flags(4 downto 1) = X"1" and tcp_connection_active = '0' then
					packet_handler_next_state <= CHECK_TCP_SYN_PACKET0;
				elsif rx_tcp_flags(4 downto 1) = X"C" or rx_tcp_flags(4 downto 1) = X"8" then
					packet_handler_next_state <= CHECK_TCP_PSH_ACK_PACKET0;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when PARSE_TCP_PACKET26 =>
				packet_handler_next_state <= PARSE_TCP_PACKET20;
			when PARSE_TCP_PACKET27 =>
				if rx_tcp_option_length = X"00" then
					packet_handler_next_state <= COMPLETE;
				else
					packet_handler_next_state <= PARSE_TCP_PACKET20;
				end if;
			when CHECK_TCP_SYN_PACKET0 =>
				packet_handler_next_state <= CHECK_TCP_SYN_PACKET1;
			when CHECK_TCP_SYN_PACKET1 =>
				packet_handler_next_state <= CHECK_TCP_SYN_PACKET2;
			when CHECK_TCP_SYN_PACKET2 =>
				packet_handler_next_state <= CHECK_TCP_SYN_PACKET3;
			when CHECK_TCP_SYN_PACKET3 =>
				packet_handler_next_state <= CHECK_TCP_SYN_PACKET4;
			when CHECK_TCP_SYN_PACKET4 =>
				packet_handler_next_state <= CHECK_TCP_SYN_PACKET5;
			when CHECK_TCP_SYN_PACKET5 =>
				packet_handler_next_state <= TRIGGER_TCP_ACK0;
				
			when CHECK_TCP_PSH_ACK_PACKET0 =>
				if tcp_sequence_number = unsigned(rx_tcp_ack_number) then
					packet_handler_next_state <= CHECK_TCP_PSH_ACK_PACKET1;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when CHECK_TCP_PSH_ACK_PACKET1 =>
				if tcp_acknowledge_number = unsigned(rx_tcp_seq_number) then
					packet_handler_next_state <= CHECK_TCP_PSH_ACK_PACKET2;
				else
					packet_handler_next_state <= RESEND_ACK;	-- ACK failed to reach target, resend
				end if;
			when CHECK_TCP_PSH_ACK_PACKET2 =>
				if rx_data_length /= X"0000" then
					packet_handler_next_state <= CHECK_TCP_PSH_ACK_PACKET3;
				else
					packet_handler_next_state <= COMPLETE; -- This was just an ACK
				end if;
			when CHECK_TCP_PSH_ACK_PACKET3 =>
				packet_handler_next_state <= READ_TCP_RX_DATA;
				
			when READ_TCP_RX_DATA =>
				if RESIZE(rx_packet_ram_rd_addr, 16) > total_packet_length then
					packet_handler_next_state <= COMPLETE;
				end if;

			when TRIGGER_TCP_ACK0 =>
				packet_handler_next_state <= TRIGGER_TCP_ACK1;
			when TRIGGER_TCP_ACK1 =>
				if window_size > X"136" then
					packet_handler_next_state <= TRIGGER_TCP_ACK2;
				end if;
			when TRIGGER_TCP_ACK2 =>
				packet_handler_next_state <= TRIGGER_TCP_ACK3;
			when TRIGGER_TCP_ACK3 =>
				if tx_packet_state = INIT_TCP_PACKET_METADATA then
					packet_handler_next_state <= COMPLETE;
				end if;

			when RESEND_ACK =>
				packet_handler_next_state <= COMPLETE;
			
			when CHECK_IF_DATA_TO_SEND =>
				if tcp_wr_data_count /= X"000" then
					packet_handler_next_state <= TRIGGER_TCP_PSH_ACK0;
				else
					packet_handler_next_state <= COMPLETE;
				end if;
			when TRIGGER_TCP_PSH_ACK0 =>
				packet_handler_next_state <= TRIGGER_TCP_PSH_ACK1;
			when TRIGGER_TCP_PSH_ACK1 =>										 
				if rx_tcp_window_size_shifted(31 downto 12) = X"00000" then
					packet_handler_next_state <= CHECK_TCP_WINDOW_SIZE;
				else
					packet_handler_next_state <= TRIGGER_TCP_PSH_ACK2; 
				end if;
			when CHECK_TCP_WINDOW_SIZE =>
				if tx_bytes_to_send > unsigned(rx_tcp_window_size_shifted(11 downto 0)) then -- server is not ready to receive data yet
					packet_handler_next_state <= RX_TCP_WINDOW_TOO_SMALL;
				else
					packet_handler_next_state <= TRIGGER_TCP_PSH_ACK2; 
				end if;
			when TRIGGER_TCP_PSH_ACK2 =>
				if tx_packet_state = SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH0 then -- wait until packet is formed before incrementing sequence number
					packet_handler_next_state <= TRIGGER_TCP_PSH_ACK3;
				end if;
			when TRIGGER_TCP_PSH_ACK3 =>
				packet_handler_next_state <= COMPLETE;
			
			when RX_TCP_WINDOW_TOO_SMALL =>
				packet_handler_next_state <= IDLE;
			when COMPLETE =>
				packet_handler_next_state <= IDLE;
				
		end case;
	end process;

	ACK_TIMER_PROC: process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if packet_handler_state = CHECK_TCP_PSH_ACK_PACKET3 then
				ack_countdown <= C_250us;
			elsif ack_countdown /= X"0000" then
				ack_countdown <= ack_countdown - 1;
			end if;
			if ack_countdown = X"0001" then
				ack_required <= '1';
			elsif trigger_fin_ack = '1' then
				ack_required <= '1';
			elsif packet_handler_state = TRIGGER_TCP_ACK0 then
				ack_required <= '0';
			end if;
			if packet_handler_state = RESEND_ACK then
				resend_ack_packet <= '1';
			elsif eth_state = RESEND_ACK_IN_BUFFER then
				resend_ack_packet <= '0';
			end if;
			if packet_handler_state = RX_TCP_WINDOW_TOO_SMALL then
				wait_for_tcp_window_size_update <= '1';
			elsif packet_handler_state = PARSE_TCP_PACKET25 then
				wait_for_tcp_window_size_update <= '0';
			end if;
		end if;
	end process;

	RX_PACKET_RD_ADDR: process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if packet_handler_state = PARSE_SOURCE_MAC0 then
				rx_packet_ram_rd_addr <= "000"&X"0A";
			elsif packet_handler_state = PARSE_PACKET_TYPE0 then
				rx_packet_ram_rd_addr <= "000"&X"10";
			elsif packet_handler_state = HANDLE_ARP_REQUEST0 then
				rx_packet_ram_rd_addr <= "000"&X"2A";
			elsif packet_handler_state = HANDLE_ARP_REQUEST7 then
				rx_packet_ram_rd_addr <= "000"&X"20";
			elsif packet_handler_state = HANDLE_IP_PACKET0 then
				rx_packet_ram_rd_addr <= "000"&X"12";
			elsif packet_handler_state = HANDLE_IP_PACKET1 then
				rx_packet_ram_rd_addr <= "000"&X"1B";
			elsif packet_handler_state = HANDLE_IP_PACKET2 then
				rx_packet_ram_rd_addr <= "000"&X"22";
			elsif packet_handler_state = HANDLE_IP_PACKET6 then
				rx_packet_ram_rd_addr <= "000"&X"14";
			elsif packet_handler_state = PARSE_UDP_PACKET0 then
				rx_packet_ram_rd_addr <= "000"&X"26";
			elsif packet_handler_state = PARSE_DHCP_PACKET0 then
				rx_packet_ram_rd_addr <= "000"&X"32";
			elsif packet_handler_state = PARSE_DHCP_PACKET4 then
				rx_packet_ram_rd_addr <= "000"&X"3E";
			elsif packet_handler_state = PARSE_DHCP_PACKET12 then
				rx_packet_ram_rd_addr <= "001"&X"1A";
			elsif packet_handler_state = PARSE_DHCP_PACKET19 then
				rx_packet_ram_rd_addr <= dhcp_option_addr;
			elsif packet_handler_state = HANDLE_ARP_PACKET0 then
				rx_packet_ram_rd_addr <= "000"&X"19";
			elsif packet_handler_state = HANDLE_ARP_REPLY0 then
				rx_packet_ram_rd_addr <= "000"&X"1A";
			elsif packet_handler_state = PARSE_TCP_PACKET0 then
				rx_packet_ram_rd_addr <= next_protocol_start_addr;
			elsif packet_handler_state = PARSE_TCP_PACKET20 then
				rx_packet_ram_rd_addr <= tcp_option_addr;
			elsif packet_handler_state = CHECK_TCP_PSH_ACK_PACKET1 then
				rx_packet_ram_rd_addr <= rx_data_start_addr;
			elsif packet_handler_state = HANDLE_DHCP_ACK1 then
				rx_packet_ram_rd_addr <= "000"&X"0A";
			else
				rx_packet_ram_rd_addr <= rx_packet_ram_rd_addr + 1;
			end if;
			if packet_handler_state = HANDLE_ARP_PACKET2 then
				arp_opcode <= rx_packet_rd_data;
			end if;
			if packet_handler_state = HANDLE_ARP_REQUEST9 then
				arp_source_ip_addr(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_ARP_REQUEST10 then
				arp_source_ip_addr(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_ARP_REQUEST11 then
				arp_source_ip_addr(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_ARP_REQUEST12 then
				arp_source_ip_addr(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = HANDLE_ARP_REQUEST2 then
				arp_target_ip_addr(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_ARP_REQUEST3 then
				arp_target_ip_addr(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_ARP_REQUEST4 then
				arp_target_ip_addr(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_ARP_REQUEST5 then
				arp_target_ip_addr(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_SOURCE_MAC2 then
				rx_packet_source_mac(47 downto 40) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_SOURCE_MAC3 then
				rx_packet_source_mac(39 downto 32) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_SOURCE_MAC4 then
				rx_packet_source_mac(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_SOURCE_MAC5 then
				rx_packet_source_mac(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_SOURCE_MAC6 then
				rx_packet_source_mac(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_SOURCE_MAC7 then
				rx_packet_source_mac(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_PACKET_TYPE2 then
				rx_packet_type(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_PACKET_TYPE3 then
				rx_packet_type(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = HANDLE_IP_PACKET2 then
				ip_packet_version <= rx_packet_rd_data(7 downto 4);
			end if;
			if packet_handler_state = HANDLE_IP_PACKET3 then
				ip_packet_protocol <= rx_packet_rd_data;
			end if;
			if packet_handler_state = HANDLE_IP_PACKET2 then
				ip_packet_header_length(3 downto 0) <= rx_packet_rd_data(3 downto 0);
				ip_packet_header_length(7 downto 4) <= X"0";
			elsif packet_handler_state = HANDLE_IP_PACKET3 then
				ip_packet_header_length <= ip_packet_header_length(5 downto 0) & "00";
			end if;
			if packet_handler_state = HANDLE_IP_PACKET4 then
				next_protocol_start_addr <= RESIZE(unsigned(ip_packet_header_length), 11) + "00000010010"; -- src/dest mac + protocol + status reg (4 bytes)
			end if;
			if packet_handler_state = HANDLE_IP_PACKET4 then
				ip_packet_destination_ip(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_IP_PACKET5 then
				ip_packet_destination_ip(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_IP_PACKET6 then
				ip_packet_destination_ip(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_IP_PACKET7 then
				ip_packet_destination_ip(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = HANDLE_IP_PACKET8 then
				ip_packet_length(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = HANDLE_IP_PACKET9 then
				ip_packet_length(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = HANDLE_IP_PACKET10 then -- TODO Rename ip_packet_length ?
				total_packet_length <= unsigned(ip_packet_length) + X"0012"; -- src/dest mac + protocol + status reg (4 bytes)
			end if;
			if packet_handler_state = PARSE_UDP_PACKET2 then
				udp_source_port(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_UDP_PACKET3 then
				udp_source_port(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_UDP_PACKET4 then
				udp_dest_port(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_UDP_PACKET5 then
				udp_dest_port(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_DHCP_PACKET2 then
				transaction_id_rd(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET3 then
				transaction_id_rd(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET4 then
				transaction_id_rd(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET5 then
				transaction_id_rd(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_DHCP_PACKET6 then
				dhcp_your_ip_addr(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET7 then
				dhcp_your_ip_addr(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET8 then
				dhcp_your_ip_addr(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET9 then
				dhcp_your_ip_addr(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_DHCP_PACKET10 then
				dhcp_server_ip_addr(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET11 then
				dhcp_server_ip_addr(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET12 then
				dhcp_server_ip_addr(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET13 then
				dhcp_server_ip_addr(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_DHCP_PACKET14 then
				dhcp_magic_cookie(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET15 then
				dhcp_magic_cookie(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET16 then
				dhcp_magic_cookie(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_DHCP_PACKET17 then
				dhcp_magic_cookie(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_DHCP_PACKET21 then
				dhcp_option <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_DHCP_PACKET22 then
				dhcp_option_length <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_DHCP_PACKET18 then
				dhcp_option_addr <= "001"&X"1E";
			elsif packet_handler_state = PARSE_DHCP_PACKET23 then
				dhcp_option_addr <= dhcp_option_addr + RESIZE(unsigned(dhcp_option_length), 11);
			end if;
			if packet_handler_state = PARSE_DHCP_PACKET23 then
				dhcp_message_type <= rx_packet_rd_data;
			end if;
			if (packet_handler_state = CHECK_TCP_SYN_PACKET0) then
				client_mac_addr(47 downto 40) <= rx_packet_source_mac(47 downto 40);
			elsif (packet_handler_state = CHECK_TCP_SYN_PACKET1) then
				client_mac_addr(39 downto 32) <= rx_packet_source_mac(39 downto 32);
			elsif (packet_handler_state = CHECK_TCP_SYN_PACKET2) then
				client_mac_addr(31 downto 24) <= rx_packet_source_mac(31 downto 24);
			elsif (packet_handler_state = CHECK_TCP_SYN_PACKET3) then
				client_mac_addr(23 downto 16) <= rx_packet_source_mac(23 downto 16);
			elsif (packet_handler_state = CHECK_TCP_SYN_PACKET4) then
				client_mac_addr(15 downto 8) <= rx_packet_source_mac(15 downto 8);
			elsif (packet_handler_state = CHECK_TCP_SYN_PACKET5) then
				client_mac_addr(7 downto 0) <= rx_packet_source_mac(7 downto 0);
			end if;
			if packet_handler_state = PARSE_TCP_PACKET2 then
				rx_tcp_source_port(15 downto 8) <= rx_packet_rd_data; 
			elsif packet_handler_state = PARSE_TCP_PACKET3 then
				rx_tcp_source_port(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET4 then
				rx_tcp_dest_port(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET5 then
				rx_tcp_dest_port(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET6 then
				rx_tcp_seq_number(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET7 then
				rx_tcp_seq_number(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET8 then
				rx_tcp_seq_number(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET9 then
				rx_tcp_seq_number(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET10 then
				rx_tcp_ack_number(31 downto 24) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET11 then
				rx_tcp_ack_number(23 downto 16) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET12 then
				rx_tcp_ack_number(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET13 then
				rx_tcp_ack_number(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET14 then
				rx_tcp_header_length <= "00"&rx_packet_rd_data(7 downto 2);
			end if;
			if packet_handler_state = PARSE_TCP_PACKET15 then
				rx_tcp_flags <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET14 then
				rx_data_length <= unsigned(ip_packet_length);
			elsif packet_handler_state = PARSE_TCP_PACKET15 then
				rx_data_length <= rx_data_length - RESIZE(unsigned(rx_tcp_header_length), 16);
			elsif packet_handler_state = PARSE_TCP_PACKET16 then
				rx_data_length <= rx_data_length - RESIZE(unsigned(ip_packet_header_length), 16);
			end if;
			if packet_handler_state = PARSE_TCP_PACKET15 then
				rx_data_start_addr <= next_protocol_start_addr;
			elsif packet_handler_state = PARSE_TCP_PACKET16 then
				rx_data_start_addr <= rx_data_start_addr + RESIZE(unsigned(rx_tcp_header_length), 11);
			end if;
			if packet_handler_state = PARSE_TCP_PACKET16 then
				rx_tcp_window_size(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET17 then
				rx_tcp_window_size(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET18 then
				rx_tcp_checksum(15 downto 8) <= rx_packet_rd_data;
			elsif packet_handler_state = PARSE_TCP_PACKET19 then
				rx_tcp_checksum(7 downto 0) <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET19 then
				tcp_option_addr <= rx_packet_ram_rd_addr + "00000000010"; -- skip 2 blanks after checksum
			elsif packet_handler_state = PARSE_TCP_PACKET26 then
				tcp_option_addr <= tcp_option_addr + 1;
			elsif packet_handler_state = PARSE_TCP_PACKET27 then
				tcp_option_addr <= tcp_option_addr + RESIZE(rx_tcp_option_length, 11);
			end if;
			if packet_handler_state = PARSE_TCP_PACKET22 then
				rx_tcp_option <= rx_packet_rd_data;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET23 then
				rx_tcp_option_length <= unsigned(rx_packet_rd_data);
			end if;
			if packet_handler_state = PARSE_TCP_PACKET24 then
				rx_tcp_window_shift <= rx_packet_rd_data(3 downto 0);
			end if;
		end if;
	end process;
	
	-- TODO Could disable window shift via linux kernel..?
	with rx_tcp_window_shift select
		rx_tcp_window_size_shifted <= "0000000000000000"&rx_tcp_window_size when X"0",
												"000000000000000"&rx_tcp_window_size&"0" when X"1",
												"00000000000000"&rx_tcp_window_size&"00" when X"2",
												"0000000000000"&rx_tcp_window_size&"000" when X"3",
												"000000000000"&rx_tcp_window_size&"0000" when X"4",
												"00000000000"&rx_tcp_window_size&"00000" when X"5",
												"0000000000"&rx_tcp_window_size&"000000" when X"6",
												"000000000"&rx_tcp_window_size&"0000000" when X"7",
												"00000000"&rx_tcp_window_size&"00000000" when X"8",
												"0000000"&rx_tcp_window_size&"000000000" when X"9",
												"000000"&rx_tcp_window_size&"0000000000" when X"A",
												"00000"&rx_tcp_window_size&"00000000000" when X"B",
												"0000"&rx_tcp_window_size&"000000000000" when X"C",
												"000"&rx_tcp_window_size&"0000000000000" when X"D",
												"00"&rx_tcp_window_size&"00000000000000" when X"E",
												"0"&rx_tcp_window_size&"000000000000000" when others;

	DHCP_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if packet_handler_state = HANDLE_DHCP_ACK1 then
				ip_addr <= dhcp_your_ip_addr;
				client_ip_addr <= dhcp_server_ip_addr;
			end if;
			if tx_packet_state = INIT_DHCP_DISCOVER_METADATA then
				expecting_dhcp_offer <= '1';
			elsif tx_packet_state = INIT_DHCP_REQUEST_METADATA then
				expecting_dhcp_offer <= '0';
			elsif tx_packet_state = CANCEL_DHCP_CONNECT_ST then
				expecting_dhcp_offer <= '0';
			end if;
			if tx_packet_state = INIT_DHCP_REQUEST_METADATA then
				expecting_dhcp_ack <= '1';
			elsif packet_handler_state = HANDLE_DHCP_ACK1 then
				expecting_dhcp_ack <= '0';
			elsif tx_packet_state = CANCEL_DHCP_CONNECT_ST then
				expecting_dhcp_ack <= '0';
			end if;
			if eth_state = TRIGGER_DHCP_DISCOVER then
				dhcp_addr_locked <= '0';
			elsif packet_handler_state = HANDLE_DHCP_ACK1 then
				dhcp_addr_locked <= '1';
			end if;
			if eth_state = TRIGGER_ARP_REQUEST then
				expecting_arp_reply <= '1';
			elsif packet_handler_state = HANDLE_ARP_REPLY1 then
				expecting_arp_reply <= '0';
			end if;
			if packet_handler_state = HANDLE_ARP_REPLY7 then
				static_addr_locked <= '1';
			elsif tx_packet_state = INIT_ARP_REQUEST_METADATA then
				static_addr_locked <= '0';
			elsif tx_packet_state = CANCEL_DHCP_CONNECT_ST then
				static_addr_locked <= '0';
			end if;
      end if;
   end process;	
				

--------------------- TX PACKET ------------------------------	

	TP_SYNC_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			tx_packet_state <= tx_packet_next_state;
      end if;
   end process;

	TP_NEXT_STATE_DECODE: process (tx_packet_state, send_arp_reply, send_arp_request, send_icmp_reply, 
												send_dhcp_discover, send_dhcp_request, frame_rd_cmplt, send_tcp_ack_packet, 
													cancel_dhcp_connect, close_tcp_connection, cancel_tcp_connection, 
														packet_instruction, checksum_calc_done)
   begin
      tx_packet_next_state <= tx_packet_state;  --default is to stay in current state
      case (tx_packet_state) is
         when IDLE =>
				if send_arp_reply = '1' then
					tx_packet_next_state <= INIT_ARP_REPLY_METADATA;
				elsif send_arp_request = '1' then
					tx_packet_next_state <= INIT_ARP_REQUEST_METADATA;
				elsif send_icmp_reply = '1' then
					tx_packet_next_state <= INIT_ICMP_REPLY_METADATA;
				elsif send_dhcp_discover = '1' then
					tx_packet_next_state <= INIT_DHCP_DISCOVER_METADATA;
				elsif send_dhcp_request = '1' then
					tx_packet_next_state <= INIT_DHCP_REQUEST_METADATA;
				elsif send_tcp_ack_packet = '1' then
					tx_packet_next_state <= INIT_TCP_PACKET_METADATA;
				elsif cancel_dhcp_connect = '1' then
					tx_packet_next_state <= CANCEL_DHCP_CONNECT_ST;
				elsif close_tcp_connection = '1' then
					tx_packet_next_state <= TCP_CONNECTION_CLOSED;
				elsif cancel_tcp_connection = '1' then
					tx_packet_next_state <= CANCEL_TCP_CONNECTION_ST;
				elsif send_tcp_tx_packet = '1' then
					tx_packet_next_state <= INIT_TCP_TX_PACKET_METADATA;
				end if;
			when CANCEL_DHCP_CONNECT_ST =>
				tx_packet_next_state <= IDLE;
			when CANCEL_TCP_CONNECTION_ST =>
				tx_packet_next_state <= IDLE;
			when TCP_CONNECTION_CLOSED =>
				tx_packet_next_state <= IDLE;
			when INIT_ARP_REPLY_METADATA =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when INIT_ARP_REQUEST_METADATA =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when INIT_ICMP_REPLY_METADATA =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when INIT_DHCP_DISCOVER_METADATA =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when INIT_DHCP_REQUEST_METADATA =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when INIT_TCP_PACKET_METADATA =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when INIT_TCP_TX_PACKET_METADATA =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when READ_PACKET_BYTE0 =>
				tx_packet_next_state <= READ_PACKET_BYTE1;
			when READ_PACKET_BYTE1 =>
				if frame_rd_cmplt = '1' then
					tx_packet_next_state <= HANDLE_PACKET_INSTRUCTION0;
				end if;
			when HANDLE_PACKET_INSTRUCTION0 =>
				if packet_instruction = X"FF" then
					tx_packet_next_state <= COMPLETE;
				elsif packet_instruction = X"17" then
					tx_packet_next_state <= SET_RX_PACKET_ADDR_LOWER_BYTE;
				elsif packet_instruction = X"18" then
					tx_packet_next_state <= SET_RX_PACKET_ADDR_UPPER_BYTE;
				elsif packet_instruction = X"20" then
					tx_packet_next_state <= SET_CHECKSUM_LENGTH_LSB;
				elsif packet_instruction = X"21" then
					tx_packet_next_state <= SET_CHECKSUM_LENGTH_MSB;
				elsif packet_instruction = X"22" then
					tx_packet_next_state <= SET_CHECKSUM_START_ADDR_LSB;
				elsif packet_instruction = X"23" then
					tx_packet_next_state <= SET_CHECKSUM_START_ADDR_MSB;
				elsif packet_instruction = X"24" then
					tx_packet_next_state <= SET_CHECKSUM_WR_ADDR_LSB;
				elsif packet_instruction = X"25" then
					tx_packet_next_state <= SET_CHECKSUM_WR_ADDR_MSB;
				elsif packet_instruction = X"26" then
					tx_packet_next_state <= TRIG_CHECKSUM_CALC;
				elsif packet_instruction = X"29" then
					tx_packet_next_state <= MOVE_TX_PACKET_WR_ADDR;
				elsif packet_instruction = X"2E" then
					tx_packet_next_state <= SET_NEW_TRANSACTION_ID;
				elsif packet_instruction = X"50" then
					tx_packet_next_state <= SET_CHECKSUM_START_VAL_LSB;
				elsif packet_instruction = X"51" then
					tx_packet_next_state <= SET_CHECKSUM_START_VAL_MSB;
				elsif packet_instruction = X"52" then
					tx_packet_next_state <= TRIGGER_CHECKSUM_LOAD_INITIAL_VALUE;
				elsif packet_instruction = X"57" then
					tx_packet_next_state <= INIT_LOAD_TX_PACKET_DATA;
				elsif packet_instruction = X"58" then
					tx_packet_next_state <= SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH0;
				elsif packet_instruction = X"59" then
					tx_packet_next_state <= SET_CHECKSUM_INITIAL_VALUE_TX_PACKET;
				else
					tx_packet_next_state <= HANDLE_PACKET_INSTRUCTION1;
				end if;
			when HANDLE_PACKET_INSTRUCTION1 =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			
			when SET_RX_PACKET_ADDR_LOWER_BYTE =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when SET_RX_PACKET_ADDR_UPPER_BYTE =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			
			when SET_CHECKSUM_LENGTH_LSB =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when SET_CHECKSUM_LENGTH_MSB =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
				
			when SET_CHECKSUM_START_ADDR_LSB =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when SET_CHECKSUM_START_ADDR_MSB =>
				tx_packet_next_state <= READ_PACKET_BYTE0;		

			when SET_CHECKSUM_WR_ADDR_LSB =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when SET_CHECKSUM_WR_ADDR_MSB =>
				tx_packet_next_state <= READ_PACKET_BYTE0;		
			
			when SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH0 =>
				tx_packet_next_state <= SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH1;
			when SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH1 =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			
			when TRIG_CHECKSUM_CALC =>
				tx_packet_next_state <= WAIT_FOR_CHECKSUM_CMPLT;
			when WAIT_FOR_CHECKSUM_CMPLT =>
				if checksum_calc_done = '1' then
					tx_packet_next_state <= READ_PACKET_BYTE0;
				end if;

			when MOVE_TX_PACKET_WR_ADDR =>
				tx_packet_next_state <= READ_PACKET_BYTE0;

			when SET_NEW_TRANSACTION_ID =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
				
			when SET_CHECKSUM_START_VAL_LSB =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when SET_CHECKSUM_START_VAL_MSB =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when TRIGGER_CHECKSUM_LOAD_INITIAL_VALUE =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			when SET_CHECKSUM_INITIAL_VALUE_TX_PACKET =>
				tx_packet_next_state <= READ_PACKET_BYTE0;
			
			when INIT_LOAD_TX_PACKET_DATA =>
				tx_packet_next_state <= LOAD_TX_PACKET_DATA;
			when LOAD_TX_PACKET_DATA =>
				if tx_packet_data_counter = X"001" then
					tx_packet_next_state <= HANDLE_PACKET_INSTRUCTION1;
				end if;
			
			when COMPLETE =>
				tx_packet_next_state <= IDLE;
				
		end case;
	end process;
	
	packet_instruction <= frame_data(15 downto 8);
	
	with packet_instruction(6 downto 0) select 
		packet_data <= frame_data(7 downto 0) 							when "000"&X"0",
							mac_addr(7 downto 0) 							when "000"&X"1",
							mac_addr(15 downto 8) 							when "000"&X"2",
							mac_addr(23 downto 16) 							when "000"&X"3",
							mac_addr(31 downto 24) 							when "000"&X"4",
							mac_addr(39 downto 32) 							when "000"&X"5",
							mac_addr(47 downto 40) 							when "000"&X"6",
							rx_packet_source_mac(7 downto 0) 			when "000"&X"7",
							rx_packet_source_mac(15 downto 8) 			when "000"&X"8",
							rx_packet_source_mac(23 downto 16) 			when "000"&X"9",
							rx_packet_source_mac(31 downto 24) 			when "000"&X"A",
							rx_packet_source_mac(39 downto 32) 			when "000"&X"B",
							rx_packet_source_mac(47 downto 40) 			when "000"&X"C",
							ip_addr(7 downto 0) 								when "000"&X"D",
							ip_addr(15 downto 8) 							when "000"&X"E",
							ip_addr(23 downto 16) 							when "000"&X"F",
							ip_addr(31 downto 24) 							when "001"&X"0",
							arp_source_ip_addr(7 downto 0) 				when "001"&X"1",
							arp_source_ip_addr(15 downto 8) 				when "001"&X"2",
							arp_source_ip_addr(23 downto 16) 			when "001"&X"3",
							arp_source_ip_addr(31 downto 24) 			when "001"&X"4",
							ip_identification(7 downto 0)					when "001"&X"5",
							ip_identification(15 downto 8)					when "001"&X"6",
							X"00"													when "001"&X"7", -- set rx read lower byte
							X"00"													when "001"&X"8", -- set rx read upper byte
							rx_packet_rd_data2								when "001"&X"9",
							cloud_ip_addr(7 downto 0)						when "001"&X"A",
							cloud_ip_addr(15 downto 8)						when "001"&X"B",
							cloud_ip_addr(23 downto 16)					when "001"&X"C",
							cloud_ip_addr(31 downto 24)					when "001"&X"D",
							X"00"													when "010"&X"0", -- set checksum length lsb
							X"00"													when "010"&X"1", -- set checksum length msb
							X"00"													when "010"&X"2", -- set checksum start addr lsb
							X"00"													when "010"&X"3", -- set checksum start addr msb
							X"00"													when "010"&X"4", -- set checksum wr addr lsb
							X"00"													when "010"&X"5", -- set checksum wr addr msb
							X"00"													when "010"&X"6", -- trigger checksum calc
							checksum(7 downto 0)  							when "010"&X"7",
							checksum(15 downto 8)  							when "010"&X"8",
							X"00"													when "010"&X"9", -- set tx write addr to checksum wr addr
							dhcp_transaction_id(7 downto 0)				when "010"&X"A",
							dhcp_transaction_id(15 downto 8)				when "010"&X"B",
							dhcp_transaction_id(23 downto 16)			when "010"&X"C",
							dhcp_transaction_id(31 downto 24)			when "010"&X"D",
							X"00"													when "010"&X"E", -- set new transaction ID
							dhcp_server_ip_addr(7 downto 0)				when "010"&X"F",
							dhcp_server_ip_addr(15 downto 8)				when "011"&X"0",
							dhcp_server_ip_addr(23 downto 16)			when "011"&X"1",
							dhcp_server_ip_addr(31 downto 24)			when "011"&X"2",
							dhcp_your_ip_addr(7 downto 0)					when "011"&X"3",
							dhcp_your_ip_addr(15 downto 8)				when "011"&X"4",
							dhcp_your_ip_addr(23 downto 16)				when "011"&X"5",
							dhcp_your_ip_addr(31 downto 24)				when "011"&X"6",
							client_ip_addr(7 downto 0)						when "011"&X"7",
							client_ip_addr(15 downto 8)					when "011"&X"8",
							client_ip_addr(23 downto 16)					when "011"&X"9",
							client_ip_addr(31 downto 24)					when "011"&X"A",
							client_mac_addr(7 downto 0) 					when "011"&X"B",
							client_mac_addr(15 downto 8) 					when "011"&X"C",
							client_mac_addr(23 downto 16) 				when "011"&X"D",
							client_mac_addr(31 downto 24) 				when "011"&X"E",
							client_mac_addr(39 downto 32) 				when "011"&X"F",
							client_mac_addr(47 downto 40) 				when "100"&X"0",
							listen_port(7 downto 0)							when "100"&X"1",
							listen_port(15 downto 8)						when "100"&X"2",
							client_port(7 downto 0)							when "100"&X"3",
							client_port(15 downto 8)						when "100"&X"4",
							slv(tcp_sequence_number(7 downto 0))		when "100"&X"5",
							slv(tcp_sequence_number(15 downto 8))		when "100"&X"6",
							slv(tcp_sequence_number(23 downto 16))		when "100"&X"7",
							slv(tcp_sequence_number(31 downto 24))		when "100"&X"8",
							slv(tcp_acknowledge_number(7 downto 0))			when "100"&X"9",
							slv(tcp_acknowledge_number(15 downto 8))			when "100"&X"A",
							slv(tcp_acknowledge_number(23 downto 16))			when "100"&X"B",
							slv(tcp_acknowledge_number(31 downto 24))			when "100"&X"C",
							tcp_flags(7 downto 0)									when "100"&X"D",
							slv(window_size(7 downto 0))							when "100"&X"E",
							slv(X"0"&window_size(11 downto 8))					when "100"&X"F",
							X"00"															when "101"&X"0", -- Set initial checksum value
							X"00"															when "101"&X"1", -- Set initial checksum value
							X"00"															when "101"&X"2", -- Load initial checksum value
							slv(tcp_ip_identification(7 downto 0))				when "101"&X"3",
							slv(tcp_ip_identification(15 downto 8))			when "101"&X"4",
							slv(tx_total_packet_length(7 downto 0))			when "101"&X"5", -- Data packet length + headers
							slv(X"0"&tx_total_packet_length(11 downto 8))	when "101"&X"6", -- Data packet length + headers
							tcp_tx_data													when "101"&X"7", -- TX Data
							X"00"															when "101"&X"8", -- Set checksum length to tx data length
							X"00"															when "101"&X"9", -- Set initial checksum value to length + protocol (6)
							X"00"															when others;
							
	tcp_sequence_number_p1 <= tcp_sequence_number + 1;
	
	METADATA_PTOC: process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			ip_identification <= lfsr_val(15 downto 0);
			if tx_packet_state = SET_NEW_TRANSACTION_ID then
				dhcp_transaction_id <= lfsr_val;
			end if;
			if packet_handler_state = CHECK_TCP_SYN_PACKET0 then
				tcp_ip_identification <= unsigned(lfsr_val(15 downto 0));
			elsif packet_handler_state = CHECK_TCP_PSH_ACK_PACKET2 then
				tcp_ip_identification <= tcp_ip_identification + 1;
			end if;
			if packet_handler_state = PARSE_TCP_PACKET4 and tcp_connection_active = '0' then
				client_port <= rx_tcp_source_port;
			end if;
			if packet_handler_state = CHECK_TCP_SYN_PACKET0 then
				tcp_sequence_number <= unsigned(lfsr_val);
			elsif packet_handler_state = PARSE_TCP_PACKET0 and sent_syn_ack = '1' then
				tcp_sequence_number <= tcp_sequence_number + 1;
			elsif packet_handler_state = TRIGGER_TCP_PSH_ACK3 then
				tcp_sequence_number <= tcp_sequence_number + RESIZE(tx_bytes_to_send, 32);
			end if;
			if packet_handler_state = CHECK_TCP_SYN_PACKET0 then
				tcp_acknowledge_number <= unsigned(rx_tcp_seq_number) + 1;
			elsif packet_handler_state = TRIGGER_TCP_ACK0 and fin_received = '1' then
				tcp_acknowledge_number <= tcp_acknowledge_number + 1;
			elsif packet_handler_state = CHECK_TCP_PSH_ACK_PACKET3 then
				tcp_acknowledge_number <= tcp_acknowledge_number + RESIZE(rx_data_length, 32);
			end if;
			if packet_handler_state = TRIGGER_TCP_ACK0 then
				if fin_received = '1' then
					tcp_flags <= C_tcp_fin_ack_flags;
				elsif syn_ack_packet = '1' then
					tcp_flags <= C_tcp_syn_ack_flags;
				else
					tcp_flags <= C_tcp_ack_flags;
				end if;
			elsif packet_handler_state = TRIGGER_TCP_PSH_ACK2 then
				tcp_flags <= C_tcp_psh_ack_flags;
			end if;
			if packet_handler_state = TRIGGER_TCP_ACK0 then
				window_size <= X"FFF" - unsigned(tcp_rd_data_count);
			elsif packet_handler_state = TRIGGER_TCP_ACK1 then
				window_size <= X"FFF" - unsigned(tcp_rd_data_count);
			end if;
			if packet_handler_state = CHECK_TCP_SYN_PACKET0 then
				fin_received <= '0';
			elsif rx_tcp_flags(0) = '1' then
				fin_received <= '1';
			end if;
			fin_received_p <= fin_received;
			if fin_received = '1' and fin_received_p = '0' then
				trigger_fin_ack <= '1';
			else
				trigger_fin_ack <= '0';
			end if;
			if packet_handler_state = CHECK_TCP_SYN_PACKET0 then
				syn_ack_packet <= '1';
			elsif packet_handler_state = TRIGGER_TCP_ACK0 then
				syn_ack_packet <= '0';
			end if;
			if packet_handler_state = TRIGGER_TCP_ACK0 and syn_ack_packet = '1' then
				sent_syn_ack <= '1';
			elsif packet_handler_state = CHECK_TCP_PSH_ACK_PACKET0 then
				sent_syn_ack <= '0';
			end if;
			if packet_handler_state = CHECK_TCP_SYN_PACKET0 then
				tcp_connection_active <= '1';
			elsif fin_received = '1' then
				tcp_connection_active <= '0';
			elsif trigger_close_connection = '1' then
				tcp_connection_active <= '0';
			end if;
			if packet_handler_state = TRIGGER_TCP_PSH_ACK0 then
				if unsigned(tcp_wr_data_count) > X"580" then
					tx_bytes_to_send <= X"580";
				else
					tx_bytes_to_send <= unsigned(tcp_wr_data_count);
				end if;
			end if;
			if packet_handler_state = TRIGGER_TCP_PSH_ACK1 then
				tx_total_packet_length <= tx_bytes_to_send + X"030"; -- IP Header length (20 Bytes) + TCP Header length (28 Bytes)
			end if;
			if packet_handler_state = TRIGGER_TCP_PSH_ACK1 then
				tx_total_packet_length_inc_mac <= tx_bytes_to_send + X"03E"; -- IP Header length (20 Bytes) + TCP Header length (28 Bytes) + MAC length (14 bytes)
			end if;
			if packet_handler_state = TRIGGER_TCP_PSH_ACK1 then
				tx_total_packet_length_checksum <= tx_bytes_to_send + X"022"; --  TCP Header length (28 Bytes) + Protocol (value=6)
			end if;
			-- TODO need to 'lock' tx logic (so previous tx packet isn't overwritten by arp or something)
			-- Can be achieved by only responding to TCP packets when tx_packet_no_ack_timeout > X"1"
			if packet_handler_state = TRIGGER_TCP_PSH_ACK3 then
				tx_packets_no_ack <= tx_packets_no_ack + 1;
			elsif packet_handler_state = CHECK_TCP_PSH_ACK_PACKET2 then
				tx_packets_no_ack <= X"0";
			end if;
			if tx_packets_no_ack > X"1" then
				tx_packet_no_ack_timeout <= tx_packet_no_ack_timeout - 1;
			else
				tx_packet_no_ack_timeout <= C_100ms;
			end if;
			if tx_packets_no_ack < X"2" then
				tx_packet_timeout_counter <= X"00";
			elsif tx_packet_no_ack_timeout = X"000000" then
				tx_packet_timeout_counter <= tx_packet_timeout_counter + 1;
			end if;
			tx_packet_timeout_counter_prev <= tx_packet_timeout_counter;
			if tx_packet_timeout_counter = X"01" and tx_packet_timeout_counter_prev = X"00" then
				trigger_send_prev_packet <= '1';
			elsif tx_packet_timeout_counter = X"03" and tx_packet_timeout_counter_prev = X"02" then
				trigger_send_prev_packet <= '1';
			elsif tx_packet_timeout_counter = X"07" and tx_packet_timeout_counter_prev = X"06" then
				trigger_send_prev_packet <= '1';
			elsif tx_packet_timeout_counter = X"0F" and tx_packet_timeout_counter_prev = X"0E" then
				trigger_send_prev_packet <= '1';
			else
				trigger_send_prev_packet <= '0';
			end if;
			if tx_packet_timeout_counter = X"1F" and tx_packet_timeout_counter_prev = X"1E" then
				trigger_close_connection <= '1';
			else
				trigger_close_connection <= '0';
			end if;
		end if;
	end process;
	
	FRAME_ADDR_LENGTH_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if tx_packet_state = INIT_ARP_REPLY_METADATA then
				tx_packet_frame_addr <= unsigned(C_arp_reply_frame_addr);
			elsif tx_packet_state = INIT_ARP_REQUEST_METADATA then
				tx_packet_frame_addr <= unsigned(C_arp_request_frame_addr);
			elsif tx_packet_state = INIT_ICMP_REPLY_METADATA then
				tx_packet_frame_addr <= unsigned(C_icmp_reply_frame_addr);
			elsif tx_packet_state = INIT_DHCP_DISCOVER_METADATA then
				tx_packet_frame_addr <= unsigned(C_dhcp_discover_frame_addr);
			elsif tx_packet_state = INIT_DHCP_REQUEST_METADATA then
				tx_packet_frame_addr <= unsigned(C_dhcp_request_frame_addr);
			elsif tx_packet_state = INIT_TCP_PACKET_METADATA then
				tx_packet_frame_addr <= unsigned(C_tcp_packet_frame_addr);
			elsif tx_packet_state = INIT_TCP_TX_PACKET_METADATA then
				tx_packet_frame_addr <= unsigned(C_tcp_tx_packet_frame_addr);
			elsif tx_packet_state = IDLE then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			elsif tx_packet_state = READ_PACKET_BYTE0 then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			elsif tx_packet_state = READ_PACKET_BYTE1 then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			elsif tx_packet_state = HANDLE_PACKET_INSTRUCTION0 then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			elsif tx_packet_state = WAIT_FOR_CHECKSUM_CMPLT then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			elsif tx_packet_state = COMPLETE then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			elsif tx_packet_state = INIT_LOAD_TX_PACKET_DATA then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			elsif tx_packet_state = LOAD_TX_PACKET_DATA then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			elsif tx_packet_state = SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH0 then
				tx_packet_frame_addr <= tx_packet_frame_addr;
			else
				tx_packet_frame_addr <= tx_packet_frame_addr + 1;
			end if;
			if tx_packet_state = INIT_ARP_REPLY_METADATA then
				tx_packet_length <= unsigned(C_arp_reply_length);
			elsif tx_packet_state = INIT_ARP_REQUEST_METADATA then
				tx_packet_length <= unsigned(C_arp_request_length);
			elsif tx_packet_state = INIT_ICMP_REPLY_METADATA then
				tx_packet_length <= unsigned(C_icmp_reply_length);
			elsif tx_packet_state = INIT_DHCP_DISCOVER_METADATA then
				tx_packet_length <= unsigned(C_dhcp_discover_length);
			elsif tx_packet_state = INIT_DHCP_REQUEST_METADATA then
				tx_packet_length <= unsigned(C_dhcp_request_length);
			elsif tx_packet_state = INIT_TCP_PACKET_METADATA then
				tx_packet_length <= unsigned(C_tcp_packet_length);
			elsif tx_packet_state = INIT_TCP_TX_PACKET_METADATA then
				tx_packet_length <= RESIZE(unsigned(tx_total_packet_length_inc_mac), 16);
			end if;
			if tx_packet_state = INIT_ARP_REPLY_METADATA then
				tx_packet_end_pointer <= tx_base_addr + unsigned(C_arp_reply_length);
				prev_tx_packet_end_pointer <= tx_packet_end_pointer;
			elsif tx_packet_state = INIT_ARP_REQUEST_METADATA then
				tx_packet_end_pointer <= tx_base_addr + unsigned(C_arp_request_length);
				prev_tx_packet_end_pointer <= tx_packet_end_pointer;
			elsif tx_packet_state = INIT_ICMP_REPLY_METADATA then
				tx_packet_end_pointer <= tx_base_addr + unsigned(C_icmp_reply_length);
				prev_tx_packet_end_pointer <= tx_packet_end_pointer;
			elsif tx_packet_state = INIT_DHCP_DISCOVER_METADATA then
				tx_packet_end_pointer <= tx_base_addr + unsigned(C_dhcp_discover_length);
				prev_tx_packet_end_pointer <= tx_packet_end_pointer;
			elsif tx_packet_state = INIT_DHCP_REQUEST_METADATA then
				tx_packet_end_pointer <= tx_base_addr + unsigned(C_dhcp_discover_length);
				prev_tx_packet_end_pointer <= tx_packet_end_pointer;
			elsif tx_packet_state = INIT_TCP_PACKET_METADATA then
				tx_packet_end_pointer <= tx_base_addr + unsigned(C_tcp_packet_length);
				prev_tx_packet_end_pointer <= tx_packet_end_pointer;
			elsif tx_packet_state = INIT_TCP_TX_PACKET_METADATA then
				tx_packet_end_pointer <= tx_base_addr + RESIZE(unsigned(tx_total_packet_length_inc_mac), 16);
				prev_tx_packet_end_pointer <= tx_packet_end_pointer;
			end if;
			if tx_packet_state = IDLE then
				doing_tx_packet_config <= '0';
			else
				doing_tx_packet_config <= '1';
			end if;
			if tx_packet_state = IDLE then
				tx_packet_ram_we_addr_buf <= "00000000000";
			elsif tx_packet_state = HANDLE_PACKET_INSTRUCTION1 then
				tx_packet_ram_we_addr_buf <= tx_packet_ram_we_addr_buf + 1;
			elsif tx_packet_state = LOAD_TX_PACKET_DATA then
				tx_packet_ram_we_addr_buf <= tx_packet_ram_we_addr_buf + 1;
			elsif tx_packet_state = MOVE_TX_PACKET_WR_ADDR then
				tx_packet_ram_we_addr_buf <= unsigned(checksum_wr_addr);
			end if;
			if tx_packet_state = COMPLETE then
				tx_packet_ready_for_transmission <= '1';
			elsif eth_state = HANDLE_TX_TRANSMIT22 then
				tx_packet_ready_for_transmission <= '0';
			end if;
			if tx_packet_state = SET_RX_PACKET_ADDR_LOWER_BYTE then
				rx_packet_rd2_addr(7 downto 0) <= unsigned(frame_data(7 downto 0));
			elsif tx_packet_state = SET_RX_PACKET_ADDR_UPPER_BYTE then
				rx_packet_rd2_addr(10 downto 8) <= unsigned(frame_data(2 downto 0));
			elsif tx_packet_state = HANDLE_PACKET_INSTRUCTION1 then
				rx_packet_rd2_addr <= rx_packet_rd2_addr + 1;
			elsif tx_packet_state = LOAD_TX_PACKET_DATA then
				rx_packet_rd2_addr <= rx_packet_rd2_addr + 1;
			end if;
      end if;
   end process;
	
	tx_base_addr <= C_tx_base_addr1 when tx_base_addr_select = '0' else C_tx_base_addr2;
	
	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if eth_state = HANDLE_TX_TRANSMIT22 or eth_state = HANDLE_TX_TRANSMIT_PREV16 then
				tx_base_addr_select <= not(tx_base_addr_select);
			end if;
			if eth_state = WAIT_FOR_TRANSMIT_CMPLT then
				tx_timeout_counter <= tx_timeout_counter - 1;
			else
				tx_timeout_counter <= C_20ms;
			end if;
		end if;
	end process;	

	tx_packet_ram_data <= packet_data;
	tx_packet_ram_we <= '1' when (tx_packet_state = HANDLE_PACKET_INSTRUCTION1) or (tx_packet_state = LOAD_TX_PACKET_DATA) else '0';
	tx_packet_config_cmplt <= '1' when tx_packet_state = COMPLETE else '0';

	tx_packet_ram_we_addr <= unsigned(checksum_addr) when (tx_packet_state = WAIT_FOR_CHECKSUM_CMPLT) else tx_packet_ram_we_addr_buf;

	TX_PACKET_RAM : TDP_RAM
		Generic Map (	G_DATA_A_SIZE 	=> tx_packet_ram_data'length,
							G_ADDR_A_SIZE	=> tx_packet_ram_we_addr'length,
							G_RELATION		=> 0, --log2(SIZE_A/SIZE_B)
							G_INIT_ZERO		=> true,
							G_INIT_FILE		=> "")
		Port Map ( CLK_A_IN 	=> CLK_IN,
				 WE_A_IN 		=> tx_packet_ram_we,
				 ADDR_A_IN 		=> slv(tx_packet_ram_we_addr),
				 DATA_A_IN		=> tx_packet_ram_data,
				 DATA_A_OUT		=> tx_packet_rd_data2,
				 CLK_B_IN 		=> CLK_IN,
				 WE_B_IN 		=> '0',
				 ADDR_B_IN 		=> slv(tx_packet_ram_rd_addr),
				 DATA_B_IN 		=> X"00",
				 DATA_B_OUT 	=> tx_packet_rd_data);

	CHECKSUM_METADATA_PROC: process(CLK_IN)
   begin
      if rising_edge(CLK_IN) then
			if tx_packet_state = SET_CHECKSUM_LENGTH_LSB then
				checksum_count(7 downto 0) <= unsigned(frame_data(7 downto 0));
			elsif tx_packet_state = SET_CHECKSUM_LENGTH_MSB then
				checksum_count(10 downto 8) <= unsigned(frame_data(2 downto 0));
			elsif tx_packet_state = SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH0 then
				checksum_count(10 downto 0) <= unsigned('0'&tx_bytes_to_send(10 downto 1)) + "00000010010";
			elsif tx_packet_state = SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH1 then
				checksum_count(10 downto 0) <= checksum_count(10 downto 0) + ("0000000000"&tx_bytes_to_send(0));
			end if;
			if tx_packet_state = SET_CHECKSUM_LENGTH_TX_PACKET_LENGTH1 then
				checksum_odd_length <= tx_bytes_to_send(0);
			elsif tx_packet_state = MOVE_TX_PACKET_WR_ADDR then -- clear odd flag before next checksum is calcd
				checksum_odd_length <= '0';
			end if;
			if tx_packet_state = SET_CHECKSUM_START_ADDR_LSB then
				checksum_start_addr(7 downto 0) <= frame_data(7 downto 0);
			elsif tx_packet_state = SET_CHECKSUM_START_ADDR_MSB then
				checksum_start_addr(10 downto 8) <= frame_data(2 downto 0);
			end if;
			if tx_packet_state = SET_CHECKSUM_WR_ADDR_LSB then
				checksum_wr_addr(7 downto 0) <= frame_data(7 downto 0);
			elsif tx_packet_state = SET_CHECKSUM_WR_ADDR_MSB then
				checksum_wr_addr(10 downto 8) <= frame_data(2 downto 0);
			end if;
			if tx_packet_state = SET_CHECKSUM_START_VAL_LSB then
				checksum_initial_value(7 downto 0) <= frame_data(7 downto 0);
			elsif tx_packet_state = SET_CHECKSUM_INITIAL_VALUE_TX_PACKET then
				checksum_initial_value(7 downto 0) <= slv(tx_total_packet_length_checksum(7 downto 0));
			end if;
			if tx_packet_state = SET_CHECKSUM_START_VAL_MSB then
				checksum_initial_value(15 downto 8) <= frame_data(7 downto 0);
			elsif tx_packet_state = SET_CHECKSUM_INITIAL_VALUE_TX_PACKET then
				checksum_initial_value(11 downto 8) <= slv(tx_total_packet_length_checksum(11 downto 8));
				checksum_initial_value(15 downto 12) <= X"0";
			end if;
			if tx_packet_state = TRIGGER_CHECKSUM_LOAD_INITIAL_VALUE then
				checksum_set_initial_value <= '1';
			else
				checksum_set_initial_value <= '0';
			end if;
			if tx_packet_state = INIT_LOAD_TX_PACKET_DATA then
				tx_packet_data_counter <= tx_bytes_to_send - 1;
			else
				tx_packet_data_counter <= tx_packet_data_counter - 1;
			end if;
		end if;
	end process;
	
	calc_checksum <= '1' when tx_packet_state = TRIG_CHECKSUM_CALC else '0';

	checksum_calc_mod : checksum_calc
    Port Map ( CLK_IN 						=> CLK_IN,
					RST_IN 						=> '0',
					CHECKSUM_CALC_IN 			=> calc_checksum,
					START_ADDR_IN 				=> checksum_start_addr,
					COUNT_IN 					=> slv(checksum_count),
					VALUE_IN 					=> tx_packet_rd_data2,
					VALUE_ADDR_OUT 			=> checksum_addr,
					CHECKSUM_INIT_IN			=> checksum_initial_value,
					CHECKSUM_SET_INIT_IN		=> checksum_set_initial_value,
					CHECKSUM_ODD_LENGTH_IN 	=> checksum_odd_length,
					CHECKSUM_OUT 				=> checksum,
					CHECKSUM_DONE_OUT 		=> checksum_calc_done);

------------------- PACKET DEFINITION ------------------------

	Packet_Definition_Mod : Packet_Definition
	  Port Map (
		 clka 	=> CLK_IN,
		 addra 	=> packet_definition_addr,
		 douta 	=> packet_definition_data);

------------------------- SPI --------------------------------

	spi_mod_inst : spi_mod
		Port Map ( 	CLK_IN 				=> CLK_IN,
						RST_IN 				=> '0',
						
						WR_CONTINUOUS_IN 	=> spi_wr_continuous,
						WE_IN 				=> spi_we,
						WR_ADDR_IN			=> spi_wr_addr,
						WR_DATA_IN 			=> spi_wr_data,
						WR_DATA_CMPLT_OUT	=> spi_wr_cmplt,
						
						RD_CONTINUOUS_IN 	=> spi_rd_continuous,
						RD_IN					=> spi_rd,
						RD_WIDTH_IN 		=> spi_rd_width,
						RD_ADDR_IN 			=> spi_rd_addr,
						RD_DATA_OUT 		=> spi_data_rd,
						RD_DATA_CMPLT_OUT	=> spi_rd_cmplt,
						
						SLOW_CS_EN_IN		=> slow_cs_en,
						OPER_CMPLT_POST_CS_OUT => spi_oper_cmplt,
						
						SDI_OUT				=> SDI_OUT,
						SDO_IN				=> SDO_IN,
						SCLK_OUT				=> SCLK_OUT,
						CS_OUT				=> CS_OUT);

------------------------- LFSR -------------------------------

	lfsr32_mod_inst : lfsr32_mod
		Port Map ( 	CLK_IN 		=> CLK_IN,
						SEED_IN 		=> X"00000000",
						SEED_EN_IN 	=> '0',
						VAL_OUT 		=> lfsr_val);

--------------------- TCP RX DATA ----------------------------

	TCP_CONNECTION_ACTIVE_OUT <= tcp_connection_active;

	tcp_data_rd_en <= TCP_RD_DATA_EN_IN;
	TCP_RD_DATA_AVAIL_OUT <= not(tcp_rd_data_available);
	TCP_RD_DATA_OUT <= tcp_rx_data_rd_data;
	
	tcp_rx_data_we <= '1' when (packet_handler_next_state = READ_TCP_RX_DATA) else '0';

	TCP_RX_FIFO : TCP_FIFO
	  PORT MAP (
		 clk 				=> CLK_IN,
		 din 				=> rx_packet_rd_data,
		 wr_en 			=> tcp_rx_data_we,
		 rd_en 			=> tcp_data_rd_en,
		 dout 			=> tcp_rx_data_rd_data,
		 full 			=> open,
		 almost_full 	=> open,
		 empty 			=> tcp_rd_data_available,
		 data_count 	=> tcp_rd_data_count);

--------------------- TCP TX DATA ----------------------------

	TCP_WR_DATA_POSSIBLE_OUT <= tcp_wr_data_possible;
	tcp_wr_data_possible <= '1' when tcp_wr_data_count < X"FA0" else '0';
	
	tcp_wr_data_en <= TCP_WR_DATA_EN_IN;
	tcp_wr_data <= TCP_WR_DATA_IN;
	tcp_wr_data_flush <= TCP_WR_DATA_FLUSH_IN;
	tcp_tx_data_rd <= '1' when (tx_packet_state = LOAD_TX_PACKET_DATA) or (tx_packet_state = INIT_LOAD_TX_PACKET_DATA) else '0'; -- TODO or previous state = LOAD_TX_PACKET_DATA

	TCP_TX_FIFO : TCP_FIFO
	  PORT MAP (
		 clk 				=> CLK_IN,
		 din 				=> tcp_wr_data,
		 wr_en 			=> tcp_wr_data_en,
		 rd_en 			=> tcp_tx_data_rd,
		 dout 			=> tcp_tx_data,
		 full 			=> open,
		 almost_full 	=> open,
		 empty 			=> open,
		 data_count 	=> tcp_wr_data_count);

	--- Network Stats ---
	
--	process(CLK_IN)
--	begin
--		if rising_edge(CLK_IN) then
--			clk_1hz_prev <= clk_1hz;
--			if clk_1hz_prev = '0' and clk_1hz = '1' then
--				rx_kbytes_sec <= rx_bytes_counter(21 downto 10);
--			end if;
--			if clk_1hz_prev = '0' and clk_1hz = '1' then
--				rx_bytes_counter <= (others => '0');
--			elsif packet_handler_state = CHECK_TCP_PSH_ACK_PACKET2 then
--				rx_bytes_counter <= rx_bytes_counter + RESIZE(total_packet_length, 22);
--			end if;
--		end if;
--	end process;

	--- DATA I/O ---
	
--	process(CLK_IN)
--	begin
--		if rising_edge(CLK_IN) then
--			if ADDR_IN = X"00" then
--				DATA_OUT <= "0000000" & network_interface_enabled;
--			elsif ADDR_IN = X"01" then
--				DATA_OUT <= mac_addr(47 downto 40);
--			elsif ADDR_IN = X"02" then
--				DATA_OUT <= mac_addr(39 downto 32);
--			elsif ADDR_IN = X"03" then
--				DATA_OUT <= mac_addr(31 downto 24);
--			elsif ADDR_IN = X"04" then
--				DATA_OUT <= mac_addr(23 downto 16);
--			elsif ADDR_IN = X"05" then
--				DATA_OUT <= mac_addr(15 downto 8);
--			elsif ADDR_IN = X"06" then
--				DATA_OUT <= mac_addr(7 downto 0);
--			elsif ADDR_IN = X"07" then
--				DATA_OUT <= "0000000" & dhcp_enable;
--			elsif ADDR_IN = X"08" then
--				DATA_OUT <= "000000" & static_addr_locked & dhcp_addr_locked;
--			elsif ADDR_IN = X"09" then
--				DATA_OUT <= ip_addr(31 downto 24);
--			elsif ADDR_IN = X"0A" then
--				DATA_OUT <= ip_addr(23 downto 16);
--			elsif ADDR_IN = X"0B" then
--				DATA_OUT <= ip_addr(15 downto 8);
--			elsif ADDR_IN = X"0C" then
--				DATA_OUT <= ip_addr(7 downto 0);
--			elsif ADDR_IN = X"0D" then
--				DATA_OUT <= cloud_ip_addr(31 downto 24);
--			elsif ADDR_IN = X"0E" then
--				DATA_OUT <= cloud_ip_addr(23 downto 16);
--			elsif ADDR_IN = X"0F" then
--				DATA_OUT <= cloud_ip_addr(15 downto 8);
--			elsif ADDR_IN = X"10" then
--				DATA_OUT <= cloud_ip_addr(7 downto 0);
--			elsif ADDR_IN = X"11" then
--				DATA_OUT <= "0000000" & tcp_connection_active;
--			end if;
--		end if;
--	end process;

end Behavioral;

