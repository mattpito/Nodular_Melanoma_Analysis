#!/usr/bin/perl

use strict;
use warnings;

# Open the input file for reading
open(my $input_fh, '<', $ARGV[0]) or die "Cannot open input file: $!";

# Open a new file for writing the output
open(my $output_fh, '>', $ARGV[1]) or die "Cannot open output file: $!";

# Write the header line with the new column name
print $output_fh "CHROM\tPOS\tREF\tALT\tDP4\tMAF\n";

# Read each line of the input file and process it
while (my $line = <$input_fh>) {
    chomp $line;
    # Skip the header line
    next if $line =~ /^CHROM/;
    # Split the line into columns
    my ($chrom, $pos, $ref, $alt, $dp4) = split(/\t/, $line);
    # Split the DP4 column into its four components
    my ($a, $b, $c, $d) = split(/,/, $dp4);
    # Calculate the MAF
    my $maf = ($c + $d) / ($a + $b + $c + $d);
    # Write the new line with the MAF column
    print $output_fh "$chrom\t$pos\t$ref\t$alt\t$dp4\t$maf\n";
}

# Close the input and output files
close($input_fh);
close($output_fh);
