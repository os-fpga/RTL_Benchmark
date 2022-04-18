library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.support_pkg.all;
use work.layers_pkg.all;
package wb_init is
  type ramd_type is array (3 downto 0) of std_logic_vector(NbitW-1 downto 0);
  type layer_ram is array (3 downto 0) of ramd_type;
  type w_ram  is array (integer range <>) of layer_ram;
  type b_type is array (integer range <>) of ramd_type;
  constant w_init : w_ram :=
  (
    0 => (
      0 => (
        0 => real2stdlv(NbitW,-0.8964),
        1 => real2stdlv(NbitW,-2.6600),
        others =>(others => '0')
      ),
      others=>(others =>(others => '0'))
    ),
    1 => (
      0 => (
        0 => real2stdlv(NbitW,-5.6056),
        1 => real2stdlv(NbitW,-1.5274),
        2 => real2stdlv(NbitW,-8.4909),
        others =>(others => '0')
      ),
      1 => (
        0 => real2stdlv(NbitW,1.0885),
        1 => real2stdlv(NbitW,0.7244),
        2 => real2stdlv(NbitW,3.8977),
        others =>(others => '0')
      ),
      others=>(others =>(others => '0'))
    ),
    2 => (
      0 => (
        0 => real2stdlv(NbitW,6.0449),
        others =>(others => '0')
      ),
      1 => (
        0 => real2stdlv(NbitW,-2.8724),
        others =>(others => '0')
      ),
      2 => (
        0 => real2stdlv(NbitW,-5.0188),
        others =>(others => '0')
      ),
      others=>(others =>(others => '0'))
    )
  );

  constant b_init : b_type :=
  (
    0 => (
      0 => real2stdlv(NbitW,(2.0**LSB_OUT)*(0.3704)),
      1 => real2stdlv(NbitW,(2.0**LSB_OUT)*(0.7149)),
      others =>(others => '0')
    ),
    1 => (
      0 => real2stdlv(NbitW,(2.0**LSB_OUT)*(2.8121)),
      1 => real2stdlv(NbitW,(2.0**LSB_OUT)*(0.3690)),
      2 => real2stdlv(NbitW,(2.0**LSB_OUT)*(2.4685)),
      others =>(others => '0')
    ),
    2 => (
      0 => real2stdlv(NbitW,(2.0**LSB_OUT)*(0.0784)),
      others =>(others => '0')
    )
  );
end wb_init;
