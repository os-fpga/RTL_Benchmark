#!/usr/bin/perl

if (! -e "one_loop.log") {
	printf "\n[Error] one_loop.log is not generated\n\n"; #getdmips.pl is supposed to generate one_loop.log 
    	exit(1);
}

my $param = {};
my $type = "tcf";
if (defined $ARGV[0]) {
	$param->{'scope'} = $ARGV[0];	
} else {
	get_scope($param);
}

if (defined $ARGV[1]) {
	$type = $ARGV[1];	
}

get_loop_time($param);
gen_tcl_for_irun($param,$type);
gen_ucli_for_vcs($param,$type);
gen_pf_info();

sub get_scope {
	my ($param) = @_;
	
	my $scope;

	open(F, "<", "flist");
	while ($line=<F>) {
		if ($line =~ m!/([\da-zA-Z]+_core_top).v$!){
			$scope = sprintf "system.%s", $1;
			last;
		}

		if ($line =~ m!/([\da-zA-Z]+_core)/!){
			$scope = sprintf "system.%s", $1;
			last;
		}
	}
	close(F);

	$param->{'scope'}=$scope;
}

sub get_loop_time {
	my ($param) = @_;

	my ($dump_start_time, $dump_end_time);
	my ($loop_start_pc, $loop_end_pc);
	my $line;

	$loop_start_pc = `grep -P "ipipe(:\\d+)?:@" one_loop.log | head -1`;
	$loop_end_pc   = `grep -P "ipipe(:\\d+)?:@" one_loop.log | tail -1`;

	if ($loop_start_pc =~ /@([\da-fA-F]{6,8})/) {
		$loop_start_pc = $1;
	} else {
		return "prepare_pattern_pc can not find the first pc of loop";
	}
	if ($loop_end_pc =~ /@([\da-fA-F]{6,8})/) {
		$loop_end_pc = $1;
	} else {
		return "prepare_pattern_pc can not find the end pc of pattern loop";
	}

	$dump_start_time = `grep -P "ipipe(:\\d+)?:\@$loop_start_pc" one_loop.log | grep "$loop_start_minfo" | head -1`;
	$dump_end_time = `grep -P "ipipe(:\\d+)?:\@$loop_end_pc" one_loop.log | grep "$loop_end_minfo" | tail -1`;
	
	if ($dump_start_time =~ /(\d+)\.\d+\s+ns:ipipe(:\d+)?:\@$loop_start_pc/){
		$dump_start_time = $1;
	} else {
		return "prepare_pattern_pf can not find timing";
	}
	
	if ($dump_end_time =~ /(\d+)\.\d+\s+ns:ipipe(:\d+)?:\@$loop_end_pc/){
		$dump_end_time = $1;
	} else {
		return ("prepare_pattern_pf can not find timing");
	}

	$param->{'dump_start_time'} = $dump_start_time;
	$param->{'dump_end_time'} = $dump_end_time;
}

sub gen_tcl_for_irun {
	my ($param, $type)=@_;
	
	my $duration;

	unlink("setup_power_sim.tcl");
	unlink("verilog.$type");

	open(F, ">", "setup_power_sim.tcl");
	 
	if (defined($param->{'dump_start_time'}) and $param->{'dump_start_time'} > 0) {
		printf F "run %f ns\n", $param->{'dump_start_time'};
	}
	
	if (defined($param->{'scope'})) {
		printf F "dump$type  -scope %s -internal -output verilog.$type -overwrite -memories\n", $param->{'scope'};
	} else {
		printf F "dump$type  -internal -output verilog.$type -overwrite -memories\n";
	}
	
	if (defined($param->{'dump_end_time'}) and $param->{'dump_end_time'} > $param->{'dump_start_time'}) {
		my $duration = $param->{'dump_end_time'} - $param->{'dump_start_time'};
		printf F "run %f ns\n", $duration;
		printf F "dump$type -end\n";
	}
	printf F "run\n";
	printf F "exit\n";
	close(F);
}

sub gen_ucli_for_vcs {
	my ($param, $type)=@_;
	
	my $duration;

	unlink("setup_power_sim.ucli");
	unlink("verilog.$type");

	open(F, ">", "setup_power_sim.ucli");

	printf F "power -gate_level all mda sv\n";
	if (defined($param->{'dump_start_time'}) and $param->{'dump_start_time'} > 0) {
		printf F "run %f ns\n", $param->{'dump_start_time'};
	}
	if (defined($param->{'scope'})) {
		printf F "power %s\n", $param->{'scope'};
	} else {
		printf F "power system\n";
	}
	printf F "power -enable\n";
	if (defined($param->{'dump_end_time'}) and $param->{'dump_end_time'} > $param->{'dump_start_time'}) {
		my $duration = $param->{'dump_end_time'} - $param->{'dump_start_time'};
		printf F "run %f ns\n", $duration;
	}
	printf F "power -disable\n";
	if (defined($param->{'scope'})) {
		printf F "power -report verilog.$type 1.0e-15 %s\n", $param->{'scope'};
	} else {
		printf F "power -report verilog.$type 1.0e-15 system\n";
	}
	printf F "quit\n";

	close(F);
}

sub gen_pf_info {
	open(F, ">", "pf_info.tcl");
	printf F "set pf_type $type\n";
	printf F "set pf_file verilog.$type\n";
	close(F);
}

