-- VHDL model created from cpu4bit.sch - Sun Feb 08 20:39:34 2004


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
-- synopsys translate_off
library UNISIM;
use UNISIM.Vcomponents.ALL;
-- synopsys translate_on

entity cpu4bit is
   port ( CLK           : in    std_logic; 
          CTRL_DATA_IN  : in    std_logic_vector (3 downto 0); 
          NRESET        : in    std_logic; 
          CPU_DADDR     : out   std_logic_vector (5 downto 0); 
          CPU_DATA_OUT  : out   std_logic_vector (3 downto 0); 
          CPU_IADDR     : out   std_logic_vector (7 downto 0); 
          CTRL_DATA_OUT : out   std_logic_vector (3 downto 0); 
          nRE_CPU       : out   std_logic; 
          nWE_CPU       : out   std_logic; 
          PWM_OUT       : out   std_logic);
end cpu4bit;

architecture BEHAVIORAL of cpu4bit is
   attribute BOX_TYPE   : STRING ;
   signal CPU_DATA_IN         : std_logic_vector (3 downto 0);
   signal nCS_PWM             : std_logic;
   signal nWR_RAM             : std_logic;
   signal RAM_DATA_OUT        : std_logic_vector (3 downto 0);
   signal XLXN_8              : std_logic_vector (9 downto 0);
   signal XLXN_86             : std_logic_vector (7 downto 0);
   signal XLXN_87             : std_logic;
   signal nWE_CPU_DUMMY       : std_logic;
   signal CPU_IADDR_DUMMY     : std_logic_vector (7 downto 0);
   signal CPU_DATA_OUT_DUMMY  : std_logic_vector (3 downto 0);
   signal CTRL_DATA_OUT_DUMMY : std_logic_vector (3 downto 0);
   signal CPU_DADDR_DUMMY     : std_logic_vector (5 downto 0);
   signal nRE_CPU_DUMMY       : std_logic;
   component ctrl4cpu
      port ( nwe_cpu       : in    std_logic; 
             nre_cpu       : in    std_logic; 
             clk           : in    std_logic; 
             nreset        : in    std_logic; 
             cpu_addr_out  : in    std_logic_vector (4 downto 0); 
             cpu_data_out  : in    std_logic_vector (3 downto 0); 
             ram_data_out  : in    std_logic_vector (3 downto 0); 
             ctrl_data_in  : in    std_logic_vector (3 downto 0); 
             nwr_ram       : out   std_logic; 
             ncs_pwm       : out   std_logic; 
             cpu_data_in   : out   std_logic_vector (3 downto 0); 
             ctrl_data_out : out   std_logic_vector (3 downto 0); 
             pwm_data_out  : out   std_logic_vector (7 downto 0));
   end component;
   
   component pwm
      port ( addr       : in    std_logic; 
             nwr        : in    std_logic; 
             ncs_pwm    : in    std_logic; 
             pwm_enable : in    std_logic; 
             clk        : in    std_logic; 
             nreset     : in    std_logic; 
             pwm_data   : in    std_logic_vector (7 downto 0); 
             pwm_out    : out   std_logic);
   end component;
   
   component ram
      port ( ADDR : in    std_logic_vector (3 downto 0); 
             DIN  : in    std_logic_vector (3 downto 0); 
             WE   : in    std_logic; 
             CLK  : in    std_logic; 
             DOUT : out   std_logic_vector (3 downto 0));
   end component;
   
   component rom
      port ( addr : in    std_logic_vector (7 downto 0); 
             clk  : in    std_logic; 
             dout : out   std_logic_vector (9 downto 0));
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : COMPONENT is "BLACK_BOX";
   
   component cpu
      port ( nreset_in  : in    std_logic; 
             clk_in     : in    std_logic; 
             idata_in   : in    std_logic_vector (9 downto 0); 
             data_in    : in    std_logic_vector (3 downto 0); 
             ndre_out   : out   std_logic; 
             ndwe_out   : out   std_logic; 
             nadwe_out  : out   std_logic; 
             iaddr_out  : out   std_logic_vector (7 downto 0); 
             data_out   : out   std_logic_vector (3 downto 0); 
             daddr_out  : out   std_logic_vector (5 downto 0); 
             adaddr_out : out   std_logic_vector (5 downto 0));
   end component;
   
begin
   CPU_DADDR(5 downto 0) <= CPU_DADDR_DUMMY(5 downto 0);
   CPU_DATA_OUT(3 downto 0) <= CPU_DATA_OUT_DUMMY(3 downto 0);
   CPU_IADDR(7 downto 0) <= CPU_IADDR_DUMMY(7 downto 0);
   CTRL_DATA_OUT(3 downto 0) <= CTRL_DATA_OUT_DUMMY(3 downto 0);
   nRE_CPU <= nRE_CPU_DUMMY;
   nWE_CPU <= nWE_CPU_DUMMY;
   XLXI_2 : ctrl4cpu
      port map (clk=>CLK, cpu_addr_out(4 downto 0)=>CPU_DADDR_Dummy(4 downto
            0), cpu_data_out(3 downto 0)=>CPU_DATA_OUT_DUMMY(3 downto 0),
            ctrl_data_in(3 downto 0)=>CTRL_DATA_IN(3 downto 0), nreset=>NRESET,
            nre_cpu=>nRE_CPU_DUMMY, nwe_cpu=>nWE_CPU_DUMMY, ram_data_out(3
            downto 0)=>RAM_DATA_OUT(3 downto 0), cpu_data_in(3 downto
            0)=>CPU_DATA_IN(3 downto 0), ctrl_data_out(3 downto
            0)=>CTRL_DATA_OUT_DUMMY(3 downto 0), ncs_pwm=>nCS_PWM,
            nwr_ram=>nWR_RAM, pwm_data_out(7 downto 0)=>XLXN_86(7 downto 0));
   
   XLXI_3 : pwm
      port map (addr=>CPU_DADDR_DUMMY(2), clk=>CLK, ncs_pwm=>nCS_PWM,
            nreset=>NRESET, nwr=>nWE_CPU_DUMMY, pwm_data(7 downto 0)=>XLXN_86(7
            downto 0), pwm_enable=>CTRL_DATA_OUT_DUMMY(0), pwm_out=>PWM_OUT);
   
   XLXI_4 : ram
      port map (ADDR(3 downto 0)=>CPU_DADDR_Dummy(3 downto 0), CLK=>CLK, DIN(3
            downto 0)=>CPU_DATA_OUT_DUMMY(3 downto 0), WE=>XLXN_87, DOUT(3
            downto 0)=>RAM_DATA_OUT(3 downto 0));
   
   XLXI_5 : rom
      port map (addr(7 downto 0)=>CPU_IADDR_DUMMY(7 downto 0), clk=>CLK, dout(9
            downto 0)=>XLXN_8(9 downto 0));
   
   XLXI_7 : INV
      port map (I=>nWR_RAM, O=>XLXN_87);
   
   XLXI_10 : cpu
      port map (clk_in=>CLK, data_in(3 downto 0)=>CPU_DATA_IN(3 downto 0),
            idata_in(9 downto 0)=>XLXN_8(9 downto 0), nreset_in=>NRESET,
            adaddr_out(5 downto 0)=>open, daddr_out(5 downto
            0)=>CPU_DADDR_DUMMY(5 downto 0), data_out(3 downto
            0)=>CPU_DATA_OUT_DUMMY(3 downto 0), iaddr_out(7 downto
            0)=>CPU_IADDR_DUMMY(7 downto 0), nadwe_out=>open,
            ndre_out=>nRE_CPU_DUMMY, ndwe_out=>nWE_CPU_DUMMY);
   
end BEHAVIORAL;


