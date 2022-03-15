-- VHDL model created from cpu16bit.sch - Sun Feb 29 11:13:59 2004


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
-- synopsys translate_off
library UNISIM;
use UNISIM.Vcomponents.ALL;
-- synopsys translate_on

entity cpu16bit is
   port ( CLK_IN       : in    std_logic; 
          CPU_INT      : in    std_logic; 
          DATA_IN_EXT  : in    std_logic_vector (15 downto 0); 
          NRESET_IN    : in    std_logic; 
          ADDR_OUT_EXT : out   std_logic_vector (9 downto 0); 
          DATA_OUT_EXT : out   std_logic_vector (15 downto 0); 
          NCS_EXT      : out   std_logic; 
          NRE_EXT      : out   std_logic; 
          NWE_EXT      : out   std_logic);
end cpu16bit;

architecture BEHAVIORAL of cpu16bit is
   attribute BOX_TYPE   : STRING ;
   signal CPU_ADADDR_OUT     : std_logic_vector (11 downto 0);
   signal CPU_DATA_IN        : std_logic_vector (15 downto 0);
   signal CPU_DATA_IN_M      : std_logic_vector (15 downto 0);
   signal CPU_IADDR_OUT      : std_logic_vector (11 downto 0);
   signal CPU_NADWE          : std_logic;
   signal CPU_NDRE           : std_logic;
   signal DWAIT_IN           : std_logic;
   signal IWAIT_IN           : std_logic;
   signal MADDR              : std_logic_vector (9 downto 0);
   signal MEM_DATA_OUT       : std_logic_vector (15 downto 0);
   signal NACS_EXT           : std_logic;
   signal NWE_RAM            : std_logic;
   signal XLXN_1             : std_logic;
   signal XLXN_2             : std_logic;
   signal XLXN_14            : std_logic_vector (11 downto 0);
   signal XLXN_19            : std_logic_vector (7 downto 0);
   signal XLXN_20            : std_logic_vector (11 downto 0);
   signal XLXN_27            : std_logic;
   signal DATA_OUT_EXT_DUMMY : std_logic_vector (15 downto 0);
   component cpu
      port ( int_in     : in    std_logic; 
             dwait_in   : in    std_logic; 
             iwait_in   : in    std_logic; 
             nreset_in  : in    std_logic; 
             clk_in     : in    std_logic; 
             saddr_in   : in    std_logic_vector (11 downto 0); 
             idata_in   : in    std_logic_vector (15 downto 0); 
             data_in    : in    std_logic_vector (15 downto 0); 
             ipush_out  : out   std_logic; 
             ipop_out   : out   std_logic; 
             ndre_out   : out   std_logic; 
             ndwe_out   : out   std_logic; 
             nadwe_out  : out   std_logic; 
             saddr_out  : out   std_logic_vector (11 downto 0); 
             iaddr_out  : out   std_logic_vector (11 downto 0); 
             data_out   : out   std_logic_vector (15 downto 0); 
             daddr_out  : out   std_logic_vector (11 downto 0); 
             adaddr_out : out   std_logic_vector (11 downto 0));
   end component;
   
   component ctrl16cpu
      port ( nADWE_CPU   : in    std_logic; 
             nreset_in   : in    std_logic; 
             clk_in      : in    std_logic; 
             DATA_IN_RAM : in    std_logic_vector (15 downto 0); 
             DATA_IN_EXT : in    std_logic_vector (15 downto 0); 
             ADADDR_IN   : in    std_logic_vector (9 downto 0); 
             nWE_RAM     : out   std_logic; 
             nCS_EXT     : out   std_logic; 
             nACS_EXT    : out   std_logic; 
             DATA_OUT    : out   std_logic_vector (15 downto 0));
   end component;
   
   component h2v
      port ( ndre_in   : in    std_logic; 
             nadwe_in  : in    std_logic; 
             dwait_in  : in    std_logic; 
             nreset_in : in    std_logic; 
             clk_in    : in    std_logic; 
             iaddr     : in    std_logic_vector (9 downto 0); 
             daddr     : in    std_logic_vector (9 downto 0); 
             iwait_out : out   std_logic; 
             maddr     : out   std_logic_vector (9 downto 0));
   end component;
   
   component stack_if
      port ( push_in   : in    std_logic; 
             pop_in    : in    std_logic; 
             nreset_in : in    std_logic; 
             clk_in    : in    std_logic; 
             addr_out  : out   std_logic_vector (7 downto 0));
   end component;
   
   component waitstategen
      port ( nacs_wait        : in    std_logic; 
             ndre_in          : in    std_logic; 
             nadwe_in         : in    std_logic; 
             nreset_in        : in    std_logic; 
             clk_in           : in    std_logic; 
             cpu_data_in      : in    std_logic_vector (15 downto 0); 
             cpu_adaddr_out_m : in    std_logic_vector (9 downto 0); 
             dwait_out        : out   std_logic; 
             ndre_out         : out   std_logic; 
             ndwe_out         : out   std_logic; 
             cpu_data_in_m    : out   std_logic_vector (15 downto 0); 
             cpu_daddr_out    : out   std_logic_vector (9 downto 0));
   end component;
   
   component ram
      port ( addr : in    std_logic_vector (9 downto 0); 
             din  : in    std_logic_vector (15 downto 0); 
             we   : in    std_logic; 
             clk  : in    std_logic; 
             dout : out   std_logic_vector (15 downto 0));
   end component;
   
   component sram
      port ( addr : in    std_logic_vector (7 downto 0); 
             din  : in    std_logic_vector (11 downto 0); 
             we   : in    std_logic; 
             clk  : in    std_logic; 
             dout : out   std_logic_vector (11 downto 0));
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : COMPONENT is "BLACK_BOX";
   
begin
   DATA_OUT_EXT(15 downto 0) <= DATA_OUT_EXT_DUMMY(15 downto 0);
   Cpu16 : cpu
      port map (clk_in=>CLK_IN, data_in(15 downto 0)=>CPU_DATA_IN_M(15 downto
            0), dwait_in=>DWAIT_IN, idata_in(15 downto 0)=>MEM_DATA_OUT(15
            downto 0), int_in=>CPU_INT, iwait_in=>IWAIT_IN,
            nreset_in=>NRESET_IN, saddr_in(11 downto 0)=>XLXN_20(11 downto 0),
            adaddr_out(11 downto 0)=>CPU_ADADDR_OUT(11 downto 0), daddr_out(11
            downto 0)=>open, data_out(15 downto 0)=>DATA_OUT_EXT_DUMMY(15
            downto 0), iaddr_out(11 downto 0)=>CPU_IADDR_OUT(11 downto 0),
            ipop_out=>XLXN_2, ipush_out=>XLXN_1, nadwe_out=>CPU_NADWE,
            ndre_out=>CPU_NDRE, ndwe_out=>open, saddr_out(11 downto
            0)=>XLXN_14(11 downto 0));
   
   XLXI_2 : ctrl16cpu
      port map (ADADDR_IN(9 downto 0)=>CPU_ADADDR_OUT(9 downto 0),
            clk_in=>CLK_IN, DATA_IN_EXT(15 downto 0)=>DATA_IN_EXT(15 downto 0),
            DATA_IN_RAM(15 downto 0)=>MEM_DATA_OUT(15 downto 0),
            nADWE_CPU=>CPU_NADWE, nreset_in=>NRESET_IN, DATA_OUT(15 downto
            0)=>CPU_DATA_IN(15 downto 0), nACS_EXT=>NACS_EXT, nCS_EXT=>NCS_EXT,
            nWE_RAM=>NWE_RAM);
   
   XLXI_3 : h2v
      port map (clk_in=>CLK_IN, daddr(9 downto 0)=>CPU_ADADDR_OUT(9 downto 0),
            dwait_in=>DWAIT_IN, iaddr(9 downto 0)=>CPU_IADDR_OUT(9 downto 0),
            nadwe_in=>CPU_NADWE, ndre_in=>CPU_NDRE, nreset_in=>NRESET_IN,
            iwait_out=>IWAIT_IN, maddr(9 downto 0)=>MADDR(9 downto 0));
   
   XLXI_4 : stack_if
      port map (clk_in=>CLK_IN, nreset_in=>NRESET_IN, pop_in=>XLXN_2,
            push_in=>XLXN_1, addr_out(7 downto 0)=>XLXN_19(7 downto 0));
   
   XLXI_5 : waitstategen
      port map (clk_in=>CLK_IN, cpu_adaddr_out_m(9 downto 0)=>CPU_ADADDR_OUT(9
            downto 0), cpu_data_in(15 downto 0)=>CPU_DATA_IN(15 downto 0),
            nacs_wait=>NACS_EXT, nadwe_in=>CPU_NADWE, ndre_in=>CPU_NDRE,
            nreset_in=>NRESET_IN, cpu_daddr_out(9 downto 0)=>ADDR_OUT_EXT(9
            downto 0), cpu_data_in_m(15 downto 0)=>CPU_DATA_IN_M(15 downto 0),
            dwait_out=>DWAIT_IN, ndre_out=>NRE_EXT, ndwe_out=>NWE_EXT);
   
   XLXI_6 : ram
      port map (addr(9 downto 0)=>MADDR(9 downto 0), clk=>CLK_IN, din(15 downto
            0)=>DATA_OUT_EXT_DUMMY(15 downto 0), we=>XLXN_27, dout(15 downto
            0)=>MEM_DATA_OUT(15 downto 0));
   
   XLXI_7 : sram
      port map (addr(7 downto 0)=>XLXN_19(7 downto 0), clk=>CLK_IN, din(11
            downto 0)=>XLXN_14(11 downto 0), we=>XLXN_1, dout(11 downto
            0)=>XLXN_20(11 downto 0));
   
   XLXI_9 : INV
      port map (I=>NWE_RAM, O=>XLXN_27);
   
end BEHAVIORAL;


