library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

package block_ram_pack is

  component block_ram
    generic(
      WRITETHRU : integer; -- Set to nonzero value for writethrough mode
      USE_FILE  : integer; -- Set to nonzero value to use INIT_FILE
      INIT_VAL  : integer; -- Value used when INIT_FILE is not used
      INIT_FILE : string;  -- ASCII hexadecimal initialization file name
      FIL_WIDTH : integer; -- Bit width of init file lines
      ADR_WIDTH : integer;
      DAT_WIDTH : integer
    );
    port (
       clk_a    : in  std_logic;
       adr_a_i  : in  unsigned(adr_width-1 downto 0);
       we_a_i   : in  std_logic;
       en_a_i   : in  std_logic;
       dat_a_i  : in  unsigned(dat_width-1 downto 0);
       dat_a_o  : out unsigned(dat_width-1 downto 0);
       
       clk_b    : in  std_logic;
       adr_b_i  : in  unsigned(adr_width-1 downto 0);
       we_b_i   : in  std_logic;
       en_b_i   : in  std_logic;
       dat_b_i  : in  unsigned(dat_width-1 downto 0);
       dat_b_o  : out unsigned(dat_width-1 downto 0)
    );
  end component;

  component block_ram_async_reset
    generic(
      WRITETHRU : integer; -- Set to nonzero value for writethrough mode
      USE_FILE  : integer; -- Set to nonzero value to use INIT_FILE
      INIT_VAL  : integer; -- Value used when INIT_FILE is not used
      INIT_FILE : string;  -- ASCII hexadecimal initialization file name
      FIL_WIDTH : integer; -- Bit width of init file lines
      ADR_WIDTH : integer;
      DAT_WIDTH : integer
    );
    port (
       reset_a  : in std_logic;
       clk_a    : in  std_logic;
       adr_a_i  : in  unsigned(adr_width-1 downto 0);
       we_a_i   : in  std_logic;
       en_a_i   : in  std_logic;
       dat_a_i  : in  unsigned(dat_width-1 downto 0);
       dat_a_o  : out unsigned(dat_width-1 downto 0);

       reset_b  : in std_logic;
       clk_b    : in  std_logic;
       adr_b_i  : in  unsigned(adr_width-1 downto 0);
       we_b_i   : in  std_logic;
       en_b_i   : in  std_logic;
       dat_b_i  : in  unsigned(dat_width-1 downto 0);
       dat_b_o  : out unsigned(dat_width-1 downto 0)
    );
  end component;

  component swiss_army_ram
    generic(
      USE_BRAM  : integer; -- Set to nonzero value for BRAM, zero for distributed RAM
      WRITETHRU : integer; -- Set to nonzero value for writethrough mode
      USE_FILE  : integer; -- Set to nonzero value to use INIT_FILE
      INIT_VAL  : integer; -- Value used when INIT_FILE is not used
      INIT_SEL  : integer; -- Selects which segment of (larger) INIT_FILE to use
      INIT_FILE : string;  -- ASCII hexadecimal initialization file name
      FIL_WIDTH : integer; -- Bit width of init file lines
      ADR_WIDTH : integer;
      DAT_WIDTH : integer
    );
    port (
       clk_a    : in  std_logic;
       adr_a_i  : in  unsigned(adr_width-1 downto 0);
       we_a_i   : in  std_logic;
       en_a_i   : in  std_logic;
       dat_a_i  : in  unsigned(dat_width-1 downto 0);
       dat_a_o  : out unsigned(dat_width-1 downto 0);
       
       clk_b    : in  std_logic;
       adr_b_i  : in  unsigned(adr_width-1 downto 0);
       we_b_i   : in  std_logic;
       en_b_i   : in  std_logic;
       dat_b_i  : in  unsigned(dat_width-1 downto 0);
       dat_b_o  : out unsigned(dat_width-1 downto 0)
    );
  end component;

end block_ram_pack;

------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

library std ;
use std.textio.all;

entity block_ram is
    generic(
      WRITETHRU : integer := 1; -- Set to nonzero value for writethrough mode
      USE_FILE  : integer := 0; -- Set to nonzero value to use INIT_FILE
      INIT_VAL  : integer := 0; -- Value used when INIT_FILE is not used
      INIT_FILE : string  := ".\foo.txt";  -- ASCII hexadecimal initialization file name
      FIL_WIDTH : integer := 32; -- Bit width of init file lines
      ADR_WIDTH : integer := 3;
      DAT_WIDTH : integer := 32
    );
    port (
       clk_a    : in  std_logic;
       adr_a_i  : in  unsigned(adr_width-1 downto 0);
       we_a_i   : in  std_logic;
       en_a_i   : in  std_logic;
       dat_a_i  : in  unsigned(dat_width-1 downto 0);
       dat_a_o  : out unsigned(dat_width-1 downto 0);
       
       clk_b    : in  std_logic;
       adr_b_i  : in  unsigned(adr_width-1 downto 0);
       we_b_i   : in  std_logic;
       en_b_i   : in  std_logic;
       dat_b_i  : in  unsigned(dat_width-1 downto 0);
       dat_b_o  : out unsigned(dat_width-1 downto 0)
    );
end block_ram;

architecture beh of block_ram is

  -- Constants

  -- Functions & associated types
    type ram_array is array(0 to 2**ADR_WIDTH-1) of unsigned(DAT_WIDTH-1 downto 0);
    impure function ram_file_init (INIT_FILE : in string) return ram_array is
      FILE F1 : text is in INIT_FILE; 
      variable ligne : line;  
      variable rambo : ram_array;
      variable vect  : std_logic_vector(FIL_WIDTH-1 downto 0);
      variable uvect : unsigned(DAT_WIDTH-1 downto 0);
    begin
      for I in ram_array'range loop
        if (USE_FILE/=0) then
          readline(F1,ligne);
          hread(ligne,vect);
          for j in uvect'range loop
            if (vect(j)='1') then
              uvect(j):='1';
            else
              uvect(j):='0';
            end if;
          end loop;
        else
          uvect := to_unsigned(INIT_VAL,DAT_WIDTH);
        end if;
        rambo(I):=uvect;
      end loop;
      return rambo;
    end function;

  -- Variable Declarations
  shared variable ram1 : ram_array := ram_file_init(init_file);

  -- Signal Declarations
  signal dat_a_wt : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_b_wt : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_a_l  : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_b_l  : unsigned(DAT_WIDTH-1 downto 0);

begin

process (clk_a)
variable i : integer;
begin
  if (clk_a'event and clk_a='1') then
    if (en_a_i='1') then
      dat_a_l <= ram1(to_integer(adr_a_i));
      if (we_a_i='1') then
        ram1(to_integer(adr_a_i)) := dat_a_i;
        dat_a_wt <= dat_a_i;
      else
        dat_a_wt <= ram1(to_integer(adr_a_i));
      end if;
    end if;
  end if;
end process;
dat_a_o <= dat_a_l when WRITETHRU=0 else dat_a_wt;

process (clk_b)
variable i : integer;
begin
  if (clk_b'event and clk_b='1') then
    if (en_b_i='1') then
      dat_b_l <= ram1(to_integer(adr_b_i));
      if (we_b_i='1') then
        ram1(to_integer(adr_b_i)) := dat_b_i;
        dat_b_wt <= dat_b_i;
      end if;
      dat_b_wt <= ram1(to_integer(adr_b_i));
    end if;
  end if;
end process;
dat_b_o <= dat_b_l when WRITETHRU=0 else dat_b_wt;

end beh;

------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

library std ;
use std.textio.all;

entity block_ram_async_reset is
    generic(
      WRITETHRU : integer := 1; -- Set to nonzero value for writethrough mode
      USE_FILE  : integer := 0; -- Set to nonzero value to use INIT_FILE
      INIT_VAL  : integer := 0; -- Value used when INIT_FILE is not used
      INIT_FILE : string  := ".\foo.txt";  -- ASCII hexadecimal initialization file name
      FIL_WIDTH : integer := 32; -- Bit width of init file lines
      ADR_WIDTH : integer := 3;
      DAT_WIDTH : integer := 32
    );
    port (
       reset_a  : in std_logic;
       clk_a    : in  std_logic;
       adr_a_i  : in  unsigned(adr_width-1 downto 0);
       we_a_i   : in  std_logic;
       en_a_i   : in  std_logic;
       dat_a_i  : in  unsigned(dat_width-1 downto 0);
       dat_a_o  : out unsigned(dat_width-1 downto 0);

       reset_b  : in std_logic;
       clk_b    : in  std_logic;
       adr_b_i  : in  unsigned(adr_width-1 downto 0);
       we_b_i   : in  std_logic;
       en_b_i   : in  std_logic;
       dat_b_i  : in  unsigned(dat_width-1 downto 0);
       dat_b_o  : out unsigned(dat_width-1 downto 0)
    );
end block_ram_async_reset;

architecture beh of block_ram_async_reset is

  -- Constants

  -- Functions & associated types
    type ram_array is array(0 to 2**ADR_WIDTH-1) of unsigned(DAT_WIDTH-1 downto 0);
    impure function ram_file_init (INIT_FILE : in string) return ram_array is
      FILE F1 : text is in INIT_FILE; 
      variable ligne : line;  
      variable rambo : ram_array;
      variable vect  : std_logic_vector(FIL_WIDTH-1 downto 0);
      variable uvect : unsigned(DAT_WIDTH-1 downto 0);
    begin
      for I in ram_array'range loop
        if (USE_FILE/=0) then
          readline(F1,ligne);
          hread(ligne,vect);
          for j in uvect'range loop
            if (vect(j)='1') then
              uvect(j):='1';
            else
              uvect(j):='0';
            end if;
          end loop;
        else
          uvect := to_unsigned(INIT_VAL,DAT_WIDTH);
        end if;
        rambo(I):=uvect;
      end loop;
      return rambo;
    end function;

  -- Variable Declarations
  shared variable ram1 : ram_array := ram_file_init(init_file);

  -- Signal Declarations
  signal dat_a_wt : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_b_wt : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_a_l  : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_b_l  : unsigned(DAT_WIDTH-1 downto 0);

begin

process (clk_a)
variable i : integer;
begin
  if (reset_a = '1') then
    dat_a_l  <= (others=>'0');
    dat_a_wt <= (others=>'0');
  elsif (clk_a'event and clk_a='1') then
    if (en_a_i='1') then
      dat_a_l <= ram1(to_integer(adr_a_i));
      if (we_a_i='1') then
        ram1(to_integer(adr_a_i)) := dat_a_i;
        dat_a_wt <= dat_a_i;
      else
        dat_a_wt <= ram1(to_integer(adr_a_i));
      end if;
    end if;
  end if;
end process;
dat_a_o <= dat_a_l when WRITETHRU=0 else dat_a_wt;

process (clk_b)
variable i : integer;
begin
  if (reset_b = '1') then
    dat_b_l  <= (others=>'0');
    dat_b_wt <= (others=>'0');
  elsif (clk_b'event and clk_b='1') then
    if (en_b_i='1') then
      dat_b_l <= ram1(to_integer(adr_b_i));
      if (we_b_i='1') then
        ram1(to_integer(adr_b_i)) := dat_b_i;
        dat_b_wt <= dat_b_i;
      end if;
      dat_b_wt <= ram1(to_integer(adr_b_i));
    end if;
  end if;
end process;
dat_b_o <= dat_b_l when WRITETHRU=0 else dat_b_wt;

end beh;

------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

library std ;
use std.textio.all;

entity swiss_army_ram is
    generic(
      USE_BRAM  : integer := 0; -- Set to nonzero value for BRAM, zero for distributed RAM
      WRITETHRU : integer := 1; -- Set to nonzero value for writethrough mode
      USE_FILE  : integer := 0; -- Set to nonzero value to use INIT_FILE
      INIT_VAL  : integer := 0; -- Value used when INIT_FILE is not used
      INIT_SEL  : natural := 0; -- Can be used with generate loop variable to select a segment of the (larger) init file
      INIT_FILE : string  := ".\foo.txt";  -- ASCII hexadecimal initialization file name
      FIL_WIDTH : integer := 32; -- Bit width of init file lines
      ADR_WIDTH : integer := 3;
      DAT_WIDTH : integer := 32
    );
    port (
       clk_a    : in  std_logic;
       adr_a_i  : in  unsigned(adr_width-1 downto 0);
       we_a_i   : in  std_logic;
       en_a_i   : in  std_logic;
       dat_a_i  : in  unsigned(dat_width-1 downto 0);
       dat_a_o  : out unsigned(dat_width-1 downto 0);
       
       clk_b    : in  std_logic;
       adr_b_i  : in  unsigned(adr_width-1 downto 0);
       we_b_i   : in  std_logic;
       en_b_i   : in  std_logic;
       dat_b_i  : in  unsigned(dat_width-1 downto 0);
       dat_b_o  : out unsigned(dat_width-1 downto 0)
    );
end swiss_army_ram;

architecture beh of swiss_army_ram is

  -- Constants

  -- Functions & associated types
    type ram_array is array(0 to 2**ADR_WIDTH-1) of unsigned(DAT_WIDTH-1 downto 0);
    impure function ram_file_init (INIT_FILE : in string) return ram_array is
      FILE F1 : text is in INIT_FILE; 
      variable ligne : line;  
      variable rambo : ram_array;
      variable vect  : std_logic_vector(FIL_WIDTH-1 downto 0);
      variable uvect : unsigned(DAT_WIDTH-1 downto 0);
      variable I,J   : integer;
    begin
      -- If using the file, then index through the file to the desired selection
      if (USE_FILE/=0) then
        if (INIT_SEL>0) then
          for I in 0 to INIT_SEL-1 loop
            for J in ram_array'range loop
              readline(F1,ligne);
            end loop;
          end loop;
        end if;
      end if;
      -- Obtain the desired initialization values
      for I in ram_array'range loop
        if (USE_FILE/=0) then
          readline(F1,ligne);
          hread(ligne,vect);
          for J in uvect'range loop
            if (vect(J)='1') then
              uvect(J):='1';
            else
              uvect(J):='0';
            end if;
          end loop;
        else
          uvect := to_unsigned(INIT_VAL,DAT_WIDTH);
        end if;
        rambo(I):=uvect;
      end loop;
      return rambo;
    end function;

  -- Variable Declarations
  -- To run with RAM > 64k comment this initialization
  -- and un-comment the next line
  shared variable ram1 : ram_array := ram_file_init(init_file);
--  shared variable ram1 : ram_array; -- Initialization removed for this project due to Vivado 64K loop limit...

  -- Signal Declarations
  signal dat_a_wt : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_b_wt : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_a_l  : unsigned(DAT_WIDTH-1 downto 0);
  signal dat_b_l  : unsigned(DAT_WIDTH-1 downto 0);

begin

process (clk_a)
variable i : integer;
begin
  if (clk_a'event and clk_a='1') then
    if (en_a_i='1') then
      dat_a_l <= ram1(to_integer(adr_a_i));
      if (we_a_i='1') then
        ram1(to_integer(adr_a_i)) := dat_a_i;
        dat_a_wt <= dat_a_i;
      else
        dat_a_wt <= ram1(to_integer(adr_a_i));
      end if;
    end if;
  end if;
end process;
dat_a_o <= ram1(to_integer(adr_a_i)) when USE_BRAM=0   else
           dat_a_l                   when WRITETHRU=0  else
           dat_a_wt;

process (clk_b)
variable i : integer;
begin
  if (clk_b'event and clk_b='1') then
    if (en_b_i='1') then
      dat_b_l <= ram1(to_integer(adr_b_i));
      if (we_b_i='1') then
        ram1(to_integer(adr_b_i)) := dat_b_i;
        dat_b_wt <= dat_b_i;
      end if;
      dat_b_wt <= ram1(to_integer(adr_b_i));
    end if;
  end if;
end process;
dat_b_o <= ram1(to_integer(adr_b_i)) when USE_BRAM=0  else
           dat_b_l                   when WRITETHRU=0 else
           dat_b_wt;

end beh;

