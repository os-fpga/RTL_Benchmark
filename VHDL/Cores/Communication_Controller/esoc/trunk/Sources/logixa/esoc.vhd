--------------------------------------------------------------------------------
--
-- This VHDL file was generated by EASE/HDL 7.4 Revision 4 from HDL Works B.V.
--
-- Ease library  : work
-- HDL library   : work
-- Host name     : S212065
-- User name     : df768
-- Time stamp    : Tue Aug 19 08:05:18 2014
--
-- Designed by   : L.Maarsen
-- Company       : LogiXA
-- Project info  : eSoC
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Object        : Entity work.esoc
-- Last modified : Mon Apr 14 12:48:20 2014.
--------------------------------------------------------------------------------



library ieee, std, work;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all;
use work.package_esoc_configuration.all;

entity esoc is
  port(
    esoc_address       : in     std_logic_vector(15 downto 0);
    esoc_areset        : in     std_logic;
    esoc_boot_complete : out    std_logic;
    esoc_clk           : in     std_logic;
    esoc_cs            : in     std_logic;
    esoc_data          : inout  std_logic_vector(31 downto 0);
    esoc_mdc           : out    std_logic_vector(esoc_port_count-1 downto 0);
    esoc_mdio          : inout  std_logic_vector(esoc_port_count-1 downto 0);
    esoc_rd            : in     std_logic;
    esoc_rgmii_rxc     : in     std_logic_vector(esoc_port_count-1 downto 0);
    esoc_rgmii_rxctl   : in     std_logic_vector(esoc_port_count-1 downto 0);
    esoc_rgmii_rxd     : in     std_logic_vector(3+4*(esoc_port_count-1) downto 0);
    esoc_rgmii_txc     : out    std_logic_vector(esoc_port_count-1 downto 0);
    esoc_rgmii_txctl   : out    std_logic_vector(esoc_port_count-1 downto 0);
    esoc_rgmii_txd     : out    std_logic_vector(3+4*(esoc_port_count-1) downto 0);
    esoc_wait          : out    std_logic;
    esoc_wr            : in     std_logic);
end entity esoc;

--------------------------------------------------------------------------------
-- Object        : Architecture work.esoc.structure
-- Last modified : Mon Apr 14 12:48:20 2014.
--------------------------------------------------------------------------------

architecture structure of esoc is

  signal clk_control         : std_logic;
  signal reset               : std_logic;
  signal clk_search          : STD_LOGIC;
  signal clk_data            : STD_LOGIC;
  signal data_req            : std_logic_vector(esoc_port_count-1 downto 0);
  signal data_gnt_wr         : std_logic_vector(esoc_port_count-1 downto 0);
  signal data_sof            : std_logic;
  signal data_eof            : std_logic;
  signal data                : std_logic_vector(63 downto 0);
  signal clk_rgmii_125m      : STD_LOGIC;
  signal clk_rgmii_25m       : STD_LOGIC;
  signal clk_rgmii_2m5       : STD_LOGIC;
  signal data_gnt_rd         : std_logic_vector(esoc_port_count-1 downto 0);
  signal ctrl_wait           : std_logic;
  signal ctrl_rddata         : std_logic_vector(31 downto 0);
  signal ctrl_rd             : std_logic;
  signal ctrl_wrdata         : std_logic_vector(31 downto 0);
  signal ctrl_wr             : std_logic;
  signal ctrl_address        : std_logic_vector(15 downto 0);
  signal search_req          : std_logic_vector(esoc_port_count-1 downto 0);
  signal search_sof          : std_logic;
  signal search_key          : std_logic_vector(63 downto 0);
  signal search_gnt_wr       : std_logic_vector(esoc_port_count-1 downto 0);
  signal search_eof          : std_logic;
  signal search_result_av    : std_logic;
  signal search_result       : std_logic_vector(esoc_port_count-1 downto 0);
  signal data_port_sel       : std_logic_vector(esoc_port_count-1 downto 0);
  signal search_port_stalled : std_logic_vector(esoc_port_count-1 downto 0);
  signal pll1_locked         : STD_LOGIC;
  signal pll2_locked         : STD_LOGIC;
  signal ctrl_brom_rd        : std_logic;
  signal ctrl_brom_address   : std_logic_vector(10 downto 0);
  signal q                   : STD_LOGIC_VECTOR(31 downto 0);

  component esoc_port
    generic(
      esoc_port_nr : integer := 0);
    port(
      clk_control         : in     std_logic;
      clk_data            : in     std_logic;
      clk_rgmii_125m      : in     STD_LOGIC;
      clk_rgmii_25m       : in     STD_LOGIC;
      clk_rgmii_2m5       : in     STD_LOGIC;
      clk_search          : in     std_logic;
      ctrl_address        : in     std_logic_vector(15 downto 0);
      ctrl_rd             : in     std_logic;
      ctrl_rddata         : out    std_logic_vector(31 downto 0);
      ctrl_wait           : out    std_logic;
      ctrl_wr             : in     std_logic;
      ctrl_wrdata         : in     std_logic_vector(31 downto 0);
      data                : inout  std_logic_vector(63 downto 0);
      data_eof            : inout  std_logic;
      data_gnt_rd         : in     std_logic;
      data_gnt_wr         : in     std_logic;
      data_port_sel       : inout  std_logic_vector(esoc_port_count-1 downto 0);
      data_req            : out    std_logic;
      data_sof            : inout  std_logic;
      mdc                 : out    std_logic;
      mdio                : inout  std_logic;
      reset               : in     std_logic;
      rgmii_rxc           : in     std_logic;
      rgmii_rxctl         : in     std_logic;
      rgmii_rxd           : in     std_logic_vector(3 downto 0);
      rgmii_txc           : out    std_logic;
      rgmii_txctl         : out    std_logic;
      rgmii_txd           : out    std_logic_vector(3 downto 0);
      search_eof          : out    std_logic;
      search_gnt_wr       : in     std_logic;
      search_key          : out    std_logic_vector(63 downto 0);
      search_port_stalled : out    std_logic;
      search_req          : out    std_logic;
      search_result       : in     std_logic_vector(esoc_port_count-1 downto 0);
      search_result_av    : in     std_logic;
      search_sof          : out    std_logic);
  end component esoc_port;

  component esoc_control
    port(
      brom_address       : out    std_logic_vector(10 downto 0);
      brom_rd            : out    std_logic;
      brom_rddata        : in     std_logic_vector(31 downto 0);
      clk_control        : in     std_logic;
      ctrl_address       : out    std_logic_vector(15 downto 0);
      ctrl_rd            : out    std_logic;
      ctrl_rddata        : in     std_logic_vector(31 downto 0);
      ctrl_wait          : in     std_logic;
      ctrl_wr            : out    std_logic;
      ctrl_wrdata        : out    std_logic_vector(31 downto 0);
      esoc_address       : in     std_logic_vector(15 downto 0);
      esoc_boot_complete : out    std_logic;
      esoc_cs            : in     std_logic;
      esoc_data          : inout  std_logic_vector(31 downto 0);
      esoc_rd            : in     std_logic;
      esoc_wait          : out    std_logic;
      esoc_wr            : in     std_logic;
      pll1_locked        : in     STD_LOGIC;
      pll2_locked        : in     STD_LOGIC;
      reset              : in     std_logic);
  end component esoc_control;

  component esoc_reset
    port(
      clk_control : in     std_logic;
      esoc_areset : in     std_logic;
      pll1_locked : in     STD_LOGIC;
      pll2_locked : in     STD_LOGIC;
      reset       : out    std_logic);
  end component esoc_reset;

  component esoc_bus_arbiter
    generic(
      id : integer := 0);
    port(
      bus_eof      : in     std_logic;
      bus_gnt_rd   : out    std_logic_vector(esoc_port_count-1 downto 0);
      bus_gnt_wr   : out    std_logic_vector(esoc_port_count-1 downto 0);
      bus_req      : in     std_logic_vector(esoc_port_count-1 downto 0);
      bus_sof      : in     std_logic;
      clk_bus      : in     std_logic;
      clk_control  : in     std_logic;
      ctrl_address : in     std_logic_vector(15 downto 0);
      ctrl_rd      : in     std_logic;
      ctrl_rddata  : out    std_logic_vector(31 downto 0);
      ctrl_wait    : out    std_logic;
      ctrl_wr      : in     std_logic;
      ctrl_wrdata  : in     std_logic_vector(31 downto 0);
      reset        : in     std_logic);
  end component esoc_bus_arbiter;

  component esoc_search_engine
    port(
      clk_control         : in     std_logic;
      clk_search          : in     std_logic;
      ctrl_address        : in     std_logic_vector(15 downto 0);
      ctrl_rd             : in     std_logic;
      ctrl_rddata         : out    std_logic_vector(31 downto 0);
      ctrl_wait           : out    std_logic;
      ctrl_wr             : in     std_logic;
      ctrl_wrdata         : in     std_logic_vector(31 downto 0);
      reset               : in     std_logic;
      search_eof          : in     std_logic;
      search_key          : in     std_logic_vector(63 downto 0);
      search_port_stalled : in     std_logic_vector(esoc_port_count-1 downto 0);
      search_result       : out    std_logic_vector(esoc_port_count-1 downto 0);
      search_result_av    : out    std_logic;
      search_sof          : in     std_logic);
  end component esoc_search_engine;

  component esoc_pll1_c3
    port(
      inclk0 : in     STD_LOGIC := '0';
      c0     : out    STD_LOGIC;
      c1     : out    STD_LOGIC;
      c2     : out    STD_LOGIC;
      locked : out    STD_LOGIC);
  end component esoc_pll1_c3;

  component esoc_pll2_c3
    port(
      inclk0 : in     STD_LOGIC := '0';
      c0     : out    STD_LOGIC;
      locked : out    STD_LOGIC;
      c1     : out    STD_LOGIC;
      c2     : out    STD_LOGIC);
  end component esoc_pll2_c3;

  component esoc_rom_2kx32
    port(
      aclr    : in     STD_LOGIC;
      address : in     STD_LOGIC_VECTOR(10 downto 0);
      clock   : in     STD_LOGIC;
      data    : in     STD_LOGIC_VECTOR(31 downto 0);
      rden    : in     STD_LOGIC;
      wren    : in     STD_LOGIC;
      q       : out    STD_LOGIC_VECTOR(31 downto 0));
  end component esoc_rom_2kx32;

begin
  --CLK IN: 
  --50MHz
  --CLK OUT: 	
  --C0 50MHz
  --C1 100MHz
  --C2 150MHz
  --CLK IN: 
  --50MHz
  --CLK OUT: 	
  --C0 125MHz
  --
  --eSoc Clocks and Reset
  --eSoc Host Control Interface
  --eSoc Ethernet ports
  --eSoc Search Engine
  --eSoc Data bus Arbiter
  --eSoc Search bus Arbiter
  --eSoc Boot ROM
  esoc_ports: for esoc_port_nr in esoc_port_count-1 downto 0 generate
  begin
    u0: esoc_port
      generic map(
        esoc_port_nr => esoc_port_nr)
      port map(
        clk_control         => clk_control,
        clk_data            => clk_data,
        clk_rgmii_125m      => clk_rgmii_125m,
        clk_rgmii_25m       => clk_rgmii_25m,
        clk_rgmii_2m5       => clk_rgmii_2m5,
        clk_search          => clk_search,
        ctrl_address        => ctrl_address,
        ctrl_rd             => ctrl_rd,
        ctrl_rddata         => ctrl_rddata,
        ctrl_wait           => ctrl_wait,
        ctrl_wr             => ctrl_wr,
        ctrl_wrdata         => ctrl_wrdata,
        data                => data,
        data_eof            => data_eof,
        data_gnt_rd         => data_gnt_rd(esoc_port_nr),
        data_gnt_wr         => data_gnt_wr(esoc_port_nr),
        data_port_sel       => data_port_sel,
        data_req            => data_req(esoc_port_nr),
        data_sof            => data_sof,
        mdc                 => esoc_mdc(esoc_port_nr),
        mdio                => esoc_mdio(esoc_port_nr),
        reset               => reset,
        rgmii_rxc           => esoc_rgmii_rxc(esoc_port_nr),
        rgmii_rxctl         => esoc_rgmii_rxctl(esoc_port_nr),
        rgmii_rxd           => esoc_rgmii_rxd(3+4*esoc_port_nr downto 4*esoc_port_nr),
        rgmii_txc           => esoc_rgmii_txc(esoc_port_nr),
        rgmii_txctl         => esoc_rgmii_txctl(esoc_port_nr),
        rgmii_txd           => esoc_rgmii_txd(3+4*esoc_port_nr downto 4*esoc_port_nr),
        search_eof          => search_eof,
        search_gnt_wr       => search_gnt_wr(esoc_port_nr),
        search_key          => search_key,
        search_port_stalled => search_port_stalled(esoc_port_nr),
        search_req          => search_req(esoc_port_nr),
        search_result       => search_result,
        search_result_av    => search_result_av,
        search_sof          => search_sof);

  end generate esoc_ports;

  -- TEST
  u0: esoc_control
    port map(
      brom_address       => ctrl_brom_address,
      brom_rd            => ctrl_brom_rd,
      brom_rddata        => q,
      clk_control        => clk_control,
      ctrl_address       => ctrl_address,
      ctrl_rd            => ctrl_rd,
      ctrl_rddata        => ctrl_rddata,
      ctrl_wait          => ctrl_wait,
      ctrl_wr            => ctrl_wr,
      ctrl_wrdata        => ctrl_wrdata,
      esoc_address       => esoc_address,
      esoc_boot_complete => esoc_boot_complete,
      esoc_cs            => esoc_cs,
      esoc_data          => esoc_data,
      esoc_rd            => esoc_rd,
      esoc_wait          => esoc_wait,
      esoc_wr            => esoc_wr,
      pll1_locked        => pll1_locked,
      pll2_locked        => pll2_locked,
      reset              => reset);

  u2: esoc_reset
    port map(
      clk_control => clk_control,
      esoc_areset => esoc_areset,
      pll1_locked => pll1_locked,
      pll2_locked => pll2_locked,
      reset       => reset);

  u4: esoc_bus_arbiter
    generic map(
      id => 0)
    port map(
      bus_eof      => data_eof,
      bus_gnt_rd   => data_gnt_rd,
      bus_gnt_wr   => data_gnt_wr,
      bus_req      => data_req,
      bus_sof      => data_sof,
      clk_bus      => clk_data,
      clk_control  => clk_control,
      ctrl_address => ctrl_address,
      ctrl_rd      => ctrl_rd,
      ctrl_rddata  => ctrl_rddata,
      ctrl_wait    => ctrl_wait,
      ctrl_wr      => ctrl_wr,
      ctrl_wrdata  => ctrl_wrdata,
      reset        => reset);

  u6: esoc_search_engine
    port map(
      clk_control         => clk_control,
      clk_search          => clk_search,
      ctrl_address        => ctrl_address,
      ctrl_rd             => ctrl_rd,
      ctrl_rddata         => ctrl_rddata,
      ctrl_wait           => ctrl_wait,
      ctrl_wr             => ctrl_wr,
      ctrl_wrdata         => ctrl_wrdata,
      reset               => reset,
      search_eof          => search_eof,
      search_key          => search_key,
      search_port_stalled => search_port_stalled,
      search_result       => search_result,
      search_result_av    => search_result_av,
      search_sof          => search_sof);

  u1: esoc_pll1_c3
    port map(
      inclk0 => esoc_clk,
      c0     => clk_control,
      c1     => clk_search,
      c2     => clk_data,
      locked => pll1_locked);

  u3: esoc_pll2_c3
    port map(
      inclk0 => esoc_clk,
      c0     => clk_rgmii_125m,
      locked => pll2_locked,
      c1     => clk_rgmii_25m,
      c2     => clk_rgmii_2m5);

  u5: esoc_bus_arbiter
    generic map(
      id => 1)
    port map(
      bus_eof      => search_eof,
      bus_gnt_rd   => open,
      bus_gnt_wr   => search_gnt_wr,
      bus_req      => search_req,
      bus_sof      => search_sof,
      clk_bus      => clk_search,
      clk_control  => clk_control,
      ctrl_address => ctrl_address,
      ctrl_rd      => ctrl_rd,
      ctrl_rddata  => ctrl_rddata,
      ctrl_wait    => ctrl_wait,
      ctrl_wr      => ctrl_wr,
      ctrl_wrdata  => ctrl_wrdata,
      reset        => reset);

  u7: esoc_rom_2kx32
    port map(
      aclr    => reset,
      address => ctrl_brom_address,
      clock   => clk_control,
      data    => (others => '0'),
      rden    => ctrl_brom_rd,
      wren    => '0',
      q       => q);

end architecture structure ; -- of esoc
