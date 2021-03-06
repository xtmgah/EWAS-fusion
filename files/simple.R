# 30-1-2018 MRC-Epid JHZ

setwd("/genetics/data/twas/25-1-18")

load("data/Archive/residuals")
p1 <- mergedOut
load("data/new/residuals")
p2 <- mergedOut
colnames(p1)!=colnames(p2)
p <- rbind(p1,p2)
p[is.na(p)] <- -999
tp <- t(p)
q <- as.data.frame(tp)
options(stringsAsFactors = FALSE)
pheno <- data.frame(FID=rownames(q), IID=rownames(q), q)
Ind <- read.table("Inds.dat",col.names="Ind",as.is=TRUE)
s <- subset(pheno,FID%in%with(Ind,Ind))

require(data.table)
fwrite(s,file="FUSION.pheno",col.names=TRUE,row.names=FALSE,quote = FALSE,sep="\t")

# very slow by default
# write.table(s, file="FUSION.pheno",quote=FALSE,row.names=FALSE, sep="\t")

