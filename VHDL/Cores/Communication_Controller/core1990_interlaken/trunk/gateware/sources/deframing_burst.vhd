library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Burst_Deframer is
    port(
        Clk              : in std_logic;                     -- Clock input
        Reset		     : in std_logic;					 -- Reset decoder
        
        Data_In          : in std_logic_vector(63 downto 0); -- Data input
        Data_Out         : out std_logic_vector(68 downto 0); --Data output including SOP, EOP and EOP_valid
        
        Data_Control_In  : in std_logic;                     --	Indicates whether the word is data or control
        Data_Valid_In    : in std_logic;
        Data_Valid_Out   : out std_logic;                    -- Indicated valid data and enables the fifo write pin
        
        CRC24_Error      : out std_logic;
        Flowcontrol      : out std_logic_vector(15 downto 0)
    );
end entity Burst_Deframer;

architecture Deframing of Burst_Deframer is
    type state_type is (IDLE, CRC);
    signal pres_state, next_state : state_type;
    
    signal Packet_Counter : integer range 0 to 60;
    signal Data_P1, Data_P2, Data_P3 : std_logic_vector(65 downto 0);
    signal Data_Temp : std_logic_vector(65 downto 0);
    signal data_word_reg, data_word_reg_p1 : std_logic_vector(63 downto 0);
    signal control_word_reg : std_logic_vector(1 downto 0);
    signal packet_ready, packet_busy : std_logic;
    
    signal CRC24_Value, CRC24_Value_P1 : std_logic_vector(23 downto 0) := (others => '0'); -- CRC-24 value received
    signal SOP, SOP_p1 : std_logic;
    signal EOP         : std_logic;
    signal EOP_Valid   : std_logic_vector(2 downto 0);
    signal Channel     : std_logic_vector(7 downto 0);
    
    -- CRC-24 related
    signal CRC24_In  : std_logic_vector(63 downto 0);   -- Data transmitted to CRC-24
    signal CRC24_Out : std_logic_vector(23 downto 0);   -- Calculated CRC-24 which returns
    signal CRC24_En  : std_logic;                       -- Indicate the CRC-24 the data is valid
    signal CRC24_Rst : std_logic;                       -- CRC-24 reset
    
begin
    
    -------------------------------- CRC-24 --------------------------------------
    CRC_24_Encoding : entity work.CRC_24
    generic map
    (
        Nbits       => 64,
        CRC_Width   => 24,
        G_Poly      => X"32_8B63",
        G_InitVal   => X"FF_FFFF"
    )
    port map
    (
        Clk     => Clk,
        DIn     => CRC24_In,
        CRC     => CRC24_Out,
        Calc    => CRC24_En,
        Reset   => CRC24_Rst
    );
    
    --------------------------- Input registers ----------------------------------
    input : process (Clk, Reset) is
    begin 
        if (Reset = '1') then
            Data_P1 <= (others => '0');
            Data_P2 <= (others => '0');
            Data_P3 <= (others => '0');
            
        elsif (rising_edge(clk)) then
            Data_P3 <= Data_P2;
            Data_P2 <= Data_P1;
            Data_P1 <= Data_valid_in & Data_Control_In & Data_In;
            
        end if;
    end process input;
    
    ---------------------------- Check CRC-24 ------------------------------------
    CRC_Check : process (clk, reset) is
    begin
        if (Reset = '1') then
            CRC24_Error <= '0';
            CRC24_Rst   <= '1';
            CRC24_En    <= '0';
        elsif (rising_edge(clk)) then
            CRC24_Rst <= '0';
            CRC24_En  <= '1';
            
            CRC24_Value <= CRC24_Value_P1; -- CRC24 pipeline to prevent mistimings in reading the value
            
            if (Data_P1(64 downto 63) = "11") then --Control word and idle/burst word
                CRC24_Rst <= '1';
            end if;
            
            if(Data_Valid_In = '0') then
                CRC24_En <= '0';
            end if;
            
            --Check for max burst length word or end of burst (contains CRC-24)
            if (Data_P3(64 downto 63) = "11" and Data_P3(61) = '0' and (Data_P3(62) xor Data_P3(60)) = '1') then
                if(CRC24_Out = CRC24_Value) then
                    CRC24_Error <= '0';
                else
                    CRC24_Error <= '1';
                end if;
            else
                CRC24_Error <= '0';
            end if;
        end if;
    end process CRC_Check;
    
    ------------------------------ Deframing -------------------------------------
    Burst_Deframing : process (clk, reset) is
    begin
        if reset = '1' then
            Data_Out      <= (others => '0');
            Data_Temp     <= (others => '0');
            SOP           <= '0';
            EOP           <= '0';
            EOP_Valid     <= (others => '0');
            FlowControl   <= (others => '0');
            Channel       <= (others => '0');
            data_word_reg <= (others => '0');
            
        elsif rising_edge(clk) then
            Data_Valid_Out <= '0';
            
            if(data_valid_in = '1' and data_control_in = '0') then
                data_word_reg    <= data_in;
                data_word_reg_p1 <= data_word_reg;
            end if;
            
            control_word_reg <= data_valid_in & data_control_in;
            
            if (Data_control_in = '1' and Data_valid_in = '1') then
                SOP <= Data_In(61);
                if(Data_in(60) = '1') then
                    EOP       <= '1';
                    EOP_Valid <= Data_In(59 downto 57);
                end if;
                FlowControl <= Data_In(55 downto 40);
                Channel     <= Data_In(39 downto 32);
            end if;
             
            if(EOP = '1') then
                if (control_word_reg(1) = '1' and control_word_reg(0) = '0') then
                    Data_Valid_Out <= '1';
                    packet_busy    <= '0';
                    EOP            <= '0';
                    EOP_Valid      <= (others => '0');
                end if;
                
            elsif(SOP = '1') then
                if (control_word_reg(1) = '1' and control_word_reg(0) = '0') then
                    Data_Valid_Out <= '1';
                    SOP            <= '0';
                end if;
                packet_busy <= '1';
            end if;
            
            data_out <= EOP_valid & (SOP and not EOP) & EOP & data_word_reg_p1;
                    
            if(packet_busy = '1') then
                if(control_word_reg(1) = '1' and control_word_reg(0) = '0') then
                    Data_Valid_Out <= '1';
                end if;
            end if;
            
        end if;
    end process Burst_Deframing;
    
    ---------------------------- State machine -----------------------------------
	state_register : process (clk) is
    begin
        if (rising_edge(clk)) then
            pres_state <= next_state;
        end if;
    end process state_register;
    
    state_decoder : process (pres_state, Packet_Counter, Data_Control_In, Data_In) is
    begin
        case pres_state is
        when IDLE =>
            if (Data_Control_In = '1' and Data_In(63 downto 60) = "1110") then --SOP set and EOP not set
                next_state <= CRC;
--            elsif (Data_Control_In = '1' and Data_In(63 downto 61) = "1111") then --SOP and EOP set
--                next_state <= CRC;
            else
                next_state <= IDLE;
            end if;
        when CRC =>
            --if(Data_Control_In = '1' and Data_In(61) = '0' and Data_In(60) = '0') then -- Middle of packet
            --    next_state <= CRC;
            if(Data_Control_In = '1' and Data_In(61) = '0' and Data_In(60) = '1') then -- End of packet
                next_state <= IDLE;
            elsif(Data_Control_In = '1' and Data_In(61) = '1') then -- Repeating start condition -> Error
                next_state <= IDLE;
            else
                next_state <= CRC;
            end if;                
        when others =>
            next_state <= IDLE;
        end case;
    end process state_decoder;

    output : process (pres_state, clk) is
    begin
        if rising_edge(clk) then
            case pres_state is
            when IDLE =>
                CRC24_In <= (others => '0');
                if (Data_Control_In = '1' and Data_In(63 downto 60) = "1110") then --SOP set and EOP not set
                    CRC24_In <= Data_In; 
                end if;
            when CRC =>
                CRC24_In <= Data_In;
                if(Data_Control_In = '1' and Data_In(63) = '1' and Data_In(61) = '0') then -- Either the middle or end of packet; Control word/Burst word/No SOP
                    if(Data_In(60) = '0') then
                    end if;
                    CRC24_Value_P1 <= Data_In(23 downto 0); -- Copy received CRC-24 value
                    CRC24_In(63 downto 24) <= Data_In(63 downto 24); --Change to CRC-length
                    CRC24_In(23 downto 0)  <= (others => '0');
                --elsif(Data_Control_In = '1' and Data_In(61) = '1') then -- Repeating start condition -> Error
                end if;
            end case;
        end if;
    end process output;
	
end architecture Deframing;
