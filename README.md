# Red-mark-syndrome-16S

This repository contains the code used to analyse 16S rRNA gene amplicon sequencing data for the study on red mark syndrome bacteriome in rainbow trout (_Oncorhynchus mykiss_) (manuscript submitted).

The analysis was run as follows:

- Reads trimming (0_cutadapt_sbatch.sh)
- Generate reads quality profiles, filter and trim by quality (1_dada2.R; 2_dada2.R; 3_dada2.R)
- Sequences dereplication, sample inference, paired reads merging (4_dada2.R)
- ASV table construction and chimera removal, with calculation of retained reads (5_dada2.R; 6_dada2.R)
- Taxonomic assignment of ASVs (7_dada2.R)
- Analysis generating the reported results (RMD file + RPCA scripts folder)
