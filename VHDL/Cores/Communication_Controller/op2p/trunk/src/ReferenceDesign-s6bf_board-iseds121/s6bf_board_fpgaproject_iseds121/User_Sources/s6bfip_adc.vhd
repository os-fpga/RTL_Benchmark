----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Istvan Nagy, buenos@freemail.hu
-- 
-- Create Date:    15:58:13 05/30/2010 
-- Design Name: 
-- Module Name:    s6bfip_adc - Behavioral 
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
-- This module handles the incoming data from the ADC (Texas Instruments ADS5517),
--controls the bahaviour of both the ADC and the PGA.
--The ADC reference clock is driven to be 200MHz
--The ADC data is continously packed into 32bit dwords, but only the upper 8 bits,
--then sento to the wishbone bus to write it into the memory. This starts when we
--set the adc_start flag, and finishes when 64MBytes has been written. 1 transfer
--at every clock edge, at 25MHz.
--PGA gain: see the PGA870 datasheet. 0=-11.5dB, 63=+20dB
--Buffering: The core buffers 32kBytes (32kSamples) of data into a local FIFO then
-- writes it out into the DDR buffer memory at address locations: 
-- ?600'0000...?6007FFF (? comes from the PCIE-BAR, but locally its 0)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity s6bfip_adc is
    Port ( --PORT LIST:------------------
			 --FPGA_PINS (EXTERNAL):---
			  ADC_CLK_REFOUT_P : out    std_logic; --set LVDS+Rs --200MHz
			  ADC_CLK_REFOUT_N  : out    std_logic; --set LVDS+Rs			 
			  ADC_CLK_IN_P   : in    std_logic; --set LVDS+Rp, use GCLK-pin
			  ADC_CLK_IN_N   : in    std_logic; --set LVDS+Rp, use GCLK-pin
			  ADC_DATA_IN_P   : in    std_logic_vector(5 downto 0); --set LVDS+Rp
			  ADC_DATA_IN_N   : in    std_logic_vector(5 downto 0); --set LVDS+Rp
			  ADC_OE : out std_logic;
			  ADC_OVR : in std_logic;
			  ADC_SDATA : out std_logic;
			  ADC_SCLK : out std_logic;
			  ADC_SEN : out std_logic;
			  ADC_RESET : out std_logic;
			  PGA_DATA_out  : out    std_logic_vector(5 downto 0); 
			  PGA_STROBE : out std_logic;
			 --DATA BUS (wishbone):
			 adcif_wb_data_o : out std_logic_vector(31 downto 0); 
			 adcif_wb_data_i : in std_logic_vector(31 downto 0);
			 adcif_wb_addr_o : out std_logic_vector(25 downto 0);
			 adcif_wb_cyc_o : out std_logic;
			 adcif_wb_stb_o : out std_logic;
			 adcif_wb_wr_o : out std_logic;
			 adcif_wb_ack_i : in std_logic;
			 adcif_wb_clk_o : out std_logic; --50MHz
			 adcif_wb_sel_o : out std_logic_vector(3 downto 0);
			 --CONTROL:
			 adc_overshoot_detected : out std_logic;
			 pga_gain : in std_logic_vector(5 downto 0); 
			 adc_triggerlevel : in std_logic_vector(7 downto 0); 
			 adc_start : in  std_logic; --edge sensitive
			 adc_finished : out  std_logic;
			 --SYSTEM:
			 x25m_clkin : in std_logic;
			 adcif_reset : in std_logic --active high
			 );
end s6bfip_adc;


architecture Behavioral of s6bfip_adc is

   -- Internal Signals ------------------------------------------------------------
	--SIGNAL dummy : std_logic_vector(15 downto 0);	--write data bus
	SIGNAL adc_localreset : std_logic;
	SIGNAL CLK_OUT200M : std_logic;
	SIGNAL LOCKED : std_logic;
	SIGNAL local_adc_parallel_clk : std_logic;
	SIGNAL adc_byteposition : std_logic_vector(1 downto 0); 
	SIGNAL adc_32bit_data : std_logic_vector(31 downto 0); 
	SIGNAL adc_32bit_data_shaddow : std_logic_vector(31 downto 0); 
	SIGNAL DATA_IN_TO_DEVICE : std_logic_vector(11 downto 0); 
	SIGNAL adcif_wb_addr_o_local : std_logic_vector(25 downto 0); 
	SIGNAL adc_wb_run  : std_logic;
	SIGNAL adcif_wb_clk_o_local : std_logic;
	SIGNAL adcrunff_state : std_logic_vector(2 downto 0);
	SIGNAL clk_adc_50m  : std_logic;
	SIGNAL clk_adc_100m  : std_logic;
	SIGNAL adcwb_state : std_logic_vector(2 downto 0);
	SIGNAL adcfifo_writedata  : std_logic_vector(7 downto 0);
	SIGNAL adcfifo_wen  : std_logic;
	SIGNAL adcfifo_rd_en  : std_logic;
	SIGNAL adcfifo_dout  : std_logic_vector(31 downto 0);
	SIGNAL adcfifo_full  : std_logic;
	SIGNAL adcfifo_empty  : std_logic;
	SIGNAL adcfifo_underflow  : std_logic;
	SIGNAL adc_wb_run_ioclk  : std_logic;
	SIGNAL adc_wb_run_ioclk1  : std_logic;
	SIGNAL adc_wb_run_ioclk2  : std_logic;
	SIGNAL adcfifo_writecount  : std_logic_vector(15 downto 0);
	SIGNAL adc_start_wbclk  : std_logic;
	SIGNAL adc_start_wbclk1  : std_logic;
	SIGNAL adcrunff_counter  : std_logic_vector(4 downto 0);


	-- COMPONENT DECLARATIONS (introducing the IPs) --------------------------------

	component adc_interface
	generic
	 (-- width of the data for the system
	  sys_w       : integer := 6;
	  -- width of the data for the device
	  dev_w       : integer := 12);
	port
	 (
	  -- From the system into the device
	  DATA_IN_FROM_PINS_P     : in    std_logic_vector(sys_w-1 downto 0);
	  DATA_IN_FROM_PINS_N     : in    std_logic_vector(sys_w-1 downto 0);
	  DATA_IN_TO_DEVICE       : out   std_logic_vector(dev_w-1 downto 0);
	  CLK_IN_P                : in    std_logic;
	  CLK_IN_N                : in    std_logic;
	  CLK_OUT                 : out   std_logic;
	  CLK_RESET               : in    std_logic;
	  IO_RESET                : in    std_logic);
	end component;

	component pll_for_adc
	port
	 (-- Clock in ports
	  CLK_IN1           : in     std_logic;
	  -- Clock out ports
	  CLK_OUT1          : out    std_logic;
	  -- Status and control signals
	  RESET             : in     std_logic;
	  LOCKED            : out    std_logic
	 );
	end component;

	component adc_fifo_8b32b --32kBytes resizing FIFO
		port (
		rst: IN std_logic;
		wr_clk: IN std_logic;
		rd_clk: IN std_logic;
		din: IN std_logic_VECTOR(7 downto 0);
		wr_en: IN std_logic;
		rd_en: IN std_logic;
		dout: OUT std_logic_VECTOR(31 downto 0);
		full: OUT std_logic;
		empty: OUT std_logic;
		underflow: OUT std_logic);
	end component;

	
	

-- ------- SYNTHESIS ATTRIBUTES: --------------------------------------------------
--attribute keep_hierarchy : string; 
--attribute keep_hierarchy of s6bfip_adc: entity is "yes"; 
 -- KEEP HIERARCHY
 -- attribute keep : string; 
 -- attribute keep of clock_signal_name: signal is "true"; 
 attribute keep : string; 
 attribute keep of adcif_wb_clk_o: signal is "true"; 
 attribute keep of local_adc_parallel_clk: signal is "true";
 
 
-- --------ARCHITECTURE BODY BEGINS -----------------------------------------------
begin

	adcif_wb_sel_o <= "1111"; --always write 32bits


	-- COMPONENT INSTALLATIONS (connecting the IPs to local signals) ---------------
	inst_adc : adc_interface
	  port map
		(
			  -- From the system into the device
		 DATA_IN_FROM_PINS_P     => ADC_DATA_IN_P,     -- IN     [5:0]
		 DATA_IN_FROM_PINS_N     => ADC_DATA_IN_N,     -- IN     [5:0]
		 DATA_IN_TO_DEVICE       => DATA_IN_TO_DEVICE,       -- OUT    [11:0], LSB is rubbish, not data
		 CLK_IN_P                => ADC_CLK_IN_P,                -- IN
		 CLK_IN_N                => ADC_CLK_IN_N,                -- IN
		 CLK_OUT                 => local_adc_parallel_clk,        -- OUT
		 CLK_RESET               => adc_localreset,               -- IN
		 IO_RESET                => adc_localreset);               -- IN


	--PLL to generate 200MHz low-jitter ADC clock from the 25MHz osc clock
	inst_pll_for_adc : pll_for_adc
	  port map
		(-- Clock in ports
		 CLK_IN1            => x25m_clkin,
		 -- Clock out ports
		 CLK_OUT1           => CLK_OUT200M,
		 -- Status and control signals
		 RESET              => adcif_reset,
		 LOCKED             => LOCKED);

   --ADC ref clock output buffer:
	OBUFDS_inst : OBUFDS
   generic map (
      IOSTANDARD => "LVDS_33")
   port map (
      O => ADC_CLK_REFOUT_P,     -- Diff_p output (connect directly to top-level port)
      OB => ADC_CLK_REFOUT_N,   -- Diff_n output (connect directly to top-level port)
      I => CLK_OUT200M      -- Buffer input 
		);

  adc_fifo_instance : adc_fifo_8b32b
		port map (
			rst => adc_localreset,
			wr_clk => local_adc_parallel_clk,
			rd_clk => clk_adc_50m,
			din => adcfifo_writedata,
			wr_en => adcfifo_wen,
			rd_en => adcfifo_rd_en,
			dout => adcfifo_dout,
			full => adcfifo_full,
			empty => adcfifo_empty,
			underflow => adcfifo_underflow); 




	-- MAIN LOGIC: -----------------------------------------------------------------
	
	PGA_DATA_out <= pga_gain;
	PGA_STROBE <= '1';
	adc_overshoot_detected <= ADC_OVR;
	ADC_OE <= '1';
	
	--ADC strappings:
	ADC_SDATA <= '0'; --not in powerdown
	ADC_SCLK <= '0'; --f>50MHz
	ADC_SEN <= '1'; --center aligned data/clk
	ADC_RESET <= '1'; --the serial config interface is not used

	--ADC_RESET <= (NOT LOCKED) or adcif_reset;
	adc_localreset <= (NOT LOCKED) or adcif_reset;
	
	--DATA packing to 32bits, and wb clock generation/synchronization:
    process (adc_localreset, local_adc_parallel_clk, adc_byteposition,
				adc_wb_run_ioclk1, adc_wb_run_ioclk, adcfifo_full)
    begin
       if (adc_localreset='1') then
           adcfifo_writedata <= "00000000";
			  adc_byteposition <= "00";
			  clk_adc_50m <='0';
			  clk_adc_100m <='0';
			  adc_wb_run_ioclk1 <='0';
			  adc_wb_run_ioclk2 <='0';
			  adc_wb_run_ioclk <='0';
			  adcfifo_wen <= '0';
			  adcfifo_writecount(15 downto 1) <=  (OTHERS => '0');
			  adcfifo_writecount(0) <= '1';
       elsif (local_adc_parallel_clk'event and local_adc_parallel_clk='1') then
         adc_wb_run_ioclk1 <= adc_wb_run;
			adc_wb_run_ioclk2 <= adc_wb_run_ioclk1;
			adc_wb_run_ioclk <= adc_wb_run_ioclk2 or adc_wb_run_ioclk1;
			 adc_byteposition <= adc_byteposition + 1;
			--write 32kbytes of data into FIFO at 200MHz
			if (adc_wb_run_ioclk = '1') then 
			  if (adcfifo_writecount(15) = '1') then --32768
			     adcfifo_wen <= '0';  
			  else
				  adcfifo_writedata <= DATA_IN_TO_DEVICE (11 downto 4);
				  adcfifo_wen <= '1';
				  adcfifo_writecount <=  adcfifo_writecount +1;
			  end if;
			else --(adc_wb_run_ioclk='0')
			  adcfifo_wen <= '0';
			  adcfifo_writecount(15 downto 1) <=  (OTHERS => '0');
			  adcfifo_writecount(0) <= '1';
			end if;
			--generate some clocks:
			if (adc_byteposition = "00") then
			  clk_adc_50m <='0';
			  clk_adc_100m <='0';
			elsif (adc_byteposition= "01") then
			  clk_adc_50m <='0';
			  clk_adc_100m <='1';
			elsif (adc_byteposition= "10") then
			  clk_adc_50m <='1';
			  clk_adc_100m <='0';
			else --(adc_byteposition="11")
			  clk_adc_50m <='1';
			  clk_adc_100m <='1';
			end if;
       end if;
    end process;	
	
    adcif_wb_clk_o <= clk_adc_50m;
	 adcif_wb_clk_o_local <= clk_adc_50m;


	 
	 --wishbone bus interface:
	 --control signal scheduling:
	 --4clk / transfer at 50MHz/32bit (50MBytes/sec)
    process (adc_localreset, adcif_wb_clk_o_local, adcwb_state, adcfifo_empty, adcfifo_dout, adcif_wb_addr_o_local) 
    begin
	 if (adc_localreset='1') then 
           adcwb_state <= "000";
				adcif_wb_addr_o <= "10000000000000000000000000";
				adcif_wb_addr_o_local <= "10000000000000000000000000";
				adcif_wb_cyc_o <= '0';
				adcif_wb_stb_o <= '0';
				adcif_wb_wr_o <= '0';
				adcfifo_rd_en <= '0';
     else
      if (adcif_wb_clk_o_local'event and adcif_wb_clk_o_local = '1') then

          case ( adcwb_state ) is

                  --********** idle STATE.  **********
				  when "000" =>   --0        
                      if (adcfifo_empty = '0') then --there is something in the fifo
							   adcwb_state <= "001"; --1/
								adcfifo_rd_en <= '1';
							 else
							   adcfifo_rd_en <= '0';
							   --if ADC is finished, then reset addresses (wr is faster than rd):
								adcif_wb_addr_o <= "10000000000000000000000000";
								adcif_wb_addr_o_local <= "10000000000000000000000000";
							 end if;                     
							   adcif_wb_cyc_o <= '0';
							   adcif_wb_stb_o <= '0';
							   adcif_wb_wr_o <= '0';	     
								
                  --********** start wb write STATE **********           
 				  when "001" =>  --1: 
							adcfifo_rd_en <= '0'; --just 1clk for the rd_en
						  adcif_wb_cyc_o <= '1';
						  adcif_wb_stb_o <= '1';
						  adcif_wb_wr_o <= '1';	
							adcwb_state <= "010"; --2/
							
                  --********** launch data STATE 2 **********
						--put data on the bus
 				  when "010" =>  --2: 
						  adcif_wb_cyc_o <= '1';
						  adcif_wb_stb_o <= '1';
						  adcif_wb_wr_o <= '1';
						  --latch valid data to wishbone-bus, with endian-swap (first sample goes to LSB byte-address)
						  --this is needed to compensate for the FIFOs built-in byte swap side-effect
						  adcif_wb_data_o(7 downto 0) <= adcfifo_dout(31 downto 24); 
						  adcif_wb_data_o(15 downto 8) <= adcfifo_dout(23 downto 16); 
						  adcif_wb_data_o(23 downto 16) <= adcfifo_dout(15 downto 8); 
						  adcif_wb_data_o(31 downto 24) <= adcfifo_dout(7 downto 0); 
							adcwb_state <= "011"; --3/

                  --********** finish wb write STATE **********           
 				  when "011" =>  --3: 
							if (adcif_wb_ack_i='1') then
								adcif_wb_addr_o <= adcif_wb_addr_o_local + 4;
								adcif_wb_addr_o_local <= adcif_wb_addr_o_local + 4;
							  adcif_wb_cyc_o <= '0';
							  adcif_wb_stb_o <= '0';
							  adcif_wb_wr_o <= '0';	
							  adcwb_state <= "000"; --0/
							end if;

                  --********** default/error STATE ********** 
				  when others => 
                      adcwb_state <= "000"; --0/

          end case;     

       end if;        
     end if;
    end process;




	--run flipflop:
    process (adc_localreset, adcif_wb_clk_o_local, adc_start, 
				adcrunff_state, adcfifo_empty, adc_start, adc_start_wbclk1) 
    begin
     if (adc_localreset='1') then
           adc_wb_run <= '0';
			  adc_finished <= '0';
			  adcrunff_state <= "000";
			  adcrunff_counter <= (OTHERS => '0');
     else
      if (adcif_wb_clk_o_local'event and adcif_wb_clk_o_local = '1') then

          adc_start_wbclk1 <= adc_start;
			 adc_start_wbclk <= adc_start_wbclk1;
			 
			 case ( adcrunff_state ) is

                  --********** idle STATE.  **********
				  when "000" =>   --0        
                      if (adc_start_wbclk ='1') then --start upon user request:
							   adcrunff_state <= "100"; --4/
								adc_wb_run <= '1';
							 else
							   adc_wb_run <= '0';
							 end if;
							 adc_finished <= '0';
							 adcrunff_counter <= (OTHERS => '0');							 
				      --intermediate state, to allow address to move out from the "max_value" and "empty" to deassert
				  when "100" =>   --0        
                      adcrunff_counter <= adcrunff_counter +1;
							 if (adcrunff_counter = "00111") then --wait 7clk
							   adcrunff_state <= "001"; --1/
							 end if;
							 
                  --********** started running STATE **********           
 				  when "001" =>  --1: 
							  if (adcfifo_empty = '1') then --stop after all data was written out:
							    adcrunff_state <= "010"; --2/ 
								 adc_finished <= '1';
								 adc_wb_run <= '0';
							  else
							    adc_finished <= '0';
								 adc_wb_run <= '1';
							  end if;

                  --********** wait for start/reset STATE **********           
 				  when "010" =>  --2: 
                      if (adc_start_wbclk='0') then
							   adcrunff_state <= "000"; --0/
								adc_finished <= '0';
							 end if;

                  --********** default/error STATE ********** 
				  when others => 
                      adcrunff_state <= "000"; --0/

          end case;     

       end if;        
     end if;
    end process;







-- -------- END OF FILE -----------------------------------------------------------
end Behavioral;
