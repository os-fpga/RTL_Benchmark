library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity tb_AES_decrypt is 
end tb_AES_decrypt;

architecture beh_tb_AES_decrypt of tb_AES_decrypt is
	component AES_decrypter
	port (
		  cipher: in std_logic_vector(127 downto 0);
		  text_out: out std_logic_vector(127 downto 0);
		  key: in std_logic_vector(127 downto 0);
		  k_valid,c_valid: in std_logic;--Asserted when either key, cipher is valid
		  ready:out std_logic;--Asserted high when IP is ready to accept the data(key or Cipher)
		  out_valid: out std_logic;--out_valid:Asserted high when decrypted cipher is on the bus
		  clk,reset: in std_logic
		);
    end component;
   
   constant clk_period: time := 10 ns;
   signal reset,clk:std_logic;
   signal cipher,text_out: std_logic_vector(127 downto 0);
   signal key:std_logic_vector(127 downto 0);
   signal k_valid,c_valid,out_valid:std_logic;
   signal ready:std_logic;
   
   
begin
    uut:AES_decrypter
	port map(cipher=>cipher,text_out=>text_out,key=>key,k_valid=>k_valid,c_valid=>c_valid,out_valid=>out_valid,clk=>clk,reset=>reset,ready=>ready);
	
  clk_process:process
  begin
     clk<='1';
     wait for clk_period/2;
     clk<='0';
	 wait for clk_period/2;
  end process;
  
	tb_process:process
    variable LW : line;
	variable error: integer:=0;
	begin
      reset<='1';
	  k_valid<='0';
	  c_valid<='0';
	  
	  wait for 5*clk_period;
	  reset<='0';
	  
	  wait for clk_period;
	  
	  if(ready/='1') then
	  wait until ready='1';	  
	  end if;
	  k_valid<='1';
	  key<=x"1234567890abcdef1234567890abcdef";
	  
	  wait for clk_period;
	  k_valid<='0';
	  
	  --Test 1
	  
	  wait until ready='1';
      --Plain text : 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA  
	  cipher<=x"220dfcbbe717ae16ebcf69615a996adb";
	  c_valid<='1';
	  
	  wait for clk_period;
	  c_valid<='0';
	  
	  wait until out_valid='1';
	  wait for 1 ns;
	  if(x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" /= text_out) then 
	     write(LW,string'("Decryption Error!!!"));
	     write(LW,string'("   Expected : 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA Received : 0x"));
		 hwrite(LW,text_out);
	     writeline(output,LW);
		 error:=1;
	  end if; 

	  --Test 2
	  
	  wait until ready='1';
	  --Plain Text : 0xBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
	  cipher<=x"e9f386223ce53e52891c113d048145ec";
	  c_valid<='1';
	  
	  wait for clk_period;
	  c_valid<='0';
	  
	  wait until out_valid='1';
	  wait for 1 ns; --Delta delay
	  if(x"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" /= text_out) then 
	     write(LW,string'("Decryption Error!!!"));
	     write(LW,string'("   Expected : 0xBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB Received : 0x"));
		 hwrite(LW,text_out);
	     writeline(output,LW);
		 error:=1;
	  end if; 
	  
	  --Test 3
	  
	  wait until ready='1';
	  --Plain Text : 0xCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
	  cipher<=x"5426f624ac8c7c9eea54f55103a6e3ab";
	  c_valid<='1';
	  
	  wait for clk_period;
	  c_valid<='0';

	  wait until out_valid='1';
	  wait for 1 ns;
	  if(x"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC" /= text_out) then 
	     write(LW,string'("Decryption Error!!!"));
	     write(LW,string'("   Expected : 0xCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC Received : 0x"));
		 hwrite(LW,text_out);
	     writeline(output,LW);
		 error:=1;
	  end if;	  
	  
	  if(error = 0) then
	     write(LW,string'("********************************************"));
		 writeline(output,LW); 	
	     write(LW,        string'("            All test case passed!!!         "));
		 writeline(output,LW);
	     write(LW,string'("********************************************"));
		 writeline(output,LW);		 
	  else
	    write(LW,string'("********************************************"));
		writeline(output,LW);
        write(LW,        string'("         Some test case failed!!!!          "));
		writeline(output,LW);
	    write(LW,string'("********************************************"));
		writeline(output,LW);
      end if;	  
	
      assert false report"This is end of simulation not test failure!!!" severity failure;	--End simulation
	  
	wait;  
	end process;
	

end beh_tb_AES_decrypt;