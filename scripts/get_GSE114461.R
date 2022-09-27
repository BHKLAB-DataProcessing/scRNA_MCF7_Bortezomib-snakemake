library(SummarizedExperiment)
library(data.table)

args <- commandArgs(trailingOnly = TRUE)
work_dir <- args[1]
filename <- args[2]

data <- read.table(file.path(work_dir, "GSE114461_Bortezomib.csv"), sep=",")
time0_col <- grep("t0",colnames(data),value = TRUE)
time1_col <- grep("t12",colnames(data),value = TRUE)
time2_col <- grep("t48",colnames(data),value = TRUE)
time3_col <- grep("t96",colnames(data),value = TRUE)
time0_data <- data[,time0_col]
time1_data <- data[,time1_col]
time2_data <- data[,time2_col]
time3_data <- data[,time3_col]
item_assay <- time0_data
colData <- DataFrame(rep("Gene", each=ncol(item_assay)),row.names = colnames(item_assay))
rowData <- DataFrame(rep("Cell",each=nrow(item_assay)),row.names = rownames(item_assay))
experiment <- SummarizedExperiment(assays = item_assay,rowData = rowData,colData = colData)

experiment_list <- list(experiment)
data_list <- list(time1_data,time2_data,time3_data)
for (i in data_list) {
  item_assay <- i
  colData <- DataFrame(rep("Gene", each=ncol(i)),row.names = colnames(item_assay))
  rowData <- DataFrame(rep("Cell",each=nrow(i)),row.names = rownames(item_assay))
  experiment <- SummarizedExperiment(assays = item_assay,rowData = rowData,colData = colData)
  experiment_list <- append(experiment_list,experiment)
  }
names(experiment_list) <- c("t0","t12","t48","t96")

saveRDS(experiment_list, file.path(work_dir, filename))