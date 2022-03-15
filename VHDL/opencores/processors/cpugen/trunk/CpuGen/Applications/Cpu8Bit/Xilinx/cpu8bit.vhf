-- VHDL model created from cpu8bit.sch - Fri Jan 09 23:23:02 2004


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
-- synopsys translate_off
library UNISIM;
use UNISIM.Vcomponents.ALL;
-- synopsys translate_on

entity cpu8bit is
   port ( IN_INT   : in    std_logic_vector (3 downto 0); 
          IN0_REG  : in    std_logic_vector (7 downto 0); 
          IN1_REG  : in    std_logic_vector (7 downto 0); 
          NRESET   : in    std_logic; 
          RXD      : in    std_logic; 
          UCLK     : in    std_logic; 
          OUT0_REG : out   std_logic_vector (7 downto 0); 
          OUT1_REG : out   std_logic_vector (7 downto 0); 
          TXD      : out   std_logic);
end cpu8bit;

architecture BEHAVIORAL of cpu8bit is
   attribute BOX_TYPE   : STRING ;
   signal CPU_ADDR_OUT   : std_logic_vector (9 downto 0);
   signal CPU_DATA_IN    : std_logic_vector (7 downto 0);
   signal CPU_DATA_OUT   : std_logic_vector (7 downto 0);
   signal CPU_INT        : std_logic;
   signal IADDR          : std_logic_vector (9 downto 0);
   signal IDATA          : std_logic_vector (13 downto 0);
   signal INT_DATA_OUT   : std_logic_vector (7 downto 0);
   signal INT_INT        : std_logic_vector (7 downto 0);
   signal nCS_INT        : std_logic;
   signal nCS_REG        : std_logic;
   signal nCS_TIMER      : std_logic;
   signal nCS_UART       : std_logic;
   signal nRE_CPU        : std_logic;
   signal nWE_CPU        : std_logic;
   signal nWE_RAM        : std_logic;
   signal RAM_DATA_OUT   : std_logic_vector (7 downto 0);
   signal REG_DATA_OUT   : std_logic_vector (7 downto 0);
   signal TIMER_DATA_OUT : std_logic_vector (7 downto 0);
   signal UART_DATA_OUT  : std_logic_vector (7 downto 0);
   signal XLXN_3         : std_logic;
   component cpu
      port ( int_in     : in    std_logic; 
             nreset_in  : in    std_logic; 
             clk_in     : in    std_logic; 
             idata_in   : in    std_logic_vector (13 downto 0); 
             data_in    : in    std_logic_vector (7 downto 0); 
             ndre_out   : out   std_logic; 
             ndwe_out   : out   std_logic; 
             nadwe_out  : out   std_logic; 
             iaddr_out  : out   std_logic_vector (9 downto 0); 
             data_out   : out   std_logic_vector (7 downto 0); 
             daddr_out  : out   std_logic_vector (9 downto 0); 
             adaddr_out : out   std_logic_vector (9 downto 0));
   end component;
   
   component inout4reg
      port ( nWE          : in    std_logic; 
             nRE          : in    std_logic; 
             nCS_REG      : in    std_logic; 
             nreset       : in    std_logic; 
             clk          : in    std_logic; 
             reg_data_in  : in    std_logic_vector (7 downto 0); 
             reg_data_out : out   std_logic_vector (7 downto 0); 
             addr         : in    std_logic; 
             in_0reg      : in    std_logic_vector (7 downto 0); 
             in_1reg      : in    std_logic_vector (7 downto 0); 
             out_0reg     : out   std_logic_vector (7 downto 0); 
             out_1reg     : out   std_logic_vector (7 downto 0));
   end component;
   
   component interrupt
      port ( addr     : in    std_logic; 
             nwe      : in    std_logic; 
             ncs_int  : in    std_logic; 
             clk      : in    std_logic; 
             nreset   : in    std_logic; 
             int_in   : in    std_logic_vector (7 downto 0); 
             int_data : in    std_logic_vector (7 downto 0); 
             int_ext  : out   std_logic; 
             int_out  : out   std_logic_vector (7 downto 0));
   end component;
   
   component timer
      port ( addr      : in    std_logic; 
             nwe       : in    std_logic; 
             ncs_timer : in    std_logic; 
             clk       : in    std_logic; 
             nreset    : in    std_logic; 
             tmr_in    : in    std_logic_vector (7 downto 0); 
             tmr_int   : out   std_logic; 
             tmr_out   : out   std_logic_vector (7 downto 0));
   end component;
   
   component tx_uart
      port ( addr          : in    std_logic; 
             nwe           : in    std_logic; 
             ncs_uart      : in    std_logic; 
             clk           : in    std_logic; 
             nreset        : in    std_logic; 
             tx_uart_data  : in    std_logic_vector (7 downto 0); 
             tx_uart       : out   std_logic; 
             tx_uart_empty : out   std_logic);
   end component;
   
   component ram
      port ( ADDR : in    std_logic_vector (7 downto 0); 
             DIN  : in    std_logic_vector (7 downto 0); 
             WE   : in    std_logic; 
             CLK  : in    std_logic; 
             DOUT : out   std_logic_vector (7 downto 0));
   end component;
   
   component rom
      port ( ADDR : in    std_logic_vector (9 downto 0); 
             CLK  : in    std_logic; 
             DOUT : out   std_logic_vector (13 downto 0));
   end component;
   
   component BUF
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of BUF : COMPONENT is "BLACK_BOX";
   
   component rx_uart
      port ( rx_uart      : in    std_logic; 
             addr         : in    std_logic; 
             nwe          : in    std_logic; 
             nre          : in    std_logic; 
             ncs_uart     : in    std_logic; 
             clk          : in    std_logic; 
             nreset       : in    std_logic; 
             rx_uart_in   : in    std_logic_vector (7 downto 0); 
             rx_uart_full : out   std_logic; 
             rx_uart_ovr  : out   std_logic; 
             rx_uart_out  : out   std_logic_vector (7 downto 0));
   end component;
   
   component ctrl8cpu
      port ( nwe_cpu        : in    std_logic; 
             nre_cpu        : in    std_logic; 
             clk            : in    std_logic; 
             nreset         : in    std_logic; 
             cpu_addr_out   : in    std_logic_vector (9 downto 0); 
             cpu_data_out   : in    std_logic_vector (7 downto 0); 
             ram_data_out   : in    std_logic_vector (7 downto 0); 
             int_data_out   : in    std_logic_vector (7 downto 0); 
             reg_data_out   : in    std_logic_vector (7 downto 0); 
             timer_data_out : in    std_logic_vector (7 downto 0); 
             uart_data_out  : in    std_logic_vector (7 downto 0); 
             nwe_ram        : out   std_logic; 
             ncs_int        : out   std_logic; 
             ncs_uart       : out   std_logic; 
             ncs_timer      : out   std_logic; 
             ncs_reg        : out   std_logic; 
             cpu_data_in    : out   std_logic_vector (7 downto 0));
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : COMPONENT is "BLACK_BOX";
   
begin
   XLXI_1 : cpu
      port map (clk_in=>UCLK, data_in(7 downto 0)=>CPU_DATA_IN(7 downto 0),
            idata_in(13 downto 0)=>IDATA(13 downto 0), int_in=>CPU_INT,
            nreset_in=>NRESET, adaddr_out(9 downto 0)=>open, daddr_out(9 downto
            0)=>CPU_ADDR_OUT(9 downto 0), data_out(7 downto 0)=>CPU_DATA_OUT(7
            downto 0), iaddr_out(9 downto 0)=>IADDR(9 downto 0),
            nadwe_out=>open, ndre_out=>nRE_CPU, ndwe_out=>nWE_CPU);
   
   XLXI_3 : inout4reg
      port map (addr=>CPU_ADDR_OUT(0), clk=>UCLK, in_0reg(7 downto
            0)=>IN0_REG(7 downto 0), in_1reg(7 downto 0)=>IN1_REG(7 downto 0),
            nCS_REG=>nCS_REG, nRE=>nRE_CPU, nreset=>NRESET, nWE=>nWE_CPU,
            reg_data_in(7 downto 0)=>CPU_DATA_OUT(7 downto 0), out_0reg(7
            downto 0)=>OUT0_REG(7 downto 0), out_1reg(7 downto 0)=>OUT1_REG(7
            downto 0), reg_data_out(7 downto 0)=>REG_DATA_OUT(7 downto 0));
   
   XLXI_4 : interrupt
      port map (addr=>CPU_ADDR_OUT(0), clk=>UCLK, int_data(7 downto
            0)=>CPU_DATA_OUT(7 downto 0), int_in(7 downto 0)=>INT_INT(7 downto
            0), ncs_int=>nCS_INT, nreset=>NRESET, nwe=>nWE_CPU,
            int_ext=>CPU_INT, int_out(7 downto 0)=>INT_DATA_OUT(7 downto 0));
   
   XLXI_5 : timer
      port map (addr=>CPU_ADDR_OUT(0), clk=>UCLK, ncs_timer=>nCS_TIMER,
            nreset=>NRESET, nwe=>nWE_CPU, tmr_in(7 downto 0)=>CPU_DATA_OUT(7
            downto 0), tmr_int=>INT_INT(7), tmr_out(7 downto
            0)=>TIMER_DATA_OUT(7 downto 0));
   
   XLXI_6 : tx_uart
      port map (addr=>CPU_ADDR_OUT(0), clk=>UCLK, ncs_uart=>nCS_UART,
            nreset=>NRESET, nwe=>nWE_CPU, tx_uart_data(7 downto
            0)=>CPU_DATA_OUT(7 downto 0), tx_uart=>TXD,
            tx_uart_empty=>INT_INT(6));
   
   XLXI_7 : ram
      port map (ADDR(7 downto 0)=>CPU_ADDR_OUT(7 downto 0), CLK=>UCLK, DIN(7
            downto 0)=>CPU_DATA_OUT(7 downto 0), WE=>XLXN_3, DOUT(7 downto
            0)=>RAM_DATA_OUT(7 downto 0));
   
   XLXI_8 : rom
      port map (ADDR(9 downto 0)=>IADDR(9 downto 0), CLK=>UCLK, DOUT(13 downto
            0)=>IDATA(13 downto 0));
   
   XLXI_10 : BUF
      port map (I=>IN_INT(0), O=>INT_INT(0));
   
   XLXI_11 : BUF
      port map (I=>IN_INT(2), O=>INT_INT(2));
   
   XLXI_12 : BUF
      port map (I=>IN_INT(1), O=>INT_INT(1));
   
   XLXI_13 : BUF
      port map (I=>IN_INT(3), O=>INT_INT(3));
   
   XLXI_26 : rx_uart
      port map (addr=>CPU_ADDR_OUT(0), clk=>UCLK, ncs_uart=>nCS_UART,
            nre=>nRE_CPU, nreset=>NRESET, nwe=>nWE_CPU, rx_uart=>RXD,
            rx_uart_in(7 downto 0)=>CPU_DATA_OUT(7 downto 0),
            rx_uart_full=>INT_INT(5), rx_uart_out(7 downto 0)=>UART_DATA_OUT(7
            downto 0), rx_uart_ovr=>INT_INT(4));
   
   XLXI_55 : ctrl8cpu
      port map (clk=>UCLK, cpu_addr_out(9 downto 0)=>CPU_ADDR_OUT(9 downto 0),
            cpu_data_out(7 downto 0)=>CPU_DATA_OUT(7 downto 0), int_data_out(7
            downto 0)=>INT_DATA_OUT(7 downto 0), nreset=>NRESET,
            nre_cpu=>nRE_CPU, nwe_cpu=>nWE_CPU, ram_data_out(7 downto
            0)=>RAM_DATA_OUT(7 downto 0), reg_data_out(7 downto
            0)=>REG_DATA_OUT(7 downto 0), timer_data_out(7 downto
            0)=>TIMER_DATA_OUT(7 downto 0), uart_data_out(7 downto
            0)=>UART_DATA_OUT(7 downto 0), cpu_data_in(7 downto
            0)=>CPU_DATA_IN(7 downto 0), ncs_int=>nCS_INT, ncs_reg=>nCS_REG,
            ncs_timer=>nCS_TIMER, ncs_uart=>nCS_UART, nwe_ram=>nWE_RAM);
   
   XLXI_56 : INV
      port map (I=>nWE_RAM, O=>XLXN_3);
   
end BEHAVIORAL;


