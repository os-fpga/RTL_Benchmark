LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY BalancedMult IS PORT (
	A0 : IN std_logic;
	A1 : IN std_logic;
	A2 : IN std_logic;
	A3 : IN std_logic;
	A4 : IN std_logic;
	A5 : IN std_logic;
	A6 : IN std_logic;
	A7 : IN std_logic;
	B0 : IN std_logic;
	B1 : IN std_logic;
	B2 : IN std_logic;
	B3 : IN std_logic;
	B4 : IN std_logic;
	B5 : IN std_logic;
	B6 : IN std_logic;
	B7 : IN std_logic;
	Y0 : OUT std_logic;
	Y1 : OUT std_logic;
	Y2 : OUT std_logic;
	Y3 : OUT std_logic;
	Y4 : OUT std_logic;
	Y5 : OUT std_logic;
	Y6 : OUT std_logic;
	Y7 : OUT std_logic;
	Y8 : OUT std_logic;
	Y9 : OUT std_logic;
	Y10 : OUT std_logic;
	Y11 : OUT std_logic;
	Y12 : OUT std_logic;
	Y13 : OUT std_logic;
	Y14 : OUT std_logic;
	Y15 : OUT std_logic
); 

END BalancedMult;



ARCHITECTURE STRUCTURE OF BalancedMult IS

-- COMPONENTS

COMPONENT MCELL21
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL11
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL21_1
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELLNONE
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL31
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL41
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL51
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL61
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL71
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL22
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL24
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL26
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL28
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL210
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL212
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

COMPONENT MCELL214
	PORT (
	AIN : IN std_logic;
	AOUT : OUT std_logic;
	BIN : IN std_logic;
	BOUT : OUT std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUMIN : IN std_logic;
	SUMOUT : OUT std_logic
	); END COMPONENT;

-- SIGNALS

SIGNAL TEST88 : std_logic;
SIGNAL TEST89 : std_logic;
SIGNAL TEST90 : std_logic;
SIGNAL TEST91 : std_logic;
SIGNAL TEST92 : std_logic;
SIGNAL TEST94 : std_logic;
SIGNAL TEST95 : std_logic;
SIGNAL TEST96 : std_logic;
SIGNAL TEST97 : std_logic;
SIGNAL TEST98 : std_logic;
SIGNAL TEST99 : std_logic;
SIGNAL TEST100 : std_logic;
SIGNAL TEST101 : std_logic;
SIGNAL TEST102 : std_logic;
SIGNAL TEST103 : std_logic;
SIGNAL TEST104 : std_logic;
SIGNAL TEST105 : std_logic;
SIGNAL TEST106 : std_logic;
SIGNAL TEST107 : std_logic;
SIGNAL TEST108 : std_logic;
SIGNAL TEST109 : std_logic;
SIGNAL TEST110 : std_logic;
SIGNAL TEST111 : std_logic;
SIGNAL TEST93 : std_logic;
SIGNAL TEST112 : std_logic;
SIGNAL TEST113 : std_logic;
SIGNAL TEST114 : std_logic;
SIGNAL TEST115 : std_logic;
SIGNAL TEST116 : std_logic;
SIGNAL TEST117 : std_logic;
SIGNAL N23528 : std_logic;
SIGNAL N23080 : std_logic;
SIGNAL N23188 : std_logic;
SIGNAL N23512 : std_logic;
SIGNAL N23100 : std_logic;
SIGNAL N23092 : std_logic;
SIGNAL N22676 : std_logic;
SIGNAL N28640 : std_logic;
SIGNAL N10645 : std_logic;
SIGNAL N10543 : std_logic;
SIGNAL N09859 : std_logic;
SIGNAL N09910 : std_logic;
SIGNAL N181410 : std_logic;
SIGNAL N10077 : std_logic;
SIGNAL N10390 : std_logic;
SIGNAL N22624 : std_logic;
SIGNAL N28815 : std_logic;
SIGNAL N23152 : std_logic;
SIGNAL N23192 : std_logic;
SIGNAL N23084 : std_logic;
SIGNAL N22808 : std_logic;
SIGNAL N22680 : std_logic;
SIGNAL N23164 : std_logic;
SIGNAL N23264 : std_logic;
SIGNAL N23088 : std_logic;
SIGNAL N10128 : std_logic;
SIGNAL N28980 : std_logic;
SIGNAL N10237 : std_logic;
SIGNAL N08574 : std_logic;
SIGNAL N08683 : std_logic;
SIGNAL N08348 : std_logic;
SIGNAL N33821 : std_logic;
SIGNAL N33872 : std_logic;
SIGNAL N26020 : std_logic;
SIGNAL N33923 : std_logic;
SIGNAL N25628 : std_logic;
SIGNAL N33974 : std_logic;
SIGNAL N35622 : std_logic;
SIGNAL N24088 : std_logic;
SIGNAL N34429 : std_logic;
SIGNAL N24484 : std_logic;
SIGNAL N34737 : std_logic;
SIGNAL N295285 : std_logic;
SIGNAL N24944 : std_logic;
SIGNAL N24180 : std_logic;
SIGNAL N24164 : std_logic;
SIGNAL N24836 : std_logic;
SIGNAL N35480 : std_logic;
SIGNAL N26232 : std_logic;
SIGNAL N25684 : std_logic;
SIGNAL N26348 : std_logic;
SIGNAL N26480 : std_logic;
SIGNAL N25716 : std_logic;
SIGNAL N26376 : std_logic;
SIGNAL N26004 : std_logic;
SIGNAL N25680 : std_logic;
SIGNAL N25696 : std_logic;
SIGNAL N26364 : std_logic;
SIGNAL N24204 : std_logic;
SIGNAL N35035 : std_logic;
SIGNAL N24840 : std_logic;
SIGNAL N24224 : std_logic;
SIGNAL N24468 : std_logic;
SIGNAL N24144 : std_logic;
SIGNAL N39255 : std_logic;
SIGNAL N24820 : std_logic;
SIGNAL N39228 : std_logic;
SIGNAL N24948 : std_logic;
SIGNAL N24208 : std_logic;
SIGNAL N24832 : std_logic;
SIGNAL N24488 : std_logic;
SIGNAL N39201 : std_logic;
SIGNAL N26288 : std_logic;
SIGNAL N39174 : std_logic;
SIGNAL N35137 : std_logic;
SIGNAL N39147 : std_logic;
SIGNAL N25880 : std_logic;
SIGNAL N26356 : std_logic;
SIGNAL N26484 : std_logic;
SIGNAL N39120 : std_logic;
SIGNAL N25744 : std_logic;
SIGNAL N38904 : std_logic;
SIGNAL N10441 : std_logic;
SIGNAL N38931 : std_logic;
SIGNAL N09687 : std_logic;
SIGNAL N08025 : std_logic;
SIGNAL N08427 : std_logic;
SIGNAL N38958 : std_logic;
SIGNAL N08762 : std_logic;
SIGNAL N38985 : std_logic;
SIGNAL N25624 : std_logic;
SIGNAL N34025 : std_logic;
SIGNAL N25700 : std_logic;
SIGNAL N179382 : std_logic;
SIGNAL N39012 : std_logic;
SIGNAL N25740 : std_logic;
SIGNAL N25760 : std_logic;
SIGNAL N39039 : std_logic;
SIGNAL N26368 : std_logic;
SIGNAL N39093 : std_logic;
SIGNAL N39066 : std_logic;
SIGNAL N26024 : std_logic;
SIGNAL N23252 : std_logic;
SIGNAL N23076 : std_logic;
SIGNAL N13556 : std_logic;
SIGNAL N28498 : std_logic;
SIGNAL N11218 : std_logic;
SIGNAL N11371 : std_logic;
SIGNAL N11116 : std_logic;
SIGNAL N11320 : std_logic;
SIGNAL N38601 : std_logic;
SIGNAL N10963 : std_logic;
SIGNAL N11065 : std_logic;
SIGNAL N24092 : std_logic;
SIGNAL N24148 : std_logic;
SIGNAL N24160 : std_logic;
SIGNAL GND : std_logic;
SIGNAL N39282 : std_logic;
SIGNAL N24344 : std_logic;
SIGNAL N22860 : std_logic;
SIGNAL N23336 : std_logic;
SIGNAL N23172 : std_logic;
SIGNAL N23180 : std_logic;
SIGNAL TEST1 : std_logic;
SIGNAL TEST2 : std_logic;
SIGNAL TEST3 : std_logic;
SIGNAL TEST4 : std_logic;
SIGNAL TEST5 : std_logic;
SIGNAL TEST6 : std_logic;
SIGNAL TEST7 : std_logic;
SIGNAL TEST8 : std_logic;
SIGNAL TEST9 : std_logic;
SIGNAL TEST10 : std_logic;
SIGNAL TEST11 : std_logic;
SIGNAL TEST12 : std_logic;
SIGNAL TEST13 : std_logic;
SIGNAL TEST14 : std_logic;
SIGNAL TEST15 : std_logic;
SIGNAL TEST17 : std_logic;
SIGNAL TEST18 : std_logic;
SIGNAL TEST19 : std_logic;
SIGNAL TEST20 : std_logic;
SIGNAL TEST21 : std_logic;
SIGNAL TEST22 : std_logic;
SIGNAL TEST23 : std_logic;
SIGNAL TEST24 : std_logic;
SIGNAL TEST16 : std_logic;
SIGNAL TEST0 : std_logic;
SIGNAL TEST25 : std_logic;
SIGNAL TEST26 : std_logic;
SIGNAL TEST27 : std_logic;
SIGNAL TEST28 : std_logic;
SIGNAL TEST29 : std_logic;
SIGNAL TEST30 : std_logic;
SIGNAL TEST31 : std_logic;
SIGNAL TEST32 : std_logic;
SIGNAL TEST33 : std_logic;
SIGNAL TEST34 : std_logic;
SIGNAL TEST35 : std_logic;
SIGNAL TEST36 : std_logic;
SIGNAL TEST37 : std_logic;
SIGNAL TEST38 : std_logic;
SIGNAL TEST39 : std_logic;
SIGNAL TEST40 : std_logic;
SIGNAL TEST41 : std_logic;
SIGNAL TEST42 : std_logic;
SIGNAL TEST43 : std_logic;
SIGNAL TEST44 : std_logic;
SIGNAL TEST45 : std_logic;
SIGNAL TEST46 : std_logic;
SIGNAL TEST47 : std_logic;
SIGNAL TEST48 : std_logic;
SIGNAL TEST49 : std_logic;
SIGNAL TEST50 : std_logic;
SIGNAL TEST51 : std_logic;
SIGNAL TEST52 : std_logic;
SIGNAL TEST53 : std_logic;
SIGNAL TEST54 : std_logic;
SIGNAL TEST56 : std_logic;
SIGNAL TEST55 : std_logic;
SIGNAL TEST57 : std_logic;
SIGNAL TEST58 : std_logic;
SIGNAL TEST59 : std_logic;
SIGNAL TEST60 : std_logic;
SIGNAL TEST61 : std_logic;
SIGNAL TEST62 : std_logic;
SIGNAL TEST63 : std_logic;
SIGNAL TEST64 : std_logic;
SIGNAL TEST65 : std_logic;
SIGNAL TEST66 : std_logic;
SIGNAL TEST67 : std_logic;
SIGNAL TEST68 : std_logic;
SIGNAL TEST69 : std_logic;
SIGNAL TEST70 : std_logic;
SIGNAL TEST71 : std_logic;
SIGNAL TEST72 : std_logic;
SIGNAL TEST73 : std_logic;
SIGNAL TEST74 : std_logic;
SIGNAL TEST75 : std_logic;
SIGNAL TEST76 : std_logic;
SIGNAL TEST77 : std_logic;
SIGNAL TEST78 : std_logic;
SIGNAL TEST79 : std_logic;
SIGNAL TEST80 : std_logic;
SIGNAL TEST81 : std_logic;
SIGNAL TEST82 : std_logic;
SIGNAL TEST83 : std_logic;
SIGNAL TEST84 : std_logic;
SIGNAL TEST85 : std_logic;
SIGNAL TEST86 : std_logic;
SIGNAL TEST87 : std_logic;

-- GATE INSTANCES

BEGIN
GND <= '0';
U330 : MCELL21	PORT MAP(
	AIN => N35035, 
	AOUT => N25696, 
	BIN => N26364, 
	BOUT => N26288, 
	CIN => TEST96, 
	COUT => TEST98, 
	SUMIN => TEST84, 
	SUMOUT => TEST97
);
U331 : MCELL21	PORT MAP(
	AIN => N24224, 
	AOUT => N35035, 
	BIN => N24204, 
	BOUT => N24832, 
	CIN => TEST94, 
	COUT => TEST96, 
	SUMIN => TEST82, 
	SUMOUT => TEST95
);
U332 : MCELL21	PORT MAP(
	AIN => N24144, 
	AOUT => N24224, 
	BIN => N24840, 
	BOUT => N24948, 
	CIN => TEST92, 
	COUT => TEST94, 
	SUMIN => TEST80, 
	SUMOUT => TEST93
);
U300 : MCELL21	PORT MAP(
	AIN => N10543, 
	AOUT => N10441, 
	BIN => N11320, 
	BOUT => N09859, 
	CIN => TEST25, 
	COUT => TEST27, 
	SUMIN => TEST14, 
	SUMOUT => TEST26
);
U333 : MCELL21	PORT MAP(
	AIN => N24160, 
	AOUT => N24144, 
	BIN => N24468, 
	BOUT => N24820, 
	CIN => TEST90, 
	COUT => TEST92, 
	SUMIN => TEST78, 
	SUMOUT => TEST91
);
U302 : MCELL21	PORT MAP(
	AIN => N181410, 
	AOUT => N08025, 
	BIN => N09859, 
	BOUT => N08348, 
	CIN => TEST40, 
	COUT => TEST42, 
	SUMIN => TEST28, 
	SUMOUT => TEST41
);
U334 : MCELL21	PORT MAP(
	AIN => N24344, 
	AOUT => N24208, 
	BIN => N24820, 
	BOUT => N39255, 
	CIN => TEST105, 
	COUT => TEST106, 
	SUMIN => TEST93, 
	SUMOUT => Y8
);
U303 : MCELL21	PORT MAP(
	AIN => N10390, 
	AOUT => N181410, 
	BIN => N09910, 
	BOUT => N08574, 
	CIN => TEST38, 
	COUT => TEST40, 
	SUMIN => TEST26, 
	SUMOUT => TEST39
);
U335 : MCELL21	PORT MAP(
	AIN => N24208, 
	AOUT => N24488, 
	BIN => N24948, 
	BOUT => N39228, 
	CIN => TEST106, 
	COUT => TEST107, 
	SUMIN => TEST95, 
	SUMOUT => Y9
);
U304 : MCELL21	PORT MAP(
	AIN => N28815, 
	AOUT => N10390, 
	BIN => N10077, 
	BOUT => N10128, 
	CIN => TEST36, 
	COUT => TEST38, 
	SUMIN => TEST16, 
	SUMOUT => TEST37
);
U336 : MCELL21	PORT MAP(
	AIN => N24488, 
	AOUT => N35137, 
	BIN => N24832, 
	BOUT => N39201, 
	CIN => TEST107, 
	COUT => TEST108, 
	SUMIN => TEST97, 
	SUMOUT => Y10
);
U305 : MCELL21	PORT MAP(
	AIN => N23192, 
	AOUT => N28815, 
	BIN => N22624, 
	BOUT => N23088, 
	CIN => TEST34, 
	COUT => TEST36, 
	SUMIN => TEST24, 
	SUMOUT => TEST35
);
U337 : MCELL21	PORT MAP(
	AIN => N35137, 
	AOUT => N25880, 
	BIN => N26288, 
	BOUT => N39174, 
	CIN => TEST108, 
	COUT => TEST109, 
	SUMIN => TEST99, 
	SUMOUT => Y11
);
U306 : MCELL21	PORT MAP(
	AIN => N23084, 
	AOUT => N23192, 
	BIN => N23152, 
	BOUT => N23164, 
	CIN => TEST32, 
	COUT => TEST34, 
	SUMIN => TEST22, 
	SUMOUT => TEST33
);
U338 : MCELL21	PORT MAP(
	AIN => N25880, 
	AOUT => N25744, 
	BIN => N26356, 
	BOUT => N39147, 
	CIN => TEST109, 
	COUT => TEST110, 
	SUMIN => TEST101, 
	SUMOUT => Y12
);
U307 : MCELL21	PORT MAP(
	AIN => N23336, 
	AOUT => N23084, 
	BIN => N23172, 
	BOUT => N22808, 
	CIN => TEST30, 
	COUT => TEST32, 
	SUMIN => TEST20, 
	SUMOUT => TEST31
);
U339 : MCELL21	PORT MAP(
	AIN => N25744, 
	AOUT => N26024, 
	BIN => N26484, 
	BOUT => N39120, 
	CIN => TEST110, 
	COUT => TEST111, 
	SUMIN => TEST103, 
	SUMOUT => Y13
);
U308 : MCELL21	PORT MAP(
	AIN => N23180, 
	AOUT => N22680, 
	BIN => N22808, 
	BOUT => N34737, 
	CIN => TEST45, 
	COUT => TEST47, 
	SUMIN => TEST33, 
	SUMOUT => TEST46
);
U309 : MCELL21	PORT MAP(
	AIN => N22680, 
	AOUT => N23264, 
	BIN => N23164, 
	BOUT => N34429, 
	CIN => TEST47, 
	COUT => TEST49, 
	SUMIN => TEST35, 
	SUMOUT => TEST48
);
U293 : MCELL11	PORT MAP(
	AIN => A0, 
	AOUT => N23188, 
	BIN => B1, 
	BOUT => N23512, 
	CIN => TEST1, 
	COUT => TEST3, 
	SUMIN => GND, 
	SUMOUT => TEST2
);
U294 : MCELL21	PORT MAP(
	AIN => N23188, 
	AOUT => N23076, 
	BIN => B2, 
	BOUT => N23100, 
	CIN => TEST3, 
	COUT => TEST5, 
	SUMIN => GND, 
	SUMOUT => TEST4
);
U295 : MCELL21	PORT MAP(
	AIN => N22860, 
	AOUT => N23092, 
	BIN => N23512, 
	BOUT => N23172, 
	CIN => TEST17, 
	COUT => TEST19, 
	SUMIN => TEST4, 
	SUMOUT => TEST18
);
U296 : MCELL21	PORT MAP(
	AIN => N23092, 
	AOUT => N22676, 
	BIN => N23100, 
	BOUT => N23152, 
	CIN => TEST19, 
	COUT => TEST21, 
	SUMIN => TEST6, 
	SUMOUT => TEST20
);
U297 : MCELL21	PORT MAP(
	AIN => N22676, 
	AOUT => N28640, 
	BIN => N23252, 
	BOUT => N22624, 
	CIN => TEST21, 
	COUT => TEST23, 
	SUMIN => TEST8, 
	SUMOUT => TEST22
);
U298 : MCELL21	PORT MAP(
	AIN => N28640, 
	AOUT => N10645, 
	BIN => N13556, 
	BOUT => N10077, 
	CIN => TEST23, 
	COUT => TEST0, 
	SUMIN => TEST10, 
	SUMOUT => TEST24
);
U299 : MCELL21	PORT MAP(
	AIN => N10645, 
	AOUT => N10543, 
	BIN => N11371, 
	BOUT => N09910, 
	CIN => TEST0, 
	COUT => TEST25, 
	SUMIN => TEST12, 
	SUMOUT => TEST16
);
U340 : MCELL21_1	PORT MAP(
	AIN => N10441, 
	AOUT => N38904, 
	BIN => N10963, 
	BOUT => N09687, 
	CIN => TEST27, 
	COUT => TEST29, 
	SUMIN => TEST15, 
	SUMOUT => TEST28
);
U310 : MCELL21	PORT MAP(
	AIN => N23264, 
	AOUT => N28980, 
	BIN => N23088, 
	BOUT => N33974, 
	CIN => TEST49, 
	COUT => TEST51, 
	SUMIN => TEST37, 
	SUMOUT => TEST50
);
U342 : MCELL21_1	PORT MAP(
	AIN => N08025, 
	AOUT => N38931, 
	BIN => N09687, 
	BOUT => N08427, 
	CIN => TEST42, 
	COUT => TEST44, 
	SUMIN => TEST29, 
	SUMOUT => TEST43
);
U343 : MCELL21_1	PORT MAP(
	AIN => N08762, 
	AOUT => N38958, 
	BIN => N08427, 
	BOUT => N34025, 
	CIN => TEST57, 
	COUT => TEST59, 
	SUMIN => TEST44, 
	SUMOUT => TEST58
);
U311 : MCELL21	PORT MAP(
	AIN => N28980, 
	AOUT => N10237, 
	BIN => N10128, 
	BOUT => N33923, 
	CIN => TEST51, 
	COUT => TEST53, 
	SUMIN => TEST39, 
	SUMOUT => TEST52
);
U312 : MCELL21	PORT MAP(
	AIN => N10237, 
	AOUT => N08683, 
	BIN => N08574, 
	BOUT => N33872, 
	CIN => TEST53, 
	COUT => TEST56, 
	SUMIN => TEST41, 
	SUMOUT => TEST54
);
U344 : MCELL21_1	PORT MAP(
	AIN => N25624, 
	AOUT => N38985, 
	BIN => N34025, 
	BOUT => N179382, 
	CIN => TEST72, 
	COUT => TEST74, 
	SUMIN => TEST59, 
	SUMOUT => TEST73
);
U345 : MCELL21_1	PORT MAP(
	AIN => N25700, 
	AOUT => N39012, 
	BIN => N179382, 
	BOUT => N25740, 
	CIN => TEST87, 
	COUT => TEST89, 
	SUMIN => TEST74, 
	SUMOUT => TEST88
);
U313 : MCELL21	PORT MAP(
	AIN => N08683, 
	AOUT => N08762, 
	BIN => N08348, 
	BOUT => N33821, 
	CIN => TEST56, 
	COUT => TEST57, 
	SUMIN => TEST43, 
	SUMOUT => TEST55
);
U314 : MCELL21	PORT MAP(
	AIN => N26020, 
	AOUT => N25624, 
	BIN => N33821, 
	BOUT => N25716, 
	CIN => TEST70, 
	COUT => TEST72, 
	SUMIN => TEST58, 
	SUMOUT => TEST71
);
U346 : MCELL21_1	PORT MAP(
	AIN => N25760, 
	AOUT => N39039, 
	BIN => N25740, 
	BOUT => N26368, 
	CIN => TEST102, 
	COUT => TEST104, 
	SUMIN => TEST89, 
	SUMOUT => TEST103
);
U347 : MCELL21_1	PORT MAP(
	AIN => N26024, 
	AOUT => N39066, 
	BIN => N26368, 
	BOUT => N39093, 
	CIN => TEST111, 
	COUT => Y15, 
	SUMIN => TEST104, 
	SUMOUT => Y14
);
U315 : MCELL21	PORT MAP(
	AIN => N25628, 
	AOUT => N26020, 
	BIN => N33872, 
	BOUT => N26348, 
	CIN => TEST68, 
	COUT => TEST70, 
	SUMIN => TEST55, 
	SUMOUT => TEST69
);
U316 : MCELLNONE	PORT MAP(
	AIN => A0, 
	AOUT => N23528, 
	BIN => B0, 
	BOUT => N23080, 
	CIN => GND, 
	COUT => TEST1, 
	SUMIN => GND, 
	SUMOUT => Y0
);
U348 : MCELL31	PORT MAP(
	AIN => N23076, 
	AOUT => N28498, 
	BIN => B3, 
	BOUT => N23252, 
	CIN => TEST5, 
	COUT => TEST7, 
	SUMIN => GND, 
	SUMOUT => TEST6
);
U317 : MCELL21	PORT MAP(
	AIN => N35622, 
	AOUT => N25628, 
	BIN => N33923, 
	BOUT => N26232, 
	CIN => TEST66, 
	COUT => TEST68, 
	SUMIN => TEST54, 
	SUMOUT => TEST67
);
U349 : MCELL41	PORT MAP(
	AIN => N28498, 
	AOUT => N11218, 
	BIN => B4, 
	BOUT => N13556, 
	CIN => TEST7, 
	COUT => TEST9, 
	SUMIN => GND, 
	SUMOUT => TEST8
);
U318 : MCELL21	PORT MAP(
	AIN => N24088, 
	AOUT => N35622, 
	BIN => N33974, 
	BOUT => N24836, 
	CIN => TEST64, 
	COUT => TEST66, 
	SUMIN => TEST52, 
	SUMOUT => TEST65
);
U319 : MCELL21	PORT MAP(
	AIN => N24484, 
	AOUT => N24088, 
	BIN => N34429, 
	BOUT => N24180, 
	CIN => TEST62, 
	COUT => TEST64, 
	SUMIN => TEST50, 
	SUMOUT => TEST63
);
U350 : MCELL51	PORT MAP(
	AIN => N11218, 
	AOUT => N11116, 
	BIN => B5, 
	BOUT => N11371, 
	CIN => TEST9, 
	COUT => TEST11, 
	SUMIN => GND, 
	SUMOUT => TEST10
);
U351 : MCELL61	PORT MAP(
	AIN => N11116, 
	AOUT => N11065, 
	BIN => B6, 
	BOUT => N11320, 
	CIN => TEST11, 
	COUT => TEST13, 
	SUMIN => GND, 
	SUMOUT => TEST12
);
U320 : MCELL21	PORT MAP(
	AIN => N24092, 
	AOUT => N24484, 
	BIN => N34737, 
	BOUT => N295285, 
	CIN => TEST60, 
	COUT => TEST62, 
	SUMIN => TEST48, 
	SUMOUT => TEST61
);
U352 : MCELL71	PORT MAP(
	AIN => N11065, 
	AOUT => N38601, 
	BIN => B7, 
	BOUT => N10963, 
	CIN => TEST13, 
	COUT => TEST15, 
	SUMIN => GND, 
	SUMOUT => TEST14
);
U353 : MCELL22	PORT MAP(
	AIN => A1, 
	AOUT => N22860, 
	BIN => B0, 
	BOUT => TEST117, 
	CIN => GND, 
	COUT => TEST17, 
	SUMIN => TEST2, 
	SUMOUT => Y1
);
U321 : MCELL21	PORT MAP(
	AIN => N24148, 
	AOUT => N24944, 
	BIN => N295285, 
	BOUT => N24468, 
	CIN => TEST75, 
	COUT => TEST77, 
	SUMIN => TEST63, 
	SUMOUT => TEST76
);
U322 : MCELL21	PORT MAP(
	AIN => N24944, 
	AOUT => N24164, 
	BIN => N24180, 
	BOUT => N24840, 
	CIN => TEST77, 
	COUT => TEST79, 
	SUMIN => TEST65, 
	SUMOUT => TEST78
);
U354 : MCELL24	PORT MAP(
	AIN => A2, 
	AOUT => N23336, 
	BIN => TEST117, 
	BOUT => TEST116, 
	CIN => GND, 
	COUT => TEST30, 
	SUMIN => TEST18, 
	SUMOUT => Y2
);
U355 : MCELL26	PORT MAP(
	AIN => A3, 
	AOUT => N23180, 
	BIN => TEST116, 
	BOUT => TEST115, 
	CIN => GND, 
	COUT => TEST45, 
	SUMIN => TEST31, 
	SUMOUT => Y3
);
U323 : MCELL21	PORT MAP(
	AIN => N24164, 
	AOUT => N35480, 
	BIN => N24836, 
	BOUT => N24204, 
	CIN => TEST79, 
	COUT => TEST81, 
	SUMIN => TEST67, 
	SUMOUT => TEST80
);
U356 : MCELL28	PORT MAP(
	AIN => A4, 
	AOUT => N24092, 
	BIN => TEST115, 
	BOUT => TEST114, 
	CIN => GND, 
	COUT => TEST60, 
	SUMIN => TEST46, 
	SUMOUT => Y4
);
U324 : MCELL21	PORT MAP(
	AIN => N35480, 
	AOUT => N25684, 
	BIN => N26232, 
	BOUT => N26364, 
	CIN => TEST81, 
	COUT => TEST83, 
	SUMIN => TEST69, 
	SUMOUT => TEST82
);
U325 : MCELL21	PORT MAP(
	AIN => N25684, 
	AOUT => N26480, 
	BIN => N26348, 
	BOUT => N26004, 
	CIN => TEST83, 
	COUT => TEST85, 
	SUMIN => TEST71, 
	SUMOUT => TEST84
);
U357 : MCELL210	PORT MAP(
	AIN => A5, 
	AOUT => N24148, 
	BIN => TEST114, 
	BOUT => TEST113, 
	CIN => GND, 
	COUT => TEST75, 
	SUMIN => TEST61, 
	SUMOUT => Y5
);
U358 : MCELL212	PORT MAP(
	AIN => A6, 
	AOUT => N24160, 
	BIN => TEST113, 
	BOUT => TEST112, 
	CIN => GND, 
	COUT => TEST90, 
	SUMIN => TEST76, 
	SUMOUT => Y6
);
U359 : MCELL214	PORT MAP(
	AIN => A7, 
	AOUT => N24344, 
	BIN => TEST112, 
	BOUT => N39282, 
	CIN => GND, 
	COUT => TEST105, 
	SUMIN => TEST91, 
	SUMOUT => Y7
);
U327 : MCELL21	PORT MAP(
	AIN => N26480, 
	AOUT => N25700, 
	BIN => N25716, 
	BOUT => N26376, 
	CIN => TEST85, 
	COUT => TEST87, 
	SUMIN => TEST73, 
	SUMOUT => TEST86
);
U328 : MCELL21	PORT MAP(
	AIN => N25680, 
	AOUT => N25760, 
	BIN => N26376, 
	BOUT => N26484, 
	CIN => TEST100, 
	COUT => TEST102, 
	SUMIN => TEST88, 
	SUMOUT => TEST101
);
U329 : MCELL21	PORT MAP(
	AIN => N25696, 
	AOUT => N25680, 
	BIN => N26004, 
	BOUT => N26356, 
	CIN => TEST98, 
	COUT => TEST100, 
	SUMIN => TEST86, 
	SUMOUT => TEST99
);
END STRUCTURE;

