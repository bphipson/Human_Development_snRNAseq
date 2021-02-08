find_modes<- function(x,adjust=1) 
  # modified from http://stackoverflow.com/questions/27418461/calculate-the-modes-in-a-multimodal-distribution-in-r
{
  dens <- density(x,adjust=adjust)
  dy <- dens$y
  modes <- NULL
  for ( i in 2:(length(dy)-1) ){
    if ( (dy[i] > dy[i-1]) & (dy[i] > dy[i+1]) ) {
      modes <- c(modes,i)
    }
  }
  if ( length(modes) == 0 ) {
    return(NA)
  }
  return(dens$x[modes])
}

find_num_modes <- function(x,adjust=1)
  # for a given set of data, returns the number of modes in the data
{
  dy <- density(x,adjust=adjust)$y
  modes <- NULL
  for ( i in 2:(length(dy)-1) ){
    if ( (dy[i] > dy[i-1]) & (dy[i] > dy[i+1]) ) {
      modes <- c(modes,i)
    }
  }
  return(length(modes))
}
