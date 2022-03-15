--
-- VHDL: STACK_T
--	gferrante@opencores.org
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY stack_t IS

   GENERIC(
		DATA_LEN:	integer:= 8;
		DEEP_LEN:	integer:= 8
	);    
   PORT(	
		saddr_in: 		out 	std_logic_vector((DATA_LEN - 1) downto 0);
		saddr_out: 		in 	std_logic_vector((DATA_LEN - 1) downto 0);
		ipush_out: 		in 	std_logic;
		ipop_out:		in	std_logic;
		nreset_in:		in	std_logic;
		clk_in:		in	std_logic
	);

END stack_t;

LIBRARY ieee, work;
USE ieee.std_logic_1164.all;

LIBRARY std;
USE std.textio.ALL;

ARCHITECTURE stack_t_struct OF stack_t IS

   -- Internal signal declarations

	signal	npush:		std_logic;
	signal 	addr_out:		std_logic_vector((DEEP_LEN - 1) downto 0);

   -- Component Declarations

   COMPONENT STACK_IF
   GENERIC(
		DATA_LEN:	integer:= 8
	);    
   PORT(	
		addr_out: 		out 	std_logic_vector((DATA_LEN - 1) downto 0);
		push_in: 		in 	std_logic;
		pop_in:		in	std_logic;
		nreset_in:		in	std_logic;
		clk_in:		in	std_logic
	);
   END COMPONENT;
   
   COMPONENT SRAM
   GENERIC(
		DADDR_LEN:	integer:= 8;
		DATA_LEN:	integer:= 8
	);    
   PORT(	
		ram_data_out: 	out 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_data_in: 	in 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_addr_in: 	in 	std_logic_vector((DADDR_LEN - 1) downto 0);
		nwe:			in	std_logic;
		nreset:		in	std_logic;
		clk:			in	std_logic
	);
   END COMPONENT;
  
   -- Optional embedded configurations
   FOR ALL : STACK_IF USE ENTITY WORK.STACK_IF;
   FOR ALL : SRAM USE ENTITY WORK.SRAM;

begin

   -- Instance port mappings

   I1 : STACK_IF
      GENERIC MAP (
         DATA_LEN		=> DEEP_LEN
      )
      PORT MAP (
		addr_out	=>	addr_out,
		push_in	=>	ipush_out,
		pop_in	=>	ipop_out,
		nreset_in	=>	nreset_in,
		clk_in	=> 	clk_in
      );

   I2 : SRAM
      GENERIC MAP (
		DADDR_LEN	=> DEEP_LEN,
         	DATA_LEN	=> DATA_LEN
      )
      PORT MAP (
		ram_data_out	=>	saddr_in,
		ram_data_in		=>	saddr_out,
		ram_addr_in		=>	addr_out,
		nwe			=>	npush,
		nreset		=>	nreset_in,
		clk			=> 	clk_in
      );

	npush	<=	not ipush_out;
   
END stack_t_struct;
