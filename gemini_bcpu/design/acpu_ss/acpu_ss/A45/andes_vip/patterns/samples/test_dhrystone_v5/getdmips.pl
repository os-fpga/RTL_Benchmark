#!/usr/bin/perl
use strict;
use warnings;

sub bighex {
	use bigint;
	my ($in) = @_;
	my $out = hex $in;
	return $out;
}

#### global parameters ####
my $log_file = "verilog.log";
my $one_loop_file = "one_loop.log";
my $output_one_loop = 1;
my $debug = 0;
my $coremark = 0;
my $success = 0;

my $icnt;		# dynamic instruction count
my $ucnt;		# dynamic micro instruction count
my %loop_start_time;
my %loop_stop_time;
my %repeat_cnt;
my %loop_icnt;		# given a pc, $loop_icnt{$pc} is the instruction count of loop starting at $pc (as if $pc is the begining of the loop)
my %loop_ucnt;
my %loop_time;
my %loop_icnt_total;	
my %loop_ucnt_total;
my %loop_time_total;
my $last_pc = 0;
my %last_icnt;
my %last_ucnt;
my %last_time;
my $clock_period = 9999;
my $last_timestamp = 0;
my $given_clock_period;
my %first_icnt;

if (!open LOG, "<", $log_file) {
	print "cannot read $log_file\n";
	exit(1);
}

#### find all loop begin candidates ####
while (my $line = <LOG>){
	chomp $line;
	# set $success to 1 only when simulation finished or stopped by end of dumping
	if ($line =~ m/(simulation stopped by end of dumping)|(SIMULATION FINISHED)|(SIMULATION PASSED)/) {
		$success = 1;
		next;
	}
	# save given clock period
	if ($line =~ m/(\d+(\.\d+)?)(\s*[pn]s)?:ipipe:-- clock period =\s*(\d+(\.\d+)?)/) {
		$given_clock_period = $4;
		next;
	}
	# if no given clock period found, find the minimum clock period from each difference of two consecutive completed instructions
	if (!defined $given_clock_period and $line =~ m/^(\d+\.\d+).+?ipipe:\d*:*@/) { 
		my $timestamp = $1;
 		my $time_diff = $timestamp - $last_timestamp;
		$clock_period = $time_diff if (($clock_period > $time_diff) and ($time_diff > 0)); 
		$last_timestamp = $timestamp;
	}
	# count remained micro-instructions
	if ($line =~ m/(mseg=[01])|(micro=1)$/) {
		++$ucnt;
		next; 
	}

	# scanonly the ipipe statements
	next unless ($line =~ m/(\d+\.\d+).+?ipipe:\d*:*@([0-9a-f]+?)=[0-9a-f]+/);
	my ($time, $pc) = ($1, bighex($2));
	my $branch_offset = $last_pc - $pc;
	my $repeat_cnt = ++$repeat_cnt{$pc};

	++$ucnt;
	++$icnt;

	$first_icnt{$pc} = $icnt if !exists($first_icnt{$pc});

	# we are only interested in backward branches:
	if ($branch_offset > 4) {
		# 1. we wish to wait for caches to warm up, so one loop should be executed at least two times
		# 2. if the desired iteration of one loop is the 3rd one, the startpoint of one loop should repeat 3 times 
		#    and repeat_cnt of the startpoint of one loop should appear for 4 times in order to capture
		#    the start time and end time of the 3rd one loop
		if ($repeat_cnt > 20) {
			my $icnt_dist = $icnt - $last_icnt{$pc};
			my $ucnt_dist = $ucnt - $last_ucnt{$pc};

			if (!exists($loop_icnt{$pc}) or ($loop_icnt{$pc} > $icnt_dist)) {
				$loop_icnt{$pc} = $icnt_dist;
				$loop_ucnt{$pc} = $ucnt_dist;
				$loop_time{$pc} = $time - $last_time{$pc};
				$loop_start_time{$pc} = $last_time{$pc};
				$loop_stop_time{$pc} = $time;
			}
		}
		if (($repeat_cnt > 20) and ($repeat_cnt <= 100)) {
			my $icnt_dist = $icnt - $last_icnt{$pc};
			my $ucnt_dist = $ucnt - $last_ucnt{$pc};
			if (!exists($loop_icnt_total{$pc})) {
				$loop_icnt_total{$pc} = 0; 
				$loop_ucnt_total{$pc} = 0;
				$loop_time_total{$pc} = 0;

			}
			$loop_icnt_total{$pc} = $icnt_dist + $loop_icnt_total{$pc}; 
			$loop_ucnt_total{$pc} = $ucnt_dist + $loop_ucnt_total{$pc}; 
			$loop_time_total{$pc} = $time - $last_time{$pc} + $loop_time_total{$pc}
		}
	}
	$last_icnt{$pc} = $icnt;
	$last_ucnt{$pc} = $ucnt;
	$last_time{$pc} = $time;
	$last_pc = $pc;
}

close LOG;

if (!$success) {
	printf "Calculation of %s score failed due to simulation failure!\n", ($coremark)?"COREMARK":"DMIPS" if $debug;
	exit(0);
}

my @loop_begin_candidates = sort {
		my $cmp = $loop_icnt{$b} <=> $loop_icnt{$a};
		if ($cmp == 0) {
			$cmp = $first_icnt{$a} <=> $first_icnt{$b};
		}
		return $cmp;
	} keys %loop_icnt;

if (! exists $loop_begin_candidates[0]) {
	print "No loops found!\n";
	exit(0);
}

my $one_loop_pc = $loop_begin_candidates[0];
my $one_loop_icnt = $loop_icnt_total{$one_loop_pc}/80;
my $one_loop_ucnt = $loop_ucnt_total{$one_loop_pc}/80;
my $one_loop_time = $loop_time_total{$one_loop_pc}/80;
my $one_loop_start_time = $loop_start_time{$one_loop_pc};
my $one_loop_stop_time = $loop_stop_time{$one_loop_pc};

#### show debug information ####
if ($debug) {
	for (my $i = 0; $i < 10; ++$i) {
		my $pc = $loop_begin_candidates[$i];
		printf "PC: 0x%08x => first_icnt: %d => cnt: %d => icnt: %d\n", $pc, $first_icnt{$pc}, $repeat_cnt{$pc}, $loop_icnt{$pc};
	}
	printf "One loop pc:   0x%08x\n", $one_loop_pc;
	printf "One loop icnt: %d\n", $one_loop_icnt;
}

#### show coremark/dmips benchmark result ####

$clock_period = $given_clock_period if defined $given_clock_period;

my $one_loop_cycles = $one_loop_time/$clock_period;

if ($coremark == 1) {
	my $coremark_mhz = 1000000.0/$one_loop_cycles;

	open F,">coremark.log" or exit 0;
	printf F "======= COREMARK report =======\n";
	printf F "insn per loop = %d\n", $one_loop_icnt;
	printf F "micro per loop = %d\n", $one_loop_ucnt;
	printf F "cycle per loop = %d\n", $one_loop_cycles;
	printf F "COREMARK/MHz = %f\n", $coremark_mhz;
	printf F "============================\n";
}
else {
	my $dmips_mhz = 1000000.0/$one_loop_cycles/1757;

	open F,">dmips.log" or exit 0;
	printf F "======= DMIPS report =======\n";
	printf F "insn per loop = %d\n", $one_loop_icnt;
	printf F "micro per loop = %d\n", $one_loop_ucnt;
	printf F "cycle per loop = %d\n", $one_loop_cycles;
	printf F "DMIPS/MHz = %f\n", $dmips_mhz;
	printf F "============================\n";
}
close F;

exit(0) unless $output_one_loop;

#### output found outer loop with max icnt to one_loop.log ####

if (!open(LOG, "<", $log_file)) {
	print "cannot read $log_file\n";
	exit(1);
}
if (!open(ONE_LOOP, ">", $one_loop_file)) {
	print "cannot read $one_loop_file\n";
	exit(1);
}

my $start_output_one_loop = 0;

while (my $line = <LOG>){
	if ($line =~m/^(\d+\.\d+).+?ipipe:\d*:*@/) { 
		my $time = $1;
		$start_output_one_loop = 1 if $time eq $one_loop_start_time;
		last if $time eq $one_loop_stop_time;
	}
	print ONE_LOOP $line if $start_output_one_loop;
}

close(LOG);
close(ONE_LOOP);

