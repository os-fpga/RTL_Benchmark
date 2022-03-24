--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- miniMIPS Superscalar Processor : delay gate stage                    --
-- based on miniMIPS Processor                                          --
--                                                                      --
--                                                                      --
-- Author : Miguel Cafruni                                              --
-- miguel_cafruni@hotmail.com                                           --
--                                                      December 2018   --
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.pack_mips.all;

entity delay_gate is
port (
    clock : in bus1;
    in1   : in bus1;
    in2   : in bus1;
    in3   : in bus1;
    in4   : in bus1;
    in5   : in bus1;
    in6   : in bus1;
    in7   : in bus1;
    in8   : in bus1;
    in9   : in bus1;
    in10  : in bus1;
    in11  : in bus1;
    in12  : in bus1;
    out1  : out bus1;
    out2  : out bus1;    
    out3  : out bus1;
    out4  : out bus1;
    out5  : out bus1;
    out6  : out bus1;    
    out7  : out bus1;
    out8  : out bus1;
    out9  : out bus1;
    out10 : out bus1;
    out11 : out bus1;
    out12 : out bus1
);
end delay_gate;

architecture rtl of delay_gate is

signal s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12 : bus1;

begin
	s1  <= in1;
	s2  <= in2;
	s3  <= in3;
	s4  <= in4;
	s5  <= in5;
	s6  <= in6;
	s7  <= in7;
	s8  <= in8;
	s9  <= in9;
	s10 <= in10;
	s11 <= in11;
	s12 <= in12;
        -- saidas deixam passar as entradas com meio ciclo de atraso
	process (clock)
	begin
		if falling_edge(clock) then
			out1  <= s1;
			out2  <= s2;
			out3  <= s3;
			out4  <= s4;
			out5  <= s5;
         out6  <= s6;
         out7  <= s7;
         out8  <= s8;
			out9  <= s9;
         out10 <= s10;
			out11 <= s11;
         out12 <= s12;
       end if;
			out1  <= s1;
			out2  <= s2;
			out3  <= s3;
			out4  <= s4; 
			out5  <= s5;
         out6  <= s6;
         out7  <= s7;
         out8  <= s8;
			out9  <= s9;
         out10 <= s10;
			out11 <= s11;
         out12 <= s12;
	end process;
end rtl;