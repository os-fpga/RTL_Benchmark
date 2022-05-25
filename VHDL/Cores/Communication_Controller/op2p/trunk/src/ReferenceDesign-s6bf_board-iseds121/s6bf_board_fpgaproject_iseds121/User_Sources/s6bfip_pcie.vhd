----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Istvan Nagy, buenos@freemail.hu
-- 
-- Create Date:    15:58:13 05/30/2010 
-- Design Name: 
-- Module Name:    s6bfip_pcie - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: PCI-express endpoint block and address decoding.
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
-- Spartan-6 PCI-express endpoint, adjusted for the S6BF board project.
-- x1 PCIe, legacy endpoint, uses a 100MHz ref clock. The generated core had to
-- be edited manually to support 100MHz, as per Xilinx AR#33761.
-- One BAR is used with a fixed size of 256MBytes.
-- PCIE endpoint BAR0 usage:
--  address 0...64kB: Control and status registers for the other interfaces.
--  address 64kB...128kB: DSP firmware FIFO, 64KB storage.
--  address 64MB...128MB (400'0000...7FF'FFFF): DDRx SDRAM 
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
-- DDR memory map:
-- --------------------------
-- total(64MBytes): x400'0000...x7FF'FFFF, x comes from the BAR
-- DSP bank-0: covers the whole memory. Boot vector is x400'0000, x comes from the BAR
-- ADC buffering: 32kBytes from x600'0000...x6007FFF, x comes from the BAR,  
--                first sample at x600'0000
--
-- DSP Control:
--  1. Write code from address x400'0000,
--  2. deassert DSP_RESET# by writing 0 into reg-0Ch.bit6
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity s6bfip_pcie is
    Port ( --FPGA PINS(EXTERNAL):
			 pci_exp_txp             : out std_logic;
			 pci_exp_txn             : out std_logic;
			 pci_exp_rxp             : in  std_logic;
			 pci_exp_rxn             : in  std_logic;	 
			 sys_clk_n                 : in  std_logic;
			 sys_clk_p                 : in  std_logic;
			 sys_reset_n             : in  std_logic;			 
			 --ON CHIP PORTS:
			 --DATA BUS (wishbone, based on BAR1): 
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
end s6bfip_pcie;

architecture Behavioral of s6bfip_pcie is
   -- Internal Signals ------------------------------------------------------------
	--SIGNAL dummy : std_logic_vector(15 downto 0);	--write data bus
	--pcie_block's ports:
	SIGNAL	pcie_bar0_wb_data_o	:		std_logic_vector(31	downto	0);
	SIGNAL	pcie_bar0_wb_data_i	:		std_logic_vector(31	downto	0);
	SIGNAL	pcie_bar0_wb_addr_o	:		std_logic_vector(27	downto	0);
	SIGNAL	pcie_bar0_wb_cyc_o	:		std_logic;		
	SIGNAL	pcie_bar0_wb_stb_o	:		std_logic;		
	SIGNAL	pcie_bar0_wb_wr_o	:		std_logic;		
	SIGNAL	pcie_bar0_wb_ack_i	:		std_logic;		
	SIGNAL	pcie_bar0_wb_clk_o	:		std_logic;	--62.5MHz	
	SIGNAL	pcie_bar0_wb_sel_o	:		std_logic_vector(3	downto	0);		
	
	SIGNAL	pcielocalreg_addrmatch	:		std_logic;	
	SIGNAL	pcie_op2p_addressmatch	:		std_logic;
	SIGNAL	pcie_dspfifo_addressmatch	:		std_logic;	
	SIGNAL   pcie_ddr_addressmatch	:		std_logic;	
	SIGNAL	pcie_bar0_wb_ack_i_localreg	:		std_logic;
	SIGNAL	pcie_bar0_wb_data_i_localreg	:		std_logic_vector(31	downto	0);
	SIGNAL pcie_irq 	:		std_logic;
	SIGNAL pcie_resetout_local 	:		std_logic;
	SIGNAL pga_gain1 	:	std_logic_vector(5	downto	0);
	SIGNAL adc_triggerlevel1	:	std_logic_vector(7	downto	0);
	SIGNAL led0_local	:		std_logic;
	SIGNAL led1_local	:		std_logic;
	SIGNAL led2_local	:		std_logic;
	SIGNAL led3_local	:		std_logic;
	SIGNAL pcie_bar0_wb_stb_o_delayed	:		std_logic;
	SIGNAL test_ram_reg	:		std_logic_vector(31	downto	0);
	SIGNAL adc_start_local	:		std_logic;
	SIGNAL dsp_controg_reg_reflection	:	std_logic_vector(7	downto	0);
	SIGNAL irq_reg :		std_logic_vector(31	downto	0);
	SIGNAL pcie_irq_sources_merge	:		std_logic;
	SIGNAL pcie_irq_status_clear: 	std_logic;
	SIGNAL pcie_irq_glob_en: 	std_logic;
	SIGNAL pcie_irq_sources_merge_reclocked1: 	std_logic;
	SIGNAL pcie_irq_sources_merge_reclocked2: 	std_logic;






	-- COMPONENT DECLARATIONS (introducing the IPs) --------------------------------
	COMPONENT xilinx_pcie2wb
    Port ( --FPGA PINS(EXTERNAL):
			 pci_exp_txp             : out std_logic;
			 pci_exp_txn             : out std_logic;
			 pci_exp_rxp             : in  std_logic;
			 pci_exp_rxn             : in  std_logic;	 
			 sys_clk_n                 : in  std_logic;
			 sys_clk_p                 : in  std_logic;
			 sys_reset_n             : in  std_logic;			 
			 --ON CHIP PORTS:
			 --DATA BUS for BAR0 (wishbone):
			 pcie_bar0_wb_data_o : out std_logic_vector(31 downto 0); 
			 pcie_bar0_wb_data_i : in std_logic_vector(31 downto 0);
			 pcie_bar0_wb_addr_o : out std_logic_vector(27 downto 0);
			 pcie_bar0_wb_cyc_o : out std_logic;
			 pcie_bar0_wb_stb_o : out std_logic;
			 pcie_bar0_wb_wr_o : out std_logic;
			 pcie_bar0_wb_ack_i : in std_logic;
			 pcie_bar0_wb_clk_o : out std_logic; --62.5MHz		
			 pcie_bar0_wb_sel_o : out std_logic_vector(3 downto 0);			 		 		 
			 --OTHER:
			 pcie_irq : in std_logic;
			 pcie_resetout  : out std_logic --active high
			);
	END COMPONENT;





-- ------- SYNTHESIS ATTRIBUTES: --------------------------------------------------
--attribute keep_hierarchy : string; 
--attribute keep_hierarchy of s6bfip_pcie: entity is "yes"; 
 -- KEEP HIERARCHY
 -- attribute keep : string; 
 -- attribute keep of clock_signal_name: signal is "true"; 
 attribute keep : string; 
 attribute keep of pcie_bar0_wb_clk_o: signal is "true"; 
 
 
 

-- --------ARCHITECTURE BODY BEGINS -----------------------------------------------
begin




	-- COMPONENT INSTALLATIONS (connecting the IPs to local signals) ---------------
 Inst_xilinx_pcie2wb: xilinx_pcie2wb PORT MAP(
	pci_exp_txp	 => 		pci_exp_txp	,
	pci_exp_txn	 => 		pci_exp_txn	,
	pci_exp_rxp	 => 		pci_exp_rxp	,
	pci_exp_rxn	 => 		pci_exp_rxn	,
	sys_clk_n	 => 		sys_clk_n	,
	sys_clk_p	 => 		sys_clk_p	,
	sys_reset_n	 => 		sys_reset_n	,
	--ON CHIP PORTS				
	--DATA BUS WB0				
	pcie_bar0_wb_data_o	 => 		pcie_bar0_wb_data_o	,
	pcie_bar0_wb_data_i	 => 		pcie_bar0_wb_data_i	,
	pcie_bar0_wb_addr_o	 => 		pcie_bar0_wb_addr_o	,
	pcie_bar0_wb_cyc_o	 => 		pcie_bar0_wb_cyc_o	,
	pcie_bar0_wb_stb_o	 => 		pcie_bar0_wb_stb_o	,
	pcie_bar0_wb_wr_o	 => 		pcie_bar0_wb_wr_o	,
	pcie_bar0_wb_ack_i	 => 		pcie_bar0_wb_ack_i	,
	pcie_bar0_wb_clk_o	 => 		pcie_bar0_wb_clk_o	,
	pcie_bar0_wb_sel_o	 => 		pcie_bar0_wb_sel_o	,
	--OTHER:				
	pcie_irq	 => 		pcie_irq	,
	pcie_resetout	 => 		pcie_resetout_local
 );





	-- MAIN LOGIC: -----------------------------------------------------------------


	pcie_resetout <= pcie_resetout_local;

	-- ------Interrupts: -------
	--  30h    irq_reg         gl.st. -      -      -      -      -      st.cl. glob.en
	pcie_irq_sources_merge <= (adc_finished or op2p_irq) and pcie_irq_glob_en; 
	--no flipflop: pcie_irq <= (adc_finished or op2p_irq) and pcie_irq_glob_en; 
	--pcie_irq <= '0'; --if disabled.
	process (pcie_resetout_local, pcie_bar0_wb_clk_o) 
	begin
	if (pcie_resetout_local='1') then 
		pcie_irq <= '0';
		pcie_irq_sources_merge_reclocked1 <= '0';
		pcie_irq_sources_merge_reclocked2 <= '0';
	else
		if (pcie_bar0_wb_clk_o'event and pcie_bar0_wb_clk_o = '1') then
			--reclocking to this clock domain:
			pcie_irq_sources_merge_reclocked1 <= pcie_irq_sources_merge;
			pcie_irq_sources_merge_reclocked2 <= pcie_irq_sources_merge_reclocked1;
			--SR flip-flop:
			if (pcie_irq_sources_merge_reclocked2='1') then
			  pcie_irq <= '1';
			elsif (pcie_irq_status_clear='1') then
			  pcie_irq <= '0';
			end if;
		end if;        
	end if;
	end process;
	pcie_irq_status_clear <= irq_reg(1);
	pcie_irq_glob_en <= irq_reg(0);





	--Connecting up the wishbone buses:--------


	 --Address match for local registers and BAR0 buses:
	 process ( pcie_resetout_local, pcie_bar0_wb_clk_o, 
				 pcie_bar0_wb_addr_o, pcie_bar0_wb_cyc_o, pcie_bar0_wb_sel_o
				 )
    begin
       if (pcie_resetout_local='1') then
            pcielocalreg_addrmatch <= '0';
				pcie_op2p_addressmatch <= '0';
				pcie_dspfifo_addressmatch <= '0';
				pcie_ddr_addressmatch <= '0';
       else 
			  if (pcie_bar0_wb_cyc_o='1') then --transaction in progress
				 if (pcie_bar0_wb_addr_o(26)='1') then --DDR memory
					pcielocalreg_addrmatch <= '0';
					pcie_op2p_addressmatch <= '0';
					pcie_dspfifo_addressmatch <= '0';
					pcie_ddr_addressmatch <= '1';
				 elsif (pcie_bar0_wb_addr_o(16 downto 8) = "000000001") then--100h to 17F: Aurora config/status registers
					pcielocalreg_addrmatch <= '0';
					pcie_op2p_addressmatch <= '1';
					pcie_dspfifo_addressmatch <= '0';
					pcie_ddr_addressmatch <= '0';
				 elsif (pcie_bar0_wb_addr_o(16) = '1') then --10000 to 1FFFF DSP_instr_FIFO
					pcielocalreg_addrmatch <= '0';
					pcie_op2p_addressmatch <= '0';
					pcie_dspfifo_addressmatch <= '1';
					pcie_ddr_addressmatch <= '0';
				 --local registers: (0...255)
			    elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"00" --PGA_gain_reg
						or pcie_bar0_wb_addr_o(7 downto 0) = X"04" --ADC_cont_reg
						or pcie_bar0_wb_addr_o(7 downto 0) = X"08" --ADC_trigg_reg
						or pcie_bar0_wb_addr_o(7 downto 0) = X"0C" --DSP_contr_reg
						or pcie_bar0_wb_addr_o(7 downto 0) = X"10" --DSP_flag_reg
						or pcie_bar0_wb_addr_o(7 downto 0) = X"14" --LEDs 
						or pcie_bar0_wb_addr_o(7 downto 2) = "000110" --X"18" --test RAM, byte addressing
						or pcie_bar0_wb_addr_o(7 downto 0) = X"30" --irq_reg 
						) then
							pcielocalreg_addrmatch <= '1';
							pcie_op2p_addressmatch <= '0';
							pcie_dspfifo_addressmatch <= '0';
							pcie_ddr_addressmatch <= '0';
				 else --no match
					pcielocalreg_addrmatch <= '0';
					pcie_op2p_addressmatch <= '0';
					pcie_dspfifo_addressmatch <= '0';
					pcie_ddr_addressmatch <= '0';
				 end if;
			  else --no transaction
            pcielocalreg_addrmatch <= '0';
				pcie_op2p_addressmatch <= '0';
				pcie_dspfifo_addressmatch <= '0';
				pcie_ddr_addressmatch <= '0';
			  end if;
       end if;
    end process;	



	--pass throughs:
	op2p_config_wb_data_o  <= pcie_bar0_wb_data_o;
	dsp_instr_wb_data_o  <= pcie_bar0_wb_data_o;
	op2p_config_wb_clk_i  <= pcie_bar0_wb_clk_o;
	dsp_instr_wb_clk_o  <= pcie_bar0_wb_clk_o;
	op2p_config_wb_addr_i (6 downto 0)  <= pcie_bar0_wb_addr_o(6 downto 0);
	dsp_instr_wb_addr_o (15 downto 0)  <= pcie_bar0_wb_addr_o(15 downto 0);
	dsp_instr_wb_sel_o (3 downto 0) <= pcie_bar0_wb_sel_o (3 downto 0);
	op2p_config_wb_sel_o (3 downto 0) <= pcie_bar0_wb_sel_o (3 downto 0);
	dsp_instr_wb_wr_o <= pcie_bar0_wb_wr_o;
	op2p_config_wb_wr_i <= pcie_bar0_wb_wr_o;
	--address 4000000...7FFFFFF goes to the DDRx memory (64MBytes)
	pcieif_wb_data_o <= pcie_bar0_wb_data_o;
	pcieif_wb_addr_o (25 downto 2)  <= pcie_bar0_wb_addr_o (25 downto 2);
	pcieif_wb_addr_o (1 downto 0) <= "00";
	pcieif_wb_wr_o  <= pcie_bar0_wb_wr_o ;
	pcieif_wb_clk_o 	 <= pcie_bar0_wb_clk_o ;
	pcieif_wb_sel_o  <= pcie_bar0_wb_sel_o ;




	 process ( pcie_resetout_local, pcie_bar0_wb_clk_o)
    begin
       if (pcie_resetout_local='1') then
		   pcie_bar0_wb_stb_o_delayed <= '0';
		 elsif (pcie_bar0_wb_clk_o'event and pcie_bar0_wb_clk_o='1') then
			pcie_bar0_wb_stb_o_delayed <= pcie_bar0_wb_stb_o;
		 end if;
    end process;	


	 --pcie-block wb input multiplexer and wb control output gating:
	 process ( pcie_resetout_local, pcielocalreg_addrmatch, pcie_bar0_wb_data_i_localreg,
				pcieif_wb_data_i, pcie_bar0_wb_cyc_o, pcie_bar0_wb_stb_o, dsp_instr_wb_ack_i,
				pcie_ddr_addressmatch, pcie_op2p_addressmatch, pcie_dspfifo_addressmatch,
				pcieif_wb_data_i, op2p_config_wb_data_i, op2p_config_wb_ack_o, pcie_bar0_wb_stb_o_delayed,
				pcie_bar0_wb_cyc_o, pcie_bar0_wb_stb_o, dsp_instr_wb_data_i,
 				dsp_instr_wb_ack_i, pcie_bar0_wb_ack_i_localreg, pcieif_wb_ack_i   )
    begin
       if (pcie_resetout_local='1') then
			pcie_bar0_wb_data_i <= X"00000000";
			pcie_bar0_wb_ack_i <= '0';
			 op2p_config_wb_cyc_i  <= '0';
			 op2p_config_wb_stb_i  <= '0';
			 dsp_instr_wb_cyc_o   <= '0';
			 dsp_instr_wb_stb_o   <= '0';
			 pcieif_wb_cyc_o   <= '0';
			 pcieif_wb_stb_o   <= '0';
       elsif (pcielocalreg_addrmatch='1') then
			pcie_bar0_wb_data_i <= pcie_bar0_wb_data_i_localreg;
			pcie_bar0_wb_ack_i <= pcie_bar0_wb_ack_i_localreg;
			 op2p_config_wb_cyc_i  <= '0';
			 op2p_config_wb_stb_i  <= '0';
			 dsp_instr_wb_cyc_o   <= '0';
			 dsp_instr_wb_stb_o   <= '0';
			 pcieif_wb_cyc_o   <= '0';
			 pcieif_wb_stb_o   <= '0';
       elsif (pcie_ddr_addressmatch='1') then
			pcie_bar0_wb_data_i <= pcieif_wb_data_i;
			pcie_bar0_wb_ack_i <= pcieif_wb_ack_i;
			 op2p_config_wb_cyc_i  <= '0';
			 op2p_config_wb_stb_i   <= '0';
			 dsp_instr_wb_cyc_o   <= '0';
			 dsp_instr_wb_stb_o   <= '0';
			 pcieif_wb_cyc_o   <= pcie_bar0_wb_cyc_o;
			 pcieif_wb_stb_o   <= pcie_bar0_wb_stb_o;
       elsif (pcie_op2p_addressmatch='1') then
			pcie_bar0_wb_data_i <= op2p_config_wb_data_i ;
			pcie_bar0_wb_ack_i <= op2p_config_wb_ack_o ;
			 op2p_config_wb_cyc_i  <= pcie_bar0_wb_cyc_o;
			 op2p_config_wb_stb_i   <= pcie_bar0_wb_stb_o;
			 dsp_instr_wb_cyc_o   <= '0';
			 dsp_instr_wb_stb_o   <= '0';
			 pcieif_wb_cyc_o   <= '0';
			 pcieif_wb_stb_o   <= '0';
       elsif (pcie_dspfifo_addressmatch='1') then
			pcie_bar0_wb_data_i <= dsp_instr_wb_data_i ;
			pcie_bar0_wb_ack_i <= dsp_instr_wb_ack_i ;
			 op2p_config_wb_cyc_i  <= '0';
			 op2p_config_wb_stb_i  <= '0';
			 dsp_instr_wb_cyc_o   <= pcie_bar0_wb_cyc_o;
			 dsp_instr_wb_stb_o   <= pcie_bar0_wb_stb_o;
			 pcieif_wb_cyc_o   <= '0';
			 pcieif_wb_stb_o   <= '0';
       else --no match
			pcie_bar0_wb_data_i <= X"00000000";
			pcie_bar0_wb_ack_i <= pcie_bar0_wb_stb_o_delayed and pcie_bar0_wb_stb_o;
			 op2p_config_wb_cyc_i  <= '0';
			 op2p_config_wb_stb_i   <= '0';
			 dsp_instr_wb_cyc_o  <= '0';
			 dsp_instr_wb_stb_o  <= '0';
			 pcieif_wb_cyc_o   <= '0';
			 pcieif_wb_stb_o   <= '0';
       end if;
    end process;	
 


	--Generating individual control signals:--------
	--these are local register(bit)s.
	-- -------------------------------------
	--  addr   name            bit7   bit6   bit5   bit4   bit3   bit2   bit1   bit0
	--  00h    PGA_gain_reg    -      -      b5     b4     b3     b2     b1     b0
	--  04h    ADC_cont_reg    start  finish oversh -      -      -      -      -
	--  08h    ADC_trigg_reg   b7     b6     b5     b4     b3     b2     b1     b0
	--  0Ch    DSP_contr_reg   boot   reset  irq    nmi    -      -      -      -
	--  10h    DSP_flag_reg    -      -      -      -      out1   out0   in1    in0
	--  14h    Debug Led Reg   -      -      -      -      led3   led2   led1   led0
	--  18h    Test RAM        32-bit RAM - - - - - - - - - - - - - - - - - - - - -
	--  30h    irq_reg         status -      -      -      -      -      clear  glob.en

	 process ( pcie_resetout_local, pcie_bar0_wb_clk_o, pcielocalreg_addrmatch,
				 pcie_bar0_wb_data_o, pcie_bar0_wb_addr_o, pcie_bar0_wb_cyc_o, pcie_bar0_wb_wr_o, pcie_bar0_wb_sel_o,
				 pcieif_wb_ack_i, pcieif_wb_data_i, pga_gain1, adc_triggerlevel1, led0_local, led1_local, led2_local, led3_local, 
				 adc_overshoot_detected, adc_finished, dsp_flag_to_pcie )
    begin
       if (pcie_resetout_local='1') then --reset condition
			--Wishbone signals to the master:
			--pcie_bar0_wb_ack_i_localreg <=  '0';
			pcie_bar0_wb_data_i_localreg <=  (OTHERS => '0');
			irq_reg  <=  (OTHERS => '0');        		 
			--control outputs:
			--ADC control signals 
			pga_gain  <= "000000";
			adc_triggerlevel  <= "00000000";
			adc_start   <= '0';  --edge sensitive
			adc_start_local <= '0';
			--DSP control signals 
			dsp_start_boot_frompcie   <= '0';
			dsp_reset_control_frompcie   <= '1';
			dsp_irq_frompcie    <= '0';
			dsp_nmi_frompcie  <= '0';
			dsp_flag_from_pcie <= "00";
			led0  <= '1';
			led1  <= '1';
			led2  <= '1';	
			led3  <= '1';	
			led0_local  <= '1';
			led1_local  <= '1';
			led2_local  <= '1';
			led3_local  <= '1';
			test_ram_reg <=  (OTHERS => '0');
			dsp_controg_reg_reflection <= "01000000";
       elsif (pcie_bar0_wb_clk_o'event and pcie_bar0_wb_clk_o='1') then
		 
           --set output (host writes)------------WR------
			  if (pcielocalreg_addrmatch='1' and pcie_bar0_wb_wr_o='1') then
				  --pcie_bar0_wb_ack_i_localreg <=  pcie_bar0_wb_cyc_o;
				  pcie_bar0_wb_data_i_localreg <=  X"00000000";
					if (pcie_bar0_wb_addr_o(7 downto 0) = X"00") then --PGA_gain_reg
						pga_gain  <= pcie_bar0_wb_data_o(5 downto 0);
						pga_gain1  <= pcie_bar0_wb_data_o(5 downto 0);
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"04") then --ADC_cont_reg
						adc_start   <= pcie_bar0_wb_data_o(7); --edge sensitive
						adc_start_local   <= pcie_bar0_wb_data_o(7); --edge sensitive
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"08") then --ADC_trigg_reg
						adc_triggerlevel   <= pcie_bar0_wb_data_o(7 downto 0);
						adc_triggerlevel1   <= pcie_bar0_wb_data_o(7 downto 0);
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"0C") then --DSP_contr_reg
						dsp_controg_reg_reflection <= pcie_bar0_wb_data_o(7 downto 0);
						dsp_start_boot_frompcie    <= pcie_bar0_wb_data_o(7);
						dsp_reset_control_frompcie   <= pcie_bar0_wb_data_o(6);
						dsp_irq_frompcie     <= pcie_bar0_wb_data_o(5);
						dsp_nmi_frompcie   <= pcie_bar0_wb_data_o(4);
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"10") then --DSP_flag_reg
						dsp_flag_from_pcie(1 downto 0)  <= pcie_bar0_wb_data_o(3 downto 2);			
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"14") then --LEDs
						led0  <= pcie_bar0_wb_data_o(0);
						led1  <= pcie_bar0_wb_data_o(1);	
						led2  <= pcie_bar0_wb_data_o(2);	
						led3  <= pcie_bar0_wb_data_o(3);		
						led0_local  <= pcie_bar0_wb_data_o(0);
						led1_local  <= pcie_bar0_wb_data_o(1);	
						led2_local  <= pcie_bar0_wb_data_o(2);	
						led3_local  <= pcie_bar0_wb_data_o(3);							
					elsif (pcie_bar0_wb_addr_o(7 downto 2) = "000110") then --X"18" --test RAM, with BE mask
						if (pcie_bar0_wb_sel_o(0)='1') then
						  test_ram_reg(7 downto 0)  <= pcie_bar0_wb_data_o(7 downto 0);
						end if;
						if (pcie_bar0_wb_sel_o(1)='1') then
						  test_ram_reg(15 downto 8)  <= pcie_bar0_wb_data_o(15 downto 8);
						end if;
						if (pcie_bar0_wb_sel_o(2)='1') then
						  test_ram_reg(23 downto 16)  <= pcie_bar0_wb_data_o(23 downto 16);
						end if;
						if (pcie_bar0_wb_sel_o(3)='1') then
						  test_ram_reg(31 downto 24)  <= pcie_bar0_wb_data_o(31 downto 24);
						end if;
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"30") then --irq_reg
						irq_reg (31 downto 0)  <= pcie_bar0_wb_data_o(31 downto 0);
					--no else
					end if;

			  --sample input(host reads)------------RD------
			  elsif (pcielocalreg_addrmatch='1' and pcie_bar0_wb_wr_o='0') then
				  --pcie_bar0_wb_ack_i_localreg <=  pcie_bar0_wb_cyc_o;
					if (pcie_bar0_wb_addr_o(7 downto 0) = X"00") then --PGA_gain_reg
						pcie_bar0_wb_data_i_localreg(31 downto 6) <=  "00000000000000000000000000";
						pcie_bar0_wb_data_i_localreg(5 downto 0) <=  pga_gain1;	
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"04") then --ADC_cont_reg --
						pcie_bar0_wb_data_i_localreg(7) <=  adc_start_local;
						pcie_bar0_wb_data_i_localreg(6) <=  adc_finished;	
						pcie_bar0_wb_data_i_localreg(5) <=  adc_overshoot_detected;	
						pcie_bar0_wb_data_i_localreg(31 downto 8) <=  X"000000";	
						pcie_bar0_wb_data_i_localreg(4 downto 0) <=  "00000";	
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"08") then --ADC_trigg_reg
						pcie_bar0_wb_data_i_localreg(7 downto 0) <=  adc_triggerlevel1;	
						pcie_bar0_wb_data_i_localreg(31 downto 8) <=  X"000000";
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"0C") then --DSP_contr_reg
						pcie_bar0_wb_data_i_localreg(31 downto 8) <=  X"000000";
						pcie_bar0_wb_data_i_localreg(7 downto 0) <= dsp_controg_reg_reflection;
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"10") then --DSP_flag_reg --
						pcie_bar0_wb_data_i_localreg(1 downto 0) <=  dsp_flag_to_pcie(1 downto 0);
						pcie_bar0_wb_data_i_localreg(31 downto 2) <=  "000000000000000000000000000000";		
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"14") then --LEDs --
						pcie_bar0_wb_data_i_localreg(0) <=  led0_local;
						pcie_bar0_wb_data_i_localreg(1) <=  led1_local;
						pcie_bar0_wb_data_i_localreg(2) <=  led2_local;
						pcie_bar0_wb_data_i_localreg(3) <=  led3_local;
						pcie_bar0_wb_data_i_localreg(7 downto 4) <=  "1010";
					elsif (pcie_bar0_wb_addr_o(7 downto 2) = "000110") then --X"18" --test RAM
						pcie_bar0_wb_data_i_localreg <= test_ram_reg;
					elsif (pcie_bar0_wb_addr_o(7 downto 0) = X"30") then --irq_reg
						pcie_bar0_wb_data_i_localreg(6 downto 0) <=  irq_reg(6 downto 0);
						pcie_bar0_wb_data_i_localreg(7) <= pcie_irq; --irq assertion status
						pcie_bar0_wb_data_i_localreg(31 downto 8) <=  irq_reg(31 downto 8);
					else
						pcie_bar0_wb_data_i_localreg <=  X"00000000";	
					end if;	
					
			  --do these things between accesses, like an idle state:
			  else
				  irq_reg(1) <= '0'; --clear irq status-clear. This bit resets to zero right after setting it to 1 by wb-write
			  end if;
       end if;
    end process;	
	 
	pcie_bar0_wb_ack_i_localreg <= pcie_bar0_wb_stb_o_delayed and pcie_bar0_wb_stb_o; --one clk pulse delayed from wb_stb













-- -------- END OF FILE -----------------------------------------------------------
end Behavioral;

