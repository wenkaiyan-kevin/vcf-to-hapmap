# Convert VCF to Hapmap

## Directions
- First step

Use the GATK tool, [VariantsToTable](https://software.broadinstitute.org/gatk/documentation/tooldocs/current/org_broadinstitute_hellbender_tools_walkers_variantutils_VariantsToTable.php), to first select only genotype information from the vcf file.
```
gatk VariantsToTable \
-V 0000.vcf \
-R Genome.fa \
-F CHROM -F POS -F REF -F ALT -GF GT \
-O output.table   
```
Note: you need to specify `INPUT_VCF`, and `OUTPUT.table`.

Then use the R script called from the command line to convert the variant table to hapmap. 
Note: this is only tested for haploid, biallelic SNP data.

- Second step

```
 	Rscript convert-vcf-to-hapmap.R -i output.table -o vcf_converted_to_hapmap.txt
```
`output.table` is the output table from the VariantsToTable tool, and `vcf_converted_to_hapmap.txt` is the output file name.

