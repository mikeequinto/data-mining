##TP 2

runAnalysis <- function(dataset){
  
  for(i in c(1,2,3)){

    ##Entropy de sex
    entropy(dataset,i)
    
  }
  
}

entropy <- function(dataset, attrIndex){
  
  prob <- prop.table(table(dataset[,attrIndex]))
  entropy <- -sum(prob*log2(prob))
  
  print(paste("entropy of ", names(dataset)[attrIndex], ": ", entropy))
}