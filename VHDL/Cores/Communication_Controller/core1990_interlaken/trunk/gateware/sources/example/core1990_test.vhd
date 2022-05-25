library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;

entity Interface_Test is
    port(
		System_Clock_In_P : in std_logic;
		System_Clock_In_N : in std_logic;
		
		GTREFCLK_IN_P : in std_logic;
		GTREFCLK_IN_N : in std_logic;
		
		USER_CLK_IN_P : in std_logic;
		USER_CLK_IN_N : in std_logic;
		
		USER_SMA_CLK_OUT_P : out std_logic;
		USER_SMA_CLK_OUT_N : out std_logic;
		
		TX_Out_P     : out std_logic;
		TX_Out_N     : out std_logic;
		RX_In_P      : in std_logic;
		RX_In_N      : in std_logic;
		
		Lock_Out  : out std_logic;
		Valid_out : out std_logic
    );
end entity Interface_test;

architecture Test of Interface_Test is
    
    signal TX_Data 	: std_logic_vector(63 downto 0);            -- Data transmitted
    signal RX_Data  : std_logic_vector(63 downto 0);            -- Data received
    
    signal TX_SOP          : std_logic;
    signal TX_EOP          : std_logic;
    signal TX_EOP_Valid    : std_logic_vector(2 downto 0);
    signal TX_FlowControl  : std_logic_vector(15 downto 0);
    signal TX_Channel      : std_logic_vector(7 downto 0);
    
    signal RX_SOP        	: std_logic;                         -- Start of Packet
    signal RX_EOP        	: std_logic;                         -- End of Packet
    signal RX_EOP_Valid 	: std_logic_vector(2 downto 0);      -- Valid bytes packet contains
    signal RX_FlowControl	: std_logic_vector(15 downto 0);     -- Flow control data (yet unutilized)
    signal RX_Channel    	: std_logic_vector(7 downto 0);      -- Select transmit channel (yet unutilized)
    
    signal RX_Valid_Out     : std_logic;
    
    signal TX_FIFO_Full      : std_logic;
    signal TX_FIFO_progfull  : std_logic;
    signal TX_FIFO_Write     : std_logic;
    signal RX_FIFO_Read      : std_logic;
    signal RX_FIFO_Full      : std_logic;
    
    signal Decoder_lock      : std_logic;
    signal Descrambler_lock  : std_logic;
    signal CRC24_Error       : std_logic;
    signal CRC32_Error       : std_logic;
    
    signal pipeline_length   : std_logic_vector(6 downto 0);
    signal TX_Info_Pipelined : std_logic_vector(4 downto 0);
    signal TX_Data_Pipelined : std_logic_vector(63 downto 0);
    signal RX_Info           : std_logic_vector(4 downto 0);
    signal System_Clock      : std_logic;
	
	signal valid_probe, RX_Valid : std_logic_vector(0 downto 0);
	signal packet_length         : std_logic_vector(6 downto 0);
	signal RX_in                 : std_logic_vector(63 downto 0);
    signal TX_out                : std_logic_vector(63 downto 0);
    signal Data_Descrambler      : std_logic_vector(63 downto 0);
    signal Data_Decoder          : std_logic_vector(63 downto 0);
            
	COMPONENT ILA_Data
	PORT (
		clk : IN STD_LOGIC;
		probe0 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		probe1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		probe2 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		probe3 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        probe4 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe5 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        probe6 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe7 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        probe8 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        probe9 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        probe10 : IN STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
	END COMPONENT;
	    
    COMPONENT vio_0
    PORT (
        clk : IN STD_LOGIC;
        probe_out0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        probe_out1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
    END COMPONENT;

    signal USER_CLK, USER_SMA_CLK: std_logic;
begin

    -------Reference clock routing
    user_clk_ibuf : IBUFDS port map(
        I => USER_CLK_IN_P, 
        IB => USER_CLK_IN_N,
        O => USER_CLK
    ); 

    USER_SMA_CLK <= USER_CLK;

    user_sma_clk_obuf: OBUFDS port map(
        I => USER_SMA_CLK,
        O => USER_SMA_CLK_OUT_P, 
        OB => USER_SMA_CLK_OUT_N
    ); 
        
	------- The Interlaken Interface -------
    interface : entity work.interlaken_interface
    generic map(
         BurstMax     => 256, --(Bytes)
         BurstShort   => 64, --(Bytes)
         PacketLength => 2028 --(Packets)
    )
    port map (
        System_Clock_In_P => System_Clock_In_P,
        System_Clock_In_N => System_Clock_In_N,
        GTREFCLK_IN_P => GTREFCLK_IN_P,
        GTREFCLK_IN_N => GTREFCLK_IN_N,
        
        System_Clock_Gen => System_Clock,
        
        TX_Data => TX_Data,
        RX_Data => RX_Data,
        
        RX_In_N => RX_In_N,
        RX_In_P => RX_In_P,  
        TX_Out_N => TX_Out_N,
        TX_Out_P => TX_Out_P,  
        
        TX_FIFO_Write => TX_FIFO_Write,
        TX_SOP => TX_SOP,
        TX_EOP => TX_EOP,
        TX_EOP_Valid => TX_EOP_Valid,
        TX_FlowControl => TX_FlowControl,
        TX_Channel => TX_Channel,
        
        RX_FIFO_Read => RX_FIFO_Read,
        RX_SOP => RX_SOP, 
        RX_EOP => RX_EOP,
        RX_EOP_Valid => RX_EOP_Valid,
        RX_FlowControl => RX_FlowControl,
        RX_Channel => RX_Channel,
        
        TX_FIFO_progfull => TX_FIFO_progfull,
        
        RX_Valid_Out => RX_Valid_Out,
        TX_FIFO_Full => TX_FIFO_Full,
        RX_FIFO_Full => RX_FIFO_Full,
        
        RX_in => RX_in,
        TX_out => TX_out,
        Data_Descrambler => Data_Descrambler,
        Data_Decoder => Data_Decoder,
        
        Decoder_lock => Decoder_lock,
        Descrambler_lock => Descrambler_lock,
        CRC24_Error => CRC24_Error,
        CRC32_Error => CRC32_Error
    );
    
    ---- Generates input data and interface signals ----
    generate_data : entity work.data_generator
    port map (
		clk => System_Clock,
	    Packet_length => packet_length,
	    --link_up => Link_up,
	    TX_FIFO_Full => TX_FIFO_progfull,
	    
	    write_enable => TX_FIFO_Write,
	    data_out => TX_Data,
        sop 	 => TX_SOP,
        eop		 => TX_EOP,
        eop_valid=> TX_EOP_Valid,
        channel	 => TX_Channel
    );
    
    ---- Pipelines input data for alignment with output data ----
    pipeline_data : entity work.pipe
    generic map (
		Nmax => 128
	)
	port map (
	    N => pipeline_length,
        clk => System_Clock,
        pipe_in(68 downto 66) => TX_EOP_Valid,
        pipe_in(65) => TX_EOP,
        pipe_in(64) => TX_SOP,
	    pipe_in(63 downto 0) => TX_Data,
	    
	    pipe_out(68 downto 64) => TX_Info_Pipelined,
	    pipe_out(63 downto 0) => TX_Data_Pipelined
	);
	RX_Info <= RX_EOP_valid & RX_EOP & RX_SOP;
	
	-------- Integrated Logic Analyzer --------
	probe_data : ILA_Data
	PORT MAP (
		clk => System_Clock,
		probe0 => TX_Data_Pipelined,
		probe1 => TX_Info_Pipelined,
		probe2 => RX_Data,
		probe3 => RX_Info,
		probe4 => valid_probe,
		probe5 => TX_FIFO_progfull & Decoder_Lock & Descrambler_Lock,
		probe6 => RX_Valid,
		probe7 => RX_in,
		probe8 => TX_out,
		probe9 => Data_Descrambler,
		probe10 => Data_Decoder
	);
	RX_Valid(0) <= RX_Valid_Out;
	
	-------- Validates the data integrity ---------
	valid : process (TX_data_pipelined, RX_data, TX_info_pipelined, RX_info)
	begin
	   if(TX_Data_Pipelined = RX_Data and TX_info_pipelined = RX_info) then
	       valid_out <= '1';
	       valid_probe <= "1";
       else 
           valid_out <= '0';
           valid_probe <= "0";
       end if;
    end process;
    RX_FIFO_Read <= not TX_FIFO_progfull;

    ------------- Virtual input/output -------------
    VIO : vio_0
    PORT MAP (
        clk => System_Clock,
        probe_out0 => packet_length,
        probe_out1 => pipeline_length
    );
    
    --------------- Lock detection ---------------
    lock : process (Descrambler_Lock) 
    begin
        if (Descrambler_Lock = '1') then
            Lock_Out <= '1';
        else
            Lock_Out <= '0';
        end if;
    end process;

end architecture Test;
