library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.e1_package.all;

entity up_interface is port
     (clk:in std_logic;
      enable:in std_logic;
      rd_wr:in std_logic;
     address: in std_logic_vector(7 downto 0);
      data:inout std_logic_vector(7 downto 0)
     ) ;
end up_interface;

Architecture behave of up_interface is
--signal ioreg:std_logic_vector( 7 downto 0);
begin

memory: process(clk,enable,rd_wr) 
variable reg_sel,i:integer range 0 to REG_LAST;
variable reg :reg_array;
variable init_reg:std_logic:='0'; -- initialy 0
begin
reg_sel:=CONV_INTEGER(address);

if init_reg='0' then
 for i in 0 to REG_LAST loop
   reg(i):="00000000";
 end loop;
 init_reg:='1'; -- initialisation has been done
else 
if enable='1' then
 if clk'event and clk='1' then
   if rd_wr='1' then
     data<=reg(reg_sel); -- read
   elsif rd_wr='0' then
     reg(reg_sel):=data; -- write
   end if;
 end if;  
  end if;
end if; 

end process;
 
end behave;   
 
  

