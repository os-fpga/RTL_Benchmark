----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:20:23 04/07/2010 
-- Design Name: 
-- Module Name:    Cpu - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity CpuX8 is
    Port ( MA : out  STD_LOGIC_VECTOR (11 downto 0);
			  MBout : out  STD_LOGIC_VECTOR (11 downto 0);
			  MBin : in  STD_LOGIC_VECTOR (11 downto 0);
			  Clk : in STD_LOGIC;
			  Rst : in STD_LOGIC;
			  Mrd : out STD_LOGIC;
			  Tty : out STD_LOGIC_VECTOR(7 downto 0);
			  Tempty : in STD_LOGIC;
			  TLoad : inout STD_LOGIC;
			  Rempty : in STD_LOGIC;
			  Rty : in STD_LOGIC_VECTOR(7 downto 0);
			  Rload :inout STD_LOGIC;
  			  DMA : out  STD_LOGIC_VECTOR (14 downto 0);
			  DMBout : out  STD_LOGIC_VECTOR (11 downto 0);
			  DMBin : in  STD_LOGIC_VECTOR (11 downto 0);
			  DMrd : out STD_LOGIC
);
end CpuX8;

architecture Behavioral of CpuX8 is
  signal acc: STD_LOGIC_VECTOR (12 downto 0);
  signal pc: STD_LOGIC_VECTOR (11 downto 0);
  type st_type is (S0 ,S1, S2, S3, S4, D0, D1, D2, D3, D4, D5);
  signal ir: STD_LOGIC_VECTOR (11 downto 0);
  signal ea: STD_LOGIC_VECTOR (11 downto 0);
  shared variable skp: STD_LOGIC;
  signal run: STD_LOGIC;
  signal st: st_type;
  signal inten: STD_LOGIC;
  signal irq: STD_LOGIC;
  signal TFlag: STD_LOGIC;
  signal RFlag: STD_LOGIC;
  signal Tnxt: STD_LOGIC;
  signal DmaRq: STD_LOGIC;
  signal Tmp: STD_LOGIC_VECTOR(11 downto 0);
  signal Dir: STD_LOGIC;
  signal DskAdd: STD_LOGIC_VECTOR(14 downto 0);
  signal DskFlg: STD_LOGIC;
  signal DskReg: STD_LOGIC_VECTOR(11 downto 0);

Procedure ProcAcc( Src : in STD_LOGIC_VECTOR (12 downto 0);
irx : in STD_LOGIC_VECTOR (11 downto 0);
signal s : out STD_LOGIC_VECTOR (12 downto 0);
variable skip : out STD_LOGIC;
signal prun : out STD_LOGIC ) is

variable atm : STD_LOGIC_VECTOR(12 DOWNTO 0);

begin
  atm:=Src;
  -- Group 2
  if (irx(8)='1') then
    skip:=irx(3);
    if (irx(6)='1' and atm(11)='1') then skip:=not irx(3); end if;              -- SMA/SPA
    if (irx(5)='1' and atm(11 downto 0)=O"0000") then skip:=not irx(3); end if; -- SNA/SZA
    if (irx(4)='1' and atm(12)='1') then skip:=not irx(3); end if;              -- SNL/SZL
    if (irx(7)='1') then atm(11 downto 0):= O"0000"; end if;              -- CLA
    if (irx(2)='1') then atm(11 downto 0):= O"7777"; end if;              -- OSR
	 if (irx(1)='1') then prun<='1'; end if;										  -- HLT
  else  
  -- Group 1
    skip:='0'; 
    if (irx(7)='1') then atm(11 downto 0):= O"0000"; end if;              -- CLA
    if (irx(6)='1') then atm(12):='0'; end if;                            -- CLL
    if (irx(5)='1') then atm(11 downto 0):=not atm(11 downto 0); end if;  -- CMA
    if (irx(4)='1') then atm(12):=not atm(12); end if;                    -- CML
    if (irx(0)='1') then atm:=atm+1; end if;                              -- IAC
    case irx(3 downto 1) is
     when "100" => atm:=atm(0) & atm(12 downto 1);                        -- RAR
     when "010" => atm:=atm(11 downto 0) & atm(12);                       -- RTR 
     when "101" => atm:=atm(1 downto 0) & atm(12 downto 2);               -- RAL
     when "011" => atm:=atm(10 downto 0) & atm(12 downto 11);             -- RTL
     when others => NULL;
    end case;
  end if;
 s<=atm;  
end procedure; 

begin
    process (Clk,Rst)
    begin
		
		if (Rst='0') then
		 pc <= O"0200";
		 acc <= b"0000000000000";
		 st <= S0;
		 run <= '1';
		 inten<='0';
		 irq<='0';
		 TLoad<='0';
		 TFlag<='0';
		 RFlag<='0';
		 Rload<='0';
		 Tnxt<='1';
		 DmaRq<='0';
		 Dir<='0';
		 DskAdd<=O"00000";
		 DMA<=O"00000";
		 DskFlg<='0';
		 DskReg<=O"0000";
    elsif (Clk'event and Clk='1') then

-- S0 Fetch
-- S1 Execute
-- S2 Mem write target(ea) of ISZ,DCA,JMS
-- S3 Defer (ea->MA)
-- S4 Mem writeback auto index reg values (0010-0017)
-- Min states S0->S1->(S0) eg CLA, max S0->S3->S4->S1->S2->(S0) eg DCA I 10
-- DMA implements 3 cycle databreak. Actualy requires 6 cycles (D0..D5).
-- DF32 attached to DMA system using 32K*12bits of FPGA RAM.

		case st is
		when S0=>
		  if (run='1') then st<=S1; end if;
		  if (irq='1') then
		   ir<=O"4000";
		   irq<='0';
		   ea<=O"0000";
		   pc<=pc-1;
		  else
		   ir<=MBin;
		   if (MBin(11 downto 9)<"110") then 
 		    if(MBin(7) = '0') then
			   -- page zero
			   ea <= "00000" &  MBin(6 downto 0);
		    else
			   ea <= pc(11 downto 7) & MBin(6 downto 0);
		    end if;
		   end if;
			
		  -- Test for Defer if MRI ie when (IR(11..9)<6)
		  
		   if (MBin(11 downto 9)<"110" and MBin(8)='1' and run='1') then st<=S3; end if;
		
			-- General rubbish to sort out the UART flags.
		
			 if (Tempty='0') then
		      TLoad<='0';
		   end if;
		   Tnxt<=Tempty;
		   if (Tnxt='0' and Tempty='1') then TFlag<='1'; end if;
		     
		   if (Rempty='0') then
			    Rload<='1';
			 else
			    if (Rload='1') then RFlag<='1'; end if;
			    Rload<='0';
			 end if;
			 
			 
		  end if;

		  
		when S1 =>
		  pc<=pc+1;	  
		  case ir(11 downto 9) is
		    when "000" =>														-- AND
		      acc(11 downto 0)<=acc(11 downto 0) and MBin;
		      if (DmaRq='1') then st<=D0; else st<=S0; end if;
		    when "001" =>														-- TAD
		      acc<=acc+MBin;
		      if (DmaRq='1') then st<=D0; else st<=S0; end if;
		    when "010" =>														-- ISZ
		      MBout<=MBin+1;
		      if (MBin=O"7777") then
		        pc<=pc+2;
		      end if;
		      st<=S2;
		    when "011" =>														-- DCA
		      MBout<=acc(11 downto 0);
		      acc(11 downto 0)<=O"0000";
		      st<=S2;
		    when "100" =>														-- JMS
		      pc<=ea+1;
		      MBout<=pc+1;
		      st<=S2;
		    when "101" => 													-- JMP
		      pc<=ea;
		      if (DmaRq='1') then st<=D0; else st<=S0; end if;
		    when "110" =>														-- IOT
		      if (DmaRq='1') then st<=D0; else st<=S0; end if;
		      case ir is
				-- TTY
		        when O"6041" =>
		          if TFlag='1' then pc<=pc+2; end if;
		        when O"6042" =>
		          TFlag<='0';
		        when O"6044" =>
		          Tty<='0' & acc(6 downto 0);
		          TLoad<='1';
		        when O"6046" =>
		          Tty<='0' & acc(6 downto 0);
		          TLoad<='1';
		          TFlag<='0';
		        when O"6031" =>
		         if (RFlag='1') then pc<=pc+2; end if;
		        when O"6032" =>
		         RFlag<='0';
		        when O"6034" =>
		         acc(7 downto 0)<=acc(7 downto 0) or ('1' & Rty(6 downto 0));
		        when O"6036" =>
		         acc(7 downto 0)<=acc(7 downto 0) or ('1' & Rty(6 downto 0));
		         RFlag<='0';
		        -- Irq        
		        when O"6001" =>
		          inten<='1';
		        when O"6002" =>
		          inten<='0';
		        -- DF32
		        when O"6603" =>
		          Dir<='1';
		          DmaRq<='1';
		          DskAdd<=DskReg(8 downto 6) & acc(11 downto 0);
		          DskFlg<='0';
		          st<=D0;
		          acc(11 downto 0)<=O"0000";
		        when O"6605" =>
		          Dir<='0';
		          DmaRq<='1';
		          DskAdd<=DskReg(8 downto 6) & acc(11 downto 0);
		          DskFlg<='0';
		          st<=D0;
		          acc(11 downto 0)<=O"0000";
		        when O"6601" =>
		          DskAdd<=O"00000";
		          DskFlg<='0';
		        when O"6611" =>
		          DskReg<=O"0000";
		        when O"6615" =>
		          DskReg<=acc(11 downto 0);
		        when O"6616" =>
		          acc(11 downto 0)<=acc(11 downto 0) or DskReg;
		        when O"6626" =>
		          acc(11 downto 0)<=acc(11 downto 0) or DskReg(11 downto 0);
		        when O"6622" =>
		          if (DskFlg='1') then pc<=pc+2; end if;
		        when O"6621" =>
		          pc<=pc+2;
              when others => NULL;
		      end case;
		    when "111" =>															-- OPR
		      ProcAcc(acc,ir,acc,skp,run);
		      if (skp='1') then pc<=pc+2; end if;
		      if (DmaRq='1') then st<=D0; else st<=S0; end if;
		    WHEN OTHERS => NULL;
		    end case;
		    
		    -- This bit manages the irq delay of 1 instruction
		    
		    if (inten='1' and (TFlag='1' OR RFlag='1') and ir/=O"6002") then
		      irq<='1';
		      inten<='0';
		    end if;
		    
			-- S2 write Mem if required ... see combinatorial 
		    
		 when S2 =>
		   if (DmaRq='1') then st<=D0; else st<=S0; end if;
			
		 when S3 =>
			MBout<=MBin+1;
			if ((ea and O"7770")=O"0010") then 
           st<=S4;
			else
		     ea<=MBin;
		     st<=S1;
		   end if;
		  
		 when S4 =>
			ea<=MBin;
			st<=S1;

		 when D0 =>
			MBout<=MBin+1;
			St<=D1;
			DMA<=DskAdd;
			DskAdd<=DskAdd+1;
			
		 when D1 =>
		  if (MBin=O"0000") then
		   DmaRq<='0'; 
		   DskFlg<='1';
		  end if;
			St<=D2;
			
		 when D2 =>
			MBout<=MBin+1;
			Tmp<=MBin+1;
			St<=D3;
			
		 when D3 =>
			St<=D4;
			
		 when D4 =>
			St<=D5;
		  if (Dir='1') then
		    MBout<=DMBin;
		  else
		    DMBout<=MBin;
		  end if;
		  
		 when D5 =>
			St<=S0;
			
		end case;

	end if;
		
  end process;
   
 -- Combinatorial set MA,Mrd=(w/!r)

	MA <= pc when (St=S0) else  
		   O"7750" when (st=D0 or st=D1) else 
		   O"7751" when (st=D2 or st=D3) else
		   Tmp when (st=D4 or st=D5)
		  else ea;	
	Mrd <= '1' when (st=S2 or st=S4 or st=D1 or st=D3 or (st=D5 and Dir='1')) else '0';
	DMrd <= '1' when (st=D5 and Dir='0') else '0';
	
end Behavioral;

