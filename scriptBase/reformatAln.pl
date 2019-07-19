#!usr/bin/perl

use strict;
use warnings;

my $infile=$ARGV[0];
my $mode=$ARGV[1];

open my $fh, '<', "$infile" or die "Cannot open file: $!\n";

while(<$fh>) {
    chomp ;
    my $line = $_;
    next if $line =~ /^#/;
    next if eof;
    #if ( -z 'all.combined' ) { print "File is empty!\n"; exit;}
    my @tmpLine = split '\t', $line;
    #print "$line\t";
    #print "$tmpLine[0]\t$tmpLine[1]\t$tmpLine[2]\t$tmpLine[3]\t$tmpLine[4]\t$tmpLine[6]\t$tmpLine[8]\t";
    my $nextLine = <$fh>; chomp $nextLine;
    my @nLine = split '\t', $nextLine;
    my $orientation="NA";
    if ($nLine[6] eq $tmpLine[6]) { $orientation="direct_repeat"; } else { $orientation="inverted_repeat"; }

    if (($nLine[8] == $tmpLine[8]) && ($mode eq "inverted")) { next if $orientation eq "direct_repeat";
        print "$tmpLine[0]\t$tmpLine[1]\t$tmpLine[2]\t$tmpLine[3]\t$tmpLine[4]\t$tmpLine[6]\t$tmpLine[8]\t$nLine[0]\t$nLine[3]\t$nLine[4]\t$nLine[6]\t$nLine[8]\t$orientation\n";}
    elsif (($nLine[8] == $tmpLine[8]) && ($mode eq "direct")) { next if $orientation eq "inverted_repeat";
         print "$tmpLine[0]\t$tmpLine[1]\t$tmpLine[2]\t$tmpLine[3]\t$tmpLine[4]\t$tmpLine[6]\t$tmpLine[8]\t$nLine[0]\t$nLine[3]\t$nLine[4]\t$nLine[6]\t$nLine[8]\t$orientation\n";}
    else { print "$tmpLine[0]\t$tmpLine[1]\t$tmpLine[2]\t$tmpLine[3]\t$tmpLine[4]\t$tmpLine[6]\t$tmpLine[8]\t$nLine[0]\t$nLine[3]\t$nLine[4]\t$nLine[6]\t$nLine[8]\t$orientation\n";}
}
