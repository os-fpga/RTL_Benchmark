library ieee;
use ieee.std_logic_1164.all;

entity testbench_Interface_Test is
end entity testbench_Interface_Test;

architecture tb_interlaken_interface of testbench_Interface_Test is
    
    constant   TX_REFCLK_PERIOD        :   time :=  8.0 ns;
    constant   RX_REFCLK_PERIOD        :   time :=  8.0 ns;
    constant   SYSCLK_PERIOD           :   time :=  25.0 ns;    
    constant   DCLK_PERIOD             :   time :=  5.0 ns;

    signal System_Clock_In_P : std_logic;
    signal System_Clock_In_N : std_logic;
    
    signal GTREFCLK_IN_P : std_logic;
    signal GTREFCLK_IN_N : std_logic;
    
    signal USER_CLK_IN_P : std_logic;
    signal USER_CLK_IN_N : std_logic;

    signal USER_SMA_CLK_OUT_P : std_logic;
    signal USER_SMA_CLK_OUT_N : std_logic;
    
    signal TX_Out_P     : std_logic;
    signal TX_Out_N     : std_logic;
    signal RX_In_P      : std_logic;
    signal RX_In_N      : std_logic;
    
    signal Lock_Out     : std_logic;
    signal valid_out    : std_logic;
    
begin
    RX_In_N <=  TX_Out_N;
    RX_In_P <=  TX_Out_P;  
    
    uut : entity work.Interface_Test
    port map (
    
        System_Clock_In_P => System_Clock_In_P,
        System_Clock_In_N => System_Clock_In_N,
        
        GTREFCLK_IN_P => GTREFCLK_IN_P,
        GTREFCLK_IN_N => GTREFCLK_IN_N,
        
        USER_CLK_IN_P => USER_CLK_IN_P,
        USER_CLK_IN_N => USER_CLK_IN_N,
        
        USER_SMA_CLK_OUT_P => USER_SMA_CLK_OUT_P,
        USER_SMA_CLK_OUT_N => USER_SMA_CLK_OUT_N,
        
        RX_In_N => RX_In_N,
        RX_In_P => RX_In_P,  
        TX_Out_N => TX_Out_N,
        TX_Out_P => TX_Out_P,
        
        Lock_Out  => Lock_Out,
        valid_out => valid_out
    );
    
    process
    begin
        GTREFCLK_IN_N  <=  '1';
        wait for TX_REFCLK_PERIOD/2;
        GTREFCLK_IN_N  <=  '0';
        wait for TX_REFCLK_PERIOD/2;
    end process;

    GTREFCLK_IN_P <= not GTREFCLK_IN_N;

    process
    begin
        System_Clock_In_N  <=  '1';
        wait for DCLK_PERIOD/2;
        System_Clock_In_N  <=  '0';
        wait for DCLK_PERIOD/2;
    end process;
    
    System_Clock_In_P <= not System_Clock_In_N;     

end architecture tb_interlaken_interface;
