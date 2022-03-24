--------------------------------------------------------------------------
--                                                                      --
--                                                                      --
-- miniMIPS Superscalar Processor : Register bank                       --
-- based on miniMIPS Processor                                          --
--                                                                      --
--                                                                      --
-- Author : Miguel Cafruni                                              --
-- miguel_cafruni@hotmail.com                                           --
--                                                      December 2018   --
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pack_mips.all;

entity banc is
port (
       clock : in bus1;
       clock2 : in bus1;
       reset : in bus1;

       -- Register addresses to read
       reg_src1 : in bus5;
       reg_src2 : in bus5;

       -- Register address to write and its data
       reg_dest : in bus5;
       donnee   : in bus32;

       -- Write signal
       cmd_ecr  : in bus1;

       -- Bank outputs
       data_src1 : out bus32;
       data_src2 : out bus32;

       -- Register addresses to read
       reg_src3 : in bus5;
       reg_src4 : in bus5;

       -- Register address to write and its data
       reg_dest2 : in bus5;
       donnee2   : in bus32;

       -- Write signal
       cmd_ecr2  : in bus1;

       -- Bank outputs
       data_src3 : out bus32;
       data_src4 : out bus32
     );
end banc;


architecture rtl of banc is

    -- The register bank
    type tab_reg is array (1 to 31) of bus32;
    signal registres : tab_reg;
    signal adr_src1 : integer range 0 to 31;
    signal adr_src2 : integer range 0 to 31;
    signal adr_dest : integer range 0 to 31;
    signal adr_src3 : integer range 0 to 31;
    signal adr_src4 : integer range 0 to 31;
    signal adr_dest2 : integer range 0 to 31;
begin

    adr_src1 <= to_integer(unsigned(reg_src1));
    adr_src2 <= to_integer(unsigned(reg_src2));	
    adr_dest <= to_integer(unsigned(reg_dest));	 
    adr_src3 <= to_integer(unsigned(reg_src3));
    adr_src4 <= to_integer(unsigned(reg_src4));	 
    adr_dest2 <= to_integer(unsigned(reg_dest2));

    data_src1 <= (others => '0') when adr_src1=0 else
                 registres(adr_src1);
    data_src2 <= (others => '0') when adr_src2=0 else
                 registres(adr_src2);
    data_src3 <= (others => '0') when adr_src3=0 else
                 registres(adr_src3);
    data_src4 <= (others => '0') when adr_src4=0 else
                 registres(adr_src4);
					  

    process(clock)
    begin
        if rising_edge(clock) then
            if reset='1' then
                for i in 1 to 31 loop
                    registres(i) <= (others => '0');
                end loop;
            elsif cmd_ecr = '1' and adr_dest /= 0 then
            -- The data is saved
                registres(adr_dest) <= donnee;
			   end if;
            if cmd_ecr2 = '1' and adr_dest2 /= 0 then
                -- The data is saved
                    registres(adr_dest2) <= donnee2;
                end if;
            end if;
	end process;

end rtl;
