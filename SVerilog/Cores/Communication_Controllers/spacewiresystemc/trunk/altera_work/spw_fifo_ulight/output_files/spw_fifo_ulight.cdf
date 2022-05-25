/* Quartus Prime Version 17.0.1 Build 598 06/07/2017 SJ Lite Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSEMA4U23) Path("/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/output_files/") File("spw_fifo_ulight.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
