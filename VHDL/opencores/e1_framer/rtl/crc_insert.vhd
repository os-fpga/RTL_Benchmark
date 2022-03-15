library ieee;
use ieee.std_logic_1164.all;
use work.e1_package.all;


entity CRC_insert is
 port(data_fas:in std_logic;  --- serial one bit in data
      clk: in std_logic;
 	  start_frm:in std_logic;
 	  reset_all: in std_logic;
      zero_bit:out std_logic;
      bit_count:out type_bitcount;
      frame_count: out type_framecount;
 	  reset_crc4:out std_logic;
 	  outdata: out std_logic ---
 	  );
end CRC_insert;

architecture behave of CRC_insert is
signal bitcntr:type_bitcount;
signal frmcntr:type_framecount;  -- multiframe consists of 16 frames
signal smfrm:std_logic ;-- sub multiframe 0 /1

signal rs,st2,rs_crcblock,crcbit: std_logic;
signal reg_crc,temp_reg : std_logic_vector(3 downto 0);
component CRC_4 is
 port(indata:in std_logic;  --- serial one bit in data
      clk: in std_logic;
      reset:in std_logic;
  	  checksum:out std_logic_vector(3 downto 0)
	  );
end component;
begin

crc_block: crc_4 port map(data_fas,clk,rs_crcblock,temp_reg);
 bit_count<=bitcntr;
 frame_count<=frmcntr;
 reset_crc4<=rs_crcblock;
-----------------------------    
zerobit:process(clk)
begin 
  if clk'event and clk='1' then
   if start_frm='1' then
     st2<='1';    -- st2 will be high in the first clock pulse immediatly after start_frm has gone hign
    else 
      st2<='0';  
  end if;
 end if;   
end process;
------------------------------

rs<= ((start_frm and (not st2)) or reset_all);

------------------------------
bitcounter:process(clk,rs)
begin
if rs='1' then
  bitcntr<=0;
elsif clk'event and clk='1' then
    bitcntr<=bitcntr +1;
 end if;
end process;
----------------------------   
framecounter: process(start_frm)
begin
 if reset_all='1' then
    frmcntr<=0;
  elsif start_frm'event and start_frm='1' then
     frmcntr<=frmcntr+1;
   end if;   
end process;          
-------------------------
crcinsert:process(start_frm)
begin
 if start_frm'event and start_frm='1' then  -- zeroth bit event
  case(frmcntr) is
    when 0 =>
            reg_crc<=temp_reg;  -- store crc check sum of the previous sub multi frame
            crcbit<=reg_crc(0); --- C1
            rs_crcblock<='1'; -- reset the crc_4 for computation of next Sub multiframe
    when 1 =>
            crcbit<='0';   --- Multi Frame word zero bit
    when 2 =>
            crcbit<=reg_crc(1); --- C2
    when 3 =>
            crcbit<='0'; --- 
    when 4 =>
            crcbit<=reg_crc(2); --- C3
    when 5 =>
            crcbit<='1'; --- 
    when 6 =>
            crcbit<=reg_crc(3); --- C4
    when 7 =>
            crcbit<='0'; --- 
    when 8 =>
            reg_crc<=temp_reg;  -- store crc check sum of the previous sub multi frame    
            crcbit<=reg_crc(0); --- C1
            rs_crcblock<='1'; -- reset the crc_4 for computation of next Sub multiframe
    when 9 =>
            crcbit<='1'; ---  
    when 10 =>
            crcbit<=reg_crc(1); --- C2
    when 11 =>
            crcbit<='1'; --- 
    when 12 =>
            crcbit<=reg_crc(2); --- C3
    when 13 =>
            crcbit<='0' ;  ---# here shoul be E bit  
    when 14 =>
            crcbit<=reg_crc(3); --- C4
    when 15 =>
            crcbit<='0' ; --- # here shoul be E bit  
    when others =>
            crcbit<='0';
  end case;
--else
 --  crcbit<=data_fas;
end if;
end process;
-------------------------
outputpr:process(clk)
begin
 if clk'event and clk='0' then  -- output data on folling edge of clock
     if rs='1' then
      outdata<=crcbit;
     else
      outdata<=data_fas;
     end if;
  end if;
 end process;
zero_bit<=rs; 
 
end behave;    	
--------------------------------------------------------------------
-- NOte
--- look for CRC_4 reset on completion of every sub multi frame
--  look for zero bit time extension and 255 slot shrinking



