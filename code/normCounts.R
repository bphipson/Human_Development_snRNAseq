normCounts <-function(x, log=FALSE, prior.count=0.5)
# Function to normalise to median library size instead of counts per million
# Input is DGEList object
# Belinda Phipson
# 30 November 2015
{
    lib.size <- x$samples$lib.size*x$samples$norm.factors
    M <- median(lib.size)
    if(log){
        prior.count.scaled <- lib.size/mean(lib.size)*prior.count
        lib.size <- lib.size + 2*prior.count.scaled
        log2(t((t(x$counts)+prior.count.scaled)/lib.size*M))
    }
    else t(t(x$counts)/lib.size*M)
}

lognormCounts <- function(x, log = TRUE, prior.count = 0.5)
    # Function to log normalise a counts matrix to median library size
    # Input is counts matrix
    # Genes as rows, cells as columns
    # Belinda Phipson
    # 26 February 2020
{
    x <- as.matrix(x)
    lib.size <- colSums(x)
    M <- median(lib.size)
    if(log){
        prior.count.scaled <- lib.size/mean(lib.size)*prior.count
        lib.size <- lib.size + 2*prior.count.scaled
        log2(t((t(x)+prior.count.scaled)/lib.size*M))
    }
    else t(t(x)/lib.size*M)
}
