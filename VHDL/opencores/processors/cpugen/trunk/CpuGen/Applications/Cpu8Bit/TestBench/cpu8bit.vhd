LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.CPU_UTILS.all;


ENTITY cpu8bit IS
   PORT ( 
	UCLK 		: IN std_logic;
	nRESET 	: IN std_logic;
	PORTA_IN 	: IN std_logic_vector(7 DOWNTO 0);
	PORTB_IN 	: IN std_logic_vector(7 DOWNTO 0);
	RXD 		: IN std_logic;
	IN_INT 	: IN std_logic_vector(3 DOWNTO 0);
	TXD 		: OUT std_logic;
	PORTA_OUT 	: OUT std_logic_vector(7 DOWNTO 0);
	PORTB_OUT 	: OUT std_logic_vector(7 DOWNTO 0)	
	);
end cpu8bit;

ARCHITECTURE SCHEMATIC OF cpu8bit IS

   SIGNAL CPU_IADDR_OUT		:	STD_LOGIC_VECTOR (9 DOWNTO 0);
   SIGNAL CPU_DATA_OUT		:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL CPU_DATA_IN		:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL CPU_ADDR_OUT		:	STD_LOGIC_VECTOR (9 DOWNTO 0);
   SIGNAL CPU_ADADDR_OUT	:	STD_LOGIC_VECTOR (9 DOWNTO 0);
   SIGNAL CPU_IDATA_IN		:	STD_LOGIC_VECTOR (13 DOWNTO 0);
   SIGNAL nWE_CPU			: 	STD_LOGIC;
   SIGNAL nAWE_CPU		: 	STD_LOGIC;
   SIGNAL nRE_CPU			: 	STD_LOGIC;
   SIGNAL nWE_RAM			: 	STD_LOGIC;
   SIGNAL CPU_INT			: 	STD_LOGIC;
   SIGNAL TX_UART_INT		: 	STD_LOGIC;
   SIGNAL RX_UART_INT		: 	STD_LOGIC;
   SIGNAL OVR_UART_INT		: 	STD_LOGIC;
   SIGNAL TIMER_INT		: 	STD_LOGIC;
   SIGNAL nCS_INT			: 	STD_LOGIC;
   SIGNAL nCS_UART		: 	STD_LOGIC;
   SIGNAL nCS_TIMER		: 	STD_LOGIC;
   SIGNAL nCS_REG			: 	STD_LOGIC;
   SIGNAL CTRL_DATA_OUT		:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL RAM_DATA_OUT		:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL INT_DATA_OUT		:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL REG_DATA_OUT		:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL TIMER_DATA_OUT	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL UART_DATA_OUT		:	STD_LOGIC_VECTOR (7 DOWNTO 0);

   COMPONENT cpu
      PORT ( 
		iaddr_out: 		out	Cpu_iaddr;
		data_out: 		out	Cpu_dobus;
		daddr_out: 		out	Cpu_daddr;
		adaddr_out: 	out	Cpu_daddr;
		idata_in: 		in	Cpu_ibus;
		data_in: 		in	Cpu_dibus;
		ndre_out:		out	std_logic;
		ndwe_out:		out	std_logic;
		nadwe_out:		out	std_logic;
		int_in:		in	std_logic;
		nreset_in:		in	std_logic;
		clk_in:		in	std_logic
	);
   END COMPONENT;

   COMPONENT ctrl8cpu
      PORT ( 
		nWE_RAM:		out	std_logic;
		nCS_INT:		out	std_logic;
		nCS_UART:		out	std_logic;
		nCS_TIMER:		out	std_logic;
		nCS_REG:		out	std_logic;
		CPU_DATA_IN:	out	std_logic_vector(7 downto 0);
		CPU_ADDR_OUT:	in	std_logic_vector(9 downto 0);		
		CPU_DATA_OUT:	in	std_logic_vector(7 downto 0);
		RAM_DATA_OUT:	in	std_logic_vector(7 downto 0);
		INT_DATA_OUT:	in	std_logic_vector(7 downto 0);
		REG_DATA_OUT:	in	std_logic_vector(7 downto 0);
		TIMER_DATA_OUT:	in	std_logic_vector(7 downto 0);
		UART_DATA_OUT:	in	std_logic_vector(7 downto 0);
		nWE_CPU:		in	std_logic;
		nRE_CPU:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
   END COMPONENT;

   COMPONENT interrupt
      GENERIC (NI : integer := 8);
      PORT ( 
		int_ext:		out 	std_logic;
		int_out:		out	std_logic_vector((NI - 1) downto 0);
		int_in:		in 	std_logic_vector((NI - 1) downto 0);
		int_data:		in 	std_logic_vector((NI - 1) downto 0);
		addr:			in	std_logic;
		nWE:			in	std_logic;
		nCS_INT:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
   END COMPONENT;

   COMPONENT tx_uart
      PORT ( 
		tx_uart:		out   std_logic;
		tx_uart_empty:	out   std_logic;
		tx_uart_data:	in	std_logic_vector(7 downto 0);
		addr:			in	std_logic;		
		nWE:			in	std_logic;
		nCS_UART:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
   END COMPONENT;

   COMPONENT rx_uart
      PORT ( 
		rx_uart_full:	out std_logic;
		rx_uart_ovr:	out std_logic;
		rx_uart_out:	out	std_logic_vector(7 downto 0);
		rx_uart_in:		in	std_logic_vector(7 downto 0);
		rx_uart: 		in	std_logic;
		addr: 		in	std_logic;
		nWE:			in	std_logic;
		nRE:			in	std_logic;
		nCS_UART:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
   END COMPONENT;

   COMPONENT timer
      PORT ( 
		tmr_int:	out 	std_logic;
		tmr_out:	out	std_logic_vector(7 downto 0);
		tmr_in:	in 	std_logic_vector(7 downto 0);
		addr:		in	std_logic;
		nWE:		in	std_logic;
		nCS_TIMER:	in	std_logic;
		clk:		in	std_logic;
		nreset:	in	std_logic
	);
   END COMPONENT;

   COMPONENT inout4reg
      PORT ( 
		out_0reg:		out	std_logic_vector(7 downto 0);
		out_1reg:		out	std_logic_vector(7 downto 0);
		in_0reg:		in	std_logic_vector(7 downto 0);
		in_1reg:		in	std_logic_vector(7 downto 0);
		reg_data_out:	out	std_logic_vector(7 downto 0);		
		reg_data_in:	in	std_logic_vector(7 downto 0);
		addr:			in	std_logic;
		nWE:			in	std_logic;
		nRE:			in	std_logic;
		nCS_REG:		in	std_logic;
		nreset:		in	std_logic;
		clk:			in	std_logic
	);
   END COMPONENT;

   COMPONENT ram
  	GENERIC(
		DADDR_LEN:		integer:= 8;
		DATA_LEN:		integer:= 8;
	      FILENAME:		STRING:="ram.vin"
	);    
  	PORT(	
		ram_data_out: 		out 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_data_in: 		in 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_addr_in: 		in 	std_logic_vector((DADDR_LEN - 1) downto 0);
		nwe:				in	std_logic;
		nreset:			in	std_logic;
		clk:				in	std_logic
	);
   END COMPONENT;

   COMPONENT rom
  generic(
		IADDR_LEN:		integer:= 8;
		IDATA_LEN:		integer:= 10;
		FILENAME:   	STRING:="rom.vin"
	);    
  port(	
		rom_data_out: 	out 	std_logic_vector((IDATA_LEN - 1) downto 0);
		rom_addr_in: 	in 	std_logic_vector((IADDR_LEN - 1) downto 0);
		clk:			in	std_logic
	);
   END COMPONENT;

BEGIN

   I1 : cpu
      PORT MAP (
		iaddr_out 		=> CPU_IADDR_OUT,
		data_out 		=> CPU_DATA_OUT,
		daddr_out 		=> CPU_ADDR_OUT,
		adaddr_out		=> CPU_ADADDR_OUT,
		idata_in 		=> CPU_IDATA_IN,
		data_in 		=> CPU_DATA_IN,
		ndre_out		=> nRE_CPU,
		ndwe_out		=> nWE_CPU,
		nadwe_out		=> nAWE_CPU,
		int_in		=> CPU_INT,
		nreset_in		=> NRESET,
		clk_in		=> UCLK
	);

   I2 : ctrl8cpu
      PORT MAP (
		nWE_RAM		=> nWE_RAM,
		nCS_INT		=> nCS_INT,
		nCS_UART		=> nCS_UART,
		nCS_TIMER		=> nCS_TIMER,
		nCS_REG		=> nCS_REG,
		CPU_DATA_IN		=> CPU_DATA_IN,
		CPU_ADDR_OUT	=> CPU_ADDR_OUT,
		CPU_DATA_OUT	=> CPU_DATA_OUT,
		RAM_DATA_OUT	=> RAM_DATA_OUT,
		INT_DATA_OUT	=> INT_DATA_OUT,
		REG_DATA_OUT	=> REG_DATA_OUT,
		TIMER_DATA_OUT	=> TIMER_DATA_OUT,
		UART_DATA_OUT	=> UART_DATA_OUT,
		nWE_CPU		=> nWE_CPU,
		nRE_CPU		=> nRE_CPU,
		clk			=> UCLK,
		nreset		=> NRESET
	);

   I3 : ram
  	GENERIC MAP(
		DADDR_LEN		=> 8,
		DATA_LEN		=> 8,
	        FILENAME		=> "..\ram.vin"
	)    
      PORT MAP (
		ram_data_out	=> RAM_DATA_OUT,
		ram_data_in		=> CPU_DATA_OUT,
		ram_addr_in		=> CPU_ADDR_OUT(7 DOWNTO 0),
		nwe			=> nWE_RAM,
		nreset		=> NRESET,
		clk			=> UCLK
	);

   I4 : rom
  	GENERIC MAP(
		IADDR_LEN		=> 10,
		IDATA_LEN		=> 14,
	      FILENAME		=> "..\rom.vin"
	)    
      PORT MAP (
		rom_data_out	=> CPU_IDATA_IN,
		rom_addr_in		=> CPU_IADDR_OUT,
		clk			=> UCLK
	);

   I5 : interrupt
  	GENERIC MAP(
		NI		=> 8
	)    
      PORT MAP (
		int_ext		=> CPU_INT,
		int_out		=> INT_DATA_OUT,
		int_in(7)		=> TIMER_INT,
		int_in(6)		=> TX_UART_INT,
		int_in(5)		=> RX_UART_INT,
		int_in(4)		=> OVR_UART_INT,
		int_in(3 DOWNTO 0)=> IN_INT(3 DOWNTO 0),
		int_data		=> CPU_DATA_OUT,
		addr			=> CPU_ADDR_OUT(0),
		nWE			=> nWE_CPU,
		nCS_INT		=> nCS_INT,
		clk			=> UCLK,
		nreset		=> NRESET
	);

   I6 : tx_uart
      PORT MAP (
		tx_uart		=> TXD,
		tx_uart_empty	=> TX_UART_INT,
		tx_uart_data	=> CPU_DATA_OUT,
		addr			=> CPU_ADDR_OUT(0),		
		nWE			=> nWE_CPU,
		nCS_UART		=> nCS_UART,
		clk			=> UCLK,
		nreset		=> NRESET
	);

   I7 : rx_uart
      PORT MAP (
		rx_uart_full	=> RX_UART_INT,
		rx_uart_ovr		=> OVR_UART_INT,
		rx_uart_out		=> UART_DATA_OUT,	
		rx_uart_in		=> CPU_DATA_OUT,
		rx_uart		=> RXD,
		addr			=> CPU_ADDR_OUT(0),		
		nWE			=> nWE_CPU,
		nRE			=> nRE_CPU,
		nCS_UART		=> nCS_UART,
		clk			=> UCLK,
		nreset		=> NRESET
	);

   I8 : timer
      PORT MAP (
		tmr_int		=> TIMER_INT,
		tmr_out		=> TIMER_DATA_OUT,
		tmr_in		=> CPU_DATA_OUT,
		addr			=> CPU_ADDR_OUT(0),
		nWE			=> nWE_CPU,
		nCS_TIMER		=> nCS_TIMER,
		clk			=> UCLK,
		nreset		=> NRESET
	);

   I9 : inout4reg
      PORT MAP (
		out_0reg		=> PORTA_OUT,
		out_1reg		=> PORTB_OUT,
		in_0reg		=> PORTA_IN,
		in_1reg		=> PORTB_IN,
		reg_data_out	=> REG_DATA_OUT,		
		reg_data_in		=> CPU_DATA_OUT,
		addr			=> CPU_ADDR_OUT(0),
		nWE			=> nWE_CPU,
		nRE			=> nRE_CPU,
		nCS_reg		=> nCS_REG,
		nreset		=> NRESET,
		clk			=> UCLK
	);

END SCHEMATIC;



