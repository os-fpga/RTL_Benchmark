-- Super-I/O Logic Istvan Nagy 2019 09 15
----------------------------------------------------------------------------------
-- A multiplexer logic block to create a super-I/O IP compatible with x86 systems.
-- A replacement for a chip like the Microchip SCH3227.
--  The LPC IP has a 32bit wishbone bus, but only lower 8bits used for SIO access, with 8bit LPC cycles.
-- Files from other projects needed:
--  - UART below this module: https://opencores.org/projects/uart16550
--     For the UART, use the 33MHz compliant version regs file: uart_regs_33m.v
--     In uart_defines.v uncomment the "`define DATA_BUS_WIDTH_8"
--  - PS2 below this module: http://www.opencores.org/projects/ps2/ 
--     In the ps2_defines, uncomment `define PS2_AUX to enble the keyboard
--  - LPC slave: https://opencores.org/projects/wb_lpc
--     Use these files: wb_lpc_periph.v, wb_lpc_defines.v, serirq_defines.v, serirq_slave.v
--     Some of the files had references, that needs rewriting to remove relative path: `include "wb_lpc_defines.v"
--     In wb_lpc_periph.v change a line: always @(posedge clk_i or negedge nrst_i) ===> always @(posedge clk_i) 
--  - Write your own device-top level file, instantiating/connecting the LPC and SIO.
-- Address range:
--  - COM1: 3F8-3FFh
-- - 
--  - COM2: 2F8-2FFh
--  - COM3: 3E8-3EFh
--  - COM4: 2E8-2EFh
--  - PS2:  60h AND 64h
--  - post-code:  80h AND 81h
--  - Custom board logic registers: 200h...207h (r/w regs connect in/out outside, ro regs out NC)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--entity header  ----------------------------------------------------------------
entity sio_logic is
Port ( 	clk : in std_logic; --33.333MHz LPC or PCI-bus-derived clock
	reset_n  : in std_logic;
	wbm_adr_i  : in std_logic_vector(31 downto 0);
	wbm_dat_i  : in std_logic_vector(31 downto 0);
	wbm_dat_o  : out std_logic_vector(31 downto 0);
	wbm_sel_i  : in std_logic_vector(3 downto 0);
	wbm_tga_i  : in std_logic_vector(1 downto 0);
	wbm_we_i  : in std_logic;
	wbm_stb_i  : in std_logic;
	wbm_cyc_i  : in std_logic;
	wbm_ack_o  : out std_logic;
	wbm_err_o  : out std_logic;
	register_0_out   : out std_logic_vector(7 downto 0); 
	register_0_in   : in std_logic_vector(7 downto 0); 
	register_1_out   : out std_logic_vector(7 downto 0); 
	register_1_in   : in std_logic_vector(7 downto 0); 
	register_2_out   : out std_logic_vector(7 downto 0); 
	register_2_in   : in std_logic_vector(7 downto 0); 
	register_3_out   : out std_logic_vector(7 downto 0); 
	register_3_in   : in std_logic_vector(7 downto 0); 
	register_4_out   : out std_logic_vector(7 downto 0); 
	register_4_in   : in std_logic_vector(7 downto 0); 
	register_5_out   : out std_logic_vector(7 downto 0); 
	register_5_in   : in std_logic_vector(7 downto 0); 
	register_6_out   : out std_logic_vector(7 downto 0); 
	register_6_in   : in std_logic_vector(7 downto 0); 
	register_7_out   : out std_logic_vector(7 downto 0); 
	register_7_in   : in std_logic_vector(7 downto 0); 
	port80   : out std_logic_vector(7 downto 0); 
	port81   : out std_logic_vector(7 downto 0); 
	--kb_rstout: out std_logic;
	serial1_tx: out std_logic; serial1_rx: in std_logic; serial1_rts: out std_logic; serial1_cts: in std_logic; serial1_dtr: out std_logic; serial1_dsr: in std_logic; serial1_ri: in std_logic; serial1_dcd: in std_logic;
	serial2_tx: out std_logic; serial2_rx: in std_logic; serial2_rts: out std_logic; serial2_cts: in std_logic; serial2_dtr: out std_logic; serial2_dsr: in std_logic; serial2_ri: in std_logic; serial2_dcd: in std_logic;
	serial3_tx: out std_logic; serial3_rx: in std_logic; serial3_rts: out std_logic; serial3_cts: in std_logic; serial3_dtr: out std_logic; serial3_dsr: in std_logic; serial3_ri: in std_logic; serial3_dcd: in std_logic;
	serial4_tx: out std_logic; serial4_rx: in std_logic; serial4_rts: out std_logic; serial4_cts: in std_logic; serial4_dtr: out std_logic; serial4_dsr: in std_logic; serial4_ri: in std_logic; serial4_dcd: in std_logic;
	ps2_kbd_clk_pad_oe_o: out std_logic; ps2_kbd_clk_pad_o: out std_logic; ps2_kbd_data_pad_oe_o: out std_logic; ps2_kbd_data_pad_o: out std_logic; 
	ps2_aux_clk_pad_oe_o: out std_logic; ps2_aux_clk_pad_o: out std_logic; ps2_aux_data_pad_oe_o: out std_logic; ps2_aux_data_pad_o: out std_logic; 
	ps2_kbd_clk_pad_i: in std_logic; ps2_kbd_data_pad_i: in std_logic; ps2_aux_clk_pad_i : in std_logic; ps2_aux_data_pad_i: in std_logic
);
end sio_logic;
--architecture start ------------------------------------------------------------
architecture Behavioral of sio_logic is

--INTERNAL SIGNALS -------------------------------------------------------------
SIGNAL   serial1_wb_adr_i: std_logic_VECTOR(2 downto 0);
SIGNAL   serial1_wb_dat_i: std_logic_VECTOR(7 downto 0);
SIGNAL   serial1_wb_dat_o: std_logic_VECTOR(7 downto 0);
SIGNAL   serial1_wb_we: std_logic;
SIGNAL   serial1_wb_stb: std_logic;
SIGNAL   serial1_wb_cyc: std_logic;
SIGNAL   serial1_wb_ack_o: std_logic;
SIGNAL   serial1_wb_sel_i: std_logic_VECTOR(3 downto 0);
SIGNAL   serial1_int_o: std_logic;
SIGNAL   serial2_wb_adr_i: std_logic_VECTOR(2 downto 0);
SIGNAL   serial2_wb_dat_i: std_logic_VECTOR(7 downto 0);
SIGNAL   serial2_wb_dat_o: std_logic_VECTOR(7 downto 0);
SIGNAL   serial2_wb_we: std_logic;
SIGNAL   serial2_wb_stb: std_logic;
SIGNAL   serial2_wb_cyc: std_logic;
SIGNAL   serial2_wb_ack_o: std_logic;
SIGNAL   serial2_wb_sel_i: std_logic_VECTOR(3 downto 0);
SIGNAL   serial2_int_o: std_logic;
SIGNAL   serial3_wb_adr_i: std_logic_VECTOR(2 downto 0);
SIGNAL   serial3_wb_dat_i: std_logic_VECTOR(7 downto 0);
SIGNAL   serial3_wb_dat_o: std_logic_VECTOR(7 downto 0);
SIGNAL   serial3_wb_we: std_logic;
SIGNAL   serial3_wb_stb: std_logic;
SIGNAL   serial3_wb_cyc: std_logic;
SIGNAL   serial3_wb_ack_o: std_logic;
SIGNAL   serial3_wb_sel_i: std_logic_VECTOR(3 downto 0);
SIGNAL   serial3_int_o: std_logic;
SIGNAL   serial4_wb_adr_i: std_logic_VECTOR(2 downto 0);
SIGNAL   serial4_wb_dat_i: std_logic_VECTOR(7 downto 0);
SIGNAL   serial4_wb_dat_o: std_logic_VECTOR(7 downto 0);
SIGNAL   serial4_wb_we: std_logic;
SIGNAL   serial4_wb_stb: std_logic;
SIGNAL   serial4_wb_cyc: std_logic;
SIGNAL   serial4_wb_ack_o: std_logic;
SIGNAL   serial4_wb_sel_i: std_logic_VECTOR(3 downto 0);
SIGNAL   serial4_int_o: std_logic;
SIGNAL   ps2_wb_cyc: std_logic;
SIGNAL   ps2_wb_stb: std_logic;
SIGNAL   ps2_wb_we: std_logic;
SIGNAL   ps2_wb_sel_i: std_logic_VECTOR(3 downto 0);
SIGNAL   ps2_wb_adr_i: std_logic_VECTOR(3 downto 0);
SIGNAL   ps2_wb_dat_i: std_logic_VECTOR(31 downto 0);
SIGNAL   ps2_wb_dat_o: std_logic_VECTOR(31 downto 0);
SIGNAL   ps2_wb_ack_o : std_logic;
SIGNAL   ps2_wb_int_o: std_logic;
SIGNAL   ps2_wb_intb_o: std_logic;
SIGNAL  offset_reg  : std_logic_VECTOR(7 downto 0);
SIGNAL  device_reg  : std_logic_VECTOR(7 downto 0);
SIGNAL  reset_activehigh : std_logic;



---------COMPONENT DECLARATIONS (introducing the IPs) ----------------------------
	COMPONENT uart_top
	PORT(
		wb_clk_i : IN std_logic;
		wb_rst_i : IN std_logic;
		wb_adr_i : IN std_logic_vector(2 downto 0);
		wb_dat_i : IN std_logic_vector(7 downto 0);
		wb_we_i : IN std_logic;
		wb_stb_i : IN std_logic;
		wb_cyc_i : IN std_logic;
		wb_sel_i : IN std_logic_vector(3 downto 0);
		srx_pad_i : IN std_logic;
		cts_pad_i : IN std_logic;
		dsr_pad_i : IN std_logic;
		ri_pad_i : IN std_logic;
		dcd_pad_i : IN std_logic;        
		wb_dat_o : OUT std_logic_vector(7 downto 0);
		wb_ack_o : OUT std_logic;
		int_o : OUT std_logic;
		stx_pad_o : OUT std_logic;
		rts_pad_o : OUT std_logic;
		dtr_pad_o : OUT std_logic
		);
	END COMPONENT;
	COMPONENT ps2_top
	PORT(
		wb_clk_i : IN std_logic;
		wb_rst_i : IN std_logic;
		wb_cyc_i : IN std_logic;
		wb_stb_i : IN std_logic;
		wb_we_i : IN std_logic;
		wb_sel_i : IN std_logic_vector(3 downto 0);
		wb_adr_i : IN std_logic_vector(3 downto 0);
		wb_dat_i : IN std_logic_vector(31 downto 0);
		ps2_kbd_clk_pad_i : IN std_logic;
		ps2_kbd_data_pad_i : IN std_logic;
		ps2_aux_clk_pad_i : IN std_logic;
		ps2_aux_data_pad_i : IN std_logic;        
		wb_dat_o : OUT std_logic_vector(31 downto 0);
		wb_ack_o : OUT std_logic;
		wb_int_o : OUT std_logic;
		--kb_rstout : OUT std_logic;
		ps2_kbd_clk_pad_o : OUT std_logic;
		ps2_kbd_data_pad_o : OUT std_logic;
		ps2_kbd_clk_pad_oe_o : OUT std_logic;
		ps2_kbd_data_pad_oe_o : OUT std_logic;
		wb_intb_o : OUT std_logic;
		ps2_aux_clk_pad_o : OUT std_logic;
		ps2_aux_data_pad_o : OUT std_logic;
		ps2_aux_clk_pad_oe_o : OUT std_logic;
		ps2_aux_data_pad_oe_o : OUT std_logic
		);
	END COMPONENT;

--architecture body start -------------------------------------------------------
begin
---------COMPONENT INSTALLATIONS (connecting the IPs to local signals) ---------
	Inst_uart1_top: uart_top PORT MAP(
		wb_clk_i => clk,
		wb_rst_i => reset_activehigh,
		wb_adr_i => serial1_wb_adr_i(2 downto 0),
		wb_dat_i => serial1_wb_dat_i,
		wb_dat_o => serial1_wb_dat_o,
		wb_we_i => serial1_wb_we,
		wb_stb_i => serial1_wb_stb,
		wb_cyc_i => serial1_wb_cyc,
		wb_ack_o => serial1_wb_ack_o,
		wb_sel_i => serial1_wb_sel_i,
		int_o => serial1_int_o,
		stx_pad_o => serial1_tx,
		srx_pad_i => serial1_rx,
		rts_pad_o => serial1_rts,
		cts_pad_i => serial1_cts,
		dtr_pad_o => serial1_dtr,
		dsr_pad_i => serial1_dsr,
		ri_pad_i => serial1_ri,
		dcd_pad_i => serial1_dcd
	);
	Inst_uart2_top: uart_top PORT MAP(
		wb_clk_i => clk,
		wb_rst_i => reset_activehigh,
		wb_adr_i => serial2_wb_adr_i(2 downto 0),
		wb_dat_i => serial2_wb_dat_i,
		wb_dat_o => serial2_wb_dat_o,
		wb_we_i => serial2_wb_we,
		wb_stb_i => serial2_wb_stb,
		wb_cyc_i => serial2_wb_cyc,
		wb_ack_o => serial2_wb_ack_o,
		wb_sel_i => serial2_wb_sel_i,
		int_o => serial2_int_o,
		stx_pad_o => serial2_tx,
		srx_pad_i => serial2_rx,
		rts_pad_o => serial2_rts,
		cts_pad_i => serial2_cts,
		dtr_pad_o => serial2_dtr,
		dsr_pad_i => serial2_dsr,
		ri_pad_i => serial2_ri,
		dcd_pad_i => serial2_dcd
	);
	Inst_uart3_top: uart_top PORT MAP(
		wb_clk_i => clk,
		wb_rst_i => reset_activehigh,
		wb_adr_i => serial3_wb_adr_i(2 downto 0),
		wb_dat_i => serial3_wb_dat_i,
		wb_dat_o => serial3_wb_dat_o,
		wb_we_i => serial3_wb_we,
		wb_stb_i => serial3_wb_stb,
		wb_cyc_i => serial3_wb_cyc,
		wb_ack_o => serial3_wb_ack_o,
		wb_sel_i => serial3_wb_sel_i,
		int_o => serial3_int_o,
		stx_pad_o => serial3_tx,
		srx_pad_i => serial3_rx,
		rts_pad_o => serial3_rts,
		cts_pad_i => serial3_cts,
		dtr_pad_o => serial3_dtr,
		dsr_pad_i => serial3_dsr,
		ri_pad_i => serial3_ri,
		dcd_pad_i => serial3_dcd
	);
	Inst_uart4_top: uart_top PORT MAP(
		wb_clk_i => clk,
		wb_rst_i => reset_activehigh,
		wb_adr_i => serial4_wb_adr_i(2 downto 0),
		wb_dat_i => serial4_wb_dat_i,
		wb_dat_o => serial4_wb_dat_o,
		wb_we_i => serial4_wb_we,
		wb_stb_i => serial4_wb_stb,
		wb_cyc_i => serial4_wb_cyc,
		wb_ack_o => serial4_wb_ack_o,
		wb_sel_i => serial4_wb_sel_i,
		int_o => serial4_int_o,
		stx_pad_o => serial4_tx,
		srx_pad_i => serial4_rx,
		rts_pad_o => serial4_rts,
		cts_pad_i => serial4_cts,
		dtr_pad_o => serial4_dtr,
		dsr_pad_i => serial4_dsr,
		ri_pad_i => serial4_ri,
		dcd_pad_i => serial4_dcd
	);


	Inst_ps2_top: ps2_top PORT MAP(
		wb_clk_i => clk,
		wb_rst_i => reset_activehigh,
	    wb_cyc_i => ps2_wb_cyc, 
	    wb_stb_i => ps2_wb_stb, 
	    wb_we_i => ps2_wb_we, 
	    wb_sel_i => ps2_wb_sel_i, 
	    wb_adr_i => ps2_wb_adr_i, 
	    wb_dat_i => ps2_wb_dat_i,
	    wb_dat_o => ps2_wb_dat_o, 
	    wb_ack_o => ps2_wb_ack_o, 
	    wb_int_o => ps2_wb_int_o, 
	    --kb_rstout => kb_rstout,
	    ps2_kbd_clk_pad_i => ps2_kbd_clk_pad_i, 
	    ps2_kbd_data_pad_i => ps2_kbd_data_pad_i, 
	    ps2_kbd_clk_pad_o => ps2_kbd_clk_pad_o, 
	    ps2_kbd_data_pad_o => ps2_kbd_data_pad_o, 
	    ps2_kbd_clk_pad_oe_o => ps2_kbd_clk_pad_oe_o, 
	    ps2_kbd_data_pad_oe_o => ps2_kbd_data_pad_oe_o,
	    wb_intb_o => ps2_wb_intb_o,
	    ps2_aux_clk_pad_i => ps2_aux_clk_pad_i, 
	    ps2_aux_data_pad_i => ps2_aux_data_pad_i, 
	    ps2_aux_clk_pad_o => ps2_aux_clk_pad_o, 
	    ps2_aux_data_pad_o => ps2_aux_data_pad_o, 
	    ps2_aux_clk_pad_oe_o => ps2_aux_clk_pad_oe_o, 
	    ps2_aux_data_pad_oe_o => ps2_aux_data_pad_oe_o
	);

--local Logic --------------------------------------------------------------------
reset_activehigh <= not reset_n;


process ( reset_n, clk, wbm_adr_i, serial1_wb_dat_o, serial2_wb_dat_o, serial3_wb_dat_o, serial4_wb_dat_o, ps2_wb_dat_o, ps2_wb_ack_o, serial1_wb_ack_o, serial2_wb_ack_o, serial3_wb_ack_o, serial4_wb_ack_o, wbm_cyc_i, wbm_we_i, wbm_stb_i, offset_reg, device_reg )
begin
if (reset_n='0') then
   wbm_dat_o <= (others => '0');
   offset_reg <=  (others => '0');
   device_reg <=  (others => '0');
else
 if (wbm_adr_i(9 downto 3) = "1111111") then --serial1
   wbm_dat_o(7 downto 0) <= serial1_wb_dat_o; wbm_ack_o <= serial1_wb_ack_o; 
   ps2_wb_cyc <= '0'; serial1_wb_cyc <= wbm_cyc_i; serial2_wb_cyc <= '0'; serial3_wb_cyc <= '0'; serial4_wb_cyc <= '0';
   ps2_wb_we <= '0'; serial1_wb_we <= wbm_we_i; serial2_wb_we <= '0'; serial3_wb_we <= '0'; serial4_wb_we <= '0';
   ps2_wb_stb <= '0'; serial1_wb_stb <= wbm_stb_i; serial2_wb_stb <= '0'; serial3_wb_stb <= '0'; serial4_wb_stb <= '0';
 elsif (wbm_adr_i(9 downto 3) = "1011111") then  --serial2
   wbm_dat_o(7 downto 0) <= serial2_wb_dat_o;  wbm_ack_o <= serial2_wb_ack_o; 
   ps2_wb_cyc <= '0'; serial1_wb_cyc <= '0'; serial2_wb_cyc <= wbm_cyc_i; serial3_wb_cyc <= '0'; serial4_wb_cyc <= '0';
   ps2_wb_we <= '0'; serial1_wb_we <= '0'; serial2_wb_we <= wbm_we_i; serial3_wb_we <= '0'; serial4_wb_we <= '0';
   ps2_wb_stb <= '0'; serial1_wb_stb <= '0'; serial2_wb_stb <= wbm_stb_i; serial3_wb_stb <= '0'; serial4_wb_stb <= '0';
 elsif (wbm_adr_i(9 downto 3) = "1111101") then  --serial3
   wbm_dat_o(7 downto 0) <= serial3_wb_dat_o;  wbm_ack_o <= serial3_wb_ack_o; 
   ps2_wb_cyc <= '0'; serial1_wb_cyc <= '0'; serial2_wb_cyc <= '0'; serial3_wb_cyc <= wbm_cyc_i; serial4_wb_cyc <= '0';
   ps2_wb_we <= '0'; serial1_wb_we <= '0'; serial2_wb_we <= '0'; serial3_wb_we <= wbm_we_i; serial4_wb_we <= '0';
   ps2_wb_stb <= '0'; serial1_wb_stb <= '0'; serial2_wb_stb <= '0'; serial3_wb_stb <= wbm_stb_i; serial4_wb_stb <= '0';
 elsif (wbm_adr_i(9 downto 3) = "1011101") then  --serial4
   wbm_dat_o(7 downto 0) <= serial4_wb_dat_o;  wbm_ack_o <= serial4_wb_ack_o; 
   ps2_wb_cyc <= '0'; serial1_wb_cyc <= '0'; serial2_wb_cyc <= '0'; serial3_wb_cyc <= '0'; serial4_wb_cyc <= wbm_cyc_i;
   ps2_wb_we <= '0'; serial1_wb_we <= '0'; serial2_wb_we <= '0'; serial3_wb_we <= '0'; serial4_wb_we <= wbm_we_i;
   ps2_wb_stb <= '0'; serial1_wb_stb <= '0'; serial2_wb_stb <= '0'; serial3_wb_stb <= '0'; serial4_wb_stb <= wbm_stb_i;
 elsif (wbm_adr_i(12 downto 3) = "0001100000") then --ps2
   wbm_dat_o(7 downto 0) <= ps2_wb_dat_o(31 downto 24); wbm_ack_o <= ps2_wb_ack_o; 
   ps2_wb_cyc <= wbm_cyc_i; serial1_wb_cyc <= '0'; serial2_wb_cyc <= '0'; serial3_wb_cyc <= '0'; serial4_wb_cyc <= '0';
   ps2_wb_we <= wbm_we_i; serial1_wb_we <= '0'; serial2_wb_we <= '0'; serial3_wb_we <= '0'; serial4_wb_we <= '0';
   ps2_wb_stb <= wbm_stb_i; serial1_wb_stb <= '0'; serial2_wb_stb <= '0'; serial3_wb_stb <= '0'; serial4_wb_stb <= '0';
 elsif (wbm_adr_i(12 downto 3) = "0001100100") then --p2s
   wbm_dat_o(7 downto 0) <= ps2_wb_dat_o(31 downto 24); wbm_ack_o <= ps2_wb_ack_o; 
   ps2_wb_cyc <= wbm_cyc_i; serial1_wb_cyc <= '0'; serial2_wb_cyc <= '0'; serial3_wb_cyc <= '0'; serial4_wb_cyc <= '0';
   ps2_wb_we <= wbm_we_i; serial1_wb_we <= '0'; serial2_wb_we <= '0'; serial3_wb_we <= '0'; serial4_wb_we <= '0';
   ps2_wb_stb <= wbm_stb_i; serial1_wb_stb <= '0'; serial2_wb_stb <= '0'; serial3_wb_stb <= '0'; serial4_wb_stb <= '0';
 else  --not serial or ps2 forwarding, decode locally: 
 
   ps2_wb_cyc <= '0'; serial1_wb_cyc <= '0'; serial2_wb_cyc <= '0'; serial3_wb_cyc <= '0'; serial4_wb_cyc <= '0';
   ps2_wb_we <= '0'; serial1_wb_we <= '0'; serial2_wb_we <= '0'; serial3_wb_we <= '0'; serial4_wb_we <= '0';
   ps2_wb_stb <= '0'; serial1_wb_stb <= '0'; serial2_wb_stb <= '0'; serial3_wb_stb <= '0'; serial4_wb_stb <= '0';

   if (clk'event and clk='1') then

          case ( wbm_adr_i(11 downto 0) ) is
          --registers:
          when X"200" =>          
           wbm_dat_o(7 downto 0) <= register_0_in(7 downto 0); wbm_ack_o <= '1'; 
           register_0_out <= wbm_dat_i(7 downto 0);
          when X"201" =>          
           wbm_dat_o(7 downto 0) <= register_1_in(7 downto 0); wbm_ack_o <= '1'; 
           register_1_out <= wbm_dat_i(7 downto 0);
          when X"202" =>          
           wbm_dat_o(7 downto 0) <= register_2_in(7 downto 0); wbm_ack_o <= '1'; 
           register_2_out <= wbm_dat_i(7 downto 0);
          when X"203" =>          
           wbm_dat_o(7 downto 0) <= register_3_in(7 downto 0); wbm_ack_o <= '1'; 
           register_3_out <= wbm_dat_i(7 downto 0);
          when X"204" =>          
           wbm_dat_o(7 downto 0) <= register_4_in(7 downto 0); wbm_ack_o <= '1'; 
           register_4_out <= wbm_dat_i(7 downto 0);
          when X"205" =>          
           wbm_dat_o(7 downto 0) <= register_5_in(7 downto 0); wbm_ack_o <= '1'; 
           register_5_out <= wbm_dat_i(7 downto 0);
          when X"206" =>          
           wbm_dat_o(7 downto 0) <= register_6_in(7 downto 0); wbm_ack_o <= '1'; 
           register_6_out <= wbm_dat_i(7 downto 0);
          when X"207" =>          
           wbm_dat_o(7 downto 0) <= register_7_in(7 downto 0); wbm_ack_o <= '1'; 
           register_7_out <= wbm_dat_i(7 downto 0);
          --post code PORT80:
          when X"080" =>          
           port80 <=  wbm_dat_i(7 downto 0); 
           wbm_dat_o(7 downto 0) <= offset_reg; wbm_ack_o <= '1'; 
          when X"081" =>          
           port81 <=  wbm_dat_i(7 downto 0); 
           wbm_dat_o(7 downto 0) <= offset_reg; wbm_ack_o <= '1'; 
          --sio plug and play logic, for the BIOS/OS to detect the number of ports available. ****
          when X"02E" =>          
           if (wbm_we_i='1') then  offset_reg <=  wbm_dat_i(7 downto 0);  end if;
           wbm_dat_o(7 downto 0) <= offset_reg; wbm_ack_o <= '1'; 
          when X"02F" =>          
           if (wbm_we_i='1') then  device_reg <=  wbm_dat_i(7 downto 0);  end if;
           wbm_ack_o <= '1'; 
             if (offset_reg = 7) then
               wbm_dat_o(7 downto 0) <= device_reg;
             elsif (offset_reg = X"60") then --offset LSB 
                if    (device_reg = 4) then --serial1
                  wbm_dat_o(7 downto 0) <= X"F8";
                elsif (device_reg = 3) then --serial2
                  wbm_dat_o(7 downto 0) <= X"F8";
                elsif (device_reg = 2) then --serial3
                  wbm_dat_o(7 downto 0) <= X"E8";
                elsif (device_reg = 1) then --serial4
                  wbm_dat_o(7 downto 0) <= X"E8";
                elsif (device_reg = 6) then --keyboard
                  wbm_dat_o(7 downto 0) <= X"60";
                elsif (device_reg = 5) then --mouse
                  wbm_dat_o(7 downto 0) <= X"60";
                else 
                  wbm_dat_o(7 downto 0) <= "00000000";
                end if;
             elsif (offset_reg = X"61") then --offset MSB 
                if    (device_reg = 4) then --serial1
                  wbm_dat_o(7 downto 0) <= X"03";
                elsif (device_reg = 3) then --serial2
                  wbm_dat_o(7 downto 0) <= X"02";
                elsif (device_reg = 2) then --serial3
                  wbm_dat_o(7 downto 0) <= X"03";
                elsif (device_reg = 1) then --serial4
                  wbm_dat_o(7 downto 0) <= X"02";
                elsif (device_reg = 6) then --keyboard
                  wbm_dat_o(7 downto 0) <= X"00";
                elsif (device_reg = 5) then --mouse
                  wbm_dat_o(7 downto 0) <= X"00";
                else 
                  wbm_dat_o(7 downto 0) <= "00000000";
                end if;
             elsif (offset_reg = X"70") then --interrupt info
                if    (device_reg = 4) then --serial1
                  wbm_dat_o(7 downto 0) <= X"04";
                elsif (device_reg = 3) then --serial2
                  wbm_dat_o(7 downto 0) <= X"03";
                elsif (device_reg = 2) then --serial3
                  wbm_dat_o(7 downto 0) <= X"04";
                elsif (device_reg = 1) then --serial4
                  wbm_dat_o(7 downto 0) <= X"03";
                elsif (device_reg = 6) then --keyboard
                  wbm_dat_o(7 downto 0) <= X"01";
                elsif (device_reg = 5) then --mouse
                  wbm_dat_o(7 downto 0) <= X"0C";
                else 
                  wbm_dat_o(7 downto 0) <= "00000000";
                end if;
             end if;
          when others => --error
            wbm_dat_o <= (others => '0'); wbm_ack_o <= '0'; 
            --device_reg <= device_reg; port80 <= port80; port81 <= port81; offset_reg <= offset_reg;
            --register_0_out <= register_0_out; register_1_out <= register_1_out; register_2_out <= register_2_out; register_3_out <= register_3_out; 
            --register_4_out <= register_4_out; register_5_out <= register_5_out; register_6_out <= register_6_out; register_7_out <= register_7_out; 
          end case;  
   end if;
 end if;
end if;
end process;

ps2_wb_dat_i(31 downto 24) <= wbm_dat_i(7 downto 0);
ps2_wb_dat_i(23 downto 16) <= wbm_dat_i(7 downto 0);
ps2_wb_dat_i(15 downto 8) <= wbm_dat_i(7 downto 0);
ps2_wb_sel_i(3) <= '1';
ps2_wb_sel_i(2 downto 0) <= "000";
ps2_wb_adr_i(3 downto 0) <= wbm_adr_i(3 downto 0);
serial1_wb_dat_i <= wbm_dat_i(7 downto 0);
serial1_wb_sel_i <= "1000"; 
serial1_wb_adr_i(2 downto 0) <= wbm_adr_i(2 downto 0);
serial2_wb_dat_i <= wbm_dat_i(7 downto 0);
serial2_wb_sel_i <= "1000"; 
serial2_wb_adr_i(2 downto 0) <= wbm_adr_i(2 downto 0);
serial3_wb_dat_i <= wbm_dat_i(7 downto 0);
serial3_wb_sel_i <= "1000"; 
serial3_wb_adr_i(2 downto 0) <= wbm_adr_i(2 downto 0);
serial4_wb_dat_i <= wbm_dat_i(7 downto 0);
serial4_wb_sel_i <= "1000"; 
serial4_wb_adr_i(2 downto 0) <= wbm_adr_i(2 downto 0);

--end file ----------------------------------------------------------------------
end Behavioral;





