# To suppress as much output in the notebook as possible...
#library(jsonlite,quietly = TRUE, warn.conflicts = FALSE)
library(plyr,quietly = TRUE, warn.conflicts = FALSE)
library(data.table,quietly = TRUE, warn.conflicts = FALSE)
#library(tidyr,quietly = TRUE, warn.conflicts = FALSE)
library(dplyr,quietly = TRUE, warn.conflicts = FALSE)
#library(proxy,quietly = TRUE, warn.conflicts = FALSE)
library(reshape2,quietly = TRUE, warn.conflicts = FALSE)
library(ggplot2,quietly = TRUE, warn.conflicts = FALSE)
#library(ggrepel,quietly = TRUE, warn.conflicts = FALSE) #install errors Oct 16 2022
library(IRdisplay,quietly = TRUE, warn.conflicts = FALSE)
library(scales, quietly = TRUE, warn.conflicts = FALSE)

#out_dir <- "GaLiLeODemo/" # Currently nothing exports to this folder
in_dir <- "script/data/"
data_files <- dir(in_dir, "\\.rds")
prepare <- function(corpus_name, file_source){
  data_files <- dir(file_source, "\\.rds")
  
  correct_corpus_files <- grep(corpus_name, data_files)

  return(correct_corpus_files)
  
}
# load("CorpusMetadata.rds")
# load("TextAttributes.rds")
# load("CorpusAttributes.rds")
# load("TypeAttributes.rds")