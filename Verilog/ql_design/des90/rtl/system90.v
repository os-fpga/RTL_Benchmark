`timescale 1ns / 1ns
module system90(clk,resetn,boot_iaddr,boot_idata,boot_daddr,boot_ddata,reg_file_b_readdataout,processor_select);
	input clk;
	input resetn;
	input [6:0] processor_select;
	output [31:0] reg_file_b_readdataout;
	input [13:0] boot_iaddr;
	input [31:0] boot_idata;
	input [13:0] boot_daddr;
	input [31:0] boot_ddata;


	reg boot_iwe0;
	reg boot_dwe0;
	reg boot_iwe1;
	reg boot_dwe1;
	reg boot_iwe2;
	reg boot_dwe2;
	reg boot_iwe3;
	reg boot_dwe3;
	reg boot_iwe4;
	reg boot_dwe4;
	reg boot_iwe5;
	reg boot_dwe5;
	reg boot_iwe6;
	reg boot_dwe6;
	reg boot_iwe7;
	reg boot_dwe7;
	reg boot_iwe8;
	reg boot_dwe8;
	reg boot_iwe9;
	reg boot_dwe9;
	reg boot_iwe10;
	reg boot_dwe10;
	reg boot_iwe11;
	reg boot_dwe11;
	reg boot_iwe12;
	reg boot_dwe12;
	reg boot_iwe13;
	reg boot_dwe13;
	reg boot_iwe14;
	reg boot_dwe14;
	reg boot_iwe15;
	reg boot_dwe15;
	reg boot_iwe16;
	reg boot_dwe16;
	reg boot_iwe17;
	reg boot_dwe17;
	reg boot_iwe18;
	reg boot_dwe18;
	reg boot_iwe19;
	reg boot_dwe19;
	reg boot_iwe20;
	reg boot_dwe20;
	reg boot_iwe21;
	reg boot_dwe21;
	reg boot_iwe22;
	reg boot_dwe22;
	reg boot_iwe23;
	reg boot_dwe23;
	reg boot_iwe24;
	reg boot_dwe24;
	reg boot_iwe25;
	reg boot_dwe25;
	reg boot_iwe26;
	reg boot_dwe26;
	reg boot_iwe27;
	reg boot_dwe27;
	reg boot_iwe28;
	reg boot_dwe28;
	reg boot_iwe29;
	reg boot_dwe29;
	reg boot_iwe30;
	reg boot_dwe30;
	reg boot_iwe31;
	reg boot_dwe31;
	reg boot_iwe32;
	reg boot_dwe32;
	reg boot_iwe33;
	reg boot_dwe33;
	reg boot_iwe34;
	reg boot_dwe34;
	reg boot_iwe35;
	reg boot_dwe35;
	reg boot_iwe36;
	reg boot_dwe36;
	reg boot_iwe37;
	reg boot_dwe37;
	reg boot_iwe38;
	reg boot_dwe38;
	reg boot_iwe39;
	reg boot_dwe39;
	reg boot_iwe40;
	reg boot_dwe40;
	reg boot_iwe41;
	reg boot_dwe41;
	reg boot_iwe42;
	reg boot_dwe42;
	reg boot_iwe43;
	reg boot_dwe43;
	reg boot_iwe44;
	reg boot_dwe44;
	reg boot_iwe45;
	reg boot_dwe45;
	reg boot_iwe46;
	reg boot_dwe46;
	reg boot_iwe47;
	reg boot_dwe47;
	reg boot_iwe48;
	reg boot_dwe48;
	reg boot_iwe49;
	reg boot_dwe49;
	reg boot_iwe50;
	reg boot_dwe50;
	reg boot_iwe51;
	reg boot_dwe51;
	reg boot_iwe52;
	reg boot_dwe52;
	reg boot_iwe53;
	reg boot_dwe53;
	reg boot_iwe54;
	reg boot_dwe54;
	reg boot_iwe55;
	reg boot_dwe55;
	reg boot_iwe56;
	reg boot_dwe56;
	reg boot_iwe57;
	reg boot_dwe57;
	reg boot_iwe58;
	reg boot_dwe58;
	reg boot_iwe59;
	reg boot_dwe59;
	reg boot_iwe60;
	reg boot_dwe60;
	reg boot_iwe61;
	reg boot_dwe61;
	reg boot_iwe62;
	reg boot_dwe62;
	reg boot_iwe63;
	reg boot_dwe63;
	reg boot_iwe64;
	reg boot_dwe64;
	reg boot_iwe65;
	reg boot_dwe65;
	reg boot_iwe66;
	reg boot_dwe66;
	reg boot_iwe67;
	reg boot_dwe67;
	reg boot_iwe68;
	reg boot_dwe68;
	reg boot_iwe69;
	reg boot_dwe69;
	reg boot_iwe70;
	reg boot_dwe70;
	reg boot_iwe71;
	reg boot_dwe71;
	reg boot_iwe72;
	reg boot_dwe72;
	reg boot_iwe73;
	reg boot_dwe73;
	reg boot_iwe74;
	reg boot_dwe74;
	reg boot_iwe75;
	reg boot_dwe75;
	reg boot_iwe76;
	reg boot_dwe76;
	reg boot_iwe77;
	reg boot_dwe77;
	reg boot_iwe78;
	reg boot_dwe78;
	reg boot_iwe79;
	reg boot_dwe79;
	reg boot_iwe80;
	reg boot_dwe80;
	reg boot_iwe81;
	reg boot_dwe81;
	reg boot_iwe82;
	reg boot_dwe82;
	reg boot_iwe83;
	reg boot_dwe83;
	reg boot_iwe84;
	reg boot_dwe84;
	reg boot_iwe85;
	reg boot_dwe85;
	reg boot_iwe86;
	reg boot_dwe86;
	reg boot_iwe87;
	reg boot_dwe87;
	reg boot_iwe88;
	reg boot_dwe88;
	reg boot_iwe89;
	reg boot_dwe89;

	 //Processor 0 control and data signals
	wire wrProc0South;
	wire fullProc0South;
	wire [31:0] dataOutProc0South;

	 //Processor 0 control and data signals
	wire wrProc0East;
	wire fullProc0East;
	wire [31:0] dataOutProc0East;

	 //Processor 1 control and data signals
	wire wrProc1South;
	wire fullProc1South;
	wire [31:0] dataOutProc1South;

	 //Processor 1 control and data signals
	wire rdProc1West;
	wire emptyProc1West;
	wire [31:0] dataInProc1West;

	 //Processor 4 control and data signals
	wire rdProc4South;
	wire emptyProc4South;
	wire [31:0] dataInProc4South;

	 //Processor 4 control and data signals
	wire rdProc4East;
	wire emptyProc4East;
	wire [31:0] dataInProc4East;

	 //Processor 4 control and data signals
	wire wrProc4East;
	wire fullProc4East;
	wire [31:0] dataOutProc4East;

	 //Processor 5 control and data signals
	wire rdProc5East;
	wire emptyProc5East;
	wire [31:0] dataInProc5East;

	 //Processor 5 control and data signals
	wire rdProc5West;
	wire emptyProc5West;
	wire [31:0] dataInProc5West;

	 //Processor 5 control and data signals
	wire wrProc5West;
	wire fullProc5West;
	wire [31:0] dataOutProc5West;

	 //Processor 6 control and data signals
	wire rdProc6South;
	wire emptyProc6South;
	wire [31:0] dataInProc6South;

	 //Processor 6 control and data signals
	wire wrProc6South;
	wire fullProc6South;
	wire [31:0] dataOutProc6South;

	 //Processor 6 control and data signals
	wire rdProc6East;
	wire emptyProc6East;
	wire [31:0] dataInProc6East;

	 //Processor 6 control and data signals
	wire wrProc6West;
	wire fullProc6West;
	wire [31:0] dataOutProc6West;

	 //Processor 7 control and data signals
	wire rdProc7South;
	wire emptyProc7South;
	wire [31:0] dataInProc7South;

	 //Processor 7 control and data signals
	wire wrProc7West;
	wire fullProc7West;
	wire [31:0] dataOutProc7West;

	 //Processor 8 control and data signals
	wire rdProc8South;
	wire emptyProc8South;
	wire [31:0] dataInProc8South;

	 //Processor 8 control and data signals
	wire wrProc8South;
	wire fullProc8South;
	wire [31:0] dataOutProc8South;

	 //Processor 8 control and data signals
	wire rdProc8East;
	wire emptyProc8East;
	wire [31:0] dataInProc8East;

	 //Processor 9 control and data signals
	wire rdProc9South;
	wire emptyProc9South;
	wire [31:0] dataInProc9South;

	 //Processor 9 control and data signals
	wire wrProc9West;
	wire fullProc9West;
	wire [31:0] dataOutProc9West;

	 //Processor 10 control and data signals
	wire rdProc10North;
	wire emptyProc10North;
	wire [31:0] dataInProc10North;

	 //Processor 10 control and data signals
	wire wrProc10East;
	wire fullProc10East;
	wire [31:0] dataOutProc10East;

	 //Processor 11 control and data signals
	wire rdProc11North;
	wire emptyProc11North;
	wire [31:0] dataInProc11North;

	 //Processor 11 control and data signals
	wire wrProc11South;
	wire fullProc11South;
	wire [31:0] dataOutProc11South;

	 //Processor 11 control and data signals
	wire rdProc11West;
	wire emptyProc11West;
	wire [31:0] dataInProc11West;

	 //Processor 12 control and data signals
	wire rdProc12South;
	wire emptyProc12South;
	wire [31:0] dataInProc12South;

	 //Processor 12 control and data signals
	wire wrProc12East;
	wire fullProc12East;
	wire [31:0] dataOutProc12East;

	 //Processor 13 control and data signals
	wire rdProc13South;
	wire emptyProc13South;
	wire [31:0] dataInProc13South;

	 //Processor 13 control and data signals
	wire wrProc13East;
	wire fullProc13East;
	wire [31:0] dataOutProc13East;

	 //Processor 13 control and data signals
	wire rdProc13West;
	wire emptyProc13West;
	wire [31:0] dataInProc13West;

	 //Processor 14 control and data signals
	wire wrProc14North;
	wire fullProc14North;
	wire [31:0] dataOutProc14North;

	 //Processor 14 control and data signals
	wire rdProc14South;
	wire emptyProc14South;
	wire [31:0] dataInProc14South;

	 //Processor 14 control and data signals
	wire wrProc14South;
	wire fullProc14South;
	wire [31:0] dataOutProc14South;

	 //Processor 14 control and data signals
	wire wrProc14East;
	wire fullProc14East;
	wire [31:0] dataOutProc14East;

	 //Processor 14 control and data signals
	wire rdProc14West;
	wire emptyProc14West;
	wire [31:0] dataInProc14West;

	 //Processor 15 control and data signals
	wire wrProc15East;
	wire fullProc15East;
	wire [31:0] dataOutProc15East;

	 //Processor 15 control and data signals
	wire rdProc15West;
	wire emptyProc15West;
	wire [31:0] dataInProc15West;

	 //Processor 16 control and data signals
	wire rdProc16North;
	wire emptyProc16North;
	wire [31:0] dataInProc16North;

	 //Processor 16 control and data signals
	wire wrProc16North;
	wire fullProc16North;
	wire [31:0] dataOutProc16North;

	 //Processor 16 control and data signals
	wire wrProc16South;
	wire fullProc16South;
	wire [31:0] dataOutProc16South;

	 //Processor 16 control and data signals
	wire rdProc16West;
	wire emptyProc16West;
	wire [31:0] dataInProc16West;

	 //Processor 17 control and data signals
	wire wrProc17North;
	wire fullProc17North;
	wire [31:0] dataOutProc17North;

	 //Processor 17 control and data signals
	wire rdProc17South;
	wire emptyProc17South;
	wire [31:0] dataInProc17South;

	 //Processor 18 control and data signals
	wire rdProc18North;
	wire emptyProc18North;
	wire [31:0] dataInProc18North;

	 //Processor 18 control and data signals
	wire wrProc18North;
	wire fullProc18North;
	wire [31:0] dataOutProc18North;

	 //Processor 18 control and data signals
	wire wrProc18South;
	wire fullProc18South;
	wire [31:0] dataOutProc18South;

	 //Processor 19 control and data signals
	wire wrProc19North;
	wire fullProc19North;
	wire [31:0] dataOutProc19North;

	 //Processor 19 control and data signals
	wire rdProc19South;
	wire emptyProc19South;
	wire [31:0] dataInProc19South;

	 //Processor 19 control and data signals
	wire wrProc19South;
	wire fullProc19South;
	wire [31:0] dataOutProc19South;

	 //Processor 20 control and data signals
	wire rdProc20South;
	wire emptyProc20South;
	wire [31:0] dataInProc20South;

	 //Processor 20 control and data signals
	wire wrProc20East;
	wire fullProc20East;
	wire [31:0] dataOutProc20East;

	 //Processor 21 control and data signals
	wire rdProc21North;
	wire emptyProc21North;
	wire [31:0] dataInProc21North;

	 //Processor 21 control and data signals
	wire rdProc21South;
	wire emptyProc21South;
	wire [31:0] dataInProc21South;

	 //Processor 21 control and data signals
	wire wrProc21South;
	wire fullProc21South;
	wire [31:0] dataOutProc21South;

	 //Processor 21 control and data signals
	wire wrProc21East;
	wire fullProc21East;
	wire [31:0] dataOutProc21East;

	 //Processor 21 control and data signals
	wire rdProc21West;
	wire emptyProc21West;
	wire [31:0] dataInProc21West;

	 //Processor 22 control and data signals
	wire wrProc22North;
	wire fullProc22North;
	wire [31:0] dataOutProc22North;

	 //Processor 22 control and data signals
	wire rdProc22South;
	wire emptyProc22South;
	wire [31:0] dataInProc22South;

	 //Processor 22 control and data signals
	wire wrProc22South;
	wire fullProc22South;
	wire [31:0] dataOutProc22South;

	 //Processor 22 control and data signals
	wire rdProc22East;
	wire emptyProc22East;
	wire [31:0] dataInProc22East;

	 //Processor 22 control and data signals
	wire wrProc22East;
	wire fullProc22East;
	wire [31:0] dataOutProc22East;

	 //Processor 22 control and data signals
	wire rdProc22West;
	wire emptyProc22West;
	wire [31:0] dataInProc22West;

	 //Processor 23 control and data signals
	wire wrProc23North;
	wire fullProc23North;
	wire [31:0] dataOutProc23North;

	 //Processor 23 control and data signals
	wire rdProc23South;
	wire emptyProc23South;
	wire [31:0] dataInProc23South;

	 //Processor 23 control and data signals
	wire rdProc23East;
	wire emptyProc23East;
	wire [31:0] dataInProc23East;

	 //Processor 23 control and data signals
	wire wrProc23East;
	wire fullProc23East;
	wire [31:0] dataOutProc23East;

	 //Processor 23 control and data signals
	wire rdProc23West;
	wire emptyProc23West;
	wire [31:0] dataInProc23West;

	 //Processor 23 control and data signals
	wire wrProc23West;
	wire fullProc23West;
	wire [31:0] dataOutProc23West;

	 //Processor 24 control and data signals
	wire rdProc24North;
	wire emptyProc24North;
	wire [31:0] dataInProc24North;

	 //Processor 24 control and data signals
	wire wrProc24North;
	wire fullProc24North;
	wire [31:0] dataOutProc24North;

	 //Processor 24 control and data signals
	wire wrProc24South;
	wire fullProc24South;
	wire [31:0] dataOutProc24South;

	 //Processor 24 control and data signals
	wire rdProc24East;
	wire emptyProc24East;
	wire [31:0] dataInProc24East;

	 //Processor 24 control and data signals
	wire wrProc24East;
	wire fullProc24East;
	wire [31:0] dataOutProc24East;

	 //Processor 24 control and data signals
	wire rdProc24West;
	wire emptyProc24West;
	wire [31:0] dataInProc24West;

	 //Processor 24 control and data signals
	wire wrProc24West;
	wire fullProc24West;
	wire [31:0] dataOutProc24West;

	 //Processor 25 control and data signals
	wire rdProc25South;
	wire emptyProc25South;
	wire [31:0] dataInProc25South;

	 //Processor 25 control and data signals
	wire wrProc25South;
	wire fullProc25South;
	wire [31:0] dataOutProc25South;

	 //Processor 25 control and data signals
	wire rdProc25East;
	wire emptyProc25East;
	wire [31:0] dataInProc25East;

	 //Processor 25 control and data signals
	wire wrProc25East;
	wire fullProc25East;
	wire [31:0] dataOutProc25East;

	 //Processor 25 control and data signals
	wire rdProc25West;
	wire emptyProc25West;
	wire [31:0] dataInProc25West;

	 //Processor 25 control and data signals
	wire wrProc25West;
	wire fullProc25West;
	wire [31:0] dataOutProc25West;

	 //Processor 26 control and data signals
	wire rdProc26North;
	wire emptyProc26North;
	wire [31:0] dataInProc26North;

	 //Processor 26 control and data signals
	wire wrProc26South;
	wire fullProc26South;
	wire [31:0] dataOutProc26South;

	 //Processor 26 control and data signals
	wire wrProc26East;
	wire fullProc26East;
	wire [31:0] dataOutProc26East;

	 //Processor 26 control and data signals
	wire rdProc26West;
	wire emptyProc26West;
	wire [31:0] dataInProc26West;

	 //Processor 26 control and data signals
	wire wrProc26West;
	wire fullProc26West;
	wire [31:0] dataOutProc26West;

	 //Processor 27 control and data signals
	wire wrProc27North;
	wire fullProc27North;
	wire [31:0] dataOutProc27North;

	 //Processor 27 control and data signals
	wire wrProc27South;
	wire fullProc27South;
	wire [31:0] dataOutProc27South;

	 //Processor 27 control and data signals
	wire rdProc27East;
	wire emptyProc27East;
	wire [31:0] dataInProc27East;

	 //Processor 27 control and data signals
	wire wrProc27East;
	wire fullProc27East;
	wire [31:0] dataOutProc27East;

	 //Processor 27 control and data signals
	wire rdProc27West;
	wire emptyProc27West;
	wire [31:0] dataInProc27West;

	 //Processor 28 control and data signals
	wire rdProc28North;
	wire emptyProc28North;
	wire [31:0] dataInProc28North;

	 //Processor 28 control and data signals
	wire wrProc28South;
	wire fullProc28South;
	wire [31:0] dataOutProc28South;

	 //Processor 28 control and data signals
	wire rdProc28East;
	wire emptyProc28East;
	wire [31:0] dataInProc28East;

	 //Processor 28 control and data signals
	wire rdProc28West;
	wire emptyProc28West;
	wire [31:0] dataInProc28West;

	 //Processor 28 control and data signals
	wire wrProc28West;
	wire fullProc28West;
	wire [31:0] dataOutProc28West;

	 //Processor 29 control and data signals
	wire rdProc29North;
	wire emptyProc29North;
	wire [31:0] dataInProc29North;

	 //Processor 29 control and data signals
	wire wrProc29North;
	wire fullProc29North;
	wire [31:0] dataOutProc29North;

	 //Processor 29 control and data signals
	wire rdProc29South;
	wire emptyProc29South;
	wire [31:0] dataInProc29South;

	 //Processor 29 control and data signals
	wire wrProc29West;
	wire fullProc29West;
	wire [31:0] dataOutProc29West;

	 //Processor 30 control and data signals
	wire wrProc30North;
	wire fullProc30North;
	wire [31:0] dataOutProc30North;

	 //Processor 30 control and data signals
	wire rdProc30South;
	wire emptyProc30South;
	wire [31:0] dataInProc30South;

	 //Processor 31 control and data signals
	wire rdProc31North;
	wire emptyProc31North;
	wire [31:0] dataInProc31North;

	 //Processor 31 control and data signals
	wire wrProc31North;
	wire fullProc31North;
	wire [31:0] dataOutProc31North;

	 //Processor 32 control and data signals
	wire rdProc32North;
	wire emptyProc32North;
	wire [31:0] dataInProc32North;

	 //Processor 32 control and data signals
	wire wrProc32North;
	wire fullProc32North;
	wire [31:0] dataOutProc32North;

	 //Processor 33 control and data signals
	wire wrProc33North;
	wire fullProc33North;
	wire [31:0] dataOutProc33North;

	 //Processor 33 control and data signals
	wire rdProc33South;
	wire emptyProc33South;
	wire [31:0] dataInProc33South;

	 //Processor 33 control and data signals
	wire wrProc33South;
	wire fullProc33South;
	wire [31:0] dataOutProc33South;

	 //Processor 33 control and data signals
	wire rdProc33East;
	wire emptyProc33East;
	wire [31:0] dataInProc33East;

	 //Processor 34 control and data signals
	wire rdProc34North;
	wire emptyProc34North;
	wire [31:0] dataInProc34North;

	 //Processor 34 control and data signals
	wire wrProc34West;
	wire fullProc34West;
	wire [31:0] dataOutProc34West;

	 //Processor 35 control and data signals
	wire rdProc35North;
	wire emptyProc35North;
	wire [31:0] dataInProc35North;

	 //Processor 35 control and data signals
	wire wrProc35North;
	wire fullProc35North;
	wire [31:0] dataOutProc35North;

	 //Processor 35 control and data signals
	wire rdProc35South;
	wire emptyProc35South;
	wire [31:0] dataInProc35South;

	 //Processor 35 control and data signals
	wire wrProc35East;
	wire fullProc35East;
	wire [31:0] dataOutProc35East;

	 //Processor 36 control and data signals
	wire rdProc36North;
	wire emptyProc36North;
	wire [31:0] dataInProc36North;

	 //Processor 36 control and data signals
	wire wrProc36South;
	wire fullProc36South;
	wire [31:0] dataOutProc36South;

	 //Processor 36 control and data signals
	wire wrProc36East;
	wire fullProc36East;
	wire [31:0] dataOutProc36East;

	 //Processor 36 control and data signals
	wire rdProc36West;
	wire emptyProc36West;
	wire [31:0] dataInProc36West;

	 //Processor 37 control and data signals
	wire rdProc37North;
	wire emptyProc37North;
	wire [31:0] dataInProc37North;

	 //Processor 37 control and data signals
	wire wrProc37South;
	wire fullProc37South;
	wire [31:0] dataOutProc37South;

	 //Processor 37 control and data signals
	wire rdProc37West;
	wire emptyProc37West;
	wire [31:0] dataInProc37West;

	 //Processor 38 control and data signals
	wire rdProc38North;
	wire emptyProc38North;
	wire [31:0] dataInProc38North;

	 //Processor 38 control and data signals
	wire rdProc38South;
	wire emptyProc38South;
	wire [31:0] dataInProc38South;

	 //Processor 38 control and data signals
	wire wrProc38South;
	wire fullProc38South;
	wire [31:0] dataOutProc38South;

	 //Processor 38 control and data signals
	wire wrProc38East;
	wire fullProc38East;
	wire [31:0] dataOutProc38East;

	 //Processor 39 control and data signals
	wire wrProc39North;
	wire fullProc39North;
	wire [31:0] dataOutProc39North;

	 //Processor 39 control and data signals
	wire rdProc39South;
	wire emptyProc39South;
	wire [31:0] dataInProc39South;

	 //Processor 39 control and data signals
	wire rdProc39West;
	wire emptyProc39West;
	wire [31:0] dataInProc39West;

	 //Processor 40 control and data signals
	wire wrProc40North;
	wire fullProc40North;
	wire [31:0] dataOutProc40North;

	 //Processor 40 control and data signals
	wire rdProc40South;
	wire emptyProc40South;
	wire [31:0] dataInProc40South;

	 //Processor 40 control and data signals
	wire wrProc40South;
	wire fullProc40South;
	wire [31:0] dataOutProc40South;

	 //Processor 40 control and data signals
	wire rdProc40East;
	wire emptyProc40East;
	wire [31:0] dataInProc40East;

	 //Processor 41 control and data signals
	wire rdProc41East;
	wire emptyProc41East;
	wire [31:0] dataInProc41East;

	 //Processor 41 control and data signals
	wire wrProc41West;
	wire fullProc41West;
	wire [31:0] dataOutProc41West;

	 //Processor 42 control and data signals
	wire rdProc42South;
	wire emptyProc42South;
	wire [31:0] dataInProc42South;

	 //Processor 42 control and data signals
	wire rdProc42East;
	wire emptyProc42East;
	wire [31:0] dataInProc42East;

	 //Processor 42 control and data signals
	wire wrProc42East;
	wire fullProc42East;
	wire [31:0] dataOutProc42East;

	 //Processor 42 control and data signals
	wire wrProc42West;
	wire fullProc42West;
	wire [31:0] dataOutProc42West;

	 //Processor 43 control and data signals
	wire rdProc43North;
	wire emptyProc43North;
	wire [31:0] dataInProc43North;

	 //Processor 43 control and data signals
	wire wrProc43North;
	wire fullProc43North;
	wire [31:0] dataOutProc43North;

	 //Processor 43 control and data signals
	wire rdProc43South;
	wire emptyProc43South;
	wire [31:0] dataInProc43South;

	 //Processor 43 control and data signals
	wire wrProc43South;
	wire fullProc43South;
	wire [31:0] dataOutProc43South;

	 //Processor 43 control and data signals
	wire wrProc43East;
	wire fullProc43East;
	wire [31:0] dataOutProc43East;

	 //Processor 43 control and data signals
	wire rdProc43West;
	wire emptyProc43West;
	wire [31:0] dataInProc43West;

	 //Processor 43 control and data signals
	wire wrProc43West;
	wire fullProc43West;
	wire [31:0] dataOutProc43West;

	 //Processor 44 control and data signals
	wire wrProc44East;
	wire fullProc44East;
	wire [31:0] dataOutProc44East;

	 //Processor 44 control and data signals
	wire rdProc44West;
	wire emptyProc44West;
	wire [31:0] dataInProc44West;

	 //Processor 45 control and data signals
	wire wrProc45North;
	wire fullProc45North;
	wire [31:0] dataOutProc45North;

	 //Processor 45 control and data signals
	wire wrProc45South;
	wire fullProc45South;
	wire [31:0] dataOutProc45South;

	 //Processor 45 control and data signals
	wire rdProc45East;
	wire emptyProc45East;
	wire [31:0] dataInProc45East;

	 //Processor 45 control and data signals
	wire rdProc45West;
	wire emptyProc45West;
	wire [31:0] dataInProc45West;

	 //Processor 46 control and data signals
	wire rdProc46North;
	wire emptyProc46North;
	wire [31:0] dataInProc46North;

	 //Processor 46 control and data signals
	wire wrProc46South;
	wire fullProc46South;
	wire [31:0] dataOutProc46South;

	 //Processor 46 control and data signals
	wire rdProc46East;
	wire emptyProc46East;
	wire [31:0] dataInProc46East;

	 //Processor 46 control and data signals
	wire wrProc46West;
	wire fullProc46West;
	wire [31:0] dataOutProc46West;

	 //Processor 47 control and data signals
	wire rdProc47North;
	wire emptyProc47North;
	wire [31:0] dataInProc47North;

	 //Processor 47 control and data signals
	wire wrProc47South;
	wire fullProc47South;
	wire [31:0] dataOutProc47South;

	 //Processor 47 control and data signals
	wire wrProc47West;
	wire fullProc47West;
	wire [31:0] dataOutProc47West;

	 //Processor 48 control and data signals
	wire rdProc48North;
	wire emptyProc48North;
	wire [31:0] dataInProc48North;

	 //Processor 48 control and data signals
	wire wrProc48North;
	wire fullProc48North;
	wire [31:0] dataOutProc48North;

	 //Processor 48 control and data signals
	wire rdProc48South;
	wire emptyProc48South;
	wire [31:0] dataInProc48South;

	 //Processor 48 control and data signals
	wire wrProc48South;
	wire fullProc48South;
	wire [31:0] dataOutProc48South;

	 //Processor 49 control and data signals
	wire wrProc49North;
	wire fullProc49North;
	wire [31:0] dataOutProc49North;

	 //Processor 49 control and data signals
	wire rdProc49South;
	wire emptyProc49South;
	wire [31:0] dataInProc49South;

	 //Processor 50 control and data signals
	wire rdProc50North;
	wire emptyProc50North;
	wire [31:0] dataInProc50North;

	 //Processor 50 control and data signals
	wire wrProc50North;
	wire fullProc50North;
	wire [31:0] dataOutProc50North;

	 //Processor 50 control and data signals
	wire rdProc50East;
	wire emptyProc50East;
	wire [31:0] dataInProc50East;

	 //Processor 50 control and data signals
	wire wrProc50East;
	wire fullProc50East;
	wire [31:0] dataOutProc50East;

	 //Processor 51 control and data signals
	wire rdProc51East;
	wire emptyProc51East;
	wire [31:0] dataInProc51East;

	 //Processor 51 control and data signals
	wire wrProc51East;
	wire fullProc51East;
	wire [31:0] dataOutProc51East;

	 //Processor 51 control and data signals
	wire rdProc51West;
	wire emptyProc51West;
	wire [31:0] dataInProc51West;

	 //Processor 51 control and data signals
	wire wrProc51West;
	wire fullProc51West;
	wire [31:0] dataOutProc51West;

	 //Processor 52 control and data signals
	wire wrProc52North;
	wire fullProc52North;
	wire [31:0] dataOutProc52North;

	 //Processor 52 control and data signals
	wire rdProc52South;
	wire emptyProc52South;
	wire [31:0] dataInProc52South;

	 //Processor 52 control and data signals
	wire wrProc52South;
	wire fullProc52South;
	wire [31:0] dataOutProc52South;

	 //Processor 52 control and data signals
	wire rdProc52East;
	wire emptyProc52East;
	wire [31:0] dataInProc52East;

	 //Processor 52 control and data signals
	wire wrProc52East;
	wire fullProc52East;
	wire [31:0] dataOutProc52East;

	 //Processor 52 control and data signals
	wire rdProc52West;
	wire emptyProc52West;
	wire [31:0] dataInProc52West;

	 //Processor 52 control and data signals
	wire wrProc52West;
	wire fullProc52West;
	wire [31:0] dataOutProc52West;

	 //Processor 53 control and data signals
	wire rdProc53North;
	wire emptyProc53North;
	wire [31:0] dataInProc53North;

	 //Processor 53 control and data signals
	wire wrProc53North;
	wire fullProc53North;
	wire [31:0] dataOutProc53North;

	 //Processor 53 control and data signals
	wire rdProc53South;
	wire emptyProc53South;
	wire [31:0] dataInProc53South;

	 //Processor 53 control and data signals
	wire wrProc53South;
	wire fullProc53South;
	wire [31:0] dataOutProc53South;

	 //Processor 53 control and data signals
	wire rdProc53East;
	wire emptyProc53East;
	wire [31:0] dataInProc53East;

	 //Processor 53 control and data signals
	wire rdProc53West;
	wire emptyProc53West;
	wire [31:0] dataInProc53West;

	 //Processor 53 control and data signals
	wire wrProc53West;
	wire fullProc53West;
	wire [31:0] dataOutProc53West;

	 //Processor 54 control and data signals
	wire rdProc54East;
	wire emptyProc54East;
	wire [31:0] dataInProc54East;

	 //Processor 54 control and data signals
	wire wrProc54West;
	wire fullProc54West;
	wire [31:0] dataOutProc54West;

	 //Processor 55 control and data signals
	wire rdProc55North;
	wire emptyProc55North;
	wire [31:0] dataInProc55North;

	 //Processor 55 control and data signals
	wire rdProc55East;
	wire emptyProc55East;
	wire [31:0] dataInProc55East;

	 //Processor 55 control and data signals
	wire wrProc55West;
	wire fullProc55West;
	wire [31:0] dataOutProc55West;

	 //Processor 56 control and data signals
	wire rdProc56North;
	wire emptyProc56North;
	wire [31:0] dataInProc56North;

	 //Processor 56 control and data signals
	wire rdProc56East;
	wire emptyProc56East;
	wire [31:0] dataInProc56East;

	 //Processor 56 control and data signals
	wire wrProc56East;
	wire fullProc56East;
	wire [31:0] dataOutProc56East;

	 //Processor 56 control and data signals
	wire wrProc56West;
	wire fullProc56West;
	wire [31:0] dataOutProc56West;

	 //Processor 57 control and data signals
	wire rdProc57North;
	wire emptyProc57North;
	wire [31:0] dataInProc57North;

	 //Processor 57 control and data signals
	wire wrProc57South;
	wire fullProc57South;
	wire [31:0] dataOutProc57South;

	 //Processor 57 control and data signals
	wire rdProc57West;
	wire emptyProc57West;
	wire [31:0] dataInProc57West;

	 //Processor 57 control and data signals
	wire wrProc57West;
	wire fullProc57West;
	wire [31:0] dataOutProc57West;

	 //Processor 58 control and data signals
	wire rdProc58North;
	wire emptyProc58North;
	wire [31:0] dataInProc58North;

	 //Processor 58 control and data signals
	wire wrProc58North;
	wire fullProc58North;
	wire [31:0] dataOutProc58North;

	 //Processor 58 control and data signals
	wire wrProc58South;
	wire fullProc58South;
	wire [31:0] dataOutProc58South;

	 //Processor 58 control and data signals
	wire rdProc58East;
	wire emptyProc58East;
	wire [31:0] dataInProc58East;

	 //Processor 59 control and data signals
	wire wrProc59North;
	wire fullProc59North;
	wire [31:0] dataOutProc59North;

	 //Processor 59 control and data signals
	wire rdProc59South;
	wire emptyProc59South;
	wire [31:0] dataInProc59South;

	 //Processor 59 control and data signals
	wire wrProc59West;
	wire fullProc59West;
	wire [31:0] dataOutProc59West;

	 //Processor 60 control and data signals
	wire wrProc60South;
	wire fullProc60South;
	wire [31:0] dataOutProc60South;

	 //Processor 60 control and data signals
	wire rdProc60East;
	wire emptyProc60East;
	wire [31:0] dataInProc60East;

	 //Processor 61 control and data signals
	wire rdProc61South;
	wire emptyProc61South;
	wire [31:0] dataInProc61South;

	 //Processor 61 control and data signals
	wire wrProc61East;
	wire fullProc61East;
	wire [31:0] dataOutProc61East;

	 //Processor 61 control and data signals
	wire wrProc61West;
	wire fullProc61West;
	wire [31:0] dataOutProc61West;

	 //Processor 62 control and data signals
	wire rdProc62North;
	wire emptyProc62North;
	wire [31:0] dataInProc62North;

	 //Processor 62 control and data signals
	wire wrProc62North;
	wire fullProc62North;
	wire [31:0] dataOutProc62North;

	 //Processor 62 control and data signals
	wire rdProc62South;
	wire emptyProc62South;
	wire [31:0] dataInProc62South;

	 //Processor 62 control and data signals
	wire wrProc62South;
	wire fullProc62South;
	wire [31:0] dataOutProc62South;

	 //Processor 62 control and data signals
	wire wrProc62East;
	wire fullProc62East;
	wire [31:0] dataOutProc62East;

	 //Processor 62 control and data signals
	wire rdProc62West;
	wire emptyProc62West;
	wire [31:0] dataInProc62West;

	 //Processor 63 control and data signals
	wire rdProc63North;
	wire emptyProc63North;
	wire [31:0] dataInProc63North;

	 //Processor 63 control and data signals
	wire wrProc63North;
	wire fullProc63North;
	wire [31:0] dataOutProc63North;

	 //Processor 63 control and data signals
	wire rdProc63South;
	wire emptyProc63South;
	wire [31:0] dataInProc63South;

	 //Processor 63 control and data signals
	wire wrProc63South;
	wire fullProc63South;
	wire [31:0] dataOutProc63South;

	 //Processor 63 control and data signals
	wire wrProc63East;
	wire fullProc63East;
	wire [31:0] dataOutProc63East;

	 //Processor 63 control and data signals
	wire rdProc63West;
	wire emptyProc63West;
	wire [31:0] dataInProc63West;

	 //Processor 64 control and data signals
	wire wrProc64South;
	wire fullProc64South;
	wire [31:0] dataOutProc64South;

	 //Processor 64 control and data signals
	wire rdProc64East;
	wire emptyProc64East;
	wire [31:0] dataInProc64East;

	 //Processor 64 control and data signals
	wire wrProc64East;
	wire fullProc64East;
	wire [31:0] dataOutProc64East;

	 //Processor 64 control and data signals
	wire rdProc64West;
	wire emptyProc64West;
	wire [31:0] dataInProc64West;

	 //Processor 65 control and data signals
	wire rdProc65West;
	wire emptyProc65West;
	wire [31:0] dataInProc65West;

	 //Processor 65 control and data signals
	wire wrProc65West;
	wire fullProc65West;
	wire [31:0] dataOutProc65West;

	 //Processor 66 control and data signals
	wire rdProc66South;
	wire emptyProc66South;
	wire [31:0] dataInProc66South;

	 //Processor 66 control and data signals
	wire wrProc66East;
	wire fullProc66East;
	wire [31:0] dataOutProc66East;

	 //Processor 67 control and data signals
	wire rdProc67North;
	wire emptyProc67North;
	wire [31:0] dataInProc67North;

	 //Processor 67 control and data signals
	wire wrProc67South;
	wire fullProc67South;
	wire [31:0] dataOutProc67South;

	 //Processor 67 control and data signals
	wire wrProc67East;
	wire fullProc67East;
	wire [31:0] dataOutProc67East;

	 //Processor 67 control and data signals
	wire rdProc67West;
	wire emptyProc67West;
	wire [31:0] dataInProc67West;

	 //Processor 68 control and data signals
	wire rdProc68North;
	wire emptyProc68North;
	wire [31:0] dataInProc68North;

	 //Processor 68 control and data signals
	wire wrProc68South;
	wire fullProc68South;
	wire [31:0] dataOutProc68South;

	 //Processor 68 control and data signals
	wire wrProc68East;
	wire fullProc68East;
	wire [31:0] dataOutProc68East;

	 //Processor 68 control and data signals
	wire rdProc68West;
	wire emptyProc68West;
	wire [31:0] dataInProc68West;

	 //Processor 69 control and data signals
	wire wrProc69North;
	wire fullProc69North;
	wire [31:0] dataOutProc69North;

	 //Processor 69 control and data signals
	wire rdProc69South;
	wire emptyProc69South;
	wire [31:0] dataInProc69South;

	 //Processor 69 control and data signals
	wire rdProc69West;
	wire emptyProc69West;
	wire [31:0] dataInProc69West;

	 //Processor 70 control and data signals
	wire rdProc70North;
	wire emptyProc70North;
	wire [31:0] dataInProc70North;

	 //Processor 70 control and data signals
	wire wrProc70South;
	wire fullProc70South;
	wire [31:0] dataOutProc70South;

	 //Processor 71 control and data signals
	wire wrProc71North;
	wire fullProc71North;
	wire [31:0] dataOutProc71North;

	 //Processor 71 control and data signals
	wire rdProc71South;
	wire emptyProc71South;
	wire [31:0] dataInProc71South;

	 //Processor 72 control and data signals
	wire rdProc72North;
	wire emptyProc72North;
	wire [31:0] dataInProc72North;

	 //Processor 72 control and data signals
	wire wrProc72North;
	wire fullProc72North;
	wire [31:0] dataOutProc72North;

	 //Processor 72 control and data signals
	wire rdProc72East;
	wire emptyProc72East;
	wire [31:0] dataInProc72East;

	 //Processor 72 control and data signals
	wire wrProc72East;
	wire fullProc72East;
	wire [31:0] dataOutProc72East;

	 //Processor 73 control and data signals
	wire rdProc73North;
	wire emptyProc73North;
	wire [31:0] dataInProc73North;

	 //Processor 73 control and data signals
	wire wrProc73North;
	wire fullProc73North;
	wire [31:0] dataOutProc73North;

	 //Processor 73 control and data signals
	wire wrProc73South;
	wire fullProc73South;
	wire [31:0] dataOutProc73South;

	 //Processor 73 control and data signals
	wire rdProc73East;
	wire emptyProc73East;
	wire [31:0] dataInProc73East;

	 //Processor 73 control and data signals
	wire rdProc73West;
	wire emptyProc73West;
	wire [31:0] dataInProc73West;

	 //Processor 73 control and data signals
	wire wrProc73West;
	wire fullProc73West;
	wire [31:0] dataOutProc73West;

	 //Processor 74 control and data signals
	wire rdProc74North;
	wire emptyProc74North;
	wire [31:0] dataInProc74North;

	 //Processor 74 control and data signals
	wire rdProc74South;
	wire emptyProc74South;
	wire [31:0] dataInProc74South;

	 //Processor 74 control and data signals
	wire wrProc74South;
	wire fullProc74South;
	wire [31:0] dataOutProc74South;

	 //Processor 74 control and data signals
	wire rdProc74East;
	wire emptyProc74East;
	wire [31:0] dataInProc74East;

	 //Processor 74 control and data signals
	wire wrProc74East;
	wire fullProc74East;
	wire [31:0] dataOutProc74East;

	 //Processor 74 control and data signals
	wire wrProc74West;
	wire fullProc74West;
	wire [31:0] dataOutProc74West;

	 //Processor 75 control and data signals
	wire rdProc75East;
	wire emptyProc75East;
	wire [31:0] dataInProc75East;

	 //Processor 75 control and data signals
	wire wrProc75East;
	wire fullProc75East;
	wire [31:0] dataOutProc75East;

	 //Processor 75 control and data signals
	wire rdProc75West;
	wire emptyProc75West;
	wire [31:0] dataInProc75West;

	 //Processor 75 control and data signals
	wire wrProc75West;
	wire fullProc75West;
	wire [31:0] dataOutProc75West;

	 //Processor 76 control and data signals
	wire wrProc76North;
	wire fullProc76North;
	wire [31:0] dataOutProc76North;

	 //Processor 76 control and data signals
	wire rdProc76South;
	wire emptyProc76South;
	wire [31:0] dataInProc76South;

	 //Processor 76 control and data signals
	wire rdProc76West;
	wire emptyProc76West;
	wire [31:0] dataInProc76West;

	 //Processor 76 control and data signals
	wire wrProc76West;
	wire fullProc76West;
	wire [31:0] dataOutProc76West;

	 //Processor 77 control and data signals
	wire rdProc77North;
	wire emptyProc77North;
	wire [31:0] dataInProc77North;

	 //Processor 77 control and data signals
	wire wrProc77South;
	wire fullProc77South;
	wire [31:0] dataOutProc77South;

	 //Processor 77 control and data signals
	wire rdProc77East;
	wire emptyProc77East;
	wire [31:0] dataInProc77East;

	 //Processor 78 control and data signals
	wire rdProc78North;
	wire emptyProc78North;
	wire [31:0] dataInProc78North;

	 //Processor 78 control and data signals
	wire wrProc78West;
	wire fullProc78West;
	wire [31:0] dataOutProc78West;

	 //Processor 79 control and data signals
	wire wrProc79North;
	wire fullProc79North;
	wire [31:0] dataOutProc79North;

	 //Processor 79 control and data signals
	wire rdProc79South;
	wire emptyProc79South;
	wire [31:0] dataInProc79South;

	 //Processor 80 control and data signals
	wire rdProc80North;
	wire emptyProc80North;
	wire [31:0] dataInProc80North;

	 //Processor 80 control and data signals
	wire wrProc80East;
	wire fullProc80East;
	wire [31:0] dataOutProc80East;

	 //Processor 81 control and data signals
	wire wrProc81North;
	wire fullProc81North;
	wire [31:0] dataOutProc81North;

	 //Processor 81 control and data signals
	wire rdProc81East;
	wire emptyProc81East;
	wire [31:0] dataInProc81East;

	 //Processor 81 control and data signals
	wire wrProc81East;
	wire fullProc81East;
	wire [31:0] dataOutProc81East;

	 //Processor 81 control and data signals
	wire rdProc81West;
	wire emptyProc81West;
	wire [31:0] dataInProc81West;

	 //Processor 82 control and data signals
	wire rdProc82East;
	wire emptyProc82East;
	wire [31:0] dataInProc82East;

	 //Processor 82 control and data signals
	wire wrProc82East;
	wire fullProc82East;
	wire [31:0] dataOutProc82East;

	 //Processor 82 control and data signals
	wire rdProc82West;
	wire emptyProc82West;
	wire [31:0] dataInProc82West;

	 //Processor 82 control and data signals
	wire wrProc82West;
	wire fullProc82West;
	wire [31:0] dataOutProc82West;

	 //Processor 83 control and data signals
	wire rdProc83North;
	wire emptyProc83North;
	wire [31:0] dataInProc83North;

	 //Processor 83 control and data signals
	wire rdProc83East;
	wire emptyProc83East;
	wire [31:0] dataInProc83East;

	 //Processor 83 control and data signals
	wire wrProc83East;
	wire fullProc83East;
	wire [31:0] dataOutProc83East;

	 //Processor 83 control and data signals
	wire rdProc83West;
	wire emptyProc83West;
	wire [31:0] dataInProc83West;

	 //Processor 83 control and data signals
	wire wrProc83West;
	wire fullProc83West;
	wire [31:0] dataOutProc83West;

	 //Processor 84 control and data signals
	wire rdProc84North;
	wire emptyProc84North;
	wire [31:0] dataInProc84North;

	 //Processor 84 control and data signals
	wire wrProc84North;
	wire fullProc84North;
	wire [31:0] dataOutProc84North;

	 //Processor 84 control and data signals
	wire rdProc84East;
	wire emptyProc84East;
	wire [31:0] dataInProc84East;

	 //Processor 84 control and data signals
	wire wrProc84East;
	wire fullProc84East;
	wire [31:0] dataOutProc84East;

	 //Processor 84 control and data signals
	wire rdProc84West;
	wire emptyProc84West;
	wire [31:0] dataInProc84West;

	 //Processor 84 control and data signals
	wire wrProc84West;
	wire fullProc84West;
	wire [31:0] dataOutProc84West;

	 //Processor 85 control and data signals
	wire rdProc85West;
	wire emptyProc85West;
	wire [31:0] dataInProc85West;

	 //Processor 85 control and data signals
	wire wrProc85West;
	wire fullProc85West;
	wire [31:0] dataOutProc85West;

	 //Processor 86 control and data signals
	wire wrProc86North;
	wire fullProc86North;
	wire [31:0] dataOutProc86North;

	 //Processor 86 control and data signals
	wire rdProc86East;
	wire emptyProc86East;
	wire [31:0] dataInProc86East;

	 //Processor 87 control and data signals
	wire rdProc87North;
	wire emptyProc87North;
	wire [31:0] dataInProc87North;

	 //Processor 87 control and data signals
	wire wrProc87East;
	wire fullProc87East;
	wire [31:0] dataOutProc87East;

	 //Processor 87 control and data signals
	wire wrProc87West;
	wire fullProc87West;
	wire [31:0] dataOutProc87West;

	 //Processor 88 control and data signals
	wire wrProc88East;
	wire fullProc88East;
	wire [31:0] dataOutProc88East;

	 //Processor 88 control and data signals
	wire rdProc88West;
	wire emptyProc88West;
	wire [31:0] dataInProc88West;

	 //Processor 89 control and data signals
	wire wrProc89North;
	wire fullProc89North;
	wire [31:0] dataOutProc89North;

	 //Processor 89 control and data signals
	wire rdProc89West;
	wire emptyProc89West;
	wire [31:0] dataInProc89West;



//PROCESSOR 0
system proc0(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe0),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe0),
	.wrSouth(wrProc0South),
	.fullSouth(fullProc0South),
	.dataOutSouth(dataOutProc0South),
	.wrEast(wrProc0East),
	.fullEast(fullProc0East),
	.dataOutEast(dataOutProc0East));

//PROCESSOR 1
system proc1(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe1),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe1),
	.wrSouth(wrProc1South),
	.fullSouth(fullProc1South),
	.dataOutSouth(dataOutProc1South),
	.rdWest(rdProc1West),
	.emptyWest(emptyProc1West),
	.dataInWest(dataInProc1West));

//PROCESSOR 2
system proc2(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe2),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe2));

//PROCESSOR 3
system proc3(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe3),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe3));

//PROCESSOR 4
system proc4(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe4),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe4),
	.rdSouth(rdProc4South),
	.emptySouth(emptyProc4South),
	.dataInSouth(dataInProc4South),
	.rdEast(rdProc4East),
	.emptyEast(emptyProc4East),
	.dataInEast(dataInProc4East),
	.wrEast(wrProc4East),
	.fullEast(fullProc4East),
	.dataOutEast(dataOutProc4East));

//PROCESSOR 5
system proc5(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe5),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe5),
	.rdEast(rdProc5East),
	.emptyEast(emptyProc5East),
	.dataInEast(dataInProc5East),
	.rdWest(rdProc5West),
	.emptyWest(emptyProc5West),
	.dataInWest(dataInProc5West),
	.wrWest(wrProc5West),
	.fullWest(fullProc5West),
	.dataOutWest(dataOutProc5West),
	.reg_file_b_readdataout(reg_file_b_readdataout));

//PROCESSOR 6
system proc6(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe6),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe6),
	.rdSouth(rdProc6South),
	.emptySouth(emptyProc6South),
	.dataInSouth(dataInProc6South),
	.wrSouth(wrProc6South),
	.fullSouth(fullProc6South),
	.dataOutSouth(dataOutProc6South),
	.rdEast(rdProc6East),
	.emptyEast(emptyProc6East),
	.dataInEast(dataInProc6East),
	.wrWest(wrProc6West),
	.fullWest(fullProc6West),
	.dataOutWest(dataOutProc6West));

//PROCESSOR 7
system proc7(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe7),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe7),
	.rdSouth(rdProc7South),
	.emptySouth(emptyProc7South),
	.dataInSouth(dataInProc7South),
	.wrWest(wrProc7West),
	.fullWest(fullProc7West),
	.dataOutWest(dataOutProc7West));

//PROCESSOR 8
system proc8(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe8),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe8),
	.rdSouth(rdProc8South),
	.emptySouth(emptyProc8South),
	.dataInSouth(dataInProc8South),
	.wrSouth(wrProc8South),
	.fullSouth(fullProc8South),
	.dataOutSouth(dataOutProc8South),
	.rdEast(rdProc8East),
	.emptyEast(emptyProc8East),
	.dataInEast(dataInProc8East));

//PROCESSOR 9
system proc9(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe9),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe9),
	.rdSouth(rdProc9South),
	.emptySouth(emptyProc9South),
	.dataInSouth(dataInProc9South),
	.wrWest(wrProc9West),
	.fullWest(fullProc9West),
	.dataOutWest(dataOutProc9West));

//PROCESSOR 10
system proc10(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe10),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe10),
	.rdNorth(rdProc10North),
	.emptyNorth(emptyProc10North),
	.dataInNorth(dataInProc10North),
	.wrEast(wrProc10East),
	.fullEast(fullProc10East),
	.dataOutEast(dataOutProc10East));

//PROCESSOR 11
system proc11(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe11),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe11),
	.rdNorth(rdProc11North),
	.emptyNorth(emptyProc11North),
	.dataInNorth(dataInProc11North),
	.wrSouth(wrProc11South),
	.fullSouth(fullProc11South),
	.dataOutSouth(dataOutProc11South),
	.rdWest(rdProc11West),
	.emptyWest(emptyProc11West),
	.dataInWest(dataInProc11West));

//PROCESSOR 12
system proc12(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe12),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe12),
	.rdSouth(rdProc12South),
	.emptySouth(emptyProc12South),
	.dataInSouth(dataInProc12South),
	.wrEast(wrProc12East),
	.fullEast(fullProc12East),
	.dataOutEast(dataOutProc12East));

//PROCESSOR 13
system proc13(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe13),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe13),
	.rdSouth(rdProc13South),
	.emptySouth(emptyProc13South),
	.dataInSouth(dataInProc13South),
	.wrEast(wrProc13East),
	.fullEast(fullProc13East),
	.dataOutEast(dataOutProc13East),
	.rdWest(rdProc13West),
	.emptyWest(emptyProc13West),
	.dataInWest(dataInProc13West));

//PROCESSOR 14
system proc14(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe14),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe14),
	.wrNorth(wrProc14North),
	.fullNorth(fullProc14North),
	.dataOutNorth(dataOutProc14North),
	.rdSouth(rdProc14South),
	.emptySouth(emptyProc14South),
	.dataInSouth(dataInProc14South),
	.wrSouth(wrProc14South),
	.fullSouth(fullProc14South),
	.dataOutSouth(dataOutProc14South),
	.wrEast(wrProc14East),
	.fullEast(fullProc14East),
	.dataOutEast(dataOutProc14East),
	.rdWest(rdProc14West),
	.emptyWest(emptyProc14West),
	.dataInWest(dataInProc14West));

//PROCESSOR 15
system proc15(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe15),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe15),
	.wrEast(wrProc15East),
	.fullEast(fullProc15East),
	.dataOutEast(dataOutProc15East),
	.rdWest(rdProc15West),
	.emptyWest(emptyProc15West),
	.dataInWest(dataInProc15West));

//PROCESSOR 16
system proc16(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe16),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe16),
	.rdNorth(rdProc16North),
	.emptyNorth(emptyProc16North),
	.dataInNorth(dataInProc16North),
	.wrNorth(wrProc16North),
	.fullNorth(fullProc16North),
	.dataOutNorth(dataOutProc16North),
	.wrSouth(wrProc16South),
	.fullSouth(fullProc16South),
	.dataOutSouth(dataOutProc16South),
	.rdWest(rdProc16West),
	.emptyWest(emptyProc16West),
	.dataInWest(dataInProc16West));

//PROCESSOR 17
system proc17(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe17),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe17),
	.wrNorth(wrProc17North),
	.fullNorth(fullProc17North),
	.dataOutNorth(dataOutProc17North),
	.rdSouth(rdProc17South),
	.emptySouth(emptyProc17South),
	.dataInSouth(dataInProc17South));

//PROCESSOR 18
system proc18(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe18),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe18),
	.rdNorth(rdProc18North),
	.emptyNorth(emptyProc18North),
	.dataInNorth(dataInProc18North),
	.wrNorth(wrProc18North),
	.fullNorth(fullProc18North),
	.dataOutNorth(dataOutProc18North),
	.wrSouth(wrProc18South),
	.fullSouth(fullProc18South),
	.dataOutSouth(dataOutProc18South));

//PROCESSOR 19
system proc19(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe19),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe19),
	.wrNorth(wrProc19North),
	.fullNorth(fullProc19North),
	.dataOutNorth(dataOutProc19North),
	.rdSouth(rdProc19South),
	.emptySouth(emptyProc19South),
	.dataInSouth(dataInProc19South),
	.wrSouth(wrProc19South),
	.fullSouth(fullProc19South),
	.dataOutSouth(dataOutProc19South));

//PROCESSOR 20
system proc20(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe20),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe20),
	.rdSouth(rdProc20South),
	.emptySouth(emptyProc20South),
	.dataInSouth(dataInProc20South),
	.wrEast(wrProc20East),
	.fullEast(fullProc20East),
	.dataOutEast(dataOutProc20East));

//PROCESSOR 21
system proc21(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe21),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe21),
	.rdNorth(rdProc21North),
	.emptyNorth(emptyProc21North),
	.dataInNorth(dataInProc21North),
	.rdSouth(rdProc21South),
	.emptySouth(emptyProc21South),
	.dataInSouth(dataInProc21South),
	.wrSouth(wrProc21South),
	.fullSouth(fullProc21South),
	.dataOutSouth(dataOutProc21South),
	.wrEast(wrProc21East),
	.fullEast(fullProc21East),
	.dataOutEast(dataOutProc21East),
	.rdWest(rdProc21West),
	.emptyWest(emptyProc21West),
	.dataInWest(dataInProc21West));

//PROCESSOR 22
system proc22(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe22),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe22),
	.wrNorth(wrProc22North),
	.fullNorth(fullProc22North),
	.dataOutNorth(dataOutProc22North),
	.rdSouth(rdProc22South),
	.emptySouth(emptyProc22South),
	.dataInSouth(dataInProc22South),
	.wrSouth(wrProc22South),
	.fullSouth(fullProc22South),
	.dataOutSouth(dataOutProc22South),
	.rdEast(rdProc22East),
	.emptyEast(emptyProc22East),
	.dataInEast(dataInProc22East),
	.wrEast(wrProc22East),
	.fullEast(fullProc22East),
	.dataOutEast(dataOutProc22East),
	.rdWest(rdProc22West),
	.emptyWest(emptyProc22West),
	.dataInWest(dataInProc22West));

//PROCESSOR 23
system proc23(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe23),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe23),
	.wrNorth(wrProc23North),
	.fullNorth(fullProc23North),
	.dataOutNorth(dataOutProc23North),
	.rdSouth(rdProc23South),
	.emptySouth(emptyProc23South),
	.dataInSouth(dataInProc23South),
	.rdEast(rdProc23East),
	.emptyEast(emptyProc23East),
	.dataInEast(dataInProc23East),
	.wrEast(wrProc23East),
	.fullEast(fullProc23East),
	.dataOutEast(dataOutProc23East),
	.rdWest(rdProc23West),
	.emptyWest(emptyProc23West),
	.dataInWest(dataInProc23West),
	.wrWest(wrProc23West),
	.fullWest(fullProc23West),
	.dataOutWest(dataOutProc23West));

//PROCESSOR 24
system proc24(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe24),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe24),
	.rdNorth(rdProc24North),
	.emptyNorth(emptyProc24North),
	.dataInNorth(dataInProc24North),
	.wrNorth(wrProc24North),
	.fullNorth(fullProc24North),
	.dataOutNorth(dataOutProc24North),
	.wrSouth(wrProc24South),
	.fullSouth(fullProc24South),
	.dataOutSouth(dataOutProc24South),
	.rdEast(rdProc24East),
	.emptyEast(emptyProc24East),
	.dataInEast(dataInProc24East),
	.wrEast(wrProc24East),
	.fullEast(fullProc24East),
	.dataOutEast(dataOutProc24East),
	.rdWest(rdProc24West),
	.emptyWest(emptyProc24West),
	.dataInWest(dataInProc24West),
	.wrWest(wrProc24West),
	.fullWest(fullProc24West),
	.dataOutWest(dataOutProc24West));

//PROCESSOR 25
system proc25(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe25),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe25),
	.rdSouth(rdProc25South),
	.emptySouth(emptyProc25South),
	.dataInSouth(dataInProc25South),
	.wrSouth(wrProc25South),
	.fullSouth(fullProc25South),
	.dataOutSouth(dataOutProc25South),
	.rdEast(rdProc25East),
	.emptyEast(emptyProc25East),
	.dataInEast(dataInProc25East),
	.wrEast(wrProc25East),
	.fullEast(fullProc25East),
	.dataOutEast(dataOutProc25East),
	.rdWest(rdProc25West),
	.emptyWest(emptyProc25West),
	.dataInWest(dataInProc25West),
	.wrWest(wrProc25West),
	.fullWest(fullProc25West),
	.dataOutWest(dataOutProc25West));

//PROCESSOR 26
system proc26(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe26),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe26),
	.rdNorth(rdProc26North),
	.emptyNorth(emptyProc26North),
	.dataInNorth(dataInProc26North),
	.wrSouth(wrProc26South),
	.fullSouth(fullProc26South),
	.dataOutSouth(dataOutProc26South),
	.wrEast(wrProc26East),
	.fullEast(fullProc26East),
	.dataOutEast(dataOutProc26East),
	.rdWest(rdProc26West),
	.emptyWest(emptyProc26West),
	.dataInWest(dataInProc26West),
	.wrWest(wrProc26West),
	.fullWest(fullProc26West),
	.dataOutWest(dataOutProc26West));

//PROCESSOR 27
system proc27(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe27),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe27),
	.wrNorth(wrProc27North),
	.fullNorth(fullProc27North),
	.dataOutNorth(dataOutProc27North),
	.wrSouth(wrProc27South),
	.fullSouth(fullProc27South),
	.dataOutSouth(dataOutProc27South),
	.rdEast(rdProc27East),
	.emptyEast(emptyProc27East),
	.dataInEast(dataInProc27East),
	.wrEast(wrProc27East),
	.fullEast(fullProc27East),
	.dataOutEast(dataOutProc27East),
	.rdWest(rdProc27West),
	.emptyWest(emptyProc27West),
	.dataInWest(dataInProc27West));

//PROCESSOR 28
system proc28(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe28),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe28),
	.rdNorth(rdProc28North),
	.emptyNorth(emptyProc28North),
	.dataInNorth(dataInProc28North),
	.wrSouth(wrProc28South),
	.fullSouth(fullProc28South),
	.dataOutSouth(dataOutProc28South),
	.rdEast(rdProc28East),
	.emptyEast(emptyProc28East),
	.dataInEast(dataInProc28East),
	.rdWest(rdProc28West),
	.emptyWest(emptyProc28West),
	.dataInWest(dataInProc28West),
	.wrWest(wrProc28West),
	.fullWest(fullProc28West),
	.dataOutWest(dataOutProc28West));

//PROCESSOR 29
system proc29(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe29),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe29),
	.rdNorth(rdProc29North),
	.emptyNorth(emptyProc29North),
	.dataInNorth(dataInProc29North),
	.wrNorth(wrProc29North),
	.fullNorth(fullProc29North),
	.dataOutNorth(dataOutProc29North),
	.rdSouth(rdProc29South),
	.emptySouth(emptyProc29South),
	.dataInSouth(dataInProc29South),
	.wrWest(wrProc29West),
	.fullWest(fullProc29West),
	.dataOutWest(dataOutProc29West));

//PROCESSOR 30
system proc30(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe30),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe30),
	.wrNorth(wrProc30North),
	.fullNorth(fullProc30North),
	.dataOutNorth(dataOutProc30North),
	.rdSouth(rdProc30South),
	.emptySouth(emptyProc30South),
	.dataInSouth(dataInProc30South));

//PROCESSOR 31
system proc31(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe31),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe31),
	.rdNorth(rdProc31North),
	.emptyNorth(emptyProc31North),
	.dataInNorth(dataInProc31North),
	.wrNorth(wrProc31North),
	.fullNorth(fullProc31North),
	.dataOutNorth(dataOutProc31North));

//PROCESSOR 32
system proc32(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe32),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe32),
	.rdNorth(rdProc32North),
	.emptyNorth(emptyProc32North),
	.dataInNorth(dataInProc32North),
	.wrNorth(wrProc32North),
	.fullNorth(fullProc32North),
	.dataOutNorth(dataOutProc32North));

//PROCESSOR 33
system proc33(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe33),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe33),
	.wrNorth(wrProc33North),
	.fullNorth(fullProc33North),
	.dataOutNorth(dataOutProc33North),
	.rdSouth(rdProc33South),
	.emptySouth(emptyProc33South),
	.dataInSouth(dataInProc33South),
	.wrSouth(wrProc33South),
	.fullSouth(fullProc33South),
	.dataOutSouth(dataOutProc33South),
	.rdEast(rdProc33East),
	.emptyEast(emptyProc33East),
	.dataInEast(dataInProc33East));

//PROCESSOR 34
system proc34(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe34),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe34),
	.rdNorth(rdProc34North),
	.emptyNorth(emptyProc34North),
	.dataInNorth(dataInProc34North),
	.wrWest(wrProc34West),
	.fullWest(fullProc34West),
	.dataOutWest(dataOutProc34West));

//PROCESSOR 35
system proc35(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe35),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe35),
	.rdNorth(rdProc35North),
	.emptyNorth(emptyProc35North),
	.dataInNorth(dataInProc35North),
	.wrNorth(wrProc35North),
	.fullNorth(fullProc35North),
	.dataOutNorth(dataOutProc35North),
	.rdSouth(rdProc35South),
	.emptySouth(emptyProc35South),
	.dataInSouth(dataInProc35South),
	.wrEast(wrProc35East),
	.fullEast(fullProc35East),
	.dataOutEast(dataOutProc35East));

//PROCESSOR 36
system proc36(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe36),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe36),
	.rdNorth(rdProc36North),
	.emptyNorth(emptyProc36North),
	.dataInNorth(dataInProc36North),
	.wrSouth(wrProc36South),
	.fullSouth(fullProc36South),
	.dataOutSouth(dataOutProc36South),
	.wrEast(wrProc36East),
	.fullEast(fullProc36East),
	.dataOutEast(dataOutProc36East),
	.rdWest(rdProc36West),
	.emptyWest(emptyProc36West),
	.dataInWest(dataInProc36West));

//PROCESSOR 37
system proc37(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe37),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe37),
	.rdNorth(rdProc37North),
	.emptyNorth(emptyProc37North),
	.dataInNorth(dataInProc37North),
	.wrSouth(wrProc37South),
	.fullSouth(fullProc37South),
	.dataOutSouth(dataOutProc37South),
	.rdWest(rdProc37West),
	.emptyWest(emptyProc37West),
	.dataInWest(dataInProc37West));

//PROCESSOR 38
system proc38(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe38),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe38),
	.rdNorth(rdProc38North),
	.emptyNorth(emptyProc38North),
	.dataInNorth(dataInProc38North),
	.rdSouth(rdProc38South),
	.emptySouth(emptyProc38South),
	.dataInSouth(dataInProc38South),
	.wrSouth(wrProc38South),
	.fullSouth(fullProc38South),
	.dataOutSouth(dataOutProc38South),
	.wrEast(wrProc38East),
	.fullEast(fullProc38East),
	.dataOutEast(dataOutProc38East));

//PROCESSOR 39
system proc39(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe39),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe39),
	.wrNorth(wrProc39North),
	.fullNorth(fullProc39North),
	.dataOutNorth(dataOutProc39North),
	.rdSouth(rdProc39South),
	.emptySouth(emptyProc39South),
	.dataInSouth(dataInProc39South),
	.rdWest(rdProc39West),
	.emptyWest(emptyProc39West),
	.dataInWest(dataInProc39West));

//PROCESSOR 40
system proc40(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe40),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe40),
	.wrNorth(wrProc40North),
	.fullNorth(fullProc40North),
	.dataOutNorth(dataOutProc40North),
	.rdSouth(rdProc40South),
	.emptySouth(emptyProc40South),
	.dataInSouth(dataInProc40South),
	.wrSouth(wrProc40South),
	.fullSouth(fullProc40South),
	.dataOutSouth(dataOutProc40South),
	.rdEast(rdProc40East),
	.emptyEast(emptyProc40East),
	.dataInEast(dataInProc40East));

//PROCESSOR 41
system proc41(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe41),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe41),
	.rdEast(rdProc41East),
	.emptyEast(emptyProc41East),
	.dataInEast(dataInProc41East),
	.wrWest(wrProc41West),
	.fullWest(fullProc41West),
	.dataOutWest(dataOutProc41West));

//PROCESSOR 42
system proc42(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe42),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe42),
	.rdSouth(rdProc42South),
	.emptySouth(emptyProc42South),
	.dataInSouth(dataInProc42South),
	.rdEast(rdProc42East),
	.emptyEast(emptyProc42East),
	.dataInEast(dataInProc42East),
	.wrEast(wrProc42East),
	.fullEast(fullProc42East),
	.dataOutEast(dataOutProc42East),
	.wrWest(wrProc42West),
	.fullWest(fullProc42West),
	.dataOutWest(dataOutProc42West));

//PROCESSOR 43
system proc43(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe43),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe43),
	.rdNorth(rdProc43North),
	.emptyNorth(emptyProc43North),
	.dataInNorth(dataInProc43North),
	.wrNorth(wrProc43North),
	.fullNorth(fullProc43North),
	.dataOutNorth(dataOutProc43North),
	.rdSouth(rdProc43South),
	.emptySouth(emptyProc43South),
	.dataInSouth(dataInProc43South),
	.wrSouth(wrProc43South),
	.fullSouth(fullProc43South),
	.dataOutSouth(dataOutProc43South),
	.wrEast(wrProc43East),
	.fullEast(fullProc43East),
	.dataOutEast(dataOutProc43East),
	.rdWest(rdProc43West),
	.emptyWest(emptyProc43West),
	.dataInWest(dataInProc43West),
	.wrWest(wrProc43West),
	.fullWest(fullProc43West),
	.dataOutWest(dataOutProc43West));

//PROCESSOR 44
system proc44(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe44),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe44),
	.wrEast(wrProc44East),
	.fullEast(fullProc44East),
	.dataOutEast(dataOutProc44East),
	.rdWest(rdProc44West),
	.emptyWest(emptyProc44West),
	.dataInWest(dataInProc44West));

//PROCESSOR 45
system proc45(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe45),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe45),
	.wrNorth(wrProc45North),
	.fullNorth(fullProc45North),
	.dataOutNorth(dataOutProc45North),
	.wrSouth(wrProc45South),
	.fullSouth(fullProc45South),
	.dataOutSouth(dataOutProc45South),
	.rdEast(rdProc45East),
	.emptyEast(emptyProc45East),
	.dataInEast(dataInProc45East),
	.rdWest(rdProc45West),
	.emptyWest(emptyProc45West),
	.dataInWest(dataInProc45West));

//PROCESSOR 46
system proc46(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe46),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe46),
	.rdNorth(rdProc46North),
	.emptyNorth(emptyProc46North),
	.dataInNorth(dataInProc46North),
	.wrSouth(wrProc46South),
	.fullSouth(fullProc46South),
	.dataOutSouth(dataOutProc46South),
	.rdEast(rdProc46East),
	.emptyEast(emptyProc46East),
	.dataInEast(dataInProc46East),
	.wrWest(wrProc46West),
	.fullWest(fullProc46West),
	.dataOutWest(dataOutProc46West));

//PROCESSOR 47
system proc47(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe47),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe47),
	.rdNorth(rdProc47North),
	.emptyNorth(emptyProc47North),
	.dataInNorth(dataInProc47North),
	.wrSouth(wrProc47South),
	.fullSouth(fullProc47South),
	.dataOutSouth(dataOutProc47South),
	.wrWest(wrProc47West),
	.fullWest(fullProc47West),
	.dataOutWest(dataOutProc47West));

//PROCESSOR 48
system proc48(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe48),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe48),
	.rdNorth(rdProc48North),
	.emptyNorth(emptyProc48North),
	.dataInNorth(dataInProc48North),
	.wrNorth(wrProc48North),
	.fullNorth(fullProc48North),
	.dataOutNorth(dataOutProc48North),
	.rdSouth(rdProc48South),
	.emptySouth(emptyProc48South),
	.dataInSouth(dataInProc48South),
	.wrSouth(wrProc48South),
	.fullSouth(fullProc48South),
	.dataOutSouth(dataOutProc48South));

//PROCESSOR 49
system proc49(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe49),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe49),
	.wrNorth(wrProc49North),
	.fullNorth(fullProc49North),
	.dataOutNorth(dataOutProc49North),
	.rdSouth(rdProc49South),
	.emptySouth(emptyProc49South),
	.dataInSouth(dataInProc49South));

//PROCESSOR 50
system proc50(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe50),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe50),
	.rdNorth(rdProc50North),
	.emptyNorth(emptyProc50North),
	.dataInNorth(dataInProc50North),
	.wrNorth(wrProc50North),
	.fullNorth(fullProc50North),
	.dataOutNorth(dataOutProc50North),
	.rdEast(rdProc50East),
	.emptyEast(emptyProc50East),
	.dataInEast(dataInProc50East),
	.wrEast(wrProc50East),
	.fullEast(fullProc50East),
	.dataOutEast(dataOutProc50East));

//PROCESSOR 51
system proc51(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe51),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe51),
	.rdEast(rdProc51East),
	.emptyEast(emptyProc51East),
	.dataInEast(dataInProc51East),
	.wrEast(wrProc51East),
	.fullEast(fullProc51East),
	.dataOutEast(dataOutProc51East),
	.rdWest(rdProc51West),
	.emptyWest(emptyProc51West),
	.dataInWest(dataInProc51West),
	.wrWest(wrProc51West),
	.fullWest(fullProc51West),
	.dataOutWest(dataOutProc51West));

//PROCESSOR 52
system proc52(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe52),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe52),
	.wrNorth(wrProc52North),
	.fullNorth(fullProc52North),
	.dataOutNorth(dataOutProc52North),
	.rdSouth(rdProc52South),
	.emptySouth(emptyProc52South),
	.dataInSouth(dataInProc52South),
	.wrSouth(wrProc52South),
	.fullSouth(fullProc52South),
	.dataOutSouth(dataOutProc52South),
	.rdEast(rdProc52East),
	.emptyEast(emptyProc52East),
	.dataInEast(dataInProc52East),
	.wrEast(wrProc52East),
	.fullEast(fullProc52East),
	.dataOutEast(dataOutProc52East),
	.rdWest(rdProc52West),
	.emptyWest(emptyProc52West),
	.dataInWest(dataInProc52West),
	.wrWest(wrProc52West),
	.fullWest(fullProc52West),
	.dataOutWest(dataOutProc52West));

//PROCESSOR 53
system proc53(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe53),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe53),
	.rdNorth(rdProc53North),
	.emptyNorth(emptyProc53North),
	.dataInNorth(dataInProc53North),
	.wrNorth(wrProc53North),
	.fullNorth(fullProc53North),
	.dataOutNorth(dataOutProc53North),
	.rdSouth(rdProc53South),
	.emptySouth(emptyProc53South),
	.dataInSouth(dataInProc53South),
	.wrSouth(wrProc53South),
	.fullSouth(fullProc53South),
	.dataOutSouth(dataOutProc53South),
	.rdEast(rdProc53East),
	.emptyEast(emptyProc53East),
	.dataInEast(dataInProc53East),
	.rdWest(rdProc53West),
	.emptyWest(emptyProc53West),
	.dataInWest(dataInProc53West),
	.wrWest(wrProc53West),
	.fullWest(fullProc53West),
	.dataOutWest(dataOutProc53West));

//PROCESSOR 54
system proc54(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe54),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe54),
	.rdEast(rdProc54East),
	.emptyEast(emptyProc54East),
	.dataInEast(dataInProc54East),
	.wrWest(wrProc54West),
	.fullWest(fullProc54West),
	.dataOutWest(dataOutProc54West));

//PROCESSOR 55
system proc55(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe55),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe55),
	.rdNorth(rdProc55North),
	.emptyNorth(emptyProc55North),
	.dataInNorth(dataInProc55North),
	.rdEast(rdProc55East),
	.emptyEast(emptyProc55East),
	.dataInEast(dataInProc55East),
	.wrWest(wrProc55West),
	.fullWest(fullProc55West),
	.dataOutWest(dataOutProc55West));

//PROCESSOR 56
system proc56(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe56),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe56),
	.rdNorth(rdProc56North),
	.emptyNorth(emptyProc56North),
	.dataInNorth(dataInProc56North),
	.rdEast(rdProc56East),
	.emptyEast(emptyProc56East),
	.dataInEast(dataInProc56East),
	.wrEast(wrProc56East),
	.fullEast(fullProc56East),
	.dataOutEast(dataOutProc56East),
	.wrWest(wrProc56West),
	.fullWest(fullProc56West),
	.dataOutWest(dataOutProc56West));

//PROCESSOR 57
system proc57(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe57),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe57),
	.rdNorth(rdProc57North),
	.emptyNorth(emptyProc57North),
	.dataInNorth(dataInProc57North),
	.wrSouth(wrProc57South),
	.fullSouth(fullProc57South),
	.dataOutSouth(dataOutProc57South),
	.rdWest(rdProc57West),
	.emptyWest(emptyProc57West),
	.dataInWest(dataInProc57West),
	.wrWest(wrProc57West),
	.fullWest(fullProc57West),
	.dataOutWest(dataOutProc57West));

//PROCESSOR 58
system proc58(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe58),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe58),
	.rdNorth(rdProc58North),
	.emptyNorth(emptyProc58North),
	.dataInNorth(dataInProc58North),
	.wrNorth(wrProc58North),
	.fullNorth(fullProc58North),
	.dataOutNorth(dataOutProc58North),
	.wrSouth(wrProc58South),
	.fullSouth(fullProc58South),
	.dataOutSouth(dataOutProc58South),
	.rdEast(rdProc58East),
	.emptyEast(emptyProc58East),
	.dataInEast(dataInProc58East));

//PROCESSOR 59
system proc59(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe59),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe59),
	.wrNorth(wrProc59North),
	.fullNorth(fullProc59North),
	.dataOutNorth(dataOutProc59North),
	.rdSouth(rdProc59South),
	.emptySouth(emptyProc59South),
	.dataInSouth(dataInProc59South),
	.wrWest(wrProc59West),
	.fullWest(fullProc59West),
	.dataOutWest(dataOutProc59West));

//PROCESSOR 60
system proc60(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe60),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe60),
	.wrSouth(wrProc60South),
	.fullSouth(fullProc60South),
	.dataOutSouth(dataOutProc60South),
	.rdEast(rdProc60East),
	.emptyEast(emptyProc60East),
	.dataInEast(dataInProc60East));

//PROCESSOR 61
system proc61(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe61),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe61),
	.rdSouth(rdProc61South),
	.emptySouth(emptyProc61South),
	.dataInSouth(dataInProc61South),
	.wrEast(wrProc61East),
	.fullEast(fullProc61East),
	.dataOutEast(dataOutProc61East),
	.wrWest(wrProc61West),
	.fullWest(fullProc61West),
	.dataOutWest(dataOutProc61West));

//PROCESSOR 62
system proc62(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe62),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe62),
	.rdNorth(rdProc62North),
	.emptyNorth(emptyProc62North),
	.dataInNorth(dataInProc62North),
	.wrNorth(wrProc62North),
	.fullNorth(fullProc62North),
	.dataOutNorth(dataOutProc62North),
	.rdSouth(rdProc62South),
	.emptySouth(emptyProc62South),
	.dataInSouth(dataInProc62South),
	.wrSouth(wrProc62South),
	.fullSouth(fullProc62South),
	.dataOutSouth(dataOutProc62South),
	.wrEast(wrProc62East),
	.fullEast(fullProc62East),
	.dataOutEast(dataOutProc62East),
	.rdWest(rdProc62West),
	.emptyWest(emptyProc62West),
	.dataInWest(dataInProc62West));

//PROCESSOR 63
system proc63(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe63),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe63),
	.rdNorth(rdProc63North),
	.emptyNorth(emptyProc63North),
	.dataInNorth(dataInProc63North),
	.wrNorth(wrProc63North),
	.fullNorth(fullProc63North),
	.dataOutNorth(dataOutProc63North),
	.rdSouth(rdProc63South),
	.emptySouth(emptyProc63South),
	.dataInSouth(dataInProc63South),
	.wrSouth(wrProc63South),
	.fullSouth(fullProc63South),
	.dataOutSouth(dataOutProc63South),
	.wrEast(wrProc63East),
	.fullEast(fullProc63East),
	.dataOutEast(dataOutProc63East),
	.rdWest(rdProc63West),
	.emptyWest(emptyProc63West),
	.dataInWest(dataInProc63West));

//PROCESSOR 64
system proc64(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe64),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe64),
	.wrSouth(wrProc64South),
	.fullSouth(fullProc64South),
	.dataOutSouth(dataOutProc64South),
	.rdEast(rdProc64East),
	.emptyEast(emptyProc64East),
	.dataInEast(dataInProc64East),
	.wrEast(wrProc64East),
	.fullEast(fullProc64East),
	.dataOutEast(dataOutProc64East),
	.rdWest(rdProc64West),
	.emptyWest(emptyProc64West),
	.dataInWest(dataInProc64West));

//PROCESSOR 65
system proc65(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe65),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe65),
	.rdWest(rdProc65West),
	.emptyWest(emptyProc65West),
	.dataInWest(dataInProc65West),
	.wrWest(wrProc65West),
	.fullWest(fullProc65West),
	.dataOutWest(dataOutProc65West));

//PROCESSOR 66
system proc66(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe66),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe66),
	.rdSouth(rdProc66South),
	.emptySouth(emptyProc66South),
	.dataInSouth(dataInProc66South),
	.wrEast(wrProc66East),
	.fullEast(fullProc66East),
	.dataOutEast(dataOutProc66East));

//PROCESSOR 67
system proc67(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe67),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe67),
	.rdNorth(rdProc67North),
	.emptyNorth(emptyProc67North),
	.dataInNorth(dataInProc67North),
	.wrSouth(wrProc67South),
	.fullSouth(fullProc67South),
	.dataOutSouth(dataOutProc67South),
	.wrEast(wrProc67East),
	.fullEast(fullProc67East),
	.dataOutEast(dataOutProc67East),
	.rdWest(rdProc67West),
	.emptyWest(emptyProc67West),
	.dataInWest(dataInProc67West));

//PROCESSOR 68
system proc68(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe68),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe68),
	.rdNorth(rdProc68North),
	.emptyNorth(emptyProc68North),
	.dataInNorth(dataInProc68North),
	.wrSouth(wrProc68South),
	.fullSouth(fullProc68South),
	.dataOutSouth(dataOutProc68South),
	.wrEast(wrProc68East),
	.fullEast(fullProc68East),
	.dataOutEast(dataOutProc68East),
	.rdWest(rdProc68West),
	.emptyWest(emptyProc68West),
	.dataInWest(dataInProc68West));

//PROCESSOR 69
system proc69(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe69),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe69),
	.wrNorth(wrProc69North),
	.fullNorth(fullProc69North),
	.dataOutNorth(dataOutProc69North),
	.rdSouth(rdProc69South),
	.emptySouth(emptyProc69South),
	.dataInSouth(dataInProc69South),
	.rdWest(rdProc69West),
	.emptyWest(emptyProc69West),
	.dataInWest(dataInProc69West));

//PROCESSOR 70
system proc70(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe70),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe70),
	.rdNorth(rdProc70North),
	.emptyNorth(emptyProc70North),
	.dataInNorth(dataInProc70North),
	.wrSouth(wrProc70South),
	.fullSouth(fullProc70South),
	.dataOutSouth(dataOutProc70South));

//PROCESSOR 71
system proc71(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe71),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe71),
	.wrNorth(wrProc71North),
	.fullNorth(fullProc71North),
	.dataOutNorth(dataOutProc71North),
	.rdSouth(rdProc71South),
	.emptySouth(emptyProc71South),
	.dataInSouth(dataInProc71South));

//PROCESSOR 72
system proc72(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe72),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe72),
	.rdNorth(rdProc72North),
	.emptyNorth(emptyProc72North),
	.dataInNorth(dataInProc72North),
	.wrNorth(wrProc72North),
	.fullNorth(fullProc72North),
	.dataOutNorth(dataOutProc72North),
	.rdEast(rdProc72East),
	.emptyEast(emptyProc72East),
	.dataInEast(dataInProc72East),
	.wrEast(wrProc72East),
	.fullEast(fullProc72East),
	.dataOutEast(dataOutProc72East));

//PROCESSOR 73
system proc73(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe73),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe73),
	.rdNorth(rdProc73North),
	.emptyNorth(emptyProc73North),
	.dataInNorth(dataInProc73North),
	.wrNorth(wrProc73North),
	.fullNorth(fullProc73North),
	.dataOutNorth(dataOutProc73North),
	.wrSouth(wrProc73South),
	.fullSouth(fullProc73South),
	.dataOutSouth(dataOutProc73South),
	.rdEast(rdProc73East),
	.emptyEast(emptyProc73East),
	.dataInEast(dataInProc73East),
	.rdWest(rdProc73West),
	.emptyWest(emptyProc73West),
	.dataInWest(dataInProc73West),
	.wrWest(wrProc73West),
	.fullWest(fullProc73West),
	.dataOutWest(dataOutProc73West));

//PROCESSOR 74
system proc74(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe74),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe74),
	.rdNorth(rdProc74North),
	.emptyNorth(emptyProc74North),
	.dataInNorth(dataInProc74North),
	.rdSouth(rdProc74South),
	.emptySouth(emptyProc74South),
	.dataInSouth(dataInProc74South),
	.wrSouth(wrProc74South),
	.fullSouth(fullProc74South),
	.dataOutSouth(dataOutProc74South),
	.rdEast(rdProc74East),
	.emptyEast(emptyProc74East),
	.dataInEast(dataInProc74East),
	.wrEast(wrProc74East),
	.fullEast(fullProc74East),
	.dataOutEast(dataOutProc74East),
	.wrWest(wrProc74West),
	.fullWest(fullProc74West),
	.dataOutWest(dataOutProc74West));

//PROCESSOR 75
system proc75(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe75),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe75),
	.rdEast(rdProc75East),
	.emptyEast(emptyProc75East),
	.dataInEast(dataInProc75East),
	.wrEast(wrProc75East),
	.fullEast(fullProc75East),
	.dataOutEast(dataOutProc75East),
	.rdWest(rdProc75West),
	.emptyWest(emptyProc75West),
	.dataInWest(dataInProc75West),
	.wrWest(wrProc75West),
	.fullWest(fullProc75West),
	.dataOutWest(dataOutProc75West));

//PROCESSOR 76
system proc76(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe76),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe76),
	.wrNorth(wrProc76North),
	.fullNorth(fullProc76North),
	.dataOutNorth(dataOutProc76North),
	.rdSouth(rdProc76South),
	.emptySouth(emptyProc76South),
	.dataInSouth(dataInProc76South),
	.rdWest(rdProc76West),
	.emptyWest(emptyProc76West),
	.dataInWest(dataInProc76West),
	.wrWest(wrProc76West),
	.fullWest(fullProc76West),
	.dataOutWest(dataOutProc76West));

//PROCESSOR 77
system proc77(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe77),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe77),
	.rdNorth(rdProc77North),
	.emptyNorth(emptyProc77North),
	.dataInNorth(dataInProc77North),
	.wrSouth(wrProc77South),
	.fullSouth(fullProc77South),
	.dataOutSouth(dataOutProc77South),
	.rdEast(rdProc77East),
	.emptyEast(emptyProc77East),
	.dataInEast(dataInProc77East));

//PROCESSOR 78
system proc78(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe78),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe78),
	.rdNorth(rdProc78North),
	.emptyNorth(emptyProc78North),
	.dataInNorth(dataInProc78North),
	.wrWest(wrProc78West),
	.fullWest(fullProc78West),
	.dataOutWest(dataOutProc78West));

//PROCESSOR 79
system proc79(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe79),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe79),
	.wrNorth(wrProc79North),
	.fullNorth(fullProc79North),
	.dataOutNorth(dataOutProc79North),
	.rdSouth(rdProc79South),
	.emptySouth(emptyProc79South),
	.dataInSouth(dataInProc79South));

//PROCESSOR 80
system proc80(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe80),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe80),
	.rdNorth(rdProc80North),
	.emptyNorth(emptyProc80North),
	.dataInNorth(dataInProc80North),
	.wrEast(wrProc80East),
	.fullEast(fullProc80East),
	.dataOutEast(dataOutProc80East));

//PROCESSOR 81
system proc81(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe81),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe81),
	.wrNorth(wrProc81North),
	.fullNorth(fullProc81North),
	.dataOutNorth(dataOutProc81North),
	.rdEast(rdProc81East),
	.emptyEast(emptyProc81East),
	.dataInEast(dataInProc81East),
	.wrEast(wrProc81East),
	.fullEast(fullProc81East),
	.dataOutEast(dataOutProc81East),
	.rdWest(rdProc81West),
	.emptyWest(emptyProc81West),
	.dataInWest(dataInProc81West));

//PROCESSOR 82
system proc82(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe82),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe82),
	.rdEast(rdProc82East),
	.emptyEast(emptyProc82East),
	.dataInEast(dataInProc82East),
	.wrEast(wrProc82East),
	.fullEast(fullProc82East),
	.dataOutEast(dataOutProc82East),
	.rdWest(rdProc82West),
	.emptyWest(emptyProc82West),
	.dataInWest(dataInProc82West),
	.wrWest(wrProc82West),
	.fullWest(fullProc82West),
	.dataOutWest(dataOutProc82West));

//PROCESSOR 83
system proc83(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe83),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe83),
	.rdNorth(rdProc83North),
	.emptyNorth(emptyProc83North),
	.dataInNorth(dataInProc83North),
	.rdEast(rdProc83East),
	.emptyEast(emptyProc83East),
	.dataInEast(dataInProc83East),
	.wrEast(wrProc83East),
	.fullEast(fullProc83East),
	.dataOutEast(dataOutProc83East),
	.rdWest(rdProc83West),
	.emptyWest(emptyProc83West),
	.dataInWest(dataInProc83West),
	.wrWest(wrProc83West),
	.fullWest(fullProc83West),
	.dataOutWest(dataOutProc83West));

//PROCESSOR 84
system proc84(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe84),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe84),
	.rdNorth(rdProc84North),
	.emptyNorth(emptyProc84North),
	.dataInNorth(dataInProc84North),
	.wrNorth(wrProc84North),
	.fullNorth(fullProc84North),
	.dataOutNorth(dataOutProc84North),
	.rdEast(rdProc84East),
	.emptyEast(emptyProc84East),
	.dataInEast(dataInProc84East),
	.wrEast(wrProc84East),
	.fullEast(fullProc84East),
	.dataOutEast(dataOutProc84East),
	.rdWest(rdProc84West),
	.emptyWest(emptyProc84West),
	.dataInWest(dataInProc84West),
	.wrWest(wrProc84West),
	.fullWest(fullProc84West),
	.dataOutWest(dataOutProc84West));

//PROCESSOR 85
system proc85(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe85),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe85),
	.rdWest(rdProc85West),
	.emptyWest(emptyProc85West),
	.dataInWest(dataInProc85West),
	.wrWest(wrProc85West),
	.fullWest(fullProc85West),
	.dataOutWest(dataOutProc85West));

//PROCESSOR 86
system proc86(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe86),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe86),
	.wrNorth(wrProc86North),
	.fullNorth(fullProc86North),
	.dataOutNorth(dataOutProc86North),
	.rdEast(rdProc86East),
	.emptyEast(emptyProc86East),
	.dataInEast(dataInProc86East));

//PROCESSOR 87
system proc87(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe87),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe87),
	.rdNorth(rdProc87North),
	.emptyNorth(emptyProc87North),
	.dataInNorth(dataInProc87North),
	.wrEast(wrProc87East),
	.fullEast(fullProc87East),
	.dataOutEast(dataOutProc87East),
	.wrWest(wrProc87West),
	.fullWest(fullProc87West),
	.dataOutWest(dataOutProc87West));

//PROCESSOR 88
system proc88(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe88),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe88),
	.wrEast(wrProc88East),
	.fullEast(fullProc88East),
	.dataOutEast(dataOutProc88East),
	.rdWest(rdProc88West),
	.emptyWest(emptyProc88West),
	.dataInWest(dataInProc88West));

//PROCESSOR 89
system proc89(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe89),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe89),
	.wrNorth(wrProc89North),
	.fullNorth(fullProc89North),
	.dataOutNorth(dataOutProc89North),
	.rdWest(rdProc89West),
	.emptyWest(emptyProc89West),
	.dataInWest(dataInProc89West));

//FIFO 0 TO 10
fifo fifo_proc0_to_proc10(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc0South),
	.full(fullProc0South),
	.dataIn(dataOutProc0South),
	.rd(rdProc10North),
	.empty(emptyProc10North),
	.dataOut(dataInProc10North));

//FIFO 0 TO 1
fifo fifo_proc0_to_proc1(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc0East),
	.full(fullProc0East),
	.dataIn(dataOutProc0East),
	.rd(rdProc1West),
	.empty(emptyProc1West),
	.dataOut(dataInProc1West));

//FIFO 1 TO 11
fifo fifo_proc1_to_proc11(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc1South),
	.full(fullProc1South),
	.dataIn(dataOutProc1South),
	.rd(rdProc11North),
	.empty(emptyProc11North),
	.dataOut(dataInProc11North));

//FIFO 14 TO 4
fifo fifo_proc14_to_proc4(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc14North),
	.full(fullProc14North),
	.dataIn(dataOutProc14North),
	.rd(rdProc4South),
	.empty(emptyProc4South),
	.dataOut(dataInProc4South));

//FIFO 5 TO 4
fifo fifo_proc5_to_proc4(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc5West),
	.full(fullProc5West),
	.dataIn(dataOutProc5West),
	.rd(rdProc4East),
	.empty(emptyProc4East),
	.dataOut(dataInProc4East));

//FIFO 4 TO 5
fifo fifo_proc4_to_proc5(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc4East),
	.full(fullProc4East),
	.dataIn(dataOutProc4East),
	.rd(rdProc5West),
	.empty(emptyProc5West),
	.dataOut(dataInProc5West));

//FIFO 6 TO 5
fifo fifo_proc6_to_proc5(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc6West),
	.full(fullProc6West),
	.dataIn(dataOutProc6West),
	.rd(rdProc5East),
	.empty(emptyProc5East),
	.dataOut(dataInProc5East));

//FIFO 16 TO 6
fifo fifo_proc16_to_proc6(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc16North),
	.full(fullProc16North),
	.dataIn(dataOutProc16North),
	.rd(rdProc6South),
	.empty(emptyProc6South),
	.dataOut(dataInProc6South));

//FIFO 6 TO 16
fifo fifo_proc6_to_proc16(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc6South),
	.full(fullProc6South),
	.dataIn(dataOutProc6South),
	.rd(rdProc16North),
	.empty(emptyProc16North),
	.dataOut(dataInProc16North));

//FIFO 7 TO 6
fifo fifo_proc7_to_proc6(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc7West),
	.full(fullProc7West),
	.dataIn(dataOutProc7West),
	.rd(rdProc6East),
	.empty(emptyProc6East),
	.dataOut(dataInProc6East));

//FIFO 17 TO 7
fifo fifo_proc17_to_proc7(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc17North),
	.full(fullProc17North),
	.dataIn(dataOutProc17North),
	.rd(rdProc7South),
	.empty(emptyProc7South),
	.dataOut(dataInProc7South));

//FIFO 18 TO 8
fifo fifo_proc18_to_proc8(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc18North),
	.full(fullProc18North),
	.dataIn(dataOutProc18North),
	.rd(rdProc8South),
	.empty(emptyProc8South),
	.dataOut(dataInProc8South));

//FIFO 8 TO 18
fifo fifo_proc8_to_proc18(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc8South),
	.full(fullProc8South),
	.dataIn(dataOutProc8South),
	.rd(rdProc18North),
	.empty(emptyProc18North),
	.dataOut(dataInProc18North));

//FIFO 9 TO 8
fifo fifo_proc9_to_proc8(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc9West),
	.full(fullProc9West),
	.dataIn(dataOutProc9West),
	.rd(rdProc8East),
	.empty(emptyProc8East),
	.dataOut(dataInProc8East));

//FIFO 19 TO 9
fifo fifo_proc19_to_proc9(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc19North),
	.full(fullProc19North),
	.dataIn(dataOutProc19North),
	.rd(rdProc9South),
	.empty(emptyProc9South),
	.dataOut(dataInProc9South));

//FIFO 10 TO 11
fifo fifo_proc10_to_proc11(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc10East),
	.full(fullProc10East),
	.dataIn(dataOutProc10East),
	.rd(rdProc11West),
	.empty(emptyProc11West),
	.dataOut(dataInProc11West));

//FIFO 11 TO 21
fifo fifo_proc11_to_proc21(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc11South),
	.full(fullProc11South),
	.dataIn(dataOutProc11South),
	.rd(rdProc21North),
	.empty(emptyProc21North),
	.dataOut(dataInProc21North));

//FIFO 22 TO 12
fifo fifo_proc22_to_proc12(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc22North),
	.full(fullProc22North),
	.dataIn(dataOutProc22North),
	.rd(rdProc12South),
	.empty(emptyProc12South),
	.dataOut(dataInProc12South));

//FIFO 12 TO 13
fifo fifo_proc12_to_proc13(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc12East),
	.full(fullProc12East),
	.dataIn(dataOutProc12East),
	.rd(rdProc13West),
	.empty(emptyProc13West),
	.dataOut(dataInProc13West));

//FIFO 23 TO 13
fifo fifo_proc23_to_proc13(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc23North),
	.full(fullProc23North),
	.dataIn(dataOutProc23North),
	.rd(rdProc13South),
	.empty(emptyProc13South),
	.dataOut(dataInProc13South));

//FIFO 13 TO 14
fifo fifo_proc13_to_proc14(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc13East),
	.full(fullProc13East),
	.dataIn(dataOutProc13East),
	.rd(rdProc14West),
	.empty(emptyProc14West),
	.dataOut(dataInProc14West));

//FIFO 24 TO 14
fifo fifo_proc24_to_proc14(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc24North),
	.full(fullProc24North),
	.dataIn(dataOutProc24North),
	.rd(rdProc14South),
	.empty(emptyProc14South),
	.dataOut(dataInProc14South));

//FIFO 14 TO 24
fifo fifo_proc14_to_proc24(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc14South),
	.full(fullProc14South),
	.dataIn(dataOutProc14South),
	.rd(rdProc24North),
	.empty(emptyProc24North),
	.dataOut(dataInProc24North));

//FIFO 14 TO 15
fifo fifo_proc14_to_proc15(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc14East),
	.full(fullProc14East),
	.dataIn(dataOutProc14East),
	.rd(rdProc15West),
	.empty(emptyProc15West),
	.dataOut(dataInProc15West));

//FIFO 15 TO 16
fifo fifo_proc15_to_proc16(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc15East),
	.full(fullProc15East),
	.dataIn(dataOutProc15East),
	.rd(rdProc16West),
	.empty(emptyProc16West),
	.dataOut(dataInProc16West));

//FIFO 16 TO 26
fifo fifo_proc16_to_proc26(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc16South),
	.full(fullProc16South),
	.dataIn(dataOutProc16South),
	.rd(rdProc26North),
	.empty(emptyProc26North),
	.dataOut(dataInProc26North));

//FIFO 27 TO 17
fifo fifo_proc27_to_proc17(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc27North),
	.full(fullProc27North),
	.dataIn(dataOutProc27North),
	.rd(rdProc17South),
	.empty(emptyProc17South),
	.dataOut(dataInProc17South));

//FIFO 18 TO 28
fifo fifo_proc18_to_proc28(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc18South),
	.full(fullProc18South),
	.dataIn(dataOutProc18South),
	.rd(rdProc28North),
	.empty(emptyProc28North),
	.dataOut(dataInProc28North));

//FIFO 29 TO 19
fifo fifo_proc29_to_proc19(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc29North),
	.full(fullProc29North),
	.dataIn(dataOutProc29North),
	.rd(rdProc19South),
	.empty(emptyProc19South),
	.dataOut(dataInProc19South));

//FIFO 19 TO 29
fifo fifo_proc19_to_proc29(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc19South),
	.full(fullProc19South),
	.dataIn(dataOutProc19South),
	.rd(rdProc29North),
	.empty(emptyProc29North),
	.dataOut(dataInProc29North));

//FIFO 30 TO 20
fifo fifo_proc30_to_proc20(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc30North),
	.full(fullProc30North),
	.dataIn(dataOutProc30North),
	.rd(rdProc20South),
	.empty(emptyProc20South),
	.dataOut(dataInProc20South));

//FIFO 20 TO 21
fifo fifo_proc20_to_proc21(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc20East),
	.full(fullProc20East),
	.dataIn(dataOutProc20East),
	.rd(rdProc21West),
	.empty(emptyProc21West),
	.dataOut(dataInProc21West));

//FIFO 31 TO 21
fifo fifo_proc31_to_proc21(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc31North),
	.full(fullProc31North),
	.dataIn(dataOutProc31North),
	.rd(rdProc21South),
	.empty(emptyProc21South),
	.dataOut(dataInProc21South));

//FIFO 21 TO 31
fifo fifo_proc21_to_proc31(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc21South),
	.full(fullProc21South),
	.dataIn(dataOutProc21South),
	.rd(rdProc31North),
	.empty(emptyProc31North),
	.dataOut(dataInProc31North));

//FIFO 21 TO 22
fifo fifo_proc21_to_proc22(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc21East),
	.full(fullProc21East),
	.dataIn(dataOutProc21East),
	.rd(rdProc22West),
	.empty(emptyProc22West),
	.dataOut(dataInProc22West));

//FIFO 32 TO 22
fifo fifo_proc32_to_proc22(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc32North),
	.full(fullProc32North),
	.dataIn(dataOutProc32North),
	.rd(rdProc22South),
	.empty(emptyProc22South),
	.dataOut(dataInProc22South));

//FIFO 22 TO 32
fifo fifo_proc22_to_proc32(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc22South),
	.full(fullProc22South),
	.dataIn(dataOutProc22South),
	.rd(rdProc32North),
	.empty(emptyProc32North),
	.dataOut(dataInProc32North));

//FIFO 23 TO 22
fifo fifo_proc23_to_proc22(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc23West),
	.full(fullProc23West),
	.dataIn(dataOutProc23West),
	.rd(rdProc22East),
	.empty(emptyProc22East),
	.dataOut(dataInProc22East));

//FIFO 22 TO 23
fifo fifo_proc22_to_proc23(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc22East),
	.full(fullProc22East),
	.dataIn(dataOutProc22East),
	.rd(rdProc23West),
	.empty(emptyProc23West),
	.dataOut(dataInProc23West));

//FIFO 33 TO 23
fifo fifo_proc33_to_proc23(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc33North),
	.full(fullProc33North),
	.dataIn(dataOutProc33North),
	.rd(rdProc23South),
	.empty(emptyProc23South),
	.dataOut(dataInProc23South));

//FIFO 24 TO 23
fifo fifo_proc24_to_proc23(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc24West),
	.full(fullProc24West),
	.dataIn(dataOutProc24West),
	.rd(rdProc23East),
	.empty(emptyProc23East),
	.dataOut(dataInProc23East));

//FIFO 23 TO 24
fifo fifo_proc23_to_proc24(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc23East),
	.full(fullProc23East),
	.dataIn(dataOutProc23East),
	.rd(rdProc24West),
	.empty(emptyProc24West),
	.dataOut(dataInProc24West));

//FIFO 24 TO 34
fifo fifo_proc24_to_proc34(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc24South),
	.full(fullProc24South),
	.dataIn(dataOutProc24South),
	.rd(rdProc34North),
	.empty(emptyProc34North),
	.dataOut(dataInProc34North));

//FIFO 25 TO 24
fifo fifo_proc25_to_proc24(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc25West),
	.full(fullProc25West),
	.dataIn(dataOutProc25West),
	.rd(rdProc24East),
	.empty(emptyProc24East),
	.dataOut(dataInProc24East));

//FIFO 24 TO 25
fifo fifo_proc24_to_proc25(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc24East),
	.full(fullProc24East),
	.dataIn(dataOutProc24East),
	.rd(rdProc25West),
	.empty(emptyProc25West),
	.dataOut(dataInProc25West));

//FIFO 35 TO 25
fifo fifo_proc35_to_proc25(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc35North),
	.full(fullProc35North),
	.dataIn(dataOutProc35North),
	.rd(rdProc25South),
	.empty(emptyProc25South),
	.dataOut(dataInProc25South));

//FIFO 25 TO 35
fifo fifo_proc25_to_proc35(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc25South),
	.full(fullProc25South),
	.dataIn(dataOutProc25South),
	.rd(rdProc35North),
	.empty(emptyProc35North),
	.dataOut(dataInProc35North));

//FIFO 26 TO 25
fifo fifo_proc26_to_proc25(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc26West),
	.full(fullProc26West),
	.dataIn(dataOutProc26West),
	.rd(rdProc25East),
	.empty(emptyProc25East),
	.dataOut(dataInProc25East));

//FIFO 25 TO 26
fifo fifo_proc25_to_proc26(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc25East),
	.full(fullProc25East),
	.dataIn(dataOutProc25East),
	.rd(rdProc26West),
	.empty(emptyProc26West),
	.dataOut(dataInProc26West));

//FIFO 26 TO 36
fifo fifo_proc26_to_proc36(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc26South),
	.full(fullProc26South),
	.dataIn(dataOutProc26South),
	.rd(rdProc36North),
	.empty(emptyProc36North),
	.dataOut(dataInProc36North));

//FIFO 26 TO 27
fifo fifo_proc26_to_proc27(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc26East),
	.full(fullProc26East),
	.dataIn(dataOutProc26East),
	.rd(rdProc27West),
	.empty(emptyProc27West),
	.dataOut(dataInProc27West));

//FIFO 27 TO 37
fifo fifo_proc27_to_proc37(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc27South),
	.full(fullProc27South),
	.dataIn(dataOutProc27South),
	.rd(rdProc37North),
	.empty(emptyProc37North),
	.dataOut(dataInProc37North));

//FIFO 28 TO 27
fifo fifo_proc28_to_proc27(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc28West),
	.full(fullProc28West),
	.dataIn(dataOutProc28West),
	.rd(rdProc27East),
	.empty(emptyProc27East),
	.dataOut(dataInProc27East));

//FIFO 27 TO 28
fifo fifo_proc27_to_proc28(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc27East),
	.full(fullProc27East),
	.dataIn(dataOutProc27East),
	.rd(rdProc28West),
	.empty(emptyProc28West),
	.dataOut(dataInProc28West));

//FIFO 28 TO 38
fifo fifo_proc28_to_proc38(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc28South),
	.full(fullProc28South),
	.dataIn(dataOutProc28South),
	.rd(rdProc38North),
	.empty(emptyProc38North),
	.dataOut(dataInProc38North));

//FIFO 29 TO 28
fifo fifo_proc29_to_proc28(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc29West),
	.full(fullProc29West),
	.dataIn(dataOutProc29West),
	.rd(rdProc28East),
	.empty(emptyProc28East),
	.dataOut(dataInProc28East));

//FIFO 39 TO 29
fifo fifo_proc39_to_proc29(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc39North),
	.full(fullProc39North),
	.dataIn(dataOutProc39North),
	.rd(rdProc29South),
	.empty(emptyProc29South),
	.dataOut(dataInProc29South));

//FIFO 40 TO 30
fifo fifo_proc40_to_proc30(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc40North),
	.full(fullProc40North),
	.dataIn(dataOutProc40North),
	.rd(rdProc30South),
	.empty(emptyProc30South),
	.dataOut(dataInProc30South));

//FIFO 43 TO 33
fifo fifo_proc43_to_proc33(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc43North),
	.full(fullProc43North),
	.dataIn(dataOutProc43North),
	.rd(rdProc33South),
	.empty(emptyProc33South),
	.dataOut(dataInProc33South));

//FIFO 33 TO 43
fifo fifo_proc33_to_proc43(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc33South),
	.full(fullProc33South),
	.dataIn(dataOutProc33South),
	.rd(rdProc43North),
	.empty(emptyProc43North),
	.dataOut(dataInProc43North));

//FIFO 34 TO 33
fifo fifo_proc34_to_proc33(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc34West),
	.full(fullProc34West),
	.dataIn(dataOutProc34West),
	.rd(rdProc33East),
	.empty(emptyProc33East),
	.dataOut(dataInProc33East));

//FIFO 45 TO 35
fifo fifo_proc45_to_proc35(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc45North),
	.full(fullProc45North),
	.dataIn(dataOutProc45North),
	.rd(rdProc35South),
	.empty(emptyProc35South),
	.dataOut(dataInProc35South));

//FIFO 35 TO 36
fifo fifo_proc35_to_proc36(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc35East),
	.full(fullProc35East),
	.dataIn(dataOutProc35East),
	.rd(rdProc36West),
	.empty(emptyProc36West),
	.dataOut(dataInProc36West));

//FIFO 36 TO 46
fifo fifo_proc36_to_proc46(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc36South),
	.full(fullProc36South),
	.dataIn(dataOutProc36South),
	.rd(rdProc46North),
	.empty(emptyProc46North),
	.dataOut(dataInProc46North));

//FIFO 36 TO 37
fifo fifo_proc36_to_proc37(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc36East),
	.full(fullProc36East),
	.dataIn(dataOutProc36East),
	.rd(rdProc37West),
	.empty(emptyProc37West),
	.dataOut(dataInProc37West));

//FIFO 37 TO 47
fifo fifo_proc37_to_proc47(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc37South),
	.full(fullProc37South),
	.dataIn(dataOutProc37South),
	.rd(rdProc47North),
	.empty(emptyProc47North),
	.dataOut(dataInProc47North));

//FIFO 48 TO 38
fifo fifo_proc48_to_proc38(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc48North),
	.full(fullProc48North),
	.dataIn(dataOutProc48North),
	.rd(rdProc38South),
	.empty(emptyProc38South),
	.dataOut(dataInProc38South));

//FIFO 38 TO 48
fifo fifo_proc38_to_proc48(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc38South),
	.full(fullProc38South),
	.dataIn(dataOutProc38South),
	.rd(rdProc48North),
	.empty(emptyProc48North),
	.dataOut(dataInProc48North));

//FIFO 38 TO 39
fifo fifo_proc38_to_proc39(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc38East),
	.full(fullProc38East),
	.dataIn(dataOutProc38East),
	.rd(rdProc39West),
	.empty(emptyProc39West),
	.dataOut(dataInProc39West));

//FIFO 49 TO 39
fifo fifo_proc49_to_proc39(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc49North),
	.full(fullProc49North),
	.dataIn(dataOutProc49North),
	.rd(rdProc39South),
	.empty(emptyProc39South),
	.dataOut(dataInProc39South));

//FIFO 50 TO 40
fifo fifo_proc50_to_proc40(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc50North),
	.full(fullProc50North),
	.dataIn(dataOutProc50North),
	.rd(rdProc40South),
	.empty(emptyProc40South),
	.dataOut(dataInProc40South));

//FIFO 40 TO 50
fifo fifo_proc40_to_proc50(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc40South),
	.full(fullProc40South),
	.dataIn(dataOutProc40South),
	.rd(rdProc50North),
	.empty(emptyProc50North),
	.dataOut(dataInProc50North));

//FIFO 41 TO 40
fifo fifo_proc41_to_proc40(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc41West),
	.full(fullProc41West),
	.dataIn(dataOutProc41West),
	.rd(rdProc40East),
	.empty(emptyProc40East),
	.dataOut(dataInProc40East));

//FIFO 42 TO 41
fifo fifo_proc42_to_proc41(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc42West),
	.full(fullProc42West),
	.dataIn(dataOutProc42West),
	.rd(rdProc41East),
	.empty(emptyProc41East),
	.dataOut(dataInProc41East));

//FIFO 52 TO 42
fifo fifo_proc52_to_proc42(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc52North),
	.full(fullProc52North),
	.dataIn(dataOutProc52North),
	.rd(rdProc42South),
	.empty(emptyProc42South),
	.dataOut(dataInProc42South));

//FIFO 43 TO 42
fifo fifo_proc43_to_proc42(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc43West),
	.full(fullProc43West),
	.dataIn(dataOutProc43West),
	.rd(rdProc42East),
	.empty(emptyProc42East),
	.dataOut(dataInProc42East));

//FIFO 42 TO 43
fifo fifo_proc42_to_proc43(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc42East),
	.full(fullProc42East),
	.dataIn(dataOutProc42East),
	.rd(rdProc43West),
	.empty(emptyProc43West),
	.dataOut(dataInProc43West));

//FIFO 53 TO 43
fifo fifo_proc53_to_proc43(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc53North),
	.full(fullProc53North),
	.dataIn(dataOutProc53North),
	.rd(rdProc43South),
	.empty(emptyProc43South),
	.dataOut(dataInProc43South));

//FIFO 43 TO 53
fifo fifo_proc43_to_proc53(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc43South),
	.full(fullProc43South),
	.dataIn(dataOutProc43South),
	.rd(rdProc53North),
	.empty(emptyProc53North),
	.dataOut(dataInProc53North));

//FIFO 43 TO 44
fifo fifo_proc43_to_proc44(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc43East),
	.full(fullProc43East),
	.dataIn(dataOutProc43East),
	.rd(rdProc44West),
	.empty(emptyProc44West),
	.dataOut(dataInProc44West));

//FIFO 44 TO 45
fifo fifo_proc44_to_proc45(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc44East),
	.full(fullProc44East),
	.dataIn(dataOutProc44East),
	.rd(rdProc45West),
	.empty(emptyProc45West),
	.dataOut(dataInProc45West));

//FIFO 45 TO 55
fifo fifo_proc45_to_proc55(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc45South),
	.full(fullProc45South),
	.dataIn(dataOutProc45South),
	.rd(rdProc55North),
	.empty(emptyProc55North),
	.dataOut(dataInProc55North));

//FIFO 46 TO 45
fifo fifo_proc46_to_proc45(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc46West),
	.full(fullProc46West),
	.dataIn(dataOutProc46West),
	.rd(rdProc45East),
	.empty(emptyProc45East),
	.dataOut(dataInProc45East));

//FIFO 46 TO 56
fifo fifo_proc46_to_proc56(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc46South),
	.full(fullProc46South),
	.dataIn(dataOutProc46South),
	.rd(rdProc56North),
	.empty(emptyProc56North),
	.dataOut(dataInProc56North));

//FIFO 47 TO 46
fifo fifo_proc47_to_proc46(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc47West),
	.full(fullProc47West),
	.dataIn(dataOutProc47West),
	.rd(rdProc46East),
	.empty(emptyProc46East),
	.dataOut(dataInProc46East));

//FIFO 47 TO 57
fifo fifo_proc47_to_proc57(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc47South),
	.full(fullProc47South),
	.dataIn(dataOutProc47South),
	.rd(rdProc57North),
	.empty(emptyProc57North),
	.dataOut(dataInProc57North));

//FIFO 58 TO 48
fifo fifo_proc58_to_proc48(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc58North),
	.full(fullProc58North),
	.dataIn(dataOutProc58North),
	.rd(rdProc48South),
	.empty(emptyProc48South),
	.dataOut(dataInProc48South));

//FIFO 48 TO 58
fifo fifo_proc48_to_proc58(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc48South),
	.full(fullProc48South),
	.dataIn(dataOutProc48South),
	.rd(rdProc58North),
	.empty(emptyProc58North),
	.dataOut(dataInProc58North));

//FIFO 59 TO 49
fifo fifo_proc59_to_proc49(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc59North),
	.full(fullProc59North),
	.dataIn(dataOutProc59North),
	.rd(rdProc49South),
	.empty(emptyProc49South),
	.dataOut(dataInProc49South));

//FIFO 51 TO 50
fifo fifo_proc51_to_proc50(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc51West),
	.full(fullProc51West),
	.dataIn(dataOutProc51West),
	.rd(rdProc50East),
	.empty(emptyProc50East),
	.dataOut(dataInProc50East));

//FIFO 50 TO 51
fifo fifo_proc50_to_proc51(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc50East),
	.full(fullProc50East),
	.dataIn(dataOutProc50East),
	.rd(rdProc51West),
	.empty(emptyProc51West),
	.dataOut(dataInProc51West));

//FIFO 52 TO 51
fifo fifo_proc52_to_proc51(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc52West),
	.full(fullProc52West),
	.dataIn(dataOutProc52West),
	.rd(rdProc51East),
	.empty(emptyProc51East),
	.dataOut(dataInProc51East));

//FIFO 51 TO 52
fifo fifo_proc51_to_proc52(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc51East),
	.full(fullProc51East),
	.dataIn(dataOutProc51East),
	.rd(rdProc52West),
	.empty(emptyProc52West),
	.dataOut(dataInProc52West));

//FIFO 62 TO 52
fifo fifo_proc62_to_proc52(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc62North),
	.full(fullProc62North),
	.dataIn(dataOutProc62North),
	.rd(rdProc52South),
	.empty(emptyProc52South),
	.dataOut(dataInProc52South));

//FIFO 52 TO 62
fifo fifo_proc52_to_proc62(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc52South),
	.full(fullProc52South),
	.dataIn(dataOutProc52South),
	.rd(rdProc62North),
	.empty(emptyProc62North),
	.dataOut(dataInProc62North));

//FIFO 53 TO 52
fifo fifo_proc53_to_proc52(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc53West),
	.full(fullProc53West),
	.dataIn(dataOutProc53West),
	.rd(rdProc52East),
	.empty(emptyProc52East),
	.dataOut(dataInProc52East));

//FIFO 52 TO 53
fifo fifo_proc52_to_proc53(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc52East),
	.full(fullProc52East),
	.dataIn(dataOutProc52East),
	.rd(rdProc53West),
	.empty(emptyProc53West),
	.dataOut(dataInProc53West));

//FIFO 63 TO 53
fifo fifo_proc63_to_proc53(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc63North),
	.full(fullProc63North),
	.dataIn(dataOutProc63North),
	.rd(rdProc53South),
	.empty(emptyProc53South),
	.dataOut(dataInProc53South));

//FIFO 53 TO 63
fifo fifo_proc53_to_proc63(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc53South),
	.full(fullProc53South),
	.dataIn(dataOutProc53South),
	.rd(rdProc63North),
	.empty(emptyProc63North),
	.dataOut(dataInProc63North));

//FIFO 54 TO 53
fifo fifo_proc54_to_proc53(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc54West),
	.full(fullProc54West),
	.dataIn(dataOutProc54West),
	.rd(rdProc53East),
	.empty(emptyProc53East),
	.dataOut(dataInProc53East));

//FIFO 55 TO 54
fifo fifo_proc55_to_proc54(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc55West),
	.full(fullProc55West),
	.dataIn(dataOutProc55West),
	.rd(rdProc54East),
	.empty(emptyProc54East),
	.dataOut(dataInProc54East));

//FIFO 56 TO 55
fifo fifo_proc56_to_proc55(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc56West),
	.full(fullProc56West),
	.dataIn(dataOutProc56West),
	.rd(rdProc55East),
	.empty(emptyProc55East),
	.dataOut(dataInProc55East));

//FIFO 57 TO 56
fifo fifo_proc57_to_proc56(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc57West),
	.full(fullProc57West),
	.dataIn(dataOutProc57West),
	.rd(rdProc56East),
	.empty(emptyProc56East),
	.dataOut(dataInProc56East));

//FIFO 56 TO 57
fifo fifo_proc56_to_proc57(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc56East),
	.full(fullProc56East),
	.dataIn(dataOutProc56East),
	.rd(rdProc57West),
	.empty(emptyProc57West),
	.dataOut(dataInProc57West));

//FIFO 57 TO 67
fifo fifo_proc57_to_proc67(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc57South),
	.full(fullProc57South),
	.dataIn(dataOutProc57South),
	.rd(rdProc67North),
	.empty(emptyProc67North),
	.dataOut(dataInProc67North));

//FIFO 58 TO 68
fifo fifo_proc58_to_proc68(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc58South),
	.full(fullProc58South),
	.dataIn(dataOutProc58South),
	.rd(rdProc68North),
	.empty(emptyProc68North),
	.dataOut(dataInProc68North));

//FIFO 59 TO 58
fifo fifo_proc59_to_proc58(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc59West),
	.full(fullProc59West),
	.dataIn(dataOutProc59West),
	.rd(rdProc58East),
	.empty(emptyProc58East),
	.dataOut(dataInProc58East));

//FIFO 69 TO 59
fifo fifo_proc69_to_proc59(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc69North),
	.full(fullProc69North),
	.dataIn(dataOutProc69North),
	.rd(rdProc59South),
	.empty(emptyProc59South),
	.dataOut(dataInProc59South));

//FIFO 60 TO 70
fifo fifo_proc60_to_proc70(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc60South),
	.full(fullProc60South),
	.dataIn(dataOutProc60South),
	.rd(rdProc70North),
	.empty(emptyProc70North),
	.dataOut(dataInProc70North));

//FIFO 61 TO 60
fifo fifo_proc61_to_proc60(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc61West),
	.full(fullProc61West),
	.dataIn(dataOutProc61West),
	.rd(rdProc60East),
	.empty(emptyProc60East),
	.dataOut(dataInProc60East));

//FIFO 71 TO 61
fifo fifo_proc71_to_proc61(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc71North),
	.full(fullProc71North),
	.dataIn(dataOutProc71North),
	.rd(rdProc61South),
	.empty(emptyProc61South),
	.dataOut(dataInProc61South));

//FIFO 61 TO 62
fifo fifo_proc61_to_proc62(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc61East),
	.full(fullProc61East),
	.dataIn(dataOutProc61East),
	.rd(rdProc62West),
	.empty(emptyProc62West),
	.dataOut(dataInProc62West));

//FIFO 72 TO 62
fifo fifo_proc72_to_proc62(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc72North),
	.full(fullProc72North),
	.dataIn(dataOutProc72North),
	.rd(rdProc62South),
	.empty(emptyProc62South),
	.dataOut(dataInProc62South));

//FIFO 62 TO 72
fifo fifo_proc62_to_proc72(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc62South),
	.full(fullProc62South),
	.dataIn(dataOutProc62South),
	.rd(rdProc72North),
	.empty(emptyProc72North),
	.dataOut(dataInProc72North));

//FIFO 62 TO 63
fifo fifo_proc62_to_proc63(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc62East),
	.full(fullProc62East),
	.dataIn(dataOutProc62East),
	.rd(rdProc63West),
	.empty(emptyProc63West),
	.dataOut(dataInProc63West));

//FIFO 73 TO 63
fifo fifo_proc73_to_proc63(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc73North),
	.full(fullProc73North),
	.dataIn(dataOutProc73North),
	.rd(rdProc63South),
	.empty(emptyProc63South),
	.dataOut(dataInProc63South));

//FIFO 63 TO 73
fifo fifo_proc63_to_proc73(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc63South),
	.full(fullProc63South),
	.dataIn(dataOutProc63South),
	.rd(rdProc73North),
	.empty(emptyProc73North),
	.dataOut(dataInProc73North));

//FIFO 63 TO 64
fifo fifo_proc63_to_proc64(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc63East),
	.full(fullProc63East),
	.dataIn(dataOutProc63East),
	.rd(rdProc64West),
	.empty(emptyProc64West),
	.dataOut(dataInProc64West));

//FIFO 64 TO 74
fifo fifo_proc64_to_proc74(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc64South),
	.full(fullProc64South),
	.dataIn(dataOutProc64South),
	.rd(rdProc74North),
	.empty(emptyProc74North),
	.dataOut(dataInProc74North));

//FIFO 65 TO 64
fifo fifo_proc65_to_proc64(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc65West),
	.full(fullProc65West),
	.dataIn(dataOutProc65West),
	.rd(rdProc64East),
	.empty(emptyProc64East),
	.dataOut(dataInProc64East));

//FIFO 64 TO 65
fifo fifo_proc64_to_proc65(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc64East),
	.full(fullProc64East),
	.dataIn(dataOutProc64East),
	.rd(rdProc65West),
	.empty(emptyProc65West),
	.dataOut(dataInProc65West));

//FIFO 76 TO 66
fifo fifo_proc76_to_proc66(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc76North),
	.full(fullProc76North),
	.dataIn(dataOutProc76North),
	.rd(rdProc66South),
	.empty(emptyProc66South),
	.dataOut(dataInProc66South));

//FIFO 66 TO 67
fifo fifo_proc66_to_proc67(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc66East),
	.full(fullProc66East),
	.dataIn(dataOutProc66East),
	.rd(rdProc67West),
	.empty(emptyProc67West),
	.dataOut(dataInProc67West));

//FIFO 67 TO 77
fifo fifo_proc67_to_proc77(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc67South),
	.full(fullProc67South),
	.dataIn(dataOutProc67South),
	.rd(rdProc77North),
	.empty(emptyProc77North),
	.dataOut(dataInProc77North));

//FIFO 67 TO 68
fifo fifo_proc67_to_proc68(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc67East),
	.full(fullProc67East),
	.dataIn(dataOutProc67East),
	.rd(rdProc68West),
	.empty(emptyProc68West),
	.dataOut(dataInProc68West));

//FIFO 68 TO 78
fifo fifo_proc68_to_proc78(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc68South),
	.full(fullProc68South),
	.dataIn(dataOutProc68South),
	.rd(rdProc78North),
	.empty(emptyProc78North),
	.dataOut(dataInProc78North));

//FIFO 68 TO 69
fifo fifo_proc68_to_proc69(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc68East),
	.full(fullProc68East),
	.dataIn(dataOutProc68East),
	.rd(rdProc69West),
	.empty(emptyProc69West),
	.dataOut(dataInProc69West));

//FIFO 79 TO 69
fifo fifo_proc79_to_proc69(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc79North),
	.full(fullProc79North),
	.dataIn(dataOutProc79North),
	.rd(rdProc69South),
	.empty(emptyProc69South),
	.dataOut(dataInProc69South));

//FIFO 70 TO 80
fifo fifo_proc70_to_proc80(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc70South),
	.full(fullProc70South),
	.dataIn(dataOutProc70South),
	.rd(rdProc80North),
	.empty(emptyProc80North),
	.dataOut(dataInProc80North));

//FIFO 81 TO 71
fifo fifo_proc81_to_proc71(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc81North),
	.full(fullProc81North),
	.dataIn(dataOutProc81North),
	.rd(rdProc71South),
	.empty(emptyProc71South),
	.dataOut(dataInProc71South));

//FIFO 73 TO 72
fifo fifo_proc73_to_proc72(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc73West),
	.full(fullProc73West),
	.dataIn(dataOutProc73West),
	.rd(rdProc72East),
	.empty(emptyProc72East),
	.dataOut(dataInProc72East));

//FIFO 72 TO 73
fifo fifo_proc72_to_proc73(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc72East),
	.full(fullProc72East),
	.dataIn(dataOutProc72East),
	.rd(rdProc73West),
	.empty(emptyProc73West),
	.dataOut(dataInProc73West));

//FIFO 73 TO 83
fifo fifo_proc73_to_proc83(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc73South),
	.full(fullProc73South),
	.dataIn(dataOutProc73South),
	.rd(rdProc83North),
	.empty(emptyProc83North),
	.dataOut(dataInProc83North));

//FIFO 74 TO 73
fifo fifo_proc74_to_proc73(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc74West),
	.full(fullProc74West),
	.dataIn(dataOutProc74West),
	.rd(rdProc73East),
	.empty(emptyProc73East),
	.dataOut(dataInProc73East));

//FIFO 84 TO 74
fifo fifo_proc84_to_proc74(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc84North),
	.full(fullProc84North),
	.dataIn(dataOutProc84North),
	.rd(rdProc74South),
	.empty(emptyProc74South),
	.dataOut(dataInProc74South));

//FIFO 74 TO 84
fifo fifo_proc74_to_proc84(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc74South),
	.full(fullProc74South),
	.dataIn(dataOutProc74South),
	.rd(rdProc84North),
	.empty(emptyProc84North),
	.dataOut(dataInProc84North));

//FIFO 75 TO 74
fifo fifo_proc75_to_proc74(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc75West),
	.full(fullProc75West),
	.dataIn(dataOutProc75West),
	.rd(rdProc74East),
	.empty(emptyProc74East),
	.dataOut(dataInProc74East));

//FIFO 74 TO 75
fifo fifo_proc74_to_proc75(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc74East),
	.full(fullProc74East),
	.dataIn(dataOutProc74East),
	.rd(rdProc75West),
	.empty(emptyProc75West),
	.dataOut(dataInProc75West));

//FIFO 76 TO 75
fifo fifo_proc76_to_proc75(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc76West),
	.full(fullProc76West),
	.dataIn(dataOutProc76West),
	.rd(rdProc75East),
	.empty(emptyProc75East),
	.dataOut(dataInProc75East));

//FIFO 75 TO 76
fifo fifo_proc75_to_proc76(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc75East),
	.full(fullProc75East),
	.dataIn(dataOutProc75East),
	.rd(rdProc76West),
	.empty(emptyProc76West),
	.dataOut(dataInProc76West));

//FIFO 86 TO 76
fifo fifo_proc86_to_proc76(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc86North),
	.full(fullProc86North),
	.dataIn(dataOutProc86North),
	.rd(rdProc76South),
	.empty(emptyProc76South),
	.dataOut(dataInProc76South));

//FIFO 77 TO 87
fifo fifo_proc77_to_proc87(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc77South),
	.full(fullProc77South),
	.dataIn(dataOutProc77South),
	.rd(rdProc87North),
	.empty(emptyProc87North),
	.dataOut(dataInProc87North));

//FIFO 78 TO 77
fifo fifo_proc78_to_proc77(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc78West),
	.full(fullProc78West),
	.dataIn(dataOutProc78West),
	.rd(rdProc77East),
	.empty(emptyProc77East),
	.dataOut(dataInProc77East));

//FIFO 89 TO 79
fifo fifo_proc89_to_proc79(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc89North),
	.full(fullProc89North),
	.dataIn(dataOutProc89North),
	.rd(rdProc79South),
	.empty(emptyProc79South),
	.dataOut(dataInProc79South));

//FIFO 80 TO 81
fifo fifo_proc80_to_proc81(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc80East),
	.full(fullProc80East),
	.dataIn(dataOutProc80East),
	.rd(rdProc81West),
	.empty(emptyProc81West),
	.dataOut(dataInProc81West));

//FIFO 82 TO 81
fifo fifo_proc82_to_proc81(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc82West),
	.full(fullProc82West),
	.dataIn(dataOutProc82West),
	.rd(rdProc81East),
	.empty(emptyProc81East),
	.dataOut(dataInProc81East));

//FIFO 81 TO 82
fifo fifo_proc81_to_proc82(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc81East),
	.full(fullProc81East),
	.dataIn(dataOutProc81East),
	.rd(rdProc82West),
	.empty(emptyProc82West),
	.dataOut(dataInProc82West));

//FIFO 83 TO 82
fifo fifo_proc83_to_proc82(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc83West),
	.full(fullProc83West),
	.dataIn(dataOutProc83West),
	.rd(rdProc82East),
	.empty(emptyProc82East),
	.dataOut(dataInProc82East));

//FIFO 82 TO 83
fifo fifo_proc82_to_proc83(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc82East),
	.full(fullProc82East),
	.dataIn(dataOutProc82East),
	.rd(rdProc83West),
	.empty(emptyProc83West),
	.dataOut(dataInProc83West));

//FIFO 84 TO 83
fifo fifo_proc84_to_proc83(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc84West),
	.full(fullProc84West),
	.dataIn(dataOutProc84West),
	.rd(rdProc83East),
	.empty(emptyProc83East),
	.dataOut(dataInProc83East));

//FIFO 83 TO 84
fifo fifo_proc83_to_proc84(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc83East),
	.full(fullProc83East),
	.dataIn(dataOutProc83East),
	.rd(rdProc84West),
	.empty(emptyProc84West),
	.dataOut(dataInProc84West));

//FIFO 85 TO 84
fifo fifo_proc85_to_proc84(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc85West),
	.full(fullProc85West),
	.dataIn(dataOutProc85West),
	.rd(rdProc84East),
	.empty(emptyProc84East),
	.dataOut(dataInProc84East));

//FIFO 84 TO 85
fifo fifo_proc84_to_proc85(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc84East),
	.full(fullProc84East),
	.dataIn(dataOutProc84East),
	.rd(rdProc85West),
	.empty(emptyProc85West),
	.dataOut(dataInProc85West));

//FIFO 87 TO 86
fifo fifo_proc87_to_proc86(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc87West),
	.full(fullProc87West),
	.dataIn(dataOutProc87West),
	.rd(rdProc86East),
	.empty(emptyProc86East),
	.dataOut(dataInProc86East));

//FIFO 87 TO 88
fifo fifo_proc87_to_proc88(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc87East),
	.full(fullProc87East),
	.dataIn(dataOutProc87East),
	.rd(rdProc88West),
	.empty(emptyProc88West),
	.dataOut(dataInProc88West));

//FIFO 88 TO 89
fifo fifo_proc88_to_proc89(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc88East),
	.full(fullProc88East),
	.dataIn(dataOutProc88East),
	.rd(rdProc89West),
	.empty(emptyProc89West),
	.dataOut(dataInProc89West));

	/**************** Boot loader ********************/
	/*******Boot up each processor one by one*********/
	always@(posedge clk)
	begin
	case(processor_select)
		0: begin

			boot_iwe0 = ~resetn;
			boot_dwe0 = ~resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		1: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 = ~resetn;
			boot_dwe1 = ~resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		2: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 = ~resetn;
			boot_dwe2 = ~resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		3: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 = ~resetn;
			boot_dwe3 = ~resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		4: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 = ~resetn;
			boot_dwe4 = ~resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		5: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 = ~resetn;
			boot_dwe5 = ~resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		6: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 = ~resetn;
			boot_dwe6 = ~resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		7: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 = ~resetn;
			boot_dwe7 = ~resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		8: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 = ~resetn;
			boot_dwe8 = ~resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		9: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 = ~resetn;
			boot_dwe9 = ~resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		10: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 = ~resetn;
			boot_dwe10 = ~resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		11: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 = ~resetn;
			boot_dwe11 = ~resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		12: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 = ~resetn;
			boot_dwe12 = ~resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		13: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 = ~resetn;
			boot_dwe13 = ~resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		14: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 = ~resetn;
			boot_dwe14 = ~resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		15: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 = ~resetn;
			boot_dwe15 = ~resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		16: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 = ~resetn;
			boot_dwe16 = ~resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		17: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 = ~resetn;
			boot_dwe17 = ~resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		18: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 = ~resetn;
			boot_dwe18 = ~resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		19: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 = ~resetn;
			boot_dwe19 = ~resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		20: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 = ~resetn;
			boot_dwe20 = ~resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		21: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 = ~resetn;
			boot_dwe21 = ~resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		22: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 = ~resetn;
			boot_dwe22 = ~resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		23: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 = ~resetn;
			boot_dwe23 = ~resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		24: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 = ~resetn;
			boot_dwe24 = ~resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		25: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 = ~resetn;
			boot_dwe25 = ~resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		26: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 = ~resetn;
			boot_dwe26 = ~resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		27: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 = ~resetn;
			boot_dwe27 = ~resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		28: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 = ~resetn;
			boot_dwe28 = ~resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		29: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 = ~resetn;
			boot_dwe29 = ~resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		30: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 = ~resetn;
			boot_dwe30 = ~resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		31: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 = ~resetn;
			boot_dwe31 = ~resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		32: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 = ~resetn;
			boot_dwe32 = ~resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		33: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 = ~resetn;
			boot_dwe33 = ~resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		34: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 = ~resetn;
			boot_dwe34 = ~resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		35: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 = ~resetn;
			boot_dwe35 = ~resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		36: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 = ~resetn;
			boot_dwe36 = ~resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		37: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 = ~resetn;
			boot_dwe37 = ~resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		38: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 = ~resetn;
			boot_dwe38 = ~resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		39: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 = ~resetn;
			boot_dwe39 = ~resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		40: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 = ~resetn;
			boot_dwe40 = ~resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		41: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 = ~resetn;
			boot_dwe41 = ~resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		42: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 = ~resetn;
			boot_dwe42 = ~resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		43: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 = ~resetn;
			boot_dwe43 = ~resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		44: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 = ~resetn;
			boot_dwe44 = ~resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		45: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 = ~resetn;
			boot_dwe45 = ~resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		46: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 = ~resetn;
			boot_dwe46 = ~resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		47: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 = ~resetn;
			boot_dwe47 = ~resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		48: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 = ~resetn;
			boot_dwe48 = ~resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		49: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 = ~resetn;
			boot_dwe49 = ~resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		50: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 = ~resetn;
			boot_dwe50 = ~resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		51: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 = ~resetn;
			boot_dwe51 = ~resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		52: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 = ~resetn;
			boot_dwe52 = ~resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		53: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 = ~resetn;
			boot_dwe53 = ~resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		54: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 = ~resetn;
			boot_dwe54 = ~resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		55: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 = ~resetn;
			boot_dwe55 = ~resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		56: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 = ~resetn;
			boot_dwe56 = ~resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		57: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 = ~resetn;
			boot_dwe57 = ~resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		58: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 = ~resetn;
			boot_dwe58 = ~resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		59: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 = ~resetn;
			boot_dwe59 = ~resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		60: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 = ~resetn;
			boot_dwe60 = ~resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		61: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 = ~resetn;
			boot_dwe61 = ~resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		62: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 = ~resetn;
			boot_dwe62 = ~resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		63: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 = ~resetn;
			boot_dwe63 = ~resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		64: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 = ~resetn;
			boot_dwe64 = ~resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		65: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 = ~resetn;
			boot_dwe65 = ~resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		66: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 = ~resetn;
			boot_dwe66 = ~resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		67: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 = ~resetn;
			boot_dwe67 = ~resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		68: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 = ~resetn;
			boot_dwe68 = ~resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		69: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 = ~resetn;
			boot_dwe69 = ~resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		70: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 = ~resetn;
			boot_dwe70 = ~resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		71: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 = ~resetn;
			boot_dwe71 = ~resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		72: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 = ~resetn;
			boot_dwe72 = ~resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		73: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 = ~resetn;
			boot_dwe73 = ~resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		74: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 = ~resetn;
			boot_dwe74 = ~resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		75: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 = ~resetn;
			boot_dwe75 = ~resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		76: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 = ~resetn;
			boot_dwe76 = ~resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		77: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 = ~resetn;
			boot_dwe77 = ~resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		78: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 = ~resetn;
			boot_dwe78 = ~resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		79: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 = ~resetn;
			boot_dwe79 = ~resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		80: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 = ~resetn;
			boot_dwe80 = ~resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		81: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 = ~resetn;
			boot_dwe81 = ~resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		82: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 = ~resetn;
			boot_dwe82 = ~resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		83: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 = ~resetn;
			boot_dwe83 = ~resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		84: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 = ~resetn;
			boot_dwe84 = ~resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		85: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 = ~resetn;
			boot_dwe85 = ~resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		86: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 = ~resetn;
			boot_dwe86 = ~resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		87: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 = ~resetn;
			boot_dwe87 = ~resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		88: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 = ~resetn;
			boot_dwe88 = ~resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
		end

		89: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 = ~resetn;
			boot_dwe89 = ~resetn;
		end

		90: begin

			boot_iwe0 = 0;
			boot_dwe0 = 0;
			boot_iwe1 = 0;
			boot_dwe1 = 0;
			boot_iwe2 = 0;
			boot_dwe2 = 0;
			boot_iwe3 = 0;
			boot_dwe3 = 0;
			boot_iwe4 = 0;
			boot_dwe4 = 0;
			boot_iwe5 = 0;
			boot_dwe5 = 0;
			boot_iwe6 = 0;
			boot_dwe6 = 0;
			boot_iwe7 = 0;
			boot_dwe7 = 0;
			boot_iwe8 = 0;
			boot_dwe8 = 0;
			boot_iwe9 = 0;
			boot_dwe9 = 0;
			boot_iwe10 = 0;
			boot_dwe10 = 0;
			boot_iwe11 = 0;
			boot_dwe11 = 0;
			boot_iwe12 = 0;
			boot_dwe12 = 0;
			boot_iwe13 = 0;
			boot_dwe13 = 0;
			boot_iwe14 = 0;
			boot_dwe14 = 0;
			boot_iwe15 = 0;
			boot_dwe15 = 0;
			boot_iwe16 = 0;
			boot_dwe16 = 0;
			boot_iwe17 = 0;
			boot_dwe17 = 0;
			boot_iwe18 = 0;
			boot_dwe18 = 0;
			boot_iwe19 = 0;
			boot_dwe19 = 0;
			boot_iwe20 = 0;
			boot_dwe20 = 0;
			boot_iwe21 = 0;
			boot_dwe21 = 0;
			boot_iwe22 = 0;
			boot_dwe22 = 0;
			boot_iwe23 = 0;
			boot_dwe23 = 0;
			boot_iwe24 = 0;
			boot_dwe24 = 0;
			boot_iwe25 = 0;
			boot_dwe25 = 0;
			boot_iwe26 = 0;
			boot_dwe26 = 0;
			boot_iwe27 = 0;
			boot_dwe27 = 0;
			boot_iwe28 = 0;
			boot_dwe28 = 0;
			boot_iwe29 = 0;
			boot_dwe29 = 0;
			boot_iwe30 = 0;
			boot_dwe30 = 0;
			boot_iwe31 = 0;
			boot_dwe31 = 0;
			boot_iwe32 = 0;
			boot_dwe32 = 0;
			boot_iwe33 = 0;
			boot_dwe33 = 0;
			boot_iwe34 = 0;
			boot_dwe34 = 0;
			boot_iwe35 = 0;
			boot_dwe35 = 0;
			boot_iwe36 = 0;
			boot_dwe36 = 0;
			boot_iwe37 = 0;
			boot_dwe37 = 0;
			boot_iwe38 = 0;
			boot_dwe38 = 0;
			boot_iwe39 = 0;
			boot_dwe39 = 0;
			boot_iwe40 = 0;
			boot_dwe40 = 0;
			boot_iwe41 = 0;
			boot_dwe41 = 0;
			boot_iwe42 = 0;
			boot_dwe42 = 0;
			boot_iwe43 = 0;
			boot_dwe43 = 0;
			boot_iwe44 = 0;
			boot_dwe44 = 0;
			boot_iwe45 = 0;
			boot_dwe45 = 0;
			boot_iwe46 = 0;
			boot_dwe46 = 0;
			boot_iwe47 = 0;
			boot_dwe47 = 0;
			boot_iwe48 = 0;
			boot_dwe48 = 0;
			boot_iwe49 = 0;
			boot_dwe49 = 0;
			boot_iwe50 = 0;
			boot_dwe50 = 0;
			boot_iwe51 = 0;
			boot_dwe51 = 0;
			boot_iwe52 = 0;
			boot_dwe52 = 0;
			boot_iwe53 = 0;
			boot_dwe53 = 0;
			boot_iwe54 = 0;
			boot_dwe54 = 0;
			boot_iwe55 = 0;
			boot_dwe55 = 0;
			boot_iwe56 = 0;
			boot_dwe56 = 0;
			boot_iwe57 = 0;
			boot_dwe57 = 0;
			boot_iwe58 = 0;
			boot_dwe58 = 0;
			boot_iwe59 = 0;
			boot_dwe59 = 0;
			boot_iwe60 = 0;
			boot_dwe60 = 0;
			boot_iwe61 = 0;
			boot_dwe61 = 0;
			boot_iwe62 = 0;
			boot_dwe62 = 0;
			boot_iwe63 = 0;
			boot_dwe63 = 0;
			boot_iwe64 = 0;
			boot_dwe64 = 0;
			boot_iwe65 = 0;
			boot_dwe65 = 0;
			boot_iwe66 = 0;
			boot_dwe66 = 0;
			boot_iwe67 = 0;
			boot_dwe67 = 0;
			boot_iwe68 = 0;
			boot_dwe68 = 0;
			boot_iwe69 = 0;
			boot_dwe69 = 0;
			boot_iwe70 = 0;
			boot_dwe70 = 0;
			boot_iwe71 = 0;
			boot_dwe71 = 0;
			boot_iwe72 = 0;
			boot_dwe72 = 0;
			boot_iwe73 = 0;
			boot_dwe73 = 0;
			boot_iwe74 = 0;
			boot_dwe74 = 0;
			boot_iwe75 = 0;
			boot_dwe75 = 0;
			boot_iwe76 = 0;
			boot_dwe76 = 0;
			boot_iwe77 = 0;
			boot_dwe77 = 0;
			boot_iwe78 = 0;
			boot_dwe78 = 0;
			boot_iwe79 = 0;
			boot_dwe79 = 0;
			boot_iwe80 = 0;
			boot_dwe80 = 0;
			boot_iwe81 = 0;
			boot_dwe81 = 0;
			boot_iwe82 = 0;
			boot_dwe82 = 0;
			boot_iwe83 = 0;
			boot_dwe83 = 0;
			boot_iwe84 = 0;
			boot_dwe84 = 0;
			boot_iwe85 = 0;
			boot_dwe85 = 0;
			boot_iwe86 = 0;
			boot_dwe86 = 0;
			boot_iwe87 = 0;
			boot_dwe87 = 0;
			boot_iwe88 = 0;
			boot_dwe88 = 0;
			boot_iwe89 = 0;
			boot_dwe89 = 0;
		end

	endcase
end
endmodule