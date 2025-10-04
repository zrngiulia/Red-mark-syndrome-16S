library(dada2); library(ggplot2); library(gridExtra)

# load environment
load("dada2.RData")

#------------------------------------------------------------------------
# Perform taxonomic assignment using SILVA dataset
# New database silva
taxa_silva <- assignTaxonomy(asvtab.nochim, "/faststorage/home/giuz/databases/dada2_silva_v138.2/silva_nr99_v138.2_toSpecies_trainset.fa", multithread=TRUE)
#------------------------------------------------------------------------

# Save taxonomic assignments and ASV table
write.csv(taxa_silva, 'taxa.csv')
write.csv(asvtab.nochim, 'asvtab.nochim.csv')

#------------------------------------------------------------------------
# Final files-- for phyloseq object
asvtab.nochim  # ASV count table
taxa_silva     # Taxa table
summary_tab    # Track file
#------------------------------------------------------------------------

# save environment
save.image("dada2.RData")
