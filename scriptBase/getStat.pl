#!usr/bin/perl

use strict;
use warnings;

my $infile=$ARGV[0];
my $genomeSize=$ARGV[1];

open my $fh, '<', "$infile" or die "Cannot open file: $!\n";
my $invRepeatBlk=0; my $invBlkSize=0;  my $dirRepeatBlk=0; my $dirBlkSize=0;

while(<$fh>) {
    chomp ;
    my $line = $_;
    next if $line =~ /^#/;
    my @tmpLine = split '\t', $line;
    #print "$tmpLine[0]\t$tmpLine[1]\t$tmpLine[2]\t$tmpLine[3]\t$tmpLine[4]\t$tmpLine[6]\t$tmpLine[8]\t";
    if ($tmpLine[12] eq "inverted_repeat") {$invRepeatBlk++; $invBlkSize=$invBlkSize + ($tmpLine[4]-$tmpLine[3]);}
    if ($tmpLine[12] eq "direct_repeat") {$dirRepeatBlk++; $dirBlkSize=$dirBlkSize + ($tmpLine[4]-$tmpLine[3]);}
}

my $invPer=0; my $dirPer=0;

if ($invBlkSize) { $invPer=($invBlkSize*2)/$genomeSize;} else { $invPer=0}
if ($dirBlkSize) { $dirPer=($dirBlkSize*2)/$genomeSize; } else { $dirPer=0}
print "inverted_repeat\t$invRepeatBlk\t$invBlkSize\t$genomeSize\t$invPer\n";

print "direct_repeat\t$dirRepeatBlk\t$dirBlkSize\t$genomeSize\t$dirPer\n";
