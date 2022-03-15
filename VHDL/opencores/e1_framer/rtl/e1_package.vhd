library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package e1_package is
------fas_insert-----------
type state_type is (S1,S2,S3,S4);  --S1 Looking for first FAS word
                                   --S2 Looking for FAS non align bit
									-- S3 looking for 2nd FAS word
									-- S4 In sync	  
 
subtype int_256 is integer range 0 to 255; --- frame bits counter--
subtype int_32 is integer range 0 to 31;
subtype int_4 is integer range 0 to 3 ; -- 
--------buffer--------------------
constant RAM_SIZE : integer := 8;
constant RAM_LAST: integer:=(RAM_SIZE -1 );
type ram is array(0 to RAM_LAST)  of std_logic_vector(7 downto 0) ;
subtype pntr_range is integer range 0 to RAM_LAST;
------crc_insert------------------
subtype type_bitcount is integer range 0 to 255;
subtype type_framecount is integer range 0 to 15;
--------- up_interface---------------
constant REG_SIZE : integer :=64;
constant REG_LAST : integer :=(REG_SIZE - 1);
type reg_array is array (0 to  REG_LAST)  of std_logic_vector(7 downto 0) ;
---subtype  is integer range 0 to REG_LAST ; 
-------------
end e1_package;  


