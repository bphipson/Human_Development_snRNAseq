addAnno <- function(gst.out, gst.id, fit, coef, t.cutoff = 1,sort=TRUE)
# Function to add significant genes information to camera GST output
# You need the camera output, the index for the gene sets created from id2indices
# and the fit object with a $genes$SYMBOL slot.
# The genes are ranked from most significant to least significant until the cut-off
# The coef is the contrast, and t.cutoff specifies the t statistic for "significant" genes
# Belinda Phipson
# 4 September 2019
{
    if(any(rownames(gst.out)!=names(gst.id))) message("rownames of gst output does not match names of gene set list")
    newresults <- data.frame(gst.out, SigGenesInSet=NA)
    for(i in 1:nrow(gst.out)){
        myout <- data.frame(t=fit$t[gst.id[[i]],coef],symbol=fit$genes$SYMBOL[gst.id[[i]]],stringsAsFactors = FALSE)
        o <- order(abs(myout$t),decreasing = TRUE)
        myout.o <- myout[o,]
        newresults$SigGenesInSet[i] <- paste(myout.o$symbol[abs(myout.o$t)>=t.cutoff],collapse=",")
    }
    if(sort){
      o <- order(newresults$PValue)
      newresults[o,]
    }
    else newresults
}
