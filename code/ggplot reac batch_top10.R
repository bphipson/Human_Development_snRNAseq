library(ggplot2)
library(grid)
library(gridExtra)
library(cowplot)
library(ggpubr)

setwd("W:/Evangelyn_Sim/Transcriptome_chromatin_human/Sequencing_ATAC_RNA/20190515_hRNAseq_MF/R/5.gsea/allgenes/")

files = list.files(path = "./USED/", pattern = ".*reactome.xls", full.names = T)
mx = lapply(files, read.delim, header=T)

for(i in 1:length(mx)){
  
  mx[[i]]$GeneSetName = gsub("REACTOME_", "", mx[[i]]$GeneSetName)
  mx[[i]]$GeneSetName = gsub("RESPIRATORY_ELECTRON_TRANSPORT_ATP_SYNTHESIS_BY_CHEMIOSMOTIC_COUPLING_AND_HEAT_PRODUCTION_BY_UNCOUPLING_PROTEINS_", 
                         "RESPIRATORY_ELECTRON_TRANSPORT_ATP_SYNTHESIS", mx[[i]]$GeneSetName)
  mx[[i]]$GeneSetName = gsub("NEF_MEDIATES_DOWN_MODULATION_OF_CELL_SURFACE_RECEPTORS_BY_RECRUITING_THEM_TO_CLATHRIN_ADAPTERS", 
                             "NEF_MEDIATES_DOWN_MODULATION_OF_CELL_SURFACE_RECEPTORS", mx[[i]]$GeneSetName)
  mxRU= mx[[i]]
  mxRU= mxRU[order(mxRU$ES, decreasing = T), ]
  mxRU= mxRU[c(1:10),]
  mxRU= mxRU[order(mxRU$ES), ]
  mxRU$colour = "#00AFBB"
  mxRU$GeneSetName = factor(mxRU$GeneSetName, levels = mxRU$GeneSetName)
  
  mxRD= mx[[i]]
  mxRD= mxRD[order(mxRD$ES), ]
  mxRD= mxRD[c(1:10),]
  mxRD$colour = "hotpink1"
  mxRD$GeneSetName = factor(mxRD$GeneSetName, levels = mxRD$GeneSetName)
  
  ES_all = rbind(mxRD, mxRU)
  
  mx[[i]] = ggplot(ES_all, aes(y=GeneSetName, x=ES))+
    geom_point(stat = 'identity', alpha=0.65, shape= 21, color="black", fill=ES_all$colour, aes(size=GeneSetSize))+
    scale_size_continuous(range = c(1,3))+
    theme_classic()+
    labs(title = gsub("./USED/edgeR_RNA_mina12a13y5y6_|.c2.cp.reactome.xls","",files[[i]]), x="Enrichment Score", y="Gene Set Name")+
    theme(plot.title = element_text(size = 3))+
    theme(axis.text = element_text(size = 3))+
    theme(axis.title = element_text(size = 5))+
    theme(legend.text = element_text(size = 2))+
    theme(legend.title = element_text(size = 2))+
    theme(legend.position = "none")
}  
  
multi = arrangeGrob(mx[[3]],mx[[5]],mx[[2]],
                    mx[[1]],mx[[4]],
                    ncol = 3, nrow = 2)
plot = as_ggplot(multi)

pdf("ggplot_Reactome_EStop10.pdf", width = 9, height = 5.25)
plot
dev.off()
