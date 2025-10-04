library(dada2); library(ggplot2); library(gridExtra)

# define path to trimmed reads
path.cut <- "../03.CutAdapt/"

# defined primer removed forward and reverse fastq filenames format, check format:
cutFs <- sort(list.files(path.cut, pattern="1_trimmed.fastq.gz", full.names = TRUE))
cutRs <- sort(list.files(path.cut, pattern = "2_trimmed.fastq.gz", full.names = TRUE))

# Extract sample names, assuming filenames have the format:
get.sample.name <- function(fname) strsplit(basename(fname), ".raw_")[[1]][1]
sample.names <- unname(sapply(cutFs, get.sample.name))

#------------------------------------------------------------------------
# Inspect read quality profiles
#------------------------------------------------------------------------
p1 <- plotQualityProfile(cutFs, aggregate = TRUE)
p2 <- plotQualityProfile(cutRs, aggregate = TRUE) 
p3 <- grid.arrange(p1, p2, nrow = 1)

ggsave("plot_qscores_cutadapt.pdf", device= "pdf", p3, width = 7, height = 3)

save.image("dada2.RData")
