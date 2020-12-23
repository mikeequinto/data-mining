## TP Decision Trees

## setwd("F:/School/HEG/Data-mining/TPs/Final project")

## colClassesParams <- c("numeric", "factor", rep("numeric", 7), rep("factor", 15), rep("factor", 3), "factor")
## myData <- read.table("investing_program_prediction_data.csv", header=TRUE, sep=",", colClasses=colClassesParams)

## datasetName <- "investing_program_prediction_data.csv"

## Exact call
### runAnalysis(datasetName, colClassesParams, 28)


## Other commands used

## Final model Decision Tree information gain
### final_dt_information<-rpart(formula=InvType~.,data=myData, parms=list(split='information'),minsplit=50, cp=0.01)
### plot(final_dt_information,compress=T,uniform=T,margin=0.2,main="selection criteria = information gain, minsplit = 50, cp = 0.01")
### text(final_dt_information,digits=3,use.n=T)

## Final model Decision Tree gini index
### final_dt_gini<-rpart(formula=InvType~.,data=myData, parms=list(split='gini'),minsplit=50, cp=0.01)
### plot(final_dt_gini,compress=T,uniform=T,margin=0.2,main="selection criteria = gini index, minsplit = 50, cp = 0.01")
### text(final_dt_gini,digits=3,use.n=T)


runAnalysis <- function(datasetName,colClassesParams, ClassAttributeIndex){
  
  ## rpart
  library(rpart)
  
  ##Cette option permet d'afficher les valeurs réelles
  ##au lieu des notations scientifiques
  options(scipen=999)
  
  ## Read data
  dataset<- read.table(datasetName,header=T,sep=",", colClasses=colClassesParams)
  
  ## Set seed to get same sequence of random values
  set.seed(100)
  
  ## Decision Tree using information gain
  print("Results for Decision Tree using information gain")
  execute_dt(dataset,'information', ClassAttributeIndex)
  
  print("")
  
  ## Decision Tree using gini index
  print("Results for Decision Tree using gini index")
  execute_dt(dataset,'gini', ClassAttributeIndex)
  
}

## Decision Tree main function
execute_dt <- function(dataset, selection, ClassAttributeIndex){
  
  print("")
  
  ## Minsplits and CPs
  minSplits <- c(5,10,50,100,200)
  cps <- c(0.001,0.01,0.1,0.2)
  
  ## Best accuracy found
  bestAccuracy = 0
  bestAccuracyMinsplit = 0
  bestAccuracyCp = 0
    
  ## Test Decision Tree for each combination
  for(x in 1:length(minSplits)){
    for(y in 1:length(cps)){
      
      averageAccuracy <- getAverageAccuracy("decisionTree",dataset,
                                            ClassAttributeIndex,selection,
                                            minSplits[x],cps[y])
      
      ## Display average accuracy
      print(paste("Average accuracy for [selection criteria=",selection,
                  ", minsplit=",minSplits[x],", cp=",cps[y],"] : ",averageAccuracy))
      
      ## Set best accuracy combination
      if(averageAccuracy > bestAccuracy){
        bestAccuracy = averageAccuracy
        bestAccuracyMinsplit = minSplits[x]
        bestAccuracyCp = cps[y]
      }
    }
  }
  
  print("")
  
  ## Display combination with highest accuracy
  print(paste("The best accuracy has been found for the hyperparameters : ",
              "Minsplit = ",bestAccuracyMinsplit,", Cp = ",bestAccuracyCp))
  print(paste("With an average accuracy of : ", bestAccuracy))
}


getAccuracy <- function(model,testData,ClassAttributeIndex){
  
  ## Get the predictions
  predictions <- predict(model,testData,type="class")
  
  ## Compare the true labels of the testing instances with the predictions
  CorrectWrong <- (predictions==testData[,ClassAttributeIndex])
  
  ## Get the Number of Correct
  numCorrect <- length(which(CorrectWrong))
  
  ## Get the accuracy, i.e. the % of correct
  accuracy <- numCorrect/dim(testData)[1]
  
  ## Return accuracy
  accuracy
}

getAverageAccuracy <- function(algorithm,dataset,ClassAttributeIndex,selection,minSplit,cp){
  
  ## Test 5 times and get average accuracy
  
  ## Name  of Class attribute
  ClassAttributeName <- names(dataset)[ClassAttributeIndex]
  
  ## Convert name to formula type
  newClassName <- paste(ClassAttributeName, "~.",sep="")
  
  ## Total for accuracy to get average
  totalAccuracy = 0
  
  ## Variable to use in loop
  i = 0
  while(i < 5){
    
    ## Create the training dataset
    ## get 2/3 of the data for training
    trainIndex <- sample(1:dim(dataset)[1],size=(2/3)*dim(dataset)[1])
    trainData <- dataset[trainIndex,]
    
    ## Creating the testing data
    #(actually the rest of the data)
    testData <- dataset[-trainIndex,]
    
    model <- NULL
    
    if(algorithm == "decisionTree"){
      ## Train a Decision Tree on trainData
      model<-rpart(formula=as.formula(newClassName), 
                   data=trainData, parms=list(split=selection), 
                   minsplit=minSplit, cp=cp)
      
      if(i == 0){
        ## Visualize the Decision Tree using a plot
        plot(model,compress=T,uniform=T,margin=0.2,
             main=paste("selection criteria = ",selection,
                        ", minsplit = ",minSplit,", cp = ",cp))
        text(model,digits=3,use.n=T)
      }
    }
    
    ## Get accuracy
    accuracy <- getAccuracy(model,testData,ClassAttributeIndex)
    
    ## Add accuracy to total
    totalAccuracy = totalAccuracy + accuracy
    
    ## Increment variable i
    i=i+1
  }
  
  ## Get average accuracy
  averageAccuracy = totalAccuracy / 5
  
  ## Return average accuracy
  averageAccuracy
}


