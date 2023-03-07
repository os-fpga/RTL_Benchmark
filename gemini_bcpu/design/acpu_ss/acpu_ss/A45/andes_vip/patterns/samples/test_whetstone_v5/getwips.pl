#!/usr/bin/perl
use strict;
use warnings;
use DBI;

###########################
# Calcultae Whetstone Result ##
###########################
our $debug = 0;
our $ndsrom_file = "NDSROM.list";
our $verilog_log = "verilog.log";
our $whet_log = "whet.log";
our $one_loop_log = "one_loop.log";
our $clk_period = 99999;
our $time_pc;
our $iter = 1; ### compute MWIPS using the execution time in the second iteration
our $time_last = 0;
our @exec_time;

our @fpu_type = ("MFLOPS", "MFLOPS", "MOPS  ", "MOPS  ", "MOPS  ", "MFLOPS", "MOPS  ", "MOPS  ");
our @fpu_heading = ("N1 array elements",
                    "N2 array as function parameter",
                    "N3 (integer) condictional jumps",
                    "N4 integer arithmetic",
                    "N5 trig functions (sin,cos,atan)",
                    "N6 procedure calls",
                    "N7 array reference",
                    "N8 standard function (exp,sqrt,log)");
our @fpu_ops  = (12*16*10, 14*96, 345*3, 210*15, 32*26, 899*6, 616*3, 93*4);

open(NDSROM, $ndsrom_file) or die "Can't open file $ndsrom_file: $!\n";
while (my $line = <NDSROM>) {
        if ($line =~ m/^[0]*(\w+)\W\<dtime\>\s*:/) {
                $time_pc = $1;
                last;
        }
}
close(NDSROM);

printf("time() found \@PC=$time_pc\n") if $debug;
die "time() not found\n" if (!$time_pc);


open(VERILOG, $verilog_log) or die "Can't open file $verilog_log: $!\n";
open(ONE_LOOP, ">$one_loop_log") or die "Can't open file $one_loop_log: $!\n";

our $i = 0;
our $test_num = 8; ### there are 8 different test cases in whetstones()
our $clk_found = 0;
our $clk_pre = 0;
while (my $line = <VERILOG>) {
        chomp($line);
        #if ($line =~ m/^([\d.]*) ns:ipipe.+EDM_CTL/) {
        if ($line =~ m/^([\d.]*) ns:ipipe:(.*)?@[0]*($time_pc\b)/) {
                my $time = $1;
                printf("time():time=$time\n") if ($debug);
                my $before_test_case = (($i % 2) == 0);
                if ($before_test_case) {
                        ### get time before each test case
                        $time_last = $time;
                }
                else {
                        my $iteration = $i/2/8; ### the number of whetstone iteration
                        my $test_case_no = ($i/2)%8; ### the number of test case
                        ### get time after each test case and compute its execution time
                        printf("execution time[%d][%d]: %.2f\n", $iteration, $test_case_no, ($time - $time_last)) if ($debug);
                        $exec_time[$test_case_no][$iteration] =  ($time - $time_last);
                }
                $i++;
                last if ($i == 32); ### skip while loop when all time() are found
        }
        printf ONE_LOOP "$line\n" if ($i > (16 * $iter));

        next if $clk_found;
        if ($line =~ m/^(\d+)\.(.+)ns:ipipe:(.+)@([^=\s]+)/) {
                #printf("clk=$1\n") if ($debug);
                my $clk_cur = int $1;
                if ($clk_pre != $clk_cur) {
                        my $clk_diff = $clk_cur - $clk_pre;
                        next if $clk_diff == 0;

                        $clk_period = $clk_diff if (($clk_period > $clk_diff) and ($clk_diff > 0));
                        $clk_pre = $clk_cur;
                }
        }
        elsif ($line =~ m/^(\d+)\.(.+)ns:ipipe:-- clock period =\s*(\d+)\.(.+)/) {
                $clk_period = $3;
                $clk_found = 1;
        }

}

close(VERILOG);
close(ONE_LOOP);

die "clock not found\n" if (!$clk_found && !$clk_period);

#################
#Calculate Performance
#################
open(MWIPS_OUT,  ">$whet_log") || die "Can't open file $whet_log: $!\n";

my $total_time = 0;
my $time = 0;
foreach my $i (0..(scalar @exec_time-1)) {
	if ($i == 0) {
		$time = $exec_time[$i][$iter]/10;
	} else {
		$time = $exec_time[$i][$iter];
	}
        printf(MWIPS_OUT "%-35s: Fpu ops/cycle = %10.2f,  %s = %10.2f, (delta_t=%8d)\n",
                $fpu_heading[$i], $fpu_ops[$i]/(($time)/$clk_period),
                $fpu_type[$i],    $fpu_ops[$i]/(($time)/1000)
                ,$time
        );
        $total_time += $time;
}
	$total_time = $total_time/10;

my $mwips     = 1/(10*$total_time/1000000000);
my $whetstone = $mwips/(1000/$clk_period);
printf(MWIPS_OUT "MWIPS = %20.2f, MWIPS/MHz = %20.2f\n", $mwips, $whetstone);

printf(MWIPS_OUT "\nCore clock period = %d (for the accuracy, the clk period shoud be an integer)\n", $clk_period);
close(MWIPS_OUT);
