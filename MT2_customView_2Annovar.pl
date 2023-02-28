#!/usr/bin/perl

use strict;
use warnings;

my $input_file = $ARGV[0];
my $output_file = $ARGV[1];

open my $in_fh, '<', $input_file or die "Could not open file $input_file: $!";
open my $out_fh, '>', $output_file or die "Could not open file $output_file: $!";

# Print header line
print $out_fh "Chromosome\tPosition\tRef\tAlt\tTumour\n";

while (my $line = <$in_fh>) {
    chomp $line;
    next if $line =~ /^#/; # skip header lines
    my ($chrom, $pos, $id, $ref, $alt, $qual, $filter, $info, $format, $sample) = split(/\t/, $line);

    my @sample_fields = split(/:/, $sample);
    my $ad = $sample_fields[1];
    my $dp = $sample_fields[3];
    my $af = $sample_fields[2];

    # set tumour value
    my $tumour;
    if ($filter eq "PASS") {
        $tumour = "comments:MT2:PASS:$ad:$dp:$af";
    } else {
        $tumour = "comments:MT2:Filtered:$ad:$dp:$af";
    }

    # print desired columns to output file
    print $out_fh "$chrom\t$pos\t$ref\t$alt\t$nm2038\n";
}

close $in_fh;
close $out_fh;
