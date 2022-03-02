library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.layers_pkg.all;
package support_pkg is

  constant NbitIn   : natural := 12;    
  constant LSB_In   : natural := 8;
  constant Nbit     : natural := 12;
  constant NbitW    : natural := 24;
  constant LSB_OUT  : natural := 8;
  constant Nlayer   : natural := 3;

  constant NbitOut : integer := 12 ;
  constant NumIn   : integer := 1;  
  constant NumN    : int_vector(Nlayer-1 downto 0) := assign_ints("2 3 1",Nlayer);
  constant LSbit   : int_vector(Nlayer-1 downto 0) := assign_ints("8 8 8",Nlayer);
  constant NbitO   : int_vector(Nlayer-1 downto 0) := assign_ints("12 12 12",Nlayer);
  constant l_type  : string  := "SP PS SP";                  -- Layer type of each layer
  constant f_type  : string  := "sigmat sigmat sigmat";  -- Activation function type of each layer

  function real2stdlv (bitW : natural; din : real) return std_logic_vector;

end support_pkg;

package body support_pkg is

function real2stdlv (bitW : natural; din : real) return std_logic_vector is
    variable vres : signed(bitW-1 downto 0) := (others => '0');
  begin  -- real2stdlv
    vres:= to_signed(integer(din*(2.0**(LSB_OUT))), bitW);
    return std_logic_vector(vres);
  end real2stdlv;

end support_pkg;