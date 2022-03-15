--**********************************************************************************************
--  General purpose register file for the AVR Core
--  Version 1.4 (Special version for the JTAG OCD)
--  Modified 22.04.2004
--  Designed by Ruslan Lepetenok
--**********************************************************************************************
	
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

use WORK.SynthCtrlPack.all; -- Synthesis control

entity reg_file_cm4 is port (
		cp2_cml_1 : in std_logic;
		cp2_cml_2 : in std_logic;
		cp2_cml_3 : in std_logic;
		
						  --Clock and reset
					      cp2         : in  std_logic;
						  cp2en       : in  std_logic;
                          ireset      : in  std_logic;
	
                          reg_rd_in   : in  std_logic_vector(7 downto 0);
                          reg_rd_out  : out std_logic_vector(7 downto 0);
                          reg_rd_out_int  : out std_logic_vector(7 downto 0);
                          reg_rd_adr  : in  std_logic_vector(4 downto 0);
                          reg_rd_adr_int      : in std_logic_vector  (4 downto 0);
                          reg_rr_out  : out std_logic_vector(7 downto 0);
                          reg_rr_adr  : in  std_logic_vector(4 downto 0);
                          reg_rd_wr   : in  std_logic;

                          post_inc    : in  std_logic; -- POST INCREMENT FOR LD/ST INSTRUCTIONS
                          pre_dec     : in  std_logic; -- PRE DECREMENT FOR LD/ST INSTRUCTIONS
                          reg_h_wr    : in  std_logic;
                          reg_h_out   : out std_logic_vector(15 downto 0);
                          reg_h_adr   : in  std_logic_vector(2 downto 0);  -- x,y,z
   		                  reg_z_out   : out std_logic_vector(15 downto 0) -- OUTPUT OF R31:R30 FOR LPM/ELPM/IJMP INSTRUCTIONS
                          );
end reg_file_cm4;

architecture RTL of reg_file_cm4 is

type register_file_type is array(0 to 25) of std_logic_vector(7 downto 0);
type register_mux_type is array(0 to 31) of std_logic_vector(7 downto 0);
signal register_file : register_file_type;
signal r26h : std_logic_vector(7 downto 0);
signal r27h : std_logic_vector(7 downto 0);
signal r28h : std_logic_vector(7 downto 0);
signal r29h : std_logic_vector(7 downto 0);
signal r30h : std_logic_vector(7 downto 0);
signal r31h : std_logic_vector(7 downto 0);

signal register_wr_en  : std_logic_vector(31 downto 0);

signal sg_rd_decode   : std_logic_vector (31 downto 0);
signal sg_rd_decode_int   : std_logic_vector (31 downto 0);
signal sg_rr_decode   : std_logic_vector (31 downto 0);

--signal sg_tmp_rd_data : register_mux_type;
signal sg_tmp_rd_data_0 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_1 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_2 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_3 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_4 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_5 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_6 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_7 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_8 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_9 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_10 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_11 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_12 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_13 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_14 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_15 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_16 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_17 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_18 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_19 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_20 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_21 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_22 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_23 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_24 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_25 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_26 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_27 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_28 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_29 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_30 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_31 : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_0_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_1_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_2_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_3_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_4_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_5_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_6_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_7_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_8_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_9_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_10_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_11_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_12_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_13_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_14_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_15_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_16_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_17_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_18_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_19_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_20_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_21_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_22_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_23_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_24_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_25_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_26_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_27_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_28_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_29_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_30_int : std_logic_vector(7 downto 0);
signal sg_tmp_rd_data_31_int : std_logic_vector(7 downto 0);
--signal sg_tmp_rr_data : register_mux_type;
signal sg_tmp_rr_data_0 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_1 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_2 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_3 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_4 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_5 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_6 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_7 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_8 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_9 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_10 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_11 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_12 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_13 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_14 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_15 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_16 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_17 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_18 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_19 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_20 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_21 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_22 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_23 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_24 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_25 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_26 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_27 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_28 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_29 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_30 : std_logic_vector(7 downto 0);
signal sg_tmp_rr_data_31 : std_logic_vector(7 downto 0);

signal sg_adr16_postinc : std_logic_vector (15 downto 0); 
signal sg_adr16_predec  : std_logic_vector (15 downto 0); 
signal reg_h_in         : std_logic_vector  (15 downto 0); 

signal sg_tmp_h_data    : std_logic_vector  (15 downto 0); 

signal reg_rd_in_cml_3 :  std_logic_vector ( 7 downto 0 );
signal reg_rd_adr_cml_3 :  std_logic_vector ( 4 downto 0 );
signal reg_rd_adr_cml_2 :  std_logic_vector ( 4 downto 0 );
signal reg_rd_wr_cml_3 :  std_logic;
signal reg_h_adr_cml_3 :  std_logic_vector ( 2 downto 0 );
signal reg_h_adr_cml_2 :  std_logic_vector ( 2 downto 0 );
signal register_file_cml_3 :  register_file_type;
signal register_file_cml_2 :  register_file_type;
signal register_file_cml_1 :  register_file_type;
signal r26h_cml_3 :  std_logic_vector ( 7 downto 0 );
signal r26h_cml_2 :  std_logic_vector ( 7 downto 0 );
signal r26h_cml_1 :  std_logic_vector ( 7 downto 0 );
signal r27h_cml_3 :  std_logic_vector ( 7 downto 0 );
signal r27h_cml_2 :  std_logic_vector ( 7 downto 0 );
signal r27h_cml_1 :  std_logic_vector ( 7 downto 0 );
signal r28h_cml_3 :  std_logic_vector ( 7 downto 0 );
signal r28h_cml_2 :  std_logic_vector ( 7 downto 0 );
signal r28h_cml_1 :  std_logic_vector ( 7 downto 0 );
signal r29h_cml_3 :  std_logic_vector ( 7 downto 0 );
signal r29h_cml_2 :  std_logic_vector ( 7 downto 0 );
signal r29h_cml_1 :  std_logic_vector ( 7 downto 0 );
signal reg_z_out_cml_out :  std_logic_vector ( 15 downto 0 );
signal r30h_cml_3 :  std_logic_vector ( 7 downto 0 );
signal r30h_cml_2 :  std_logic_vector ( 7 downto 0 );
signal r30h_cml_1 :  std_logic_vector ( 7 downto 0 );
signal r31h_cml_3 :  std_logic_vector ( 7 downto 0 );
signal r31h_cml_2 :  std_logic_vector ( 7 downto 0 );
signal r31h_cml_1 :  std_logic_vector ( 7 downto 0 );
signal sg_adr16_predec_cml_3 :  std_logic_vector ( 15 downto 0 );
signal sg_adr16_predec_cml_2 :  std_logic_vector ( 15 downto 0 );
signal sg_tmp_h_data_cml_3 :  std_logic_vector ( 15 downto 0 );
signal sg_tmp_h_data_cml_2 :  std_logic_vector ( 15 downto 0 );

begin



process(cp2_cml_1) begin
if (cp2_cml_1 = '1' and cp2_cml_1'event) then
	register_file_cml_1 <= register_file;
	r26h_cml_1 <= r26h;
	r27h_cml_1 <= r27h;
	r28h_cml_1 <= r28h;
	r29h_cml_1 <= r29h;
	r30h_cml_1 <= r30h;
	r31h_cml_1 <= r31h;
end if;
end process;

process(cp2_cml_2) begin
if (cp2_cml_2 = '1' and cp2_cml_2'event) then
	reg_rd_adr_cml_2 <= reg_rd_adr;
	reg_h_adr_cml_2 <= reg_h_adr;
	register_file_cml_2 <= register_file_cml_1;
	r26h_cml_2 <= r26h_cml_1;
	r27h_cml_2 <= r27h_cml_1;
	r28h_cml_2 <= r28h_cml_1;
	r29h_cml_2 <= r29h_cml_1;
	r30h_cml_2 <= r30h_cml_1;
	r31h_cml_2 <= r31h_cml_1;
	sg_adr16_predec_cml_2 <= sg_adr16_predec;
	sg_tmp_h_data_cml_2 <= sg_tmp_h_data;
end if;
end process;

process(cp2_cml_3) begin
if (cp2_cml_3 = '1' and cp2_cml_3'event) then
	reg_rd_in_cml_3 <= reg_rd_in;
	reg_rd_adr_cml_3 <= reg_rd_adr_cml_2;
	reg_rd_wr_cml_3 <= reg_rd_wr;
	reg_h_adr_cml_3 <= reg_h_adr_cml_2;
	register_file_cml_3 <= register_file_cml_2;
	r26h_cml_3 <= r26h_cml_2;
	r27h_cml_3 <= r27h_cml_2;
	r28h_cml_3 <= r28h_cml_2;
	r29h_cml_3 <= r29h_cml_2;
	r30h_cml_3 <= r30h_cml_2;
	r31h_cml_3 <= r31h_cml_2;
	sg_adr16_predec_cml_3 <= sg_adr16_predec_cml_2;
	sg_tmp_h_data_cml_3 <= sg_tmp_h_data_cml_2;
end if;
end process;
reg_z_out <= reg_z_out_cml_out;


write_decode: for i in 0 to 31 generate
-- SynEDA CoreMultiplier
-- assignment(s): register_wr_en
-- replace(s): reg_rd_adr, reg_rd_wr

register_wr_en(i) <= '1' when (i=reg_rd_adr_cml_3 and reg_rd_wr_cml_3='1') else '0';
end generate;

rd_mux_decode: for i in 0 to 31 generate
sg_rd_decode(i) <= '1' when (reg_rd_adr=i) else '0';
end generate;

rd_mux_decode_int: for i in 0 to 31 generate
sg_rd_decode_int(i) <= '1' when (reg_rd_adr_int=i) else '0';
end generate;

rr_mux_decode: for i in 0 to 31 generate
sg_rr_decode(i) <= '1' when (reg_rr_adr=i) else '0';
end generate;

-- SynEDA CoreMultiplier
-- assignment(s): reg_z_out
-- replace(s): r30h, r31h

reg_z_out_cml_out <= r31h_cml_1&r30h_cml_1; -- R31:R30 OUTPUT FOR LPM/ELPM INSTRUCTIONS 

--sg_tmp_rd_data(0) <= register_file(0) when sg_rd_decode(0)='1' else (others=>'0');
--read_rd_mux: for i in 1 to 25 generate
--sg_tmp_rd_data(i) <= register_file(i) when sg_rd_decode(i)='1' else sg_tmp_rd_data(i-1);
--end generate;
--sg_tmp_rd_data(26) <= r26h when sg_rd_decode(26)='1' else sg_tmp_rd_data(25);
--sg_tmp_rd_data(27) <= r27h when sg_rd_decode(27)='1' else sg_tmp_rd_data(26);
--sg_tmp_rd_data(28) <= r28h when sg_rd_decode(28)='1' else sg_tmp_rd_data(27);
--sg_tmp_rd_data(29) <= r29h when sg_rd_decode(29)='1' else sg_tmp_rd_data(28);
--sg_tmp_rd_data(30) <= r30h when sg_rd_decode(30)='1' else sg_tmp_rd_data(29);
--sg_tmp_rd_data(31) <= r31h when sg_rd_decode(31)='1' else sg_tmp_rd_data(30);	
--reg_rd_out <= sg_tmp_rd_data(31); 

-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_0
-- replace(s): register_file

sg_tmp_rd_data_0 <= register_file_cml_1(0) when sg_rd_decode(0)='1' else (others=>'0');
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_1
-- replace(s): register_file

sg_tmp_rd_data_1 <= register_file_cml_1(1) when sg_rd_decode(1)='1' else sg_tmp_rd_data_0;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_2
-- replace(s): register_file

sg_tmp_rd_data_2 <= register_file_cml_1(2) when sg_rd_decode(2)='1' else sg_tmp_rd_data_1;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_3
-- replace(s): register_file

sg_tmp_rd_data_3 <= register_file_cml_1(3) when sg_rd_decode(3)='1' else sg_tmp_rd_data_2;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_4
-- replace(s): register_file

sg_tmp_rd_data_4 <= register_file_cml_1(4) when sg_rd_decode(4)='1' else sg_tmp_rd_data_3;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_5
-- replace(s): register_file

sg_tmp_rd_data_5 <= register_file_cml_1(5) when sg_rd_decode(5)='1' else sg_tmp_rd_data_4;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_6
-- replace(s): register_file

sg_tmp_rd_data_6 <= register_file_cml_1(6) when sg_rd_decode(6)='1' else sg_tmp_rd_data_5;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_7
-- replace(s): register_file

sg_tmp_rd_data_7 <= register_file_cml_1(7) when sg_rd_decode(7)='1' else sg_tmp_rd_data_6;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_8
-- replace(s): register_file

sg_tmp_rd_data_8 <= register_file_cml_1(8) when sg_rd_decode(8)='1' else sg_tmp_rd_data_7;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_9
-- replace(s): register_file

sg_tmp_rd_data_9 <= register_file_cml_1(9) when sg_rd_decode(9)='1' else sg_tmp_rd_data_8;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_10
-- replace(s): register_file

sg_tmp_rd_data_10 <= register_file_cml_1(10) when sg_rd_decode(10)='1' else sg_tmp_rd_data_9;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_11
-- replace(s): register_file

sg_tmp_rd_data_11 <= register_file_cml_1(11) when sg_rd_decode(11)='1' else sg_tmp_rd_data_10;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_12
-- replace(s): register_file

sg_tmp_rd_data_12 <= register_file_cml_1(12) when sg_rd_decode(12)='1' else sg_tmp_rd_data_11;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_13
-- replace(s): register_file

sg_tmp_rd_data_13 <= register_file_cml_1(13) when sg_rd_decode(13)='1' else sg_tmp_rd_data_12;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_14
-- replace(s): register_file

sg_tmp_rd_data_14 <= register_file_cml_1(14) when sg_rd_decode(14)='1' else sg_tmp_rd_data_13;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_15
-- replace(s): register_file

sg_tmp_rd_data_15 <= register_file_cml_1(15) when sg_rd_decode(15)='1' else sg_tmp_rd_data_14;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_16
-- replace(s): register_file

sg_tmp_rd_data_16 <= register_file_cml_1(16) when sg_rd_decode(16)='1' else sg_tmp_rd_data_15;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_17
-- replace(s): register_file

sg_tmp_rd_data_17 <= register_file_cml_1(17) when sg_rd_decode(17)='1' else sg_tmp_rd_data_16;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_18
-- replace(s): register_file

sg_tmp_rd_data_18 <= register_file_cml_1(18) when sg_rd_decode(18)='1' else sg_tmp_rd_data_17;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_19
-- replace(s): register_file

sg_tmp_rd_data_19 <= register_file_cml_1(19) when sg_rd_decode(19)='1' else sg_tmp_rd_data_18;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_20
-- replace(s): register_file

sg_tmp_rd_data_20 <= register_file_cml_1(20) when sg_rd_decode(20)='1' else sg_tmp_rd_data_19;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_21
-- replace(s): register_file

sg_tmp_rd_data_21 <= register_file_cml_1(21) when sg_rd_decode(21)='1' else sg_tmp_rd_data_20;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_22
-- replace(s): register_file

sg_tmp_rd_data_22 <= register_file_cml_1(22) when sg_rd_decode(22)='1' else sg_tmp_rd_data_21;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_23
-- replace(s): register_file

sg_tmp_rd_data_23 <= register_file_cml_1(23) when sg_rd_decode(23)='1' else sg_tmp_rd_data_22;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_24
-- replace(s): register_file

sg_tmp_rd_data_24 <= register_file_cml_1(24) when sg_rd_decode(24)='1' else sg_tmp_rd_data_23;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_25
-- replace(s): register_file

sg_tmp_rd_data_25 <= register_file_cml_1(25) when sg_rd_decode(25)='1' else sg_tmp_rd_data_24;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_26
-- replace(s): r26h

sg_tmp_rd_data_26 <= r26h_cml_1 when sg_rd_decode(26)='1' else sg_tmp_rd_data_25;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_27
-- replace(s): r27h

sg_tmp_rd_data_27 <= r27h_cml_1 when sg_rd_decode(27)='1' else sg_tmp_rd_data_26;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_28
-- replace(s): r28h

sg_tmp_rd_data_28 <= r28h_cml_1 when sg_rd_decode(28)='1' else sg_tmp_rd_data_27;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_29
-- replace(s): r29h

sg_tmp_rd_data_29 <= r29h_cml_1 when sg_rd_decode(29)='1' else sg_tmp_rd_data_28;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_30
-- replace(s): r30h

sg_tmp_rd_data_30 <= r30h_cml_1 when sg_rd_decode(30)='1' else sg_tmp_rd_data_29;
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_rd_data_31
-- replace(s): r31h

sg_tmp_rd_data_31 <= r31h_cml_1 when sg_rd_decode(31)='1' else sg_tmp_rd_data_30;	
reg_rd_out <= sg_tmp_rd_data_31; 

sg_tmp_rd_data_0_int <= register_file(0) when sg_rd_decode_int(0)='1' else (others=>'0');
sg_tmp_rd_data_1_int <= register_file(1) when sg_rd_decode_int(1)='1' else sg_tmp_rd_data_0_int;
sg_tmp_rd_data_2_int <= register_file(2) when sg_rd_decode_int(2)='1' else sg_tmp_rd_data_1_int;
sg_tmp_rd_data_3_int <= register_file(3) when sg_rd_decode_int(3)='1' else sg_tmp_rd_data_2_int;
sg_tmp_rd_data_4_int <= register_file(4) when sg_rd_decode_int(4)='1' else sg_tmp_rd_data_3_int;
sg_tmp_rd_data_5_int <= register_file(5) when sg_rd_decode_int(5)='1' else sg_tmp_rd_data_4_int;
sg_tmp_rd_data_6_int <= register_file(6) when sg_rd_decode_int(6)='1' else sg_tmp_rd_data_5_int;
sg_tmp_rd_data_7_int <= register_file(7) when sg_rd_decode_int(7)='1' else sg_tmp_rd_data_6_int;
sg_tmp_rd_data_8_int <= register_file(8) when sg_rd_decode_int(8)='1' else sg_tmp_rd_data_7_int;
sg_tmp_rd_data_9_int <= register_file(9) when sg_rd_decode_int(9)='1' else sg_tmp_rd_data_8_int;
sg_tmp_rd_data_10_int <= register_file(10) when sg_rd_decode_int(10)='1' else sg_tmp_rd_data_9_int;
sg_tmp_rd_data_11_int <= register_file(11) when sg_rd_decode_int(11)='1' else sg_tmp_rd_data_10_int;
sg_tmp_rd_data_12_int <= register_file(12) when sg_rd_decode_int(12)='1' else sg_tmp_rd_data_11_int;
sg_tmp_rd_data_13_int <= register_file(13) when sg_rd_decode_int(13)='1' else sg_tmp_rd_data_12_int;
sg_tmp_rd_data_14_int <= register_file(14) when sg_rd_decode_int(14)='1' else sg_tmp_rd_data_13_int;
sg_tmp_rd_data_15_int <= register_file(15) when sg_rd_decode_int(15)='1' else sg_tmp_rd_data_14_int;
sg_tmp_rd_data_16_int <= register_file(16) when sg_rd_decode_int(16)='1' else sg_tmp_rd_data_15_int;
sg_tmp_rd_data_17_int <= register_file(17) when sg_rd_decode_int(17)='1' else sg_tmp_rd_data_16_int;
sg_tmp_rd_data_18_int <= register_file(18) when sg_rd_decode_int(18)='1' else sg_tmp_rd_data_17_int;
sg_tmp_rd_data_19_int <= register_file(19) when sg_rd_decode_int(19)='1' else sg_tmp_rd_data_18_int;
sg_tmp_rd_data_20_int <= register_file(20) when sg_rd_decode_int(20)='1' else sg_tmp_rd_data_19_int;
sg_tmp_rd_data_21_int <= register_file(21) when sg_rd_decode_int(21)='1' else sg_tmp_rd_data_20_int;
sg_tmp_rd_data_22_int <= register_file(22) when sg_rd_decode_int(22)='1' else sg_tmp_rd_data_21_int;
sg_tmp_rd_data_23_int <= register_file(23) when sg_rd_decode_int(23)='1' else sg_tmp_rd_data_22_int;
sg_tmp_rd_data_24_int <= register_file(24) when sg_rd_decode_int(24)='1' else sg_tmp_rd_data_23_int;
sg_tmp_rd_data_25_int <= register_file(25) when sg_rd_decode_int(25)='1' else sg_tmp_rd_data_24_int;
sg_tmp_rd_data_26_int <= r26h when sg_rd_decode_int(26)='1' else sg_tmp_rd_data_25_int;
sg_tmp_rd_data_27_int <= r27h when sg_rd_decode_int(27)='1' else sg_tmp_rd_data_26_int;
sg_tmp_rd_data_28_int <= r28h when sg_rd_decode_int(28)='1' else sg_tmp_rd_data_27_int;
sg_tmp_rd_data_29_int <= r29h when sg_rd_decode_int(29)='1' else sg_tmp_rd_data_28_int;
sg_tmp_rd_data_30_int <= r30h when sg_rd_decode_int(30)='1' else sg_tmp_rd_data_29_int;
sg_tmp_rd_data_31_int <= r31h when sg_rd_decode_int(31)='1' else sg_tmp_rd_data_30_int;	
reg_rd_out_int <= sg_tmp_rd_data_31_int; 

--sg_tmp_rr_data(0) <= register_file(0) when sg_rr_decode(0)='1' else (others=>'0');
--read_rr_mux: for i in 1 to 25 generate
--sg_tmp_rr_data(i) <= register_file(i) when sg_rr_decode(i)='1' else sg_tmp_rr_data(i-1);
--end generate;
--sg_tmp_rr_data() <= register_file() when sg_rr_decode()='1' else sg_tmp_rr_data();
--sg_tmp_rr_data(26) <= r26h when sg_rr_decode(26)='1' else sg_tmp_rr_data(25);
--sg_tmp_rr_data(27) <= r27h when sg_rr_decode(27)='1' else sg_tmp_rr_data(26);
--sg_tmp_rr_data(28) <= r28h when sg_rr_decode(28)='1' else sg_tmp_rr_data(27);
--sg_tmp_rr_data(29) <= r29h when sg_rr_decode(29)='1' else sg_tmp_rr_data(28);
--sg_tmp_rr_data(30) <= r30h when sg_rr_decode(30)='1' else sg_tmp_rr_data(29);
--sg_tmp_rr_data(31) <= r31h when sg_rr_decode(31)='1' else sg_tmp_rr_data(30);
--reg_rr_out <= sg_tmp_rr_data(31);


sg_tmp_rr_data_0 <= register_file(0) when sg_rr_decode(0)='1' else (others=>'0');
sg_tmp_rr_data_1 <= register_file(1) when sg_rr_decode(1)='1' else sg_tmp_rr_data_0;
sg_tmp_rr_data_2 <= register_file(2) when sg_rr_decode(2)='1' else sg_tmp_rr_data_1;
sg_tmp_rr_data_3 <= register_file(3) when sg_rr_decode(3)='1' else sg_tmp_rr_data_2;
sg_tmp_rr_data_4 <= register_file(4) when sg_rr_decode(4)='1' else sg_tmp_rr_data_3;
sg_tmp_rr_data_5 <= register_file(5) when sg_rr_decode(5)='1' else sg_tmp_rr_data_4;
sg_tmp_rr_data_6 <= register_file(6) when sg_rr_decode(6)='1' else sg_tmp_rr_data_5;
sg_tmp_rr_data_7 <= register_file(7) when sg_rr_decode(7)='1' else sg_tmp_rr_data_6;
sg_tmp_rr_data_8 <= register_file(8) when sg_rr_decode(8)='1' else sg_tmp_rr_data_7;
sg_tmp_rr_data_9 <= register_file(9) when sg_rr_decode(9)='1' else sg_tmp_rr_data_8;
sg_tmp_rr_data_10 <= register_file(10) when sg_rr_decode(10)='1' else sg_tmp_rr_data_9;
sg_tmp_rr_data_11 <= register_file(11) when sg_rr_decode(11)='1' else sg_tmp_rr_data_10;
sg_tmp_rr_data_12 <= register_file(12) when sg_rr_decode(12)='1' else sg_tmp_rr_data_11;
sg_tmp_rr_data_13 <= register_file(13) when sg_rr_decode(13)='1' else sg_tmp_rr_data_12;
sg_tmp_rr_data_14 <= register_file(14) when sg_rr_decode(14)='1' else sg_tmp_rr_data_13;
sg_tmp_rr_data_15 <= register_file(15) when sg_rr_decode(15)='1' else sg_tmp_rr_data_14;
sg_tmp_rr_data_16 <= register_file(16) when sg_rr_decode(16)='1' else sg_tmp_rr_data_15;
sg_tmp_rr_data_17 <= register_file(17) when sg_rr_decode(17)='1' else sg_tmp_rr_data_16;
sg_tmp_rr_data_18 <= register_file(18) when sg_rr_decode(18)='1' else sg_tmp_rr_data_17;
sg_tmp_rr_data_19 <= register_file(19) when sg_rr_decode(19)='1' else sg_tmp_rr_data_18;
sg_tmp_rr_data_20 <= register_file(20) when sg_rr_decode(20)='1' else sg_tmp_rr_data_19;
sg_tmp_rr_data_21 <= register_file(21) when sg_rr_decode(21)='1' else sg_tmp_rr_data_20;
sg_tmp_rr_data_22 <= register_file(22) when sg_rr_decode(22)='1' else sg_tmp_rr_data_21;
sg_tmp_rr_data_23 <= register_file(23) when sg_rr_decode(23)='1' else sg_tmp_rr_data_22;
sg_tmp_rr_data_24 <= register_file(24) when sg_rr_decode(24)='1' else sg_tmp_rr_data_23;
sg_tmp_rr_data_25 <= register_file(25) when sg_rr_decode(25)='1' else sg_tmp_rr_data_24;
sg_tmp_rr_data_26 <= r26h when sg_rr_decode(26)='1' else sg_tmp_rr_data_25;
sg_tmp_rr_data_27 <= r27h when sg_rr_decode(27)='1' else sg_tmp_rr_data_26;
sg_tmp_rr_data_28 <= r28h when sg_rr_decode(28)='1' else sg_tmp_rr_data_27;
sg_tmp_rr_data_29 <= r29h when sg_rr_decode(29)='1' else sg_tmp_rr_data_28;
sg_tmp_rr_data_30 <= r30h when sg_rr_decode(30)='1' else sg_tmp_rr_data_29;
sg_tmp_rr_data_31 <= r31h when sg_rr_decode(31)='1' else sg_tmp_rr_data_30;
reg_rr_out <= sg_tmp_rr_data_31;


h_dat_mux_l:for i in 0 to 7 generate
sg_tmp_h_data(i) <= (r26h_cml_1(i) and reg_h_adr(0)) or (r28h_cml_1(i) and reg_h_adr(1)) or (r30h_cml_1(i) and reg_h_adr(2));
end generate;
h_dat_mux_h:for i in 8 to 15 generate
-- SynEDA CoreMultiplier
-- assignment(s): sg_tmp_h_data
-- replace(s): r26h, r27h, r28h, r29h, r30h, r31h

sg_tmp_h_data(i) <= (r27h_cml_1(i-8) and reg_h_adr(0)) or (r29h_cml_1(i-8) and reg_h_adr(1)) or (r31h_cml_1(i-8) and reg_h_adr(2));
end generate;


-- SynEDA CoreMultiplier
-- assignment(s): sg_adr16_postinc
-- replace(s): sg_tmp_h_data

sg_adr16_postinc <= sg_tmp_h_data_cml_3 +1;
sg_adr16_predec  <= sg_tmp_h_data -1;
-- OUTPUT TO THE ADDRESS BUS
reg_h_out <= sg_adr16_predec when (pre_dec='1') else           -- PREDECREMENT
             sg_tmp_h_data;            -- NO PREDECREMENT

-- SynEDA CoreMultiplier
-- assignment(s): reg_h_in
-- replace(s): sg_adr16_predec

-- TO REGISTERS
reg_h_in  <= sg_adr16_postinc when (post_inc='1') else         -- POST INC 
             sg_adr16_predec_cml_3;                                  -- PRE DEC

-- Register file with global reset (for simulation)

RegFileWithRst:if CResetRegFile generate

-- SynEDA CoreMultiplier
-- assignment(s): register_file
-- replace(s): reg_rd_in, register_file

R0_R25:process(cp2,ireset)
begin
 if ireset='0' then 
  for i in 0 to 25 loop
   register_file(i) <= (others =>'0');
  end loop;	
 elsif (cp2='1' and cp2'event) then register_file <= register_file_cml_3;
  if (cp2en='1') then 							  -- Clock enable	 
   for i in 0 to 25 loop   
    if register_wr_en(i)='1' then
     register_file(i) <= reg_rd_in_cml_3;
    end if;
   end loop;
  end if;
 end if; 
end process;


-- SynEDA CoreMultiplier
-- assignment(s): r26h
-- replace(s): reg_rd_in, reg_h_adr, r26h

-- R26 (LOW)
R26:process(cp2,ireset)
begin
 if ireset='0' then 
  r26h <= (others =>'0');
 elsif (cp2='1' and cp2'event) then r26h <= r26h_cml_3;
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(26)='1' then
    r26h <= reg_rd_in_cml_3;
   elsif (reg_h_adr_cml_3(0)='1'and reg_h_wr='1') then
    r26h <= reg_h_in(7 downto 0);             
   end if;
  end if; 
 end if;
end process;

-- SynEDA CoreMultiplier
-- assignment(s): r27h
-- replace(s): reg_rd_in, reg_h_adr, r27h

-- R27 (HIGH)
R27:process(cp2,ireset)
begin
 if ireset='0' then 
  r27h <= (others =>'0');
 elsif (cp2='1' and cp2'event) then r27h <= r27h_cml_3;
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(27)='1' then
    r27h <= reg_rd_in_cml_3;
   elsif (reg_h_adr_cml_3(0)='1'and reg_h_wr='1') then
    r27h <= reg_h_in(15 downto 8);             
   end if;
  end if; 
 end if;
end process;

-- SynEDA CoreMultiplier
-- assignment(s): r28h
-- replace(s): reg_rd_in, reg_h_adr, r28h

-- R28 (LOW)
R28:process(cp2,ireset)
begin
 if ireset='0' then 
  r28h <= (others =>'0');
 elsif (cp2='1' and cp2'event) then r28h <= r28h_cml_3;
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(28)='1' then
    r28h <= reg_rd_in_cml_3;
   elsif (reg_h_adr_cml_3(1)='1'and reg_h_wr='1') then
    r28h <= reg_h_in(7 downto 0);             
   end if;
  end if;
 end if;
end process;

-- SynEDA CoreMultiplier
-- assignment(s): r29h
-- replace(s): reg_rd_in, reg_h_adr, r29h

-- R29 (HIGH)
R29:process(cp2,ireset)
begin
 if ireset='0' then 
  r29h <= (others =>'0');
 elsif (cp2='1' and cp2'event) then r29h <= r29h_cml_3;
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(29)='1' then
    r29h <= reg_rd_in_cml_3;
   elsif (reg_h_adr_cml_3(1)='1'and reg_h_wr='1') then
    r29h <= reg_h_in(15 downto 8);             
   end if;
  end if; 
 end if;
end process;

-- SynEDA CoreMultiplier
-- assignment(s): r30h
-- replace(s): reg_rd_in, reg_h_adr, r30h

-- R30 (LOW)
R30:process(cp2,ireset)
begin
 if ireset='0' then 
  r30h <= (others =>'0');
 elsif (cp2='1' and cp2'event) then r30h <= r30h_cml_3;
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(30)='1' then
    r30h <= reg_rd_in_cml_3;
   elsif (reg_h_adr_cml_3(2)='1'and reg_h_wr='1') then
    r30h <= reg_h_in(7 downto 0);             
   end if;
  end if; 
 end if;
end process;

-- SynEDA CoreMultiplier
-- assignment(s): r31h
-- replace(s): reg_rd_in, reg_h_adr, r31h

-- R31 (HIGH)
R31:process(cp2,ireset)
begin
 if ireset='0' then 
  r31h <= (others =>'0');
 elsif (cp2='1' and cp2'event) then r31h <= r31h_cml_3;
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(31)='1' then
    r31h <= reg_rd_in_cml_3;
   elsif (reg_h_adr_cml_3(2)='1'and reg_h_wr='1') then
    r31h <= reg_h_in(15 downto 8);             
   end if;
  end if; 
 end if;
end process;

end generate;


-- Register file without global reset (for synthesis)

RegFileWithoutRst:if not CResetRegFile generate

R0_R25:process(cp2)
begin
 if (cp2='1' and cp2'event) then
  if (cp2en='1') then 							  -- Clock enable	 
   for i in 0 to 25 loop   
    if register_wr_en(i)='1' then
     register_file(i) <= reg_rd_in;
    end if;
   end loop;
  end if;
 end if; 
end process;


-- R26 (LOW)
R26:process(cp2)
begin
 if (cp2='1' and cp2'event) then
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(26)='1' then
    r26h <= reg_rd_in;
   elsif (reg_h_adr(0)='1'and reg_h_wr='1') then
    r26h <= reg_h_in(7 downto 0);             
   end if;
  end if; 
 end if;
end process;

-- R27 (HIGH)
R27:process(cp2)
begin
 if (cp2='1' and cp2'event) then
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(27)='1' then
    r27h <= reg_rd_in;
   elsif (reg_h_adr(0)='1'and reg_h_wr='1') then
    r27h <= reg_h_in(15 downto 8);             
   end if;
  end if; 
 end if;
end process;

-- R28 (LOW)
R28:process(cp2)
begin
 if (cp2='1' and cp2'event) then
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(28)='1' then
    r28h <= reg_rd_in;
   elsif (reg_h_adr(1)='1'and reg_h_wr='1') then
    r28h <= reg_h_in(7 downto 0);             
   end if;
  end if;  
 end if;
end process;

-- R29 (HIGH)
R29:process(cp2)
begin
 if (cp2='1' and cp2'event) then
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(29)='1' then
    r29h <= reg_rd_in;
   elsif (reg_h_adr(1)='1'and reg_h_wr='1') then
    r29h <= reg_h_in(15 downto 8);             
   end if;
  end if; 
 end if;
end process;

-- R30 (LOW)
R30:process(cp2)
begin
 if (cp2='1' and cp2'event) then
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(30)='1' then
    r30h <= reg_rd_in;
   elsif (reg_h_adr(2)='1'and reg_h_wr='1') then
    r30h <= reg_h_in(7 downto 0);             
   end if;
  end if; 
 end if;
end process;

-- R31 (HIGH)
R31:process(cp2)
begin
 if (cp2='1' and cp2'event) then
  if (cp2en='1') then 							  -- Clock enable	 
   if register_wr_en(31)='1' then
    r31h <= reg_rd_in;
   elsif (reg_h_adr(2)='1'and reg_h_wr='1') then
    r31h <= reg_h_in(15 downto 8);             
   end if;
  end if; 
 end if;
end process;

end generate;

end RTL;
