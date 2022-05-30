----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:50:00 04/16/2013 
-- Design Name: 
-- Module Name:    processor_uart - Behavioral 
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
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processor is
    Port (
	 			ACK_I : IN std_logic;
				CLK_I : IN std_logic;
				DAT_I : IN std_logic_vector(7 downto 0);
				RST_I : IN std_logic;
				ADR_O : OUT std_logic_vector(7 downto 0);
				CYC_O : OUT std_logic;
				DAT_O: OUT std_logic_vector(7 downto 0);
				STB_O : OUT std_logic;
				WE_O: OUT std_logic;
				RX : IN std_logic;      
				TX : OUT std_logic

		);

	 
	 
end processor;

architecture Behavioral of processor is
	COMPONENT burst_uart
	PORT(
		CLOCK : IN std_logic;
		DBIN : IN std_logic_vector(7 downto 0);
		write_strobe : IN std_logic;
		RESET : IN std_logic;
		DATA_STREAM_OUT_ACK : IN std_logic;
		RX : IN std_logic;          
		ack : OUT std_logic;
		DATA_OUT : OUT std_logic_vector(7 downto 0);
		DATA_STREAM_OUT_STB : OUT std_logic;
		send_data: in std_logic;
		queue_empty:out std_logic;
		TX : OUT std_logic
		);
	END COMPONENT;
	

	COMPONENT uart_to_instruction
	PORT(
		uart_rx_data_out_stb : IN std_logic;
		data_in : IN std_logic_vector(7 downto 0);
		next_instructie : IN std_logic;
		clock : IN std_logic;
		queue_empty : IN std_logic;          
		rd : OUT std_logic;
		enable : OUT std_logic;
		send_data : OUT std_logic;
		opcode : OUT std_logic;
		adress : OUT std_logic_vector(7 downto 0);
		data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;



-- VHDL Instantiation Created from source file IOALU.vhd -- 10:58:43 05/23/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT IOALU
	PORT(
		ACK_I : IN std_logic;
		CLK_I : IN std_logic;
		DAT_I : IN std_logic_vector(7 downto 0);
		RST_I : IN std_logic;
		enable : IN std_logic;
		adress : IN std_logic_vector(7 downto 0);
		db_in : IN std_logic_vector(7 downto 0);
		queue_ack : IN std_logic;
		opcode : IN std_logic;          
		ADR_O : OUT std_logic_vector(7 downto 0);
		CYC_O : OUT std_logic;
		DAT_O : OUT std_logic_vector(7 downto 0);
		STB_O : OUT std_logic;
		WE_O : OUT std_logic;
		db_out : OUT std_logic_vector(7 downto 0);
		rs232_we : OUT std_logic;
		error : OUT std_logic;
		next_instructie : OUT std_logic
		);
	END COMPONENT;



	signal db_out,DATA_OUT :std_logic_vector(7 downto 0);
	signal uart_rx_data_out_stb,next_instructie: std_logic;
	signal rd,enable,send_data,queue_empty,write_strobe: std_logic;
	signal opcode,error,queue_ack: std_logic;
	signal adress :std_logic_vector(7 downto 0);
	signal data : std_logic_vector(7 downto 0);
begin

	Inst_uart_to_instruction: uart_to_instruction PORT MAP(
		CLOCK => CLK_I,
		uart_rx_data_out_stb =>uart_rx_data_out_stb,
		data_in=> DATA_OUT,
		rd => rd,
		enable=>enable,
		send_data=>send_data,
		queue_empty=>queue_empty,
		next_instructie=>next_instructie,
		opcode => opcode,
		adress => adress,
		data => data
	);

	Inst_burst_uart: burst_uart PORT MAP(
		CLOCK => CLK_I,
		DBIN => db_out,
		write_strobe => write_strobe,
		ack => queue_ack,
		RESET => RST_I,
		DATA_STREAM_OUT_ACK => rd,
		DATA_OUT => DATA_OUT,
		DATA_STREAM_OUT_STB => uart_rx_data_out_stb,
		send_data=>send_data,
		queue_empty=>queue_empty,
		RX => RX,
		TX => TX
	);
	Inst_IOALU: IOALU PORT MAP(
		ACK_I => ACK_I,
		ADR_O => ADR_O,
		CLK_I => CLK_I,
		CYC_O => CYC_O,
		DAT_I => DAT_I,
		DAT_O => DAT_O,
		RST_I => RST_I,
		STB_O => STB_O,
		WE_O => WE_O,
		enable =>enable ,
		adress => adress,
		db_in => data,
		db_out => db_out,
		rs232_we =>write_strobe,
		queue_ack => queue_ack,
		opcode => opcode,
		error => error,
		next_instructie => next_instructie
	);

end Behavioral;

