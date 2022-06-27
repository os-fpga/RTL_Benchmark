--(Maximum Frequency: 301.051MHz)

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
 
ENTITY sha256compressionCore is
    Port ( clock 	: in  STD_LOGIC;
           --data input signals
           data 	: in  STD_LOGIC_VECTOR (255 downto 0);
           load   : in  STD_LOGIC;
           w, k 	: in  STD_LOGIC_VECTOR (31 downto 0);
           enable : in  STD_LOGIC;
           --hash output signals
           digest	: out STD_LOGIC_VECTOR (255 downto 0));
end sha256compressionCore;
 
ARCHITECTURE Behavioral of sha256compressionCore is

   signal b,c,d,f,g,h,su0,su1,maj,ch,temp1,temp2,a1,a2,e1,sum : STD_LOGIC_VECTOR(31 downto 0);
 
BEGIN
 
   compression: process(clock)
   begin
      if rising_edge(clock) then
         if load = '1' then
				a1 <= data(255 downto 224);
				b <= data(223 downto 192);
				c <= data(191 downto 160);
				d <= data(159 downto 128);
				e1 <= data(127 downto 96);
				f <= data(95 downto 64);
				g <= data(63 downto 32);
				h <= data(31 downto 0);
				a2 <= (others => '0');
				temp1 <= (others => '0');
         elsif enable = '1' then
            a1 <= su0;
				a2 <= maj;
				temp1 <= h + su1 + ch;
				b <= temp2;
				c <= b;
				d <= c;
				e1 <= d;
				f <= sum;
				g <= f;
				h <= g + w + k;
			end if;
		end if;
   end process;
   --main_loop_pipe asynchron circuitry
   su1 <= (sum(5 downto 0) & sum(31 downto 6)) xor (sum(10 downto 0) & sum(31 downto 11)) xor (sum(24 downto 0) & sum(31 downto 25));
   ch <= (sum and f) xor ((not sum) and g);
   su0 <= (temp2(1 downto 0) & temp2(31 downto 2)) xor (temp2(12 downto 0) & temp2(31 downto 13)) xor (temp2(21 downto 0) & temp2(31 downto 22));
   maj <= (temp2 and (b xor c)) xor (b and c);
   sum <= e1 + temp1;
   temp2 <= temp1 + a1 + a2;
   --end of main_loop_pipe asynchron circuitry
   digest <= temp2 & b & c & d & sum & f & g & h;

END Behavioral;
