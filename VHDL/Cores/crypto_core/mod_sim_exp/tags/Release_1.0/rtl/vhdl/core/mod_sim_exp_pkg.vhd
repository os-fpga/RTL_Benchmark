----------------------------------------------------------------------  
----  mod_sim_exp_pkg                                             ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    Package for the Modular Simultaneous Exponentiation Core  ----
----    Project. Contains the component declarations and used     ----
----    constants.                                                ----
----                                                              ---- 
----  Dependencies: none                                          ---- 
----                                                              ---- 
----  Authors:                                                    ----
----      - Geoffrey Ottoy, DraMCo research group                 ----
----      - Jonas De Craene, JonasDC@opencores.org                ---- 
----                                                              ---- 
---------------------------------------------------------------------- 
----                                                              ---- 
---- Copyright (C) 2011 DraMCo research group and OPENCORES.ORG   ---- 
----                                                              ---- 
---- This source file may be used and distributed without         ---- 
---- restriction provided that this copyright statement is not    ---- 
---- removed from the file and that any derivative work contains  ---- 
---- the original copyright notice and the associated disclaimer. ---- 
----                                                              ---- 
---- This source file is free software; you can redistribute it   ---- 
---- and/or modify it under the terms of the GNU Lesser General   ---- 
---- Public License as published by the Free Software Foundation; ---- 
---- either version 2.1 of the License, or (at your option) any   ---- 
---- later version.                                               ---- 
----                                                              ---- 
---- This source is distributed in the hope that it will be       ---- 
---- useful, but WITHOUT ANY WARRANTY; without even the implied   ---- 
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ---- 
---- PURPOSE.  See the GNU Lesser General Public License for more ---- 
---- details.                                                     ---- 
----                                                              ---- 
---- You should have received a copy of the GNU Lesser General    ---- 
---- Public License along with this source; if not, download it   ---- 
---- from http://www.opencores.org/lgpl.shtml                     ---- 
----                                                              ---- 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


package mod_sim_exp_pkg is
  
  --------------------------------------------------------------------
  -- d_flip_flop
  --------------------------------------------------------------------
  --    1-bit D flip-flop with asynchronous active high reset
  -- 
  component d_flip_flop is
    port(
      core_clk : in  std_logic; -- clock signal
      reset    : in  std_logic; -- active high reset
      din      : in  std_logic; -- data in
      dout     : out std_logic  -- data out
    );
  end component d_flip_flop;
  
  --------------------------------------------------------------------
  -- register_1b
  --------------------------------------------------------------------
  --    1-bit register with asynchronous reset and clock enable
  -- 
  component register_1b is
    port(
      core_clk : in  std_logic; -- clock input
      ce       : in  std_logic; -- clock enable (active high)
      reset    : in  std_logic; -- reset (active high)
      din      : in  std_logic; -- data in
      dout     : out std_logic  -- data out
    );
  end component register_1b;
  
  --------------------------------------------------------------------
  -- register_n
  --------------------------------------------------------------------
  --    n-bit register with asynchronous reset and clock enable
  -- 
  component register_n is
    generic(
      width : integer := 4
    );
    port(
      core_clk : in  std_logic; -- clock input
      ce       : in  std_logic; -- clock enable (active high)
      reset    : in  std_logic; -- reset (active high)
      din      : in  std_logic_vector((width-1) downto 0);  -- data in (width)-bit
      dout     : out std_logic_vector((width-1) downto 0)   -- data out (width)-bit
    );
  end component register_n;
  
  --------------------------------------------------------------------
  -- cell_1b_adder
  --------------------------------------------------------------------
  --    1-bit full adder cell using combinatorial logic
  --    
  component cell_1b_adder is
    port (
      -- input operands a, b
      a    : in  std_logic;
      b    : in  std_logic;
      -- carry in, out
      cin  : in  std_logic;
      cout : out  std_logic;
      -- result out
      r    : out  std_logic
    );
  end component cell_1b_adder;
  
  --------------------------------------------------------------------
  -- cell_1b_mux
  --------------------------------------------------------------------
  --    1-bit mux for a standard cell in the montgommery multiplier 
  --    systolic array
  -- 
  component cell_1b_mux is
    port (
      -- input bits
      my     : in  std_logic; 
      y      : in  std_logic;
      m      : in  std_logic;
      -- selection bits
      x      : in  std_logic;
      q      : in  std_logic;
      -- mux out
      result : out std_logic
    );
  end component cell_1b_mux;
  
  --------------------------------------------------------------------
  -- cell_1b
  --------------------------------------------------------------------
  --    1-bit cell for the systolic array
  -- 
  component cell_1b is
    port (
      -- operand input bits (m+y, y and m)
      my   : in  std_logic;
      y    : in  std_logic;
      m    : in  std_logic;
      -- operand x input bit and q
      x    : in  std_logic;
      q    : in  std_logic;
      -- previous result input bit
      a    : in  std_logic;
      -- carry's
      cin  : in  std_logic;
      cout : out std_logic;
      -- cell result out
      r    : out std_logic
    );
  end component cell_1b;
  
  --------------------------------------------------------------------
  -- adder_block
  --------------------------------------------------------------------
  --    (width)-bit full adder block using cell_1b_adders with buffered
  --    carry out
  -- 
  component adder_block is
    generic (
      width : integer := 32 --adder operand widths
    );
    port (
      -- clock input
      core_clk : in std_logic; 
      -- adder input operands a, b (width)-bit
      a : in std_logic_vector((width-1) downto 0);
      b : in std_logic_vector((width-1) downto 0);
      -- carry in, out
      cin   : in std_logic;
      cout  : out std_logic;
      -- adder result out (width)-bit
      r : out std_logic_vector((width-1) downto 0) 
    );
  end component adder_block;
  
  --------------------------------------------------------------------
  -- adder_n
  --------------------------------------------------------------------
  --    n-bit adder using adder blocks. works in stages, to prevent 
  --    large carry propagation. 
  --    Result avaiable after (width/block_width) clock cycles
  -- 
  component adder_n is
    generic (
      width       : integer := 1536; -- adder operands width
      block_width : integer := 8     -- adder blocks size
    );
    port (
      -- clock input
      core_clk : in std_logic;  
      -- adder input operands (width)-bit
      a : in std_logic_vector((width-1) downto 0);
      b : in std_logic_vector((width-1) downto 0);
      -- carry in, out
      cin   : in std_logic;
      cout  : out std_logic;
      -- adder output result (width)-bit
      r : out std_logic_vector((width-1) downto 0) 
    );
  end component adder_n;
  
  --------------------------------------------------------------------
  -- standard_cell_block
  --------------------------------------------------------------------
  --    a standard cell block of (width)-bit for the montgommery multiplier 
  --    systolic array
  -- 
  component standard_cell_block is
    generic (
      width : integer := 16
    );
    port (
      -- modulus and y operand input (width)-bit
      my   : in  std_logic_vector((width-1) downto 0);
      y    : in  std_logic_vector((width-1) downto 0);
      m    : in  std_logic_vector((width-1) downto 0);
      -- q and x operand input (serial input)
      x    : in  std_logic;
      q    : in  std_logic;
      -- previous result in (width)-bit
      a    : in  std_logic_vector((width-1) downto 0);
      -- carry in and out
      cin  : in std_logic;
      cout : out std_logic;
      -- result out (width)-bit
      r    : out  std_logic_vector((width-1) downto 0)
    );
  end component standard_cell_block;
  
  --------------------------------------------------------------------
  -- standard_stage
  --------------------------------------------------------------------
  --    standard stage for use in the montgommery multiplier pipeline
  --    the result is available after 1 clock cycle
  -- 
  component standard_stage is
    generic(
      width : integer := 32
    );
    port(
      -- clock input
      core_clk : in  std_logic;
      -- modulus and y operand input (width)-bit
      my       : in  std_logic_vector((width-1) downto 0);
      y        : in  std_logic_vector((width-1) downto 0);
      m        : in  std_logic_vector((width-1) downto 0);
      -- q and x operand input (serial input)
      xin      : in  std_logic;
      qin      : in  std_logic;
      -- q and x operand output (serial output)
      xout     : out std_logic;
      qout     : out std_logic;
      -- msb input (lsb from next stage, for shift right operation)
      a_msb    : in  std_logic;
      -- carry out(clocked) and in
      cin      : in  std_logic;
      cout     : out std_logic;
      -- control singals
      start    : in  std_logic;
      reset    : in  std_logic;
      done : out std_logic;
      -- result out
      r    : out std_logic_vector((width-1) downto 0)
    );
  end component standard_stage;
  
  --------------------------------------------------------------------
  -- first_stage
  --------------------------------------------------------------------
  --    first stage for use in the montgommery multiplier pipeline
  --    generates the q signal for all following stages
  --    the result is available after 1 clock cycle
  -- 
  component first_stage is
    generic(
      width : integer := 16 -- must be the same as width of the standard stage
    );
    port(
      -- clock input
      core_clk : in  std_logic;
      -- modulus and y operand input (width+1)-bit
      my       : in  std_logic_vector((width) downto 0);
      y        : in  std_logic_vector((width) downto 0);
      m        : in  std_logic_vector((width) downto 0);
      -- x operand input (serial input)
      xin      : in  std_logic;
      -- q and x operand output (serial output)
      xout     : out std_logic;
      qout     : out std_logic;
      -- msb input (lsb from next stage, for shift right operation)
      a_msb    : in  std_logic;
      -- carry out
      cout     : out std_logic;
      -- control signals
      start    : in  std_logic;
      reset    : in  std_logic;
      done     : out std_logic;
      -- result out
      r        : out std_logic_vector((width-1) downto 0)
    );
  end component first_stage;
  
  --------------------------------------------------------------------
  -- last_stage
  --------------------------------------------------------------------
  --    last stage for use in the montgommery multiplier pipeline
  --    the result is available after 1 clock cycle
  -- 
  component last_stage is
    generic(
      width : integer := 16 -- must be the same as width of the standard stage
    );
    port(
      -- clock input
      core_clk : in  std_logic;
      -- modulus and y operand input (width(-1))-bit
      my       : in  std_logic_vector((width-1) downto 0);
      y        : in  std_logic_vector((width-2) downto 0);
      m        : in  std_logic_vector((width-2) downto 0);
      -- q and x operand input (serial input)
      xin      : in  std_logic;
      qin      : in  std_logic;
      -- carry in
      cin      : in  std_logic;
      -- control signals
      start    : in  std_logic;
      reset    : in  std_logic;
      -- result out
      r        : out std_logic_vector((width+1) downto 0)
    );
  end component last_stage;
  
  --------------------------------------------------------------------
  -- counter_sync
  --------------------------------------------------------------------
  --    counter with synchronous count enable. It generates an
  --    overflow when max_value is reached
  -- 
  component counter_sync is
    generic(
      max_value : integer := 1024 -- maximum value (constraints the nr bits for counter)
    );
    port(
      reset_value : in integer;   -- value the counter counts to
      core_clk    : in std_logic; -- clock input
      ce          : in std_logic; -- count enable
      reset       : in std_logic; -- reset input
      overflow    : out std_logic -- gets high when counter reaches reset_value
    );
  end component counter_sync;
  
  --------------------------------------------------------------------
  -- stepping_logic
  --------------------------------------------------------------------
  --    stepping logic for the pipeline, generates the start pulses for the
  --    first stage and keeps track of when the last stages are done
  -- 
  component stepping_logic is
    generic(
      n : integer := 1536;  -- max nr of steps required to complete a multiplication
      t : integer := 192    -- total nr of steps in the pipeline
    );
    port(
      core_clk          : in  std_logic;  -- clock input
      start             : in  std_logic;  -- start signal for pipeline (one multiplication)
      reset             : in  std_logic;  -- reset signal
      t_sel             : in integer range 0 to t; -- nr of stages in the pipeline piece
      n_sel             : in integer range 0 to n; -- nr of steps(bits in operands) required for a complete multiplication
      start_first_stage : out std_logic;  -- start pulse output for first stage
      stepping_done     : out std_logic   -- done signal
    );
  end component stepping_logic;

  --------------------------------------------------------------------
  -- x_shift_reg
  --------------------------------------------------------------------
  --    shift register for the x operand of the multiplier
  --    outputs the lsb of the register or bit at offset according to the
  --    selected pipeline part 
  -- 
  component x_shift_reg is
    generic(
      n  : integer := 1536; -- width of the operands (# bits)
      t  : integer := 48;   -- total number of stages
      tl : integer := 16    -- lower number of stages
    );
    port(
      -- clock input
      clk    : in  std_logic;
      -- x operand in (n-bit)
      x_in   : in  std_logic_vector((n-1) downto 0);
      -- control signals
      reset  : in  std_logic; -- reset, clears register
      load_x : in  std_logic; -- load operand into shift register   
      next_x : in  std_logic; -- next bit of x
      p_sel  : in  std_logic_vector(1 downto 0);  -- pipeline selection
      -- x operand bit out (serial)
      xi     : out std_logic  
    );
  end component x_shift_reg;
  
  --------------------------------------------------------------------
  -- systolic_pipeline
  --------------------------------------------------------------------
  --    systolic pipeline implementation of the montgommery multiplier
  --    devides the pipeline into 2 parts, so 3 operand widths are supported
  -- 
  --    p_sel: 
  --      01 = lower part
  --      10 = upper part
  --      11 = full range
  component systolic_pipeline is
    generic(
      n  : integer := 1536; -- width of the operands (# bits)
      t  : integer := 192;  -- total number of stages (divider of n) >= 2
      tl : integer := 64    -- lower number of stages (best take t = sqrt(n))
    );
    port(
      -- clock input
      core_clk : in  std_logic;
      -- modulus and y opperand input (n)-bit
      my       : in  std_logic_vector((n) downto 0); -- m+y
      y        : in  std_logic_vector((n-1) downto 0);
      m        : in  std_logic_vector((n-1) downto 0);
      -- x operand input (serial)
      xi       : in  std_logic;
      -- control signals
      start    : in  std_logic; -- start multiplier
      reset    : in  std_logic;
      p_sel    : in  std_logic_vector(1 downto 0); -- select which piece of the multiplier will be used
      ready    : out std_logic; -- multiplication ready
      next_x   : out std_logic; -- next x operand bit
      -- result out
      r        : out std_logic_vector((n+1) downto 0)
    );
  end component systolic_pipeline;
  
  --------------------------------------------------------------------
  -- mont_mult_sys_pipeline
  --------------------------------------------------------------------
  -- Structural description of the montgommery multiply pipeline
  -- contains the x operand shift register, my adder, the pipeline and 
  -- reduction adder. To do a multiplication, the following actions must take place:
  -- 
  --    * load in the x operand in the shift register using the xy bus and load_x
  --    * place the y operand on the xy bus for the rest of the operation
  --    * generate a start pulse of 1 clk cycle long on start
  --    * wait for ready signal
  --    * result is avaiable on the r bus
  -- 
  component mont_mult_sys_pipeline is
    generic (
      n          : integer := 1536; -- width of the operands
      nr_stages  : integer := 96; -- total number of stages
      stages_low : integer := 32  -- lower number of stages
    );
    port (
      -- clock input
      core_clk : in std_logic;
      -- operand inputs
      xy       : in std_logic_vector((n-1) downto 0); -- bus for x or y operand
      m        : in std_logic_vector((n-1) downto 0); -- modulus
      -- result output
      r        : out std_logic_vector((n-1) downto 0);  -- result
      -- control signals
      start    : in std_logic;
      reset    : in std_logic;
      p_sel    : in std_logic_vector(1 downto 0);
      load_x   : in std_logic;
      ready    : out std_logic
    );
  end component mont_mult_sys_pipeline;

  --------------------------------------------------------------------
  -- mod_sim_exp_core
  --------------------------------------------------------------------
  --    toplevel of the modular simultaneous exponentiation core
  --    contains an operand and modulus ram, multiplier, an exponent fifo
  --    and control logic
  -- 
  component mod_sim_exp_core is
    port(
      clk   : in  std_logic;
      reset : in  std_logic;
        -- operand memory interface (plb shared memory)
      write_enable : in  std_logic; -- write data to operand ram
      data_in      : in  std_logic_vector (31 downto 0);  -- operand ram data in
      rw_address   : in  std_logic_vector (8 downto 0);   -- operand ram address bus
      data_out     : out std_logic_vector (31 downto 0);  -- operand ram data out
      collision    : out std_logic; -- write collision
        -- op_sel fifo interface
      fifo_din    : in  std_logic_vector (31 downto 0); -- exponent fifo data in
      fifo_push   : in  std_logic;  -- push data in exponent fifo
      fifo_full   : out std_logic;  -- high if fifo is full
      fifo_nopush : out std_logic;  -- high if error during push
        -- control signals
      start          : in  std_logic; -- start multiplication/exponentiation
      run_auto       : in  std_logic; -- single multiplication if low, exponentiation if high
      ready          : out std_logic; -- calculations done
      x_sel_single   : in  std_logic_vector (1 downto 0); -- single multiplication x operand selection
      y_sel_single   : in  std_logic_vector (1 downto 0); -- single multiplication y operand selection
      dest_op_single : in  std_logic_vector (1 downto 0); -- result destination operand selection
      p_sel          : in  std_logic_vector (1 downto 0); -- pipeline part selection
      calc_time      : out std_logic
    );
  end component mod_sim_exp_core;

  component autorun_cntrl is
    port (
      clk              : in  std_logic;
      reset            : in  std_logic;
      start            : in  std_logic;
      done             : out  std_logic;
      op_sel           : out  std_logic_vector (1 downto 0);
      start_multiplier : out  std_logic;
      multiplier_done  : in  std_logic;
      read_buffer      : out  std_logic;
      buffer_din       : in  std_logic_vector (31 downto 0);
      buffer_empty     : in  std_logic
    );
  end component autorun_cntrl;
  
  component fifo_primitive is
    port (
      clk    : in  std_logic;
      din    : in  std_logic_vector (31 downto 0);
      dout   : out  std_logic_vector (31 downto 0);
      empty  : out  std_logic;
      full   : out  std_logic;
      push   : in  std_logic;
      pop    : in  std_logic;
      reset  : in std_logic;
      nopop  : out std_logic;
      nopush : out std_logic
    );
  end component fifo_primitive;
  
  component modulus_ram is
    port(
      clk           : in std_logic;
      modulus_addr  : in std_logic_vector(5 downto 0);
      write_modulus : in std_logic;
      modulus_in    : in std_logic_vector(31 downto 0);
      modulus_out   : out std_logic_vector(1535 downto 0)
    );
  end component modulus_ram;
  
  component mont_ctrl is
    port (
      clk   : in std_logic;
      reset : in std_logic;
        -- bus side
      start           : in std_logic;
      x_sel_single    : in std_logic_vector(1 downto 0);
      y_sel_single    : in std_logic_vector(1 downto 0);
      run_auto        : in std_logic;
      op_buffer_empty : in std_logic;
      op_sel_buffer   : in std_logic_vector(31 downto 0);
      read_buffer     : out std_logic;
      buffer_noread   : in std_logic;
      done            : out std_logic;
      calc_time       : out std_logic;
        -- multiplier side
      op_sel           : out std_logic_vector(1 downto 0);
      load_x           : out std_logic;
      load_result      : out std_logic;
      start_multiplier : out std_logic;
      multiplier_ready : in std_logic
    );
  end component mont_ctrl;
  
  component operand_dp is
    port (
      clka  : in std_logic;
      wea   : in std_logic_vector(0 downto 0);
      addra : in std_logic_vector(5 downto 0);
      dina  : in std_logic_vector(31 downto 0);
      douta : out std_logic_vector(511 downto 0);
      clkb  : in std_logic;
      web   : in std_logic_vector(0 downto 0);
      addrb : in std_logic_vector(5 downto 0);
      dinb  : in std_logic_vector(511 downto 0);
      doutb : out std_logic_vector(31 downto 0)
    );
  end component operand_dp;
  
  component operand_mem is
    generic(n : integer := 1536
    );
    port(
        -- data interface (plb side)
      data_in    : in  std_logic_vector(31 downto 0);
      data_out   : out  std_logic_vector(31 downto 0);
      rw_address : in  std_logic_vector(8 downto 0);
        -- address structure:
        -- bit:  8   -> '1': modulus
        --              '0': operands
        -- bits: 7-6 -> operand_in_sel in case of bit 8 = '0'
        --              don't care in case of modulus
        -- bits: 5-0 -> modulus_addr / operand_addr resp.
  
        -- operand interface (multiplier side)
      op_sel    : in  std_logic_vector(1 downto 0);
      xy_out    : out  std_logic_vector(1535 downto 0);
      m         : out  std_logic_vector(1535 downto 0);
      result_in : in std_logic_vector(1535 downto 0);
        -- control signals
      load_op        : in std_logic;
      load_m         : in std_logic;
      load_result    : in std_logic;
      result_dest_op : in std_logic_vector(1 downto 0);
      collision      : out std_logic;
        -- system clock
      clk : in  std_logic
    );
  end component operand_mem;
  
  component operand_ram is
    port( -- write_operand_ack voorzien?
      -- global ports
      clk       : in std_logic;
      collision : out std_logic;
      -- bus side connections (32-bit serial)
      operand_addr   : in std_logic_vector(5 downto 0);
      operand_in     : in std_logic_vector(31 downto 0);
      operand_in_sel : in std_logic_vector(1 downto 0);
      result_out     : out std_logic_vector(31 downto 0);
      write_operand  : in std_logic;
      -- multiplier side connections (1536 bit parallel)
      result_dest_op  : in std_logic_vector(1 downto 0);
      operand_out     : out std_logic_vector(1535 downto 0);
      operand_out_sel : in std_logic_vector(1 downto 0); -- controlled by bus side
      write_result    : in std_logic;
      result_in       : in std_logic_vector(1535 downto 0)
    );
  end component operand_ram;
  
  component operands_sp is
    port (
      clka  : in std_logic;
      wea   : in std_logic_vector(0 downto 0);
      addra : in std_logic_vector(4 downto 0);
      dina  : in std_logic_vector(31 downto 0);
      douta : out std_logic_vector(511 downto 0)
    );
  end component operands_sp;
  
end package mod_sim_exp_pkg;