entity twofish_whit_keysched256 is
port	(
		in_key_twk256		: in std_logic_vector(255 downto 0);
		out_K0_twk256,
		out_K1_twk256,
		out_K2_twk256,
		out_K3_twk256,
		out_K4_twk256,
		out_K5_twk256,
		out_K6_twk256,
		out_K7_twk256			: out std_logic_vector(31 downto 0)
		);
end twofish_whit_keysched256;
				
architecture twofish_whit_keysched256_arch of twofish_whit_keysched256 is

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
			M0, M1, M2, M3, M4, M5, M6, M7	: std_logic_vector(31 downto 0);

	signal	byte15, byte14, byte13, byte12, byte11, byte10,
			byte9, byte8, byte7, byte6, byte5, byte4,
			byte3, byte2, byte1, byte0,
			byte16, byte17, byte18, byte19,
			byte20, byte21, byte22, byte23,
			byte24, byte25, byte26, byte27,
			byte28, byte29, byte30, byte31 : std_logic_vector(7 downto 0);

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

	component h_256 
	port	(
			in_h256			: in std_logic_vector(7 downto 0);
			Mfirst_h256,
			Msecond_h256,
			Mthird_h256,
			Mfourth_h256	: in std_logic_vector(31 downto 0);
			out_h256		: out std_logic_vector(31 downto 0)
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
	byte31 <= in_key_twk256(7 downto 0);
	byte30 <= in_key_twk256(15 downto 8);
	byte29 <= in_key_twk256(23 downto 16);
	byte28 <= in_key_twk256(31 downto 24);
	byte27 <= in_key_twk256(39 downto 32);
	byte26 <= in_key_twk256(47 downto 40);
	byte25 <= in_key_twk256(55 downto 48);
	byte24 <= in_key_twk256(63 downto 56);
	byte23 <= in_key_twk256(71 downto 64);
	byte22 <= in_key_twk256(79 downto 72);
	byte21 <= in_key_twk256(87 downto 80);
	byte20 <= in_key_twk256(95 downto 88);
	byte19 <= in_key_twk256(103 downto 96);
	byte18 <= in_key_twk256(111 downto 104);
	byte17 <= in_key_twk256(119 downto 112);
	byte16 <= in_key_twk256(127 downto 120);
	byte15 <= in_key_twk256(135 downto 128);
	byte14 <= in_key_twk256(143 downto 136);
	byte13 <= in_key_twk256(151 downto 144);
	byte12 <= in_key_twk256(159 downto 152);
	byte11 <= in_key_twk256(167 downto 160);
	byte10 <= in_key_twk256(175 downto 168);
	byte9 <= in_key_twk256(183 downto 176);
	byte8 <= in_key_twk256(191 downto 184);
	byte7 <= in_key_twk256(199 downto 192);
	byte6 <= in_key_twk256(207 downto 200);
	byte5 <= in_key_twk256(215 downto 208);
	byte4 <= in_key_twk256(223 downto 216);
	byte3 <= in_key_twk256(231 downto 224);
	byte2 <= in_key_twk256(239 downto 232);
	byte1 <= in_key_twk256(247 downto 240);
	byte0 <= in_key_twk256(255 downto 248);

	-- we form the M{0..7}
	M0 <= byte3 & byte2 & byte1 & byte0;
	M1 <= byte7 & byte6 & byte5 & byte4;
	M2 <= byte11 & byte10 & byte9 & byte8;
	M3 <= byte15 & byte14 & byte13 & byte12;
	M4 <= byte19 & byte18 & byte17 & byte16;
	M5 <= byte23 & byte22 & byte21 & byte20;
	M6 <= byte27 & byte26 & byte25 & byte24;
	M7 <= byte31 & byte30 & byte29 & byte28;

	-- we produce the keys for the whitening steps
	-- keys K0,1
	-- upper h
	upper_h1: h_256
	port map	(
				in_h256 => zero,
				Mfirst_h256 => M6,
				Msecond_h256 => M4,
				Mthird_h256 => M2,
				Mfourth_h256 => M0,
				out_h256 => to_up_pht_1
				);
				
	-- lower h
	lower_h1: h_256
	port map	(
				in_h256 => one,
				Mfirst_h256 => M7,
				Msecond_h256 => M5,
				Mthird_h256 => M3,
				Mfourth_h256 => M1,
				out_h256 => to_shift_8_1
				);
				
	-- left rotate by 8
	from_shift_8_1(31 downto 8) <= to_shift_8_1(23 downto 0);
	from_shift_8_1(7 downto 0) <= to_shift_8_1(31 downto 24);
	
	-- pht transformation
	pht_transform1: pht
	port map	(
				up_in_pht => to_up_pht_1,
				down_in_pht => from_shift_8_1,
				up_out_pht => out_K0_twk256,
				down_out_pht => to_shift_9_1
				);
				
	-- left rotate by 9
	out_K1_twk256(31 downto 9) <= to_shift_9_1(22 downto 0);
	out_K1_twk256(8 downto 0) <= to_shift_9_1(31 downto 23);

	-- keys K2,3
	-- upper h
	upper_h2: h_256
	port map	(
				in_h256 => two,
				Mfirst_h256 => M6,
				Msecond_h256 => M4,
				Mthird_h256 => M2,
				Mfourth_h256 => M0,
				out_h256 => to_up_pht_2
				);
				
	-- lower h
	lower_h2: h_256
	port map	(
				in_h256 => three,
				Mfirst_h256 => M7,
				Msecond_h256 => M5,
				Mthird_h256 => M3,
				Mfourth_h256 => M1,
				out_h256 => to_shift_8_2
				);
				
	-- left rotate by 8
	from_shift_8_2(31 downto 8) <= to_shift_8_2(23 downto 0);
	from_shift_8_2(7 downto 0) <= to_shift_8_2(31 downto 24);
	
	-- pht transformation
	pht_transform2: pht
	port map	(
				up_in_pht => to_up_pht_2,
				down_in_pht => from_shift_8_2,
				up_out_pht => out_K2_twk256,
				down_out_pht => to_shift_9_2
				);
				
	-- left rotate by 9
	out_K3_twk256(31 downto 9) <= to_shift_9_2(22 downto 0);
	out_K3_twk256(8 downto 0) <= to_shift_9_2(31 downto 23);

	-- keys K4,5
	-- upper h
	upper_h3: h_256
	port map	(
				in_h256 => four,
				Mfirst_h256 => M6,
				Msecond_h256 => M4,
				Mthird_h256 => M2,
				Mfourth_h256 => M0,
				out_h256 => to_up_pht_3
				);
				
	-- lower h
	lower_h3: h_256
	port map	(
				in_h256 => five,
				Mfirst_h256 => M7,
				Msecond_h256 => M5,
				Mthird_h256 => M3,
				Mfourth_h256 => M1,
				out_h256 => to_shift_8_3
				);
				
	-- left rotate by 8
	from_shift_8_3(31 downto 8) <= to_shift_8_3(23 downto 0);
	from_shift_8_3(7 downto 0) <= to_shift_8_3(31 downto 24);
	
	-- pht transformation
	pht_transform3: pht
	port map	(
				up_in_pht => to_up_pht_3,
				down_in_pht => from_shift_8_3,
				up_out_pht => out_K4_twk256,
				down_out_pht => to_shift_9_3
				);
				
	-- left rotate by 9
	out_K5_twk256(31 downto 9) <= to_shift_9_3(22 downto 0);
	out_K5_twk256(8 downto 0) <= to_shift_9_3(31 downto 23);

	-- keys K6,7
	-- upper h
	upper_h4: h_256
	port map	(
				in_h256 => six,
				Mfirst_h256 => M6,
				Msecond_h256 => M4,
				Mthird_h256 => M2,
				Mfourth_h256 => M0,
				out_h256 => to_up_pht_4
				);
				
	-- lower h
	lower_h4: h_256
	port map	(
				in_h256 => seven,
				Mfirst_h256 => M7,
				Msecond_h256 => M5,
				Mthird_h256 => M3,
				Mfourth_h256 => M1,
				out_h256 => to_shift_8_4
				);
				
	-- left rotate by 8
	from_shift_8_4(31 downto 8) <= to_shift_8_4(23 downto 0);
	from_shift_8_4(7 downto 0) <= to_shift_8_4(31 downto 24);
	
	-- pht transformation
	pht_transform4: pht
	port map	(
				up_in_pht => to_up_pht_4,
				down_in_pht => from_shift_8_4,
				up_out_pht => out_K6_twk256,
				down_out_pht => to_shift_9_4
				);
				
	-- left rotate by 9
	out_K7_twk256(31 downto 9) <= to_shift_9_4(22 downto 0);
	out_K7_twk256(8 downto 0) <= to_shift_9_4(31 downto 23);

end twofish_whit_keysched256_arch;
