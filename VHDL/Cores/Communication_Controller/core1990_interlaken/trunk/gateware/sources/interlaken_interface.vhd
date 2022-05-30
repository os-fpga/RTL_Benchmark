library ieee; 
use ieee.std_logic_1164.all;
library work;

entity interlaken_interface is
    generic(
        BurstMax     : positive;   -- Configurable value of BurstMax
        BurstShort   : positive;   -- Configurable value of BurstShort
        PacketLength : positive    -- Configurable value of PacketLength
    );
	port (
	    ------ 200 MHz input, to clock generator -----------
        System_Clock_In_P : in std_logic;
        System_Clock_In_N : in std_logic;
        
        ----125/156,25 MHz input, to transceiver (SGMII/SMA clock)--
        GTREFCLK_IN_P : in std_logic;
        GTREFCLK_IN_N : in std_logic;
        
        ------ User clk output, to other logic -------------
        System_Clock_Gen : out std_logic;
        
        ---------- Data signals ----------------------------
		TX_Data 	: in std_logic_vector(63 downto 0);          -- Data transmitted
        RX_Data     : out std_logic_vector(63 downto 0);         -- Data received
		
		---- Transceiver related transmission --------------
		TX_Out_P  : out std_logic;
		TX_Out_N  : out std_logic;
		RX_In_P   : in std_logic;
        RX_In_N   : in std_logic;
		
		---- Transmitter input/ready signals ---------------
		TX_SOP          : in std_logic;
		TX_EOP          : in std_logic;
		TX_EOP_Valid    : in std_logic_vector(2 downto 0);
		TX_FlowControl  : in std_logic_vector(15 downto 0);
        TX_Channel      : in std_logic_vector(7 downto 0);
		
		------ Receiver output signals ---------------------
		RX_SOP        	: out std_logic;                         -- Start of Packet
		RX_EOP        	: out std_logic;                         -- End of Packet
		RX_EOP_Valid 	: out std_logic_vector(2 downto 0);      -- Valid bytes packet contains
		RX_FlowControl	: out std_logic_vector(15 downto 0);     -- Flow control data (yet unutilized)
		RX_Channel    	: out std_logic_vector(7 downto 0);      -- Select transmit channel (yet unutilized)
		
		RX_Valid_Out    : out std_logic;
		
		------ Transmitter status signals-------------------
		TX_FIFO_Full    : out std_logic;
        TX_FIFO_Write   : in std_logic;
        TX_FIFO_progfull: out std_logic;
        
        ---------- Debug signals ----------------------------
        RX_in            : out std_logic_vector(63 downto 0);
        TX_out           : out std_logic_vector(63 downto 0);
        Data_Descrambler : out std_logic_vector(63 downto 0);
        Data_Decoder     : out std_logic_vector(63 downto 0);
		
		------- Receiver status signals ---------------------
		RX_FIFO_Full      : out std_logic;
		RX_FIFO_Read      : in std_logic;
		Decoder_lock      : out std_logic;
		Descrambler_lock  : out std_logic;
		CRC24_Error       : out std_logic;
		CRC32_Error       : out std_logic
		
	);
end entity interlaken_interface;

architecture interface of interlaken_interface is
    
    -------------------------- Generate System Clock ---------------------------
    component clk_40MHz
    port (
        --Clock in- and output signals
        clk_in1_p         : in     std_logic;
        clk_in1_n         : in     std_logic;
        clk_out1          : out    std_logic;
        clk_out2          : out    std_logic;
        
        -- Status and control signals
        reset             : in     std_logic;
        locked            : out    std_logic
    );
    end component;
    
    -------------------------- Include Transceiver -----------------------------
    component Transceiver_10g_64b67b
    Port ( 
        SOFT_RESET_TX_IN : in STD_LOGIC;
        SOFT_RESET_RX_IN : in STD_LOGIC;
        DONT_RESET_ON_DATA_ERROR_IN : in STD_LOGIC;
        Q0_CLK1_GTREFCLK_PAD_N_IN : in STD_LOGIC;
        Q0_CLK1_GTREFCLK_PAD_P_IN : in STD_LOGIC;
        GT0_TX_FSM_RESET_DONE_OUT : out STD_LOGIC;
        GT0_RX_FSM_RESET_DONE_OUT : out STD_LOGIC;
        GT0_DATA_VALID_IN : in STD_LOGIC;
        GT0_TX_MMCM_LOCK_OUT : out STD_LOGIC;
        GT0_RX_MMCM_LOCK_OUT : out STD_LOGIC;
        GT0_TXUSRCLK_OUT : out STD_LOGIC;
        GT0_TXUSRCLK2_OUT : out STD_LOGIC;
        GT0_RXUSRCLK_OUT : out STD_LOGIC;
        GT0_RXUSRCLK2_OUT : out STD_LOGIC;
        gt0_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
        gt0_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
        gt0_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
        gt0_drpen_in : in STD_LOGIC;
        gt0_drprdy_out : out STD_LOGIC;
        gt0_drpwe_in : in STD_LOGIC;
        gt0_dmonitorout_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
        gt0_eyescanreset_in : in STD_LOGIC;
        gt0_rxuserrdy_in : in STD_LOGIC;
        gt0_eyescandataerror_out : out STD_LOGIC;
        gt0_eyescantrigger_in : in STD_LOGIC;
        gt0_rxdata_out : out STD_LOGIC_VECTOR ( 63 downto 0 );
        gt0_gtxrxp_in : in STD_LOGIC;
        gt0_gtxrxn_in : in STD_LOGIC;
        gt0_rxdfelpmreset_in : in STD_LOGIC;
        gt0_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
        gt0_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
        gt0_rxoutclkfabric_out : out STD_LOGIC;
        gt0_rxdatavalid_out : out STD_LOGIC;
        gt0_rxheader_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
        gt0_rxheadervalid_out : out STD_LOGIC;
        gt0_rxgearboxslip_in : in STD_LOGIC;
        gt0_gtrxreset_in : in STD_LOGIC;
        gt0_rxpmareset_in : in STD_LOGIC;
        gt0_rxresetdone_out : out STD_LOGIC;
        gt0_gttxreset_in : in STD_LOGIC;
        gt0_txuserrdy_in : in STD_LOGIC;
        gt0_txdata_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
        gt0_gtxtxn_out : out STD_LOGIC;
        gt0_gtxtxp_out : out STD_LOGIC;
        gt0_txoutclkfabric_out : out STD_LOGIC;
        gt0_txoutclkpcs_out : out STD_LOGIC;
        gt0_txgearboxready_out : out STD_LOGIC;
        gt0_txheader_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
        gt0_txstartseq_in : in STD_LOGIC;
        gt0_txresetdone_out : out STD_LOGIC;
        GT0_QPLLLOCK_OUT : out STD_LOGIC;
        GT0_QPLLREFCLKLOST_OUT : out STD_LOGIC;
        GT0_QPLLOUTCLK_OUT : out STD_LOGIC;
        GT0_QPLLOUTREFCLK_OUT : out STD_LOGIC;
        sysclk_in : in STD_LOGIC
    );
    end component;
    
    signal System_Clock_40, System_Clock_user: std_logic;
    signal TX_User_Clock, RX_User_Clock : std_logic;
    
    signal RX_prog_full         : std_logic_vector(15 downto 0);    
    signal FlowControl          : std_logic_vector(15 downto 0);
    signal RX_Datavalid_Out     : std_logic;
    signal RX_Header_Out        : std_logic_vector(2 downto 0);
    signal RX_Headervalid_Out   : std_logic;
    signal RX_Gearboxslip_In    : std_logic;
    signal RX_Resetdone_Out     : std_logic;
    
    signal TX_Gearboxready_Out  : std_logic;
    signal TX_Header_In         : std_logic_vector(2 downto 0);
    signal TX_Startseq_In       : std_logic;
    signal TX_Resetdone_Out     : std_logic;
    
    signal Data_Transceiver_In, Data_Transceiver_Out : std_logic_vector(63 downto 0);
    signal GT0_DATA_VALID_IN         : std_logic;
    signal GT0_TX_FSM_RESET_DONE_OUT : std_logic;
    signal locked, reset            : std_logic;     
    signal link_up                  : std_logic;
    signal Descrambler_Locked       : std_logic;
            
begin
    ------------------------------ System Clock --------------------------------
    System_Clock : clk_40MHz
    port map (
        clk_in1_p => System_Clock_In_P,
        clk_in1_n => System_Clock_In_N, 
        clk_out1  => System_Clock_40,
        clk_out2  => System_Clock_user,
                    
        reset   => '0',
        locked  => locked
    );
    
    System_Clock_Gen <= System_Clock_user;
    reset <= not locked;

    ------------------------------- Transceiver --------------------------------
    Transceiver_10g_64b67b_i : Transceiver_10g_64b67b
    port map (
        SOFT_RESET_TX_IN            => reset,
        SOFT_RESET_RX_IN            => reset,
        DONT_RESET_ON_DATA_ERROR_IN => '0',
        Q0_CLK1_GTREFCLK_PAD_N_IN   => GTREFCLK_IN_N,
        Q0_CLK1_GTREFCLK_PAD_P_IN   => GTREFCLK_IN_P,
        
        GT0_TX_FSM_RESET_DONE_OUT => GT0_TX_FSM_RESET_DONE_OUT,
        GT0_RX_FSM_RESET_DONE_OUT => open,
        GT0_DATA_VALID_IN         => GT0_DATA_VALID_IN,
        GT0_TX_MMCM_LOCK_OUT      => open,
        GT0_RX_MMCM_LOCK_OUT      => open,
        
        GT0_TXUSRCLK_OUT    => open,
        GT0_TXUSRCLK2_OUT   => TX_User_Clock,
        GT0_RXUSRCLK_OUT    => open,
        GT0_RXUSRCLK2_OUT   => RX_User_Clock,
        
        --_________________________________________________________________________
        --GT0  (X0Y2)
        --____________________________CHANNEL PORTS________________________________
        ---------------------------- Channel - DRP Ports  --------------------------
        gt0_drpaddr_in                  =>      (others => '0'),
        gt0_drpdi_in                    =>      (others => '0'),
        gt0_drpdo_out                   =>      open,
        gt0_drpen_in                    =>      '0',
        gt0_drprdy_out                  =>      open,
        gt0_drpwe_in                    =>      '0',
        --------------------------- Digital Monitor Ports --------------------------
        gt0_dmonitorout_out             =>      open,
        
        --------------------- RX Initialization and Reset Ports --------------------
        gt0_eyescanreset_in             =>      '0',
        gt0_rxuserrdy_in                =>      '1',
        -------------------------- RX Margin Analysis Ports ------------------------
        gt0_eyescandataerror_out        =>      open,
        gt0_eyescantrigger_in           =>      '0',
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt0_rxdata_out                  =>      Data_Transceiver_Out,
        --------------------------- Receive Ports - RX AFE -------------------------
        gt0_gtxrxp_in                   =>      RX_In_P,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt0_gtxrxn_in                   =>      RX_In_N,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt0_rxdfelpmreset_in            =>      '0',
        gt0_rxmonitorout_out            =>      open,
        gt0_rxmonitorsel_in             =>      (others => '0'),
        --------------- Receive Ports - RX Fabric Output Control Ports -------------
        gt0_rxoutclkfabric_out          =>      open,
        ---------------------- Receive Ports - RX Gearbox Ports --------------------
        gt0_rxdatavalid_out             =>      RX_Datavalid_Out,
        gt0_rxheader_out                =>      RX_Header_Out,
        gt0_rxheadervalid_out           =>      RX_Headervalid_Out,
        --------------------- Receive Ports - RX Gearbox Ports  --------------------
        gt0_rxgearboxslip_in            =>      RX_Gearboxslip_In,
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt0_gtrxreset_in                =>      reset,
        gt0_rxpmareset_in               =>      '0',
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt0_rxresetdone_out             =>      RX_Resetdone_Out,
        
        --------------------- TX Initialization and Reset Ports --------------------
        gt0_gttxreset_in                =>      reset,
        gt0_txuserrdy_in                =>      '1',
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt0_txdata_in                   =>      Data_Transceiver_In,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt0_gtxtxn_out                  =>      TX_Out_N,
        gt0_gtxtxp_out                  =>      TX_Out_P,
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt0_txoutclkfabric_out          =>      open,
        gt0_txoutclkpcs_out             =>      open,
        --------------------- Transmit Ports - TX Gearbox Ports --------------------
        gt0_txgearboxready_out          =>      TX_Gearboxready_Out,
        gt0_txheader_in                 =>      TX_Header_In,
        gt0_txstartseq_in               =>      TX_Startseq_In,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt0_txresetdone_out             =>      TX_Resetdone_Out,
        --____________________________COMMON PORTS________________________________
        GT0_QPLLLOCK_OUT        => open,
        GT0_QPLLREFCLKLOST_OUT  => open,
        GT0_QPLLOUTCLK_OUT      => open,
        GT0_QPLLOUTREFCLK_OUT   => open,
        sysclk_in               => System_Clock_40
    );
        
    startseq : process (TX_User_Clock)
    begin
        if rising_edge(TX_User_Clock) then
            if (reset = '1') then
                TX_Startseq_In <= '0';
            elsif (TX_Gearboxready_Out = '1') then
                TX_Startseq_In <= '1';           
            end if;
        end if;
    end process;
    
    ---------------------------- Transmitting side -----------------------------
    Interlaken_TX : entity work.Interlaken_Transmitter
    generic map(
        BurstMax        => BurstMax,      -- Configurable value of BurstMax
        BurstShort      => BurstShort,    -- Configurable value of BurstShort
        PacketLength    => PacketLength -- Configurable value of PacketLength
    )
    port map (
        write_clk   => System_Clock_user,
        clk         => TX_User_Clock,
        reset       => reset,
        
        TX_Data_In  => TX_Data,
        TX_Data_Out(63 downto 0) => Data_Transceiver_In,
        TX_Data_Out(66 downto 64) => TX_Header_In,
        
        TX_SOP          => TX_SOP,
        TX_EOP_Valid    => TX_EOP_Valid,
        TX_EOP          => TX_EOP,
        TX_Channel      => TX_Channel,
        TX_Gearboxready => TX_Gearboxready_Out,
        TX_Startseq     => TX_Startseq_In,
        
        FIFO_Write_Data => TX_FIFO_Write,
        FIFO_prog_full  => TX_FIFO_progfull,
        
        TX_FlowControl  => FlowControl,
        RX_prog_full    => RX_prog_full,
        
        Link_up         => Descrambler_locked,
        FIFO_Full       => TX_FIFO_Full,
        
        TX_valid_out    => GT0_DATA_VALID_IN
    );
    
    TX_out <= Data_Transceiver_In;
    
    ---------------------------- Receiving side --------------------------------
    Interlaken_RX : entity work.Interlaken_Receiver
    generic map (
        PacketLength => PacketLength
    )
    port map (
        fifo_read_clk   => System_Clock_user,
        clk             => RX_User_Clock,
        reset           => reset,
        
        RX_Data_In(63 downto 0) => Data_Transceiver_Out,
        RX_Data_In(66 downto 64)=> RX_Header_Out,
        RX_Data_Out             => RX_Data,
        RX_Valid_Out            => RX_Valid_Out,
        
        RX_SOP          => RX_SOP,
        RX_EOP_valid    => RX_EOP_Valid,
        RX_EOP          => RX_EOP,
        RX_FlowControl  => FlowControl,
        RX_prog_full    => RX_prog_full,
        RX_Channel      => RX_Channel,
        RX_Datavalid    => RX_Datavalid_Out,
        
        Descrambler_Lock    => Descrambler_Locked,
        Decoder_Lock        => Decoder_Lock,
        CRC24_Error         => CRC24_Error,
        CRC32_Error         => CRC32_Error,
        
        Data_Descrambler    => Data_Descrambler, 
        Data_Decoder        => Data_Decoder,
        
        RX_FIFO_Full        => RX_FIFO_Full,
        RX_FIFO_Read        => RX_FIFO_Read,
           
        RX_Link_Up          => Link_Up,
        Bitslip             => RX_Gearboxslip_In
    );
    
    Descrambler_Lock <= Descrambler_locked;
    RX_in            <= Data_Transceiver_Out;
    
end architecture interface;
