
library ieee;
use ieee.std_logic_1164.all;


entity twofish_whit_keysched128 is
port	(
		in_key_twk128		: in std_logic_vector(127 downto 0);
		out_K0_twk128,
		out_K1_twk128,
		out_K2_twk128,
		out_K3_twk128,
		out_K4_twk128,
		out_K5_twk128,
		out_K6_twk128,
		out_K7_twk128			: out std_logic_vector(31 downto 0)
		);
end twofish_whit_keysched128;
				
architecture twofish_whit_keysched128_arch of twofish_whit_keysched128 is

	-- we declare internal signals
	signal	to_up_pht_1,
			to_shift_8_1,
			from_shift_8_1,
			to_shift_9_1,
			to_up_pht_2,
			to_shift_8_2,
			from_shift_8_2,
			to_shift_9_2,
			to_up_pht_3,
			to_shift_8_3,
			from_shift_8_3,
			to_shift_9_3,
			to_up_pht_4,
			to_shift_8_4,
			from_shift_8_4,
			to_shift_9_4,
			M0, M1, M2, M3	: std_logic_vector(31 downto 0);

	signal	byte0, byte1, byte2, byte3,
			byte4, byte5, byte6, byte7,
			byte8, byte9, byte10, byte11,
			byte12, byte13, byte14, byte15	: std_logic_vector(7 downto 0);

	signal		zero, one, two, three, four, five, six, seven	: std_logic_vector(7 downto 0);
																		   			
	-- we declare the components to be used
	component pht
	port	(
			up_in_pht,
			down_in_pht		: in std_logic_vector(31 downto 0);
			up_out_pht,
			down_out_pht	: out std_logic_vector(31 downto 0)
			);
	end component;

	component h_128 
	port	(
			in_h128			: in std_logic_vector(7 downto 0);
			Mfirst_h128,
			Msecond_h128	: in std_logic_vector(31 downto 0);
			out_h128		: out std_logic_vector(31 downto 0)
			);
	end component;

-- begin architecture description
begin

	-- we produce the first eight numbers
	zero <= "00000000";
	one <= "00000001";
	two <= "00000010";
	three <= "00000011";
	four <= "00000100";
	five <= "00000101";
	six <= "00000110";
	seven <= "00000111";

	-- we assign the input signal to the respective
	-- bytes as is described in the prototype
	byte15 <= in_key_twk128(7 downto 0);
	byte14 <= in_key_twk128(15 downto 8);
	byte13 <= in_key_twk128(23 downto 16);
	byte12 <= in_key_twk128(31 downto 24);
	byte11 <= in_key_twk128(39 downto 32);
	byte10 <= in_key_twk128(47 downto 40);
	byte9 <= in_key_twk128(55 downto 48);
	byte8 <= in_key_twk128(63 downto 56);
	byte7 <= in_key_twk128(71 downto 64);
	byte6 <= in_key_twk128(79 downto 72);
	byte5 <= in_key_twk128(87 downto 80);
	byte4 <= in_key_twk128(95 downto 88);
	byte3 <= in_key_twk128(103 downto 96);
	byte2 <= in_key_twk128(111 downto 104);
	byte1 <= in_key_twk128(119 downto 112);
	byte0 <= in_key_twk128(127 downto 120);

	-- we form the M{0..3}
	M0 <= byte3 & byte2 & byte1 & byte0;
	M1 <= byte7 & byte6 & byte5 & byte4;
	M2 <= byte11 & byte10 & byte9 & byte8;
	M3 <= byte15 & byte14 & byte13 & byte12;

	-- we produce the keys for the whitening steps
	-- keys K0,1
	-- upper h
	upper_h1: h_128
	port map	(
				in_h128 => zero,
				Mfirst_h128 => M2,
				Msecond_h128 => M0,
				out_h128 => to_up_pht_1
				);
				
	-- lower h
	lower_h1: h_128
	port map	(
				in_h128 => one,
				Mfirst_h128 => M3,
				Msecond_h128 => M1,
				out_h128 => to_shift_8_1
				);
				
	-- left rotate by 8
	from_shift_8_1(31 downto 8) <= to_shift_8_1(23 downto 0);
	from_shift_8_1(7 downto 0) <= to_shift_8_1(31 downto 24);
	
	-- pht transformation
	pht_transform1: pht
	port map	(
				up_in_pht => to_up_pht_1,
				down_in_pht => from_shift_8_1,
				up_out_pht => out_K0_twk128,
				down_out_pht => to_shift_9_1
				);
				
	-- left rotate by 9
	out_K1_twk128(31 downto 9) <= to_shift_9_1(22 downto 0);
	out_K1_twk128(8 downto 0) <= to_shift_9_1(31 downto 23);

	-- keys K2,3
	-- upper h
	upper_h2: h_128
	port map	(
				in_h128 => two,
				Mfirst_h128 => M2,
				Msecond_h128 => M0,
				out_h128 => to_up_pht_2
				);
				
	-- lower h
	lower_h2: h_128
	port map	(
				in_h128 => three,
				Mfirst_h128 => M3,
				Msecond_h128 => M1,
				out_h128 => to_shift_8_2
				);
				
	-- left rotate by 8
	from_shift_8_2(31 downto 8) <= to_shift_8_2(23 downto 0);
	from_shift_8_2(7 downto 0) <= to_shift_8_2(31 downto 24);
	
	-- pht transformation
	pht_transform2: pht
	port map	(
				up_in_pht => to_up_pht_2,
				down_in_pht => from_shift_8_2,
				up_out_pht => out_K2_twk128,
				down_out_pht => to_shift_9_2
				);
				
	-- left rotate by 9
	out_K3_twk128(31 downto 9) <= to_shift_9_2(22 downto 0);
	out_K3_twk128(8 downto 0) <= to_shift_9_2(31 downto 23);

	-- keys K4,5
	-- upper h
	upper_h3: h_128
	port map	(
				in_h128 => four,
				Mfirst_h128 => M2,
				Msecond_h128 => M0,
				out_h128 => to_up_pht_3
				);
				
	-- lower h
	lower_h3: h_128
	port map	(
				in_h128 => five,
				Mfirst_h128 => M3,
				Msecond_h128 => M1,
				out_h128 => to_shift_8_3
				);
				
	-- left rotate by 8
	from_shift_8_3(31 downto 8) <= to_shift_8_3(23 downto 0);
	from_shift_8_3(7 downto 0) <= to_shift_8_3(31 downto 24);
	
	-- pht transformation
	pht_transform3: pht
	port map	(
				up_in_pht => to_up_pht_3,
				down_in_pht => from_shift_8_3,
				up_out_pht => out_K4_twk128,
				down_out_pht => to_shift_9_3
				);
				
	-- left rotate by 9
	out_K5_twk128(31 downto 9) <= to_shift_9_3(22 downto 0);
	out_K5_twk128(8 downto 0) <= to_shift_9_3(31 downto 23);

	-- keys K6,7
	-- upper h
	upper_h4: h_128
	port map	(
				in_h128 => six,
				Mfirst_h128 => M2,
				Msecond_h128 => M0,
				out_h128 => to_up_pht_4
				);
				
	-- lower h
	lower_h4: h_128
	port map	(
				in_h128 => seven,
				Mfirst_h128 => M3,
				Msecond_h128 => M1,
				out_h128 => to_shift_8_4
				);
				
	-- left rotate by 8
	from_shift_8_4(31 downto 8) <= to_shift_8_4(23 downto 0);
	from_shift_8_4(7 downto 0) <= to_shift_8_4(31 downto 24);
	
	-- pht transformation
	pht_transform4: pht
	port map	(
				up_in_pht => to_up_pht_4,
				down_in_pht => from_shift_8_4,
				up_out_pht => out_K6_twk128,
				down_out_pht => to_shift_9_4
				);
				
	-- left rotate by 9
	out_K7_twk128(31 downto 9) <= to_shift_9_4(22 downto 0);
	out_K7_twk128(8 downto 0) <= to_shift_9_4(31 downto 23);

end twofish_whit_keysched128_arch;
