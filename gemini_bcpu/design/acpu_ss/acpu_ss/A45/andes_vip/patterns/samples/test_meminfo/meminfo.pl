#!/bin/env perl
$FILE_INPUT = $ARGV[0];
$KEY_ENABLE = "ENABLE";
$KEY_YES    = "yes";

# parser file to a structure
my %data;
open(FH,'<', $FILE_INPUT) or die $!;
while($line = <FH>){
	### print $line;

	# remove space and newline
	chomp $line;
	$line = $line =~ s/ //gr;

	#parser each line content
	@arr  = split(/[:\.=]/, $line);
	$name  = $arr[-4].".".$arr[-3];
	$attr  = $arr[-2];
	$value = $arr[-1];
	### print $name." ".$attr." ".$value."\n";

	$data{$name}{$attr} = $value;
}
close(FH);

# according to output format, insert data to report
my %report;
foreach my $instance (sort keys %data){
	if ($data{$instance}{$KEY_ENABLE} ne $KEY_YES) {
		next;
	}

	$dimension = "";
	foreach my $attr (sort keys %{$data{$instance}}){
		if($attr eq $KEY_ENABLE) {
			next;
		}
		$dimension = $dimension.$attr." = ".$data{$instance}{$attr}.", ";
	}
	$dimension = substr $dimension, 0, -2; # remove the last ", "
	### print $instance." ->\t ".$dimension."\n";
	
	push(@{$report{$dimension}},$instance);
}

# output the report
$index = 0;
foreach my $dimension (sort keys %report){
	print "============================================================\n";
	print " Mem macro ".$index."\n";
	print "============================================================\n";
	print "Dimension:\n";
	print "\t".$dimension."\n";
	print "Instance:\n";
	foreach my $instance (@{$report{$dimension}}){
		print "\t$instance\n";  
	}
	$index = $index + 1;
	print "\n";  
}  

exit(0);

