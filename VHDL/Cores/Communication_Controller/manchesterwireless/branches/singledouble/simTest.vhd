library ieee;
use ieee.std_logic_1164.all;

use work.globals.all;

entity testSim is
end testSim;

architecture Behavioral of testSim is

  component manchesterWireless
  port (
    clk_i             : in  std_logic;
    rst_i             : in  std_logic;
    data_i            : in  std_logic;
    q_o               : out std_logic_vector(WORD_LENGTH-1 downto 0);
    ready_o           : out std_logic;
    recieved_debug    : out std_logic_vector(3 downto 0);
    waitforstart_rdy  : out std_logic
  );
  end component; 

  signal decode_output : std_logic_vector(WORD_LENGTH-1 downto 0);
  -- up/down and left/right buffers
  signal parity_o_buff, parity_o_reg : std_logic;
  signal button_o_buff, button_o_reg : std_logic_vector(1 downto 0);
  signal ud_buff1, ud_buff2, lr_buff1, lr_buff2 : std_logic_vector(6 downto 0);
  signal ud_buff1_reg, ud_buff2_reg, lr_buff1_reg, lr_buff2_reg : std_logic_vector(6 downto 0);
  signal char_select : integer range 0 to 3;
  signal reset_manchester, soft_reset, ready_o_buff : std_logic;
  
  
  signal clk_i             : std_logic;
  signal rst_i             : std_logic := '1';
  signal data_i            : std_logic;
  signal ready_o           : std_logic;
  signal character_o       : std_logic_vector(0 to 7);
  signal anode_ctrl        : std_logic_vector(3 downto 0);
  signal button_o          : std_logic_vector(1 downto 0);
  signal parity_o          : std_logic;
  signal recieved_debug    : std_logic_vector(3 downto 0);
  signal waitforstart_rdy  : std_logic;  
  
  signal coded_rdy: std_logic;
  signal coded : std_logic_vector(WORD_LENGTH-1 downto 0);
  constant half_period : time := 10 ns;
  constant period : time := 2*half_period;
  constant mid_single : time := (INTERVAL_MIN_SINGLE+INTERVAL_MAX_SINGLE)/2*period;
  constant WORD : std_logic_vector(28 downto 0) := "01100101100101010101010101010";  

begin
  character_o(7) <= '1'; -- turn off decimal point

  reset_manchester <=  rst_i or soft_reset;
  ready_o <= ready_o_buff;

  inst_manchesterWireless: manchesterWireless
  port map(
    clk_i   => clk_i,
    rst_i   => reset_manchester,
    data_i  => data_i,
    q_o     => decode_output,
    ready_o => ready_o_buff,
    recieved_debug => recieved_debug,
    waitforstart_rdy => waitforstart_rdy
  );
  
  -- the transmitter is sending the following UP/DOWN (4 bits)
  -- then left/right (3 bits), and finally the parity (1 bit)
  -- each command was ror onto the transmitter -- one at a time.
  -- the decoder was written to assume that all the data was in 
  -- being shifted to the transmitter from the right
  -- thus, while we are transmitting:
  -- initialize|up/down|left/right|buttons|parity|stop
  -- the decoder will return results to us as
  -- parity|buttons|left/right|up/down
  -- bits 9|  8-7  |   6-4    |  3-0
  
  -- decode up/down first digit (ones place)
  with decode_output(3 downto 0) select
     ud_buff1  <= "0000001" when x"D",  -- off
                   "1001111" when x"F",  -- 1
                   "0010010" when x"7",  -- 2
                   "0000110" when x"5",  -- 3
                   "1001100" when x"1",  -- 4
                   "0100100" when x"3",  -- 5
                   "0100000" when x"2",  -- 6
                   "0001111" when x"6",  -- 7
                   "0000000" when x"e",  -- 8
                   "0000100" when x"c",  -- 9
                   "0000001" when x"a",  -- 10
                   "1001111" when x"b",  -- 11
                   "0010010" when x"9",  -- 12
                   "0000110" when x"8",  -- 13
                   "1111111" when others; -- 'E'rror

  -- decode up/down second digit (tens place)                 
  with decode_output(3 downto 0) select
     ud_buff2  <=  "1001111" when x"a",  -- 10
                   "1001111" when x"b",  -- 11
                   "1001111" when x"9",  -- 12
                   "1001111" when x"8",  -- 13
                   "1111111" when others;

  -- decode left/right first digit
  with decode_output(6 downto 4) select
     lr_buff1  <=  "1001111" when "010",  -- -1
                   "0010010" when "011",  -- -2
                   "0000110" when "001",  -- -3
                   "0000001" when "110",  -- 0
                   "1001111" when "100",  -- 1
                   "0010010" when "101",  -- 2
                   "0000110" when "111",  -- 3
                   "1111111" when others;

  -- decode left/right sign digit
  with decode_output(6 downto 4) select
     lr_buff2  <=  "1111110" when "010",  -- -1
                   "1111110" when "011",  -- -2
                   "1111110" when "001",  -- -3
                   "1111111" when others;
                   
  -- decode buttons                    
  with decode_output(8 downto 7) select
     button_o_buff  <=  "11" when "10",  -- 00
                        "01" when "11",  -- 10
                        "10" when "01",  -- 01
                        "00" when "00",  -- 11
                        "11" when others;

  parity_o_buff <= decode_output(9);
  parity_o <= parity_o_reg;

  process (clk_i,rst_i)
    variable counter : integer range 0 to 1023;
  begin  
     if rst_i = '1' then
       char_select <= 0;
       counter := 0;
       div_clk := '0';
       soft_reset <= '0';
     elsif (clk_i'event and clk_i = '1') then
       -- register the output
       if (ready_o_buff = '1') then
        ud_buff1_reg <= ud_buff1;
        ud_buff2_reg <= ud_buff2;
        lr_buff1_reg <= lr_buff1;
        lr_buff2_reg <= lr_buff2;
        button_o_reg <= button_o_buff;
        parity_o_reg <= parity_o_buff;
        soft_reset <= '1';
       else
        soft_reset <= '0';
       end if;
     
       counter := counter + 1;
       if (counter = 1023) then
         
         -- this is for simulation
         -- ModelSim does not want to roll over
         if char_select < 3 then
          char_select <= char_select + 1;
         else
          char_select <= 0;
         end if;
         
         counter := 0;
       end if;

     end if;
  end process;
   
  -- set output
  with char_select select
    character_o(0 to 6) <= ud_buff2_reg when 0,
                           ud_buff1_reg when 1,
                           lr_buff2_reg when 2,
                           lr_buff1_reg when 3;

  with char_select select
    anode_ctrl <= "0111" when 0,
                  "1011" when 1,
                  "1101" when 2,
                  "1110" when 3; 
               
  process
  begin
    wait for 5*period;
    rst_i <= '0';

    -- begin transmission header 
    data_i <= '1';
    wait for 5*MID_SINGLE;
    
    data_i <= '0';
    wait for MID_SINGLE;
    -- end transmission header

    for i in WORD'left downto 0 loop
      data_i <= WORD(i);
      wait for MID_SINGLE;
    end loop;

    data_i <= '1';
    wait for MID_SINGLE;
   
    rst_i <= '1';
    wait for 5*period;

  end process;
  
  clock : process
  begin
    clk_i <= '1';
    loop
      wait for half_period;
      clk_i <= not clk_i;
    end loop;
  end process; 
               
end Behavioral;



