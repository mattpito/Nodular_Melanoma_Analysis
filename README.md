# Nodular_Melanoma_Analysis
Code for analysing Nodular Melanoma samples from multi-regional NGS data
## MT2_customView_2Annovar.pl
Perl script to parse information from a mutect2 vcf files (generated with Gatk 4.3.0) and create a custom .tsv file that is compatible with ANNOVAR execution for annotation and an extra column with summary stats from variant calling. e.g., Is it a PASS or filtered mutation, the DP, AF and AD values, usefull for further scrutiny
