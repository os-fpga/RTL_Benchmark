----------------------------------------------------------------------------------
-- Company: Home, hobby project
-- Engineer: Istvan Nagy, buenos@freemail.hu
-- 
-- Create Date:    15:40:36 05/30/2010 
-- Design Name:  Spartan6-Blackfin-Board
-- Module Name:    s6bf_board_top - Behavioral 
-- Project Name: 
-- Target Devices: XC6SLX45T-2FGG484C
-- Tool versions: ISE 11.4
-- Description: 
-- 
-- Dependencies: 
--  Some cores were generated in CoreGenerator. We need to copy all sources
--  from the corename folders and some sources from the example_design folders.
--  If the core has an NGC file, then we need to copy that into this ISE project as well.
--  The project uses 2 UCF constraint files, s6bf_board_constraints.ucf is written by
--  PlanAhead with the pin-locations, and s6bf_board_TIMING-constraints.ucf has all other
--  constraints.
--  Required ISE settings: Synthesis-KeepHierarchy=Yes, Translate-AllowUnmatched_XX_Constraints=Yes
--  If there are timingerrors we still might want to procees to be able to analyze the violation
--  details. For this, we have to set the windows env.variable XIL_TIMING_ALLOW_IMPOSSIBLE to 1.
--  In the synthesis properties, pack IOB registers = off. Synthesis: Set the "FSM Encoding 
--  Algorithm" to "user". To make it configure in 500ms, set the bitgen option "config rate" to 33.
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--  ===========SYSTEM:=============
--
--  DDR2_chip (64Mbytes,500MT/s,x16)
--    |
-- [MEM.CO.]
--  | | | |_____ADC_INTERFACE<--ADS5517 A/D Converter (200MSPS,LVDS)
--  | | |_______DSP_INTERFACE<-->ADSP-BF544 DSP, (500MHz)
--  | |_________op2p_INTERFACE<-->RJ45 connector, (AC coupled, 2lanes, 2.5Gbps)
--  |___________PCIE-ENDPOINT,addr 3FFFFFF-7FFFFFF <-->card_edge (x1, PCIe 1.1)
--
-- PCIE endpoint BAR0 usage:
--  address 0...64kB: Control and status registers for the other interfaces.
--  address 64kB...128kB: DSP firmware FIFO, 64KB storage.
--  address 3FFFFFF...7FFFFFF: DDR SDRAM 
--
-- ADDRESSES ARE BYTE ADDRESSES. 
--The lower address bits are usually zero, so the slave (MCB) has to select bytes based 
--on the byte select signals: sel[3:0].
--
-- Control & Status Registers BAR0 Address Map (0000-1FFFF: LSB-bytes only):
-- -----------------------------------------------------------------------------
--  addr   name            bit7   bit6   bit5   bit4   bit3   bit2   bit1   bit0
--  00h    PGA_gain_reg    -      -      b5     b4     b3     b2     b1     b0
--  04h    ADC_cont_reg    start  finish oversh -      -      -      -      -
--  08h    ADC_trigg_reg   b7     b6     b5     b4     b3     b2     b1     b0
--  0Ch    DSP_contr_reg   boot   reset  irq    nmi    -      -      -      -
--  10h    DSP_flag_reg    -      -      -      -      out1   out0   in1    in0
--  14h    Debug Led Reg   -      -      -      -      led3   led2   led1   led0 
--  18h    Test RAM        32-bit RAM - - - - - - - - - - - - - - - - - - - - -
--  30h    irq_reg         status -      -      -      -      -      clear  glob.en
--  100h to 17F: Aurora config/status registers
--
-- 10000
--  to     DSP_instr_FIFO
-- 1FFFF
--
-- DDR memory map :
-- --------------------------
-- total(64MBytes): x400'0000...x7FF'FFFF, x comes from the BAR
-- DSP bank-0: covers the whole memory. Boot vector is x400'0000, x comes from the BAR
-- ADC buffering: 32kBytes from x600'0000...x6007FFF, x comes from the BAR,  
--                first sample at x600'0000
--
--
-- Resets:
-- The PCI-express endpoint gets the reset from the card edge, and provides a 
-- reset signal to all other devices in the system. The peripheral IPs provide
-- resets to the on-board peripherals.
--
-- Clocking:
-- The PCIE-EP gets its reference clock from the card edge.
-- The on-board 25MHz oscillator is used to:
--  Synthesize a 500MHz refclock for the MCB, by a PLL in jitter filtering mode.
--  Synthesize a 200MHz refclock for the ADC, by a PLL in jitter filtering mode.
--  Synthesize a 100MHz refclock for the AURORA, by a PLL in jitter filtering mode.
--  Drive it to the DSP as a reference clock, at 25MHz.
-- The on-chip parallel buses are driven by the peripherals at their own clocks.
-- These are: 62.5MHz for the PCIE and DSP, 50MHz for the ADC, 125MHz for the Aurora.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity s6bf_board_top is
    
	 Port ( --TOPLEVEL PORTS-----------------------
			 --ADC INTERFACE---
			  ADC_CLK_REFOUT_P : out    std_logic; --set LVDS+Rs --200MHz
			  ADC_CLK_REFOUT_N  : out    std_logic; --set LVDS+Rs			 
			  ADC_CLK_IN_P   : in    std_logic; --set LVDS+Rp, use GCLK-pin
			  ADC_CLK_IN_N   : in    std_logic; --set LVDS+Rp, use GCLK-pin
			  ADC_DATA_IN_P   : in    std_logic_vector(5 downto 0); --set LVDS+Rp, same bufio2-region
			  ADC_DATA_IN_N   : in    std_logic_vector(5 downto 0); --set LVDS+Rp, same bufio2-region
			  ADC_OE : out std_logic;
			  ADC_OVR : in std_logic;
			  ADC_SDATA : out std_logic;
			  ADC_SCLK : out std_logic;
			  ADC_SEN : out std_logic;
			  ADC_RESET : out std_logic;
			  PGA_DATA_out  : out    std_logic_vector(5 downto 0); 
			  PGA_STROBE : out std_logic; 
			  --DSP INTERFACE:
			  dsp_reset_n : out  STD_LOGIC;
			  dsp_refclk :   out  STD_LOGIC;	
			  dsp_ioclk: in  STD_LOGIC;  --to a GCLK pin!
			  dsp_bmode : out  STD_LOGIC_VECTOR (3 downto 0);
			  dsp_dmar1_n : out  STD_LOGIC;
			  dsp_hwait : in  STD_LOGIC;
			  dsp_ams_n : in  STD_LOGIC_VECTOR (3 downto 0);
			  dsp_data : inout  STD_LOGIC_VECTOR (15 downto 0);
			  dsp_abe_n :in  STD_LOGIC_VECTOR (1 downto 0);
			  dsp_awe_n : in  STD_LOGIC;  --to a GCLK pin!
			  dsp_aoe_n : in  STD_LOGIC;
			  dsp_are_n : in  STD_LOGIC;  --to a GCLK pin!
			  dsp_ardy : out  STD_LOGIC;
			  dsp_addr : in STD_LOGIC_VECTOR (25 downto 1);
			  dsp_flag_from_dsp : in  STD_LOGIC_VECTOR (1 downto 0);
			  dsp_flag_to_dsp : out  STD_LOGIC_VECTOR (1 downto 0);
			  dsp_uart_tx : out  STD_LOGIC;
			  dsp_uart_rx : in  STD_LOGIC;
			  dsp_interrupt : out  STD_LOGIC;
			  dsp_nmi_n : out  STD_LOGIC;
			  dsp_hostif_data :inout  STD_LOGIC_VECTOR (7 downto 0);
			  dsp_hostif_ce_n : out  STD_LOGIC;
			  dsp_hostif_rd_n : out  STD_LOGIC;
			  dsp_hostif_wr_n : out  STD_LOGIC;
			  dsp_hostif_addr : out  STD_LOGIC_VECTOR (1 downto 0);
			  dsp_hostif_ack : in  STD_LOGIC;
			  --AURORA INTERFACE:
           GTPD1_P  : in std_logic; --aurora GTP refclk P
           GTPD1_N  : in std_logic; --aurora GTP refclk N
           op2p_RXP  : in std_logic_vector(0 to 1);
           op2p_RXN  : in std_logic_vector(0 to 1);
           op2p_TXP  : out std_logic_vector(0 to 1);
           op2p_TXN  : out std_logic_vector(0 to 1);
			  --aurora reference clock setting:
			  op2p_refclkset_od0 : out std_logic;
			  op2p_refclkset_od1 : out std_logic;
			  op2p_refclkset_od2 : out std_logic;
			  op2p_refclkset_pr0 : out std_logic;
			  op2p_refclkset_pr1 : out std_logic;			  
			  --DDR MEMORY PINS:
			  mcb3_dram_dq        : inout  std_logic_vector(15 downto 0);
			  mcb3_dram_a         : out std_logic_vector(12 downto 0);
			  mcb3_dram_ba        : out std_logic_vector(1 downto 0);
			  mcb3_dram_ras_n     : out std_logic;
			  mcb3_dram_cas_n     : out std_logic;
			  mcb3_dram_we_n      : out std_logic;
			  mcb3_dram_odt       : out std_logic;
			  mcb3_dram_cke       : out std_logic;
			  mcb3_dram_dm        : out std_logic;
			  mcb3_dram_udqs      : inout  std_logic;
			  mcb3_dram_udqs_n    : inout  std_logic;
			  mcb3_rzq            : inout  std_logic;
			  mcb3_zio            : inout  std_logic;
			  mcb3_dram_udm       : out std_logic;
			  mcb3_dram_dqs       : inout  std_logic;
			  mcb3_dram_dqs_n     : inout  std_logic;
			  mcb3_dram_ck        : out std_logic;
			  mcb3_dram_ck_n      : out std_logic;		
			  --PCI-EXPRESS INTERFACE:
			  pci_exp_txp             : out std_logic;
			  pci_exp_txn             : out std_logic;
			  pci_exp_rxp             : in  std_logic;
			  pci_exp_rxn             : in  std_logic;	 
			  sys_clk_n                 : in  std_logic;
			  sys_clk_p                 : in  std_logic;
			  --RESET:
			  --On board-revision-1 there is a bug that makes the PCIe card-edge reset to be unusable.
			  --As a workaround, generate a reset internally, and driven out to the board for the Aurora/Clock/PLL chip.
			  --if it was working, the sys_reset_n pin would be an input, and the self-reset generator logic at the 
			  --bottom of this file would be commented out or deleted.
			  sys_reset_n             : out  std_logic;	--output for board rev-1		  
			  -- OTHER:
			  x25m_clkin_pin : in  STD_LOGIC;
			  x25m_clkout : out  STD_LOGIC;
			  led0 : out  STD_LOGIC;
			  led1 : out  STD_LOGIC;
			  led2 : out  STD_LOGIC;
			  led3 : out  STD_LOGIC
			  );
end s6bf_board_top;

-- --------ARCHITECTURE BEGINS ----------------------------------------------------
architecture Behavioral of s6bf_board_top is

   -- Internal Signals ------------------------------------------------------------
	--SIGNAL dummy : std_logic_vector(15 downto 0);	--write data bus
	
	--ADC controller onchip signals:
	SIGNAL adcif_wb_data_o :   std_logic_vector(31 downto 0); 
	SIGNAL adcif_wb_data_i :   std_logic_vector(31 downto 0);
	SIGNAL adcif_wb_addr_o :   std_logic_vector(25 downto 0);
	SIGNAL adcif_wb_cyc_o :   std_logic;
	SIGNAL adcif_wb_stb_o :   std_logic;
	SIGNAL adcif_wb_wr_o :   std_logic;
	SIGNAL adcif_wb_ack_i :   std_logic;
	SIGNAL adcif_wb_clk_o :   std_logic; --50MHz
	SIGNAL adcif_wb_sel_o :   std_logic_vector(3 downto 0);
	--CONTROL:
	SIGNAL adc_overshoot_detected :   std_logic;
	SIGNAL pga_gain  :   std_logic_vector(5 downto 0); 
	SIGNAL adc_triggerlevel :   std_logic_vector(7 downto 0); 
	SIGNAL adc_start :    std_logic; --edge sensitive
	SIGNAL adc_finished :    std_logic;
	--SYSTEM:
	SIGNAL x25m_clk  :   std_logic;
	SIGNAL adcif_reset :   std_logic; --active high

	--DSP INTERFACE onchip signals
	--DATA BUS (wishbone):
	SIGNAL dspif_wb_data_o :  std_logic_vector(31 downto 0); 
	SIGNAL dspif_wb_data_i :  std_logic_vector(31 downto 0);
	SIGNAL dspif_wb_addr_o :  std_logic_vector(25 downto 0);
	SIGNAL dspif_wb_cyc_o :  std_logic;
	SIGNAL dspif_wb_stb_o :  std_logic;
	SIGNAL dspif_wb_wr_o :  std_logic;
	SIGNAL dspif_wb_ack_i :  std_logic;
	SIGNAL dspif_wb_clk_o :  std_logic; 
	SIGNAL dspif_wb_sel_o : std_logic_vector(3 downto 0);
	--instruction buffer :
	SIGNAL dsp_instr_wb_data_o :  std_logic_vector(31 downto 0); 
	SIGNAL dsp_instr_wb_data_i :  std_logic_vector(31 downto 0);
	SIGNAL dsp_instr_wb_addr_o :  std_logic_vector(15 downto 0);
	SIGNAL dsp_instr_wb_cyc_o :  std_logic;
	SIGNAL dsp_instr_wb_stb_o :  std_logic;
	SIGNAL dsp_instr_wb_wr_o :  std_logic;
	SIGNAL dsp_instr_wb_ack_i :  std_logic;
	SIGNAL dsp_instr_wb_clk_o :  std_logic; 
	--Control:
	SIGNAL dsp_start_boot_frompcie :  std_logic;
	SIGNAL dsp_reset_control_frompcie :  std_logic;
	SIGNAL dsp_irq_frompcie :  std_logic; 
	SIGNAL dsp_nmi_frompcie :  std_logic; 
	SIGNAL dsp_flag_to_pcie :   STD_LOGIC_VECTOR (1 downto 0);
	SIGNAL dsp_flag_from_pcie :   STD_LOGIC_VECTOR (1 downto 0);	 
	--System:
	--SIGNAL x25m_clkin :  std_logic;
	SIGNAL dspif_reset :  std_logic; --active high

	--AURORA INTERFACE ONCHIP SIGNALS:
	--DATA BUS (wishbone):
	SIGNAL op2p_memory_wb_data_o : std_logic_vector(31 downto 0); 
	SIGNAL op2p_memory_wb_data_i : std_logic_vector(31 downto 0);
	SIGNAL op2p_memory_wb_addr_o : std_logic_vector(25 downto 0);
	SIGNAL op2p_memory_wb_cyc_o : std_logic;
	SIGNAL op2p_memory_wb_stb_o : std_logic;
	SIGNAL op2p_memory_wb_wr_o : std_logic;
	SIGNAL op2p_memory_wb_ack_i : std_logic;
	SIGNAL op2p_memory_wb_clk_o : std_logic; 
	SIGNAL op2p_memory_wb_sel_o :  std_logic_vector(3 downto 0);
	--instruction registers :
	SIGNAL op2p_config_wb_data_o : std_logic_vector(31 downto 0); 
	SIGNAL op2p_config_wb_data_i : std_logic_vector(31 downto 0);
	SIGNAL op2p_config_wb_addr_i : std_logic_vector(6 downto 0);
	SIGNAL op2p_config_wb_cyc_i : std_logic;
	SIGNAL op2p_config_wb_stb_i : std_logic;
	SIGNAL op2p_config_wb_wr_i : std_logic;
	SIGNAL op2p_config_wb_ack_o : std_logic;
	SIGNAL op2p_config_wb_clk_i : std_logic; 		
	--completion flags	SIGNAL 
	SIGNAL op2p_reset : std_logic;
	--SIGNAL x25m_clk : std_logic;
	SIGNAL tx_completed :  STD_LOGIC;
	SIGNAL rx_completed :  STD_LOGIC;

	--PCIE-INTERFACE ON CHIP PORTS:
	--DATA BUS (wishbone):
	SIGNAL pcieif_wb_data_o : std_logic_vector(31 downto 0); 
	SIGNAL pcieif_wb_data_i : std_logic_vector(31 downto 0);
	SIGNAL pcieif_wb_addr_o : std_logic_vector(25 downto 0);
	SIGNAL pcieif_wb_cyc_o : std_logic;
	SIGNAL pcieif_wb_stb_o : std_logic;
	SIGNAL pcieif_wb_wr_o : std_logic;
	SIGNAL pcieif_wb_ack_i : std_logic;
	SIGNAL pcieif_wb_clk_o : std_logic; --62.5MHz	
	SIGNAL pcieif_wb_sel_o : std_logic_vector(3 downto 0);	
	SIGNAL op2p_config_wb_sel_o :  std_logic_vector(3 downto 0);	
	SIGNAL dsp_instr_wb_sel_o :  std_logic_vector(3 downto 0);			
	--OTHER:
	SIGNAL pcie_resetout  :  std_logic;
	SIGNAL op2p_irq  :  std_logic;
	SIGNAL x25m_clkin :  std_logic;
	SIGNAL x25m_clkin_intermediate :  std_logic;
	SIGNAL sys_reset_n_local :  std_logic;
	SIGNAL sysreset_counter :  std_logic_vector(21 downto 0);
	SIGNAL sys_reset_n_local_2ms :  std_logic;
	SIGNAL sysreset_counter_2ms :  std_logic_vector(15 downto 0) := "0000000011111111";
	SIGNAL sys_reset_n_local_2msb :  std_logic;
	SIGNAL sysreset_counter_2msb :  std_logic_vector(15 downto 0) := "1111111100000000";
	
	SIGNAL dummy1 :  std_logic;
	SIGNAL dummy2 :  std_logic;
	SIGNAL CHANNEL_UP_copy : std_logic;
	

	-- COMPONENT DECLARATIONS (introducing the IPs) --------------------------------

	COMPONENT s6bfip_adc
	PORT(
		ADC_CLK_IN_P : IN std_logic;
		ADC_CLK_IN_N : IN std_logic;
		ADC_DATA_IN_P : IN std_logic_vector(5 downto 0);
		ADC_DATA_IN_N : IN std_logic_vector(5 downto 0);
		ADC_OVR : IN std_logic;
		adcif_wb_data_i : IN std_logic_vector(31 downto 0);
		adcif_wb_ack_i : IN std_logic;
		pga_gain : IN std_logic_vector(5 downto 0);
		adc_triggerlevel : IN std_logic_vector(7 downto 0);
		adc_start : IN std_logic;
		x25m_clkin : IN std_logic;
		adcif_reset : IN std_logic;          
		ADC_CLK_REFOUT_P : OUT std_logic;
		ADC_CLK_REFOUT_N : OUT std_logic;
		ADC_OE : OUT std_logic;
		ADC_SDATA : OUT std_logic;
		ADC_SCLK : OUT std_logic;
		ADC_SEN : OUT std_logic;
		ADC_RESET : OUT std_logic;
		PGA_DATA_out : OUT std_logic_vector(5 downto 0);
		PGA_STROBE : OUT std_logic;
		adcif_wb_data_o : OUT std_logic_vector(31 downto 0);
		adcif_wb_addr_o : OUT std_logic_vector(25 downto 0);
		adcif_wb_cyc_o : OUT std_logic;
		adcif_wb_stb_o : OUT std_logic;
		adcif_wb_wr_o : OUT std_logic;
		adcif_wb_clk_o : OUT std_logic;
		adcif_wb_sel_o : out std_logic_vector(3 downto 0);
		adc_overshoot_detected : OUT std_logic;
		adc_finished : OUT std_logic
		);
	END COMPONENT;



	COMPONENT s6bfip_dsp
	PORT(
		dsp_ioclk : IN std_logic;
		dsp_hwait : IN std_logic;
		dsp_ams_n : IN std_logic_vector(3 downto 0);
		dsp_abe_n : IN std_logic_vector(1 downto 0);
		dsp_awe_n : IN std_logic;
		dsp_aoe_n : IN std_logic;
		dsp_are_n : IN std_logic;
		dsp_addr : IN std_logic_vector(25 downto 1);
		dsp_flag_from_dsp : IN std_logic_vector(1 downto 0);
		dsp_uart_rx : IN std_logic;
		dsp_hostif_ack : IN std_logic;
		dspif_wb_data_i : IN std_logic_vector(31 downto 0);
		dspif_wb_ack_i : IN std_logic;
		dsp_instr_wb_data_o : IN std_logic_vector(31 downto 0);
		dsp_instr_wb_addr_o : IN std_logic_vector(15 downto 0);
		dsp_instr_wb_cyc_o : IN std_logic;
		dsp_instr_wb_stb_o : IN std_logic;
		dsp_instr_wb_wr_o : IN std_logic;
		dsp_instr_wb_clk_o : IN std_logic;
		dsp_instr_wb_sel_o :  IN std_logic_vector(3 downto 0);	
		dsp_start_boot_frompcie : IN std_logic;
		dsp_reset_control_frompcie : IN std_logic;
		dsp_irq_frompcie : IN std_logic;
		dsp_nmi_frompcie : IN std_logic;
		dsp_flag_from_pcie : IN std_logic_vector(1 downto 0);
		x25m_clkin : IN std_logic;
		dspif_reset : IN std_logic;    
		dsp_data : INOUT std_logic_vector(15 downto 0);
		dsp_hostif_data : INOUT std_logic_vector(7 downto 0);      
		dsp_reset_n : OUT std_logic;
		dsp_refclk : OUT std_logic;
		dsp_bmode : OUT std_logic_vector(3 downto 0);
		dsp_dmar1_n : OUT std_logic;
		dsp_ardy : OUT std_logic;
		dsp_flag_to_dsp : OUT std_logic_vector(1 downto 0);
		dsp_uart_tx : OUT std_logic;
		dsp_interrupt : OUT std_logic;
		dsp_nmi_n : OUT std_logic;
		dsp_hostif_ce_n : OUT std_logic;
		dsp_hostif_rd_n : OUT std_logic;
		dsp_hostif_wr_n : OUT std_logic;
		dsp_hostif_addr : OUT std_logic_vector(1 downto 0);
		dspif_wb_data_o : OUT std_logic_vector(31 downto 0);
		dspif_wb_addr_o : OUT std_logic_vector(25 downto 0);
		dspif_wb_cyc_o : OUT std_logic;
		dspif_wb_stb_o : OUT std_logic;
		dspif_wb_wr_o : OUT std_logic;
		dspif_wb_clk_o : OUT std_logic;
		dspif_wb_sel_o : out std_logic_vector(3 downto 0);
		dsp_instr_wb_data_i : OUT std_logic_vector(31 downto 0);
		dsp_instr_wb_ack_i : OUT std_logic;
		dsp_flag_to_pcie : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

	COMPONENT op2p
    Port ( --FPGA PINS (EXTERNAL):
           GTPD1_P  : in std_logic; --aurora GTP refclk P
           GTPD1_N  : in std_logic; --aurora GTP refclk N
           op2p_RXP  : in std_logic_vector(0 to 1);
           op2p_RXN  : in std_logic_vector(0 to 1);
           op2p_TXP  : out std_logic_vector(0 to 1);
           op2p_TXN  : out std_logic_vector(0 to 1);
			  --INTERNAL PORTS:
			  --DATA BUS (wishbone):
			  op2p_memory_wb_data_o : out std_logic_vector(31 downto 0); 
			  op2p_memory_wb_data_i : in std_logic_vector(31 downto 0);
			  op2p_memory_wb_addr_o : out std_logic_vector(25 downto 0);
			  op2p_memory_wb_cyc_o : out std_logic;
			  op2p_memory_wb_stb_o : out std_logic;
			  op2p_memory_wb_wr_o : out std_logic;
			  op2p_memory_wb_ack_i : in std_logic;
			  op2p_memory_wb_clk_o : out std_logic; 
			  op2p_memory_wb_sel_o : out std_logic_vector(3 downto 0);
			  --instruction registers :
			  op2p_config_wb_data_o : in std_logic_vector(31 downto 0); 
			  op2p_config_wb_data_i : out std_logic_vector(31 downto 0);
			  op2p_config_wb_addr_i : in std_logic_vector(6 downto 0);
			  op2p_config_wb_cyc_i : in std_logic;
			  op2p_config_wb_stb_i : in std_logic;
			  op2p_config_wb_wr_i : in std_logic;
			  op2p_config_wb_ack_o : out std_logic;
			  op2p_config_wb_clk_i : in std_logic; 		
			  op2p_config_wb_sel_o :  in std_logic_vector(3 downto 0);	
			  --reference clock setting:
			  op2p_refclkset_od0 : out std_logic;
			  op2p_refclkset_od1 : out std_logic;
			  op2p_refclkset_od2 : out std_logic;
			  op2p_refclkset_pr0 : out std_logic;
			  op2p_refclkset_pr1 : out std_logic;
			  --irq:
			  op2p_irq : out  STD_LOGIC;			  
			  op2p_reset : in std_logic;
			  CHANNEL_UP_copy : out std_logic;
			  x25m_clk : in std_logic
			 );
	END COMPONENT;


	COMPONENT s6bfip_memory
    Port (--FPGA_PINS (EXTERNAL):
			  mcb3_dram_dq        : inout  std_logic_vector(15 downto 0);
			  mcb3_dram_a         : out std_logic_vector(12 downto 0);
			  mcb3_dram_ba        : out std_logic_vector(1 downto 0);
			  mcb3_dram_ras_n     : out std_logic;
			  mcb3_dram_cas_n     : out std_logic;
			  mcb3_dram_we_n      : out std_logic;
			  mcb3_dram_odt       : out std_logic;
			  mcb3_dram_cke       : out std_logic;
			  mcb3_dram_dm        : out std_logic;
			  mcb3_dram_udqs      : inout  std_logic;
			  mcb3_dram_udqs_n    : inout  std_logic;
			  mcb3_rzq            : inout  std_logic;
			  mcb3_zio            : inout  std_logic;
			  mcb3_dram_udm       : out std_logic;
			  mcb3_dram_dqs       : inout  std_logic;
			  mcb3_dram_dqs_n     : inout  std_logic;
			  mcb3_dram_ck        : out std_logic;
			  mcb3_dram_ck_n      : out std_logic;	
			  --ONCHIP PORTS:
			  --channel-0
			  channel0_wb_data_i : in std_logic_vector(31 downto 0); 
			  channel0_wb_data_o : out std_logic_vector(31 downto 0);
			  channel0_wb_addr_i : in std_logic_vector(25 downto 0);
			  channel0_wb_cyc_i : in std_logic;
			  channel0_wb_stb_i : in std_logic;
			  channel0_wb_wr_i : in std_logic;
			  channel0_wb_ack_o : out std_logic;
			  channel0_wb_clk_i : in std_logic; 	
			  channel0_wb_sel_i : in std_logic_vector(3 downto 0);
			  --channel-1
			  channel1_wb_data_i : in std_logic_vector(31 downto 0); 
			  channel1_wb_data_o : out std_logic_vector(31 downto 0);
			  channel1_wb_addr_i : in std_logic_vector(25 downto 0);
			  channel1_wb_cyc_i : in std_logic;
			  channel1_wb_stb_i : in std_logic;
			  channel1_wb_wr_i : in std_logic;
			  channel1_wb_ack_o : out std_logic;
			  channel1_wb_clk_i : in std_logic; 
			  channel1_wb_sel_i : in std_logic_vector(3 downto 0);
			  --channel-2
			  channel2_wb_data_i : in std_logic_vector(31 downto 0); 
			  channel2_wb_data_o : out std_logic_vector(31 downto 0);
			  channel2_wb_addr_i : in std_logic_vector(25 downto 0);
			  channel2_wb_cyc_i : in std_logic;
			  channel2_wb_stb_i : in std_logic;
			  channel2_wb_wr_i : in std_logic;
			  channel2_wb_ack_o : out std_logic;
			  channel2_wb_clk_i : in std_logic; 
			  channel2_wb_sel_i : in std_logic_vector(3 downto 0);
			  --channel-3
			  channel3_wb_data_i : in std_logic_vector(31 downto 0); 
			  channel3_wb_data_o : out std_logic_vector(31 downto 0);
			  channel3_wb_addr_i : in std_logic_vector(25 downto 0);
			  channel3_wb_cyc_i : in std_logic;
			  channel3_wb_stb_i : in std_logic;
			  channel3_wb_wr_i : in std_logic;
			  channel3_wb_ack_o : out std_logic;
			  channel3_wb_clk_i : in std_logic; 
			  channel3_wb_sel_i : in std_logic_vector(3 downto 0);
			  --System signals:
			  x25m_clk : in std_logic; 
			  reset : in std_logic 
			 );
	END COMPONENT;

	COMPONENT s6bfip_pcie
    Port ( --FPGA PINS(EXTERNAL):
			 pci_exp_txp             : out std_logic;
			 pci_exp_txn             : out std_logic;
			 pci_exp_rxp             : in  std_logic;
			 pci_exp_rxn             : in  std_logic;	 
			 sys_clk_n                 : in  std_logic;
			 sys_clk_p                 : in  std_logic;
			 sys_reset_n             : in  std_logic;			 
			 --ON CHIP PORTS:
			 --DATA BUS (wishbone):
			 pcieif_wb_data_o : out std_logic_vector(31 downto 0); 
			 pcieif_wb_data_i : in std_logic_vector(31 downto 0);
			 pcieif_wb_addr_o : out std_logic_vector(25 downto 0);
			 pcieif_wb_cyc_o : out std_logic;
			 pcieif_wb_stb_o : out std_logic;
			 pcieif_wb_wr_o : out std_logic;
			 pcieif_wb_ack_i : in std_logic;
			 pcieif_wb_clk_o : out std_logic; --62.5MHz	
			 pcieif_wb_sel_o : out std_logic_vector(3 downto 0);
			 --AURORA control bus:
			  op2p_config_wb_data_o : out std_logic_vector(31 downto 0); 
			  op2p_config_wb_data_i : in std_logic_vector(31 downto 0);
			  op2p_config_wb_addr_i : out std_logic_vector(6 downto 0);
			  op2p_config_wb_cyc_i : out std_logic;
			  op2p_config_wb_stb_i : out std_logic;
			  op2p_config_wb_wr_i : out std_logic;
			  op2p_config_wb_ack_o : in std_logic;
			  op2p_config_wb_clk_i : out std_logic; 
			  op2p_config_wb_sel_o : out std_logic_vector(3 downto 0);	
			  op2p_irq : in std_logic;
			 --DSP firmware loader bus:
			  dsp_instr_wb_data_o : out std_logic_vector(31 downto 0); 
			  dsp_instr_wb_data_i : in std_logic_vector(31 downto 0);
			  dsp_instr_wb_addr_o : out std_logic_vector(15 downto 0);
			  dsp_instr_wb_cyc_o : out std_logic;
			  dsp_instr_wb_stb_o : out std_logic;
			  dsp_instr_wb_wr_o : out std_logic;
			  dsp_instr_wb_ack_i : in std_logic;
			  dsp_instr_wb_clk_o : out std_logic; 	
			  dsp_instr_wb_sel_o : out std_logic_vector(3 downto 0);				 
			 --ADC control signals:
			  adc_overshoot_detected : in std_logic;
			  pga_gain : out std_logic_vector(5 downto 0); 
			  adc_triggerlevel : out std_logic_vector(7 downto 0); 
			  adc_start : out  std_logic; --edge sensitive
			  adc_finished : in  std_logic;
			 --LEDS:
			  led0 : out  STD_LOGIC;
			  led1 : out  STD_LOGIC;
			  led2 : out  STD_LOGIC;
			  led3 : out  STD_LOGIC;		  
			 --DSP control signals:
			  dsp_start_boot_frompcie : out std_logic;
			  dsp_reset_control_frompcie : out std_logic;
			  dsp_irq_frompcie : out std_logic; 
			  dsp_nmi_frompcie : out std_logic; 
			  dsp_flag_to_pcie : in  STD_LOGIC_VECTOR (1 downto 0);
			  dsp_flag_from_pcie : out  STD_LOGIC_VECTOR (1 downto 0);				 
			 --OTHER:
			 pcie_resetout  : out std_logic		 
			);
	END COMPONENT;




-- ------- SYNTHESIS ATTRIBUTES: --------------------------------------------------
--attribute keep_hierarchy : string; 
--attribute keep_hierarchy of s6bf_board_top: entity is "yes"; 
--attribute keep_hierarchy of xilinx_pcie2wb: entity is "yes"; 
--attribute keep_hierarchy of op2p_exmpl_des_modified: entity is "yes"; 
--attribute keep_hierarchy of s6bfip_pcie: entity is "yes"; 
--attribute keep_hierarchy of s6bfip_memory: entity is "yes"; 
--attribute keep_hierarchy of op2p: entity is "yes"; 
--attribute keep_hierarchy of s6bfip_adc: entity is "yes"; 
--attribute keep_hierarchy of s6bfip_dsp: entity is "yes"; 




-- --------ARCHITECTURE BODY BEGINS -----------------------------------------------
begin




	-- COMPONENT INSTALLATIONS (connecting the IPs to local signals) ---------------
	
		
		
		
	--ADC interface			
	Inst_s6bfip_adc: s6bfip_adc PORT MAP(			
		ADC_CLK_REFOUT_P	=>	ADC_CLK_REFOUT_P,
		ADC_CLK_REFOUT_N	=>	ADC_CLK_REFOUT_N,
		ADC_CLK_IN_P	=>	ADC_CLK_IN_P,			
		ADC_CLK_IN_N	=>	ADC_CLK_IN_N,			
		ADC_DATA_IN_P	=>	ADC_DATA_IN_P,			
		ADC_DATA_IN_N	=>	ADC_DATA_IN_N,			
		ADC_OE	=>	ADC_OE,			
		ADC_OVR	=>	ADC_OVR,
		ADC_SDATA	=>	ADC_SDATA,			
		ADC_SCLK	=>	ADC_SCLK,			
		ADC_SEN	=>	ADC_SEN,
		ADC_RESET	=>	ADC_RESET,			
		PGA_DATA_out	=>	PGA_DATA_out,			
		PGA_STROBE	=>	PGA_STROBE,			
		adcif_wb_data_o	=>	adcif_wb_data_o,			
		adcif_wb_data_i	=>	adcif_wb_data_i,			
		adcif_wb_addr_o	=>	adcif_wb_addr_o,			
		adcif_wb_cyc_o	=>	adcif_wb_cyc_o,			
		adcif_wb_stb_o	=>	adcif_wb_stb_o,			
		adcif_wb_wr_o	=>	adcif_wb_wr_o,			
		adcif_wb_ack_i	=>	adcif_wb_ack_i,			
		adcif_wb_clk_o	=>	adcif_wb_clk_o,	
		adcif_wb_sel_o => adcif_wb_sel_o,	
		adc_overshoot_detected	=>	adc_overshoot_detected,
		pga_gain	=>	pga_gain,			
		adc_triggerlevel	=>	adc_triggerlevel,
		adc_start	=>	adc_start,			
		adc_finished	=>	adc_finished,			
		x25m_clkin	=>	x25m_clkin,			
		adcif_reset	=>	pcie_resetout				
	);	
		
		
		
	--DSP interface:
	Inst_s6bfip_dsp: s6bfip_dsp PORT MAP(			
		dsp_reset_n	=>	dsp_reset_n,			
		dsp_refclk	=>	dsp_refclk,			
		dsp_ioclk	=>	dsp_ioclk,			
		dsp_bmode	=>	dsp_bmode,			
		dsp_dmar1_n	=>	dsp_dmar1_n,			
		dsp_hwait	=>	dsp_hwait,			
		dsp_ams_n	=>	dsp_ams_n,			
		dsp_data	=>	dsp_data,			
		dsp_abe_n	=>	dsp_abe_n,			
		dsp_awe_n	=>	dsp_awe_n,			
		dsp_aoe_n	=>	dsp_aoe_n,			
		dsp_are_n	=>	dsp_are_n,			
		dsp_ardy	=>	dsp_ardy,			
		dsp_addr	=>	dsp_addr,			
		dsp_flag_from_dsp	=>	dsp_flag_from_dsp,
		dsp_flag_to_dsp	=>	dsp_flag_to_dsp,			
		dsp_uart_tx	=>	dsp_uart_tx,			
		dsp_uart_rx	=>	dsp_uart_rx,			
		dsp_interrupt	=>	dsp_interrupt,			
		dsp_nmi_n		=>	dsp_nmi_n,
		dsp_hostif_data	=>	dsp_hostif_data,			
		dsp_hostif_ce_n	=>	dsp_hostif_ce_n,			
		dsp_hostif_rd_n	=>	dsp_hostif_rd_n,			
		dsp_hostif_wr_n	=>	dsp_hostif_wr_n,			
		dsp_hostif_addr	=>	dsp_hostif_addr,			
		dsp_hostif_ack	=>	dsp_hostif_ack,			
		dspif_wb_data_o	=>	dspif_wb_data_o,			
		dspif_wb_data_i	=>	dspif_wb_data_i,			
		dspif_wb_addr_o	=>	dspif_wb_addr_o,			
		dspif_wb_cyc_o	=>	dspif_wb_cyc_o,			
		dspif_wb_stb_o	=>	dspif_wb_stb_o,			
		dspif_wb_wr_o	=>	dspif_wb_wr_o,			
		dspif_wb_ack_i	=>	dspif_wb_ack_i,			
		dspif_wb_clk_o	=>	dspif_wb_clk_o,	
		dspif_wb_sel_o => dspif_wb_sel_o,
		dsp_instr_wb_data_o	=>	dsp_instr_wb_data_o,
		dsp_instr_wb_data_i	=>	dsp_instr_wb_data_i,
		dsp_instr_wb_addr_o	=>	dsp_instr_wb_addr_o,
		dsp_instr_wb_cyc_o	=>	dsp_instr_wb_cyc_o,
		dsp_instr_wb_stb_o	=>	dsp_instr_wb_stb_o,
		dsp_instr_wb_wr_o	=>	dsp_instr_wb_wr_o,
		dsp_instr_wb_ack_i	=>	dsp_instr_wb_ack_i,
		dsp_instr_wb_clk_o	=>	dsp_instr_wb_clk_o,
		dsp_instr_wb_sel_o => dsp_instr_wb_sel_o,
		dsp_start_boot_frompcie	=>	dsp_start_boot_frompcie,			
		dsp_reset_control_frompcie	=>	dsp_reset_control_frompcie,			
		dsp_irq_frompcie	=> adc_finished, ----ASSERT IRQ WHEN THE ADC FINISHED BUFFERING or use: dsp_irq_frompcie,
		dsp_nmi_frompcie	=>	 dsp_nmi_frompcie,
		dsp_flag_to_pcie	=>	dsp_flag_to_pcie,
		dsp_flag_from_pcie	=>	dsp_flag_from_pcie,
		x25m_clkin	=>	x25m_clkin,			
		dspif_reset	=>	pcie_resetout				
	);	
		
		
	Inst_s6bfip_aurora:	op2p	PORT MAP(		
      GTPD1_P  => GTPD1_P, --aurora GTP refclk P
      GTPD1_N  => GTPD1_N, --aurora GTP refclk N
		op2p_RXP	=>	op2p_RXP,		
		op2p_RXN	=>	op2p_RXN,		
		op2p_TXP	=>	op2p_TXP,		
		op2p_TXN	=>	op2p_TXN,		
		--INTERNAL PORTS:		
		--DATA BUS (wishbone):			
		op2p_memory_wb_data_o	=>	op2p_memory_wb_data_o,		
		op2p_memory_wb_data_i	=>	op2p_memory_wb_data_i,		
		op2p_memory_wb_addr_o	=>	op2p_memory_wb_addr_o,		
		op2p_memory_wb_cyc_o	=>	op2p_memory_wb_cyc_o,		
		op2p_memory_wb_stb_o	=>	op2p_memory_wb_stb_o,		
		op2p_memory_wb_wr_o	=>	op2p_memory_wb_wr_o,		
		op2p_memory_wb_ack_i	=>	op2p_memory_wb_ack_i,		
		op2p_memory_wb_clk_o	=>	op2p_memory_wb_clk_o,	
		op2p_memory_wb_sel_o => op2p_memory_wb_sel_o,	
		--instruction registers	:			
		op2p_config_wb_data_o	=>	op2p_config_wb_data_o,		
		op2p_config_wb_data_i	=>	op2p_config_wb_data_i,		
		op2p_config_wb_addr_i	=>	op2p_config_wb_addr_i,		
		op2p_config_wb_cyc_i	=>	op2p_config_wb_cyc_i,		
		op2p_config_wb_stb_i	=>	op2p_config_wb_stb_i,		
		op2p_config_wb_wr_i	=>	op2p_config_wb_wr_i,		
		op2p_config_wb_ack_o	=>	op2p_config_wb_ack_o,		
		op2p_config_wb_clk_i	=>	op2p_config_wb_clk_i,		
		op2p_config_wb_sel_o => op2p_config_wb_sel_o,
		--reference clock setting:
		op2p_refclkset_od0  => op2p_refclkset_od0,
		op2p_refclkset_od1  => op2p_refclkset_od1,
		op2p_refclkset_od2  => op2p_refclkset_od2,
		op2p_refclkset_pr0  => op2p_refclkset_pr0,
		op2p_refclkset_pr1  => op2p_refclkset_pr1,
		--irq:
		op2p_irq =>op2p_irq,		
		op2p_reset	=>	pcie_resetout,
		CHANNEL_UP_copy => CHANNEL_UP_copy,
		x25m_clk	=>	x25m_clkin			
	);	
		
		
		
	Inst_s6bfip_memory: s6bfip_memory PORT MAP(			
		mcb3_dram_dq	=>	mcb3_dram_dq,	--vector(15 downto 0)		
		mcb3_dram_a	=>	mcb3_dram_a,    --vector(12 downto 0)				
		mcb3_dram_ba	=>	mcb3_dram_ba,	--vector(1 downto 0)		
		mcb3_dram_ras_n	=>	mcb3_dram_ras_n,		
		mcb3_dram_cas_n	=>	mcb3_dram_cas_n,		
		mcb3_dram_we_n	=>	mcb3_dram_we_n,		
		mcb3_dram_odt	=>	mcb3_dram_odt,		
		mcb3_dram_cke	=>	mcb3_dram_cke,		
		mcb3_dram_dm	=>	mcb3_dram_dm,		
		mcb3_dram_udqs	=>	mcb3_dram_udqs,		
		mcb3_dram_udqs_n	=>	mcb3_dram_udqs_n,		
		mcb3_rzq	=>	mcb3_rzq,		
		mcb3_zio	=>	mcb3_zio,		
		mcb3_dram_udm	=>	mcb3_dram_udm,		
		mcb3_dram_dqs	=>	mcb3_dram_dqs,		
		mcb3_dram_dqs_n	=>	mcb3_dram_dqs_n,		
		mcb3_dram_ck	=>	mcb3_dram_ck,		
		mcb3_dram_ck_n	=>	mcb3_dram_ck_n,		
		--ONCHIP PORTS:		
		--channel-0			
		channel0_wb_data_o	=>	pcieif_wb_data_i, --vector(31 downto 0)
		channel0_wb_data_i	=>	pcieif_wb_data_o, --vector(31 downto 0)
		channel0_wb_addr_i	=>	pcieif_wb_addr_o, --vector(25 downto 0)
		channel0_wb_cyc_i	=>	pcieif_wb_cyc_o,		
		channel0_wb_stb_i	=>	pcieif_wb_stb_o,		
		channel0_wb_wr_i	=>	pcieif_wb_wr_o,		
		channel0_wb_ack_o	=>	pcieif_wb_ack_i,		
		channel0_wb_clk_i	=>	pcieif_wb_clk_o,	
		channel0_wb_sel_i =>	pcieif_wb_sel_o,
		--channel-1			
		channel1_wb_data_o	=>	adcif_wb_data_i, --vector(31 downto 0)
		channel1_wb_data_i	=>	adcif_wb_data_o, --vector(31 downto 0)
		channel1_wb_addr_i	=>	adcif_wb_addr_o, --vector(25 downto 0)
		channel1_wb_cyc_i	=>	adcif_wb_cyc_o,		
		channel1_wb_stb_i	=>	adcif_wb_stb_o,		
		channel1_wb_wr_i	=>	adcif_wb_wr_o,		
		channel1_wb_ack_o	=>	adcif_wb_ack_i,		
		channel1_wb_clk_i	=>	adcif_wb_clk_o,	
		channel1_wb_sel_i =>	adcif_wb_sel_o,
		--channel-2			
		channel2_wb_data_o	=>	dspif_wb_data_i, --vector(31 downto 0)
		channel2_wb_data_i	=>	dspif_wb_data_o, --vector(31 downto 0)
		channel2_wb_addr_i	=>	dspif_wb_addr_o, --vector(25 downto 0)
		channel2_wb_cyc_i	=>	dspif_wb_cyc_o,		
		channel2_wb_stb_i	=>	dspif_wb_stb_o,		
		channel2_wb_wr_i	=>	dspif_wb_wr_o,		
		channel2_wb_ack_o	=>	dspif_wb_ack_i,		
		channel2_wb_clk_i	=>	dspif_wb_clk_o,	 
		channel2_wb_sel_i =>	dspif_wb_sel_o,
		--channel-3			
		channel3_wb_data_o	=>	op2p_memory_wb_data_i, --vector(31 downto 0)
		channel3_wb_data_i	=>	op2p_memory_wb_data_o, --vector(31 downto 0)
		channel3_wb_addr_i	=>	op2p_memory_wb_addr_o, --vector(25 downto 0)
		channel3_wb_cyc_i	=>	op2p_memory_wb_cyc_o,		
		channel3_wb_stb_i	=>	op2p_memory_wb_stb_o,		
		channel3_wb_wr_i	=>	op2p_memory_wb_wr_o,		
		channel3_wb_ack_o	=>	op2p_memory_wb_ack_i,		
		channel3_wb_clk_i	=>	op2p_memory_wb_clk_o,	
		channel3_wb_sel_i =>	op2p_memory_wb_sel_o,
		--System	signals:		
		x25m_clk	=>	x25m_clkin,		
		reset	=>	pcie_resetout	
	);	
		
		
	Inst_s6bfip_pcie: s6bfip_pcie PORT MAP(			
		pci_exp_txp	=>	pci_exp_txp,		
		pci_exp_txn	=>	pci_exp_txn,		
		pci_exp_rxp	=>	pci_exp_rxp,		
		pci_exp_rxn	=>	pci_exp_rxn,		
		sys_clk_n	=>	sys_clk_n,
		sys_clk_p	=>	sys_clk_p,			
		sys_reset_n	=>	sys_reset_n_local,		
		--ON	CHIP		PORTS:
		--DATA	BUS		(wishbone):			
		pcieif_wb_data_o	=>	pcieif_wb_data_o,	--vector(31 downto 0)	
		pcieif_wb_data_i	=>	pcieif_wb_data_i,	--vector(31 downto 0)	
		pcieif_wb_addr_o	=>	pcieif_wb_addr_o,	--vector(25 downto 0)	
		pcieif_wb_cyc_o	=>	pcieif_wb_cyc_o,		
		pcieif_wb_stb_o	=>	pcieif_wb_stb_o,		
		pcieif_wb_wr_o	=>	pcieif_wb_wr_o,		
		pcieif_wb_ack_i	=>	pcieif_wb_ack_i,		
		pcieif_wb_clk_o	=>	pcieif_wb_clk_o,	--62.5MHz	  
		pcieif_wb_sel_o => pcieif_wb_sel_o,
		--AURORA control		bus:			
		op2p_config_wb_data_o	=>	op2p_config_wb_data_o,	--vector(31 downto 0)			
		op2p_config_wb_data_i	=>	op2p_config_wb_data_i,	--vector(31 downto 0)			
		op2p_config_wb_addr_i	=>	op2p_config_wb_addr_i,	--vector(6 downto 0)			
		op2p_config_wb_cyc_i	=>	op2p_config_wb_cyc_i,	
		op2p_config_wb_stb_i	=>	op2p_config_wb_stb_i,	
		op2p_config_wb_wr_i	=>	op2p_config_wb_wr_i,	
		op2p_config_wb_ack_o	=>	op2p_config_wb_ack_o,	
		op2p_config_wb_clk_i	=>	op2p_config_wb_clk_i,
		op2p_config_wb_sel_o => op2p_config_wb_sel_o,
		op2p_irq => op2p_irq,
		--DSP firmware loader bus:		
		dsp_instr_wb_data_o	=>	dsp_instr_wb_data_o,	--vector(31 downto 0)
		dsp_instr_wb_data_i	=>	dsp_instr_wb_data_i,	--vector(31 downto 0)
		dsp_instr_wb_addr_o	=>	dsp_instr_wb_addr_o,	--vector(15 downto 0)
		dsp_instr_wb_cyc_o	=>	dsp_instr_wb_cyc_o,	
		dsp_instr_wb_stb_o	=>	dsp_instr_wb_stb_o,	
		dsp_instr_wb_wr_o	=>	dsp_instr_wb_wr_o,	
		dsp_instr_wb_ack_i	=>	dsp_instr_wb_ack_i,	
		dsp_instr_wb_clk_o	=>	dsp_instr_wb_clk_o,	
		dsp_instr_wb_sel_o => dsp_instr_wb_sel_o,
		--ADC control		
		adc_overshoot_detected	=>	adc_overshoot_detected,	
		pga_gain	=>	pga_gain,	--vector(5 downto 0)			
		adc_triggerlevel	=>	adc_triggerlevel,	--vector(7 downto 0)
		adc_start	=>	adc_start,	--edge	sensitive				
		adc_finished	=>	adc_finished,		
		--LEDS:
		led0	=>	led0,
		led1	=>	led1,
		led2	=>	dummy2, --led2,
		led3	=>	dummy1, --led3,
		--DSP control		
		dsp_start_boot_frompcie	=>	dsp_start_boot_frompcie,				
		dsp_reset_control_frompcie	=>	dsp_reset_control_frompcie,	
		dsp_irq_frompcie	=>	dsp_irq_frompcie,	
		dsp_nmi_frompcie	=>	dsp_nmi_frompcie,	
		dsp_flag_to_pcie	=>	dsp_flag_to_pcie,	--vector(1 downto 0)		
		dsp_flag_from_pcie	=>	dsp_flag_from_pcie,	--vector(1 downto 0)	
		--OTHER:			
		pcie_resetout	=>	pcie_resetout				
	);	
		

			  	
			  			
		
		
	

	-- MAIN LOGIC: -----------------------------------------------------------------
	
	
   --global clock buffer for the 25MHz reference clock.
	IBUFG_inst_25mhzin : IBUFG
   generic map (
      IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "LVCMOS33")
   port map (
      O => x25m_clkin_intermediate, -- Clock buffer output
      I => x25m_clkin_pin  -- Clock buffer input (connect directly to top-level port)
   );	
	--stage2: global clock net
   BUFG_inst_25mhzin : BUFG --this should work with the new constraint: PIN "BUFG_inst_25mhzin.O" BUFG_inst_25mhzin = FALSE;
   port map (
      O => x25m_clkin, -- 1-bit Clock buffer output
      I => x25m_clkin_intermediate  -- 1-bit Clock buffer input
   );
--	--stage2: global clock net
--   BUFG_inst : BUFG   --this works with the original constraint: PIN "BUFG_inst.O" CLOCK_DEDICATED_ROUTE = FALSE;
--   port map (
--      O => x25m_clkin, -- 1-bit Clock buffer output
--      I => x25m_clkin_intermediate  -- 1-bit Clock buffer input
--   );
	
	x25m_clkout <= x25m_clkin; --this is for the external PLL clock chip used for the Aurora's GTP.
	
	--LEDs: 0=on, 1=off
	led3 <= not CHANNEL_UP_copy ; --just for debug/test: LED-on = Aurora/OP2P link is alive.
	--led3 <= dummy1;
	led2 <= pcie_resetout; --just for debug/test: LED-on = not-in-reset
	--led2 <= dummy2;





	--RESET PCB BUG WORKAROUND:-------------------------------------------------------------
	--On board-revision-1 there is a bug that makes the PCIe card-edge reset to be unusable.
	--As a workaround, generate a reset internally:
	--(this signal is also driven out to the board for the Aurora/Clock/PLL chip)
	--the counter is 22-bit, and generates a 100ms reset
	sys_reset_n <= sys_reset_n_local;
	 process ( sys_reset_n_local_2ms, sys_reset_n_local_2msb, x25m_clkin)
    begin
       if (sys_reset_n_local_2ms='0' or sys_reset_n_local_2msb='0') then
			sysreset_counter <= (others => '0');
			sys_reset_n_local <= '0';
		 elsif (x25m_clkin'event and x25m_clkin='0') then --falling edge deassertion for good rec/rem timing
			if (sysreset_counter = "1001100010010110100000") then 
			  sys_reset_n_local <= '1';
			  --stop counting
			else
			  sysreset_counter <= sysreset_counter +1;
			  sys_reset_n_local <= '0';
			end if;
       end if;
    end process;	
	 --This is to generate a reset signal for the reset generator:
	 --Unfortunatelly the counter starts at a random number, so the reset delay can be anywhere between 0ms...2ms.
	 --The counter is doubled, one counts up the other one down. so if all bits start at 0000 or at 1111 the first 
	 --stage should still generate a few clock cycles reset to the main reset counter above.
	 process ( x25m_clkin)
    begin
       if (x25m_clkin'event and x25m_clkin='1') then
			if (sysreset_counter_2ms = "1111111100000000") then --2ms if it started from zero
			  sys_reset_n_local_2ms <= '1';
			  --stop counting
			else
			  sysreset_counter_2ms <= sysreset_counter_2ms +1;
			  sys_reset_n_local_2ms <= '0';
			end if;
			if (sysreset_counter_2msb = "0000000000000000") then --2ms if it started from oxFFFF
			  sys_reset_n_local_2msb <= '1';
			  --stop counting
			else
			  sysreset_counter_2msb <= sysreset_counter_2msb -1;
			  sys_reset_n_local_2msb <= '0';
			end if;
       end if;
    end process;	




-- -------- END OF FILE -----------------------------------------------------------
end Behavioral;

