getTransformedProps <- function(clusters = clusters, sample = sample)
{
  tab <- table(sample,clusters)
  props <- tab/rowSums(tab)
  prop.trans <- asin(sqrt(props))
  list(TransformedProps=t(prop.trans),Proportions=t(props))
}
