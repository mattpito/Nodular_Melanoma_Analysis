#!/usr/bin/perl

use strict;
use warnings;

my ($input_file, $output_file) = @ARGV;

open(my $in, "<", $input_file) or die "Can't open input file: $!";
open(my $out, ">", $output_file) or die "Can't open output file: $!";

print $out "CHROM\tPOS\tREF\tALT\tDP4\n";  # Write the header to the output file

while (my $line = <$in>) {
    chomp $line;
    if ($line =~ /^CHROM\tPOS\tREF\tALT\tDP4$/) {
        next;  # Skip the header line
    }
    my @fields = split /\t/, $line;
    my ($a, $b, $c, $d) = split /,/, $fields[4];

    if (($a + $b + $c + $d) >= 10 && ($c + $d) >= 4 && ($c + $d) / ($a + $b + $c + $d) >= 0.1) {
        print $out "$line\n";
    }
}

close($in);
close($out);
