library(MFPCA)
library(funData)
library(readxl)
library(rmatio)

ufpca <- function(input, npc) {
  n <- dim(input)[1]
  timepoints <- dim(input)[2]
  
  if (any(is.nan(input)) | sd(input)==0) {
    next
  }
  
  long_sig = matrix(0.0, n, timepoints)
  for (k in 1:timepoints){
    long_sig[, k] <- input[, k] - mean(input[, k])
  }
  
  f <- new("funData", argvals = list(1:timepoints), X = long_sig)
  pca <- PACE(f, npc = npc)
    
  return(pca)
}

mvfpca <- function(input, npc) {
  n <- dim(input)[1]
  variables <- dim(input)[2]
  timepoints <- dim(input)[3]
  
  x = c()
  f = list()
  decomposition = c()
  for (j in 1:variables){
    if (any(is.nan(input[,j,])) | sd(input[,j,])==0) {
      next
    }
    
    long_sig = matrix(0.0, n, timepoints)
    for (k in 1:timepoints){
      long_sig[, k] <- input[, j,k] - mean(input[, j, k])
    }
    
    x[[idx]] <- long_sig
    decomposition[[idx]] <- list(type = "uFPCA")
    f[[idx]] <- new("funData", argvals = list(1:timepoints), X = x[[idx]])
    idx = idx + 1
  }
  
  mfd <- multiFunData(f)
  pca[[m]] <- MFPCA(mfd, M = npc, uniExpansions = decomposition)
}