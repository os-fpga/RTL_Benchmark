#!/usr/bin/perl
use Getopt::Long;

use strict vars;


use constant {
	SRC_NONE => 0,
	SRC_IMM  => 1,
	SRC_VS1  => 2,
	SRC_XS1  => 3,
	SRC_FS1  => 4,
	SRC_VS2  => 5,
	DST_VD   => 0,
	DST_XD   => 1,
	DST_FD   => 2,
};

use Switch;
our $misa_base;
our $rvv = 0;
our $instn;
our $pc;
our $rd;
our $rs1;
our $rs2;
our $rs3;
our $rm;
our $rd_q;
our $rs1_q;
our $rs2_q;
our $func3;
our $func7;
our %labels;
our %ace_disassembly;

our $OptXLEN = 32;
our $OptInstall = 0;
our $help = 0;

# perl -MO=Bytecode,-H,-oipipe_decode ipipe_decode.pl
sub recompile {
	my ($pl, $prog_name) = @_;
	printf "compiling bytecode for $pl\n";
	system("perl -MO=Bytecode,-H,-o$prog_name $pl");
	exit if ($? != 0);
	exit if ! -f $prog_name;

	my $mode =  (stat($prog_name))[2] & 07777;
	$mode |= 0755;
	chmod($mode, $prog_name);
}

sub usage {
	my $pname = $0;
	$pname =~ s/.*\///;
	printf "Usage:\n";
	printf "\t$pname -xlen=[32|64|128] verilog.log\n";
	printf "\tcat verilog.log | $pname\n";
	printf "\tzcat verilog.log.gz | fgrep ipipe | $pname\n";
	exit(0);
}
my $prog_name = $0;
my $pl = $prog_name;
if ($prog_name =~ m/\.pl$/) {
	$prog_name =~ s/\.pl$//;
}
else {
	$pl = $pl . ".pl";
}

GetOptions ("xlen=i"	=> \$OptXLEN,
	    "install"	=> \$OptInstall,
	    "help"	=> \$help,
	    )
				       or die("Error in command line arguments\n");

if ($help) {
	usage();
}

if ($OptInstall) {
	recompile($pl, $prog_name);
	exit(0);
}

if ($OptXLEN == 32) {
	$misa_base = 1;
}
elsif ($OptXLEN == 64) {
	$misa_base = 2;
}
else {
	$misa_base = 3;
}

if (-f $prog_name and -f $pl and -B $prog_name) {
	if (-w $prog_name and -C $pl < -C $prog_name) {
		recompile($pl, $prog_name);
		if (-C $pl > -C $prog_name) {
			exec($prog_name, @ARGV);
		}
	}
}


# Add for Seearch Config ####################################################
my $push_pop_support = 0;
my $rv64 = 0;
my $config_f;
if (-f "config.inc") {
	open($config_f, "config.inc");
}

if (defined($config_f)) {
	while (my $line = <$config_f>) {
		if (($line =~ m/NDS_PUSHPOP_TYPE/) && ($line =~ m/1/)) {
			$push_pop_support = 1;	
		}
		if (($line =~ m/NDS_ISA_BASE/) && ($line =~ m/64/)) {
			$rv64 = 1;	
		}
	}
	close($config_f);
}

sub calculate_sp_adj {
	my ($reg_count_idx) = @_;
	my @reg_count	    = ( 1, 2, 3, 4, 5, 7, 10, 13);
        my $offset          = $rv64 ? 8 : 4;
        my $size            = @reg_count[$reg_count_idx]*$offset;
        my $q_value         = int($size / 16);                      # note : $q_value may be a floating value.
        my $r_value         = $size % 16;
        $size               = ($r_value != 0) ? ($q_value + 1)*16 : $size;
        return $size;
}
#############################################################################


my $fh;
if (-f "NDSROM.list") {
	open($fh, "NDSROM.list");
}
elsif (-f "NDSROM.list.gz") {
	open($fh, "gzcat NDSROM.list.gz|");
}

if (defined($fh)) {
	while (my $line = <$fh>) {
		if ($line =~ m/^([0-9a-f]+) <([a-zA-Z_\@\.]+)>:/) {
			my ($addr, $lab) = (hex $1, $2);
			$labels{$addr} = $lab;
		}
		elsif ($line =~ m/\s*([0-9a-f]+):\s+([0-9a-f]+)\s+(.*)/) {
			my ($pc, $instn, $disassembly) = ($1, hex $2, $3);
			my $is_custom3 = ($instn & 0x7f) == ((30 << 2) | 0x3);
			if ($is_custom3 and !exists $ace_disassembly{$instn}) {
				$disassembly =~ s/\s*#.*//;
				$disassembly =~ s/<[^>]+>//;
				$disassembly =~ s/\s+/ /g;
				my $instn_hex = sprintf "%08x", $instn;
				$ace_disassembly{$instn_hex} = $disassembly;
			}
		}
		elsif ($line =~ m/file format elf(\d+)-/) {
			my $rv = $1;
			$OptXLEN = $rv;
			if ($rv == 64) {
				$misa_base = 2;
			}
		}
	}
	close($fh);
}

while (my $line = <>) {
	if ($line =~ m/(:ipipe(?:_incomplete)?)? misa=([0-9a-f]+)/) {
		my $misa = $2;
		if (length($misa) == 32) { $misa_base = 3; }
		elsif (length($misa) == 8) { $misa_base = 1; }
		else { $misa_base = 2; }

                my $misa_hex = hex $2;
                if (($misa_hex & 0x200000) > 0) { $rvv = 1; }
                printf "rvv = $rvv\n";
	}
	if ($line =~ m/(:ipipe(?:_incomplete)?:(\d:)?@([0-9a-f]+)=)([0-9a-f]+)/) {
		$pc = hex $3;
		$instn = hex $4;
		my $asm = decode($instn);
		$asm .= " " x (27 - length $asm);
		$line =~ s//$1$4 $asm/;

		if ($line =~ m/\scause/) {
			my $cause = decode_xcept($line);

			chomp($line);
			$line .= "$cause\n";
		}
	} elsif ($line =~ m/\scause/) {
		# message without PC would fall into this block
		# e.g 17930.50 ns:ipipe:0:debug cause=3
		my $cause = decode_xcept($line);

		chomp($line);
		$line .= "$cause\n";
	}
	if ($line =~ /istatus=([0-9a-f]+)/) {
		my $istatus = $1;
		my $status = decode_istatus($istatus);
		$line =~ s/(istatus=[0-9a-f]+)/$1 ($status)/;
	}
	print $line;
}

sub decode_xcept {
	my ($line) = @_;

	my %irq_xcept_code = (
		0 => 'User SW interrupt',
		1 => 'Supervisor SW interrupt',
		2 => 'Reserved',
		3 => 'Machine SW interrupt',
		4 => 'User timer interrupt',
		5 => 'Supervisor timer interrupt',
		6 => 'Reserved',
		7 => 'Machine timer interrupt',
		8 => 'User external interrupt',
		9 => 'Supervisor external interrupt',
		10 => 'Reserved',
		11 => 'Machine external interrupt',
		16 => 'Machine slave port ECC error interrupt',
		17 => 'Machine bus read (dcause = 1) / write (dcause = 2) transaction error interrupt',
		18 => 'Machine performance monitor overflow interrupt',
		24 => 'Machine ace error interrupt',
		272 => 'Supervisor slave port ECC error interrupt',
		273 => 'Supervisor bus write transaction error interrupt',
		274 => 'Supervisor performance monitor overflow interrupt',
		280 => 'Supervisor ace error interrupt',
       );

	my %instr_xcept_code = (
		0 => 'Instruction address misaligned',
		1 => 'Instruction access fault',
		2 => 'Illegal instruction',
		3 => 'Breakpoint',
		4 => 'Load address misaligned',
		5 => 'Load access fault',
		6 => 'Store/AMO address misaligned',
		7 => 'Store/AMO access fault',
		8 => 'Environment call from U-mode',
		9 => 'Environment call from S-mode',
		10 => 'Reserved',
		11 => 'Environment call from M-mode',
		12 => 'Instruction page fault',
		13 => 'Load page fault',
		14 => 'Reserved',
		15 => 'Store/AMO page fault',
		32 => 'Stack overflow exception',
		33 => 'Stack underflow exception',
		44 => 'ACE register file rd index confliction',
      );

	my %dbg_xcept_code = (
		0 => 'Reserved',
		1 => 'Ebreak',
		2 => 'Trigger module',
		3 => 'Halt request',
		4 => 'Single step',
		5 => 'Halt on reset',
		6 => 'Halt group request',
      );

	my ($code, $cause, $irq);

	if ($line =~ m/exception/) {
		($code) = $line =~ m/exception cause=([0-9a-f]+)/;
		$code = hex($code);
		$cause = $instr_xcept_code{$code} || 'Unknown';
	} elsif ($line =~ m/interrupt/) {
		# ext = 0 (normal irq), ext = 1 (vector irq)
		($code, $irq) = $line =~ m/interrupt cause=([0-9a-f]+) ext=([0-9a-f]+)/;
		if ($irq eq '1') {
			# the cause is interrupt source ID in vector IRQ mode
			# we just skip it
			return '';
		}
		$code = hex($code);
		$cause = $irq_xcept_code{$code} || 'Unknown';
	} elsif ($line =~ m/debug/) {
		($code) = $line =~ m/debug cause=([0-9a-f]+)/;
		$code = hex($code);
		$cause = $dbg_xcept_code{$code} || 'Unknown';
	} elsif ($line =~ m/nmi/) {
		return '';
	} else {
		$cause = 'Unknown';
	}

	return " ($cause)";
}

sub decode_istatus {
	my ($i) = @_;
	my $status;
	switch ($i) {
        case "00" { $status = "SUCCESS"; }
	else      { $status = "UNKNOWN_STATUS"; }
	}
	return $status;
}

sub decode {
	my $decode = $instn & 0x3;
	switch($decode) {
	case 0 { return decode00() }
	case 1 { return decode01() }
	case 2 { return decode10() }
	case 3 { return decode11() }
	else { return unknown();}
	}
}

sub str_ireg {
	my ($rr) = @_;
	switch($rr) {
	case 0 { return sprintf "zero" }
	case 1 { return sprintf "ra" }
	case 2 { return sprintf "sp" }
	case 3 { return sprintf "gp" }
	case 4 { return sprintf "tp" }
	case 5 { return sprintf "t0" }
	case 6 { return sprintf "t1" }
	case 7 { return sprintf "t2" }
	case 8 { return sprintf "s0" }
	case 9 { return sprintf "s1" }
	case 10 { return sprintf "a0" }
	case 11 { return sprintf "a1" }
	case 12 { return sprintf "a2" }
	case 13 { return sprintf "a3" }
	case 14 { return sprintf "a4" }
	case 15 { return sprintf "a5" }
	case 16 { return sprintf "a6" }
	case 17 { return sprintf "a7" }
	case 18 { return sprintf "s2" }
	case 19 { return sprintf "s3" }
	case 20 { return sprintf "s4" }
	case 21 { return sprintf "s5" }
	case 22 { return sprintf "s6" }
	case 23 { return sprintf "s7" }
	case 24 { return sprintf "s8" }
	case 25 { return sprintf "s9" }
	case 26 { return sprintf "s10" }
	case 27 { return sprintf "s11" }
	case 28 { return sprintf "t3" }
	case 29 { return sprintf "t4" }
	case 30 { return sprintf "t5" }
	case 31 { return sprintf "t6" }
	else { return sprintf "unknown" }
	}
}

sub str_vreg {
	my ($rr) = @_;
	switch($rr) {
	case  0 { return sprintf "v0" }
	case  1 { return sprintf "v1" }
	case  2 { return sprintf "v2" }
	case  3 { return sprintf "v3" }
	case  4 { return sprintf "v4" }
	case  5 { return sprintf "v5" }
	case  6 { return sprintf "v6" }
	case  7 { return sprintf "v7" }
	case  8 { return sprintf "v8" }
	case  9 { return sprintf "v9" }
	case 10 { return sprintf "v10" }
	case 11 { return sprintf "v11" }
	case 12 { return sprintf "v12" }
	case 13 { return sprintf "v13" }
	case 14 { return sprintf "v14" }
	case 15 { return sprintf "v15" }
	case 16 { return sprintf "v16" }
	case 17 { return sprintf "v17" }
	case 18 { return sprintf "v18" }
	case 19 { return sprintf "v19" }
	case 20 { return sprintf "v20" }
	case 21 { return sprintf "v21" }
	case 22 { return sprintf "v22" }
	case 23 { return sprintf "v23" }
	case 24 { return sprintf "v24" }
	case 25 { return sprintf "v25" }
	case 26 { return sprintf "v26" }
	case 27 { return sprintf "v27" }
	case 28 { return sprintf "v28" }
	case 29 { return sprintf "v29" }
	case 30 { return sprintf "v30" }
	case 31 { return sprintf "v31" }
	else { return sprintf "unknown" }
	}
}
sub str_rm {
	my ($rr) = @_;
	switch($rr) {
	case  0 { return sprintf "rne" }
	case  1 { return sprintf "rtz" }
	case  2 { return sprintf "rdn" }
	case  3 { return sprintf "rup" }
	case  4 { return sprintf "rmm" }
	case  5 { return sprintf "inv" }
	case  6 { return sprintf "inv" }
	case  7 { return sprintf "dyn" }
	else    { return sprintf "unknown_rm" }
	}
}

sub str_freg {
	my ($rr) = @_;
	switch($rr) {
	case  0 { return sprintf "ft0" }
	case  1 { return sprintf "ft1" }
	case  2 { return sprintf "ft2" }
	case  3 { return sprintf "ft3" }
	case  4 { return sprintf "ft4" }
	case  5 { return sprintf "ft5" }
	case  6 { return sprintf "ft6" }
	case  7 { return sprintf "ft7" }
	case  8 { return sprintf "fs0" }
	case  9 { return sprintf "fs1" }
	case 10 { return sprintf "fa0" }
	case 11 { return sprintf "fa1" }
	case 12 { return sprintf "fa2" }
	case 13 { return sprintf "fa3" }
	case 14 { return sprintf "fa4" }
	case 15 { return sprintf "fa5" }
	case 16 { return sprintf "fa6" }
	case 17 { return sprintf "fa7" }
	case 18 { return sprintf "fs2" }
	case 19 { return sprintf "fs3" }
	case 20 { return sprintf "fs4" }
	case 21 { return sprintf "fs5" }
	case 22 { return sprintf "fs6" }
	case 23 { return sprintf "fs7" }
	case 24 { return sprintf "fs8" }
	case 25 { return sprintf "fs9" }
	case 26 { return sprintf "fs10" }
	case 27 { return sprintf "fs11" }
	case 28 { return sprintf "ft8"  }
	case 29 { return sprintf "ft9"  }
	case 30 { return sprintf "ft10" }
	case 31 { return sprintf "ft11" }
	else { return sprintf "unknown" }
	}
}

sub str_creg {
	my ($rr) = @_;
	switch($rr) {
	case 0 { return sprintf "s0" }
	case 1 { return sprintf "s1" }
	case 2 { return sprintf "a0" }
	case 3 { return sprintf "a1" }
	case 4 { return sprintf "a2" }
	case 5 { return sprintf "a3" }
	case 6 { return sprintf "a4" }
	case 7 { return sprintf "a5" }
	else { return sprintf "unknown" }
	}
}
sub str_cfreg {
	my ($rr) = @_;
	switch($rr) {
	case 0 { return sprintf "fs0" }
	case 1 { return sprintf "fs1" }
	case 2 { return sprintf "fa0" }
	case 3 { return sprintf "fa1" }
	case 4 { return sprintf "fa2" }
	case 5 { return sprintf "fa3" }
	case 6 { return sprintf "fa4" }
	case 7 { return sprintf "fa5" }
	else { return sprintf "unknown" }
	}
}

sub str_simm5 {
	my ($imm) = @_;
	if ($imm & 0x10) {
		return sprintf "-0x%02x", (0x20-$imm);
	}
	else {
		return sprintf "0x%02x", $imm;
	}
}

sub str_simm6 {
	my ($imm) = @_;
	if ($imm & 0x20) {
		return sprintf "-0x%02x", (0x40-$imm);
	}
	else {
		return sprintf "0x%02x", $imm;
	}
}

sub str_simm7 {
	my ($imm) = @_;
	if ($imm & 0x40) {
		return sprintf "-0x%02x", (0x80-$imm);
	}
	else {
		return sprintf "0x%02x", $imm;
	}
}

sub str_simm8 {
	my ($imm) = @_;
	if ($imm & 0x80) {
		return sprintf "-0x%02x", (0x100-$imm);
	}
	else {
		return sprintf "0x%02x", $imm;
	}
}

sub str_simm9 {
	my ($imm) = @_;
	if ($imm & 0x100) {
		return sprintf "-0x%03x", (0x200-$imm);
	}
	else {
		return sprintf "0x%03x", $imm;
	}
}

sub str_simm10 {
	my ($imm) = @_;
	if ($imm & 0x200) {
		return sprintf "-0x%03x", (0x400-$imm);
	}
	else {
		return sprintf "0x%03x", $imm;
	}
}

sub str_simm12 {
	my ($imm) = @_;
	if ($imm & 0x800) {
		return sprintf "-0x%03x", (0x1000-$imm);
	}
	else {
		return sprintf "0x%03x", $imm;
	}
}

sub str_simm18 {
	my ($imm) = @_;
	if ($imm & 0x20000) {
		return sprintf "-0x%05x", (0x40000-$imm);
	}
	else {
		return sprintf "0x%05x", $imm;
	}
}

sub str_simm19 {
	my ($imm) = @_;
	if ($imm & 0x40000) {
		return sprintf "-0x%05x", (0x80000-$imm);
	}
	else {
		return sprintf "0x%05x", $imm;
	}
}

sub str_simm20 {
	my ($imm) = @_;
	if ($imm & 0x80000) {
		return sprintf "-0x%05x", (0x100000-$imm);
	}
	else {
		return sprintf "0x%05x", $imm;
	}
}
sub str_imm5 {
	my ($imm) = @_;
	return sprintf "0x%02x", $imm;
}

sub str_imm6 {
	my ($imm) = @_;
	return sprintf "0x%02x", $imm;
}

sub str_imm7 {
	my ($imm) = @_;
	return sprintf "0x%02x", $imm;
}

sub str_imm10 {
	my ($imm) = @_;
	return sprintf "0x%03x", $imm;
}

sub str_imm11 {
	my ($imm) = @_;
	return sprintf "0x%03x", $imm;
}


sub str_imm12 {
	my ($imm) = @_;
	return sprintf "0x%03x", $imm;
}

sub str_imm18 {
	my ($imm) = @_;
	return sprintf "0x%05x", $imm;
}

sub str_imm19 {
	my ($imm) = @_;
	return sprintf "0x%05x", $imm;
}


sub str_pc_offset9 {
	my $abs_addr;
	my $rel_addr;
	my $label;
	my $sign;
	my ($imm) = @_;
	if ($imm & 0x100) {
		$abs_addr = $pc + $imm - 0x200;
		$rel_addr = (0x200-$imm);
		$sign = '-';
	}
	else {
		$abs_addr = $pc + $imm;
		$rel_addr = $imm;
		$sign = '+';
	}
	if (exists $labels{$abs_addr}) {
		$label = sprintf "%s:", $labels{$abs_addr};
	}
	return sprintf "%s0x%03x (%s0x%08x)", $sign, $rel_addr, $label, $abs_addr;
}

sub str_pc_offset12 {
	my $abs_addr;
	my $rel_addr;
	my $label;
	my $sign;
	my ($imm) = @_;
	if ($imm & 0x800) {
		$abs_addr = $pc + $imm - 0x1000;
		$rel_addr = (0x1000-$imm);
		$sign = '-';
	}
	else {
		$abs_addr = $pc + $imm;
		$rel_addr = $imm;
		$sign = '+';
	}
	if (exists $labels{$abs_addr}) {
		$label = sprintf "%s:", $labels{$abs_addr};
	}
	return sprintf "%s0x%04x (%s0x%08x)", $sign, $rel_addr, $label, $abs_addr;
}

sub str_pc_offset13 {
	my $abs_addr;
	my $rel_addr;
	my $label;
	my $sign;
	my ($imm) = @_;
	if ($imm & 0x1000) {
		$abs_addr = $pc - 0x2000 + $imm;
		$rel_addr = (0x2000-$imm);
		$sign = '-';
	}
	else {
		$abs_addr = $pc + $imm;
		$rel_addr = $imm;
		$sign = '+';
	}
	if (exists $labels{$abs_addr}) {
		$label = sprintf "%s:", $labels{$abs_addr};
	}
	return sprintf "%s0x%04x (%s0x%08x)", $sign, $rel_addr, $label, $abs_addr;
}

sub str_pc_offset21_jal {
	my $abs_addr;
	my $rel_addr;
	my $label;
	my $sign;
	my ($imm) = @_;
	if ($imm & 0x100000) {
		$abs_addr = $pc + $imm - 0x200000;
		$rel_addr = (0x200000-$imm);
		$sign = '-';
	}
	else {
		$abs_addr = $pc + $imm;
		$rel_addr = $imm;
		$sign = '+';
	}
	if (exists $labels{$abs_addr}) {
		$label = sprintf "%s:", $labels{$abs_addr};
	}
	return sprintf "%s0x%05x (%s0x%08x)", $sign, $rel_addr, $label, $abs_addr;
}

sub load {
	my $str_op;
	my $sign = 1;
	my $imm = ($instn >> 20) & 0xfff;
	switch($func3) {
	case 0 { $str_op = "lb" }
	case 1 { $str_op = "lh" }
	case 2 { $str_op = "lw" }
	case 3 { if ($misa_base == 2) { $str_op = "ld"; } else { return unknown(); } }
	case 4 { $str_op = "lbu" ; $sign = 0; }
	case 5 { $str_op = "lhu" ; $sign = 0; }
	case 6 { if ($misa_base == 2) { $str_op = "lwu"; } else { return unknown(); } $sign = 0; }
	else   { return unknown(); }
	}
	return sprintf "%s %s, %s (%s)", $str_op, str_ireg($rd), ($sign) ? str_simm12($imm) : str_imm12($imm), str_ireg($rs1) ;
}

sub load_fp {
	my $str_op;

        if ($rvv) {
                my $nf    = ($instn >> 29) & 0x7;
                $nf = $nf + 1;
                my $mew   = ($instn >> 28) & 0x1;
                my $mop   = ($instn >> 26) & 0x3;
                my $vm    = ($instn >> 25) & 0x1;
                my $lumop = ($instn >> 20) & 0x1f;

                if (($func3 == 1) || ($func3 == 2) || ($func3 == 3) || ($func3 == 4)) {
	                my $imm   = ($instn >> 20) & 0xfff;
                        switch($func3) {
                        case 1 { $str_op = "flh" }
                        case 2 { $str_op = "flw" }
                        case 3 { $str_op = "fld" }
                        case 4 { $str_op = "flq" }
                        else   { return unknown();}
                        }
                        return sprintf "%s %s, %s (%s)", $str_op, str_freg($rd), str_simm12($imm), str_ireg($rs1);
                }
                elsif ($mop == 0) { # unit-stride unsigned load
                        if ($lumop == 16) { # fault-only-first
				if ($mew == 0) {
                                switch($func3) {
					case 0 { $str_op = "vle8ff.v" }
					case 5 { $str_op = "vle16ff.v" }
					case 6 { $str_op = "vle32ff.v" }
					case 7 { $str_op = "vle64ff.v" }
					else   { return unknown();}
					}
				} elsif ($mew == 1) {
					switch($func3) {
					case 0 { $str_op = "vle128ff.v" }
					case 5 { $str_op = "vle256ff.v" }
					case 6 { $str_op = "vle512ff.v" }
					case 7 { $str_op = "vle1024ff.v" }
					else   { return unknown();}
                                }
				} else {
					return unknown();
                        }
                                }
			elsif ($lumop == 8) {
				if ($vm == 1) {
                                        my $hint;
                                        if ($mew == 0) {
                                                switch($func3) {
					        case 0 { $hint = "8" }
					        case 5 { $hint = "16" }
					        case 6 { $hint = "32" }
					        case 7 { $hint = "64" }
					        else   { return unknown();}
                                                }
                                        } elsif ($mew == 1) {
					        switch($func3) {
					        case 0 { $hint = "128" }
					        case 5 { $hint = "256" }
					        case 6 { $hint = "512" }
					        case 7 { $hint = "1024" }
					        else   { return unknown();}
                        }
                                        } else {
                                return unknown();
                        }

					switch($nf) {
					case 1 { $str_op = "vl1re$hint.v" }
					case 2 { $str_op = "vl2re$hint.v" }
					case 4 { $str_op = "vl4re$hint.v" }
					case 8 { $str_op = "vl8re$hint.v" }
					else   { return unknown();}
					}

                        }
                        else {
					return unknown();
                        }
                }
                        elsif ($lumop == 0) {
				if ($mew == 0) {
                                switch($func3) {
					case 0 { $str_op = "vle8.v" }
					case 5 { $str_op = "vle16.v" }
					case 6 { $str_op = "vle32.v" }
					case 7 { $str_op = "vle64.v" }
					else   { return unknown();}
					}
				} elsif ($mew == 1) {
					switch($func3) {
					case 0 { $str_op = "vle128.v" }
					case 5 { $str_op = "vle256.v" }
					case 6 { $str_op = "vle512.v" }
					case 7 { $str_op = "vle1024.v" }
					else   { return unknown();}
                                }
				} else {
					return unknown();
                        }
					}
			elsif ($lumop == 11) {
				if ($mew == 0 and $vm == 1 and $func3 == 0) {
					$str_op = "vle1.v";
				}
				else {
					return unknown();
                                }
                        }
                        else {
                                return unknown();
                        }
                        $str_op = Zvlsseg_insert($nf, $str_op);
                        if ($vm) {
                                return sprintf "%s %s, (%s)", $str_op, str_vreg($rd), str_ireg($rs1);
                        }
                        else {
                                return sprintf "%s %s, (%s), v0.t", $str_op, str_vreg($rd), str_ireg($rs1);
                        }
                }
                elsif ($mop == 1) { # indexed-unordered load
                        if ($mew == 0) {
                        switch($func3) {
				case 0 { $str_op = "vluxei8.v" }
				case 5 { $str_op = "vluxei16.v" }
				case 6 { $str_op = "vluxei32.v" }
				case 7 { $str_op = "vluxei64.v" }
				else   { return unknown();}
				}
			} else {
				return unknown();
                        }
                        $str_op = Zvlsseg_insert($nf, $str_op);
                        if ($vm) {
                                return sprintf "%s %s, (%s), %s", $str_op, str_vreg($rd), str_ireg($rs1), str_vreg($rs2);
                        }
                        else {
                                return sprintf "%s %s, (%s), %s, v0.t", $str_op, str_vreg($rd), str_ireg($rs1), str_vreg($rs2);
                        }
                }
                elsif ($mop == 2) { # strided load
			if ($mew == 0) {
                        switch($func3) {
				case 0 { $str_op = "vlse8.v" }
				case 5 { $str_op = "vlse16.v" }
				case 6 { $str_op = "vlse32.v" }
				case 7 { $str_op = "vlse64.v" }
				else   { return unknown();}
                        }
			} elsif ($mew == 1) {
                        switch($func3) {
				case 0 { $str_op = "vlse128.v" }
				case 5 { $str_op = "vlse256.v" }
				case 6 { $str_op = "vlse512.v" }
				case 7 { $str_op = "vlse1024.v" }
				else   { return unknown();}
				}
			} else {
				return unknown();
                        }
                        $str_op = Zvlsseg_insert($nf, $str_op);
                        if ($vm) {
                                return sprintf "%s %s, (%s), %s", $str_op, str_vreg($rd), str_ireg($rs1), str_ireg($rs2);
                        }
                        else {
                                return sprintf "%s %s, (%s), %s, v0.t", $str_op, str_vreg($rd), str_ireg($rs1), str_ireg($rs2);
                        }
                }
                elsif ($mop == 3) { # indexed-ordered load
                        if ($mew == 0) {
                        switch($func3) {
				case 0 { $str_op = "vloxei8.v" }
				case 5 { $str_op = "vloxei16.v" }
				case 6 { $str_op = "vloxei32.v" }
				case 7 { $str_op = "vloxei64.v" }
				else   { return unknown();}
				}
			} else {
				return unknown();
                        }
                        $str_op = Zvlsseg_insert($nf, $str_op);
                        if ($vm) {
                                return sprintf "%s %s, (%s), %s", $str_op, str_vreg($rd), str_ireg($rs1), str_vreg($rs2);
                        }
                        else {
                                return sprintf "%s %s, (%s), %s, v0.t", $str_op, str_vreg($rd), str_ireg($rs1), str_vreg($rs2);
                        }
                }
                else {
                        return unknown();
                }
        }
        else {
	        my $imm = ($instn >> 20) & 0xfff;
        	switch($func3) {
        	case 0 { $str_op = "flhw" }
        	case 1 { $str_op = "flh" }
        	case 2 { $str_op = "flw" }
        	case 3 { $str_op = "fld" }
        	case 4 { $str_op = "flq" }
        	else   { return unknown();}
        	}
        	return sprintf "%s %s, %s (%s)", $str_op, str_freg($rd), str_simm12($imm), str_ireg($rs1) ;
        }
}

sub Zvlsseg_insert {
        my ($nf, $str_op_src) = @_;
        my $str_op;

        if (($nf > 1) & ($str_op_src =~ /(v[ls][s|x|ux]?)([e|ei]\d+(ff)?)\.v/)) {
                        my $vls = $1;
                my $edff = $2;
                        $str_op = $1."seg$nf".$2.".v";
        } else {
                $str_op = $str_op_src;
        }  
        return $str_op;
}

sub custom0 {
	my $imm;
	my $str_op;
	my $st = 0;
	my $sign = 1;
	my $func2 = $func3 & 0x3;
	switch($func2) {
	case 0 { $str_op = "lbgp" }
	case 1 { $str_op = "addigp" }
	case 2 { $str_op = "lbugp"; $sign = 0; }
	case 3 { $str_op = "sbgp"; $st = 1; }
	else { return unknown();}
	}
	if ($st) {
		my $imm0	= ($instn >> 14)& 0x1;
		my $imm4_1	= ($instn >> 7) & 0x1e;
		my $imm10_5	= ($instn >> 20)& 0x7e0;
		my $imm11	= ($instn << 4)	& 0x800;
		my $imm14_12	= ($instn >> 5) & 0x7000;
		my $imm16_15	= ($instn)	& 0x18000;
		my $imm17	= ($instn >> 14)& 0x20000;
		$imm = $imm0 + $imm4_1 + $imm10_5 + $imm11 + $imm14_12 + $imm16_15 + $imm17;
		return sprintf "%s %s, %s", $str_op, str_ireg($rs2), str_simm18($imm);
	}
	else {
		my $imm0	= ($instn >> 14)& 0x1;
		my $imm10_1	= ($instn >> 20)& 0x7fe;
		my $imm11	= ($instn >> 9)	& 0x800;
		my $imm14_12	= ($instn >> 5) & 0x7000;
		my $imm16_15	= ($instn)	& 0x18000;
		my $imm17	= ($instn >> 14)& 0x20000;
		$imm = $imm0 + $imm10_1 + $imm11 + $imm14_12 + $imm16_15 + $imm17;
		return sprintf "%s %s, %s", $str_op, str_ireg($rd),  ($sign) ? str_simm18($imm) : str_imm18($imm);
	}
}

sub misc_mem {
	my $predecessor = ($instn >> 24) & 0xf;
	my $successor = ($instn >> 20) & 0xf;
	switch($func3) {
	case 0 { return sprintf "fence (predecessor:%s, successor:%s)", $predecessor, $successor;}
	case 1 { return sprintf "fence.i" }
	else   { return unknown();}
	}
}

sub op_imm {
	my $str_op;
	my $shift = 0;
	my $subop7 = ($instn >> 25) & 0x7f;
	my $subop6 = ($instn >> 26) & 0x3f;
	my $imm = ($instn >> 20) & 0xfff;
	my $shamt = ($instn >> 20) & 0x1f;
	my $shamt1 = ($instn >> 20) & 0x3f;
	switch($func3) {
	case 0 { $str_op = "addi" }
	case 1 { $str_op = "slli" ; $shift = 1; }
	case 2 { $str_op = "slti" }
	case 3 { $str_op = "sltiu" }
	case 4 { $str_op = "xori" }
	case 5 {
		if ($misa_base == 2) {
			switch($subop6) {
			case 0  { $str_op = "srli"; }
			case 16 { $str_op = "srai"; }
			else    { return unknown(); }
			}
		}
		else {
			switch($subop7) {
			case 0  { $str_op = "srli"; }
			case 32 { $str_op = "srai"; }
			else    { return unknown(); }
			}
		}
		$shift = 1;
	}
	case 6 { $str_op = "ori" }
	case 7 { $str_op = "andi" }
	else   { return unknown();}
	}
	if ($instn == 0x13) {
		return "nop";
	}
	return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), ($shift) ? ($misa_base == 2) ? $shamt1 : $shamt : str_simm12($imm);
}

sub op_imm_32 {
	my $str_op;
	my $shift = 0;
	my $subop7 = ($instn >> 25) & 0x7f;
	my $subop6 = ($instn >> 26) & 0x3f;
	my $imm = ($instn >> 20) & 0xfff;
	my $shamt = ($instn >> 20) & 0x1f;
	switch($func3) {
	case 0 { $str_op = "addiw" }
	case 1 { $str_op = "slliw" ; $shift = 1; }
	case 5 {
		switch($subop7) {
		case 0  { $str_op = "srliw" }
		case 32 { $str_op = "sraiw" }
		else    { return unknown();}
		}
		$shift = 1;
	}
	else   { return unknown();}
	}
	return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), ($shift) ? $shamt : str_simm12($imm);
}

sub store {
	my $str_op;
	my $imm_upper = ($instn >> 25) & 0x7f;
	my $imm_lower = ($instn >> 7) & 0x1f;
	my $imm = ($imm_upper << 5) + $imm_lower;

	switch($func3) {
	case 0 { $str_op = "sb" }
	case 1 { $str_op = "sh" }
	case 2 { $str_op = "sw" }
	case 3 { if ($misa_base == 2) { $str_op = "sd" } else { return unknown();} }
	else   { return unknown();}
	}
	return sprintf "%s %s, %s (%s)", $str_op, str_ireg($rs2), str_simm12($imm), str_ireg($rs1);
}

sub store_fp {
	my $str_op;
        if ($rvv) {
                my $nf    = ($instn >> 29) & 0x7;
                $nf = $nf + 1;
                my $mew   = ($instn >> 28) & 0x1;
                my $mop   = ($instn >> 26) & 0x3;
                my $vm    = ($instn >> 25) & 0x1;
                my $sumop = ($instn >> 20) & 0x1f;

                if (($func3 == 1) || ($func3 == 2) || ($func3 == 3) || ($func3 == 4)) {
	                my $imm = (($instn >> 20) & 0xfe0) + (($instn >> 7) & 0x1f);
                        switch($func3) {
                        case 1 { $str_op = "fsh" }
                        case 2 { $str_op = "fsw" }
                        case 3 { $str_op = "fsd" }
                        case 4 { $str_op = "fsq" }
                        else   { return unknown();}
                        }
	                return sprintf "%s %s, %s (%s)", $str_op, str_freg($rs2), str_simm12($imm), str_ireg($rs1);
                }
                elsif ($mop == 0) { # unit-stride store
			if ($sumop == 0) {
				if ($mew == 0) {
                        switch($func3) {
					case 0 { $str_op = "vse8.v" }
					case 5 { $str_op = "vse16.v" }
					case 6 { $str_op = "vse32.v" }
					case 7 { $str_op = "vse64.v" }
					else   { return unknown();}
					}
				} elsif ($mew == 1) {
					switch($func3) {
					case 0 { $str_op = "vse128.v" }
					case 5 { $str_op = "vse256.v" }
					case 6 { $str_op = "vse512.v" }
					case 7 { $str_op = "vse1024.v" }
					else   { return unknown();}
					}
				} else {
					return unknown();
				}
			} elsif ($sumop == 8) {
				if ($func3 == 0 and $vm == 1) {
					switch($nf) {
					case 1  { $str_op = "vs1r.v" }
					case 2  { $str_op = "vs2r.v" }
					case 4  { $str_op = "vs4r.v" }
					case 8  { $str_op = "vs8r.v" }
					else   { return unknown();}
					}
				} else { return unknown();}
			} elsif ($sumop == 11) {
				if ($mew == 0 and $vm == 1 and $func3 == 0) {
					$str_op = "vse1.v";
				} else {
					return unknown();
			}
			} else {
				return unknown();
                        }
                        $str_op = Zvlsseg_insert($nf, $str_op);
                        if ($vm) {
                                return sprintf "%s %s, (%s)", $str_op, str_vreg($rd), str_ireg($rs1);
                        }
                        else {
                                return sprintf "%s %s, (%s), v0.t", $str_op, str_vreg($rd), str_ireg($rs1);
                        }
                }
                elsif ($mop == 1) { # indexed-unordered store
			if ($mew == 0) {
                        switch($func3) {
				case 0 { $str_op = "vsuxei8.v" }
				case 5 { $str_op = "vsuxei16.v" }
				case 6 { $str_op = "vsuxei32.v" }
				case 7 { $str_op = "vsuxei64.v" }
				else   { return unknown();}
				}
			} else {
				return unknown();
                        }
                        $str_op = Zvlsseg_insert($nf, $str_op);
                        if ($vm) {
                                return sprintf "%s %s, (%s), %s", $str_op, str_vreg($rd), str_ireg($rs1), str_vreg($rs2);
                        }
                        else {
                                return sprintf "%s %s, (%s), %s, v0.t", $str_op, str_vreg($rd), str_ireg($rs1), str_vreg($rs2);
                        }
                }
                elsif ($mop == 2) { # strided store
			if ($mew == 0) {
                        switch($func3) {
				case 0 { $str_op = "vsse8.v" }
				case 5 { $str_op = "vsse16.v" }
				case 6 { $str_op = "vsse32.v" }
				case 7 { $str_op = "vsse64.v" }
				else   { return unknown();}
				}
			} elsif ($mew == 1) {
				switch($func3) {
				case 0 { $str_op = "vsse128.v" }
				case 5 { $str_op = "vsse256.v" }
				case 6 { $str_op = "vsse512.v" }
				case 7 { $str_op = "vsse1024.v" }
				else   { return unknown();}
				}
			} else {
				return unknown();
                        }
                        $str_op = Zvlsseg_insert($nf, $str_op);
                        if ($vm) {
                                return sprintf "%s %s, (%s), %s", $str_op, str_vreg($rd), str_ireg($rs1), str_ireg($rs2);
                        }
                        else {
                                return sprintf "%s %s, (%s), %s, v0.t", $str_op, str_vreg($rd), str_ireg($rs1), str_ireg($rs2);
                        }
                }
                elsif ($mop == 3) { # indexed-ordered store
			if ($mew == 0) {
                        switch($func3) {
				case 0 { $str_op = "vsoxei8.v" }
				case 5 { $str_op = "vsoxei16.v" }
				case 6 { $str_op = "vsoxei32.v" }
				case 7 { $str_op = "vsoxei64.v" }
				else   { return unknown();}
				}
			} else {
				return unknown();
                        }
                        $str_op = Zvlsseg_insert($nf, $str_op);
                        if ($vm) {
                                return sprintf "%s %s, (%s), %s", $str_op, str_vreg($rd), str_ireg($rs1), str_vreg($rs2);
                        }
                        else {
                                return sprintf "%s %s, (%s), %s, v0.t", $str_op, str_vreg($rd), str_ireg($rs1), str_vreg($rs2);
                        }
                }
                else {
                        return unknown();
                }
        }
        else {
	        my $imm = (($instn >> 20) & 0xfe0) + (($instn >> 7) & 0x1f);
        	switch($func3) {
        	case 0 { $str_op = "fshw" }
        	case 1 { $str_op = "fsh" }
        	case 2 { $str_op = "fsw" }
        	case 3 { $str_op = "fsd" }
        	case 4 { $str_op = "fsq" }
        	else   { return unknown();}
        	}
	        return sprintf "%s %s, %s (%s)", $str_op, str_freg($rs2), str_simm12($imm), str_ireg($rs1);
        }
}

sub custom1 {
	my $imm;
	my $str_op;
	my $st = 0;
	my $sign = 1;
	my $imm11;
	my $imm14_12;
	my $imm16_15;
	my $imm17;
	my $imm18;
	my $imm19;
	my $imm4_1;
	my $imm4_2;
	my $imm4_3;
	my $imm10_5; # for store
	my $imm10_1;
	my $imm10_2;
	my $imm10_3; # for load
	my $st_type = 0;
	my $ld_type = 0;
	switch($func3) {
	case 0 { $str_op = "shgp"; $st_type = 1; $st = 1; }
	case 1 { $str_op = "lhgp"; $ld_type = 1; }
	case 2 { $str_op = "lwgp"; $ld_type = 2; }
	case 3 { if ($misa_base == 2) { $str_op = "ldgp"; $ld_type = 3; } else { return unknown(); } }
	case 4 { $str_op = "swgp"; $st_type = 2; $st = 1; }
	case 5 { $str_op = "lhugp"; $ld_type = 1; $sign = 0; }
	case 6 { $str_op = "lwugp"; $ld_type = 2; $sign = 0;}
	case 7 { if ($misa_base == 2) { $str_op = "sdgp"; $st = 1; } else { return unknown(); } }
	else { return unknown();}
	}
	if ($st) {
		my $shift17	= ($st_type == 1) ? ($instn >> 14) : ($instn << 9);
		my $shift18	= ($st_type == 2) ? ($instn >> 13) : ($instn << 9);
		$imm4_1		= ($instn >> 7) & 0x1e;
		$imm4_2		= $imm4_1 	& 0x1c;
		$imm4_3		= $imm4_1 	& 0x18;
		$imm10_5	= ($instn >> 20)& 0x7e0;
		$imm11		= ($instn << 4)	& 0x800;
		$imm14_12	= ($instn >> 5) & 0x7000;
		$imm16_15	= ($instn)	& 0x18000;
		$imm17		= $shift17	& 0x20000;
		$imm18		= $shift18	& 0x40000;
		$imm19		= ($instn >> 12)& 0x80000;
		$imm =	($st_type == 1) ? ($imm4_1 + $imm10_5 + $imm11 + $imm14_12 + $imm16_15 + $imm17) :
			($st_type == 2) ? ($imm4_2 + $imm10_5 + $imm11 + $imm14_12 + $imm16_15 + $imm17 + $imm18) :
			($imm4_3 + $imm10_5 + $imm11 + $imm14_12 + $imm16_15 + $imm17 + $imm18 + $imm19);
		return sprintf "%s %s, %s", $str_op, str_ireg($rs2), ($st_type == 1) ? str_simm18($imm) : ($st_type == 2) ? str_simm19($imm) : str_simm20($imm);
	}
	else {
		my $shift17	= ($ld_type == 1) ? ($instn >> 14) : ($instn >> 4);
		my $shift18	= ($ld_type == 2) ? ($instn >> 13) : ($instn >> 4);
		$imm10_1	= ($instn >> 20)& 0x7fe;
		$imm10_2	= ($instn >> 20)& 0x7fc;
		$imm10_3	= ($instn >> 20)& 0x7f8;
		$imm11		= ($instn >> 9)	& 0x800;
		$imm14_12	= ($instn >> 5) & 0x7000;
		$imm16_15	= ($instn)	& 0x18000;
		$imm17		= $shift17	& 0x20000;
		$imm18		= $shift18	& 0x40000;
		$imm19		= ($instn >> 12)& 0x80000;
		$imm =	($ld_type == 1) ? $imm10_1 + $imm11 + $imm14_12 + $imm16_15 + $imm17 :
			($ld_type == 2) ? $imm10_2 + $imm11 + $imm14_12 + $imm16_15 + $imm17 + $imm18 :
			$imm10_3 + $imm11 + $imm14_12 + $imm16_15 + $imm17 + $imm18 + $imm19;
		return sprintf "%s %s, %s", $str_op, str_ireg($rd), ($sign) ? ($ld_type == 1) ? str_simm18($imm) : ($ld_type == 2) ? str_simm19($imm) : str_simm20($imm): ($ld_type == 1) ? str_imm18($imm) : str_imm19($imm);
	}
}

sub amo {
        if ($rvv) {
	        switch($func3) {
	        case 2 { return amo_w() }
	        case 3 { return amo_d() }
                case 4 { return amo_q() }
                case 6 { return vamo_w() }
                case 7 { return vamo_d() }
                case 0 { return vamo_q() }
	        else   { return unknown();}
	        }
        }
        else {
	        switch($func3) {
	        case 2 { return amo_w() }
	        case 3 { return amo_d() }
	        else   { return unknown();}
	        }
        }
}

sub amo_w {
	my $str_op;
	my $subop = ($instn >> 27) & 0x1f;
	my $aq = ($instn >> 26) & 0x1;
	my $rl = ($instn >> 25) & 0x1;
	switch($subop) {
	case 0 { $str_op = "amoadd.w" }
	case 1 { $str_op = "amoswap.w" }
	case 2 { $str_op = "lr.w" }
	case 3 { $str_op = "sc.w" }
	case 4 { $str_op = "amoxor.w" }
	case 8 { $str_op = "amoor.w" }
	case 12 { $str_op = "amoand.w" }
	case 16 { $str_op = "amomin.w" }
	case 20 { $str_op = "amomax.w" }
	case 24 { $str_op = "amominu.w" }
	case 28 { $str_op = "amomaxu.w" }
	else     { return unknown();}
	}
        if ($aq == 1 && $rl == 1) {
                $str_op = "${str_op}.aqrl";
        }
        elsif ($aq == 1) {
                $str_op = "${str_op}.aq";
        }
        elsif ($rl == 1) {
                $str_op = "${str_op}.rl";
        }

	if ($str_op =~ m/lr/) {
		if ($rs2 == 0) {
			return sprintf "%s %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs1);
		}
		else {
			return unknown();
		}
	}
	elsif ($str_op =~ m/sc/) {
		return sprintf "%s %s, %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs2), str_ireg($rs1);
	}
	else {
                return sprintf "%s %s, %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs2), str_ireg($rs1);
	}
}

sub amo_d {
	my $str_op;
	my $subop = ($instn >> 27) & 0x1f;
	my $aq = ($instn >> 26) & 0x1;
	my $rl = ($instn >> 25) & 0x1;
	switch($subop) {
	case 0 { $str_op = "amoadd.d" }
	case 1 { $str_op = "amoswap.d" }
	case 2 { $str_op = "lr.d" }
	case 3 { $str_op = "sc.d" }
	case 4 { $str_op = "amoxor.d" }
	case 8 { $str_op = "amoor.d" }
	case 12 { $str_op = "amoand.d" }
	case 16 { $str_op = "amomin.d" }
	case 20 { $str_op = "amomax.d" }
	case 24 { $str_op = "amominu.d" }
	case 28 { $str_op = "amomaxu.d" }
	else     { return unknown();}
	}
        if ($aq == 1 && $rl == 1) {
                $str_op = "${str_op}.aqrl";
        }
        elsif ($aq == 1) {
                $str_op = "${str_op}.aq";
        }
        elsif ($rl == 1) {
                $str_op = "${str_op}.rl";
        }
	if ($str_op =~ m/lr/) {
		if ($rs2 == 0) {
			return sprintf "%s %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs1);
		}
		else {
			return unknown();
		}
	}
	elsif ($str_op =~ m/sc/) {
		return sprintf "%s %s, %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs2), str_ireg($rs1);
	}
	else {
                return sprintf "%s %s, %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs2), str_ireg($rs1);
	}
}

sub amo_q {
	my $str_op;
	my $subop = ($instn >> 27) & 0x1f;
	my $aq = ($instn >> 26) & 0x1;
	my $rl = ($instn >> 25) & 0x1;
	switch($subop) {
	case 0 { $str_op = "amoadd.q" }
	case 1 { $str_op = "amoswap.q" }
	case 2 { $str_op = "lr.q" }
	case 3 { $str_op = "sc.q" }
	case 4 { $str_op = "amoxor.q" }
	case 8 { $str_op = "amoor.q" }
	case 12 { $str_op = "amoand.q" }
	case 16 { $str_op = "amomin.q" }
	case 20 { $str_op = "amomax.q" }
	case 24 { $str_op = "amominu.q" }
	case 28 { $str_op = "amomaxu.q" }
	else     { return unknown();}
	}
        if ($aq == 1 && $rl == 1) {
                $str_op = "${str_op}.aqrl";
        }
        elsif ($aq == 1) {
                $str_op = "${str_op}.aq";
        }
        elsif ($rl == 1) {
                $str_op = "${str_op}.rl";
        }
	if ($str_op =~ m/lr/) {
		return sprintf "%s %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs1);
	}
	elsif ($str_op =~ m/sc/) {
		return sprintf "%s %s, %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs2), str_ireg($rs1);
	}
	else {
                return sprintf "%s %s, %s, (%s)", $str_op, str_ireg($rd), str_ireg($rs2), str_ireg($rs1);
	}
}

sub vamo_w {
	my $str_op;
	my $amoop = ($instn >> 27) & 0x1f;
        my $vm    = ($instn >> 25) & 0x1;
	switch($amoop) {
	case 0 { $str_op = "vamoaddw.v" }
	case 1 { $str_op = "vamoswapw.v" }
	case 4 { $str_op = "vamoxorw.v" }
	case 8 { $str_op = "vamoorw.v" }
	case 12 { $str_op = "vamoandw.v" }
	case 16 { $str_op = "vamominw.v" }
	case 20 { $str_op = "vamomaxw.v" }
	case 24 { $str_op = "vamominuw.v" }
	case 28 { $str_op = "vamomaxuw.v" }
	else     { return unknown();}
	}

	if ($vm) {
                return sprintf "%s %s, %s, (%s)", $str_op, str_vreg($rd), str_vreg($rs2), str_ireg($rs1);
        }
	else {
                return sprintf "%s %s, %s, (%s), v0.t", $str_op, str_vreg($rd), str_vreg($rs2), str_ireg($rs1);
        }
}

sub vamo_d {
	my $str_op;
	my $amoop = ($instn >> 27) & 0x1f;
        my $vm    = ($instn >> 25) & 0x1;
	switch($amoop) {
	case 0 { $str_op = "vamoaddd.v" }
	case 1 { $str_op = "vamoswapd.v" }
	case 4 { $str_op = "vamoxord.v" }
	case 8 { $str_op = "vamoord.v" }
	case 12 { $str_op = "vamoandd.v" }
	case 16 { $str_op = "vamomind.v" }
	case 20 { $str_op = "vamomaxd.v" }
	case 24 { $str_op = "vamominud.v" }
	case 28 { $str_op = "vamomaxud.v" }
	else     { return unknown();}
	}

	if ($vm) {
                return sprintf "%s %s, %s, (%s)", $str_op, str_vreg($rd), str_vreg($rs2), str_ireg($rs1);
        }
	else {
                return sprintf "%s %s, %s, (%s), v0.t", $str_op, str_vreg($rd), str_vreg($rs2), str_ireg($rs1);
        }
}

sub vamo_q {
	my $str_op;
	my $amoop = ($instn >> 27) & 0x1f;
        my $vm    = ($instn >> 25) & 0x1;
	switch($amoop) {
	case 0 { $str_op = "vamoaddq.v" }
	case 1 { $str_op = "vamoswapq.v" }
	case 4 { $str_op = "vamoxorq.v" }
	case 8 { $str_op = "vamoorq.v" }
	case 12 { $str_op = "vamoandq.v" }
	case 16 { $str_op = "vamominq.v" }
	case 20 { $str_op = "vamomaxq.v" }
	case 24 { $str_op = "vamominuq.v" }
	case 28 { $str_op = "vamomaxuq.v" }
	else     { return unknown();}
	}

	if ($vm) {
                return sprintf "%s %s, %s, (%s)", $str_op, str_vreg($rd), str_vreg($rs2), str_ireg($rs1);
        }
	else {
                return sprintf "%s %s, %s, (%s), v0.t", $str_op, str_vreg($rd), str_vreg($rs2), str_ireg($rs1);
        }
}
                
sub op {
	my $str_op;
	switch($func3) {
	case 0 {
		switch($func7) {
		case 0 { $str_op = "add" }
		case 1 { $str_op = "mul" }
		case 32 { $str_op = "sub" }
		else { return unknown();}
		}
	}
	case 1 {
		switch($func7) {
		case 0 { $str_op = "sll" }
		case 1 { $str_op = "mulh" }
		else { return unknown();}
		}
	}
	case 2 {
		switch($func7) {
		case 0 { $str_op = "slt" }
		case 1 { $str_op = "mulhsu" }
		else { return unknown();}
		}
	}
	case 3 {
		switch($func7) {
		case 0 { $str_op = "sltu" }
		case 1 { $str_op = "mulhu" }
		else { return unknown();}
		}
	}
	case 4 {
		switch($func7) {
		case 0 { $str_op = "xor" }
		case 1 { $str_op = "div" }
		else { return unknown();}
		}
	}
	case 5 {
		switch($func7) {
		case 0 { $str_op = "srl" }
		case 1 { $str_op = "divu" }
		case 32 { $str_op = "sra" }
		else { return unknown();}
		}
	}
	case 6 {
		switch($func7) {
		case 0 { $str_op = "or" }
		case 1 { $str_op = "rem" }
		else { return unknown();}
		}
	}
	case 7 {
		switch($func7) {
		case 0 { $str_op = "and" }
		case 1 { $str_op = "remu" }
		else { return unknown();}
		}
	}
	else   { return unknown();}
	}
	return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), str_ireg($rs2);
}

sub op_32 {
	my $str_op;
	switch($func3) {
	case 0 {
		switch($func7) {
		case 0 { $str_op = "addw" }
		case 1 { $str_op = "mulw" }
		case 32 { $str_op = "subw" }
		else { return unknown();}
		}
	}
	case 1 { $str_op = "sllw" }
	case 4 {
		switch($func7) {
		case 1 { $str_op = "divw" }
		else { return unknown();}
		}
	}
	case 5 {
		switch($func7) {
		case 0 { $str_op = "srlw" }
		case 1 { $str_op = "divuw" }
		case 32 { $str_op = "sraw" }
		else { return unknown();}
		}
	}
	case 6 { $str_op = "remw" }
	case 7 { $str_op = "remuw" }
	else   { return unknown();}
	}
	return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), str_ireg($rs2);
}

sub madd {
	my $str_op;
	my $fmt = ($instn >> 25) & 0x3;
	switch($fmt) {
	case 0 { $str_op = "fmadd.s" }
	case 1 { $str_op = "fmadd.d" }
	case 2 { $str_op = "fmadd.h" }
	case 3 { $str_op = "fmadd.q" }
	}
	return sprintf "%s %s, %s, %s, %s, %s", $str_op, str_freg($rd), str_freg($rs1), str_freg($rs2), str_freg($rs3), str_rm($rm);
}

sub msub {
	my $str_op;
	my $fmt = ($instn >> 25) & 0x3;
	switch($fmt) {
	case 0 { $str_op = "fmsub.s" }
	case 1 { $str_op = "fmsub.d" }
	case 2 { $str_op = "fmsub.h" }
	case 3 { $str_op = "fmsub.q" }
	}
	return sprintf "%s %s, %s, %s, %s, %s", $str_op, str_freg($rd), str_freg($rs1), str_freg($rs2), str_freg($rs3), str_rm($rm);
}

sub nmsub {
	my $str_op;
	my $fmt = ($instn >> 25) & 0x3;
	switch($fmt) {
	case 0 { $str_op = "fnmsub.s" }
	case 1 { $str_op = "fnmsub.d" }
	case 2 { $str_op = "fnmsub.h" }
	case 3 { $str_op = "fnmsub.q" }
	}
	return sprintf "%s %s, %s, %s, %s, %s", $str_op, str_freg($rd), str_freg($rs1), str_freg($rs2), str_freg($rs3), str_rm($rm);
}

sub nmadd {
	my $str_op;
	my $fmt = ($instn >> 25) & 0x3;
	switch($fmt) {
	case 0 { $str_op = "fnmadd.s" }
	case 1 { $str_op = "fnmadd.d" }
	case 2 { $str_op = "fnmadd.h" }
	case 3 { $str_op = "fnmadd.q" }
	}
	return sprintf "%s %s, %s, %s, %s, %s", $str_op, str_freg($rd), str_freg($rs1), str_freg($rs2), str_freg($rs3), str_rm($rm);
}

sub op_fp {
	my $str_op;
	my $freg_in  = 1;
	my $freg_out = 1;
	my $frs2_disable = 0;
        my $instr_with_rm = 0;
	my $str;
	my $str_fmt;
	switch($func7 >> 2) {
	case  0 { $str_op = "fadd._FMT_" ; $instr_with_rm = 1;}
	case  1 { $str_op = "fsub._FMT_" ; $instr_with_rm = 1;}
	case  2 { $str_op = "fmul._FMT_" ; $instr_with_rm = 1;}
	case  3 { $str_op = "fdiv._FMT_" ; $instr_with_rm = 1;}
	case  4 {
		switch($func3) {
		case 0 { $str_op = "fsgnj._FMT_" }
		case 1 { $str_op = "fsgnjn._FMT_" }
		case 2 { $str_op = "fsgnjx._FMT_"}
		else   { return unknown();}
		}
	}
	case  5 {
		switch($func3) {
		case 0 { $str_op = "fmin._FMT_" }
		case 1 { $str_op = "fmax._FMT_" }
		else   { return unknown();}
		}
	}
	case  8 {
		switch($rs2) {
			case 0	{$str_op = "fcvt._FMT_.s"}
			case 1	{$str_op = "fcvt._FMT_.d"}
			case 2	{$str_op = "fcvt._FMT_.h"}
			else	{ return unknown();  }
		}
	        $frs2_disable = 1;
                $instr_with_rm = 1;
        }
	case 11 { $str_op = "fsqrt._FMT_"; $instr_with_rm = 1; $frs2_disable = 1;}
	case 20 {
		switch($func3) {
		case 0 { $str_op = "fle._FMT_" }
		case 1 { $str_op = "flt._FMT_" }
		case 2 { $str_op = "feq._FMT_" }
		else   { return unknown();}
		}
                $freg_out = 0;
	}
	case 24 {
                $instr_with_rm = 1;
		switch($rs2) {
		case 0 { $str_op = "fcvt.w._FMT_" }
		case 1 { $str_op = "fcvt.wu._FMT_" }
		case 2 { $str_op = "fcvt.l._FMT_" }
		case 3 { $str_op = "fcvt.lu._FMT_" }
		else   { return unknown()}
		}
                $freg_out = 0;
	        $frs2_disable = 1;
	}
	case 26 {
                $instr_with_rm = 1;
		switch($rs2) {
		case 0 { $str_op = "fcvt._FMT_.w" }
		case 1 { $str_op = "fcvt._FMT_.wu" }
		case 2 { $str_op = "fcvt._FMT_.l" }
		case 3 { $str_op = "fcvt._FMT_.lu"}
		else   { return unknown();}
		}
                $freg_in = 0;
	        $frs2_disable = 1;
	}
	case 28 {
		switch($func3) {
		case 0 { $str_op = "fmv.x._FMT_" }
		case 1 { $str_op = "fclass._FMT_" }
		else   { return unknown();}
		}
                $freg_out = 0;
	}
	case 30 { $str_op = "fmv._FMT_.x"; $freg_in = 0;}
	else { return unknown();}
	}

	switch ($func7 & 0x3) {
		case 0 {$str_fmt = ($str_op =~ /fmv/) ? "w" : "s"}
		case 1 {$str_fmt = "d"}
		case 2 {$str_fmt = "h"}
		case 3 {$str_fmt = "q"}
	}
	$str_op =~ s/_FMT_/$str_fmt/;

        $str  = sprintf("%s %s, %s", $str_op, $freg_out ? str_freg($rd ) : str_ireg($rd ),
                                              $freg_in  ? str_freg($rs1) : str_ireg($rs1));
        $str .= sprintf(", %s",               $freg_in  ? str_freg($rs2) : str_ireg($rs2)) if (!$frs2_disable);
        if ($instr_with_rm) {
                $str .= sprintf(", %s", str_rm($rm));
        }
        return $str;
}

sub op_v {
        my $str_op;
        my $func6   = ($instn >> 26) & 0x3f;
        my $vm      = ($instn >> 25) & 0x1;
        my $inst_rd;
        my $inst_src2 = SRC_NONE;
        my $inst_src  = SRC_NONE;
        my $instr_with_rm = 0;
        my $mask_as_src   = 0;
        my $str;

        # vsetvl/vsetvli/vsetivli
        if ($func3 == 7) {
                my $zimm11   = ($instn >> 20) & 0x7ff;
		my $vediv    = ($zimm11 >> 8) & 0x3;
		my $vma      = ($zimm11 >> 7) & 0x1;
		my $vta      = ($zimm11 >> 6) & 0x1;
		my $vsew     = ($zimm11 >> 3) & 0x7;
		my $vlmul    = ($zimm11 >> 0) & 0x7;

                my $ediv     = 2 ** $vediv;
		my $ma       = ($vma) ? "ma" : "mu";
		my $ta       = ($vta) ? "ta" : "tu";
                my $sew      = 2 ** ($vsew + 3);
		my $lmul     = ($vlmul == 0) ? "1" : 
			       ($vlmul == 1) ? "2" :
			       ($vlmul == 2) ? "4" :
			       ($vlmul == 3) ? "8" :
			       ($vlmul == 5) ? "f8" :
			       ($vlmul == 6) ? "f4" :
			       ($vlmul == 7) ? "f2" : 1;
                my $inst_msb = ($instn >> 30) & 0x3;
                switch($inst_msb) {
                case 0 { $str_op = "vsetvli" }
                case 1 { $str_op = "vsetvli" }
                case 2 { $str_op = "vsetvl"  }
                case 3 { $str_op = "vsetivli"}
                else   { return unknown();}
                }

                if ($inst_msb == 2) {
                        return  sprintf("%s %s, %s, %s", $str_op, str_ireg($rd ), str_ireg($rs1), str_ireg($rs2));
                }
                else {
			my $str;
			$str =  sprintf("%s %s, %s, e%s", $str_op, str_ireg($rd ), str_ireg($rs1), $sew)     	if ($inst_msb <  2);
			$str =  sprintf("%s %s, %s, e%s", $str_op, str_ireg($rd ),          $rs1 , $sew)	if ($inst_msb == 3);
			$str   .=  sprintf(", m%s", $lmul) if ($lmul !~ /^1$/);
			$str   .=  sprintf(", %s" , $ta);
			$str   .=  sprintf(", %s" , $ma);
                        $str   .=  sprintf(", d%s", $ediv) if ($ediv > 1);
                        return $str;
                }
        }

        # others riscv-v operations
        switch($func6) {
        case 0 { 
                switch($func3) {
                case 0 { $str_op = "vadd.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfadd.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vredsum.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vadd.vi";    $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vadd.vx";    $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfadd.vf";   $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 1 {
                switch($func3) {
                case 1 { $str_op = "vfredsum.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vredand.vs";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 2 { 
                switch($func3) {
                case 0 { $str_op = "vsub.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfsub.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vredor.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vsub.vx";   $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfsub.vf";  $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 3 { 
                switch($func3) {
                case 1 { $str_op = "vfredosum.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vredxor.vs";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vrsub.vi";     $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vrsub.vx";     $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 4 { 
                switch($func3) {
                case 0 { $str_op = "vminu.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfmin.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vredminu.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vminu.vx";    $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfmin.vf";    $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 5 { 
                switch($func3) {
                case 0 { $str_op = "vmin.vv";     $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfredmin.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vredmin.vs";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmin.vx";     $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 6 { 
                switch($func3) {
                case 0 { $str_op = "vmaxu.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfmax.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vredmaxu.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmaxu.vx";    $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfmax.vf";    $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 7 { 
                switch($func3) {
                case 0 { $str_op = "vmax.vv";     $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfredmax.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vredmax.vs";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmax.vx";     $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 8 { 
                switch($func3) {
                case 1 { $str_op = "vfsgnj.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vaaddu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfsgnj.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vaaddu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 9 { 
                switch($func3) {
                case 0 { $str_op = "vand.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfsgnjn.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vaadd.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vand.vi";    $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vand.vx";    $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfsgnjn.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vaadd.vx";   $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 10 { 
                switch($func3) {
                case 0 { $str_op = "vor.vv";     $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfsgnjx.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vasubu.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vor.vi";     $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vor.vx";     $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfsgnjx.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vasubu.vv";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 11 { 
                switch($func3) {
                case 0 { $str_op = "vxor.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vasub.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vxor.vi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vxor.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vasub.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 12 {
                switch($func3) {
                case 0 { $str_op = "vrgather.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vrgather.vi"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vrgather.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 13 {
                return unknown();
        }
        case 14 {
                switch($func3) {
                case 0 { $str_op = "vrgatherei16.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vslideup.vi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vslideup.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfslide1up.vx";   $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vslide1up.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 15 {
                switch($func3) {
                case 3 { $str_op = "vslidedown.vi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vslidedown.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfslide1down.vx"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vslide1down.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 16 {
                if ($func3 == 2) {
                        switch($rs1) {
                        case 0  { $str_op = "vmv.x.s";  $inst_rd = DST_XD; $inst_src = SRC_VS2; }
                        case 16 { $str_op = "vpopc.m";  $inst_rd = DST_XD; $inst_src = SRC_VS2; }
                        case 17 { $str_op = "vfirst.m"; $inst_rd = DST_XD; $inst_src = SRC_VS2; }
                        else    { return unknown();}
                        }
                }
                elsif ($vm == 1) {
                        switch($func3) {
                        case 1 { if ($rs1 == 0) { $str_op = "vfmv.f.s"; $inst_rd = DST_FD; $inst_src = SRC_VS2; }
                                 else { return unknown(); }
                               }
                        case 5 { if ($rs2 == 0) { $str_op = "vfmv.s.f"; $inst_rd = DST_VD; $inst_src = SRC_FS1; }
                                 else { return unknown(); }
                               }
                        case 6 { if ($rs2 == 0) {$str_op = "vmv.s.x";   $inst_rd = DST_VD; $inst_src = SRC_XS1; }
                                 else {return unknown(); }
                               }
                        else   { return unknown();}
                        }
                }
		elsif ($vm == 0) {
			switch($func3) {
                        case 0 { $str_op = "vadc.vvm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                        case 3 { $str_op = "vadc.vim"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                        case 4 { $str_op = "vadc.vxm"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                        else   { return unknown();}
                        }
		}
                else {
                        return unknown();
                }
        }
        case 17 {
                if ($vm == 1) {
                        switch($func3) {
                        case 0 { $str_op = "vmadc.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                        case 3 { $str_op = "vmadc.vi"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                        case 4 { $str_op = "vmadc.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                        else   { return unknown();}
                        }
                }
		elsif ($vm == 0) {
                        switch($func3) {
                        case 0 { $str_op = "vmadc.vvm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                        case 3 { $str_op = "vmadc.vim"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                        case 4 { $str_op = "vmadc.vxm"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                        else   { return unknown();}
                        }
                }
                else {
                        return unknown();
                }
        }
        case 18 { 
                        switch($func3) {
                        case 0 { 
				if ($vm == 0) {
					$str_op = "vsbc.vvm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; $mask_as_src = 1;
				} else {
					return unknown();
                        }
                }
			case 1 {
				switch($rs1) {
				case 0  { $str_op = "vfcvt.xu.f.v" }
				case 1  { $str_op = "vfcvt.x.f.v" }
				case 2  { $str_op = "vfcvt.f.xu.v" }
				case 3  { $str_op = "vfcvt.f.x.v" }
				case 6  { $str_op = "vfcvt.rtz.xu.f.v" }
				case 7  { $str_op = "vfcvt.rtz.x.f.v" }
				case 8  { $str_op = "vfwcvt.xu.f.v" }
				case 9  { $str_op = "vfwcvt.x.f.v" }
				case 10 { $str_op = "vfwcvt.f.xu.v" }
				case 11 { $str_op = "vfwcvt.f.x.v" }
				case 12 { $str_op = "vfwcvt.f.f.v" }
				case 14 { $str_op = "vfwcvt.rtz.xu.f.v" }
				case 15 { $str_op = "vfwcvt.rtz.x.f.v" }
				case 16 { $str_op = "vfncvt.xu.f.w" }
				case 17 { $str_op = "vfncvt.x.f.w" }
				case 18 { $str_op = "vfncvt.f.xu.w" }
				case 19 { $str_op = "vfncvt.f.x.w" }
				case 20 { $str_op = "vfncvt.f.f.w" }
				case 21 { $str_op = "vfncvt.rod.f.f.w" }
				case 22 { $str_op = "vfncvt.rtz.xu.f.w" }
				case 23 { $str_op = "vfncvt.rtz.x.f.w" }
				else    { return unknown();}
				}
				$inst_rd = DST_VD;
				$inst_src = SRC_VS2;
			}
			case 2 {
				switch($rs1) {
				case 2  { $str_op = "vzext.vf8" }
				case 3  { $str_op = "vsext.vf8" }
				case 4  { $str_op = "vzext.vf4" }
				case 5  { $str_op = "vsext.vf4" }
				case 6  { $str_op = "vzext.vf2" }
				case 7  { $str_op = "vsext.vf2" }
				else    { return unknown();}
                                }
				$inst_rd = DST_VD;
				$inst_src = SRC_VS2;
			}
                        case 4 { 
				if ($vm == 0) {
					$str_op = "vsbc.vxm"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; $mask_as_src = 1;
				} else {
                        return unknown();
                }
        }
                        else   { return unknown();}
		}
        }
        case 19 { 
                if ($func3 == 1) {
			switch($rs1) {
			case 0  { $str_op = "vfsqrt.v" }
			case 4  { $str_op = "vfrsqrte7.v" }
			case 5  { $str_op = "vfrece7.v" }
			case 16 { $str_op = "vfclass.v" }
                        else    { return unknown();} 
			}
                        $inst_rd = DST_VD;
                        $inst_src = SRC_VS2; 
		}
		elsif ($vm == 1) {
                        switch($func3) {
                        case 0 { $str_op = "vmsbc.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                        case 4 { $str_op = "vmsbc.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                        else   { return unknown();}
                        }
                }
		elsif ($vm == 0) {
                        switch($func3) {
                        case 0 { $str_op = "vmsbc.vvm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                        case 4 { $str_op = "vmsbc.vxm"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                        else   { return unknown();}
                        }
                }
                else {
                        return unknown();
                }
        }
        case 20 {
                switch($func3) {
                case 2 { 
                               $inst_rd = DST_VD;
                               $inst_src = SRC_VS2;
                               switch($rs1) {
                               case 1  { $str_op = "vmsbf.m"; }
                               case 2  { $str_op = "vmsof.m"; }
                               case 3  { $str_op = "vmsif.m"; }
                               case 16 { $str_op = "viota.m"; }
                               case 17 { 
                                       if ($rs2 == 0) { $str_op = "vid.v"; $inst_src = SRC_NONE;}
                                       else           { return unknown();  }
                                       }
                               else    { return unknown();}
                               }
                       }
                else   { return unknown();}
                }
        }
        case 21 {
                return unknown();
        }
        case 22 {
                return unknown();
        }
        case 23 { 
                switch($func3) {
                case 2 { $str_op = "vcompress.vm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                else   { 
                       if ($vm == 0) {
                               switch($func3) {
                               case 0 { $str_op = "vmerge.vvm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                               case 3 { $str_op = "vmerge.vim"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                               case 4 { $str_op = "vmerge.vxm"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                               case 5 { $str_op = "vfmerge.vfm"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; $mask_as_src = 1; }
                               else   { return unknown();}
                               }
                       }
                       elsif (($vm == 1) && ($rs2 == 0)) {
                               switch($func3) {
                               case 0 { $str_op = "vmv.v.v"; $inst_rd = DST_VD; $inst_src = SRC_VS1; }
                               case 3 { $str_op = "vmv.v.i"; $inst_rd = DST_VD; $inst_src = SRC_IMM; }
                               case 4 { $str_op = "vmv.v.x"; $inst_rd = DST_VD; $inst_src = SRC_XS1; }
                               case 5 { $str_op = "vfmv.v.f";$inst_rd = DST_VD; $inst_src = SRC_FS1; }
                               else   { return unknown();}
                               }
                       }
                       else {
                               return unknown();
                       }
                       }
                }
        }
        case 24 { 
                switch($func3) {
                case 0 { $str_op = "vmseq.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vmfeq.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmandnot.mm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vmseq.vi";    $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmseq.vx";    $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vmfeq.vf";    $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 25 { 
                switch($func3) {
                case 0 { $str_op = "vmsne.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vmfle.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmand.mm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vmsne.vi"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmsne.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vmfle.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 26 {       # for spec 20190726, instructions vmford are removed
                switch($func3) {
                case 0 { $str_op = "vmsltu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                #case 1 { $str_op = "vmford.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmor.mm";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmsltu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                #case 5 { $str_op = "vmford.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 27 { 
                switch($func3) {
                case 0 { $str_op = "vmslt.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vmflt.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmxor.mm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmslt.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vmflt.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 28 { 
                switch($func3) {
                case 0 { $str_op = "vmsleu.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vmfne.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmornot.mm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vmsleu.vi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmsleu.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vmfne.vf";   $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 29 { 
                switch($func3) {
                case 0 { $str_op = "vmsle.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmnand.mm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vmsle.vi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmsle.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vmfgt.vf";  $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 30 { 
                switch($func3) {
                case 2 { $str_op = "vmnor.mm";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vmsgtu.vi"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmsgtu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 31 { 
                switch($func3) {
                case 2 { $str_op = "vmxnor.mm"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vmsgt.vi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vmsgt.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vmfge.vf";  $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 32 { 
                switch($func3) {
                case 0 { $str_op = "vsaddu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfdiv.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vdivu.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vsaddu.vi"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vsaddu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfdiv.vf";  $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vdivu.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 33 { 
                switch($func3) {
                case 0 { $str_op = "vsadd.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vdiv.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vsadd.vi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vsadd.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfrdiv.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vdiv.vx";   $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 34 { 
                switch($func3) {
                case 0 { $str_op = "vssubu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vremu.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vssubu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vremu.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 35 { 
                switch($func3) {
                case 0 { $str_op = "vssub.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vrem.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vssub.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vrem.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 36 { 
                switch($func3) {
                case 1 { $str_op = "vfmul.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmulhu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfmul.vf";  $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vmulhu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 37 { 
                switch($func3) {
                case 0 { $str_op = "vsll.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmul.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 3 { $str_op = "vsll.vi"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vsll.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vmul.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 38 { 
                switch($func3) {
                case 2 { $str_op = "vmulhsu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vmulhsu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
		}
        }
        case 39 {
                switch($func3) {
                case 0 { $str_op = "vsmul.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vmulh.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
		case 3 {
			switch($rs1) {
			case 0 { $str_op = "vmv1r.v"; $inst_rd = DST_VD; $inst_src2 = SRC_VS2; }
			case 1 { $str_op = "vmv2r.v"; $inst_rd = DST_VD; $inst_src2 = SRC_VS2; }
			case 3 { $str_op = "vmv4r.v"; $inst_rd = DST_VD; $inst_src2 = SRC_VS2; }
			case 7 { $str_op = "vmv8r.v"; $inst_rd = DST_VD; $inst_src2 = SRC_VS2; }
			else { return unknown();}
			}
		}
                case 4 { $str_op = "vsmul.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfrsub.vf";$inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vmulh.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 40 { 
                switch($func3) {
                case 0 { $str_op = "vsrl.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfmadd.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 3 { $str_op = "vsrl.vi";   $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vsrl.vx";   $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfmadd.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                else   { return unknown();}
                }
        }
        case 41 { 
                switch($func3) {
                case 0 { $str_op = "vsra.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfnmadd.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 2 { $str_op = "vmadd.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 3 { $str_op = "vsra.vi";    $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vsra.vx";    $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfnmadd.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                case 6 { $str_op = "vmadd.vx";   $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                else   { return unknown();}
                }
        }
        case 42 { 
                switch($func3) {
                case 0 { $str_op = "vssrl.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfmsub.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 3 { $str_op = "vssrl.vi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vssrl.vx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfmsub.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                else   { return unknown();}
                }
        }
        case 43 { 
                switch($func3) {
                case 0 { $str_op = "vssra.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfnmsub.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 2 { $str_op = "vnmsub.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 3 { $str_op = "vssra.vi";   $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vssra.vx";   $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfnmsub.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                case 6 { $str_op = "vnmsub.vx";  $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                else   { return unknown();}
                }
        }
        case 44 { 
                switch($func3) {
                case 0 { $str_op = "vnsrl.wv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfmacc.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 3 { $str_op = "vnsrl.wi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vnsrl.wx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfmacc.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                else   { return unknown();}
                }
        }
        case 45 { 
                switch($func3) {
                case 0 { $str_op = "vnsra.wv";   $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfnmacc.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 2 { $str_op = "vmacc.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 3 { $str_op = "vnsra.wi";   $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vnsra.wx";   $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfnmacc.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                case 6 { $str_op = "vmacc.vx";   $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                else   { return unknown();}
                }
        }
        case 46 { 
                switch($func3) {
                case 0 { $str_op = "vnclipu.wv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfmsac.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 3 { $str_op = "vnclipu.wi"; $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vnclipu.wx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfmsac.vf";  $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                else   { return unknown();}
                }
        }
        case 47 { 
                switch($func3) {
                case 0 { $str_op = "vnclip.wv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfnmsac.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 2 { $str_op = "vnmsac.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 3 { $str_op = "vnclip.wi";  $inst_rd = DST_VD; $inst_src = SRC_IMM; $inst_src2 = SRC_VS2; }
                case 4 { $str_op = "vnclip.wx";  $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfnmsac.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                case 6 { $str_op = "vnmsac.vx";  $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                else   { return unknown();}
                }
        }
        case 48 {
                switch($func3) {
                case 0 { $str_op = "vwredsumu.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfwadd.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vwaddu.vv";    $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfwadd.vf";    $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwaddu.vx";    $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 49 {
                switch($func3) {
                case 0 { $str_op = "vwredsum.vs";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfwredsum.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vwadd.vv";     $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwadd.vx";     $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 50 {
                switch($func3) {
                case 1 { $str_op = "vfwsub.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vwsubu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfwsub.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwsubu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 51 {
                switch($func3) {
                case 1 { $str_op = "vfwredosum.vs"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vwsub.vv";      $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwsub.vx";      $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 52 {
                switch($func3) {
                case 1 { $str_op = "vfwadd.wv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vwaddu.wv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfwadd.wf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwaddu.wx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 53 {
                switch($func3) {
                case 2 { $str_op = "vwadd.wv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwadd.wx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 54 {
                switch($func3) {
                case 1 { $str_op = "vfwsub.wv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vwsubu.wv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfwsub.wf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwsubu.wx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 55 {
                switch($func3) {
                case 2 { $str_op = "vwsub.wv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwsub.wx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 56 {
                switch($func3) {
                case 0 { $str_op = "vdotu.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfwmul.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 2 { $str_op = "vwmulu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 5 { $str_op = "vfwmul.vf"; $inst_rd = DST_VD; $inst_src = SRC_FS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwmulu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 57 {
                switch($func3) {
                case 0 { $str_op = "vdot.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 1 { $str_op = "vfdot.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 58 {
                switch($func3) {
                case 2 { $str_op = "vwmulsu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwmulsu.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 59 {
                switch($func3) {
                case 2 { $str_op = "vwmul.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS1; $inst_src2 = SRC_VS2; }
                case 6 { $str_op = "vwmul.vx"; $inst_rd = DST_VD; $inst_src = SRC_XS1; $inst_src2 = SRC_VS2; }
                else   { return unknown();}
                }
        }
        case 60 {
                switch($func3) {
		case 0 { $str_op = "vqmaccu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 1 { $str_op = "vfwmacc.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 2 { $str_op = "vwmaccu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
		case 4 { $str_op = "vqmaccu.vx"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                case 5 { $str_op = "vfwmacc.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                case 6 { $str_op = "vwmaccu.vx"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                else   { return unknown();}
                }
        }
        case 61 {
                switch($func3) {
                case 0 { $str_op = "vqmacc.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
		case 1 { $str_op = "vfwnmacc.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 2 { $str_op = "vwmacc.vv";   $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
		case 4 { $str_op = "vqmacc.vx";   $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                case 5 { $str_op = "vfwnmacc.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                case 6 { $str_op = "vwmacc.vx";   $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                else   { return unknown();}
                }
        }
        case 62 {
                switch($func3) {
                case 1 { $str_op = "vfwmsac.vv";  $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 4 { $str_op = "vqmaccus.vx"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                case 5 { $str_op = "vfwmsac.vf";  $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                case 6 { $str_op = "vwmaccus.vx"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                else   { return unknown();}                                                           
                }                                                                                     
        }                                                                                             
        case 63 {                                                                                     
                switch($func3) {                                                                      
		case 0 { $str_op = "vqmaccsu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 1 { $str_op = "vfwnmsac.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 2 { $str_op = "vwmaccsu.vv"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_VS1; }
                case 4 { $str_op = "vqmaccsu.vx"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                case 5 { $str_op = "vfwnmsac.vf"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_FS1; }
                case 6 { $str_op = "vwmaccsu.vx"; $inst_rd = DST_VD; $inst_src = SRC_VS2; $inst_src2 = SRC_XS1; }
                else   { return unknown();}
                }
        }
	else { return unknown();}
        }

	$str = sprintf("%s %s", $str_op, ($inst_rd == DST_VD) ? str_vreg($rd) :
					 ($inst_rd == DST_XD) ? str_ireg($rd) : str_freg($rd));

        if ($inst_src2 != SRC_NONE) {
                $str .= sprintf(", %s", ($inst_src2 == SRC_VS2) ? str_vreg($rs2) : 
					($inst_src2 == SRC_VS1) ? str_vreg($rs1) :
					($inst_src2 == SRC_XS1) ? str_ireg($rs1) : str_freg($rs1));
        }

        if ($inst_src != SRC_NONE) {
                $str .= sprintf(", %s", ($inst_src == SRC_IMM) ? str_simm5($rs1) :
                                        ($inst_src == SRC_VS2) ? str_vreg($rs2)  : 
                                        ($inst_src == SRC_XS1) ? str_ireg($rs1)  : 
                                        ($inst_src == SRC_FS1) ? str_freg($rs1)  : str_vreg($rs1));
        }
	
	if ($mask_as_src == 1) {
		$str .= sprintf(", v0");
	} elsif ($vm == 0) {
                $str .= sprintf(", v0.t");
        }

        return $str;
}

sub dsp {
    # FIXME: 1. print imm
    #        2. CSR related (RDOV & CLROV)
    my $str_op;
    my $subop5 = ($instn >> 20) & 0x1f;     # instn[24:20]
    my $subop2 = ($instn >> 23) & 0x3;      # instn[24:23]
    my $subop1 = ($instn >> 24) & 0x1;      # instn[24]
    my $only_rs1 = 0;
    my $imm = 0;    #FIXME
    my $imm3 = 0;
    my $imm4 = 0;
    my $imm5 = 0;
    my $imm6 = 0;
    my $shamt3 = ($instn >> 20) & 0x7;      # instn[22:20]
    my $shamt4 = ($instn >> 20) & 0xf;      # instn[23:20]
    my $shamt5 = ($instn >> 20) & 0x1f;     # instn[24:20]
    my $shamt6 = ($instn >> 20) & 0x3f;     # instn[25:20]
    my $imm14_10 = ($instn >> 10) & 0x7c00;
    my $imm9_5   = ($instn >> 10) & 0x3e0;
    my $imm4_0   = ($instn >> 7)  & 0x1f;
    my $imm15s   = $imm14_10 + $imm9_5 + $imm4_0;

    my $high2 = $instn >> 30;
    if (($high2 == 3) && ($func3 == 2)) {
        $str_op = "bpick";
        my $rc    = ($instn >> 25) & 0x1f;
        return sprintf "%s %s, %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), str_ireg($rs2), str_ireg($rc);
    }
    # R-type
    if ($func3 == 0) {
        switch($func7) {
            case 0   { $str_op = "radd16"; }
            case 1   { $str_op = "rsub16"; }
            case 2   { $str_op = "rcras16"; }
            case 3   { $str_op = "rcrsa16"; }
            case 4   { $str_op = "radd8"; }
            case 5   { $str_op = "rsub8"; }
            case 6   { $str_op = "scmplt16"; }
            case 7   { $str_op = "scmplt8"; }
            case 8   { $str_op = "kadd16"; }
            case 9   { $str_op = "ksub16"; }
            case 10  { $str_op = "kcras16"; }
            case 11  { $str_op = "kcrsa16"; }
            case 12  { $str_op = "kadd8"; }
            case 13  { $str_op = "ksub8"; }
            case 14  { $str_op = "scmple16"; }
            case 15  { $str_op = "scmple8"; }
            case 16  { $str_op = "uradd16"; }
            case 17  { $str_op = "ursub16"; }
            case 18  { $str_op = "urcras16"; }
            case 19  { $str_op = "urcrsa16"; }
            case 20  { $str_op = "uradd8"; }
            case 21  { $str_op = "ursub8"; }
            case 22  { $str_op = "ucmplt16"; }
            case 23  { $str_op = "ucmplt8"; }
            case 24  { $str_op = "ukadd16"; }
            case 25  { $str_op = "uksub16"; }
            case 26  { $str_op = "ukcras16"; }
            case 27  { $str_op = "ukcrsa16"; }
            case 28  { $str_op = "ukadd8"; }
            case 29  { $str_op = "uksub8"; }
            case 30  { $str_op = "ucmple16"; }
            case 31  { $str_op = "ucmple8"; }
            case 32  { $str_op = "add16"; }
            case 33  { $str_op = "sub16"; }
            case 34  { $str_op = "cras16"; }
            case 35  { $str_op = "crsa16"; }
            case 36  { $str_op = "add8"; }
            case 37  { $str_op = "sub8"; }
            case 38  { $str_op = "cmpeq16"; }
            case 39  { $str_op = "cmpeq8"; }
            case 40  { $str_op = "sra16"; }
            case 41  { $str_op = "srl16"; }
            case 42  { $str_op = "sll16"; }
            case 43  { $str_op = "kslra16"; }
            case 44  { $str_op = "sra8"; }
            case 45  { $str_op = "srl8"; }
            case 46  { $str_op = "sll8"; }
            case 47  { $str_op = "kslra8"; }
            case 48  { $str_op = "sra16_u"; }
            case 49  { $str_op = "srl16_u"; }
            case 50  { $str_op = "ksll16"; }
            case 51  { $str_op = "kslra16_u"; }
            case 52  { $str_op = "sra8_u"; }
            case 53  { $str_op = "srl8_u"; }
            case 54  { $str_op = "ksll8"; }
            case 55  { $str_op = "kslra8_u"; }
            case 56  {
                switch($subop1) {
                    case 0 { $str_op = "srai16";   $imm4 = 1; }   # imm4 [23:20]
                    case 1 { $str_op = "srai16_u"; $imm4 = 1; }   # imm4 [23:20]
                    else   { return unknown();}
                }
            }
            case 57  {
                switch($subop1) {
                    case 0 { $str_op = "srli16";   $imm4 = 1; }   # imm4 [23:20]
                    case 1 { $str_op = "srli16_u"; $imm4 = 1; }   # imm4 [23:20]
                    else   { return unknown();}
                }
            }
            case 58  {
                switch($subop1) {
                    case 0 { $str_op = "slli16";  $imm4 = 1; }   # imm4  [23:20]
                    case 1 { $str_op = "kslli16"; $imm4 = 1; }   # imm4u [23:20]
                    else   { return unknown();}
                }
            }
            case 60  {
                switch($subop2) {
                    case 0 { $str_op = "srai8";   $imm3 = 1; }   # imm3u [22:20]
                    case 1 { $str_op = "srai8_u"; $imm3 = 1; }   # imm3u [22:20]
                    else   { return unknown();}
                }
            }
            case 61  {
                switch($subop2) {
                    case 0 { $str_op = "srli8";   $imm3 = 1; }   # imm3u [22:20]
                    case 1 { $str_op = "srli8_u"; $imm3 = 1; }   # imm3u [22:20]
                    else   { return unknown();}
                }
            }
            case 62  {
                switch($subop2) {
                    case 0 { $str_op = "slli8";  $imm3 = 1; }    # imm3u [22:20]
                    case 1 { $str_op = "kslli8"; $imm3 = 1; }    # imm3u [22:20]
                    else   { return unknown();}
                }
            }
            case 64  { $str_op = "smin16"; }
            case 65  { $str_op = "smax16"; }
            case 66  { 
                switch($subop1) {
                    case 0 { $str_op = "sclip16"; $imm4 = 1; }   # imm4u [23:20]
                    case 1 { $str_op = "uclip16"; $imm4 = 1; }   # imm4u [23:20]
                }
            }
            case 67  { $str_op = "khm16"; }
            case 68  { $str_op = "smin8"; }
            case 69  { $str_op = "smax8"; }
            case 70  { 
                switch($subop2) {
                    case 0 { $str_op = "sclip8"; $imm3 = 1; }    # imm3u [22:20]
                    case 2 { $str_op = "uclip8"; $imm3 = 1; }    # imm3u [22:20]
                }
            }
            case 71  { $str_op = "khm8"; }
            case 72  { $str_op = "umin16"; }
            case 73  { $str_op = "umax16"; }
            case 75  { $str_op = "khmx16"; }
            case 76  { $str_op = "umin8"; }
            case 77  { $str_op = "umax8"; }
            case 79  { $str_op = "khmx8"; }
            case 80  { $str_op = "smul16"; }
            case 81  { $str_op = "smulx16"; }
            case 84  { $str_op = "smul8"; }
            case 85  { $str_op = "smulx8"; }
            case 86  {
                if ($subop2 == 0) {
                    $str_op = "insb";
                    $imm = 1;           # imm[21:20] in rv32    imm[22:20] in rv64 
                }
                else {
                    switch ($subop5) {
                        case 8   { $str_op = "sunpkd810";  $only_rs1 = 1; }
                        case 9   { $str_op = "sunpkd820";  $only_rs1 = 1; }
                        case 10  { $str_op = "sunpkd830";  $only_rs1 = 1; }
                        case 11  { $str_op = "sunpkd831";  $only_rs1 = 1; }
                        case 12  { $str_op = "zunpkd810";  $only_rs1 = 1; }
                        case 13  { $str_op = "zunpkd820";  $only_rs1 = 1; }
                        case 14  { $str_op = "zunpkd830";  $only_rs1 = 1; }
                        case 15  { $str_op = "zunpkd831";  $only_rs1 = 1; }
                        case 16  { $str_op = "kabs8";      $only_rs1 = 1; }
                        case 17  { $str_op = "kabs16";     $only_rs1 = 1; }
                        case 18  { $str_op = "kabs32";     $only_rs1 = 1; }
                        case 19  { $str_op = "sunpkd832";  $only_rs1 = 1; }
                        case 20  { $str_op = "kabsw";      $only_rs1 = 1; }
                        case 23  { $str_op = "zunpkd832";  $only_rs1 = 1; }
                        case 24  { $str_op = "swap8";      $only_rs1 = 1; }
                        case 25  { $str_op = "swap16";     $only_rs1 = 1; }
                        else   { return unknown();}
                    }
                }
            }
            case 87  {
                switch ($subop5) {
                    case 0   { $str_op = "clrs8";  $only_rs1 = 1; }
                    case 1   { $str_op = "clz8";   $only_rs1 = 1; }
                    case 3   { $str_op = "clo8";   $only_rs1 = 1; }
                    case 8   { $str_op = "clrs16"; $only_rs1 = 1; }
                    case 9   { $str_op = "clz16";  $only_rs1 = 1; }
                    case 11  { $str_op = "clo16";  $only_rs1 = 1; }
                    case 24  { $str_op = "clrs32"; $only_rs1 = 1; }
                    case 25  { $str_op = "clz32";  $only_rs1 = 1; }
                    case 27  { $str_op = "clo32";  $only_rs1 = 1; }
                }
            }
            case 88  { $str_op = "umul16"; }
            case 89  { $str_op = "umulx16"; }
            case 92  { $str_op = "umul8"; }
            case 93  { $str_op = "umulx8"; }
            case 100 { $str_op = "smaqa"; }
            case 101 { $str_op = "smaqa_su"; }
            case 102 { $str_op = "umaqa"; }
            case 103 { $str_op = "wext"; }
            case 111 { $str_op = "wexti";   $imm5 = 1; }    # #LSBloc[4:0] instn[24:20]
            case 112 { $str_op = "ave"; }
            case 114 { $str_op = "sclip32"; $imm5 = 1; }    # imm5u[24:20]
            case 115 { $str_op = "bitrev"; }
            case 116 { $str_op = "bitrevi"; $imm = 1; }     #rv32: imm[24:20]     rv64: imm[25:20]
            case 117 { $str_op = "bitrevi"; $imm = 1; }     #rv32: imm[24:20]     rv64: imm[25:20]
            case 120 { $str_op = "minw"; }
            case 121 { $str_op = "maxw"; }
            case 122 { $str_op = "uclip32"; $imm5 = 1; }    # imm5u[24:20]
            case 124 { $str_op = "mtlbi";   $imm = 1; }     # imm15s[24:20] imm[19:15] imm[11:7]
            case 125 { $str_op = "mtlei";   $imm = 1; }     # imm15s[24:20] imm[19:15] imm[11:7]
            case 126 { $str_op = "pbsad"; }
            case 127 { $str_op = "pbsada"; }
            else   { return unknown();}
        }
    }
    elsif ($func3 == 1) {
        switch($func7) {
            case 0   { $str_op = "kaddw"; }
            case 1   { $str_op = "ksubw"; }
            case 2   { $str_op = "kaddh"; }
            case 3   { $str_op = "ksubh"; }
            case 4   { $str_op = "smbb16"; }
            case 5   { $str_op = "kdmbb"; }
            case 6   { $str_op = "khmbb"; }
            case 7   { $str_op = "pkbb16"; }
            case 8   { $str_op = "ukaddw"; }
            case 9   { $str_op = "uksubw"; }
            case 10  { $str_op = "ukaddh"; }
            case 11  { $str_op = "uksubh"; }
            case 12  { $str_op = "smbt16"; }
            case 13  { $str_op = "kdmbt"; }
            case 14  { $str_op = "khmbt"; }
            case 15  { $str_op = "pkbt16"; }
            case 16  { $str_op = "raddw"; }
            case 17  { $str_op = "rsubw"; }
            case 18  { $str_op = "sra_u"; }
            case 19  { $str_op = "ksll"; }
            case 20  { $str_op = "smtt16"; }
            case 21  { $str_op = "kdmtt"; }
            case 22  { $str_op = "khmtt"; }
            case 23  { $str_op = "pktt16"; }
            case 24  { $str_op = "uraddw"; }
            case 25  { $str_op = "ursubw"; }
            case 26  { $str_op = "sraiw_u"; $imm5 = 1; }    # imm5u[24:20]
            case 27  { $str_op = "kslli";   $imm5 = 1; }    # imm5u[24:20] 
            case 28  { $str_op = "kmda"; }
            case 29  { $str_op = "kmxda"; }
            case 31  { $str_op = "pktb16"; }
            case 32  { $str_op = "smmul"; }
            case 33  { $str_op = "kmmsb"; }
            case 34  { $str_op = "smmwb"; }
            case 35  { $str_op = "kmmawb"; }
            case 36  { $str_op = "kmada"; }
            case 37  { $str_op = "kmaxda"; }
            case 38  { $str_op = "kmsda"; }
            case 39  { $str_op = "kmsxda"; }
            case 40  { $str_op = "smmul_u"; }
            case 41  { $str_op = "kmmsb_u"; }
            case 42  { $str_op = "smmwb_u"; }
            case 43  { $str_op = "kmmawb_u"; }
            case 44  { $str_op = "smds"; }
            case 45  { $str_op = "kmabb"; }
            case 46  { $str_op = "kmads"; }
            case 47  { $str_op = "smal"; }
            case 48  { $str_op = "kmmac"; }
            case 49  { $str_op = "kwmmul"; }
            case 50  { $str_op = "smmwt"; }
            case 51  { $str_op = "kmmawt"; }
            case 52  { $str_op = "smdrs"; }
            case 53  { $str_op = "kmabt"; }
            case 54  { $str_op = "kmadrs"; }
            case 55  { $str_op = "kslraw"; }
            case 56  { $str_op = "kmmac_u"; }
            case 57  { $str_op = "kwmmul_u"; }
            case 58  { $str_op = "smmwt_u"; }
            case 59  { $str_op = "kmmawt_u"; }
            case 60  { $str_op = "smxds"; }
            case 61  { $str_op = "kmatt"; }
            case 62  { $str_op = "kmaxds"; }
            case 63  { $str_op = "kslraw_u"; }
            case 64  { $str_op = "radd64"; }
            case 65  { $str_op = "rsub64"; }
            case 66  { $str_op = "smar64"; }
            case 67  { $str_op = "smsr64"; }
            case 68  { $str_op = "smalbb"; }
            case 69  { $str_op = "smalds"; }
            case 70  { $str_op = "smalda"; }
            case 71  { $str_op = "kmmwb2"; }
            case 72  { $str_op = "kadd64"; }
            case 73  { $str_op = "ksub64"; }
            case 74  { $str_op = "kmar64"; }
            case 75  { $str_op = "kmsr64"; }
            case 76  { $str_op = "smalbt"; }
            case 77  { $str_op = "smaldrs"; }
            case 78  { $str_op = "smalxda"; }
            case 79  { $str_op = "kmmwb2_u"; }
            case 80  { $str_op = "uradd64"; }
            case 81  { $str_op = "ursub64"; }
            case 82  { $str_op = "umar64"; }
            case 83  { $str_op = "umsr64"; }
            case 84  { $str_op = "smaltt"; }
            case 85  { $str_op = "smalxds"; }
            case 86  { $str_op = "smslda"; }
            case 87  { $str_op = "kmmwt2"; }
            case 88  { $str_op = "ukadd64"; }
            case 89  { $str_op = "uksub64"; }
            case 90  { $str_op = "ukmar64"; }
            case 91  { $str_op = "ukmsr64"; }
            case 94  { $str_op = "smslxda"; }
            case 95  { $str_op = "kmmwt2_u"; }
            case 96  { $str_op = "add64"; }
            case 97  { $str_op = "sub64"; }
            case 98  { $str_op = "maddr32"; }
            case 99  { $str_op = "msubr32"; }
            case 103 { $str_op = "kmmawb2"; }
            case 105 { $str_op = "kdmabb"; }
            case 106 { $str_op = "srai_u"; $imm = 1; }  # imm6u[25:20]
            case 107 { $str_op = "srai_u"; $imm = 1; }  # imm6u[25:20]
            case 108 { $str_op = "kdmabb16"; }
            case 109 { $str_op = "kdmbb16"; }
            case 110 { $str_op = "khmbb16"; }
            case 111 { $str_op = "kmmawb2_u"; }
            case 112 { $str_op = "mulsr64"; }
            case 113 { $str_op = "kdmabt"; }
            case 116 { $str_op = "kdmabt16"; }
            case 117 { $str_op = "kdmbt16"; }
            case 118 { $str_op = "khmbt16"; }
            case 119 { $str_op = "kmmawt2"; }
            case 120 { $str_op = "mulr64"; }
            case 121 { $str_op = "kdmatt"; }
            case 124 { $str_op = "kdmatt16"; }
            case 125 { $str_op = "kdmtt16"; }
            case 126 { $str_op = "khmtt16"; }
            case 127 { $str_op = "kmmawt2_u"; }
            else   { return unknown();}
        }
    }
    elsif ($func3 == 2) {
        switch($func7) {
            case 0  { $str_op = "radd32"  }
            case 1  { $str_op = "rsub32"  }
            case 2  { $str_op = "rcras32" }
            case 3  { $str_op = "rcrsa32" }
            case 4  { $str_op = "smbb32"  }
            case 7  { $str_op = "pkbb32"}
            case 8  { $str_op = "kadd32"  }
            case 9  { $str_op = "ksub32"  }
            case 10 { $str_op = "kcras32" }
            case 11 { $str_op = "kcrsa32" }
            case 12 { $str_op = "smbt32" }
            case 15 { $str_op = "pkbt32"}
            case 16 { $str_op = "uradd32" }
            case 17 { $str_op = "ursub32" }
            case 18 { $str_op = "urcras32" }
            case 19 { $str_op = "urcrsa32" }
            case 20 { $str_op = "smtt32" }
            case 23 { $str_op = "pktt32"}
            case 24 { $str_op = "ukadd32" }
            case 25 { $str_op = "uksub32" }
            case 26 { $str_op = "ukcras32" }
            case 27 { $str_op = "ukcrsa32" }
            case 28 { $str_op = "kmda32" }
            case 29 { $str_op = "kmxda32" }
            case 31 { $str_op = "pktb32"}
            case 32 { $str_op = "add32" }
            case 33 { $str_op = "sub32" }
            case 34 { $str_op = "cras32" }
            case 35 { $str_op = "crsa32" }
            case 36 { $str_op = "kmada32" }
            case 37 { $str_op = "kmaxda32" }
            case 38 { $str_op = "kmsda32" }
            case 39 { $str_op = "kmsxda32" }
            case 40 { $str_op = "sra32" }
            case 41 { $str_op = "srl32" }
            case 42 { $str_op = "sll32" }
            case 43 { $str_op = "kslra32" }
            case 44 { $str_op = "smds32" }
            case 45 { $str_op = "kmabb32" }
            case 46 { $str_op = "kmads32" }
            case 48 { $str_op = "sra32_u" }
            case 49 { $str_op = "srl32_u" }
            case 50 { $str_op = "ksll32" }
            case 51 { $str_op = "kslra32_u" }
            case 52 { $str_op = "smdrs32" }
            case 53 { $str_op = "kmabt32" }
            case 54 { $str_op = "kmadrs32" }
            case 56 { $str_op = "srai32"; $imm5 = 1; }
            case 57 { $str_op = "srli32"; $imm5 = 1; }
            case 58 { $str_op = "slli32"; $imm5 = 1; }
            case 60 { $str_op = "smxds32" }
            case 61 { $str_op = "kmatt32" }
            case 62 { $str_op = "kmaxds32" }
            case 64 { $str_op = "srai32_u"; $imm5 = 1; }
            case 65 { $str_op = "srli32_u"; $imm5 = 1; }
            case 66 { $str_op = "kslli32";  $imm5 = 1; }
            case 72 { $str_op = "smin32" }
            case 73 { $str_op = "smax32" }
            case 80 { $str_op = "umin32" }
            case 81 { $str_op = "umax32" }
            else   { return unknown();}
        }
    }
    elsif ($func3 == 3) {
        switch($func7) {
            case 0  { $str_op = "rstas32" }
            case 1  { $str_op = "rstsa32" }
            case 2  { $str_op = "rstas16" }
            case 3  { $str_op = "rstsa16" }
            case 8  { $str_op = "kstas32"}
            case 9  { $str_op = "kstsa32"}
            case 10 { $str_op = "kstas16" }
            case 11 { $str_op = "kstsa16" }
            case 16 { $str_op = "urstas32" }
            case 17 { $str_op = "urstsa32" }
            case 18 { $str_op = "urstas16" }
            case 19 { $str_op = "urstsa16" }
            case 24 { $str_op = "ukstas32" }
            case 25 { $str_op = "ukstsa32" }
            case 26 { $str_op = "ukstas16" }
            case 27 { $str_op = "ukstsa16" }
            case 32 { $str_op = "stas32" }
            case 33 { $str_op = "stsa32" }
            case 34 { $str_op = "stas16" }
            case 35 { $str_op = "stsa16" }
            else   { return unknown();}
        }
    }
    else   { return unknown();}

    my $shift_instr = $imm3 || $imm4 || $imm5 || $imm6 ;
    
    if ($only_rs1 == 1) {
        return sprintf "%s %s, %s", $str_op, str_ireg($rd), str_ireg($rs1);
    }
    elsif ($shift_instr) {
        return sprintf "%s %s, %s, #%s", $str_op, str_ireg($rd), str_ireg($rs1), $shamt5 if ($str_op =~ "wexti");
        return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), ($imm3 ? $shamt3 : ($imm4 ? $shamt4 : ($imm5 ? $shamt5 : $shamt6)));
    }
    elsif ($imm == 1) {
        if ($str_op eq "bitrevi" || $str_op eq "srai_u") {
            return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), (($misa_base == 2) ? $shamt6 : ($shamt6 & 0x1f));
        }
        elsif ($str_op eq "insb") {
            return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), (($misa_base == 2) ? $shamt3 : ($shamt3 & 0x3));
        }
        elsif (($str_op eq "mtlbi") || ($str_op eq "mtlei")) {
            return sprintf "%s %s", $str_op, $imm15s;
        }
    }
    else {
        # R-type
        return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), str_ireg($rs2);
    }
}

sub reserved {
	return sprintf "reserved instructions";
}

sub custom2{
	my $str_op;
	my $flag = 0;
	my $bit30 = ($instn >> 30) & 0x1;
	my $imm1;
	my $imm2;
	switch($func3) {
	case 0 {
		switch($func7) {
		case 5 { $str_op = "lea.h" }
		case 6 { $str_op = "lea.w" }
		case 7 { $str_op = "lea.d" }
		case 8 { $str_op = "lea.b.ze" }
		case 9 { $str_op = "lea.h.ze" }
		case 10 { $str_op = "lea.w.ze" }
		case 11 { $str_op = "lea.d.ze" }
		case 16 { $str_op = "ffb" }
		case 17 { $str_op = "ffzmism" }
		case 18 { $str_op = "ffmism" }
		case 19 { $str_op = "flmism" }
		else { return unknown();}
		}
	}
	case 2 { $str_op = "bfoz"; $flag = 1; }
	case 3 { $str_op = "bfos"; $flag = 1; }
	case 4 { 
		if (($func7 >> 1) == 0) {
			switch($rs1) {
				case 0 {
					$str_op = "vfwcvt.s.bf16";
					$flag = 4;
				}
				case 1 {
					$str_op = "vfncvt.bf16.s";
					$flag = 4;
				}
				case 2 {
					$str_op = "fcvt.s.bf16";
					$flag = 5;
				} 
				case 3 {
					$str_op = "fcvt.bf16.s";
					$flag = 5;
				}
				case 4 {
					$str_op = "vfwcvt.f.n.v";
					$flag = 9;
				}
				case 5 {
					$str_op = "vfwcvt.f.nu.v";
					$flag = 9;
				}
				case 6 {
					$str_op = "vfwcvt.f.b.v";
					$flag = 9;
				}
				case 7 {
					$str_op = "vfwcvt.f.bu.v";
					$flag = 9;
				}
				else {
					return unknown();
				}
			}
		}
                elsif (($func7 >> 1) == 1) {
                        switch($rs2) {
                                case 0 {
					$str_op = "vle4.v";
                                        $flag = 6;
                                }
                                case 2 {
                                        $str_op = "vln8.v";
                                        $flag = 6;
                                }
                                case 3 {
                                        $str_op = "vlnu8.v";
                                        $flag = 6;
                                }
                                else {
                                        return unknown();
                                }
                        }
                }
		elsif (($func7 >> 1) == 2) {
			$str_op = "vfpmadt.vf";
			$flag = 7;
		}
		elsif (($func7 >> 1) == 3) {
			$str_op = "vfpmadb.vf";
			$flag = 7;
		}
		elsif (($func7 >> 1) == 4) {
			$str_op = "vd4dots.vv";
			$flag = 8;
		}
		elsif (($func7 >> 1) == 5) {
			$str_op = "vd4dotsu.vv";
			$flag = 8;
		}
		elsif (($func7 >> 1) == 7) {
			$str_op = "vd4dotu.vv";
			$flag = 8;
		}
		else {
			return unknown();
		}
	}
	case 5 { $str_op = "beqc"; $flag = 2; }
	case 6 { $str_op = "bnec"; $flag = 2; }
	case 7 { $str_op = ($bit30) ? "bbs" : "bbc"; $flag = 3; }
	else { return unknown();}
	}
	if ($flag == 1) {
		$imm1 = ($instn >> 26) & 0x3f;
		$imm2 = ($instn >> 20) & 0x3f;
		return sprintf "%s %s, %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), ($misa_base == 2) ? str_imm6($imm1) : str_imm5($imm1), ($misa_base == 2) ? str_imm6($imm2) : str_imm5($imm2);
	}
	elsif ($flag == 2) {
		$imm1 = (($instn >> 24) & 0x40) + (($instn >> 2) & 0x20) + (($instn >> 20) & 0x1f);
		$imm2 = (($instn >> 21) & 0x400) + (($instn >> 20) & 0x3e0) + (($instn >> 7) & 0x1e);
		return sprintf "%s %s, %s, %s", $str_op, str_ireg($rs1), str_imm7($imm1), str_imm11($imm2);
	}
	elsif ($flag == 3) {
		$imm1 = ($misa_base == 2) ? (($instn >> 20) & 0x1f) + (($instn >> 2) & 0x20): (($instn >> 20) & 0x1f);
		$imm2 = (($instn >> 21) & 0x400) + (($instn >> 20) & 0x3e0) + (($instn >> 7) & 0x1e);
		return sprintf "%s %s, %s, %s", $str_op, str_ireg($rs1),($misa_base == 2) ? str_imm6($imm1) : str_imm5($imm1), str_imm11($imm2);
	}
	elsif ($flag == 4) {
		return sprintf "%s %s, %s", $str_op, str_vreg($rd), str_vreg($rs2);
	}
	elsif ($flag == 5) {
		return sprintf "%s %s, %s", $str_op, str_freg($rd), str_freg($rs2);
	}
        elsif ($flag == 6) {
                my $vm = ($instn >> 25) & 0x1;
                if ($vm) {
                        return sprintf "%s %s, (%s)", $str_op, str_vreg($rd), str_ireg($rs1);
                }
                else {
                        return sprintf "%s %s, (%s), v0.t", $str_op, str_vreg($rd), str_ireg($rs1);
                }
        }
	elsif ($flag == 7) {
		my $vm = ($instn >> 25) & 0x1;
		if (!$vm) {
			return sprintf "%s %s, %s, %s, v0.t", $str_op, str_vreg($rd), str_freg($rs1), str_vreg($rs2);
		}
		else {
			return sprintf "%s %s, %s, %s", $str_op, str_vreg($rd), str_freg($rs1), str_vreg($rs2);
		}
	}
	elsif ($flag == 8) {
		my $vm = ($instn >> 25) & 0x1;
		return sprintf "%s %s, %s, %s%s", $str_op, str_vreg($rd), str_vreg($rs1), str_vreg($rs2), $vm ? "" : ", v0.t";
	}
	elsif ($flag == 9) {
		my $vm = ($instn >> 25) & 0x1;
		if ($vm) {
			return sprintf "%s %s, %s", $str_op, str_vreg($rd), str_vreg($rs2);
		}
		else {
			return sprintf "%s %s, %s, v0.t", $str_op, str_vreg($rd), str_vreg($rs2);
		}
	}
	else {
		return sprintf "%s %s, %s, %s", $str_op, str_ireg($rd), str_ireg($rs1), str_ireg($rs2);
	}
}

sub br {
	my $str_op;
	my $imm12 = ($instn >> 19) & 0x1000;
	my $imm10_5 = ($instn >> 20) & 0x7e0;
	my $imm4_1 = ($instn >> 7) & 0x1e;
	my $imm11 = ($instn * 16) & 0x800;
	my $imm = $imm12 + $imm11 + $imm10_5 + $imm4_1;
	switch($func3) {
	case 0 { $str_op = "beq" }
	case 1 { $str_op = "bne" }
	case 4 { $str_op = "blt" }
	case 5 { $str_op = "bge" }
	case 6 { $str_op = "bltu" }
	case 7 { $str_op = "bgeu" }
	else   { return unknown();}
	}
	return sprintf "%s %s, %s, %s", $str_op, str_ireg($rs1), str_ireg($rs2), str_pc_offset13($imm);
}

sub sys {
	my $str_op;
	my $csr = ($instn >> 20) & 0xfff;
	my $csr_name;
	switch($csr) {
	case 0x000  { $csr_name = "ustatus"; }
	case 0x001  { $csr_name = "fflags"; }
	case 0x002  { $csr_name = "frm"; }
	case 0x003  { $csr_name = "fcsr"; }
	case 0x004  { $csr_name = "uie"; }
	case 0x005  { $csr_name = "utvec"; }
        case 0x008  { $csr_name = "vstart"; }
        case 0x009  { $csr_name = "vxsat"; }
        case 0x00a  { $csr_name = "vxrm"; }
	case 0x040  { $csr_name = "uscratch"; }
	case 0x041  { $csr_name = "uepc"; }
	case 0x042  { $csr_name = "ucause"; }
	case 0x043  { $csr_name = "utval"; }
	case 0x044  { $csr_name = "uip"; }
	case 0x100  { $csr_name = "sstatus"; }
	case 0x102  { $csr_name = "sedeleg"; }
	case 0x103  { $csr_name = "sideleg"; }
	case 0x104  { $csr_name = "sie"; }
	case 0x105  { $csr_name = "stvec"; }
	case 0x106  { $csr_name = "scounteren"; }
	case 0x140  { $csr_name = "sscratch"; }
	case 0x141  { $csr_name = "sepc"; }
	case 0x142  { $csr_name = "scause"; }
	case 0x143  { $csr_name = "stval"; }
	case 0x144  { $csr_name = "sip"; }
	case 0x180  { $csr_name = "satp"; }
	case 0x300  { $csr_name = "mstatus"; }
	case 0x301  { $csr_name = "misa"; }
	case 0x302  { $csr_name = "medeleg"; }
	case 0x303  { $csr_name = "mideleg"; }
	case 0x304  { $csr_name = "mie"; }
	case 0x305  { $csr_name = "mtvec"; }
	case 0x306  { $csr_name = "mcounteren"; }
	case 0x320  { $csr_name = "mcountinhibit"; }
	case 0x323  { $csr_name = "mhpmevent3"; }
	case 0x324  { $csr_name = "mhpmevent4"; }
	case 0x325  { $csr_name = "mhpmevent5"; }
	case 0x326  { $csr_name = "mhpmevent6"; }
	case 0x327  { $csr_name = "mhpmevent7"; }
	case 0x328  { $csr_name = "mhpmevent8"; }
	case 0x329  { $csr_name = "mhpmevent9"; }
	case 0x32a  { $csr_name = "mhpmevent10"; }
	case 0x32b  { $csr_name = "mhpmevent11"; }
	case 0x32c  { $csr_name = "mhpmevent12"; }
	case 0x32d  { $csr_name = "mhpmevent13"; }
	case 0x32e  { $csr_name = "mhpmevent14"; }
	case 0x32f  { $csr_name = "mhpmevent15"; }
	case 0x330  { $csr_name = "mhpmevent16"; }
	case 0x331  { $csr_name = "mhpmevent17"; }
	case 0x332  { $csr_name = "mhpmevent18"; }
	case 0x333  { $csr_name = "mhpmevent19"; }
	case 0x334  { $csr_name = "mhpmevent20"; }
	case 0x335  { $csr_name = "mhpmevent21"; }
	case 0x336  { $csr_name = "mhpmevent22"; }
	case 0x337  { $csr_name = "mhpmevent23"; }
	case 0x338  { $csr_name = "mhpmevent24"; }
	case 0x339  { $csr_name = "mhpmevent25"; }
	case 0x33a  { $csr_name = "mhpmevent26"; }
	case 0x33b  { $csr_name = "mhpmevent27"; }
	case 0x33c  { $csr_name = "mhpmevent28"; }
	case 0x33d  { $csr_name = "mhpmevent29"; }
	case 0x33e  { $csr_name = "mhpmevent30"; }
	case 0x33f  { $csr_name = "mhpmevent31"; }
	case 0x340  { $csr_name = "mscratch"; }
	case 0x341  { $csr_name = "mepc"; }
	case 0x342  { $csr_name = "mcause"; }
	case 0x343  { $csr_name = "mtval"; }
	case 0x344  { $csr_name = "mip"; }
	case 0x380  { $csr_name = "mbase"; }
	case 0x381  { $csr_name = "mbound"; }
	case 0x382  { $csr_name = "mibase"; }
	case 0x383  { $csr_name = "mibound"; }
	case 0x384  { $csr_name = "mdbase"; }
	case 0x385  { $csr_name = "mdbound"; }
	case 0x3a0  { $csr_name = "pmpcfg0"; }
	case 0x3a1  { $csr_name = "pmpcfg1"; }
	case 0x3a2  { $csr_name = "pmpcfg2"; }
	case 0x3a3  { $csr_name = "pmpcfg3"; }
	case 0x3b0  { $csr_name = "pmpaddr0"; }
	case 0x3b1  { $csr_name = "pmpaddr1"; }
	case 0x3b2  { $csr_name = "pmpaddr2"; }
	case 0x3b3  { $csr_name = "pmpaddr3"; }
	case 0x3b4  { $csr_name = "pmpaddr4"; }
	case 0x3b5  { $csr_name = "pmpaddr5"; }
	case 0x3b6  { $csr_name = "pmpaddr6"; }
	case 0x3b7  { $csr_name = "pmpaddr7"; }
	case 0x3b8  { $csr_name = "pmpaddr8"; }
	case 0x3b9  { $csr_name = "pmpaddr9"; }
	case 0x3ba  { $csr_name = "pmpaddr10"; }
	case 0x3bb  { $csr_name = "pmpaddr11"; }
	case 0x3bc  { $csr_name = "pmpaddr12"; }
	case 0x3bd  { $csr_name = "pmpaddr13"; }
	case 0x3be  { $csr_name = "pmpaddr14"; }
	case 0x3bf  { $csr_name = "pmpaddr15"; }
	case 0x7a0  { $csr_name = "tselect"; }
	case 0x7a1  { $csr_name = "tdata1"; }
	case 0x7a2  { $csr_name = "tdata2"; }
	case 0x7a3  { $csr_name = "tdata3"; }
	case 0x7a4  { $csr_name = "tinfo"; }
	case 0x7a5  { $csr_name = "tcontrol"; }
	case 0x7a8  { $csr_name = "mcontext"; }
	case 0x7aa  { $csr_name = "scontext"; }
	case 0x7b0  { $csr_name = "dcsr"; }
	case 0x7b1  { $csr_name = "dpc"; }
	case 0x7b2  { $csr_name = "dscratch0"; }
	case 0x7b3  { $csr_name = "dscratch1"; }
	case 0x7c0  { $csr_name = "milmb"; }
	case 0x7c1  { $csr_name = "mdlmb"; }
	case 0x7c2  { $csr_name = "mecc_code"; }
	case 0x7c3  { $csr_name = "mnvec"; }
	case 0x7c4  { $csr_name = "mxstatus"; }
	case 0x7c5  { $csr_name = "mpft_ctl"; }
	case 0x7c6  { $csr_name = "mhsp_ctl"; }
	case 0x7c7  { $csr_name = "msp_bound"; }
	case 0x7c8  { $csr_name = "msp_base"; }
	case 0x7c9  { $csr_name = "mdcause"; }
	case 0x7ca  { $csr_name = "mcache_ctl"; }
	case 0x7cb  { $csr_name = "mcctlbeginaddr"; }
	case 0x7cc  { $csr_name = "mcctlcommand"; }
	case 0x7cd  { $csr_name = "mcctldata"; }
	case 0x7ce  { $csr_name = "mcounterwen"; }
	case 0x7cf  { $csr_name = "mcounterinten"; }
	case 0x7d0  { $csr_name = "mmisc_ctl"; }
	case 0x7d1  { $csr_name = "mcountermask_m"; }
	case 0x7d2  { $csr_name = "mcountermask_s"; }
	case 0x7d3  { $csr_name = "mcountermask_u"; }
	case 0x7d4  { $csr_name = "mcounterovf"; }
	case 0x7d5  { $csr_name = "mslideleg";}
	case 0x7df  { $csr_name = "mclk_ctl";}
	case 0x7e0  { $csr_name = "dexc2dbg"; }
	case 0x7e1  { $csr_name = "ddcause"; }
	case 0x7fc  { $csr_name = "mrandseq"; }
	case 0x7fd  { $csr_name = "mrandseqh"; }
	case 0x7fe  { $csr_name = "mrandstate"; }
	case 0x7ff  { $csr_name = "mrandstateh"; }
	case 0x800  { $csr_name = "uitb"; }
	case 0x801  { $csr_name = "ucode"; }
	case 0x80b  { $csr_name = "ucctlbeginaddr"; }
	case 0x80c  { $csr_name = "ucctlcommand"; }
	case 0x9c4  { $csr_name = "slie"; }
	case 0x9c5  { $csr_name = "slip"; }
	case 0x9c9  { $csr_name = "sdcause"; }
	case 0x9cd  { $csr_name = "scctldata"; }
	case 0x9cf  { $csr_name = "scounterinten"; }
	case 0x9d0  { $csr_name = "smisc_ctl"; }
	case 0x9d1  { $csr_name = "scountermask_m"; }
	case 0x9d2  { $csr_name = "scountermask_s"; }
	case 0x9d3  { $csr_name = "scountermask_u"; }
	case 0x9d4  { $csr_name = "scounterovf"; }
	case 0x9e0  { $csr_name = "scountinhibit"; }
	case 0x9e3  { $csr_name = "shpmevent3"; }
	case 0x9e4  { $csr_name = "shpmevent4"; }
	case 0x9e5  { $csr_name = "shpmevent5"; }
	case 0x9e6  { $csr_name = "shpmevent6"; }
	case 0xb00  { $csr_name = "mcycle"; }
	case 0xb02  { $csr_name = "minstret"; }
	case 0xb03  { $csr_name = "mhpmcounter3"; }
	case 0xb04  { $csr_name = "mhpmcounter4"; }
	case 0xb05  { $csr_name = "mhpmcounter5"; }
	case 0xb06  { $csr_name = "mhpmcounter6"; }
	case 0xb07  { $csr_name = "mhpmcounter7"; }
	case 0xb08  { $csr_name = "mhpmcounter8"; }
	case 0xb09  { $csr_name = "mhpmcounter9"; }
	case 0xb0a  { $csr_name = "mhpmcounter10"; }
	case 0xb0b  { $csr_name = "mhpmcounter11"; }
	case 0xb0c  { $csr_name = "mhpmcounter12"; }
	case 0xb0d  { $csr_name = "mhpmcounter13"; }
	case 0xb0e  { $csr_name = "mhpmcounter14"; }
	case 0xb0f  { $csr_name = "mhpmcounter15"; }
	case 0xb10  { $csr_name = "mhpmcounter16"; }
	case 0xb11  { $csr_name = "mhpmcounter17"; }
	case 0xb12  { $csr_name = "mhpmcounter18"; }
	case 0xb13  { $csr_name = "mhpmcounter19"; }
	case 0xb14  { $csr_name = "mhpmcounter20"; }
	case 0xb15  { $csr_name = "mhpmcounter21"; }
	case 0xb16  { $csr_name = "mhpmcounter22"; }
	case 0xb17  { $csr_name = "mhpmcounter23"; }
	case 0xb18  { $csr_name = "mhpmcounter24"; }
	case 0xb19  { $csr_name = "mhpmcounter25"; }
	case 0xb1a  { $csr_name = "mhpmcounter26"; }
	case 0xb1b  { $csr_name = "mhpmcounter27"; }
	case 0xb1c  { $csr_name = "mhpmcounter28"; }
	case 0xb1d  { $csr_name = "mhpmcounter29"; }
	case 0xb1e  { $csr_name = "mhpmcounter30"; }
	case 0xb1f  { $csr_name = "mhpmcounter31"; }
	case 0xb80  { $csr_name = "mcycleh"; }
	case 0xb82  { $csr_name = "minstreth"; }
	case 0xb83  { $csr_name = "mhpmcounter3h"; }
	case 0xb84  { $csr_name = "mhpmcounter4h"; }
	case 0xb85  { $csr_name = "mhpmcounter5h"; }
	case 0xb86  { $csr_name = "mhpmcounter6h"; }
	case 0xb87  { $csr_name = "mhpmcounter7h"; }
	case 0xb88  { $csr_name = "mhpmcounter8h"; }
	case 0xb89  { $csr_name = "mhpmcounter9h"; }
	case 0xb8a  { $csr_name = "mhpmcounter10h"; }
	case 0xb8b  { $csr_name = "mhpmcounter11h"; }
	case 0xb8c  { $csr_name = "mhpmcounter12h"; }
	case 0xb8d  { $csr_name = "mhpmcounter13h"; }
	case 0xb8e  { $csr_name = "mhpmcounter14h"; }
	case 0xb8f  { $csr_name = "mhpmcounter15h"; }
	case 0xb90  { $csr_name = "mhpmcounter16h"; }
	case 0xb91  { $csr_name = "mhpmcounter17h"; }
	case 0xb92  { $csr_name = "mhpmcounter18h"; }
	case 0xb93  { $csr_name = "mhpmcounter19h"; }
	case 0xb94  { $csr_name = "mhpmcounter20h"; }
	case 0xb95  { $csr_name = "mhpmcounter21h"; }
	case 0xb96  { $csr_name = "mhpmcounter22h"; }
	case 0xb97  { $csr_name = "mhpmcounter23h"; }
	case 0xb98  { $csr_name = "mhpmcounter24h"; }
	case 0xb99  { $csr_name = "mhpmcounter25h"; }
	case 0xb9a  { $csr_name = "mhpmcounter26h"; }
	case 0xb9b  { $csr_name = "mhpmcounter27h"; }
	case 0xb9c  { $csr_name = "mhpmcounter28h"; }
	case 0xb9d  { $csr_name = "mhpmcounter29h"; }
	case 0xb9e  { $csr_name = "mhpmcounter30h"; }
	case 0xb9f  { $csr_name = "mhpmcounter31h"; }
        case 0xbc0  { $csr_name = "pmacfg0"; }
        case 0xbc1  { $csr_name = "pmacfg1"; }
        case 0xbc2  { $csr_name = "pmacfg2"; }
        case 0xbc3  { $csr_name = "pmacfg3"; }
        case 0xbd0  { $csr_name = "pmaaddr0"; }
        case 0xbd1  { $csr_name = "pmaaddr1"; }
        case 0xbd2  { $csr_name = "pmaaddr2"; }
        case 0xbd3  { $csr_name = "pmaaddr3"; }
        case 0xbd4  { $csr_name = "pmaaddr4"; }
        case 0xbd5  { $csr_name = "pmaaddr5"; }
        case 0xbd6  { $csr_name = "pmaaddr6"; }
        case 0xbd7  { $csr_name = "pmaaddr7"; }
        case 0xbd8  { $csr_name = "pmaaddr8"; }
        case 0xbd9  { $csr_name = "pmaaddr9"; }
        case 0xbda  { $csr_name = "pmaaddr10"; }
        case 0xbdb  { $csr_name = "pmaaddr11"; }
        case 0xbdc  { $csr_name = "pmaaddr12"; }
        case 0xbdd  { $csr_name = "pmaaddr13"; }
        case 0xbde  { $csr_name = "pmaaddr14"; }
        case 0xbdf  { $csr_name = "pmaaddr15"; }
	case 0xc00  { $csr_name = "cycle"; }
	case 0xc01  { $csr_name = "time"; }
	case 0xc02  { $csr_name = "instret"; }
	case 0xc03  { $csr_name = "hpmcounter3"; }
	case 0xc04  { $csr_name = "hpmcounter4"; }
	case 0xc05  { $csr_name = "hpmcounter5"; }
	case 0xc06  { $csr_name = "hpmcounter6"; }
	case 0xc07  { $csr_name = "hpmcounter7"; }
	case 0xc08  { $csr_name = "hpmcounter8"; }
	case 0xc09  { $csr_name = "hpmcounter9"; }
	case 0xc0a  { $csr_name = "hpmcounter10"; }
	case 0xc0b  { $csr_name = "hpmcounter11"; }
	case 0xc0c  { $csr_name = "hpmcounter12"; }
	case 0xc0d  { $csr_name = "hpmcounter13"; }
	case 0xc0e  { $csr_name = "hpmcounter14"; }
	case 0xc0f  { $csr_name = "hpmcounter15"; }
	case 0xc10  { $csr_name = "hpmcounter16"; }
	case 0xc11  { $csr_name = "hpmcounter17"; }
	case 0xc12  { $csr_name = "hpmcounter18"; }
	case 0xc13  { $csr_name = "hpmcounter19"; }
	case 0xc14  { $csr_name = "hpmcounter20"; }
	case 0xc15  { $csr_name = "hpmcounter21"; }
	case 0xc16  { $csr_name = "hpmcounter22"; }
	case 0xc17  { $csr_name = "hpmcounter23"; }
	case 0xc18  { $csr_name = "hpmcounter24"; }
	case 0xc19  { $csr_name = "hpmcounter25"; }
	case 0xc1a  { $csr_name = "hpmcounter26"; }
	case 0xc1b  { $csr_name = "hpmcounter27"; }
	case 0xc1c  { $csr_name = "hpmcounter28"; }
	case 0xc1d  { $csr_name = "hpmcounter29"; }
	case 0xc1e  { $csr_name = "hpmcounter30"; }
	case 0xc1f  { $csr_name = "hpmcounter31"; }
	case 0xc20  { $csr_name = "vl"; }
	case 0xc21  { $csr_name = "vtype"; }
	case 0xc22  { $csr_name = "vlenb"; }
	case 0xc80  { $csr_name = "cycleh"; }
	case 0xc81  { $csr_name = "timeh"; }
	case 0xc82  { $csr_name = "instreth"; }
	case 0xc83  { $csr_name = "hpmcounter3h"; }
	case 0xc84  { $csr_name = "hpmcounter4h"; }
	case 0xc85  { $csr_name = "hpmcounter5h"; }
	case 0xc86  { $csr_name = "hpmcounter6h"; }
	case 0xc87  { $csr_name = "hpmcounter7h"; }
	case 0xc88  { $csr_name = "hpmcounter8h"; }
	case 0xc89  { $csr_name = "hpmcounter9h"; }
	case 0xc8a  { $csr_name = "hpmcounter10h"; }
	case 0xc8b  { $csr_name = "hpmcounter11h"; }
	case 0xc8c  { $csr_name = "hpmcounter12h"; }
	case 0xc8d  { $csr_name = "hpmcounter13h"; }
	case 0xc8e  { $csr_name = "hpmcounter14h"; }
	case 0xc8f  { $csr_name = "hpmcounter15h"; }
	case 0xc90  { $csr_name = "hpmcounter16h"; }
	case 0xc91  { $csr_name = "hpmcounter17h"; }
	case 0xc92  { $csr_name = "hpmcounter18h"; }
	case 0xc93  { $csr_name = "hpmcounter19h"; }
	case 0xc94  { $csr_name = "hpmcounter20h"; }
	case 0xc95  { $csr_name = "hpmcounter21h"; }
	case 0xc96  { $csr_name = "hpmcounter22h"; }
	case 0xc97  { $csr_name = "hpmcounter23h"; }
	case 0xc98  { $csr_name = "hpmcounter24h"; }
	case 0xc99  { $csr_name = "hpmcounter25h"; }
	case 0xc9a  { $csr_name = "hpmcounter26h"; }
	case 0xc9b  { $csr_name = "hpmcounter27h"; }
	case 0xc9c  { $csr_name = "hpmcounter28h"; }
	case 0xc9d  { $csr_name = "hpmcounter29h"; }
	case 0xc9e  { $csr_name = "hpmcounter30h"; }
	case 0xc9f  { $csr_name = "hpmcounter31h"; }
	case 0xf11  { $csr_name = "mvendorid"; }
	case 0xf12  { $csr_name = "marchid"; }
	case 0xf13  { $csr_name = "mimpid"; }
	case 0xf14  { $csr_name = "mhartid"; }
	case 0xfc0  { $csr_name = "micm_cfg"; }
	case 0xfc1  { $csr_name = "mdcm_cfg"; }
	case 0xfc2  { $csr_name = "mmsc_cfg"; }
	case 0xfc3  { $csr_name = "mmsc_cfg2"; }
	case 0xfc7  { $csr_name = "mvec_cfg"; }
	else      { $csr_name = $csr; }
	}
	switch($func3) {
	case 0 {
		if ($func7 == 9) { return sprintf "sfence.vma %s, %s", str_ireg($rs1), str_ireg($rs2) }
		else {
			switch($csr) {
			case 0 { $str_op = "ecall" }
			case 1 { $str_op = "ebreak" }
			case 2 { $str_op = "uret" }
			case 258 { $str_op = "sret" }
			case 261 { $str_op = "wfi" }
			case 514 { $str_op = "hret" }
			case 770 { $str_op = "mret" }
			case 1970 { $str_op = "dret" }
			else { return unknown();}
			}
			return sprintf "%s", $str_op;
		}
	}
	case 1 { return sprintf "csrrw %s, %s, %s", str_ireg($rd), $csr_name, str_ireg($rs1) }
	case 2 { return sprintf "csrrs %s, %s, %s", str_ireg($rd), $csr_name, str_ireg($rs1) }
	case 3 { return sprintf "csrrc %s, %s, %s", str_ireg($rd), $csr_name, str_ireg($rs1) }
	case 5 { return sprintf "csrrwi %s, %s, %s", str_ireg($rd), $csr_name, $rs1 }
	case 6 { return sprintf "csrrsi %s, %s, %s", str_ireg($rd), $csr_name, $rs1 }
	case 7 { return sprintf "csrrci %s, %s, %s", str_ireg($rd), $csr_name, $rs1 }
	else   { return unknown();}
	}
}

sub custom3 {
	my $instn_hex = sprintf "%08x", $instn;
	if (exists $ace_disassembly{$instn_hex}) {
		return $ace_disassembly{$instn_hex};
	} else {
		return sprintf "custom3, %08x", $instn;
	}
}

sub unknown{
	return sprintf "unknown %08x", $instn;
}

sub misc_alu {
	my $str_op;
	my $func2 = ($instn >> 10) & 0x3;
	my $func3 = ($instn >> 10) & 0x7;
	my $funct = ($instn >> 5) & 0x3;
	my $imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x1f);
	switch($func2) {
	case 0 {
		if ($imm == 0) { return sprintf "c.srli64 %s, %s, 64", str_creg($rd_q), str_creg($rd_q) }
		else { return sprintf "c.srli %s, %s, %s", str_creg($rd_q), str_creg($rd_q), str_imm12($imm); }
	}
	case 1 {
		if ($imm == 0) { return sprintf "c.srai64 %s, %s, 64", str_creg($rd_q), str_creg($rd_q) }
		else { return sprintf "c.srai %s, %s, %s", str_creg($rd_q), str_creg($rd_q), str_imm12($imm); }
	}
	case 2 { return sprintf "c.andi %s, %s, %s", str_creg($rd_q), str_creg($rd_q), str_simm6($imm) }
	case 3 {
		switch($func3) {
		case 3 {
			switch($funct) {
			case 0 { $str_op = "c.sub" }
			case 1 { $str_op = "c.xor" }
			case 2 { $str_op = "c.or" }
			case 3 { $str_op = "c.and" }
			}
		}
		case 7 {
			switch($funct) {
			case 0 { $str_op = "c.subw" }
			case 1 { $str_op = "c.addw" }
			case 2 { return reserved() }
			case 3 { return reserved() }
			}
		}
		else     { return unknown();}
		}
		return sprintf  "%s %s, %s, %s", $str_op, str_creg($rd_q), str_creg($rd_q), str_creg($rs2_q)
	}
	}
}

sub decode11 {
	$rd = ($instn >> 7) & 0x1f;
	$rs1 = ($instn >> 15) & 0x1f;
	$rs2 = ($instn >> 20) & 0x1f;
	$rs3 = ($instn >> 27) & 0x1f;
        $rm  = ($instn >> 12) & 0x7;
	$func3 = ($instn >> 12) & 0x7;
	$func7 = ($instn >> 25) & 0x7f;
	my $imm;
	my $type = ($instn >> 2) & 0x1f;
	if ($type == 0)    { return load() }
	elsif ($type == 1) { return load_fp() } # load_fp includes vector load
	elsif ($type == 2) { return custom0() }
	elsif ($type == 3) { return misc_mem() }
	elsif ($type == 4) { return op_imm() }
	elsif ($type == 5) {
		my $abs_addr;
		my $rel_addr;
		$imm = $instn & 0xfffff000 ;
		$abs_addr = $pc + $imm;
		return sprintf "auipc %s, 0x%08x (0x%08x)", str_ireg($rd), $imm, $abs_addr;
	}
	elsif ($type == 6) { return op_imm_32() }
	elsif ($type == 8) { return store() }
	elsif ($type == 9) { return store_fp() } # store_fp includes vector store
	elsif ($type == 10) { return custom1() }
	elsif ($type == 11) { return amo() } # amo includes vector amo
	elsif ($type == 12) { return op() }
	elsif ($type == 13) {
		$imm = $instn & 0xfffff000 ;
		return sprintf "lui %s, 0x%08x", str_ireg($rd), $imm
	}
	elsif ($type == 14) { return op_32() }
	elsif ($type == 16) { return madd() }
	elsif ($type == 17) { return msub() }
	elsif ($type == 18) { return nmsub() }
	elsif ($type == 19) { return nmadd() }
	elsif ($type == 20) { return op_fp() }
	elsif ($type == 21) { return op_v() }
	elsif ($type == 22) { return custom2() }
	elsif ($type == 24) { return br() }
	elsif ($type == 25) {
		$imm = ($instn >> 20) & 0xfff;
		return sprintf "jalr %s, %s (%s)", str_ireg($rd), str_simm12($imm), str_ireg($rs1) } 
	elsif ($type == 26) { return reserved() }
	elsif ($type == 27) {
		my $imm20 = ($instn >> 11) & 0x100000;
		my $imm19_12 = $instn & 0xff000;
		my $imm11 = ($instn >> 9) & 0x800;
		my $imm10_1 = ($instn >> 20) & 0x7fe;
		$imm = $imm20 + $imm19_12 + $imm11 + $imm10_1 ;
		return sprintf "jal %s, %s", str_ireg($rd), str_pc_offset21_jal($imm)
	}
	elsif ($type == 28) { return sys() }
	elsif ($type == 29) { return reserved() }
        elsif ($type == 30) { return custom3() }
        elsif ($type == 31) { return dsp() }
	else    { return unknown();}
}

sub decode00 {
	$rd_q = ($instn >> 2) & 0x7;
	$rs1_q = ($instn >> 7) & 0x7;
	$func3 = ($instn >> 13) & 0x7;
	my $imm;
	if ($func3 == 0) {
		$imm = (($instn >> 7) & 0x30) + (($instn >> 1) & 0x3c0) + (($instn >> 4) & 0x4) + (($instn >> 2) & 0x8);
		return sprintf "c.addi4spn %s, sp, %s", str_creg($rd_q), str_simm10($imm);
	}
	elsif ($func3 == 1) {
		if ($push_pop_support == 1) { # c.lbu
			$imm = (($instn >> 7) & 0x18) + (($instn >> 4) & 0x06) + (($instn >> 12) & 0x1);#4:3 2:1 0
			return sprintf "c.lbu %s, %s (%s)", str_creg($rd_q), str_simm6($imm), str_creg($rs1_q);
		}
		elsif (($misa_base == 1) || ($misa_base == 2)) {
			$imm = (($instn >> 7) & 0x38) + (($instn << 1) & 0xc0);#5:3 7:6
			return sprintf "c.fld %s, %s (%s)", str_cfreg($rd_q), str_simm8($imm), str_creg($rs1_q);
		}
		else {
			$imm = (($instn >> 7) & 0x30) + (($instn << 1) & 0xc0) + (($instn >> 2) & 0x100); #5:4|8 7:6
			return sprintf "c.lq %s, %s (%s)", str_creg($rd_q), str_simm9($imm), str_creg($rs1_q);
		}
	}
	elsif ($func3 == 2) {
		$imm = (($instn >> 7) & 0x38) + (($instn >> 4) & 0x4) + (($instn << 1) & 0x40); #5:3 2|6
		return sprintf "c.lw %s, %s (%s)", str_creg($rd_q), str_simm7($imm), str_creg($rs1_q);
	}
	elsif ($func3 == 3) {
		if ($misa_base == 1) {
			$imm = (($instn >> 7) & 0x38) + (($instn >> 4) & 0x4) + (($instn << 1) & 0x40); #5:3 2|6
			return sprintf "c.flw %s, %s (%s)", str_cfreg($rd_q), str_simm7($imm), str_creg($rs1_q);
		}
		else {
			$imm = (($instn >> 7) & 0x38) + (($instn << 1) & 0xc0);#5:3 7:6
			return sprintf "c.ld %s, %s (%s)", str_creg($rd_q), str_simm8($imm), str_creg($rs1_q);
		}
	}
	elsif ($func3 == 4) {
		my $str_op;
		my $codense = ($instn >> 7) & 0x3; # originally ex9 or ex10
		my $imm1 = ($instn >> 2) & 0x2;
		my $imm2 = ($instn >> 2) & 0x4;
		my $imm4_3 = ($instn >> 7) & 0x18;
		my $imm5 = ($instn << 3) & 0x20;
		my $imm7_6 = ($instn << 1) & 0xc0;
		my $imm8 = ($instn >> 1) & 0x100;
		my $imm9;
		my $imm10 = ($instn >> 2) & 0x400;
		if ($push_pop_support == 1) {
			if (($instn >> 10) & 0x7 != 4) {
				 return unknown();
			}
			my @inst_list = (
			    "ra",	    "ra, s0",	    "ra, s0-s1",    "ra, s0-s2",
			    "ra, s0-s3" ,   "ra, s0-s5",    "ra, s0-s8",    "ra, s0-s11");
			my $offset = ($rv64 == 1) ? 8 : 4;
			my $push_pop_op	= ($instn >> 5) & 0x3;
			if ($push_pop_op == 0) { # c.pop
				my $spimm   = ($instn >> 2) & 0x07;	# spimm[2:1] of pop should be zero.
				my $rcount  = ($instn >> 7) & 0x07;
				my $sp_adj  = $spimm*16 + calculate_sp_adj($rcount);
				return sprintf "c.pop {%s}, %d", @inst_list[$rcount], $sp_adj;
			}
			elsif ($push_pop_op == 1) { # c.popret
				my $spimm   = ($instn >> 2) & 0x07;	
				my $rcount  = ($instn >> 7) & 0x07;
				my $sp_adj  = $spimm*16 + calculate_sp_adj($rcount);
				return sprintf "c.popret {%s}, %d", @inst_list[$rcount], $sp_adj;
			}
			elsif ($push_pop_op == 2) { # c.push
				my $spimm   = ($instn >> 2) & 0x07;	
				my $rcount  = ($instn >> 7) & 0x07;
				my $sp_adj  = $spimm*16 + calculate_sp_adj($rcount);
				return sprintf "c.push {%s}, -%d", @inst_list[$rcount], $sp_adj;
			}
			else { return unknown() }
		}
		elsif ($codense == 0) {	# exec.it
			$imm9 = ($instn << 6) & 0x200;
			$imm = $imm2 + $imm4_3 + $imm5 + $imm7_6 + $imm8 + $imm9 + $imm10;
			return sprintf "exec.it %s", str_imm11($imm);
		}
		elsif ($codense == 1) { # exec.cs
			$imm9 = ($instn >> 3) & 0x200;
			$imm = $imm1 + $imm2 + $imm4_3 + $imm5 + $imm7_6 + $imm8 + $imm9;
			return sprintf "exex.cs %s", str_imm10($imm);
		}
		else { return unknown() }
	}
	elsif ($func3 == 5) {
		if ($push_pop_support == 1) { # c.sb
			$imm = (($instn >> 7) & 0x18) + (($instn >> 4) & 0x06) + (($instn >> 12) & 0x1); #4:3 2:1 :0
			my $rs1 = ($instn >> 7) & 0x7;
			my $rs2 = ($instn >> 2) & 0x7;
			return sprintf "c.sb %s, %s (%s)", str_creg($rs2), str_simm6($imm), str_creg($rs1);
		}
		elsif (($misa_base == 1) || ($misa_base == 2)) {
			$imm = (($instn >> 7) & 0x38) + (($instn << 1) & 0xc0);#5:3 7:6
			return sprintf "c.fsd %s, %s (%s)", str_cfreg($rd_q), str_simm8($imm), str_creg($rs1_q);
		}
		else {
			$imm = (($instn >> 7) & 0x30) + (($instn << 1) & 0xc0) + (($instn >> 2) & 0x100); #5:4|8 7:6
			return sprintf "c.sq %s, %s (%s)", str_creg($rd_q), str_simm9($imm), str_creg($rs1_q);
		}
	}
	elsif ($func3 == 6) {
		$imm = (($instn >> 7) & 0x38) + (($instn >> 4) & 0x4) + (($instn << 1) & 0x40); #5:3 2|6
		return sprintf "c.sw %s, %s (%s)", str_creg($rd_q), str_simm7($imm), str_creg($rs1_q);
	}
	elsif ($func3 == 7) {
		if ($misa_base == 1) {
			$imm = (($instn >> 7) & 0x38) + (($instn >> 4) & 0x4) + (($instn << 1) & 0x40); #5:3 2|6
			return sprintf "c.fsw %s, %s (%s)", str_cfreg($rd_q), str_simm7($imm), str_creg($rs1_q);
		}
		else{
			$imm = (($instn >> 7) & 0x38) + (($instn << 1) & 0xc0);#5:3 7:6
			return sprintf "c.sd %s, %s (%s)", str_creg($rd_q), str_simm8($imm), str_creg($rs1_q);
		}
	}
	else     { return unknown();}
}

sub decode01 {
	$rd = ($instn >> 7) & 0x1f;
	$rd_q = ($instn >> 7) & 0x7;
	$rs2_q = ($instn >> 2) & 0x7;
	$func3 = ($instn >> 13) & 0x7;
	my $imm;
	if ($func3 == 0) {
		$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x1f);
		if ($rd == 0) { return sprintf "c.nop" }
		else { return sprintf "c.addi %s, %s, %s", str_ireg($rd), str_ireg($rd), str_imm12($imm) }
	}
	elsif ($func3 == 1) {
		if ($misa_base == 1) {
			$imm = (($instn >> 1) & 0xb40) + (($instn >> 7) & 0x10) + (($instn << 2) & 0x400) + (($instn << 1) & 0x80) + (($instn >> 2) & 0xe) + (($instn << 3) & 0x20);
			return sprintf "c.jal %s", str_pc_offset12($imm);
		}
		else {
			$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x1f);
			return sprintf "c.addiw %s, %s, %s", str_ireg($rd), str_ireg($rd), str_simm6($imm);
		}
	}
	elsif ($func3 == 2) {
		$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x1f);
		return sprintf "c.li %s, %s", str_ireg($rd), str_simm6($imm);
	}
	elsif ($func3 == 3) {
		if ($rd != 0 && $rd != 2) {
			$imm = (($instn >> 3) & 0x200) + (($instn >> 2) & 0x10) + (($instn << 1) & 0x40) + (($instn << 4) & 0x180) + (($instn << 3) & 0x20);
			return sprintf "c.lui %s, %s", str_ireg($rd), str_simm18($imm);
		}
		elsif ($rd == 2){
			$imm = (($instn << 5) & 0x20000) + (($instn << 10) & 0x1f000);
			return sprintf "c.addi16sp sp, sp, %s", str_simm10($imm);
		}
		else { return unknown();}
	}
	elsif ($func3 == 4) { return misc_alu() }
	elsif ($func3 == 5) {
		$imm = (($instn >> 1) & 0xb40) + (($instn >> 7) & 0x10) + (($instn << 2) & 0x400) + (($instn << 1) & 0x80) + (($instn >> 2) & 0xe) + (($instn << 3) & 0x20);
 		return sprintf "c.j %s", str_pc_offset12($imm);
	}
	elsif ($func3 == 6) {
		$imm = (($instn >> 4) & 0x100) + (($instn >> 7) & 0x18) + (($instn << 1) & 0xc0) + (($instn >> 2) & 0x6) + (($instn << 3) & 0x20);
		return sprintf "c.beqz %s, %s", str_creg($rd_q), str_pc_offset9($imm);
	}
	elsif ($func3 == 7) {
		$imm = (($instn >> 4) & 0x100) + (($instn >> 7) & 0x18) + (($instn << 1) & 0xc0) + (($instn >> 2) & 0x6) + (($instn << 3) & 0x20);
		return sprintf "c.bnez %s, %s", str_creg($rd_q), str_pc_offset9($imm);
	}
	else     { return unknown();}
}

sub decode10 {
	$rd = ($instn >> 7) & 0x1f;
	$rs2 = ($instn >> 2) & 0x1f;
	$func3 = ($instn >> 13) & 0x7;
	my $imm12 = ($instn >> 12) & 0x1;
	my $imm;
	if ($func3 == 0) {
		$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x1f);
		if ($imm == 0) { return sprintf "c.slli64 %s, %s, 64", str_ireg($rd), str_ireg($rd) }
		else { return sprintf "c.slli %s, %s, %s", str_ireg($rd), str_ireg($rd), str_imm12($imm) }
	}
	elsif ($func3 == 1) {
		if ($push_pop_support == 1) { # c.lhu
			$imm = (($instn >> 7) & 0x38) + (($instn >> 4) & 0x06);#5:3 2:1
			$rs2 = ($instn >> 7) & 0x7;
			$rd = ($instn >> 2) & 0x7;
			return sprintf "c.lhu %s, %s (%s)", str_creg($rd), str_simm7($imm), str_creg($rs2);
		}
		elsif (($misa_base == 1) || ($misa_base == 2)) {
			$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x18) + (($instn << 4) & 0x1c0);
			return sprintf "c.fldsp %s, %s (sp)", str_freg($rd), str_simm9($imm);
		}
		else {
			$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x10) + (($instn << 4) & 0x3c0);
			return sprintf "c.lqsp %s, %s (sp)", str_ireg($rd), str_simm10($imm);
		}
	}
	elsif ($func3 == 2) {
		$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x1c) + (($instn << 4) & 0xc0);
		return sprintf "c.lwsp %s, %s (sp)", str_freg($rd), str_simm8($imm);
	}
	elsif ($func3 == 3) {
		if ($misa_base == 1) {
			$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x1c) + (($instn << 4) & 0xc0);
			return sprintf "c.flwsp %s, %s (sp)", str_ireg($rd), str_simm8($imm);
		}
		else {
			$imm = (($instn >> 7) & 0x20) + (($instn >> 2) & 0x18) + (($instn << 4) & 0x1c0);
			return sprintf "c.ldsp %s, %s (sp)", str_ireg($rd), str_simm9($imm);
		}
	}
	elsif ($func3 == 4) { #jr/mv/ebreak/jalr/add
		if ($imm12 == 0) {
			if ($rs2 == 0) { return sprintf "c.jr zero, 0 (%s)", str_ireg($rd) }
			else { return sprintf "c.mv %s, %s", str_ireg($rd), str_ireg($rs2) }
		}
		elsif ($imm12 == 1) {
			if ($rd == 0 && $rs2 == 0) { return sprintf "c.ebreak" }
			elsif ($rs2 == 0) { return sprintf "c.jalr %s", str_ireg($rd) }
			else { return sprintf "c.add %s, %s, %s", str_ireg($rd), str_ireg($rd), str_ireg($rs2) }
		}
	}
	elsif ($func3 == 5) {
		my $bit12 = ($instn >> 12) & 0x01;	
		if (($push_pop_support == 1) && ($bit12 == 1)) { # c.sh
			$imm = (($instn >> 7) & 0x18) + (($instn >> 4) & 0x06); #4:3 2:1
			my $rs1 = ($instn >> 7) & 0x7;
			my $rs2 = ($instn >> 2) & 0x7;
			return sprintf "c.sh %s, %s (%s)", str_creg($rs2), str_simm6($imm), str_creg($rs1);
		}
		elsif (($push_pop_support == 1) && ($bit12 == 0)) { # new exce.it
			my $imm2    = ($instn >> 2) & 0x4;
			my $imm4_3  = ($instn >> 7) & 0x18;
			my $imm5    = ($instn << 3) & 0x20;
			my $imm7_6  = ($instn << 1) & 0xc0;
			my $imm8    = ($instn >> 1) & 0x100;
			my $imm9    = ($instn << 6) & 0x200;
			my $imm10   = ($instn << 3) & 0x400;
			my $imm11   = ($instn << 3) & 0x800;
			$imm = $imm2 + $imm4_3 + $imm5 + $imm7_6 + $imm8 + $imm9 + $imm10 + $imm11;
			return sprintf "mexec.it %s", str_imm11($imm);
		}
		elsif (($misa_base == 1) || ($misa_base == 2)) {
			$imm = (($instn >> 7) & 0x38) + (($instn >> 1) & 0x1c0);
			return sprintf "c.fsdsp %s, %s (sp)", str_freg($rs2), str_simm9($imm);
		}
		else {
			$imm = (($instn >> 7) & 0x30) + (($instn << 1) & 0x3c0);
			return sprintf "c.sqsp %s, %s (sp)", str_ireg($rs2), str_simm10($imm);
		}
	}
	elsif ($func3 == 6) {
		$imm = (($instn >> 7) & 0x3c) + (($instn >> 1) & 0xc0);
		return sprintf "c.swsp %s, %s (sp)", str_ireg($rs2), str_simm8($imm);
	}
	elsif ($func3 == 7) {
		if ($misa_base == 1) {
			$imm = (($instn >> 7) & 0x3c) + (($instn >> 1) & 0xc0);
			return sprintf "c.fswsp %s, %s (sp)", str_freg($rs2), str_simm8($imm);
		}
		else {
			$imm = (($instn >> 7) & 0x38) + (($instn >> 1) & 0x1c0);
			return sprintf "c.sdsp %s, %s (sp)", str_ireg($rs2), str_simm9($imm);
		}
	}
	else     { return unknown();}
}
