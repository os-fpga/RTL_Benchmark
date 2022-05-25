--******************************************************************************
--*                                                                            *
--*           Calculates a CRC-24 over the data at Din, data may               *
--*           already arrive when Reset is high                                *
--*           The process from Din to CRC takes 2 Clk cycles                   *
--*           Frans Schreuder (Nikhef) franss@nikhef.nl                        *
--*                                                                            *
--******************************************************************************
library ieee;
use ieee.std_logic_1164.all;
library work;

entity CRC_24 is
   generic(
     Nbits :  positive 	:= 64;
     CRC_Width		  :  positive 	:= 24;
     G_Poly: Std_Logic_Vector :=x"32_8B63"; --c1acf
     G_InitVal: std_logic_vector:=x"ffff_ffff"
     );
   port(
     CRC   : out    std_logic_vector(CRC_Width-1 downto 0);
     Calc  : in     std_logic;
     Clk   : in     std_logic;
     DIn   : in     std_logic_vector(Nbits-1 downto 0);
     Reset : in     std_logic);
end CRC_24;


architecture rtl of CRC_24 is

    function ToIndirectInitVal(Direct:std_logic_vector; CRC_Width: positive; Poly: std_logic_vector) return std_logic_vector is 
        variable InDirect: std_logic_vector(Direct'high downto Direct'low);
    begin
        for k in 0 to CRC_Width loop
            if(k = 0) then
                InDirect := Direct;
            else
                if(InDirect(0)='1') then
                    InDirect := (('0'&InDirect(CRC_Width-1 downto 1)) xor ('1'&Poly(CRC_Width-1 downto 1)));
                else
                    InDirect := '0'&InDirect(CRC_Width-1 downto 1);
                end if;
            end if;
        end loop;
        return InDirect; 
    end function ToIndirectInitVal;
    
    constant Poly: Std_Logic_Vector(CRC_Width-1 downto 0) := G_Poly;
    constant InitVal: Std_Logic_Vector(CRC_Width-1 downto 0) := G_InitVal;
    
    constant InDirectInitVal: std_logic_vector(CRC_Width-1 downto 0):=ToIndirectInitVal(InitVal, CRC_Width, Poly);
    signal Reg_s : std_logic_vector(CRC_Width-1 downto 0);  
begin
   
  
    process (Clk)
        variable Reg, Reg2: Std_Logic_Vector (CRC_Width-1 downto 0);
        variable ApplyPoly: std_logic;
    begin

        if rising_Edge(Clk) then
            if Reset = '1' then
                if(Calc = '1') then
                    for k In 0 to Nbits loop
                        if(k = 0) then
                            Reg := (InDirectInitVal);--(CRC_Width-1 downto 0)&dinP(k))xor ('0'&Poly);
                        else
                            if Reg(CRC_Width-1) = '1' then
                                Reg := (Reg(CRC_Width-2 downto 0)&din(Nbits - k))xor (Poly);
                            else
                                Reg := Reg(CRC_Width-2 downto 0)&din(Nbits - k);
                            end if;
                        end if;
                    end loop;
                else
                    Reg := InDirectInitVal;
                end if;
            else
                if Calc = '1' then
                    for k In 1 to Nbits loop
                        if Reg(CRC_Width-1) = '1' then
                            Reg := (Reg(CRC_Width-2 downto 0)&din(Nbits - k))xor (Poly);
                        else
                            Reg := Reg(CRC_Width-2 downto 0)&din(Nbits - k);
                        end if;
                    end loop;
                else
                    Reg := Reg;
                end if;
            end if;
            
            Reg_s <= Reg;
            Reg2 := Reg_s;
            --we need one more loop to output the CRC register to the output.
            for k In 1 to CRC_Width loop
                if Reg2(CRC_Width-1) = '1' then
                    Reg2 := (Reg2(CRC_Width-2 downto 0)&'0')xor (Poly);
                else
                    Reg2:= Reg2(CRC_Width-2 downto 0)&'0';
                end if;
            end loop;
            CRC <= Reg2;--(CRC_width-1 downto 0);
        end if;
    end process;
    
end architecture rtl ; -- of CRC
