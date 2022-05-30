----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Istvan Nagy, buenos@freemail.hu
-- 
-- Create Date:    15:58:13 05/30/2010 
-- Design Name:  interface to an ADSP-BF544 Digital Signal Processor
-- Module Name:    s6bfip_dsp - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
-- Access address regions:
--  BANK3: instruction buffer for FIFO boot, 64kbytes buffer
--  BANK1: onboard DRAM memory access, 64Mbytes window
-- 
-- We use an intermediate register for the DSP boot FIFO to break a long timing path.
-- The consequence is that the DSP has to keep AOE asserted for at least 2 clock cycles.
-- All the bus signals from the DSP are registered to break the timing paths.
-- Based on timing analysis, the interface can work up to F_MAX clock rate. Check
-- the UCF file for F_MAX setting. Same as the dsp_ioclk constraint. Because
-- of the registers, the DSP EBIU programming must take the extra clock cycles into
-- account, since every signal gets 1 clock cycle delay before driven to any logic.
-- BOOT:
--  At the moment the flash boot is selected, so the DSP will start loading data/code
--  (right after its reset gets deasserted) from the DDR-memory location 0x00.
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

entity s6bfip_dsp is 
    Port ( --FPGA PINS (EXTERNAL):
			  dsp_reset_n : out  STD_LOGIC;
			  dsp_refclk :  out  STD_LOGIC;	
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
			  dsp_interrupt : out  STD_LOGIC; --to a GPIO pin
			  dsp_nmi_n : out  STD_LOGIC;
			  dsp_hostif_data :inout  STD_LOGIC_VECTOR (7 downto 0);
			  dsp_hostif_ce_n : out  STD_LOGIC;
			  dsp_hostif_rd_n : out  STD_LOGIC;
			  dsp_hostif_wr_n : out  STD_LOGIC;
			  dsp_hostif_addr : out  STD_LOGIC_VECTOR (1 downto 0); --0==data, 1=config
			  dsp_hostif_ack : in  STD_LOGIC;
			  --DATA BUS (wishbone):
			  dspif_wb_data_o : out std_logic_vector(31 downto 0); 
			  dspif_wb_data_i : in std_logic_vector(31 downto 0);
			  dspif_wb_addr_o : out std_logic_vector(25 downto 0);
			  dspif_wb_cyc_o : out std_logic;
			  dspif_wb_stb_o : out std_logic;
			  dspif_wb_wr_o : out std_logic;
			  dspif_wb_ack_i : in std_logic;
			  dspif_wb_clk_o : out std_logic; 
			  dspif_wb_sel_o : out std_logic_vector(3 downto 0);
			  --instruction buffer :
			  dsp_instr_wb_data_o : in std_logic_vector(31 downto 0); 
			  dsp_instr_wb_data_i : out std_logic_vector(31 downto 0);
			  dsp_instr_wb_addr_o : in std_logic_vector(15 downto 0);
			  dsp_instr_wb_cyc_o : in std_logic;
			  dsp_instr_wb_stb_o : in std_logic;
			  dsp_instr_wb_wr_o : in std_logic;
			  dsp_instr_wb_ack_i : out std_logic;
			  dsp_instr_wb_clk_o : in std_logic; 
			  dsp_instr_wb_sel_o :  in std_logic_vector(3 downto 0);	
			  --Control:
			  dsp_start_boot_frompcie : in std_logic;
			  dsp_reset_control_frompcie : in std_logic;
			  dsp_irq_frompcie : in std_logic; 
			  dsp_nmi_frompcie : in std_logic; 
			  dsp_flag_to_pcie : out  STD_LOGIC_VECTOR (1 downto 0);
			  dsp_flag_from_pcie : in  STD_LOGIC_VECTOR (1 downto 0);			  
			  --System:
			  x25m_clkin : in std_logic;
			  dspif_reset : in std_logic --active high			  
			  );
end s6bfip_dsp;

architecture Behavioral of s6bfip_dsp is
   -- Internal Signals ------------------------------------------------------------
	--SIGNAL dummy : std_logic_vector(15 downto 0);	--write data bus

	SIGNAL dsp_ioclk_local :  std_logic;
	SIGNAL dsp_ioclk_feedback_1 :  std_logic;
	SIGNAL dsp_ioclk_feedback_2 :  std_logic;
	
	--instruction buffer ports:
	SIGNAL clka:  std_logic;
	SIGNAL ena:  std_logic;
	SIGNAL wea:  std_logic_VECTOR(0 downto 0);
	SIGNAL addra:  std_logic_VECTOR(13 downto 0);
	SIGNAL dina:  std_logic_VECTOR(31 downto 0);
	SIGNAL douta:  std_logic_VECTOR(31 downto 0);
	SIGNAL clkb:  std_logic;
	SIGNAL enb:  std_logic;
	SIGNAL web:  std_logic_VECTOR(0 downto 0);
	SIGNAL addrb:  std_logic_VECTOR(14 downto 0);
	SIGNAL dinb:  std_logic_VECTOR(15 downto 0);
	SIGNAL doutb:  std_logic_VECTOR(15 downto 0);
	
	--other signals:
	SIGNAL dsp_fifo_address_counter : STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL dsp_address_latched : STD_LOGIC_VECTOR (25 downto 0);
	SIGNAL dsp_fifo_read_data : STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL dsp_fifo_read_data_intermediate  : STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL async_read_data : STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL async_write_data : STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL dsp_read_data_ready : STD_LOGIC; 	
	SIGNAL dsp_writes : STD_LOGIC; 
	SIGNAL dsp_reads : STD_LOGIC; 
	SIGNAL dsp_aoe_n_latched : STD_LOGIC; 
	SIGNAL wea_vectorize  : STD_LOGIC_VECTOR (0 downto 0);
	SIGNAL dsp_upperlower_vectorize : STD_LOGIC_VECTOR (1 downto 0);
	SIGNAL dsp_upperlower : STD_LOGIC; 
	SIGNAL wb_state : STD_LOGIC_VECTOR (2 downto 0);
	SIGNAL dsp_abe_n_latched : STD_LOGIC_VECTOR (1 downto 0);
	SIGNAL dsp_ams_n_3_latched : STD_LOGIC; 
	SIGNAL dsp_ams_n_0_latched : STD_LOGIC; 
	SIGNAL dsp_awe_n_latched : STD_LOGIC; 
	SIGNAL dsp_awe_n_latched_previous : STD_LOGIC;
	SIGNAL dsp_aoe_n_latched2 : STD_LOGIC;
	SIGNAL dsp_hwait_latched : STD_LOGIC;
	SIGNAL dsp_writedata_pass : STD_LOGIC;
	SIGNAL dsp_ioclk_local_dummy : STD_LOGIC;
	SIGNAL dsp_refclk_counter : STD_LOGIC_VECTOR (2 downto 0);
	SIGNAL dsp_are_n_latched : STD_LOGIC;




	-- COMPONENT DECLARATIONS (introducing the IPs) --------------------------------

	--instruction buffer: 64kbytes. port-A=32bit, port-B=16bit
	component dsp_instr_buffer
		port (
		clka: IN std_logic;
		ena: IN std_logic;
		wea: IN std_logic_VECTOR(0 downto 0);
		addra: IN std_logic_VECTOR(13 downto 0);
		dina: IN std_logic_VECTOR(31 downto 0);
		douta: OUT std_logic_VECTOR(31 downto 0);
		clkb: IN std_logic;
		enb: IN std_logic;
		web: IN std_logic_VECTOR(0 downto 0);
		addrb: IN std_logic_VECTOR(14 downto 0);
		dinb: IN std_logic_VECTOR(15 downto 0);
		doutb: OUT std_logic_VECTOR(15 downto 0));
	end component;

	--ioclk pll, for zero delay clock buffering.
	component dcm_for_ioclk_dsp_s6bf is
	port
	 (-- Clock in ports
	  CLK_IN1           : in     std_logic;
	  CLKFB_IN          : in     std_logic;
	  -- Clock out ports
	  CLK_OUT1          : out    std_logic;
	  CLKFB_OUT         : out    std_logic
	 );
	end component;
	
	
	component pll_for_dsprefclk
	port
	 (-- Clock in ports
	  CLK_IN1           : in     std_logic;
	  -- Clock out ports
	  CLK_OUT1          : out    std_logic
	 );
	end component;


-- ------- SYNTHESIS ATTRIBUTES: --------------------------------------------------
--attribute keep_hierarchy : string; 
--attribute keep_hierarchy of s6bfip_dsp: entity is "yes"; 



-- --------ARCHITECTURE BODY BEGINS -----------------------------------------------
begin




	-- COMPONENT INSTALLATIONS (connecting the IPs to local signals) ---------------
	inst_dsp_instr_buffer : dsp_instr_buffer
		port map (
			clka => clka,
			ena => ena,
			wea => wea,
			addra => addra,
			dina => dina,
			douta => douta,
			clkb => clkb,
			enb => enb,
			web => web,
			addrb => addrb,
			dinb => dinb,
			doutb => doutb);	


	-- MAIN LOGIC: -----------------------------------------------------------------

		dsp_reset_n <= not (dspif_reset or dsp_reset_control_frompcie);
	
	--  boot mode = 0010 = FIFO boot
	--0010= FIFO boot (using AMS3)
	--0000= no boot (the datasheet and HRM contradicts about this)
	--0001= execute or boot from ext-flash (using AMS0)
	--1011= OTP boot
	--0111= UART (DSP is slave)
	dsp_bmode(3) <= '0';
	dsp_bmode(2) <= '0';
	dsp_bmode(1) <= '0';
	dsp_bmode(0) <= '1';

	--interrupts:
	dsp_interrupt  <= dsp_irq_frompcie;
	dsp_nmi_n  <= not dsp_nmi_frompcie;
	
	--uart loopback for test:
	dsp_uart_tx <= 'Z';
	
	dsp_flag_to_dsp <= dsp_flag_from_pcie;
	dsp_flag_to_pcie <= dsp_flag_from_dsp;


	--HOST INTERFACE: --------------------------------------
	--not used at the moment:
	dsp_hostif_data <= "ZZZZZZZZ";
	dsp_hostif_ce_n <= '1';
	dsp_hostif_rd_n <= '1';
	dsp_hostif_wr_n <= '1';
	dsp_hostif_addr <= "01"; 
	--?? <= dsp_hostif_ack 


	--ASYNCHRONOUS SLAVE BUS INTERFACE:----------------------
	dsp_dmar1_n <='1';
	 process (dspif_reset, dsp_reset_control_frompcie, dsp_ioclk_local, dsp_ams_n, dsp_aoe_n, dsp_writedata_pass,
				dsp_fifo_read_data, dsp_fifo_address_counter,  dsp_awe_n, dsp_ams_n_3_latched, dsp_hwait_latched,
				dsp_ams_n_0_latched,  dsp_awe_n_latched, dsp_awe_n_latched_previous, dsp_aoe_n_latched2, dsp_are_n,
				dsp_read_data_ready, dsp_fifo_address_counter, dsp_aoe_n_latched, async_read_data, dsp_awe_n_latched_previous)
    begin
       if (dspif_reset='1' or dsp_reset_control_frompcie='1') then
           dsp_data <= "ZZZZZZZZZZZZZZZZ";
			  dsp_fifo_address_counter <= "0000000000000000";
			  async_write_data <= "0000000000000000";
			  dsp_ardy <= '0';
			  dsp_writes <= '0';
			  dsp_reads <= '0';
			  dsp_aoe_n_latched <= '1';
			  dsp_fifo_read_data_intermediate <= "0000000000000000";
			  dsp_abe_n_latched <= "11";
			  dsp_ams_n_3_latched <= '1';
			  dsp_ams_n_0_latched <= '1';
			  dsp_awe_n_latched <= '1';
			  dsp_awe_n_latched_previous <= '1';
			  dsp_aoe_n_latched2 <= '1';
			  dsp_hwait_latched <= '0';
       elsif (dsp_ioclk_local'event and dsp_ioclk_local='1') then
		 
			--output data driver:
			dsp_fifo_read_data_intermediate <= dsp_fifo_read_data; --this is to break long timing path
			if (dsp_aoe_n_latched='0') then
				  if (dsp_ams_n_3_latched ='0') then --boot from FIFO
				    dsp_data <= dsp_fifo_read_data_intermediate;
				  else --normal data access
				    dsp_data <= async_read_data;
				  end if;
			else
				  dsp_data <= "ZZZZZZZZZZZZZZZZ";
			end if;
			
			--latch some signals:
			  dsp_address_latched(25 downto 1) <= dsp_addr(25 downto 1);
			  dsp_address_latched(0) <= not dsp_abe_n(0);
			  dsp_ams_n_3_latched <= dsp_ams_n(3);
			  dsp_ams_n_0_latched <= dsp_ams_n(0);
			  dsp_awe_n_latched <= dsp_awe_n;
			  dsp_are_n_latched <= dsp_are_n;
			  dsp_hwait_latched <= dsp_hwait;
           dsp_aoe_n_latched <= dsp_aoe_n;
			  dsp_aoe_n_latched2 <= dsp_aoe_n_latched;
			  dsp_awe_n_latched_previous <= dsp_awe_n_latched;			  
			  --latch write data, break timing path as well (sample in first clk cycle of the wr# pulse)
			  if (dsp_writedata_pass='1') then
			    async_write_data <= dsp_data;
			  end if;
			
			--boot from FIFO: AMS3_n=0--------
			if (dsp_ams_n_3_latched='0') then
			  --read
			  if (dsp_aoe_n_latched='0' and dsp_hwait_latched='0') then
				 dsp_ardy <= '1';
			  elsif (dsp_aoe_n_latched='0' and dsp_hwait_latched='1') then
				 dsp_ardy <= '1';			  
			  elsif (dsp_aoe_n_latched2='0' and dsp_aoe_n_latched='1') then
				 dsp_ardy <= '0';
			  --idle
			  else
				 dsp_ardy <= '1';
			  end if;
			  --increment fifo address for boot-fifo after aoe_n gets deasserted
			  if (dsp_aoe_n_latched2='0' and dsp_aoe_n_latched='1') then
				  dsp_fifo_address_counter <= dsp_fifo_address_counter +1;
			  end if;
			  dsp_writes <= '0';
			  dsp_reads <= '0';
			
			--access to data memory: AMS0_n=0-------
			elsif (dsp_ams_n_0_latched='0') then
			  dsp_abe_n_latched <= dsp_abe_n;--latch only during access	
			  --read
			  if (dsp_are_n_latched='0') then
				 dsp_ardy <= dsp_read_data_ready;
				 dsp_writes <= '0';
			    dsp_reads <= '1';
			  --write
			  elsif (dsp_awe_n_latched_previous='0') then
				 dsp_ardy <= '1';
				 dsp_writes <= '1';
			    dsp_reads <= '0';		 
			  --idle
			  else
				 dsp_ardy <= '0';
				 dsp_writes <= '0';
			    dsp_reads <= '0';
			  end if;

			--no access: -------
			else
			  dsp_ardy <= '0';
			  dsp_writes <= '0';
			  dsp_reads <= '0';
			end if;
       end if;
    end process;
	 
	 dsp_writedata_pass <= (not dsp_ams_n_0_latched) and (not dsp_awe_n_latched) and dsp_awe_n_latched_previous;


	--ACCESS THE INSTRUCTION BUFFER BY THE DSP:-------------------
	clkb <= dsp_ioclk_local;
	enb <= not dsp_ams_n_3_latched;
	web <= "0";
	addrb <= dsp_fifo_address_counter(14 downto 0);
	dinb <= "0000000000000000";
	dsp_fifo_read_data <= doutb;
	



	--ACCESS THE INSTRUCTION BUFFER BY THE PCIE:------------------
	clka <= dsp_instr_wb_clk_o;
	ena <= dsp_instr_wb_stb_o;
	wea <= wea_vectorize;
	addra <= dsp_instr_wb_addr_o(13 downto 0);
	dina <= dsp_instr_wb_data_o;
	dsp_instr_wb_data_i <= douta;
	dsp_instr_wb_ack_i <= dsp_instr_wb_stb_o;

	wea_vectorize(0) <= dsp_instr_wb_stb_o and dsp_instr_wb_wr_o;



	--ACCESS THE DDR MEMORY THROUGH WISHBONE BUS:-----------------------	
	--Also do access packing between the 16bit DSP bus and the on-chip 32bit wishbone bus.
	--This is a fast wishbone master, supporting very long wait states through ack.
	
	dspif_wb_clk_o <= dsp_ioclk_local;
	--wishbone address (byte address, but dword aligned only):
	dspif_wb_addr_o(25 downto 2) <= dsp_address_latched(25 downto 2);
	dspif_wb_addr_o(1 downto 0) <= "00"; --only dword aligned accesses will happen
	dsp_upperlower <= dsp_address_latched(1); --0=lower word
	dspif_wb_sel_o (3 downto 2) <= dsp_upperlower_vectorize and (not dsp_abe_n_latched (1 downto 0));
	dspif_wb_sel_o (1 downto 0) <= (not dsp_upperlower_vectorize) and (not dsp_abe_n_latched (1 downto 0));	
	
	dsp_upperlower_vectorize(0) <= dsp_upperlower;
	dsp_upperlower_vectorize(1) <= dsp_upperlower;
	
    process (dspif_reset, dsp_ioclk_local, wb_state, async_write_data, dsp_reads, dsp_writes, dsp_upperlower,
				dspif_wb_ack_i, dspif_wb_data_i, dsp_awe_n_latched, dsp_are_n_latched) 
    begin
	 if (dspif_reset ='1') then 
       wb_state <= "000";
		 dspif_wb_data_o <= "00000000000000000000000000000000";
		 dspif_wb_stb_o <=  '0';
		 dspif_wb_cyc_o <=  '0';
		 dspif_wb_wr_o <=  '0';		 
		 dsp_read_data_ready <='0';
    else
      if (dsp_ioclk_local'event and dsp_ioclk_local = '1') then
		case ( wb_state ) is

         --********** IDLE STATE. waiting  **********
			when "000" =>   --0        
                if (dsp_reads='1') then
                  wb_state <= "001"; --1
						 dspif_wb_data_o <= "00000000000000000000000000000000";
						 dsp_read_data_ready <='0';
                elsif (dsp_writes='1') then
                  wb_state <= "010"; --2		
						if (dsp_upperlower='1') then --1= upper word
						  dspif_wb_data_o(31 downto 16) <= async_write_data(15 downto 0);
						  dspif_wb_data_o(15 downto 0) <= "0000000000000000";
						else
						  dspif_wb_data_o(31 downto 16) <= "0000000000000000";
						  dspif_wb_data_o(15 downto 0) <= async_write_data(15 downto 0);
						end if;						 
						dsp_read_data_ready <='0';				
					 else --stay in idle 
						 dspif_wb_data_o <= "00000000000000000000000000000000";
						 dsp_read_data_ready <='0';
					 end if;    

         --********** WRITE CYCLE  **********
			when "010" =>   --2        
					if (dspif_wb_ack_i='1') then
					  wb_state <= "011"; --0, idle
					  dspif_wb_stb_o <=  '0';
					  dspif_wb_cyc_o <=  '0';
					  dspif_wb_wr_o <=  '0';						  
					else
					  dspif_wb_stb_o <=  '1';
					  dspif_wb_cyc_o <=  '1';
					  dspif_wb_wr_o <=  '1';	
					end if;
					dsp_read_data_ready <='0';

         --********** READ CYCLE  **********
			when "001" =>   --1        
					if (dspif_wb_ack_i='1') then
					  wb_state <= "011"; --0, idle	
					  dsp_read_data_ready <='1';
					  dspif_wb_stb_o <=  '0';
					  dspif_wb_cyc_o <=  '0';
					  dspif_wb_wr_o <=  '0';						  
					else
					  dspif_wb_stb_o <=  '1';
					  dspif_wb_cyc_o <=  '1';
					  dspif_wb_wr_o <=  '0';	
					end if;
					if (dsp_upperlower='1') then --0=lower word
						  async_read_data(15 downto 0) <= dspif_wb_data_i(31 downto 16);
					else
						  async_read_data(15 downto 0) <= dspif_wb_data_i(15 downto 0);
					end if;	
					

         --********** wait for end of access  **********
			when "011" =>   --1        
					if (dsp_awe_n_latched='1' and dsp_are_n_latched='1') then
					  wb_state <= "000"; --0, idle
					end if;
					
			when others => --error
               wb_state <= "000"; --0

		end case;     
       end if;        
    end if;
    end process;




	--DCM-based ZERO-DELAY CLOCK BUFFER --------------------------------------------
	--(dsp interface I/O clock)
	--to balance t_ISU/t_OSU, adjust the PLL delay parameters.
	--no pll buffering: dsp_ioclk_local <= dsp_ioclk;
	--or use PLL/DCM:

--   --buffer in the PLL feedback path. PLL FBIN can be driven by bufio2fb only, not by direct signals.
----	BUFIO2FB_inst : BUFIO2FB
----   generic map (
----      DIVIDE_BYPASS => TRUE  -- Bypass Divider (TRUE/FALSE) Set the same as associated BUFIO2
----   )
----   port map (
----      O => dsp_ioclk_feedback_2, -- 1-bit Output feedback clock (connect to feedback input of DCM/PLL)
----      I => dsp_ioclk_feedback_1  -- 1-bit Feedback clock input
----   );
--	  clkfb_buf : BUFG
--		port map
--		(O => dsp_ioclk_feedback_2,
--		I => dsp_ioclk_feedback_1);
--	
--  -- Instantiation of the DCM:
--  ioclk_buffer : dcm_for_ioclk_dsp_s6bf
--  port map
--   (-- Clock in ports
--    CLK_IN1            => dsp_ioclk,
--    CLKFB_IN           => dsp_ioclk_feedback_2,
--    -- Clock out ports
--    CLK_OUT1           => dsp_ioclk_local_dummy, --originally:  dsp_ioclk_local
--    CLKFB_OUT          => dsp_ioclk_feedback_1);



	--DSP Reference clock:--------------------------------------------
	dsp_refclk <= x25m_clkin;
	--or generate a 10MHz clock for the DSP, so it can scale it's clocks to(1...63)*10MHz
	--actually its not a PLL, just a DCM.
	pll_dsp_refclk_x : pll_for_dsprefclk
	  port map
		(-- Clock in ports
		 CLK_IN1            => x25m_clkin,
		 -- Clock out ports
		 --CLK_OUT1           => dsp_refclk); --old: drives the DSP refclk pin
		 CLK_OUT1           => dsp_ioclk_local); --new: drives the FPGA logic and the divider for refclk-pin

	--because the DSP output clock is disabled after reset:
	--we need a 70MHz I/O clock for the FPGA (from DCM) and a 10MHz-50MHz reference 
	--clock for the DSP (from a counter/divider).

--    process (dspif_reset, dsp_ioclk_local) 
--    begin
--	 if (dspif_reset='1') then 
--           dsp_refclk_counter <= "000";
--			  dsp_refclk <= '0';
--    elsif (dsp_ioclk_local'event and dsp_ioclk_local = '1') then
--		if (dsp_refclk_counter = "011") then 
--           dsp_refclk_counter <= "000";
--			  dsp_refclk <= '0';
--		elsif (dsp_refclk_counter = "001") then
--           dsp_refclk_counter <= dsp_refclk_counter + 1;
--			  dsp_refclk <= '1';
--		end if;
--    end if;
--    end process;




-- -------- END OF FILE -----------------------------------------------------------
end Behavioral;
