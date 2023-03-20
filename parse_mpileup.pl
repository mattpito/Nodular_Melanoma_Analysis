#!/usr/bin/perl
use strict;
use warnings;

# open the input and output files
open my $fh_in, '<', 'input.txt' or die "Cannot open input.txt: $!\n";
open my $fh_out, '>', 'output.txt' or die "Cannot open output.txt: $!\n";

# write the header of the output file
print $fh_out "CHROM\tPOS\tREF\tALT\tDP4\n";

# read the input file line by line
while (my $line = <$fh_in>) {
    # skip the header line
    next if $line =~ /^#/;
    # split the line into fields
    my @fields = split /\t/, $line;
    # extract the desired fields. Up to you, depending on your file format
    my ($chrom, $pos, $ref, $alt, $info) = @fields[0, 1, 3, 4, 7];
    my ($dp4) = $info =~ /DP4=([\d,]+)/;
    # write the output line
    print $fh_out "$chrom\t$pos\t$ref\t$alt\t$dp4\n";
}

# close the input and output files
close $fh_in;
close $fh_out;
