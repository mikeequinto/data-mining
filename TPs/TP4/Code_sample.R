## TP 4 Naive Bayes

## setwd("D:/School/HEG/Data-mining/TPs/TP4")

## colClassesParams <- c("numeric", "character", rep("numeric", 7), rep("character", 15), rep("character", 3), "character")
## myData <- read.table("investing_program_prediction_data.csv", header=TRUE, sep=",", colClasses=colClassesParams)

## Exact call for Naive Bayes
## runAnalysis("investing_program_prediction_data.csv", c("numeric", "character", rep("numeric", 7), rep("character", 15), rep("character", 3), "character"), naiveBayes, 28)

## Exact call for Default Classifier
## runAnalysis("investing_program_prediction_data.csv", c("numeric", "character", rep("numeric", 7), rep("character", 15), rep("character", 3), "character"), defaultClassifier, 28)

## Exact call for Naive Bayes final mod�le
## runAnalysis("investing_program_prediction_data.csv", c("numeric", "character", rep("numeric", 7), rep("character", 15), rep("character", 3), "character"), naiveBayes_finalModel, 28)



## Other commands used

## Create final model
### nb <- naiveBayes(as.factor(InvType)~.,data=myData)

## Prior distribution of InvType
### barplot(prop.table(nb$apriori), main="Prior distribution of the class attribute InvType")

## Conditional distribution for discrete attributes
### barplot(prop.table(t(nb$tables$IA3),2), legend=T, main="Conditional probability of IA3 given InvType P(IA3 | InvType)")
### barplot(prop.table(t(nb$tables$PE10),2), legend=T, main="Conditional probability of PE10 given InvType P(PE10 | InvType)")

## Mean of SE1 given invType = C0
### mean.SE1.C0 <- nb$tables$SE1[1,1]
## Standard deviation of SE1 given invType = C0
### sd.SE1.C0 <- nb$tables$SE1[1,2] 

## Gaussian distribution for SE1
### x.SE1.C0 <- myData[myData[,28]=="C0",1]
### y.SE1.C0 <- dnorm(x.SE1.C0, mean.SE1.C0, sd.SE1.C0)
### plot(x.SE1.C0,y.SE1.C0, xlab="SE1", ylab="probability of SE1", main="Gaussian distribution of SE1 given InvType=C0")

## Get a random instance from dataset
### myData[sample(nrow(myData), 1), ]

runAnalysis <- function(datasetName,colClassesParams, methodName, ClassAttributeIndex){
  
  ## package e1071
  library(e1071)
  
  ## Read data
  dataset<- read.table(datasetName,header=T,sep=",", colClasses=colClassesParams)
  ClassAttributeName <- names(dataset)[ClassAttributeIndex]
  
  if(as.character(substitute(methodName)) == "naiveBayes_finalModel"){
    
    ## Si on veut juste obtenir le mod�le final
    nbFinalModel <- naiveBayes(as.factor(InvType)~.,data=dataset)
    nbFinalModel
    
  }else{
    
    ## Set seed to get same sequence of random values
    set.seed(100)
    
    ## Total for number of correct / accuracy
    ## To get average
    AverageCorrect = 0
    AverageAccuracy = 0
    
    i = 0
    
    while(i < 5){
      
      #create the training dataset
      #get 2/3 of the data for training
      trainIndex <- sample(1:dim(dataset)[1], size=(2/3)*dim(dataset)[1])
      trainData <- dataset[trainIndex,]
      
      #Creating the testing data
      #(actually the rest of the data)
      testData <- dataset[-trainIndex,]
      
      print(paste("Nombre d'instances dans le testData � classer : ", dim(testData)[1]))
      
      if(as.character(substitute(methodName)) == "defaultClassifier"){
        
        #Get the majority class which will be used to predict
        predictions <- names(which.max(table(trainData[,ClassAttributeIndex])))
        
      }else{
        
        #Train a Naive Bayes
        #The parameter:
        # formula=type.~.
        #sets the target/class variable to be the type.
        #and use as predictive variables all the others
        model <- methodName(as.factor(InvType)~.,data=trainData)
        
        #get the predictions
        predictions <- predict(model,testData)
        
      }
      
      #Compare the true labels of the
      #testing instances with the predictions
      CorrectWrong <- (predictions==testData[,ClassAttributeIndex])
      #Get the Correct (i.e. TRUE above)
      #which(CorrectWrong)
      
      #Get the Number of Correct
      numCorrect <- length(which(CorrectWrong))
      print(paste("Nombre d'instances correctement class�es : ", numCorrect))
      
      #Get the accuracy, i.e. the % of correct
      accuracy <- numCorrect/dim(testData)[1]
      print(paste("Pourcentage d'instances bien class�es : ", accuracy))
      
      #Add Number of correct and accuracy
      #To get average
      AverageCorrect = AverageCorrect + numCorrect
      AverageAccuracy = AverageAccuracy + accuracy
      
      print("")
      
      i=i+1
    }
    
    print("")
    
    ## Get average number of correct / accuracy
    AverageCorrect = AverageCorrect / 5
    AverageAccuracy = AverageAccuracy / 5
    
    ## Display average number of correct / accuracy
    print(paste("Moyenne d'instances correctement class�s : ", AverageCorrect))
    print(paste("Moyenne de pr�cision pour l'algorithme", as.character(substitute(methodName)), " : ", AverageAccuracy))
    
    
  }
  
}