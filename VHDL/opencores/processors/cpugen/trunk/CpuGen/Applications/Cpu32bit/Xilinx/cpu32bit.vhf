-- VHDL model created from cpu32bit.sch - Fri Feb 27 22:12:28 2004


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
-- synopsys translate_off
library UNISIM;
use UNISIM.Vcomponents.ALL;
-- synopsys translate_on

entity cpu32bit is
   port ( CLK_IN    : in    std_logic; 
          INT_IN    : in    std_logic; 
          NRESET_IN : in    std_logic; 
          DADDR_OUT : out   std_logic_vector (26 downto 0); 
          DATA_OUT  : out   std_logic_vector (31 downto 0); 
          NDRE_OUT  : out   std_logic; 
          NDWE_OUT  : out   std_logic);
end cpu32bit;

architecture BEHAVIORAL of cpu32bit is
   attribute BOX_TYPE   : STRING ;
   signal ADADDR_OUT      : std_logic_vector (26 downto 0);
   signal DATA_IN         : std_logic_vector (31 downto 0);
   signal IADDR_OUT       : std_logic_vector (26 downto 0);
   signal IDATA_IN        : std_logic_vector (31 downto 0);
   signal NADWE_OUT       : std_logic;
   signal XLXN_2          : std_logic;
   signal XLXN_19         : std_logic;
   signal DADDR_OUT_DUMMY : std_logic_vector (26 downto 0);
   signal DATA_OUT_DUMMY  : std_logic_vector (31 downto 0);
   signal NDWE_OUT_DUMMY  : std_logic;
   component cpuc
      port ( int_in     : in    std_logic; 
             dwait_in   : in    std_logic; 
             nreset_in  : in    std_logic; 
             clk_in     : in    std_logic; 
             idata_in   : in    std_logic_vector (31 downto 0); 
             data_in    : in    std_logic_vector (31 downto 0); 
             ndre_out   : out   std_logic; 
             ndwe_out   : out   std_logic; 
             nadwe_out  : out   std_logic; 
             iaddr_out  : out   std_logic_vector (26 downto 0); 
             data_out   : out   std_logic_vector (31 downto 0); 
             daddr_out  : out   std_logic_vector (26 downto 0); 
             adaddr_out : out   std_logic_vector (26 downto 0));
   end component;
   
   component ram
      port ( addr : in    std_logic_vector (9 downto 0); 
             din  : in    std_logic_vector (31 downto 0); 
             we   : in    std_logic; 
             clk  : in    std_logic; 
             dout : out   std_logic_vector (31 downto 0));
   end component;
   
   component rom
      port ( addr : in    std_logic_vector (9 downto 0); 
             clk  : in    std_logic; 
             dout : out   std_logic_vector (31 downto 0));
   end component;
   
   component GND
      port ( G : out   std_logic);
   end component;
   attribute BOX_TYPE of GND : COMPONENT is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : COMPONENT is "BLACK_BOX";
   
begin
   DADDR_OUT(26 downto 0) <= DADDR_OUT_DUMMY(26 downto 0);
   DATA_OUT(31 downto 0) <= DATA_OUT_DUMMY(31 downto 0);
   NDWE_OUT <= NDWE_OUT_DUMMY;
   XLXI_1 : cpuc
      port map (clk_in=>CLK_IN, data_in(31 downto 0)=>DATA_IN(31 downto 0),
            dwait_in=>XLXN_2, idata_in(31 downto 0)=>IDATA_IN(31 downto 0),
            int_in=>INT_IN, nreset_in=>NRESET_IN, adaddr_out(26 downto
            0)=>ADADDR_OUT(26 downto 0), daddr_out(26 downto
            0)=>DADDR_OUT_DUMMY(26 downto 0), data_out(31 downto
            0)=>DATA_OUT_DUMMY(31 downto 0), iaddr_out(26 downto
            0)=>IADDR_OUT(26 downto 0), nadwe_out=>NADWE_OUT,
            ndre_out=>NDRE_OUT, ndwe_out=>NDWE_OUT_DUMMY);
   
   XLXI_2 : ram
      port map (addr(9 downto 0)=>DADDR_OUT_Dummy(9 downto 0), clk=>CLK_IN,
            din(31 downto 0)=>DATA_OUT_DUMMY(31 downto 0), we=>XLXN_19, dout(31
            downto 0)=>DATA_IN(31 downto 0));
   
   XLXI_3 : rom
      port map (addr(9 downto 0)=>IADDR_OUT(9 downto 0), clk=>CLK_IN, dout(31
            downto 0)=>IDATA_IN(31 downto 0));
   
   XLXI_4 : GND
      port map (G=>XLXN_2);
   
   XLXI_5 : INV
      port map (I=>NDWE_OUT_DUMMY, O=>XLXN_19);
   
end BEHAVIORAL;


