---------------------------------------------------------------------
--	Filename:	yanu.vhd
--
--			
--	Description:
--		YANU: an Asynchronous UART with Altera Avalon Interface 
--              
--	Copyright (c) 2009 by Renato Andreola (Imagos sas)
--
--	This file is part of YANU.
--	YANU is free software: you can redistribute it and/or modify
--	it under the terms of the GNU Lesser General Public License as published by
--	the Free Software Foundation, either version 3 of the License, or
--	(at your option) any later version.
--	YANU is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--	GNU Lesser General Public License for more details.
--
--	You should have received a copy of the GNU Lesser General Public License
--	along with YANU.  If not, see <http://www.gnu.org/licenses/>.
--	
--	Revision	History:
--	Revision	Date      	Author   	Comment
--	--------	----------	---------	-----------
--	1.0     	30/05/2009	Renato Andreola	Initial revision
--	
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Top-level Avalon slave interface entity
entity yanu is
  generic
    (
      USE_RAM : string := "ON"          -- can be "ON" or "OFF" to enable use of FPGA ram (ff's otherwise)
      );
  port
    (
      -- avalon port
      csi_yanuc_clk,
      avs_yanu_read, avs_yanu_write,
      avs_yanu_begintransfer, csi_yanuc_reset : in  std_logic;
      avs_yanu_address                       : in  std_logic_vector(2 downto 0);
      avs_yanu_readdata                      : out std_logic_vector(31 downto 0);
      avs_yanu_writedata                     : in  std_logic_vector(31 downto 0);
      avs_yanu_waitrequest                   : out std_logic;
      ins_yanui_irq                           : out std_logic;

      -- device i/o ports
      coe_txd : out std_logic;
      coe_rxd : in  std_logic;
      coe_cts : out std_logic;
      coe_rts : in  std_logic
      );
end yanu;


architecture arch_yanu of yanu is
  -- rename signals
  alias clk           : std_logic is csi_yanuc_clk;
  alias read          : std_logic is avs_yanu_read;
  alias write         : std_logic is avs_yanu_write;
  alias begintransfer : std_logic is avs_yanu_begintransfer;
  alias reset         : std_logic is csi_yanuc_reset;
  alias address       : std_logic_vector(2 downto 0) is avs_yanu_address;
  alias readdata      : std_logic_vector(31 downto 0) is avs_yanu_readdata;
  alias writedata     : std_logic_vector(31 downto 0) is avs_yanu_writedata;
  alias waitrequest   : std_logic is avs_yanu_waitrequest;
  alias irq           : std_logic is ins_yanui_irq;
  alias txd           : std_logic is coe_txd;
  alias rxd           : std_logic is coe_rxd;
  alias cts           : std_logic is coe_cts;
  alias rts           : std_logic is coe_rts;


  -- internal signals with "right" polarity and their "invert" polarity flags 
  signal itxd, irxd, irts, icts                         : std_logic;
  signal invert_txd, invert_rxd, invert_rts, invert_cts : std_logic;

  -- Avalon bus activity in progress state machine
  type   reg_state_type is (Q_idle, Q_data, Q_config, Q_trigger, Q_status);
  signal reg_next_state, reg_current_state : reg_state_type := Q_idle;

  -- Avalon implementation signals
  signal waitrq, waitrq_in : std_logic := '1';  -- wait request ff

  -- prescaler interconnection ports
  signal tick : std_logic;

  ----------------------------------------------------------------------------------------------------------------------
  -- transmitter/receiver block ports
  signal bits          : std_logic_vector(2 downto 0);
  signal parity_enable : std_logic;
  signal parity_even   : std_logic;
  signal stops         : std_logic;
  signal iepe          : std_logic;
  signal iefe          : std_logic;
  signal iebrk         : std_logic;
  signal ieoe          : std_logic;
  signal ierrdy        : std_logic;
  signal rdy_delay     : std_logic_vector(7 downto 0);
  signal tdata         : std_logic_vector(7 downto 0);
  signal tfifo_thr     : std_logic_vector(3 downto 0);
  signal ietrdy        : std_logic;
  signal hhena         : std_logic;
  signal forcebrk      : std_logic;

  -- "action" pulses
  signal rpe, spe     : std_logic;
  signal rfe, sfe     : std_logic;
  signal rbrk, sbrk   : std_logic;
  signal roe, soe     : std_logic;
  signal rrrdy, srrdy : std_logic;
  signal rfifo_pull   : std_logic;
  signal rfifo_clear  : std_logic;
  signal tdata_push   : std_logic;
  signal tfifo_clr    : std_logic;
  signal strdy        : std_logic;
  signal rtrdy        : std_logic;

  -- read only signals
  signal pe          : std_logic;
  signal fe          : std_logic;
  signal brk         : std_logic;
  signal oe          : std_logic;
  signal rrdy        : std_logic;
  signal rdata       : std_logic_vector(7 downto 0);
  signal rfifo_chars : std_logic_vector(4 downto 0);
  signal rirq        : std_logic;
  signal trdy        : std_logic;
  signal tirq        : std_logic;
  signal tfifo_chars : std_logic_vector(4 downto 0);

  -- Read/Write control registers
  signal creg, creg_in       : std_logic_vector(29 downto 0) := (others => '0');
  signal baudreg, baudreg_in : std_logic_vector(15 downto 0) := (others => '0');

  ----------------------------------------------------------------------------------------------------------------------
  -- used components: prescaler, rxcore, txcore

  component fprescal is
    generic (
      NMANTISSA : integer;
      NEXP      : integer);
    port (
      clk, reset : in  std_logic;
      divisor    : in  std_logic_vector(NEXP+NMANTISSA-1 downto 0);
      output     : out std_logic);
  end component fprescal;

  component rxcore
    generic (
      USE_EAB : string);
    port (
      clk, reset    : in  std_logic;
      rx            : in  std_logic;
      tick          : in  std_logic;
      bits          : in  std_logic_vector(2 downto 0);
      parity_enable : in  std_logic;
      parity_even   : in  std_logic;
      data          : out std_logic_vector(7 downto 0);
      pe            : out std_logic;
      rpe, spe      : in  std_logic;
      ipe           : in  std_logic;
      fe            : out std_logic;
      rfe, sfe      : in  std_logic;
      ife           : in  std_logic;
      brk           : out std_logic;
      rbrk, sbrk    : in  std_logic;
      ibrk          : in  std_logic;
      rdy           : out std_logic;
      rrdy, srdy    : in  std_logic;
      irdy          : in  std_logic;
      fifo_pull     : in  std_logic;
      fifo_clear    : in  std_logic;
      fifo_chars    : out std_logic_vector(4 downto 0);
      rdy_delay     : in  std_logic_vector(7 downto 0);
      oe            : out std_logic;
      roe, soe      : in  std_logic;
      ioe           : in  std_logic;
      irq           : out std_logic);
  end component;

  component txcore
    generic (
      USE_EAB : string); 
    port (
      clk, reset    : in  std_logic;
      tick          : in  std_logic;
      bits          : in  std_logic_vector(2 downto 0);
      stops         : in  std_logic;
      parity_enable : in  std_logic;
      parity_even   : in  std_logic;
      data          : in  std_logic_vector(7 downto 0);
      data_push     : in  std_logic;
      fifo_thr      : in  std_logic_vector(3 downto 0);
      tx            : out std_logic;
      irq           : out std_logic;
      iflag         : out std_logic;
      fifo_words    : out std_logic_vector(4 downto 0);
      fifo_clr      : in  std_logic;
      if_set        : in  std_logic;
      if_clear      : in  std_logic;
      ie            : in  std_logic;
      forcebrk      : in  std_logic;
      hhena         : in  std_logic;
      rts           : in  std_logic);
  end component;

  -- constant sources...
  signal zeros : std_logic_vector(31 downto 0) := (others => '0');
  signal ones  : std_logic_vector(31 downto 0) := (others => '1');
  
begin
  -- prescaler: generates the "tick" event (8 ticks per bit).
  fprescal_1 : fprescal
    generic map (
      NMANTISSA => 12,
      NEXP      => 4)
    port map (
      clk     => clk,
      reset   => reset,
      divisor => baudreg,
      output  => tick);

  -- reception core, convert rxd to parallel data to be put into a 16 word fifo
  rxcore_1 : rxcore
    generic map (
      USE_EAB => USE_RAM)
    port map (
      clk           => clk,
      reset         => reset,
      rx            => irxd,
      tick          => tick,
      bits          => bits,
      parity_enable => parity_enable,
      parity_even   => parity_even,
      data          => rdata,
      pe            => pe,
      rpe           => rpe,
      spe           => spe,
      ipe           => iepe,
      fe            => fe,
      rfe           => rfe,
      sfe           => sfe,
      ife           => iefe,
      brk           => brk,
      rbrk          => rbrk,
      sbrk          => sbrk,
      ibrk          => iebrk,
      rdy           => rrdy,
      rrdy          => rrrdy,
      srdy          => srrdy,
      irdy          => ierrdy,
      fifo_pull     => rfifo_pull,
      fifo_clear    => rfifo_clear,
      fifo_chars    => rfifo_chars,
      rdy_delay     => rdy_delay,
      oe            => oe,
      roe           => roe,
      soe           => soe,
      ioe           => ieoe,
      irq           => rirq
      );

  -- transmission core: convert parallel data from fifo to txd...
  txcore_1 : txcore
    generic map (
      USE_EAB => USE_RAM)
    port map (
      clk           => clk,
      reset         => reset,
      tick          => tick,
      bits          => bits,
      stops         => stops,
      parity_enable => parity_enable,
      parity_even   => parity_even,
      data          => writedata(7 downto 0),
      data_push     => tdata_push,
      fifo_thr      => tfifo_thr,
      tx            => itxd,
      irq           => tirq,
      iflag         => trdy,
      fifo_words    => tfifo_chars,
      fifo_clr      => tfifo_clr,
      if_set        => strdy,
      if_clear      => rtrdy,
      ie            => ietrdy,
      forcebrk      => forcebrk,
      hhena         => hhena,
      rts           => irts
      );

  -- Implement the combinatorial logic of the Avalon interface and the next state function
  yanu_cp : process (address, baudreg, begintransfer, brk, creg, fe, hhena, icts, invert_cts, invert_rts, invert_rxd,
                     invert_txd, itxd, oe, pe, rdata, read, reg_current_state, rfifo_chars, rirq, rrdy, rts, rxd,
                     tfifo_chars, tirq, trdy, waitrq, write, writedata, zeros) is
  begin  -- process yanu_cp
    -- read data multiplexer with "low noise" switching logic
    readdata <= (others => '0');
    if (read = '1') then
      case address is
        when b"000" =>                  -- Add = 0 -> rx_data fifo port
          readdata <= zeros(31 downto 8) & rdata;
        when b"001" =>                  -- Add = 1 -> control register
          readdata <= zeros(31 downto creg'length) & creg;
        when b"010" =>                  -- Add = 2 -> baud register
          readdata <= zeros(31 downto baudreg'length) & baudreg;
        when b"100" =>                  -- Add = 4 -> status register 
          readdata <= zeros(31 downto 16) & tfifo_chars & rfifo_chars & pe & fe & brk & oe & trdy & rrdy;
        when b"101" =>                  -- Add = 5 -> magic register 
          readdata <= x"756e6179";
        when others =>
          null;
      end case;
    end if;

    -- next state function
    reg_next_state <= reg_current_state;
    waitrq_in      <= '1';
    case reg_current_state is
      when Q_idle =>
        if (begintransfer and (read or write)) = '1' then
          waitrq_in <= '0';
          case address is
            when b"000" =>              -- Add = 0 -> data register
              reg_next_state <= Q_data;
            when b"001" | b"010" =>     -- Add = 1..2 -> configuration
              reg_next_state <= Q_config;
            when b"011" =>              -- Add = 3 -> action!
              reg_next_state <= Q_trigger;
            when others =>              -- others -> status
              reg_next_state <= Q_status;
          end case;
        end if;
      when others =>
        reg_next_state <= Q_idle;
    end case;

    -- configuration registers update logic
    creg_in    <= creg;
    baudreg_in <= baudreg;
    if (write = '1') and (reg_current_state = Q_config) then
      case address is
        when b"001" =>                  -- write to creg
          creg_in <= writedata(creg_in'length -1 downto 0);
        when b"010" =>                  -- write to baudreg
          baudreg_in <= writedata(baudreg_in'length -1 downto 0);
        when others => null;
      end case;
    end if;

    -- connect configuration registers to single bits...
    ierrdy        <= creg(0);
    ieoe          <= creg(1);
    iebrk         <= creg(2);
    iefe          <= creg(3);
    iepe          <= creg(4);
    ietrdy        <= creg(5);
    bits          <= creg(8 downto 6);
    parity_enable <= creg(9);
    parity_even   <= creg(10);
    stops         <= creg(11);
    hhena         <= creg(12);
    forcebrk      <= creg(13);
    rdy_delay     <= creg(21 downto 14);
    tfifo_thr     <= creg(25 downto 22);
    invert_rxd    <= creg(26);
    invert_txd    <= creg(27);
    invert_rts    <= creg(28);
    invert_cts    <= creg(29);

    -- connect "trigger" bits
    rpe         <= '0';
    spe         <= '0';
    rfe         <= '0';
    sfe         <= '0';
    rbrk        <= '0';
    sbrk        <= '0';
    roe         <= '0';
    soe         <= '0';
    rrrdy       <= '0';
    srrdy       <= '0';
    rfifo_pull  <= '0';
    rfifo_clear <= '0';
    tdata_push  <= '0';
    tfifo_clr   <= '0';
    rtrdy       <= '0';
    strdy       <= '0';
    if (reg_current_state = Q_trigger) and (write = '1') then
      rrrdy       <= writedata(0);
      roe         <= writedata(1);
      rbrk        <= writedata(2);
      rfe         <= writedata(3);
      rpe         <= writedata(4);
      srrdy       <= writedata(5);
      soe         <= writedata(6);
      sbrk        <= writedata(7);
      sfe         <= writedata(8);
      spe         <= writedata(9);
      rfifo_pull  <= writedata(10);
      rfifo_clear <= writedata(11);
      tfifo_clr   <= writedata(12);
      rtrdy       <= writedata(13);
      strdy       <= writedata(14);
    end if;

    -- tx fifo push: a write to data register
    tdata_push <= '0';
    if (reg_current_state = Q_data) and (write = '1') then
      tdata_push <= '1';
    end if;

    -- cts: reflects rrdy flag! -> when the receiver is not ready the "remote" transmitter is enabled
    icts <= not rrdy;

    -- avalon waitrequest
    waitrequest <= waitrq;

    -- avalon interrupt request
    irq <= rirq or tirq;

    -- signals polarity
    irxd <= rxd xor invert_rxd;
    txd  <= itxd xor invert_txd;
    irts <= (not rts) xor invert_rts;
    cts  <= not ((icts or not hhena) xor invert_cts);
  end process yanu_cp;

  -- yanu register update logic
  yanu_sp : process (clk) is
  begin  -- process yanu_sp
    if rising_edge(clk) then
      creg              <= creg_in;
      baudreg           <= baudreg_in;
      reg_current_state <= reg_next_state;
      waitrq            <= waitrq_in;
    end if;
  end process yanu_sp;
end arch_yanu;

