options(timeout=1000)
library(GEOquery)
args <- commandArgs(trailingOnly = TRUE)
work_dir <- args[1]

getGEOSuppFiles("GSE114461", makeDirectory=FALSE, baseDir=work_dir)
gunzip(file.path(work_dir, "GSE114461_Bortezomib.csv.gz"))
