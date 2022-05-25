#############################################################################
## This code is free software; you can redistribute it and/or
## modify it under the terms of the GNU Lesser General Public
## License as published by the Free Software Foundation; either
## version 2.1 of the License, or (at your option) any later version.
##
## This code is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## Lesser General Public License for more details.
##
## This perl script will parse data in a file, do manchester encoding
## / decoding and write the encoded / decoded data in another file.
## This file can be executed from command line. The syntax of the
## command for encoding is "perl man_encode_decode.pl E". 'E' as an
## argument in the command denotes encoding.  The syntax of the
## command for decoding is "perl man_encode_decode.pl D". 'D' as an
## argument in the command denotes decoding.
##
##  Revision  Date        Author                Comment
##  ########  ##########  ####################  ################
##  1.0       26/06/09    M. Thiagarajan        Initial revision
##
##  Future revisions tracked in Subversion at OpenCores.org
##  under the manchesterwireless project
#############################################################################
#!usr/local/bin/perl

$IP_FILE = "./data_ip.txt";
$OP_FILE = "./data_op.txt";

$OPERATION = @ARGV[0];

open ($DATA_IP, "$IP_FILE") || die ("\n***Error: Input file not found");

!(-e $OP_FILE) || unlink $OP_FILE;  #If file found, delete it  
open ($DATA_OP,">>".$OP_FILE) || die ("\n***Error: Cannot create output file. Cehck folder permissions.\n");

if ($OPERATION eq "E")  #E - Encode
{
  $DATA = <$DATA_IP>;
  chop ($DATA);
  while ($DATA ne "")
  {
    $SIZE = length ($DATA);
    while ($SIZE > 0)
    {
       $IPBIT = substr ($DATA,($SIZE-1),1);
       $DATA =~ s/.$//;
       $SIZE--;
       
       if ($IPBIT == 0)
       {$OPBIT = "10";}
       elsif ($IPBIT == 1)
       {$OPBIT = "01";}
         
       print $DATA_OP "$OPBIT";
     }  
    print $DATA_OP "\n";
    $DATA = <$DATA_IP>;
    chop ($DATA);
    #print ($DATA,"\n");
  }
}
elsif ($OPERATION eq "D")
{
  $DATA = <$DATA_IP>;
  chop ($DATA);
  while ($DATA ne "")
  {
    $SIZE = length ($DATA);
    if (($SIZE % 2) != 0)
    {
      print ("\n***Error: Improper Data width\n") && die;
    }
    else
    {     
      while ($SIZE > 0)
      {
        $IPBIT = substr ($DATA,($SIZE-2),2);
        $DATA =~ s/..$//;
        $SIZE=$SIZE-2;

        if ($IPBIT == 10)
        {$OPBIT = "0";}
        elsif ($IPBIT == 01)
        {$OPBIT = "1";}

       print $DATA_OP "$OPBIT";
       }
     }
    print $DATA_OP "\n";
    $DATA = <$DATA_IP>;
    chop ($DATA);
  }
}
else
{
  print "\n***Error: No Valid arguments in the command\n";
  print "***Valid arguments are - 'E' for Encoding; 'D' for Decoding\n\n";
  print "***Usage Example:\t\"perl man_encode_decode.pl E\"\n";
}
