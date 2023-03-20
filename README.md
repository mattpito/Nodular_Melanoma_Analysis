# Nodular_Melanoma_Analysis
Code for analysing Nodular Melanoma samples from multi-regional NGS data
## MT2_customView_2Annovar.pl
Perl script to parse information from a mutect2 vcf files (generated with Gatk 4.3.0) and create a custom .tsv file that is compatible with ANNOVAR execution for annotation and an extra column with summary stats from variant calling. e.g., Is it a PASS or filtered mutation, the DP, AF and AD values, usefull for further scrutiny.
Note: For ANNOVAR, whenever there is a deletion or instertion, it is represented as "-". For example, say there is an insertion. In mutect2 vcf file this would be shown us : 
| REF | ALT |
| ------------- | ------------- |
| G | GACTACT |

However for ANNOVAR REF would be indicated as "-" and ALT as "ACTACT". Therefore start and end positions of the variant slightly change. The code also accounts for that.
## parse.mpileup.pl
Parse information from samtools/bcftools mpileup. The format looks like:
 #CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  TUMOUR
CHROM, POS, REF, ALT, DP4 from INFO are extracted into a tabular delimited .txt file
Script takes input and output as arguments
## filter.mpileup.pl
Use the DP4 column which holds integer a,b,c,d ( where a,b are fw/rev reference reads and c,d are fw/rev alt reads) to keep values with at least 10 reads (a+b+c+d), at least 4 tumour reads ( c+d) and at least 10% MAF (c+d+/(a+b+c+d)
## add_maf_column.pl
Add an extra column to the custom mpileup called MAF, generated from DP4 values
## add_local_ploidy.pl
Use Copy Number analysis files to extract copy number per segments and assign local copy numbers to the mpileup file
