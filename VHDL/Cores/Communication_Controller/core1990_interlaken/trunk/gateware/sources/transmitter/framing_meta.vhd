library ieee;
use ieee.std_logic_1164.all;

entity Meta_Framer is
	generic(
		PacketLength : positive -- 2048 * 8 = 16KB - 128Kb each packet. Including the metaframing itself
	);
	port (
		clk   : in std_logic;
		reset : in std_logic;
		
		TX_Enable : in std_logic;
		
		HealthLane       : in std_logic;                      -- Lane status bit transmitted in diagnostic
		HealthInterface  : in std_logic;                      -- Interface status bit transmitted in diagnostic
		
		Data_In          : in std_logic_vector(63 downto 0);  -- Input data
		Data_Out         : out std_logic_vector(63 downto 0); -- To scrambling/framing
		Data_Valid_In    : in std_logic;				      -- Indicate data received is valid
		Data_Valid_Out   : out std_logic;				      -- Indicate data transmitted is valid
		Data_Control_In  : in std_logic;                      -- Control word indication from the burst component
		Data_Control_Out : out std_logic;                     -- Control word indication
		
		Gearboxready  : in std_logic;
		
		FIFO_read     : out std_logic	
	);
end Meta_Framer;

architecture framing of Meta_Framer is
	type state_type is (IDLE, SCRAM, SKIP, DATA, P1, P2, P3, DIAG);
	signal pres_state, next_state : state_type;
	
	signal Packet_Counter : integer range 0 to PacketLength;
	
	signal Data_Control, Data_Control_Meta, Data_Control_Burst, Data_Valid : std_logic;
		
	signal Data_P1, Data_P2, Data_P3 : std_logic_vector (63 downto 0);        -- Pipeline for framing
	signal Control_P1, Control_P2, Control_P3 : std_logic;
	
	signal Data_valid_p1, Data_valid_p2, Data_valid_p3, Data_valid_framed : std_logic;
	
	signal Data_ControlValid_P1, Data_ControlValid_P2 : std_logic_vector (1 downto 0); --Pipeline for CRC calculation
	signal Data_Framed, Data_Framed_P1, Data_Framed_P2: std_logic_vector (63 downto 0);
	
    signal CRC32_Out    : std_logic_vector(31 downto 0);   -- Calculated CRC-32 which returns
    signal CRC32_En     : std_logic;                       -- Indicate the CRC-32 the data is valid
    signal CRC32_Rst    : std_logic;                       -- CRC-32 reset
    signal CRC32_Calc   : std_logic;
    signal CRC32_Ready  : std_logic;
    signal CRC32_Rst_P1 : std_logic;
    
    signal Gearboxready_P1 : std_logic;
begin

    ---------------------- CRC-32 -----------------------------
    CRC_32_Encoding : entity work.CRC_32
    generic map
    (
        Nbits       => 64,
        CRC_Width   => 32,
        G_Poly      => X"1EDC_6F41",
        G_InitVal   => X"FFFF_FFFF"
    )
    port map
    (
        Clk     => Clk,
        DIn     => Data_Framed,
        CRC     => CRC32_Out,
        Calc    => CRC32_Calc,
        Reset   => CRC32_Rst
    );
	CRC32_Calc <= CRC32_En and Gearboxready_P1;
	
	------------- Wait for CRC-32 and output data -------------
	diagnostic : process (clk, reset) is
	   variable CRC32_Out_v: std_logic_vector(31 downto 0);
	begin
        if (reset = '1') then
            Data_Framed_P1       <= (others => '0');
            Data_Framed_P2       <= (others => '0');
            Data_ControlValid_P1 <= (others => '0');
            Data_ControlValid_P2 <= (others => '0');
            Data_Out             <= (others => '0');
            Data_Control_Out     <= '0';
            Data_Valid_Out       <= '0';
        elsif (rising_edge(clk)) then
            Gearboxready_P1 <= Gearboxready;
            CRC32_Rst_P1 <= CRC32_Rst;
            
            if(CRC32_Rst_P1 = '1') then
                CRC32_Out_v := CRC32_Out;
            end if;
            
            if(Gearboxready = '1') then
                Data_Framed_P1  <= Data_Framed;
                Data_Framed_P2  <= Data_Framed_P1;
                Data_Out        <= Data_Framed_P2;
                
                Data_ControlValid_P1 <= Data_Control & (Data_Valid or Data_valid_framed); -- Waiting for CRC calculation to be ready
                Data_ControlValid_P2 <= Data_ControlValid_P1;
                Data_Control_Out     <= Data_ControlValid_P2(1);
                Data_Valid_Out       <= Data_ControlValid_P2(0);

                if((Data_ControlValid_P2(1) = '1') and (Data_Framed_P2(63 downto 58) = "011001")) then
                    Data_Out(31 downto 0) <= CRC32_Out_v;
                end if;
            end if;
        end if;
	end process diagnostic;

	----------------- Determine control word ------------------
	control_word : process (data_control_meta, data_control_burst, gearboxready) is
    begin
        if((Data_Control_Meta = '1' or Data_Control_Burst= '1') and Gearboxready = '1') then
            Data_Control <= '1';
        else
            Data_Control <= '0';
        end if;
    end process control_word;
    
    ---------------- Control bit pipeline ---------------------
    control_pipeline : process(clk, reset) is
    begin
        if(reset = '1') then
            Data_Control_Burst <= '0';
            Control_P3 <= '0';
            Control_P2 <= '0';
            Control_P1 <= '0';
        elsif(rising_edge(clk)) then
            if(Gearboxready = '1') then
                Data_Control_Burst <= Control_P3;
                Control_P3 <= Control_P2;
                Control_P2 <= Control_P1;
                Control_P1 <= Data_Control_In;
            end if;
        end if;
    end process control_pipeline;
	
    ------------ State machine for meta framing ---------------
	state_register : process (clk) is
	begin
		if (rising_edge(clk)) then
			pres_state <= next_state;
		end if;
	end process state_register;
	
	state_decoder : process (pres_state, Data_valid_in , Packet_Counter, Gearboxready, TX_enable) is
	begin
	    if(Gearboxready = '0') then
            next_state <= pres_state;
        else        
            case pres_state is
            when IDLE =>
                if(TX_Enable = '1') then
                    next_state <= SCRAM;
                else
                    next_state <= IDLE;
                    --Optional error state for not receiving valid data?
                end if;
            when SCRAM =>
                next_state <= SKIP;
            when SKIP =>
                next_state <= DATA;
            when DATA => 
                if (Packet_Counter >= (PacketLength - 5)) then
                    next_state <= P1;
                else
                    next_state <= DATA;
                end if;
            when P1 =>
                next_state <= P2;
            when P2 =>
                next_state <= P3;
            when P3 =>
                next_state <= DIAG;
            when DIAG =>
                next_state <= IDLE;
            when others => 
                next_state <= IDLE;
            end case;
        end if;
	end process state_decoder;

	output : process (clk) is
	begin
        if rising_edge(clk) then
            CRC32_RST <= '0';
            
            if(Gearboxready = '0') then
                NULL;
            else
                case pres_state is
                when IDLE =>  
                    Data_Valid        <= '0';
                    Data_Framed       <= (others => '0');
                    FIFO_Read         <= '1';
                    Data_Control_Meta <= '0';
                    
                    if (TX_Enable = '1') then
                        Data_Framed       <= X"78f6_78f6_78f6_78f6"; -- Predefined sync word
                        Data_Control_Meta <= '1';
                        Data_Valid        <= '1';
                        CRC32_Rst         <= '1';
                    end if;
                    
                    Packet_Counter <= 1;
                    Data_P1        <= Data_in;
                    Data_valid_p1  <= Data_Valid_In;
                    CRC32_En       <= '1';
                    
                when SCRAM =>
                    Data_Valid     <= '1';
                    Packet_Counter <= Packet_Counter + 1;
                    Data_Framed    <= X"2800_0000_0000_0000"; -- Scrambler state (real data added later)
                    
                    Data_P2 <= Data_P1;
                    Data_P1 <= Data_in;
                    
                    Data_valid_p2 <= Data_valid_p1;
                    Data_valid_p1 <= Data_Valid_In;
                    
                when SKIP =>
                    Data_Valid     <= '1';
                    Packet_Counter <= Packet_Counter + 1;
                    Data_Framed    <= X"1e1e_1e1e_1e1e_1e1e"; -- Predefined skip word
                   
                    Data_P3 <= Data_P2;
                    Data_P2 <= Data_P1;
                    Data_P1 <= Data_in;
                    
                    Data_valid_p3 <= Data_valid_p2;
                    Data_valid_p2 <= Data_valid_p1;
                    Data_valid_p1 <= Data_Valid_In;
                                       
                when DATA =>
                    CRC32_EN          <= '1';
                    Packet_Counter    <= Packet_Counter + 1;
                    Data_Control_Meta <= '0';
                    Data_valid        <= '0';
                    
                    Data_Framed <= Data_P3; 
                    Data_P3     <= Data_P2;
                    Data_P2     <= Data_P1;
                    Data_P1     <= Data_in;
                    
                    Data_valid_framed <= Data_valid_p3;
                    Data_valid_p3     <= Data_valid_p2;
                    Data_valid_p2     <= Data_valid_p1;
                    Data_valid_p1     <= Data_Valid_In;
                    
                    if(packet_counter >= (PacketLength - 6) and packet_counter < (PacketLength - 3)) then -- Still 4 packets incoming after FIFO read disable
                        FIFO_Read <= '0';                         -- PacketLength - 4 packets - 1 - 1 cycle delay fifo read - 4 cycle delay burst component
                    else
                        FIFO_Read <= '1';
                    end if;
                    
                when P1 =>
                    Packet_Counter <= Packet_Counter + 1;
                    
                    Data_Framed <= Data_P3; 
                    Data_P3     <= Data_P2;
                    Data_P2     <= Data_P1;
                    
                    Data_valid_framed <= Data_valid_p3;
                    Data_valid_p3     <= Data_valid_p2;
                    Data_valid_p2     <= Data_valid_p1;
                    
                when P2 =>
                    Packet_Counter    <= Packet_Counter + 1;
                    Data_Framed       <= Data_P3; 
                    Data_P3           <= Data_P2;
                    Data_valid_framed <= Data_valid_p3;
                    Data_valid_p3     <= Data_valid_p2;
                
                when P3 =>
                    Packet_Counter    <= Packet_Counter + 1;
                    Data_Framed       <= Data_P3; 
                    Data_valid_framed <= Data_valid_p3;
                    FIFO_Read         <= '1';
                    
                when DIAG =>
                    Data_Valid      <= '1';
                    Packet_Counter  <= Packet_Counter + 1;
                    Data_Framed     <= X"6400_0000_0000_0000"; -- Diagnostic word including CRC32
                    Data_Framed(33 downto 32) <= HealthLane & HealthInterface;
                    Data_Control_Meta         <= '1';
                end case;
            end if;
	    end if;
	end process output;
end architecture framing;

