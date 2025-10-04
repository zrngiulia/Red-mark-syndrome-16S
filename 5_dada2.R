library(dada2); library(ggplot2); library(gridExtra)

# load environment
load("dada2.RData")


#------------------------------------------------------------------------
# Construct sequence table
#------------------------------------------------------------------------
seqtab <- makeSequenceTable(mergers)

# Inspect distribution of sequence lengths
table(nchar(getSequences(seqtab)))

asvtab <- seqtab

# Write out the FASTAs from after this step in a single file, with size=abundance of each merged read
uniquesToFasta(asvtab, "asv_tab_length_filt.fasta")

#------------------------------------------------------------------------
# Remove chimeric sequences
#------------------------------------------------------------------------
asvtab.nochim <- removeBimeraDenovo(asvtab,
method="consensus",
allowOneOff=FALSE, # This parameter =T will recognize 1 mismatch sequences to a bimera to also be a bimera
minSampleFraction = 0.9,
minFoldParentOverAbundance=2,
multithread=TRUE, verbose=TRUE)

# save environment
save.image("dada2.RData")
