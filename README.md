# EWAS-fusion
Epigenome-wide association study FUSION

The repository contains information on FUSION analysis using epigenome data. 

## Requirements

To begin, the software [FUSION](http://gusevlab.org/projects/fusion/) is required. Other facilities to be required are

   1. Sun grid engine (sge) similar to those at MRC Epidemiology Unit Linux clusters.
   2, Weight files based on epigenetic data.

## Input

The input file contains GWAS summary statistics similar to [.sumstats](https://github.com/bulik/ldsc/wiki/Summary-Statistics-File-Format) as in [LDSC](https://github.com/bulik/ldsc) with the following columns.

   * SNP -- RS id of SNPs
   * A1  -- Effect allele (first allele)
   * A2  -- Other allele (second allele)
   * Z   -- Z-scores, taking sign with repect to A1

## Use of the programs
```
ewas-sge.sh input-file
```
These will send jobs to the Linux clusters.

## References

Gusev A, et al. (2016). Integrative approaches for large-scale transcriptome-wide association studies. Nature Genetics, 48, 245-252

Mancuso N, et al. (2017). Integrating gene expression with summary association statistics to identify susceptibility genes for 30 complex traits. American Journal of Human Genetics, 2017, 100, 473-487, http://www.cell.com/ajhg/fulltext/S0002-9297(17)30032-0. See also http://biorxiv.org/content/early/2016/09/01/072967 or http://dx.doi.org/10.1101/072967.

