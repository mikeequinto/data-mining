## TP 4 Naive Bayes

## setwd("C:/HEG/Data-mining/TPs/TP4")
## myData <- read.table("investing_program_prediction_data.csv", header=TRUE, sep=",")

runAnalysis <- function(datasetName,
                        methodName
                        ##DiscreteAttributesIndeces,
                        ##ContinuousAttributesIndeces,
                        ##IndecesAttrsToRemoveIndeces,
                        ##ClassAttributeIndex
                        ){
  
  ## package e1071
  library(e1071)
  
  ## Read data
  dataset<- read.table(datasetName,header=T,sep=",", colClasses=c("numeric", "character", rep("numeric", 7), rep("character", 15), rep("character", 3), "character"))
  
  #create the training dataset
  #get 50% of the data for training
  trainIndex <- sample(1:dim(dataset)[1],size=(2/3)*dim(dataset)[1])
  trainData <- dataset[trainIndex,]
  
  #Train a Naive Bayes on myData.
  #The parameter:
  # formula=type.~.
  #sets the target/class variable to be the type.
  #and use as predictive variables all the others
  nb<-naiveBayes(as.factor(InvType)~.,data=trainData)
  nb
  
  
  #Creating the testing data
  #(actually the rest of the data)
  testData <- dataset[-trainIndex,]
  ##testData
  
  #to make it even more realistic
  #hide the labels
  testDataNoLab <- testData[,1:27]
  #testDataNoLab
  #get the predictions
  predictions <- predict(nb,testDataNoLab)
  #predictions
  
  #Compare the true labels of the
  #testing instances with the predictions
  CorrectWrong <- (predictions==testData[,28])
  #Get the Correct (i.e. TRUE above)
  which(CorrectWrong)
  #Get the Number of Correct
  numCorrect <- length(which(CorrectWrong))
  print(paste("Nombre d'instances correctement classées : ", numCorrect))
  #Get the accuracy, i.e. the % of correct
  accuracy <- numCorrect/dim(testData)[1]
  print(paste("Pourcentage d'instances bien classées : ", accuracy))
  
  
  
}