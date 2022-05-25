library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package fifo_pack is

  component generic_fifo
    generic(
      WIDTH          : integer;
      DEPTH          : integer;
      PF_FULL_POINT  : integer;
      PF_FLAG_POINT  : integer;
      PF_EMPTY_POINT : integer
    );
    port (     
      sys_rst_n     : in  std_logic; -- Asynchronous
      sys_clk       : in  std_logic;
      sys_clk_en    : in  std_logic;

      reset_i       : in std_logic;  -- Synchronous

      fifo_rd_i     : in  std_logic;
      fifo_dout     : out unsigned(WIDTH-1 downto 0);

      fifo_wr_i     : in  std_logic;
      fifo_din      : in  unsigned(WIDTH-1 downto 0);

      fifo_full     : out std_logic;
      fifo_empty    : out std_logic;    
      fifo_pf_full  : out std_logic;
      fifo_pf_flag  : out std_logic;
      fifo_pf_empty : out std_logic           
    );
  end component;

  component fifo_with_fill_level
    generic(
      WIDTH            : integer;
      DEPTH            : integer;
      FILL_LEVEL_BITS  : integer; -- Should be at least int(floor(log2(DEPTH))+1.0)
      PF_FULL_POINT    : integer;
      PF_FLAG_POINT    : integer;
      PF_EMPTY_POINT   : integer
    );
    port (
      sys_rst_n       : in  std_logic; -- Asynchronous
      sys_clk         : in  std_logic;
      sys_clk_en      : in std_logic;

      reset_i         : in std_logic;  -- Synchronous

      fifo_rd_i       : in  std_logic;
      fifo_dout       : out unsigned(WIDTH-1 downto 0);

      fifo_wr_i       : in  std_logic;
      fifo_din        : in  unsigned(WIDTH-1 downto 0);

      fifo_fill_level : out unsigned(FILL_LEVEL_BITS-1 downto 0);
      fifo_full       : out std_logic;
      fifo_empty      : out std_logic;    
      fifo_pf_full    : out std_logic;
      fifo_pf_flag    : out std_logic;
      fifo_pf_empty   : out std_logic           
    );
  end component;

  component swiss_army_fifo
    generic(
      USE_BRAM         : integer; -- Set to nonzero value for BRAM, zero for distributed RAM
      WIDTH            : integer;
      DEPTH            : integer;
      FILL_LEVEL_BITS  : integer; -- Should be at least int(floor(log2(DEPTH))+1.0)
      PF_FULL_POINT    : integer;
      PF_FLAG_POINT    : integer;
      PF_EMPTY_POINT   : integer
    );
    port (
      sys_rst_n       : in  std_logic; -- Asynchronous
      sys_clk         : in  std_logic;
      sys_clk_en      : in  std_logic;

      reset_i         : in std_logic;  -- Synchronous

      fifo_wr_i       : in  std_logic;
      fifo_din        : in  unsigned(WIDTH-1 downto 0);

      fifo_rd_i       : in  std_logic;
      fifo_dout       : out unsigned(WIDTH-1 downto 0);

      fifo_fill_level : out unsigned(FILL_LEVEL_BITS-1 downto 0);
      fifo_full       : out std_logic;
      fifo_empty      : out std_logic;    
      fifo_pf_full    : out std_logic;
      fifo_pf_flag    : out std_logic;
      fifo_pf_empty   : out std_logic           
    );
  end component;

  component swiss_army_fifo_cdc
    generic (
      USE_BRAM         : integer; -- Set to nonzero value for BRAM, zero for distributed RAM
      WIDTH            : integer;
      DEPTH            : integer;
      FILL_LEVEL_BITS  : integer; -- Should be at least int(floor(log2(DEPTH))+1.0)
      PF_FULL_POINT    : integer;
      PF_FLAG_POINT    : integer;
      PF_EMPTY_POINT   : integer
    );
    port (
      sys_rst_n        : in  std_logic; -- Asynchronous

      wr_clk_i         : in  std_logic;
      wr_clk_en_i      : in  std_logic;
      wr_reset_i       : in  std_logic;  -- Synchronous
      wr_en_i          : in  std_logic;
      wr_dat_i         : in  unsigned(WIDTH-1 downto 0);
      wr_fifo_level    : out unsigned(FILL_LEVEL_BITS-1 downto 0);
      wr_fifo_full     : out std_logic;
      wr_fifo_empty    : out std_logic;
      wr_fifo_pf_full  : out std_logic;
      wr_fifo_pf_flag  : out std_logic;
      wr_fifo_pf_empty : out std_logic;

      rd_clk_i         : in  std_logic;
      rd_clk_en_i      : in  std_logic;
      rd_reset_i       : in  std_logic;  -- Synchronous
      rd_en_i          : in  std_logic;
      rd_dat_o         : out unsigned(WIDTH-1 downto 0);
      rd_fifo_level    : out unsigned(FILL_LEVEL_BITS-1 downto 0);
      rd_fifo_full     : out std_logic;
      rd_fifo_empty    : out std_logic;
      rd_fifo_pf_full  : out std_logic;
      rd_fifo_pf_flag  : out std_logic;
      rd_fifo_pf_empty : out std_logic
    );
  end component;

  component data_packer
    generic (
      ADR_W          : integer; -- Bit width of snoop address
      DATA_IN_W      : integer; -- Maximum in_dat_i word size
      LOG2_DATA_IN_W : integer; -- Bit width of in_word_size_i
      DATA_OUT_W     : integer; -- Bit width of archive data
      FIFO_DEPTH     : integer  -- Size of BRAM FIFO buffer
    );
    port ( 

      sys_rst_n  : in std_logic;
      sys_clk    : in std_logic;
      sys_clk_en : in std_logic;

      -- Input Port
      in_dat_i        : in  unsigned(DATA_IN_W-1 downto 0);
      in_word_size_i  : in  unsigned(LOG2_DATA_IN_W downto 0);
      in_last_word_i  : in  std_logic;
      in_adr_i        : in  unsigned(ADR_W-1 downto 0);
      in_match_adr_i  : in  unsigned(ADR_W-1 downto 0);
      in_cyc_i        : in  std_logic;
      in_ack_i        : in  std_logic;

      -- Status
      fifo_full_o     : out std_logic;
      fifo_reset_i    : in  std_logic;

      -- Output Port
      tx_done_i       : in  std_logic;
      tx_buff_i       : in  unsigned(ADR_W-1 downto 0);
      out_dat_o       : out unsigned(DATA_OUT_W-1 downto 0);
      out_last_word_o : out std_logic;
      out_cyc_o       : out std_logic;
      out_ack_i       : in  std_logic

    );
  end component;

end fifo_pack;


--------------------------------------------------------------
-- Generic FIFO
--------------------------------------------------------------
-- Description:
--
-- This is a generic, parameterized FIFO module meant to be used
-- by logic which is already synchronous to the system clock.
-- The input and output use a single system clock.
-- Also, there is no handshaking for read/write requests.
-- This means that Read/Write request assertions must conform to
-- setup & hold times within the system clock domain in order for
-- this FIFO to operate correctly.  In other words, don't use
-- this FIFO with any inputs originating from a different clock
-- domain.
--
-- This FIFO has a memory array which is not address pipelined,
-- and which operates in a "single clock cycle response" mode
-- so that writes and reads are completed at the first clock
-- edge following the assertion of a read or write request.
-- Therefore, the system clock speed must be limited to speeds
-- at which the memory can respond in that fashion.  Also, it is
-- assumed that the memory array used for the FIFO storage will
-- be synthesized with separate input and output data paths, such
-- that reads and writes can occur at the same clock edge.  Thus
-- there does not need to be a prioritization of read vs. write
-- operations, since they can both occur at any given clock edge.
--
-- NOTES:
-- The DEPTH does not need to be a power of two.
-- This FIFO has been simulated using DEPTH values down to as
-- low as 2.  Depths less than this are considered degenerate 
-- cases, and will produce errors.
--
-- Since the read_row points to the data about to be read,
-- the fifo_dout bus contains the read data before a read
-- request is actually asserted.  In the case of an empty
-- FIFO, the output data bus is driven by the input data bus.
--
-- If read and write are requested simultaneously to a full
-- FIFO, it will remain full and it operates as an N stage
-- delay line.
--
-- If read and write are requested simultaneously to an empty
-- FIFO, it will remain empty.  No actual access to storage
-- is performed, and the input is simply passed to the output,
-- which could be considered to be a zero stage delay line...
--
-- If the PF empty and full points are set to be overlapping,
-- they can conceivably both be active at the same time.
-- PF empty values less than zero cause the fifo_pf_empty
-- output to stay inactive.  PF full values greater than the
-- FIFO depth cause the fifo_pf_full output to behave exactly
-- the same as fifo_full.
-- There is a third fifo fill level output, fifo_pf_flag.
-- It is high only when the FIFO fill level is greater than
-- or equal to the desired set value.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;

entity generic_fifo is
    generic ( 
      WIDTH          : integer :=  8;
      DEPTH          : integer :=  5;
      PF_FULL_POINT  : integer :=  3;
      PF_FLAG_POINT  : integer :=  2;
      PF_EMPTY_POINT : integer :=  0
    );
    port (     
      sys_rst_n     : in  std_logic; -- Asynchronous
      sys_clk       : in  std_logic;
      sys_clk_en    : in  std_logic;

      reset_i       : in std_logic;  -- Synchronous

      fifo_rd_i     : in  std_logic;
      fifo_dout     : out unsigned(WIDTH-1 downto 0);

      fifo_wr_i     : in  std_logic;
      fifo_din      : in  unsigned(WIDTH-1 downto 0);

      fifo_full     : out std_logic;
      fifo_empty    : out std_logic;
      fifo_pf_full  : out std_logic;
      fifo_pf_flag  : out std_logic;
      fifo_pf_empty : out std_logic           
    );
end generic_fifo;

architecture beh of generic_fifo is

  -- Constants
  constant FLG_WIDTH : integer := bit_width(DEPTH); -- Bit Width of memory address.  Pointers are one bit wider,
                                                    -- so that fill_level can represent the full quantity of 
                                                    -- items stored in the FIFO.  This is important when DEPTH
                                                    -- is an even power of 2.

  -- Signal Declarations
  signal rd_row     : unsigned(FLG_WIDTH downto 0);
  signal wr_row     : unsigned(FLG_WIDTH downto 0);
  signal fill_level : unsigned(FLG_WIDTH downto 0);

  TYPE memory_array IS
    ARRAY (integer RANGE 0 TO DEPTH-1) OF unsigned(WIDTH-1 DOWNTO 0);

  SIGNAL fifo_array: memory_array;

  TYPE STATE_TYPE IS (st_empty, st_data, st_full);

  signal current_state : STATE_TYPE ;


BEGIN

  fifo_empty    <= '1' when (current_state=st_empty) else '0';
  fifo_full     <= '1' when (current_state=st_full)  else '0';
  fifo_pf_full  <= '1' when (fill_level>=PF_FULL_POINT or current_state=st_full) else '0';
  fifo_pf_flag  <= '1' when (fill_level>=PF_FLAG_POINT) else '0';
  fifo_pf_empty <= '1' when (fill_level<=PF_EMPTY_POINT and current_state/=st_full) else '0';

-------------------------
-- The FIFO Fill Level
fill_level_proc: process(wr_row, rd_row, current_state)
  begin
    if (current_state=st_empty) then
      fill_level <= (others=>'0');
    elsif (wr_row>rd_row) then
      fill_level <= wr_row-rd_row;
    else
      fill_level <= DEPTH+(wr_row-rd_row);
    end if;
  end process;

-------------------------
-- The FIFO memory
memory: process (sys_clk, sys_rst_n) 
  variable i : integer;
  begin
    -- The memory initialization at reset was included for simulation only.
    -- It can be removed for synthesis if desired.
    if (sys_rst_n='0') then
      for i in 0 to DEPTH-1 loop
        fifo_array(i) <= (others=>'0');
      end loop;
    elsif (sys_clk'event and sys_clk = '1') then 
      if (sys_clk_en='1') then
        if ((fifo_wr_i='1' and current_state/=st_full) or
            (fifo_wr_i='1' and current_state=st_full and fifo_rd_i='1')) then
          fifo_array(to_integer(wr_row(FLG_WIDTH-1 downto 0))) <= fifo_din; 
        end if; 
      end if;
    end if; 
  end process; 
fifo_dout <= fifo_array(to_integer(rd_row(FLG_WIDTH-1 downto 0))) when (current_state/=st_empty) 
             else fifo_din;


-------------------------
-- The FIFO state machine
  clocked : PROCESS(sys_clk, sys_rst_n)

  procedure do_write is
  begin
    if (wr_row=DEPTH-1) then  -- Roll buffer index for non-power-of-two
      wr_row <= (others=>'0');
    else 
      wr_row<=wr_row+1;
    end if;
  end do_write;

  procedure do_read is
  begin
    if (rd_row=DEPTH-1) then  -- Roll buffer index for non-power-of-two
      rd_row <= (others=>'0');
    else 
      rd_row<=rd_row+1;
    end if;
  end do_read;

  begin
    if (sys_rst_n = '0') then
      current_state <= st_empty;
      rd_row   <= (others=>'0');
      wr_row   <= (others=>'0');

    elsif (sys_clk'EVENT and sys_clk = '1') then
      if (sys_clk_en='1') then
        if (reset_i='1') then
          current_state <= st_empty;
          wr_row <= (others=>'0');
          rd_row <= (others=>'0');
        else
          case current_state is

          when st_empty =>
            if (fifo_wr_i='1') then
              do_write;
              if (fifo_rd_i='0') then
                current_state<=st_data;
              else
                do_read;
              end if;
            end if;

          when st_data =>
            if (fifo_wr_i='1') then
              do_write;
              if (fifo_rd_i='0' and fill_level=DEPTH-1) then
                current_state<=st_full;
              end if;
            end if;
            if (fifo_rd_i='1') then
              do_read;
              if (fifo_wr_i='0' and fill_level=1) then
                current_state<=st_empty;
              end if;
            end if;

          when st_full =>
            if (fifo_rd_i='1') then
              do_read;
              if (fifo_wr_i='0') then
                current_state<=st_data;
              else
                do_write;
              end if;
            end if;

          when others => null;
          end case;
          
        end if;
      end if; -- sys_clk_en
    end if; -- sys_clk
  end process clocked;


end beh;


--------------------------------------------------------------
-- FIFO with fill level output
--------------------------------------------------------------
-- Description:
--
-- This is the same as "generic_fifo" but with an additional
-- output providing the fifo_fill_level.
--
-- The bit width of this additional output is set by a generic
-- parameter 
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;

entity fifo_with_fill_level is
    generic ( 
      WIDTH            : integer :=  8;
      DEPTH            : integer :=  5;
      FILL_LEVEL_BITS  : integer :=  3; -- Should be at least int(floor(log2(DEPTH))+1.0)
      PF_FULL_POINT    : integer :=  3;
      PF_FLAG_POINT    : integer :=  2;
      PF_EMPTY_POINT   : integer :=  0
    );
    port (     
      sys_rst_n       : in  std_logic; -- Asynchronous
      sys_clk         : in  std_logic;
      sys_clk_en      : in  std_logic;

      reset_i         : in std_logic;  -- Synchronous

      fifo_rd_i       : in  std_logic;
      fifo_dout       : out unsigned(WIDTH-1 downto 0);

      fifo_wr_i       : in  std_logic;
      fifo_din        : in  unsigned(WIDTH-1 downto 0);

      fifo_fill_level : out unsigned(FILL_LEVEL_BITS-1 downto 0);
      fifo_full       : out std_logic;
      fifo_empty      : out std_logic;
      fifo_pf_full    : out std_logic;
      fifo_pf_flag    : out std_logic;
      fifo_pf_empty   : out std_logic           
    );
end fifo_with_fill_level;

architecture beh of fifo_with_fill_level is

  -- Constants
  constant FLG_WIDTH : integer := bit_width(DEPTH); -- Bit Width of memory address.  Pointers are one bit wider,
                                                    -- so that fill_level can represent the full quantity of 
                                                    -- items stored in the FIFO.  This is important when DEPTH
                                                    -- is an even power of 2.

  -- Signal Declarations
  signal rd_row     : unsigned(FLG_WIDTH downto 0);
  signal wr_row     : unsigned(FLG_WIDTH downto 0);
  signal fill_level : unsigned(FLG_WIDTH downto 0);

  TYPE memory_array IS
    ARRAY (integer RANGE 0 TO DEPTH-1) OF unsigned(WIDTH-1 DOWNTO 0);

  SIGNAL fifo_array: memory_array;

  TYPE STATE_TYPE IS (st_empty, st_data, st_full);

  signal current_state : STATE_TYPE ;


BEGIN

  fifo_empty      <= '1' when (current_state=st_empty) else '0';
  fifo_full       <= '1' when (current_state=st_full)  else '0';
  fifo_pf_full    <= '1' when (fill_level>=PF_FULL_POINT or current_state=st_full) else '0';
  fifo_pf_flag    <= '1' when (fill_level>=PF_FLAG_POINT) else '0';
  fifo_pf_empty   <= '1' when (fill_level<=PF_EMPTY_POINT and current_state/=st_full) else '0';
  fifo_fill_level <= u_resize(fill_level,FILL_LEVEL_BITS);

-------------------------
-- The FIFO Fill Level
fill_level_proc: process(wr_row, rd_row, current_state)
  begin
    if (current_state=st_empty) then
      fill_level <= (others=>'0');
    elsif (wr_row>rd_row) then
      fill_level <= wr_row-rd_row;
    else
      fill_level <= DEPTH+(wr_row-rd_row);
    end if;
  end process;

-------------------------
-- The FIFO memory
memory: process (sys_clk, sys_rst_n) 
  variable i : integer;
  begin
    -- The memory initialization at reset was included for simulation only.
    -- It can be removed for synthesis if desired.
    if (sys_rst_n='0') then
      for i in 0 to DEPTH-1 loop
        fifo_array(i) <= (others=>'0');
      end loop;
    elsif (sys_clk'event and sys_clk = '1') then 
      if (sys_clk_en='1') then
        if ((fifo_wr_i='1' and current_state/=st_full) or
            (fifo_wr_i='1' and current_state=st_full and fifo_rd_i='1')) then
          fifo_array(to_integer(wr_row(FLG_WIDTH-1 downto 0))) <= fifo_din; 
        end if; 
      end if;
    end if; 
end process; 
fifo_dout <= fifo_array(to_integer(rd_row(FLG_WIDTH-1 downto 0))) when (current_state/=st_empty) 
             else fifo_din;


-------------------------
-- The FIFO state machine
  clocked : PROCESS(sys_clk, sys_rst_n)

  procedure do_write is
  begin
    if (wr_row=DEPTH-1) then  -- Roll buffer index for non-power-of-two
      wr_row <= (others=>'0');
    else 
      wr_row<=wr_row+1;
    end if;
  end do_write;

  procedure do_read is
  begin
    if (rd_row=DEPTH-1) then  -- Roll buffer index for non-power-of-two
      rd_row <= (others=>'0');
    else 
      rd_row<=rd_row+1;
    end if;
  end do_read;

  begin
    if (sys_rst_n = '0') then
      current_state <= st_empty;
      rd_row   <= (others=>'0');
      wr_row   <= (others=>'0');

    elsif (sys_clk'EVENT and sys_clk = '1') then
      if (sys_clk_en='1') then
        if (reset_i='1') then
          current_state <= st_empty;
          wr_row <= (others=>'0');
          rd_row <= (others=>'0');
        else
          case current_state is

          when st_empty =>
            if (fifo_wr_i='1') then
              do_write;
              if (fifo_rd_i='0') then
                current_state<=st_data;
              else
                do_read;
              end if;
            end if;

          when st_data =>
            if (fifo_wr_i='1') then
              do_write;
              if (fifo_rd_i='0' and fill_level=DEPTH-1) then
                current_state<=st_full;
              end if;
            end if;
            if (fifo_rd_i='1') then
              do_read;
              if (fifo_wr_i='0' and fill_level=1) then
                current_state<=st_empty;
              end if;
            end if;

          when st_full =>
            if (fifo_rd_i='1') then
              do_read;
              if (fifo_wr_i='0') then
                current_state<=st_data;
              else
                do_write;
              end if;
            end if;

          when others => null;
          end case;
          
        end if;
      end if; -- sys_clk_en
    end if; -- sys_clk
  end process clocked;


end beh;


--------------------------------------------------------------
-- SWISS ARMY FIFO with fill level output
--------------------------------------------------------------
-- Description:
--
-- This is the same as "fifo_with_fill_level" but it has been
-- coded to select whether Block RAMs or distributed RAMs are inferred.
--
-- The bit width of this additional output is set by a generic
-- parameter 
--
-- Note : When USE_BRAM=0, the behavior when reading the FIFO is to
--        make read data available immediately during the clock cycle
--        in which fifo_rd_i='1'.  When USE_BRAM/=0, then an additional
--        clock cycle occurs following the fifo_rd_i pulse, before the
--        output data is available.
--        Please be aware of this.
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;
use work.block_ram_pack.all;

entity swiss_army_fifo is
    generic (
      USE_BRAM         : integer :=  1; -- Set to nonzero value for BRAM, zero for distributed RAM
      WIDTH            : integer :=  8;
      DEPTH            : integer :=  5;
      FILL_LEVEL_BITS  : integer :=  3; -- Should be at least int(floor(log2(DEPTH))+1.0)
      PF_FULL_POINT    : integer :=  3;
      PF_FLAG_POINT    : integer :=  2;
      PF_EMPTY_POINT   : integer :=  0
    );
    port (
      sys_rst_n       : in  std_logic; -- Asynchronous
      sys_clk         : in  std_logic;
      sys_clk_en      : in  std_logic;

      reset_i         : in  std_logic;  -- Synchronous

      fifo_wr_i       : in  std_logic;
      fifo_din        : in  unsigned(WIDTH-1 downto 0);

      fifo_rd_i       : in  std_logic;
      fifo_dout       : out unsigned(WIDTH-1 downto 0);

      fifo_fill_level : out unsigned(FILL_LEVEL_BITS-1 downto 0);
      fifo_full       : out std_logic;
      fifo_empty      : out std_logic;
      fifo_pf_full    : out std_logic;
      fifo_pf_flag    : out std_logic;
      fifo_pf_empty   : out std_logic           
    );
end swiss_army_fifo;

architecture beh of swiss_army_fifo is

  -- Constants
  constant FLG_WIDTH : integer := bit_width(DEPTH); -- Bit Width of memory address.  Pointers are one bit wider,
                                                    -- so that fill_level can represent the full quantity of 
                                                    -- items stored in the FIFO.  This is important when DEPTH
                                                    -- is an even power of 2.

  -- Signal Declarations
  signal rd_row     : unsigned(FLG_WIDTH downto 0);
  signal wr_row     : unsigned(FLG_WIDTH downto 0);
  signal fill_level : unsigned(FLG_WIDTH downto 0);
  signal ram_we_a   : std_logic;
  signal ram_dout   : unsigned(WIDTH-1 downto 0);

  TYPE STATE_TYPE IS (st_empty, st_data, st_full);
  signal current_state : STATE_TYPE ;

  signal bram_dat_b : unsigned(WIDTH-1 downto 0);

BEGIN

  fifo_empty      <= '1' when (current_state=st_empty) else '0';
  fifo_full       <= '1' when (current_state=st_full)  else '0';
  fifo_pf_full    <= '1' when (fill_level>=PF_FULL_POINT or current_state=st_full) else '0';
  fifo_pf_flag    <= '1' when (fill_level>=PF_FLAG_POINT) else '0';
  fifo_pf_empty   <= '1' when (fill_level<=PF_EMPTY_POINT and current_state/=st_full) else '0';
  fifo_fill_level <= u_resize(fill_level,FILL_LEVEL_BITS);

-------------------------
-- The FIFO Fill Level
fill_level_proc: process(wr_row, rd_row, current_state)
  begin
    if (current_state=st_empty) then
      fill_level <= (others=>'0');
    elsif (wr_row>rd_row) then
      fill_level <= wr_row-rd_row;
    else
      fill_level <= DEPTH+(wr_row-rd_row);
    end if;
  end process;

-------------------------
-- The FIFO memory

-- Port A is the write side.
-- Port B is dedicated to reading only.
-- The hexfile is used to permit initialization of the RAM

  fifo_ram : swiss_army_ram
    generic map(
      USE_BRAM  => USE_BRAM,
      WRITETHRU => 0, -- Set to nonzero value for writethrough mode
      USE_FILE  => 0, -- Set to nonzero value to use INIT_FILE
      INIT_VAL  => 0,
      INIT_SEL  => 0, -- No generate loop here
      INIT_FILE => ".\foo.txt", -- ASCII hexadecimal initialization file name
      FIL_WIDTH => 32, -- Bit width of init file lines
      ADR_WIDTH => FLG_WIDTH,
      DAT_WIDTH => WIDTH
    )
    port map (
       clk_a    => sys_clk,
       clk_b    => sys_clk,

       adr_a_i  => wr_row(FLG_WIDTH-1 downto 0),
       adr_b_i  => rd_row(FLG_WIDTH-1 downto 0),

       we_a_i   => ram_we_a,
       en_a_i   => sys_clk_en,
       dat_a_i  => fifo_din,
       dat_a_o  => open,

       we_b_i   => '0',
       en_b_i   => sys_clk_en,
       dat_b_i  => bram_dat_b,
       dat_b_o  => ram_dout
    );

  bram_dat_b <= (others=>'0');
  ram_we_a <= '1' when fifo_wr_i='1' and (current_state/=st_full or (current_state=st_full and fifo_rd_i='1')) else '0';
  fifo_dout <= ram_dout;


-------------------------
-- The FIFO state machine
  clocked : PROCESS(sys_clk, sys_rst_n)

  procedure do_write is
  begin
    if (wr_row=DEPTH-1) then  -- Roll buffer index for non-power-of-two
      wr_row <= (others=>'0');
    else 
      wr_row<=wr_row+1;
    end if;
  end do_write;

  procedure do_read is
  begin
    if (rd_row=DEPTH-1) then  -- Roll buffer index for non-power-of-two
      rd_row <= (others=>'0');
    else 
      rd_row<=rd_row+1;
    end if;
  end do_read;

  begin
    if (sys_rst_n = '0') then
      current_state <= st_empty;
      rd_row   <= (others=>'0');
      wr_row   <= (others=>'0');

    elsif (sys_clk'EVENT and sys_clk = '1') then
      if (sys_clk_en='1') then
        if (reset_i='1') then
          current_state <= st_empty;
          wr_row <= (others=>'0');
          rd_row <= (others=>'0');
        else
          case current_state is

          -- When empty, one can only read if also writing
          when st_empty =>
            if (fifo_wr_i='1') then
              do_write;
              if (fifo_rd_i='1') then
                do_read;
              else
                current_state<=st_data;
              end if;
            end if;

          when st_data =>
            if (fifo_wr_i='1') then
              do_write;
              if (fifo_rd_i='0' and fill_level=DEPTH-1) then
                current_state<=st_full;
              end if;
            end if;
            if (fifo_rd_i='1') then
              do_read;
              if (fifo_wr_i='0' and fill_level=1) then
                current_state<=st_empty;
              end if;
            end if;

          -- When full, one can only write if also reading
          when st_full =>
            if (fifo_rd_i='1') then
              do_read;
              if (fifo_wr_i='1') then
                do_write;
              else
                current_state<=st_data;
              end if;
            end if;

          when others => null;
          end case;
        
        end if;
      end if; -- sys_clk_en
    end if; -- sys_clk
  end process clocked;


end beh;

--------------------------------------------------------------
-- SWISS ARMY FIFO "Clock Domain Crossing" version
--------------------------------------------------------------
-- Description:
--
-- This is the same as "swiss_army_fifo" but it has been
-- coded to include two separate clock domains.  Originally,
-- the status signals were all synchronized to their respective
-- clock domains.  However, it was taken out so that the user of
-- this module must take care as the status signals are not delayed,
-- but they are possibly subject to metastability.
--
-- Note : When USE_BRAM=0, the behavior when reading the FIFO is to
--        make read data available immediately during the clock cycle
--        in which fifo_rd_i='1'.  When USE_BRAM/=0, then an additional
--        clock cycle occurs following the fifo_rd_i pulse, before the
--        output data is available.
--        Please be aware of this.
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;
use work.block_ram_pack.all;

entity swiss_army_fifo_cdc is
    generic (
      USE_BRAM         : integer :=  1; -- Set to nonzero value for BRAM, zero for distributed RAM
      WIDTH            : integer :=  8;
      DEPTH            : integer :=  5;
      FILL_LEVEL_BITS  : integer :=  3; -- Should be at least int(floor(log2(DEPTH))+1.0)
      PF_FULL_POINT    : integer :=  3;
      PF_FLAG_POINT    : integer :=  2;
      PF_EMPTY_POINT   : integer :=  0
    );
    port (
      sys_rst_n        : in  std_logic; -- Asynchronous

      wr_clk_i         : in  std_logic;
      wr_clk_en_i      : in  std_logic;
      wr_reset_i       : in  std_logic;  -- Synchronous
      wr_en_i          : in  std_logic;
      wr_dat_i         : in  unsigned(WIDTH-1 downto 0);
      wr_fifo_level    : out unsigned(FILL_LEVEL_BITS-1 downto 0);
      wr_fifo_full     : out std_logic;
      wr_fifo_empty    : out std_logic;
      wr_fifo_pf_full  : out std_logic;
      wr_fifo_pf_flag  : out std_logic;
      wr_fifo_pf_empty : out std_logic;

      rd_clk_i         : in  std_logic;
      rd_clk_en_i      : in  std_logic;
      rd_reset_i       : in  std_logic;  -- Synchronous
      rd_en_i          : in  std_logic;
      rd_dat_o         : out unsigned(WIDTH-1 downto 0);
      rd_fifo_level    : out unsigned(FILL_LEVEL_BITS-1 downto 0);
      rd_fifo_full     : out std_logic;
      rd_fifo_empty    : out std_logic;
      rd_fifo_pf_full  : out std_logic;
      rd_fifo_pf_flag  : out std_logic;
      rd_fifo_pf_empty : out std_logic           

    );
end swiss_army_fifo_cdc;

architecture beh of swiss_army_fifo_cdc is

  -- Constants
  constant FLG_WIDTH : integer := bit_width(DEPTH); -- Bit Width of memory address.  Pointers are one bit wider,
                                                    -- so that fill_level can represent the full quantity of 
                                                    -- items stored in the FIFO.  This is important when DEPTH
                                                    -- is an even power of 2.

  -- Signal Declarations
  signal rd_row     : unsigned(FLG_WIDTH downto 0);
  signal wr_row     : unsigned(FLG_WIDTH downto 0);
  signal fill_level : unsigned(FLG_WIDTH+1 downto 0);
  signal ram_we_a   : std_logic;
  signal bram_dat_b : unsigned(WIDTH-1 downto 0);

  signal fifo_level       : unsigned(FILL_LEVEL_BITS-1 downto 0);
  signal fifo_full        : std_logic;
  signal fifo_empty       : std_logic;
  signal fifo_pf_full     : std_logic;
  signal fifo_pf_flag     : std_logic;
  signal fifo_pf_empty    : std_logic;

begin

  fifo_level    <= u_resize(fill_level,FILL_LEVEL_BITS);
  fifo_full     <= '1' when (fill_level=DEPTH) else '0';
  fifo_empty    <= '1' when (fill_level=0) else '0';
  fifo_pf_full  <= '1' when (fill_level>=PF_FULL_POINT) else '0';
  fifo_pf_flag  <= '1' when (fill_level>=PF_FLAG_POINT) else '0';
  fifo_pf_empty <= '1' when (fill_level<=PF_EMPTY_POINT) else '0';

-------------------------
-- The FIFO Fill Level

fill_level <= (others=>'0') when wr_row=rd_row else
              ('0' & wr_row)-('0' & rd_row) when wr_row>rd_row else
              (2**(FLG_WIDTH+1))+(('0' & wr_row)-('0' & rd_row));

-------------------------
-- The FIFO memory

-- Port A is the write side.
-- Port B is dedicated to reading only.
-- The hexfile is used to permit initialization of the RAM

  fifo_ram : swiss_army_ram
    generic map(
      USE_BRAM  => USE_BRAM,
      WRITETHRU => 0, -- Set to nonzero value for writethrough mode
      USE_FILE  => 0, -- Set to nonzero value to use INIT_FILE
      INIT_VAL  => 0,
      INIT_SEL  => 0, -- No generate loop here
      INIT_FILE => ".\foo.txt", -- ASCII hexadecimal initialization file name
      FIL_WIDTH => 32, -- Bit width of init file lines
      ADR_WIDTH => FLG_WIDTH,
      DAT_WIDTH => WIDTH
    )
    port map (
       clk_a    => wr_clk_i,
       clk_b    => rd_clk_i,

       adr_a_i  => wr_row(FLG_WIDTH-1 downto 0),
       adr_b_i  => rd_row(FLG_WIDTH-1 downto 0),

       we_a_i   => ram_we_a,
       en_a_i   => wr_clk_en_i,
       dat_a_i  => wr_dat_i,
       dat_a_o  => open,

       we_b_i   => '0',
       en_b_i   => rd_clk_en_i,
       dat_b_i  => bram_dat_b,
       dat_b_o  => rd_dat_o
    );

  bram_dat_b <= (others=>'0');
  ram_we_a <= '1' when wr_en_i='1' and fifo_full='0' else '0';

-------------------------
-- The FIFO writing process
  wr_proc : PROCESS(wr_clk_i, sys_rst_n)
  begin
    if (sys_rst_n = '0') then
      wr_row   <= (others=>'0');
    elsif (wr_clk_i'event and wr_clk_i = '1') then
      if (wr_clk_en_i='1') then
        if (wr_reset_i='1') then
          wr_row <= (others=>'0');
        else
          if (ram_we_a='1') then
            if (fifo_level=DEPTH) then
              null; -- FIFO is full!  Don't do any writes.
            else
              wr_row <= wr_row+1;
            end if;
          end if;
        end if;
        -- Synchronize all dataflow outputs to the
        -- wr_clk_i clock domain
--        wr_fifo_level    <= fifo_level;
--        wr_fifo_full     <= fifo_full;
--        wr_fifo_empty    <= fifo_empty;
--        wr_fifo_pf_full  <= fifo_pf_full;
--        wr_fifo_pf_flag  <= fifo_pf_flag;
--        wr_fifo_pf_empty <= fifo_pf_empty;
      end if; -- wr_clk_en
    end if; -- wr_clk_i
  end process wr_proc;
  -- Synchronized version removed, because it added an extra clock
  -- cycle of delay.
  -- This may be dangerous in terms of flip-flop metastability
  wr_fifo_level    <= fifo_level;
  wr_fifo_full     <= fifo_full;
  wr_fifo_empty    <= fifo_empty;
  wr_fifo_pf_full  <= fifo_pf_full;
  wr_fifo_pf_flag  <= fifo_pf_flag;
  wr_fifo_pf_empty <= fifo_pf_empty;

-------------------------
-- The FIFO reading process
  rd_proc : PROCESS(rd_clk_i, sys_rst_n)
  begin
    if (sys_rst_n = '0') then
      rd_row   <= (others=>'0');
    elsif (rd_clk_i'event and rd_clk_i = '1') then
      if (rd_clk_en_i='1') then
        if (rd_reset_i='1') then
          rd_row <= (others=>'0');
        else
          if (rd_en_i='1' and fifo_empty='0') then
            if (fifo_level=0) then
              null; -- FIFO is empty!  Don't read anything.
            else
              rd_row <= rd_row+1;
            end if;
          end if;
        end if;
        -- Synchronize all dataflow outputs to the
        -- rd_clk_i clock domain
--        rd_fifo_level    <= fifo_level;
--        rd_fifo_full     <= fifo_full;
--        rd_fifo_empty    <= fifo_empty;
--        rd_fifo_pf_full  <= fifo_pf_full;
--        rd_fifo_pf_flag  <= fifo_pf_flag;
--        rd_fifo_pf_empty <= fifo_pf_empty;
      end if; -- rd_clk_en
    end if; -- rd_clk_i
  end process rd_proc;
  -- Synchronized version removed, because it added an extra clock
  -- cycle of delay.
  -- This may be dangerous in terms of flip-flop metastability
  rd_fifo_level    <= fifo_level;
  rd_fifo_full     <= fifo_full;
  rd_fifo_empty    <= fifo_empty;
  rd_fifo_pf_full  <= fifo_pf_full;
  rd_fifo_pf_flag  <= fifo_pf_flag;
  rd_fifo_pf_empty <= fifo_pf_empty;

end beh;

-------------------------------------------------------------------------------
-- Adjustable Data Packer
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Sep.  04, 2012  Copied code from pcm_tx, and began
--                         updating the description.
--         July  18, 2013  Moved this module from decom_pack into
--                         fifo_pack, and revised the description
--                         to make it sound more generic.
--
-- Description
-------------------------------------------------------------------------------
-- This module is a very simple "bit packer" that takes in data on a parallel
-- bus, along with a word size value that indicates which of the input least
-- significant bits are to be "packed."
--
-- The input port is an address snooper, meaning that it is intended to be used
-- on a bus with other units also receiving the data.  The other units will
-- acknowledge the transfers, and this unit uses that acknowledge to latch the
-- bus data.
--
-- The latched input word is shifted one bit at a time into the output
-- word shift register.  When the output word shift register is full, the
-- output word is latched, and an output cycle is produced.
--
-- This mechanism allows data words of dynamically programmable size to be
-- "snooped up" for any selected data source on the input bus, and then sent 
-- over the ethernet interface as 8-bit values.
--
-- When asserted, the "last word" input causes zero bits to be packed into the
-- output word as needed to finish up a final output cycle.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.fifo_pack.all;
use work.convert_pack.all;

  entity data_packer is
    generic (
      ADR_W          : integer :=   4; -- Bit width of snoop address
      DATA_IN_W      : integer :=  16; -- Maximum in_dat_i word size
      LOG2_DATA_IN_W : integer :=   4; -- Bit width of in_word_size_i
      DATA_OUT_W     : integer :=   8; -- Bit width of archive data
      FIFO_DEPTH     : integer := 512  -- Size of BRAM FIFO buffer
    );
    port ( 

      sys_rst_n  : in std_logic;
      sys_clk    : in std_logic;
      sys_clk_en : in std_logic;

      -- Input Port
      in_dat_i        : in  unsigned(DATA_IN_W-1 downto 0);
      in_word_size_i  : in  unsigned(LOG2_DATA_IN_W downto 0);
      in_last_word_i  : in  std_logic;
      in_adr_i        : in  unsigned(ADR_W-1 downto 0);
      in_match_adr_i  : in  unsigned(ADR_W-1 downto 0);
      in_cyc_i        : in  std_logic;
      in_ack_i        : in  std_logic;

      -- Status
      fifo_full_o     : out std_logic;
      fifo_reset_i    : in  std_logic;

      -- Output Port
      tx_done_i       : in  std_logic;
      tx_buff_i       : in  unsigned(ADR_W-1 downto 0);
      out_dat_o       : out unsigned(DATA_OUT_W-1 downto 0);
      out_last_word_o : out std_logic;
      out_cyc_o       : out std_logic;
      out_ack_i       : in  std_logic

    );
  end data_packer;

architecture beh of data_packer is

-- Constants
constant FIFO_WIDTH      : natural := (LOG2_DATA_IN_W+1)+DATA_IN_W+1; -- word_size, data, 1 bit last word flag
constant FIFO_FILL_BITS  : natural := timer_width(FIFO_DEPTH);
constant LOG2_DATA_OUT_W : natural := bit_width(DATA_OUT_W);

-- Internal signal declarations
signal fifo_din         : unsigned(FIFO_WIDTH-1 downto 0);
signal fifo_dout        : unsigned(FIFO_WIDTH-1 downto 0);
signal fifo_we          : std_logic;
signal fifo_rd          : std_logic;
signal fifo_empty       : std_logic;
signal stored_data      : unsigned(DATA_IN_W-1 downto 0);
signal stored_word_size : unsigned(LOG2_DATA_IN_W downto 0);
signal stored_last_word : std_logic;

  -- Modified Miller Code State Machine
type FSM_STATE_TYPE is (TRANSFER, READ_DATA, MAKE_TAIL, WRITE_DATA, WRITE_LAST_DATA);
signal fsm_state        : FSM_STATE_TYPE;



signal bits_in        : unsigned(DATA_IN_W downto 0); -- includes "last word" bit
signal bits_in_count  : unsigned(LOG2_DATA_IN_W downto 0);
signal bit_sel        : unsigned(LOG2_DATA_IN_W downto 0);
signal bits_out       : unsigned(DATA_OUT_W-1 downto 0);
signal bits_out_count : unsigned(LOG2_DATA_OUT_W downto 0);
signal transfer_bit   : std_logic;
signal buffering      : std_logic;

begin

fifo_din <= in_word_size_i & in_dat_i & in_last_word_i;
fifo_we  <= '1' when (in_adr_i=in_match_adr_i) and in_cyc_i='1' and in_ack_i='1' else '0';
stored_word_size <= fifo_dout(DATA_IN_W+1+LOG2_DATA_IN_W downto DATA_IN_W+1);
stored_data      <= fifo_dout(DATA_IN_W downto 1);
stored_last_word <= fifo_dout(0);

packer_fifo : swiss_army_fifo
  generic map(
    USE_BRAM         => 1,
    WIDTH            => FIFO_WIDTH,
    DEPTH            => FIFO_DEPTH,
    FILL_LEVEL_BITS  => FIFO_FILL_BITS,
    PF_FULL_POINT    => FIFO_DEPTH-4,
    PF_FLAG_POINT    => FIFO_DEPTH/2,
    PF_EMPTY_POINT   => 4
  )
  port map(
    sys_rst_n       => sys_rst_n,
    sys_clk         => sys_clk,
    sys_clk_en      => sys_clk_en,

    reset_i         => fifo_reset_i,

    fifo_wr_i       => fifo_we,
    fifo_din        => fifo_din,

    fifo_rd_i       => fifo_rd,
    fifo_dout       => fifo_dout,

    fifo_fill_level => open,
    fifo_full       => fifo_full_o,
    fifo_empty      => fifo_empty,
    fifo_pf_full    => open,
    fifo_pf_flag    => open,
    fifo_pf_empty   => open
  );

pack_proc: process(sys_clk, sys_rst_n)
begin
  if (sys_rst_n='0') then
    buffering       <= '1';
    bits_in         <= (others=>'0');
    bits_in_count   <= (others=>'0');
    bits_out        <= (others=>'0');
    bits_out_count  <= (others=>'0');
    bit_sel         <= (others=>'0');
    fsm_state       <= READ_DATA;
  elsif (sys_clk'event and sys_clk='1') then
    if (sys_clk_en='1') then

      -- Handle transitions from packing state to buffering state
      if (tx_done_i='1' and tx_buff_i=in_match_adr_i) then
        buffering <= '0';
      end if;

      if (buffering='0') then

        -- Default values

        -- Handle state transitions
        case (fsm_state) is

          when TRANSFER =>
            if (bits_in_count=0) then
              if (transfer_bit='1') then -- Check last word bit.
                fsm_state <= MAKE_TAIL;
              else
                fsm_state <= READ_DATA;
              end if;
              -- Writing completed data is highest priority
              if (bits_out_count=DATA_OUT_W) then
                if (transfer_bit='1') then
                  fsm_state <= WRITE_LAST_DATA;
                  bits_out_count <= (others=>'0');
                else
                  fsm_state <= WRITE_DATA;
                  bits_out_count <= (others=>'0');
                end if;
              end if;
            elsif (bits_out_count=DATA_OUT_W) then
              fsm_state <= WRITE_DATA;
              bits_out_count <= (others=>'0');
            elsif (bits_in_count>0) then
              bits_out <= bits_out(bits_out'length-2 downto 0) & transfer_bit;
              bits_in  <= bits_in(bits_in'length-2 downto 0) & '0';
              bits_in_count <= bits_in_count-1;
              bits_out_count <= bits_out_count+1;
            end if;

          when READ_DATA =>
            bits_in       <= stored_data & stored_last_word;
            bits_in_count <= stored_word_size;
            bit_sel       <= stored_word_size;
            if (fifo_rd='1' and stored_word_size>0) then
              fsm_state <= TRANSFER;
            end if;

          when MAKE_TAIL =>
            if (bits_out_count>=DATA_OUT_W) then
              fsm_state <= WRITE_LAST_DATA;
              bits_out_count <= (others=>'0');
            else
              bits_out <= bits_out(DATA_OUT_W-2 downto 0) & '0';
              bits_out_count <= bits_out_count+1;
            end if;

          when WRITE_DATA =>
            if (out_ack_i='1') then
              fsm_state <= TRANSFER;
              if (bits_in_count=0) then
                fsm_state <= READ_DATA;
              end if;
            end if;

          when WRITE_LAST_DATA =>
            if (out_ack_i='1') then
              fsm_state <= TRANSFER;
              if (bits_in_count=0) then
                fsm_state <= READ_DATA;
              end if;
              buffering <= '1';
            end if;

          --when others => 
          --  fsm_state <= IDLE;
        end case;

      end if; -- buffering='0' and fifo_empty='0'

    end if; -- sys_clk_en
  end if; -- sys_clk
end process;

-- Select the correct bit to transfer
transfer_bit <= bits_in(to_integer(bit_sel));

-- Create FIFO read signal
fifo_rd <= '1' when fsm_state=READ_DATA and fifo_empty='0' and buffering='0' else '0';

-- Assign the outputs
out_last_word_o <= '1' when fsm_state=WRITE_LAST_DATA else '0';
out_cyc_o <= '1' when fsm_state=WRITE_DATA or fsm_state=WRITE_LAST_DATA else '0';
out_dat_o <= bits_out;

end beh;

