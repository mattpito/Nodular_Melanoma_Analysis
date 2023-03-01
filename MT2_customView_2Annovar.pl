my $input_file = $ARGV[0];
my $output_file = $ARGV[1];

open my $in_fh, '<', $input_file or die "Could not open file $input_file: $!";
open my $out_fh, '>', $output_file or die "Could not open file $output_file: $!";

# Print header line
print $out_fh "Chromosome\tStart\tEnd\tRef\tAlt\tNM84_2038\n";

while (my $line = <$in_fh>) {
    chomp $line;
    next if $line =~ /^#/; # skip header lines
    my ($chrom, $pos, $id, $ref, $alt, $qual, $filter, $info, $format, $sample) = split(/\t/, $line);

    # Determine start and end positions
    my ($start, $end);
    if (length($ref) == 1 && length($alt) == 1) {
        $start = $pos;
        $end = $pos;
    } elsif (length($ref) == 1 && length($alt) > 1) {
        $ref = "-";
        $alt = substr($alt,1);
        $start = $pos;
        $end = $pos;
    } elsif (length($ref) > 1 && length($alt) == 1) {
        $start = $pos + 1;
        $end = $pos + length($ref) - 1;
        $alt = "-";
        $ref = substr($ref,1);
    } elsif (length($ref) > 1 && length($alt) > 1) {
        $start = $pos;
        $end = $pos + length($ref) - 1;
    }

    my @sample_fields = split(/:/, $sample);
    my $ad = $sample_fields[1];
    my $dp = $sample_fields[3];
    my $af = $sample_fields[2];

    # set NM2038 value
    my $nm2038;
    if ($filter eq "PASS") {
        $nm2038 = "comments:MT2:PASS:$ad:$dp:$af";
    } else {
        $nm2038 = "comments:MT2:Filtered:$ad:$dp:$af";
    }

    # print desired columns to output file
    print $out_fh "$chrom\t$start\t$end\t$ref\t$alt\t$nm2038\n";
}

close $in_fh;
close $out_fh;
