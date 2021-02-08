ggplotColors <- function(g){
  
  d <- 360/g
  
  h <- cumsum(c(15, rep(d,g - 1)))
  
  hcl(h = h, c = 100, l = 65)
  
}
