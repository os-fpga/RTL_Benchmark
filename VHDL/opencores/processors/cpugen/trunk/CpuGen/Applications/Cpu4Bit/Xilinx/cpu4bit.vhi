-- Vhdl instantiation template created from schematic cpu4bit.sch - Wed Dec 10 23:36:04 2003
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module.
-- 2) To use this template to instantiate this component, cut-and-paste and then edit.
--

   COMPONENT cpu4bit
   PORT( CLK	:	IN	STD_LOGIC; 
          CPU_DATA_OUT	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          NRESET	:	IN	STD_LOGIC; 
          nWE_CPU	:	OUT	STD_LOGIC; 
          nRE_CPU	:	OUT	STD_LOGIC; 
          CTRL_DATA_IN	:	IN	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          CTRL_DATA_OUT	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          PWM_OUT	:	OUT	STD_LOGIC; 
          CPU_IADDR	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          CPU_DADDR	:	OUT	STD_LOGIC_VECTOR (5 DOWNTO 0));
   END COMPONENT;

   UUT: cpu4bit PORT MAP(
		CLK => , 
		CPU_DATA_OUT => , 
		NRESET => , 
		nWE_CPU => , 
		nRE_CPU => , 
		CTRL_DATA_IN => , 
		CTRL_DATA_OUT => , 
		PWM_OUT => , 
		CPU_IADDR => , 
		CPU_DADDR => 
   );
