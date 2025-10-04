# Remember to activate the conda environment for gemelli

# Load libraries
library(reticulate)	# hook python into R
library(SQMtools)	# from SqueezeMeta

use_condaenv("gemelli_env", required = TRUE)
py_config()

# Load the counts
ta <- read.table("./gemelli_asv_no_outliers_water_rarefied.tsv", header=TRUE, sep="\t", check.names=FALSE, row.names = 1)

# Export the table
exportTable(ta, 'gemelli_asv_no_outliers_water_rarefied.tsv')

# Import the gemelli and biom to R
gemelli.rpca = import('gemelli.rpca')
biom = import('biom')

# Import the previous ta table in the biom format
data = biom$load_table('gemelli_asv_no_outliers_water_rarefied.tsv')

# Run gemelli
res = gemelli.rpca$rpca(data) # RuntimeWarning: divide by zero encountered in log | this warning can safely be ignored according to an issue in the gemelli repo
ordination = res[[1]]
distance = res[[2]]

# Check if the data needs rarefiyng
# Import gemelli
gemelli.utils = import('gemelli.utils')
# Perform RPCA on rarefied set
resrare = gemelli.rpca$rpca(data$copy()$subsample(100))
# Assign distance results to rare_distance
rare_distance = resrare[[2]]
# Perform qc
resqc = gemelli.utils$qc_rarefaction(data, rare_distance, distance)
# Show results of test to decide if rarefaction is needed
t_ = resqc[[1]] # If t < 0 and p < alpha then the data should be rarefied since the rareified distances
p_ = resqc[[2]] # correlate significantly less to the absolute sample sum differences
print(t_)
print(p_)
#stopifnot(p_ > 0.05)

# Create a vegan::rda-like object in R
ord.gemelli = list()
class(ord.gemelli) = c('rda', 'cca', 'gemelli')
ord.gemelli$method='rda'
ord.gemelli$CA = list()
ord.gemelli$CA$eig = ordination$eigvals
ord.gemelli$CA$tot.chi = sum(ord.gemelli$CA$eig)
ord.gemelli$CA$u = as.matrix(ordination$samples)
ord.gemelli$CA$v = as.matrix(ordination$features)
ord.gemelli$CA$rank = ncol(ord.gemelli$CA$u)
ord.gemelli$tot.chi = ord.gemelli$CA$tot.chi
ord.gemelli$inertia = 'variance'
ord.gemelli$regularization = 'this is a vegan::rda result object'
distmatrix.gemelli = as.dist(distance$to_data_frame())

# Add metadata to the object
metadata <- read.table("./all_metadata_filt_no_outl_water_rarefied.csv", header=TRUE, sep=",", check.names=FALSE, row.names = 1) #Load metadata
attr(ord.gemelli, "metadata") <- metadata  # Add metadata to the RDA object

# Save RDS to load in the plotting script
saveRDS(ord.gemelli, file = "ord-gemelli-asv-rare-water-rda.rds")
saveRDS(distmatrix.gemelli, file = "distmatrix-gemelli-asv-rare-water.rds")
