library(calibrate)

summary_plot <- function(species) {
    xlabels = paste(tsv[tsv$Species==species,]$Gene.Symbol,
                tsv[tsv$Species==species,]$Service, sep='\n')
    
    if (species == "humans") {
        species_name <- "Homo sapiens"
    } else if (species == "mice") {
        species_name <- "Mus musculus"
    } else if (species == "drosophila+melanogaster") {
        species_name <- "Drosophila melanogaster"
    } else if (species == "danio+rerio") {
        species_name <- "Danio rerio"
    }
    
    name <- paste(species, "_tpr.png", sep="")
    title <- paste("True Positive Rate:", species_name, sep=" ")
    png(filename = name, width=650, height=400, units="px", pointsize=10, bg="white")
    barplot(tsv[tsv$Species==species,]$True.Positive.Rate, ylim=c(0,1), names.arg=xlabels,
              col=colors, main=title, space=0.4)
    dev.off()
    
    name <- paste(species, "_fdr.png", sep="")
    title <- paste("False Discovery Rate:", species_name, sep=" ")
    png(filename = name, width=650, height=400, units="px", pointsize=10, bg="white")
    barplot(tsv[tsv$Species==species,]$False.Discovery.Rate, ylim=c(0,1), names.arg=xlabels,
              col=colors, main=title, space=0.4)
    dev.off()
}

tsv <- read.delim("opacmo_pubmed2ensembl56.tsv", header=T, stringsAsFactors=F)

# Some renaming to adjust for the actual gene symbol that was queried:
x <- tsv[tsv$Species=='drosophila+melanogaster' & tsv$Gene.Symbol=='Myc',]
x$Gene.Symbol <- 'dm'
tsv[tsv$Species=='drosophila+melanogaster' & tsv$Gene.Symbol=='Myc',] <- x
x <- tsv[tsv$Species=='drosophila+melanogaster' & tsv$Gene.Symbol=='DCC',]
x$Gene.Symbol <- 'fra'
tsv[tsv$Species=='drosophila+melanogaster' & tsv$Gene.Symbol=='DCC',] <- x
x <- tsv[tsv$Species=='danio+rerio' & tsv$Gene.Symbol=='Myc',]
x$Gene.Symbol <- 'myca'
tsv[tsv$Species=='danio+rerio' & tsv$Gene.Symbol=='Myc',] <- x

colors = c('#5588bb', '#88aa33')

summary_plot('humans')
summary_plot('mice')
summary_plot('drosophila+melanogaster')
summary_plot('danio+rerio')
