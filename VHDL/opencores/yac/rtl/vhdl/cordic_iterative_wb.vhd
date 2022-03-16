----------------------------------------------------------------------------
----                                                                    ----
----  File           : cordic_iterative_wb.vhd                         ----
----  Project        : YAC (Yet Another CORDIC Core)                    ----
----  Creation       : Feb. 2014                                        ----
----  Limitations    :                                                  ----
----  Synthesizer    :                                                  ----
----  Target         :                                                  ----
----                                                                    ----
----  Author(s):     : Christian Haettich                               ----
----  Email          : feddischson@opencores.org                        ----
----                                                                    ----
----                                                                    ----
-----                                                                  -----
----                                                                    ----
----  Description                                                       ----
----        wb bus interface for the YAC                                ----
----                                                                    ----
----                                                                    ----
----                                                                    ----
-----                                                                  -----
----                                                                    ----
----     Memory organization:                                           ----
----  -----------------------------------------------------------       ----
----  |   word        |     description                         |       ----
----  |   index       |                                         |       ----
----  -----------------------------------------------------------       ----
----  |             0 |   x_0             \                     |       ----
----  |             1 |   y_0              \  1'st entry        |       ----
----  |             2 |   a_0              /                    |       ----
----  |             3 |   mode_0          /                     |       ----
----  |             4 |   x_1             \                     |       ----
----  |             5 |   y_1              \  2'nd entry        |       ----
----  |             6 |   a_1              /                    |       ----
----  |             7 |   mode_1          /                     |       ----
----  |             8 |   .                                     |       ----
----  |               |   ...                                   |       ----
----  | N_ENTRIES*4-4 |   x_n             \                     |       ----
----  | N_ENTRIES*4-3 |   y_n              \  n'th entry        |       ----
----  | N_ENTRIES*4-2 |   a_n              /                    |       ----
----  | N_ENTRIES*4-1 |   mode_n          /                     |       ----
----  | N_ENTRIES*4   |   status-register                       |       ----
----  -----------------------------------------------------------       ----
----                                                                    ----
----                                                                    ----
----      Status register bit fields:                                   ----
----                                                                    ----
----       bit 0: ==>> start/idle flag:                                 ----
----       ------------------------------                               ----
----                  write 1: start                                    ----
----                  read  1: busy                                     ----
----                  read  0: idle                                     ----
----              the flag is set by SW and cleared automatically       ----
----              after processing.                                     ----
----                                                                    ----
----       bit 1: ==>> IRQ flag:                                        ----
----       ------------------------------                               ----
----                  write 1: sets the IRQ                             ----
----                  write 0: clears the IRQ                           ----
----              the flag is set automatically by HW and is mapped     ----
----              to irq_o. The software can clear the flag/irq by      ----
----              writing a 0 to this bit.                              ----
----                                                                    ----
----                                                                    ----
----                                                                    ----
----       bit 16...ceil(log2(N_ENTRIES)): ==>> item-count              ----
----       -----------------------------------------------              ----
----           defines, how much items are processed,                   ----
----           the processing works from the higher part to the lower   ----
----           part of the memory.                                      ---
----                                                                    ----
----                                                                    ----
----                                                                    ----
----                                                                    ----
---------                                                       ------------
----  TODO:                                                             ----
----        - further testing                                           ----
----        - err_o: error output generation                            ----
----                                                                    ----
----                                                                    ----
----                                                                    ----
----                                                                    ----
----------------------------------------------------------------------------
----                                                                    ----
----                  Copyright Notice                                  ----
----                                                                    ----
---- This file is part of YAC - Yet Another CORDIC Core                 ----
---- Copyright (c) 2014, Author(s), All rights reserved.                ----
----                                                                    ----
---- YAC is free software; you can redistribute it and/or               ----
---- modify it under the terms of the GNU Lesser General Public         ----
---- License as published by the Free Software Foundation; either       ----
---- version 3.0 of the License, or (at your option) any later version. ----
----                                                                    ----
---- YAC is distributed in the hope that it will be useful,             ----
---- but WITHOUT ANY WARRANTY; without even the implied warranty of     ----
---- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU  ----
---- Lesser General Public License for more details.                    ----
----                                                                    ----
---- You should have received a copy of the GNU Lesser General Public   ----
---- License along with this library. If not, download it from          ----
---- http://www.gnu.org/licenses/lgpl                                   ----
----                                                                    ----
----------------------------------------------------------------------------



library ieee;
library std;
use std.textio.all;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use ieee.std_logic_textio.all; -- I/O for logic types
use work.cordic_pkg.ALL;


entity cordic_iterative_wb is
 generic(
   WB_ADR_WIDTH   : natural := 32; -- wishbone address bus width
   N_ENTRIES      : natural := 16; -- number of calculation entries, 
                                   -- which can be stored
   A_WIDTH        : natural := 12; -- \  
   XY_WIDTH       : natural := 12; --  | Cordic setup
   GUARD_BITS     : natural := 2;  --  |  
   RM_GAIN        : natural := 3   -- /
 );
 port(
   clk_i :  in std_logic;
   rst_i :  in std_logic;
   dat_i :  in std_logic_vector( 32-1 downto 0 );
   dat_o : out std_logic_vector( 32-1 downto 0 );
   adr_i :  in std_logic_vector( WB_ADR_WIDTH-1 downto 0 );
   we_i  :  in std_logic;
   sel_i :  in std_logic_vector( 4-1 downto 0 );
   cyc_i :  in std_logic;
   stb_i :  in std_logic;
   ack_o : out std_logic;
   cti_i :  in std_logic_vector( 3-1 downto 0 );
   bte_i :  in std_logic_vector( 2-1 downto 0 );
   irq_o : out std_logic
 );
 end entity;

architecture IMP of cordic_iterative_wb is

  constant STATUS_REG_I   : natural := N_ENTRIES*4;



  function ceil_log2(N: natural) return positive is
  begin
     if N <= 2 then
        return 1;
     else
        if N mod 2 = 0 then
           return 1 + ceil_log2( N/2 );
        else
           return 1 + ceil_log2( (N+1) / 2 );
        end if;
     end if;
  end;

  constant MEM_SIZE : natural := 32; 
  --
  -- memory blocks:
  --    N_ENTRIES * ( x, y, a, mode) + status-register
  --
  type mem_t  is array ( 0 to 4*N_ENTRIES+1-1 ) of std_logic_vector( MEM_SIZE-1 downto 0 );
  signal MEM : mem_t;

  -- address size  (in words)
  constant ADR_WIDTH : natural := ceil_log2( 4*N_ENTRIES+1 );

  type B3_TRANS_T is ( WB_BURST, WB_NO_BURST );
  signal b3_trans       : B3_TRANS_T;
  signal addr           : std_logic_vector( ADR_WIDTH-1  downto 0 );
  signal addr_burst     : std_logic_vector( ADR_WIDTH-1  downto 0 );
  signal cti_r          : std_logic_vector( cti_i'range );
  signal bte_r          : std_logic_vector( bte_i'range );
  signal dat_o_tmp      : std_logic_vector( dat_o'range );
  signal wr_data        : std_logic_vector( dat_i'range );
  signal ack_r          : std_logic;
  signal ack            : std_logic;

  signal burst_start   : std_logic;
  signal burst_end     : std_logic;



  component cordic_iterative_int is
  generic(
     XY_WIDTH    : natural := 12;
     A_WIDTH     : natural := 12;
     GUARD_BITS  : natural :=  2;
     RM_GAIN     : natural :=  4 
         );
  port(
     clk, rst  : in  std_logic;
     en        : in  std_logic;
     start     : in  std_logic;
     done      : out std_logic;
     mode_i    : in  std_logic_vector( 4-1 downto 0 );
     x_i       : in  std_logic_vector( XY_WIDTH-1  downto 0 );
     y_i       : in  std_logic_vector( XY_WIDTH-1  downto 0 );
     a_i       : in  std_logic_vector( A_WIDTH+2-1 downto 0 );
     x_o       : out std_logic_vector( XY_WIDTH+GUARD_BITS-1  downto 0 );
     y_o       : out std_logic_vector( XY_WIDTH+GUARD_BITS-1  downto 0 );
     a_o       : out std_logic_vector( A_WIDTH+2-1 downto 0 )
      );
  end component cordic_iterative_int;
  signal cordic_en      : std_logic;
  signal cordic_start   : std_logic;
  signal cordic_done    : std_logic;
  signal cordic_mode_i  : std_logic_vector( 4-1 downto 0 );
  signal cordic_x_i     : std_logic_vector( XY_WIDTH-1  downto 0 );
  signal cordic_y_i     : std_logic_vector( XY_WIDTH-1  downto 0 );
  signal cordic_a_i     : std_logic_vector( A_WIDTH+2-1 downto 0 );
  signal cordic_x_o     : std_logic_vector( XY_WIDTH+GUARD_BITS-1  downto 0 );
  signal cordic_y_o     : std_logic_vector( XY_WIDTH+GUARD_BITS-1  downto 0 );
  signal cordic_a_o     : std_logic_vector( A_WIDTH+2-1 downto 0 );


  type state_T_st  is (ST_IDLE, ST_START, ST_WAIT);
  type state_T     is 
  record
    st    : state_T_st;
    cnt   : unsigned( ceil_log2( N_ENTRIES ) -1 downto 0 );
  end record;
  signal state : state_T;


begin


  -- start of burst signal
  burst_start <= '1' when ( cti_i = "001" or cti_i = "010" ) 
                              and stb_i = '1' 
                              and b3_trans /= WB_BURST 
                  else '0';

  -- end of burst signal
  burst_end   <= '1' when cti_i = "111" 
                              and stb_i = '1' 
                              and b3_trans = WB_BURST   
                              and ack      = '1' 
                  else '0';




  ------
  --  Burst address generation: this depends on the number of entries
  --  and the internal address bus width
  --
  BURST_GEN_ALL : if ADR_WIDTH > 4 generate
  addr_burst <=                              std_logic_vector(  unsigned( addr               ) + 1 ) when bte_r = "00" else
                addr( addr'high downto 2 ) & std_logic_vector(  unsigned( addr( 1 downto 0 ) ) + 1 ) when bte_r = "01" else
                addr( addr'high downto 3 ) & std_logic_vector(  unsigned( addr( 2 downto 0 ) ) + 1 ) when bte_r = "10" else
                addr( addr'high downto 4 ) & std_logic_vector(  unsigned( addr( 3 downto 0 ) ) + 1 ) when bte_r = "11";

  end generate;


  BURST_GEN_4 : if ADR_WIDTH = 4 generate
  addr_burst <=                              std_logic_vector(  unsigned( addr               ) + 1 ) when bte_r = "00" else
                addr( addr'high downto 2 ) & std_logic_vector(  unsigned( addr( 1 downto 0 ) ) + 1 ) when bte_r = "01" else
                addr( addr'high downto 3 ) & std_logic_vector(  unsigned( addr( 2 downto 0 ) ) + 1 ) when bte_r = "10" else
                                             std_logic_vector(  unsigned( addr( 3 downto 0 ) ) + 1 ) when bte_r = "11";
  end generate;


  BURST_GEN_3 : if ADR_WIDTH = 3 generate 
  addr_burst <=                              std_logic_vector(  unsigned( addr               ) + 1 ) when bte_r = "00" else
                addr( addr'high downto 2 ) & std_logic_vector(  unsigned( addr( 1 downto 0 ) ) + 1 ) when bte_r = "01" else
                                             std_logic_vector(  unsigned( addr( 2 downto 0 ) ) + 1 ) when bte_r = "10";
  end generate;


  BURST_GEN_2 : if ADR_WIDTH = 2 generate 
  addr_burst <=                              std_logic_vector(  unsigned( addr               ) + 1 ) when bte_r = "00" else
                                             std_logic_vector(  unsigned( addr( 1 downto 0 ) ) + 1 ) when bte_r = "01";
  end generate;


  ------
  --
  --  wishbone bus transaction handling
  --    - ack generation
  --    - burst handling
  --    - address handling
  --
  p : process( clk_i, rst_i )

  begin

    if clk_i'event and clk_i='1' then
      if rst_i = '1' then
        addr           <= ( others => '0' );
        b3_trans       <= WB_NO_BURST;
        ack_r          <= '0';
      else

        cti_r <= cti_i;
        bte_r <= bte_i;


        if    burst_start = '1' then
          addr  <= adr_i( ADR_WIDTH+2-1 downto 2 );

        elsif cti_r = "010" and  ack = '1' and b3_trans = WB_BURST then
          addr <=  addr_burst;
        else
          addr  <= adr_i( ADR_WIDTH+2-1 downto 2 );
        end if;


        if    burst_start = '1' then

          -- start of burst
          b3_trans    <= WB_BURST;

        elsif burst_end = '1' then

          -- end of burst
          b3_trans <= WB_NO_BURST;

        elsif b3_trans = WB_BURST then

          -- during burst

        end if;



        -- ack generation
        if cyc_i  = '1' then

          if cti_i = "000" then

            if stb_i = '1' then
              ack_r <= not ack_r;
            end if;

          elsif cti_i = "010" or cti_i = "001" then
            ack_r <= stb_i;

          elsif cti_i = "111" then
            if ack_r = '0' then
              ack_r <= '1';
            else 
              ack_r <= '0';
            end if;

          end if;
        else
          ack_r <= '0';
        end if;

      end if;
    end if;

  end process;


  ack <= ack_r and stb_i;
  ack_o <= ack;

  wr_data( 31 downto 24 ) <=  dat_i( 31 downto 24 ) when sel_i(3) = '1' else dat_o_tmp( 31 downto 24 );
  wr_data( 23 downto 16 ) <=  dat_i( 23 downto 16 ) when sel_i(2) = '1' else dat_o_tmp( 23 downto 16 );
  wr_data( 15 downto  8 ) <=  dat_i( 15 downto 8  ) when sel_i(1) = '1' else dat_o_tmp( 15 downto 8  );
  wr_data(  7 downto  0 ) <=  dat_i( 7  downto 0  ) when sel_i(0) = '1' else dat_o_tmp( 7  downto 0  );


  --dat_o_tmp( dat_o_tmp'high downto MEM_SIZE ) <= ( others => '0' );
  dat_o_tmp( MEM_SIZE-1 downto 0 ) <= MEM( to_integer( unsigned( addr ) ) );
  dat_o <= dat_o_tmp;





  -- 
  --  this includes a small state machine, the IRQ generation
  --  and the memory handling
  -- 
  wr_p : process( clk_i, rst_i )
    variable MEM_START : integer;
  begin

    if clk_i'event and clk_i='1' then
      if rst_i = '1' then
        MEM <= ( others => ( others => '0' ) );
        state <= ( st  => ST_IDLE,
                    cnt => ( others => '0' ) );

        cordic_start  <= '0';
        cordic_x_i    <= ( others => '0' );
        cordic_y_i    <= ( others => '0' );
        cordic_a_i    <= ( others => '0' );
        cordic_mode_i <= ( others => '0' );

      else

        -- default values (get changed below)
        cordic_start    <= '0';
        cordic_x_i      <= ( others => '0' );
        cordic_y_i      <= ( others => '0' );
        cordic_a_i      <= ( others => '0' );
        cordic_mode_i   <= ( others => '0' );



        -- writing to memory
        if we_i = '1' and  ack = '1' then
          MEM( to_integer( unsigned( addr ) ) ) <= wr_data( MEM_SIZE-1 downto 0 );
        end if;




        -- start of all calculations
        if MEM( STATUS_REG_I )(0) = '1' and state.st = ST_IDLE then
          state.st   <= ST_START;
          state.cnt  <= unsigned( MEM( STATUS_REG_I )( 16+state.cnt'length-1 downto 16 ) )-1;
        end if;


        -- start of a single cordic calculation
        if state.st = ST_START then    
          MEM_START := to_integer( state.cnt & "00" ); -- state.cnt * 4
          cordic_x_i    <= MEM( MEM_START+0 )( cordic_x_i'range );
          cordic_y_i    <= MEM( MEM_START+1 )( cordic_y_i'range );
          cordic_a_i    <= MEM( MEM_START+2 )( cordic_a_i'range );
          cordic_mode_i <= MEM( MEM_START+3 )( cordic_mode_i'range );
          cordic_start  <= '1';

          state.st     <= ST_WAIT;
        end if;


        -- single cordic calculation is done:
        -- save the result and start the next one or
        -- go back to idle
        if state.st = ST_WAIT and cordic_done = '1' then
          MEM_START := to_integer( state.cnt & "00" ); -- state.cnt * 4
          MEM( MEM_START+0 ) <= ( others =>  cordic_x_o( cordic_x_o'high ));
          MEM( MEM_START+1 ) <= ( others =>  cordic_y_o( cordic_y_o'high ) );
          MEM( MEM_START+2 ) <= ( others =>  cordic_a_o( cordic_a_o'high ) );
          MEM( MEM_START+0 )( cordic_x_o'range ) <= cordic_x_o;
          MEM( MEM_START+1 )( cordic_y_o'range ) <= cordic_y_o;
          MEM( MEM_START+2 )( cordic_a_o'range ) <= cordic_a_o;


          if state.cnt = 0 then

            -- go back to IDLE
            state.st <= ST_IDLE;

            -- clear busy flag
            MEM( STATUS_REG_I )( 0 ) <= '0';

            -- set IRQ flag
            MEM( STATUS_REG_I )( 1 ) <= '1';
          else
            state.st <= ST_START;
            state.cnt <= state.cnt-1;
          end if;

        end if;

      end if;
    end if;
  end process;

  -- disable the cordic when there is nothing to do
  cordic_en <= '0' when state.st = ST_IDLE else '1';

  irq_o <= MEM( STATUS_REG_I )( 1 );



  -- the cordic instance
  cordic_inst : cordic_iterative_int 
  generic map (
     XY_WIDTH       => XY_WIDTH  ,
     A_WIDTH        => A_WIDTH   ,
     GUARD_BITS     => GUARD_BITS,
     RM_GAIN        => RM_GAIN   
         )
  port map(
     clk         => clk_i           ,
     rst         => rst_i           ,
     en          => cordic_en       ,
     start       => cordic_start    ,
     done        => cordic_done     ,
     mode_i      => cordic_mode_i   ,
     x_i         => cordic_x_i      ,
     y_i         => cordic_y_i      ,
     a_i         => cordic_a_i      ,
     x_o         => cordic_x_o      ,
     y_o         => cordic_y_o      ,
     a_o         => cordic_a_o         
      );






end architecture IMP;
