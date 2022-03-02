-------------------------------------------------------------------------------
-- Title      : Testbench for design "ann". XOR solving neural network.
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ann_tb.vhd
-- Author     : Jurek Stefanowicz
-- Company    : 
-- Created    : 2016-09-30
-- Last update: 2016-09-30
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2016
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library std;
use std.textio.all;

library work;
use work.layers_pkg.all;
use work.support_pkg.all;

-------------------------------------------------------------------------------

entity ann_tb is
end ann_tb;

-------------------------------------------------------------------------------

architecture beh1 of ann_tb is
  
  -- testbech signals
  signal end_sim : boolean := false;

  file data_out        : text open write_mode is "data_out_tb.txt";
  file data_in         : text open read_mode is "data_in.txt";

  signal reset   : std_logic := '1';
  signal clk     : std_logic := '1';

  -- ann input sigs
  signal run_in  : std_logic := '0'; -- Start and input data validation
  signal inputs  : std_logic_vector(Nbit-1 downto 0) := (others => '0'); -- Input data

  -- weight&bias memory interface (not used)
  signal wdata   : std_logic_vector(NbitW-1 downto 0) := (others => '0');  -- Weight and bias memory write data
  signal addr    : std_logic_vector((calculate_addr_l(NumIn, NumN, Nlayer)+log2(Nlayer))-1 downto 0) := (others => '0'); -- Weight and bias memory address
  signal m_en    : std_logic := '0'; -- Weight and bias memory enable (external interface)
  signal m_we    : std_logic_vector(((NbitW+7)/8)-1 downto 0) := (others => '0');

  signal run_out : std_logic; -- Output data validation
  signal rdata   : std_logic_vector(NbitW-1 downto 0);  -- Weight and bias memory read data
  signal outputs : std_logic_vector(Nbit-1 downto 0); -- Output data
      

begin
  -- component instantiation
  ann0 : entity work.ann
    generic map (
      WBinit   => true, 
      Nlayer   => Nlayer,
      NbitW    => NbitW,
      NumIn    => NumIn,  
      NbitIn   => Nbit,
      NumN     => NumN,
      l_type   => l_type,
      f_type   => f_type,
      LSbit    => LSbit,
      NbitO    => NbitO,
      NbitOut  => NbitOut)
    port map (
      -- in
      reset    => reset,
      clk      => clk,
      run_in   => run_in,
      m_en     => m_en,
      m_we     => m_we,
      inputs   => inputs,
      wdata    => wdata,
      addr     => addr,
      -- out
      run_out  => run_out,
      rdata    => rdata,
      outputs  => outputs
    );
  -- clock generation
  Clk <= not Clk after 10 ns when end_sim = false else '0';

  -- xor wieghts:
  -- layer0:                          addresses:
  -- weights:                         layer bias  neuron input     
  --   neuron 1, input 1 : -3.7596     0     0     0      0  
  --   neuron 1, input 2 :  3.0396     0     0     0      1   
  --   neuron 2, input 1 :  2.3740     0     0     1      0    
  --   neuron 2, input 2 : -2.1895     0     0     1      1    
  -- bias:                            layer bias    x   neuron       
  --   neuron 1 : 2.20762               0     1     0      0              
  --   neuron 2 : 0.96043               0     1     0      1                
  -- layer1:                                
  -- weights:                         layer bias  neuron input            
  --   neuron 1, input 1 :  -2.2381     1     0     0      0                               
  --   neuron 1, input 2 :  -2.2888     1     0     0      1                                 
  -- bias:                            layer bias    x   neuron    
  --   neuron 1: 3.8896                 1     1     0      0              
  --

  DataSave : process(Clk)
    variable my_line : line;  -- type 'line' comes from textio
  begin
    if (Clk'event and Clk = '1' ) then
      if ( run_out = '1') then
        write(my_line,  to_integer(signed(outputs)));   
        writeline(data_out, my_line);             
      end if;
    end if;
  end process;

  DataLoad : process
    variable input_line  : line;
    variable din         : real;
  begin
    wait for 20 ns;
    reset <= '0';  
    wait until clk = '0';
    wait until clk = '1';
    wait until clk = '0';
    wait until clk = '1';

    l1 : while not end_sim loop
      if not endfile(data_in) then
        readline(data_in, input_line);
        read(input_line, din);
      else      
        end_sim <= true;    
        exit l1;
      end if;
      run_in <= '1';
      inputs  <= std_logic_vector(to_signed(integer(din*(2.0**LSB_In)),NbitIn));

      wait until clk = '0';
      wait until clk = '1';
      run_in <= '0';
      
      -- We wait 4 clock cycles between run_ins because
      -- the network has a maximum layers size of 3 neurons

      wait until clk = '0';
      wait until clk = '1';
      
      wait until clk = '0';
      wait until clk = '1';

      wait until clk = '0';
      wait until clk = '1';

      --wait until clk = '0';
      --wait until clk = '1';

    end loop l1;
    wait ;
  end process;

end beh1;


