-- -----------------------------------------------------------------------------
--  This file is a top level application for conencting the wb_lpc to the sio_logic
-- written by : Istvan Nagy 11.01, 2019
-- 
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
--  - COM2: 2F8-2FFh
--  - COM3: 3E8-3EFh
--  - COM4: 2E8-2EFh
--  - PS2:  60h AND 64h
--  - post-code:  80h AND 81h
--  - Custom board logic registers: 200h...207h (r/w regs connect in/out outside, ro regs out NC)
-- -----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--entity header  ----------------------------------------------------------------
entity example_sio_top is
    Port ( 
    clk_lpc : in std_logic;
    reset_n : in std_logic;
    lframe : in std_logic;
    lad   : inout std_logic_vector(3 downto 0); 
    serirq   : inout  std_logic;
    parallel_irq : IN std_logic_vector(31 downto 0);
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
	serial1_tx: out std_logic; serial1_rx: in std_logic; serial1_rts: out std_logic; serial1_cts: in std_logic; serial1_dtr: out std_logic; serial1_dsr: in std_logic; serial1_ri: in std_logic; serial1_dcd: in std_logic;
	serial2_tx: out std_logic; serial2_rx: in std_logic; serial2_rts: out std_logic; serial2_cts: in std_logic; serial2_dtr: out std_logic; serial2_dsr: in std_logic; serial2_ri: in std_logic; serial2_dcd: in std_logic;
	serial3_tx: out std_logic; serial3_rx: in std_logic; serial3_rts: out std_logic; serial3_cts: in std_logic; serial3_dtr: out std_logic; serial3_dsr: in std_logic; serial3_ri: in std_logic; serial3_dcd: in std_logic;
	serial4_tx: out std_logic; serial4_rx: in std_logic; serial4_rts: out std_logic; serial4_cts: in std_logic; serial4_dtr: out std_logic; serial4_dsr: in std_logic; serial4_ri: in std_logic; serial4_dcd: in std_logic;
	ps2_kbd_clk_pad_oe_o: out std_logic; ps2_kbd_clk_pad_o: out std_logic; ps2_kbd_data_pad_oe_o: out std_logic; ps2_kbd_data_pad_o: out std_logic; 
	ps2_aux_clk_pad_oe_o: out std_logic; ps2_aux_clk_pad_o: out std_logic; ps2_aux_data_pad_oe_o: out std_logic; ps2_aux_data_pad_o: out std_logic; 
	ps2_kbd_clk_pad_i: in std_logic; ps2_kbd_data_pad_i: in std_logic; ps2_aux_clk_pad_i : in std_logic; ps2_aux_data_pad_i: in std_logic; kb_rstout: out std_logic
           );
end example_sio_top;


--architecture start ------------------------------------------------------------
architecture Behavioral of example_sio_top is


-- INTERNAL SIGNALS -------------------------------------------------------------
    SIGNAL dummy0:  std_logic;
    SIGNAL dummy1:  std_logic_VECTOR(6 DOWNTO 0);
	SIGNAL	xwbm_adr_i :  std_logic_vector(31 downto 0);
	SIGNAL	xwbm_dat_i :  std_logic_vector(31 downto 0);
	SIGNAL	xwbm_sel_i :  std_logic_vector(3 downto 0);
	SIGNAL	xwbm_tga_i :  std_logic_vector(1 downto 0);
	SIGNAL	xwbm_we_i :  std_logic;
	SIGNAL	xwbm_stb_i :  std_logic;
	SIGNAL	xwbm_cyc_i :  std_logic; 
	SIGNAL	xwbm_dat_o :  std_logic_vector(31 downto 0);
	SIGNAL	xwbm_ack_o :  std_logic;
	SIGNAL	xwbm_err_o :  std_logic;
	SIGNAL dma_bs1  :  std_logic_vector(2 downto 0);
	SIGNAL dma_bs2  :  std_logic;
	SIGNAL	serirq_i :  std_logic;          
	SIGNAL	serirq_o :  std_logic;
	SIGNAL	serirq_oe :  std_logic;
	SIGNAL	lad_i :  std_logic_vector(3 downto 0);      
	SIGNAL	lad_o :  std_logic_vector(3 downto 0);
	SIGNAL	lad_oe :  std_logic;



--------- COMPONENT DECLARATIONS (introducing the IPs) --------------------------
	COMPONENT sio_logic
	PORT(
		clk : IN std_logic;
		reset_n : IN std_logic;
		wbm_adr_i : IN std_logic_vector(31 downto 0);
		wbm_dat_i : IN std_logic_vector(31 downto 0);
		wbm_sel_i : IN std_logic_vector(3 downto 0);
		wbm_tga_i : IN std_logic_vector(1 downto 0);
		wbm_we_i : IN std_logic;
		wbm_stb_i : IN std_logic;
		wbm_cyc_i : IN std_logic;
		register_0_in : IN std_logic_vector(7 downto 0);
		register_1_in : IN std_logic_vector(7 downto 0);
		register_2_in : IN std_logic_vector(7 downto 0);
		register_3_in : IN std_logic_vector(7 downto 0);
		register_4_in : IN std_logic_vector(7 downto 0);
		register_5_in : IN std_logic_vector(7 downto 0);
		register_6_in : IN std_logic_vector(7 downto 0);
		register_7_in : IN std_logic_vector(7 downto 0);
		serial1_rx : IN std_logic;
		serial1_cts : IN std_logic;
		serial1_dsr : IN std_logic;
		serial1_ri : IN std_logic;
		serial1_dcd : IN std_logic;
		serial2_rx : IN std_logic;
		serial2_cts : IN std_logic;
		serial2_dsr : IN std_logic;
		serial2_ri : IN std_logic;
		serial2_dcd : IN std_logic;
		serial3_rx : IN std_logic;
		serial3_cts : IN std_logic;
		serial3_dsr : IN std_logic;
		serial3_ri : IN std_logic;
		serial3_dcd : IN std_logic;
		serial4_rx : IN std_logic;
		serial4_cts : IN std_logic;
		serial4_dsr : IN std_logic;
		serial4_ri : IN std_logic;
		serial4_dcd : IN std_logic;
		ps2_kbd_clk_pad_i : IN std_logic;
		ps2_kbd_data_pad_i : IN std_logic;
		ps2_aux_clk_pad_i : IN std_logic;
		ps2_aux_data_pad_i : IN std_logic;          
		wbm_dat_o : OUT std_logic_vector(31 downto 0);
		wbm_ack_o : OUT std_logic;
		wbm_err_o : OUT std_logic;
		register_0_out : OUT std_logic_vector(7 downto 0);
		register_1_out : OUT std_logic_vector(7 downto 0);
		register_2_out : OUT std_logic_vector(7 downto 0);
		register_3_out : OUT std_logic_vector(7 downto 0);
		register_4_out : OUT std_logic_vector(7 downto 0);
		register_5_out : OUT std_logic_vector(7 downto 0);
		register_6_out : OUT std_logic_vector(7 downto 0);
		register_7_out : OUT std_logic_vector(7 downto 0);
		port80 : OUT std_logic_vector(7 downto 0);
		port81 : OUT std_logic_vector(7 downto 0);
		serial1_tx : OUT std_logic;
		serial1_rts : OUT std_logic;
		serial1_dtr : OUT std_logic;
		serial2_tx : OUT std_logic;
		serial2_rts : OUT std_logic;
		serial2_dtr : OUT std_logic;
		serial3_tx : OUT std_logic;
		serial3_rts : OUT std_logic;
		serial3_dtr : OUT std_logic;
		serial4_tx : OUT std_logic;
		serial4_rts : OUT std_logic;
		serial4_dtr : OUT std_logic;
		--kb_rstout : OUT std_logic;
		ps2_kbd_clk_pad_oe_o : OUT std_logic;
		ps2_kbd_clk_pad_o : OUT std_logic;
		ps2_kbd_data_pad_oe_o : OUT std_logic;
		ps2_kbd_data_pad_o : OUT std_logic;
		ps2_aux_clk_pad_oe_o : OUT std_logic;
		ps2_aux_clk_pad_o : OUT std_logic;
		ps2_aux_data_pad_oe_o : OUT std_logic;
		ps2_aux_data_pad_o : OUT std_logic
		);
	END COMPONENT;

	COMPONENT wb_lpc_periph
	PORT(
		clk_i : IN std_logic;
		nrst_i : IN std_logic;
		wbm_dat_i : IN std_logic_vector(31 downto 0);
		wbm_ack_i : IN std_logic;
		wbm_err_i : IN std_logic;
		lframe_i : IN std_logic;
		lad_i : IN std_logic_vector(3 downto 0);          
		wbm_adr_o : OUT std_logic_vector(31 downto 0);
		wbm_dat_o : OUT std_logic_vector(31 downto 0);
		wbm_sel_o : OUT std_logic_vector(3 downto 0);
		wbm_tga_o : OUT std_logic_vector(1 downto 0);
		wbm_we_o : OUT std_logic;
		wbm_stb_o : OUT std_logic;
		wbm_cyc_o : OUT std_logic;
		dma_chan_o : OUT std_logic_vector(2 downto 0);
		dma_tc_o : OUT std_logic;
		lad_o : OUT std_logic_vector(3 downto 0);
		lad_oe : OUT std_logic
		);
	END COMPONENT;


	COMPONENT serirq_slave
	PORT(
		clk_i : IN std_logic;
		nrst_i : IN std_logic;
		irq_i : IN std_logic_vector(31 downto 0);
		serirq_i : IN std_logic;          
		serirq_o : OUT std_logic;
		serirq_oe : OUT std_logic
		);
	END COMPONENT;


--architecture body start -------------------------------------------------------
begin



--------- COMPONENT INSTALLATIONS (connecting the IPs to local signals) ---------
	Inst_sio_logic: sio_logic PORT MAP(
		clk => clk_lpc ,
		reset_n => reset_n  ,
		wbm_adr_i => xwbm_adr_i,
		wbm_dat_i => xwbm_dat_i,
		wbm_dat_o => xwbm_dat_o,
		wbm_sel_i => xwbm_sel_i,
		wbm_tga_i => xwbm_tga_i,
		wbm_we_i => xwbm_we_i,
		wbm_stb_i => xwbm_stb_i,
		wbm_cyc_i => xwbm_cyc_i,
		wbm_ack_o => xwbm_ack_o,
		wbm_err_o => xwbm_err_o,
		register_0_out  	 => 	register_0_out,
		register_0_in  	 => 	register_0_in,
		register_1_out  	 => 	register_1_out,
		register_1_in  	 => 	register_1_in,
		register_2_out  	 => 	register_2_out,
		register_2_in  	 => 	register_2_in,
		register_3_out  	 => 	register_3_out,
		register_3_in  	 => 	register_3_in,
		register_4_out  	 => 	register_4_out,
		register_4_in  	 => 	register_4_in,
		register_5_out  	 => 	register_5_out,
		register_5_in  	 => 	register_5_in,
		register_6_out  	 => 	register_6_out,
		register_6_in  	 => 	register_6_in,
		register_7_out  	 => 	register_7_out,
		register_7_in  	 => 	register_7_in,
		port80  	 => 	port80,
		port81  	 => 	port81,
		serial1_tx  	 => 	serial1_tx,
		serial1_rx  	 => 	serial1_rx,
		serial1_rts  	 => 	serial1_rts,
		serial1_cts  	 => 	serial1_cts,
		serial1_dtr  	 => 	serial1_dtr,
		serial1_dsr  	 => 	serial1_dsr,
		serial1_ri  	 => 	serial1_ri,
		serial1_dcd  	 => 	serial1_dcd,
		serial2_tx  	 => 	serial2_tx,
		serial2_rx  	 => 	serial2_rx,
		serial2_rts  	 => 	serial2_rts,
		serial2_cts  	 => 	serial2_cts,
		serial2_dtr  	 => 	serial2_dtr,
		serial2_dsr  	 => 	serial2_dsr,
		serial2_ri  	 => 	serial2_ri,
		serial2_dcd  	 => 	serial2_dcd,
		serial3_tx  	 => 	serial3_tx,
		serial3_rx  	 => 	serial3_rx,
		serial3_rts  	 => 	serial3_rts,
		serial3_cts  	 => 	serial3_cts,
		serial3_dtr  	 => 	serial3_dtr,
		serial3_dsr  	 => 	serial3_dsr,
		serial3_ri  	 => 	serial3_ri,
		serial3_dcd  	 => 	serial3_dcd,
		serial4_tx  	 => 	serial4_tx,
		serial4_rx  	 => 	serial4_rx,
		serial4_rts  	 => 	serial4_rts,
		serial4_cts  	 => 	serial4_cts,
		serial4_dtr  	 => 	serial4_dtr,
		serial4_dsr  	 => 	serial4_dsr,
		serial4_ri  	 => 	serial4_ri,
		serial4_dcd  	 => 	serial4_dcd,
		--kb_rstout  	 => 	kb_rstout, --missing???
		ps2_kbd_clk_pad_oe_o  	 => 	ps2_kbd_clk_pad_oe_o,
		ps2_kbd_clk_pad_o  	 => 	ps2_kbd_clk_pad_o,
		ps2_kbd_data_pad_oe_o  	 => 	ps2_kbd_data_pad_oe_o,
		ps2_kbd_data_pad_o  	 => 	ps2_kbd_data_pad_o,
		ps2_aux_clk_pad_oe_o  	 => 	ps2_aux_clk_pad_oe_o,
		ps2_aux_clk_pad_o  	 => 	ps2_aux_clk_pad_o,
		ps2_aux_data_pad_oe_o  	 => 	ps2_aux_data_pad_oe_o,
		ps2_aux_data_pad_o  	 => 	ps2_aux_data_pad_o,
		ps2_kbd_clk_pad_i  	 => 	ps2_kbd_clk_pad_i,
		ps2_kbd_data_pad_i  	 => 	ps2_kbd_data_pad_i,
		ps2_aux_clk_pad_i  	 => 	ps2_aux_clk_pad_i,
		ps2_aux_data_pad_i  	 => 	ps2_aux_data_pad_i
		

	);


	Inst_wb_lpc_periph: wb_lpc_periph PORT MAP(
		clk_i => clk_lpc ,
		nrst_i => reset_n ,
		wbm_adr_o => xwbm_adr_i ,
		wbm_dat_o => xwbm_dat_i ,
		wbm_dat_i => xwbm_dat_o ,
		wbm_sel_o => xwbm_sel_i ,
		wbm_tga_o => xwbm_tga_i ,
		wbm_we_o => xwbm_we_i ,
		wbm_stb_o => xwbm_stb_i ,
		wbm_cyc_o => xwbm_cyc_i ,
		wbm_ack_i => xwbm_ack_o ,
		wbm_err_i => xwbm_err_o ,
		dma_chan_o => dma_bs1,
		dma_tc_o => dma_bs2,
		lframe_i => lframe ,
		lad_i => lad_i,
		lad_o => lad_o ,
		lad_oe => lad_oe
	);


	Inst_serirq_slave: serirq_slave PORT MAP(
		clk_i => clk_lpc ,
		nrst_i => reset_n ,
		irq_i => parallel_irq ,
		serirq_o => serirq_o ,
		serirq_i => serirq_i ,
		serirq_oe => serirq_oe 
	);




-- local Logic ------------------------------------------------------------------
    
	 process ( reset_n, lad_oe, lad_o)
    begin
       if (reset_n='0') then
           lad <= "ZZZZ";
       else
         if (lad_oe='1') then lad <= lad_o;
			else lad <= "ZZZZ";
			end if;
       end if;
    end process;  
    lad_i <= lad;  

	 process ( reset_n, serirq_oe , serirq_o )
    begin
       if (reset_n='0') then
           serirq <= 'Z';
       else
         if (serirq_oe ='1') then serirq <= serirq_o ;
			else serirq <= 'Z';
			end if;
       end if;
    end process;  
    serirq_i  <= serirq;  





--end file ----------------------------------------------------------------------
end Behavioral;