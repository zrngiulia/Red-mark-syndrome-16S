library(dada2); library(ggplot2); library(gridExtra)

#------------------------------------------------------------------------
#Filter and trim
#------------------------------------------------------------------------

# load environment
load("dada2.RData")

# Define directory to put filtered reads
filtFs <- file.path("../04.filtered", basename(cutFs))
filtRs <- file.path("../04.filtered", basename(cutRs))

# Perform filter and trim
# Set truncLen based on quality profile 
# Primer trimming can be done here too by adding trimLeft command e.g. trimLeft=c(19,20), but better done with cutadapt

trimmed_out <- filterAndTrim(cutFs, filtFs, cutRs, filtRs, truncLen=c(160, 160),
                     maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                     compress=TRUE, multithread=TRUE)

## view new quality profiles after trimming
forward.trimmed.Qplot <- plotQualityProfile(filtFs, aggregate = TRUE)
reverse.trimmed.Qplot <- plotQualityProfile(filtRs, aggregate = TRUE)

trimmed.Qplot <- grid.arrange(forward.trimmed.Qplot, reverse.trimmed.Qplot, nrow = 1)

ggsave("plot_qscores_trimmed.pdf", device= "pdf", trimmed.Qplot, width = 7, height = 3)

save.image("dada2.RData")
