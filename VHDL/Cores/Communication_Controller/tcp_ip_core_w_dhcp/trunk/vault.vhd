----------------------------------------------------------------------------------
-- Company: 
-- Engineer: CW
-- 
-- Create Date:    21:25:31 10/06/2014 
-- Design Name: 
-- Module Name:    hw_client - Behavioral 
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
use work.CommonPckg.all;
use work.SdCardPckg.all;

library UNISIM;
use UNISIM.VComponents.all;

entity vault is
    Port ( 	CLK_IN 		: in STD_LOGIC;

				LED_OUT 		: out STD_LOGIC_VECTOR (7 downto 0);
				SSEG_OUT 	: out STD_LOGIC_VECTOR (7 downto 0);
				SSEG_EN_OUT : out STD_LOGIC_VECTOR (3 downto 0);
				SW_IN 		: in STD_LOGIC_VECTOR (7 downto 0);
				BUTTON_IN 	: in STD_LOGIC_VECTOR (5 downto 0);
				
				SDI			: in STD_LOGIC;
				SDO			: out STD_LOGIC;
				SCLK 			: out STD_LOGIC;
				CS				: out STD_LOGIC;
				RESET			: out STD_LOGIC;
				
				SD_MISO_IN	: in  STD_LOGIC;
				SD_MOSI_OUT	: out  STD_LOGIC;
				SD_CLK_OUT	: out  STD_LOGIC;
				SD_CS_OUT	: out  STD_LOGIC;
				
				TEST_RF_OUT	: out STD_LOGIC);
end vault;

architecture Behavioral of vault is

	COMPONENT clk_mod
		 Port ( CLK_100MHz_IN 	: in  STD_LOGIC;
				  CLK_100Mhz_OUT 	: out  STD_LOGIC);
	END COMPONENT;
	
	COMPONENT sseg
	PORT (	
		CLK    : in STD_LOGIC;
		VAL_IN  	: in STD_LOGIC_VECTOR (15 downto 0);
		SSEG_OUT	: out STD_LOGIC_VECTOR(7 downto 0);
		AN_OUT   : out STD_LOGIC_VECTOR(3 downto 0));
	END COMPONENT;

	COMPONENT led_mod is
    Port ( CLK_IN 				: in  STD_LOGIC;
           LED_STATE_IN 		: in  STD_LOGIC_VECTOR (2 downto 0);
			  ERROR_CODE_IN		: in	STD_LOGIC_VECTOR (4 downto 0);
			  ERROR_CODE_EN_IN	: in	STD_LOGIC;
           LEDS_OUT 				: out  STD_LOGIC_VECTOR (1 downto 0);
			  CLK_1HZ_OUT			: out STD_LOGIC);
	END COMPONENT;

	COMPONENT eth_mod is
	 Generic ( G_FUNCTION 	: string :="client" ); -- client/server (defaults to client)
    Port ( CLK_IN 	: in  STD_LOGIC;
			  
			  -- Command interface
			  INIT_ENC28J60 	: in 	STD_LOGIC;
			  DHCP_CONNECT 	: in 	STD_LOGIC;
--			  TCP_CONNECT 		: in 	STD_LOGIC;
			  ERROR_OUT 		: out  STD_LOGIC_VECTOR (7 downto 0);
			  
			  -- Data Interface
--			  ADDR_IN	: in  STD_LOGIC_VECTOR (7 downto 0);
--			  DATA_OUT	: out  STD_LOGIC_VECTOR (7 downto 0);
			  
			  DEBUG_IN 	: in STD_LOGIC_VECTOR (2 downto 0);
			  DEBUG_OUT	: out  STD_LOGIC_VECTOR (15 downto 0);
			  
           -- TCP Connection Interface
			  TCP_CONNECTION_ACTIVE_OUT 	: out STD_LOGIC;
			  TCP_RD_DATA_AVAIL_OUT 		: out STD_LOGIC;
			  TCP_RD_DATA_EN_IN 				: in STD_LOGIC;
			  TCP_RD_DATA_OUT 				: out STD_LOGIC_VECTOR (7 downto 0);
			  TCP_WR_DATA_POSSIBLE_OUT		: out STD_LOGIC;
			  TCP_WR_DATA_EN_IN 				: in STD_LOGIC;
			  TCP_WR_DATA_FLUSH_IN			: in STD_LOGIC;
			  TCP_WR_DATA_IN 					: in STD_LOGIC_VECTOR (7 downto 0);
			  
			  CLK_1HZ_IN	: in STD_LOGIC;
			  
			  -- Eth SPI interface
			  SDI_OUT 	: out  STD_LOGIC;
           SDO_IN 	: in  STD_LOGIC;
           SCLK_OUT 	: out  STD_LOGIC;
           CS_OUT 	: out  STD_LOGIC);
	END COMPONENT;

	COMPONENT SdCardCtrl
    generic (
      FREQ_G          : real       := 100.0;  -- Master clock frequency (MHz).
      INIT_SPI_FREQ_G : real       := 0.4;  -- Slow SPI clock freq. during initialization (MHz).
      SPI_FREQ_G      : real       := 25.0;  -- Operational SPI freq. to the SD card (MHz).
      BLOCK_SIZE_G    : natural    := 512;  -- Number of bytes in an SD card block or sector.
      CARD_TYPE_G     : CardType_t := SD_CARD_E  -- Type of SD card connected to this controller.
      );
    port (
      -- Host-side interface signals.
      clk_i      : in  std_logic;       -- Master clock.
      reset_i    : in  std_logic                     := NO;  -- active-high, synchronous  reset.
      rd_i       : in  std_logic                     := NO;  -- active-high read block request.
      wr_i       : in  std_logic                     := NO;  -- active-high write block request.
      continue_i : in  std_logic                     := NO;  -- If true, inc address and continue R/W.
      addr_i     : in  std_logic_vector(31 downto 0) := x"00000000";  -- Block address.
      data_i     : in  std_logic_vector(7 downto 0)  := x"00";  -- Data to write to block.
      data_o     : out std_logic_vector(7 downto 0)  := x"00";  -- Data read from block.
      busy_o     : out std_logic;  -- High when controller is busy performing some operation.
      hndShk_i   : in  std_logic;  -- High when host has data to give or has taken data.
      hndShk_o   : out std_logic;  -- High when controller has taken data or has data to give.
      error_o    : out std_logic_vector(15 downto 0) := (others => NO);
      -- I/O signals to the external SD card.
      cs_bo      : out std_logic                     := HI;  -- Active-low chip-select.
      sclk_o     : out std_logic                     := LO;  -- Serial clock to SD card.
      mosi_o     : out std_logic                     := HI;  -- Serial data output to SD card.
      miso_i     : in  std_logic                     := ZERO;  -- Serial data input from SD card.
		state_debug_o	: out std_logic_vector(4 downto 0)
      );
	END COMPONENT;

Constant C_TEST_W_SD_CARD 	:boolean :=false;
Constant C_TEST_W_FPGA 		:boolean :=true;

subtype slv is std_logic_vector;

signal clk_100MHz, clk_1hz : std_logic;

signal char_addr, font_addr	: std_logic_vector(11 downto 0);
signal char_data, font_data	: std_logic_vector(7 downto 0);
signal debug_addr	: std_logic_vector(11 downto 0);
signal debug_data	: std_logic_vector(7 downto 0);
signal debug_i		: std_logic_vector(2 downto 0);
signal debug_o		: std_logic_vector(15 downto 0);
signal r, g, b 					: std_logic := '0';
signal octl							: std_logic_vector(7 downto 0);
signal ocrx, ocry 				: std_logic_vector(7 downto 0) := (others => '0');

signal frame_addr : std_logic_vector(23 downto 1) := (others => '0');
signal frame_data : std_logic_vector(15 downto 0) := (others => '0');
signal frame_rd, frame_rd_cmplt : std_logic := '0';

signal sseg_data : std_logic_vector(15 downto 0) := (others => '0');
signal debug_we : std_logic := '0';
signal debug_wr_addr : unsigned(11 downto 0) := (others => '0');
signal debug_wr_data : std_logic_vector(7 downto 0) := (others => '0');
signal buttons, buttons_prev, buttons_edge	: std_logic_vector(5 downto 0) := (others => '0');
signal debounce_count								: unsigned(15 downto 0) := (others => '0');

signal data_bus, addr_bus 	: std_logic_vector(7 downto 0) := (others => '0');
signal eth_command 			: std_logic_vector(3 downto 0);
signal eth_command_err		: std_logic_vector(7 downto 0);
signal eth_command_en, eth_command_cmplt : std_logic;
	
signal sdi_buf, sdo_buf, sclk_buf, sclk_buf_n, sclk_oddr, cs_buf : std_logic;

signal clk_div_counter : unsigned(7 downto 0) := (others => '0');
signal test_rf_counter : unsigned(15 downto 0) := (others => '0');
signal tcp_rd_en, tcp_rd_en_p, tcp_rd_data_avail : std_logic;
signal tcp_connection_active : std_logic;
signal tcp_wr_en, tcp_wr_possible, wr_en : std_logic := '0';
signal check_rd_data : std_logic;
signal tcp_data_rd : std_logic_vector(7 downto 0);
signal tcp_data_wr : unsigned(7 downto 0) := X"00";
signal tcp_data_rd_p, tcp_data_rd_pp : unsigned(7 downto 0);
signal err_count : unsigned(15 downto 0) := (others => '0');
signal sd_cs, sd_clk, sd_mosi, sd_miso : std_logic;
signal busy_o, hndshk_i, hndshk_o, wr_i : std_logic;
signal wr_counter : unsigned(11 downto 0) := (others => '0');
signal data_i : unsigned(7 downto 0) := (others => '0');
signal addr_i : unsigned(31 downto 0) := (others => '0');
signal test_rf : std_logic;

type SD_ST is (	IDLE,
						INIT_WR,
						WAIT_FOR_DATA_AVAIL,
						WAIT_FOR_BYTE,
						WR_BYTE0,
						WR_BYTE1,
						WR_BYTE2,
						WR_BYTE3,
						WAIT_FOR_NOT_BUSY);
						
signal sd_state, sd_next_state : SD_ST := IDLE;


begin
	
	clk_mod_Inst : clk_mod
	PORT MAP ( 	CLK_100MHz_IN 	=> CLK_IN,
					CLK_100Mhz_OUT => clk_100MHz);
	
--------------------------- DEBUG LOGIC ------------------------------
	
	LED_OUT(3 downto 3) <= (others => '0');
	LED_OUT(2) <= tcp_connection_active;
	
	SD_CS_OUT <= sd_cs;
	SD_CLK_OUT <= sd_clk;
	SD_MOSI_OUT <= sd_mosi;
	sd_miso <= SD_MISO_IN;

	sseg_inst : sseg
	PORT MAP (	
		CLK    	=> clk_100MHz,
		VAL_IN 	=> sseg_data,
		SSEG_OUT	=> SSEG_OUT,
		AN_OUT   => SSEG_EN_OUT);
	
	process(clk_100MHz)
	begin
		if rising_edge(clk_100MHz) then
			debounce_count <= debounce_count + 1;
			buttons_prev <= buttons;
			if debounce_count = X"0000" then
				buttons <= BUTTON_IN;
			end if;
			for i in 0 to 5 loop
				if buttons_prev(i) = '1' and buttons(i) = '0' then
					buttons_edge(i) <= '1';
				else
					buttons_edge(i) <= '0';
				end if;
			end loop;
		end if;
	end process;

--------------------------- UI I/O ------------------------------

	led_mod_inst : led_mod
    Port Map ( CLK_IN 				=> clk_100MHz,
					LED_STATE_IN 		=> "001",
					ERROR_CODE_IN		=> SW_IN(4 downto 0),
					ERROR_CODE_EN_IN	=> '0',
					LEDS_OUT 			=> LED_OUT(1 downto 0),
					CLK_1HZ_OUT			=> clk_1hz);
				
------------------------- Ethernet I/O --------------------------------

	RESET <= '1';
	debug_i <= buttons_edge(2)&buttons_edge(1)&buttons_edge(0);
	
	OBUF_inst_0: OBUF generic map ( DRIVE => 12, IOSTANDARD => "DEFAULT", SLEW => "FAST") port map (I => sdi_buf, O => SDO);
	IBUF_inst_0: IBUF port map (I => SDI, O => sdo_buf);
	OBUF_inst_1: OBUF generic map ( DRIVE => 12, IOSTANDARD => "DEFAULT", SLEW => "FAST") port map (I => sclk_oddr, O => SCLK);
	OBUF_inst_2: OBUF generic map ( DRIVE => 12, IOSTANDARD => "DEFAULT", SLEW => "FAST") port map (I => cs_buf, O => CS);

	sclk_buf_n <= not(sclk_buf);
	
	ODDR2_CLK: ODDR2
   port map (
      Q => sclk_oddr, 	-- 1-bit output data
      C0 => sclk_buf, 	-- 1-bit clock input
      C1 => sclk_buf_n, -- 1-bit clock input
      CE => '1',  		-- 1-bit clock enable input
      D0 => '1',   		-- 1-bit data input (associated with C0)
      D1 => '0',   		-- 1-bit data input (associated with C1)
      R => '0',    		-- 1-bit reset input
      S => '0'     		-- 1-bit set input
   );

	eth_mod_inst : eth_mod
		 Generic Map ( G_FUNCTION 	=> "client" )
		 Port Map ( CLK_IN 	=> clk_100MHz,
				  
					  -- Command interface
					  INIT_ENC28J60 	=> buttons_edge(3),
					  DHCP_CONNECT 	=> buttons_edge(4),
--					  TCP_CONNECT 		=> buttons_edge(5),
					  ERROR_OUT 		=> eth_command_err,
					  
					  -- Data Interface
--					  ADDR_IN 	=> addr_bus,
--					  DATA_OUT 	=> data_bus,
					  
					  DEBUG_IN	=> debug_i,
					  DEBUG_OUT	=> debug_o,
					  
					  -- TCP Connection Interface
					  TCP_CONNECTION_ACTIVE_OUT 	=> tcp_connection_active,
					  TCP_RD_DATA_AVAIL_OUT 		=> tcp_rd_data_avail,
					  TCP_RD_DATA_EN_IN 				=> tcp_rd_en,
					  TCP_RD_DATA_OUT 				=> tcp_data_rd,
					  TCP_WR_DATA_POSSIBLE_OUT		=> tcp_wr_possible,
					  TCP_WR_DATA_EN_IN 				=> tcp_wr_en,
					  TCP_WR_DATA_FLUSH_IN			=> buttons_edge(1),
					  TCP_WR_DATA_IN 					=> slv(tcp_data_wr),
					  
					  CLK_1HZ_IN	=> clk_1hz,
					  
					  -- Eth SPI interface
					  SDI_OUT 	=> sdi_buf,
					  SDO_IN 	=> sdo_buf,
					  SCLK_OUT 	=> sclk_buf,
					  CS_OUT 	=> cs_buf);

------------------------- TCP Testing --------------------------------

	-- Test with FPGA
	FPGA_TEST: if C_TEST_W_FPGA = true generate
	
		LED_OUT(7 downto 4) <= sseg_data(15 downto 12);
		--sseg_data(15 downto 0) <= slv(err_count);
		sseg_data(15 downto 0) <= slv(debug_o);

		process(clk_100MHz)
		begin
			if rising_edge(clk_100MHz) then
				if tcp_wr_en = '1' then
					tcp_data_wr <= tcp_data_wr + 1;
				end if;
			end if;
		end process;
		
		
		TEST_RF_OUT <= test_rf;
		
		process(clk_100MHz)
		begin
			if rising_edge(clk_100MHz) then
				test_rf_counter <= test_rf_counter - 1;
				if buttons(2) = '0' then
					if test_rf_counter = X"0000" then
						test_rf <= not(test_rf);
					end if;
				else
					test_rf <= '1';
				end if;
			end if;
		end process;

		process(clk_100MHz)
		begin
			if rising_edge(clk_100MHz) then
				if clk_div_counter = X"00" then
					clk_div_counter <= unsigned(SW_IN);
				else
					clk_div_counter <= clk_div_counter - 1;
				end if;
				if clk_div_counter = X"00" and tcp_wr_possible = '1' and buttons(0) = '0' then
--				if clk_div_counter = X"00" and tcp_rd_data_avail = '1' and buttons(0) = '0' then
--					tcp_rd_en <= '1';
					tcp_wr_en <= '1';
				else
--					tcp_rd_en <= '0';
					tcp_wr_en <= '0';
				end if;
				if tcp_rd_en = '1' then
					tcp_data_rd_p <= unsigned(tcp_data_rd);
					tcp_data_rd_pp <= unsigned(tcp_data_rd_p);
				end if;
				tcp_rd_en_p <= tcp_rd_en;
				if tcp_rd_en_p = '1' then
					if tcp_data_rd_p /= X"00" and tcp_data_rd_pp /= X"00" then
						check_rd_data <= '1';
					end if;
				else
					check_rd_data <= '0';
				end if;
				if check_rd_data = '1' then
					if tcp_data_rd_p /= (tcp_data_rd_pp + 1) then
						err_count <= err_count + 1;
					end if;
				end if;
			end if;
		end process;
	
	end generate;
	
	-- Test by logging to SD Card
	SD_CARD_TEST: if C_TEST_W_SD_CARD = true generate
	
		LED_OUT(7) <= '1' when sd_state = IDLE else '0';
		LED_OUT(6) <= hndshk_i;
		LED_OUT(5) <= busy_o;
		LED_OUT(4) <= '0';

		sseg_data(15 downto 0) <= debug_o;

		wr_i <= '1' when sd_state = INIT_WR else '0';
		tcp_rd_en <= '1' when sd_state = WAIT_FOR_BYTE else '0';
		hndshk_i <= '1' when sd_state = WR_BYTE1 else '0';
						
		SD_ST_DECODE: process (buttons_edge(3), tcp_rd_en)
		begin
			sd_next_state <= sd_state;  --default is to stay in current state
			case (sd_state) is
				when IDLE =>
					if buttons_edge(4) = '1' and busy_o = '0' then
						sd_next_state <= INIT_WR;
					end if;
				when INIT_WR =>
					if busy_o = '1' then
						sd_next_state <= WAIT_FOR_DATA_AVAIL;
					end if;
				when WAIT_FOR_DATA_AVAIL =>
					if tcp_rd_data_avail = '1' then
						sd_next_state <= WAIT_FOR_BYTE;				
					end if;
				when WAIT_FOR_BYTE =>
					sd_next_state <= WR_BYTE0;
				when WR_BYTE0 =>
					if hndshk_o = '1' then
						sd_next_state <= WR_BYTE1;
					end if;
				when WR_BYTE1 =>
					if hndshk_o = '0' then
						sd_next_state <= WR_BYTE2;
					end if;
				when WR_BYTE2 =>
					sd_next_state <= WR_BYTE3;
				when WR_BYTE3 =>
					if wr_counter = X"200" then
						sd_next_state <= WAIT_FOR_NOT_BUSY;
					else
						sd_next_state <= WAIT_FOR_DATA_AVAIL;
					end if;
				when WAIT_FOR_NOT_BUSY =>
					if busy_o = '0' then
						sd_next_state <= INIT_WR;
					end if;
			end case;
		end process;
		
		process(clk_100MHz)
		begin
			if rising_edge(clk_100MHz) then
				sd_state <= sd_next_state;
				if sd_state = INIT_WR then
					wr_counter <= (others => '0');
				elsif sd_state = WR_BYTE2 then
					wr_counter <= wr_counter + 1;
				end if;
				if sd_state = WR_BYTE3 and sd_next_state = WAIT_FOR_NOT_BUSY then
					addr_i <= addr_i + 1;
				end if;
			end if;
		end process;

	  SdCardCtrl_Inst : SdCardCtrl
		 generic map (
			FREQ_G          => 100.0,  	-- Master clock frequency (MHz).
			INIT_SPI_FREQ_G => 0.4,  		-- Slow SPI clock freq. during initialization (MHz).
			SPI_FREQ_G      => 25.0,  		-- Operational SPI freq. to the SD card (MHz).
			BLOCK_SIZE_G    => 512,  		-- Number of bytes in an SD card block or sector.
			CARD_TYPE_G     => SD_CARD_E  -- Type of SD card connected to this controller.
			)
		 port map (
			
			-- Host-side interface signals.
			clk_i      => clk_100MHz,
			reset_i    => buttons_edge(3),
			rd_i       => '0',
			wr_i       => wr_i,
			continue_i => '0',
			addr_i     => slv(addr_i),
			data_i     => tcp_data_rd,
			data_o     => open,
			busy_o     => busy_o,
			hndShk_i   => hndshk_i,
			hndShk_o   => hndshk_o,
			error_o    => open,
			
			-- I/O signals to the external SD card.
			cs_bo		  => sd_cs,
			sclk_o     => sd_clk,
			mosi_o     => sd_mosi,
			miso_i     => sd_miso,
			state_debug_o	=> open); --leds(4 downto 0));

	end generate;

end Behavioral;

