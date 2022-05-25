	component ulight_fifo is
		port (
			auto_start_external_connection_export           : out   std_logic;                                        -- export
			clk_clk                                         : in    std_logic                     := 'X';             -- clk
			clock_sel_external_connection_export            : out   std_logic_vector(2 downto 0);                     -- export
			counter_rx_fifo_external_connection_export      : in    std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			counter_tx_fifo_external_connection_export      : in    std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			data_flag_rx_external_connection_export         : in    std_logic_vector(8 downto 0)  := (others => 'X'); -- export
			data_info_external_connection_export            : in    std_logic_vector(13 downto 0) := (others => 'X'); -- export
			data_read_en_rx_external_connection_export      : out   std_logic;                                        -- export
			fifo_empty_rx_status_external_connection_export : in    std_logic                     := 'X';             -- export
			fifo_empty_tx_status_external_connection_export : in    std_logic                     := 'X';             -- export
			fifo_full_rx_status_external_connection_export  : in    std_logic                     := 'X';             -- export
			fifo_full_tx_status_external_connection_export  : in    std_logic                     := 'X';             -- export
			fsm_info_external_connection_export             : in    std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			led_pio_test_external_connection_export         : out   std_logic_vector(4 downto 0);                     -- export
			link_disable_external_connection_export         : out   std_logic;                                        -- export
			link_start_external_connection_export           : out   std_logic;                                        -- export
			memory_mem_a                                    : out   std_logic_vector(12 downto 0);                    -- mem_a
			memory_mem_ba                                   : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                                   : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                                 : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                                  : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                                 : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                                : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                                : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                                 : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n                              : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                                   : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dq
			memory_mem_dqs                                  : inout std_logic                     := 'X';             -- mem_dqs
			memory_mem_dqs_n                                : inout std_logic                     := 'X';             -- mem_dqs_n
			memory_mem_odt                                  : out   std_logic;                                        -- mem_odt
			memory_mem_dm                                   : out   std_logic;                                        -- mem_dm
			memory_oct_rzqin                                : in    std_logic                     := 'X';             -- oct_rzqin
			pll_0_locked_export                             : out   std_logic;                                        -- export
			pll_0_outclk0_clk                               : out   std_logic;                                        -- clk
			reset_reset_n                                   : in    std_logic                     := 'X';             -- reset_n
			timecode_ready_rx_external_connection_export    : in    std_logic                     := 'X';             -- export
			timecode_rx_external_connection_export          : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			timecode_tx_data_external_connection_export     : out   std_logic_vector(7 downto 0);                     -- export
			timecode_tx_enable_external_connection_export   : out   std_logic;                                        -- export
			timecode_tx_ready_external_connection_export    : in    std_logic                     := 'X';             -- export
			write_data_fifo_tx_external_connection_export   : out   std_logic_vector(8 downto 0);                     -- export
			write_en_tx_external_connection_export          : out   std_logic                                         -- export
		);
	end component ulight_fifo;

	u0 : component ulight_fifo
		port map (
			auto_start_external_connection_export           => CONNECTED_TO_auto_start_external_connection_export,           --           auto_start_external_connection.export
			clk_clk                                         => CONNECTED_TO_clk_clk,                                         --                                      clk.clk
			clock_sel_external_connection_export            => CONNECTED_TO_clock_sel_external_connection_export,            --            clock_sel_external_connection.export
			counter_rx_fifo_external_connection_export      => CONNECTED_TO_counter_rx_fifo_external_connection_export,      --      counter_rx_fifo_external_connection.export
			counter_tx_fifo_external_connection_export      => CONNECTED_TO_counter_tx_fifo_external_connection_export,      --      counter_tx_fifo_external_connection.export
			data_flag_rx_external_connection_export         => CONNECTED_TO_data_flag_rx_external_connection_export,         --         data_flag_rx_external_connection.export
			data_info_external_connection_export            => CONNECTED_TO_data_info_external_connection_export,            --            data_info_external_connection.export
			data_read_en_rx_external_connection_export      => CONNECTED_TO_data_read_en_rx_external_connection_export,      --      data_read_en_rx_external_connection.export
			fifo_empty_rx_status_external_connection_export => CONNECTED_TO_fifo_empty_rx_status_external_connection_export, -- fifo_empty_rx_status_external_connection.export
			fifo_empty_tx_status_external_connection_export => CONNECTED_TO_fifo_empty_tx_status_external_connection_export, -- fifo_empty_tx_status_external_connection.export
			fifo_full_rx_status_external_connection_export  => CONNECTED_TO_fifo_full_rx_status_external_connection_export,  --  fifo_full_rx_status_external_connection.export
			fifo_full_tx_status_external_connection_export  => CONNECTED_TO_fifo_full_tx_status_external_connection_export,  --  fifo_full_tx_status_external_connection.export
			fsm_info_external_connection_export             => CONNECTED_TO_fsm_info_external_connection_export,             --             fsm_info_external_connection.export
			led_pio_test_external_connection_export         => CONNECTED_TO_led_pio_test_external_connection_export,         --         led_pio_test_external_connection.export
			link_disable_external_connection_export         => CONNECTED_TO_link_disable_external_connection_export,         --         link_disable_external_connection.export
			link_start_external_connection_export           => CONNECTED_TO_link_start_external_connection_export,           --           link_start_external_connection.export
			memory_mem_a                                    => CONNECTED_TO_memory_mem_a,                                    --                                   memory.mem_a
			memory_mem_ba                                   => CONNECTED_TO_memory_mem_ba,                                   --                                         .mem_ba
			memory_mem_ck                                   => CONNECTED_TO_memory_mem_ck,                                   --                                         .mem_ck
			memory_mem_ck_n                                 => CONNECTED_TO_memory_mem_ck_n,                                 --                                         .mem_ck_n
			memory_mem_cke                                  => CONNECTED_TO_memory_mem_cke,                                  --                                         .mem_cke
			memory_mem_cs_n                                 => CONNECTED_TO_memory_mem_cs_n,                                 --                                         .mem_cs_n
			memory_mem_ras_n                                => CONNECTED_TO_memory_mem_ras_n,                                --                                         .mem_ras_n
			memory_mem_cas_n                                => CONNECTED_TO_memory_mem_cas_n,                                --                                         .mem_cas_n
			memory_mem_we_n                                 => CONNECTED_TO_memory_mem_we_n,                                 --                                         .mem_we_n
			memory_mem_reset_n                              => CONNECTED_TO_memory_mem_reset_n,                              --                                         .mem_reset_n
			memory_mem_dq                                   => CONNECTED_TO_memory_mem_dq,                                   --                                         .mem_dq
			memory_mem_dqs                                  => CONNECTED_TO_memory_mem_dqs,                                  --                                         .mem_dqs
			memory_mem_dqs_n                                => CONNECTED_TO_memory_mem_dqs_n,                                --                                         .mem_dqs_n
			memory_mem_odt                                  => CONNECTED_TO_memory_mem_odt,                                  --                                         .mem_odt
			memory_mem_dm                                   => CONNECTED_TO_memory_mem_dm,                                   --                                         .mem_dm
			memory_oct_rzqin                                => CONNECTED_TO_memory_oct_rzqin,                                --                                         .oct_rzqin
			pll_0_locked_export                             => CONNECTED_TO_pll_0_locked_export,                             --                             pll_0_locked.export
			pll_0_outclk0_clk                               => CONNECTED_TO_pll_0_outclk0_clk,                               --                            pll_0_outclk0.clk
			reset_reset_n                                   => CONNECTED_TO_reset_reset_n,                                   --                                    reset.reset_n
			timecode_ready_rx_external_connection_export    => CONNECTED_TO_timecode_ready_rx_external_connection_export,    --    timecode_ready_rx_external_connection.export
			timecode_rx_external_connection_export          => CONNECTED_TO_timecode_rx_external_connection_export,          --          timecode_rx_external_connection.export
			timecode_tx_data_external_connection_export     => CONNECTED_TO_timecode_tx_data_external_connection_export,     --     timecode_tx_data_external_connection.export
			timecode_tx_enable_external_connection_export   => CONNECTED_TO_timecode_tx_enable_external_connection_export,   --   timecode_tx_enable_external_connection.export
			timecode_tx_ready_external_connection_export    => CONNECTED_TO_timecode_tx_ready_external_connection_export,    --    timecode_tx_ready_external_connection.export
			write_data_fifo_tx_external_connection_export   => CONNECTED_TO_write_data_fifo_tx_external_connection_export,   --   write_data_fifo_tx_external_connection.export
			write_en_tx_external_connection_export          => CONNECTED_TO_write_en_tx_external_connection_export           --          write_en_tx_external_connection.export
		);

