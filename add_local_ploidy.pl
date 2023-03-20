#!/usr/bin/perl

use strict;
use warnings;

# get input and output files from command line arguments
my ($file1, $file2, $output_file) = @ARGV;

# open input files for reading
open my $file1_fh, "<", $file1 or die "Cannot open file1: $!";
open my $file2_fh, "<", $file2 or die "Cannot open file2: $!";

# open output file for writing
open my $output_fh, ">", $output_file or die "Cannot open output file: $!";

# read file2 into a hash of hashes
my %file2_data;
while (my $line = <$file2_fh>) {
    chomp $line;
    my ($chromosome, $start, $end, $gene, $log2, $cn, $depth, $p_ttest, $probes, $weight) = split /\t/, $line;
    $file2_data{$chromosome}{$start}{$end} = $cn;
}

# loop through file1 and add local_copy_number column
while (my $line = <$file1_fh>) {
    chomp $line;
    my ($chrom, $pos, $ref, $alt, $dp4, $maf) = split /\t/, $line;
    my $local_copy_number = "NA";
    if (exists $file2_data{$chrom}) {
        foreach my $start (keys %{$file2_data{$chrom}}) {
            foreach my $end (keys %{$file2_data{$chrom}{$start}}) {
                if ($pos >= $start && $pos <= $end) {
                    $local_copy_number = $file2_data{$chrom}{$start}{$end};
                    last;
                }
            }
            last if $local_copy_number ne "NA";
        }
    }
    print $output_fh "$line\t$local_copy_number\n";
}

# close files
close $file1_fh;
close $file2_fh;
close $output_fh;
