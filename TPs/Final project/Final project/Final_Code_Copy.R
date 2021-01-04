## Michael Quinto

## Final project code

## setwd("F:/School/HEG/Data-mining/TPs/Final project")

## Data preparation

### colClassesParams <- c("numeric", "factor", rep("numeric", 7), rep("factor", 15), rep("factor", 3), "factor")
### myData <- read.table("investing_program_prediction_data.csv", header=TRUE, sep=",", colClasses=colClassesParams)

### datasetName <- "investing_program_prediction_data.csv"
### discreteAttributes <- c(2,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27)
### continuousAttributes <- c(1,3,4,5,6,7,8,9)

## Exact call
### runAnalysis(datasetName, colClassesParams, discreteAttributes, continuousAttributes, 28)


## Other commands used

## Final model Decision Tree information gain
### final_dt_information<-rpart(formula=InvType~.,data=myData, parms=list(split='information'),minsplit=50, cp=0.01)
### draw_dt(final_dt_information,'information',5,0.01)

## Final model Decision Tree gini index
### final_dt_gini<-rpart(formula=InvType~.,data=myData, parms=list(split='gini'),minsplit=5, cp=0.01)
### draw_dt(final_dt_gini,'gini',5,0.01)


## Other packages used (that need to be installed before executing the exact call)

### rpart.plot


runAnalysis <- function(datasetName,colClassesParams,discreteAttributes,continuousAttributes,ClassAttributeIndex){
  
  ## Libraries
  ### rpart - Decision Trees
  library(rpart)
  ### rpart.plot
  library(rpart.plot)
  ### class - KNN
  library(class)
  ## package e1071 - Naive Bayes
  library(e1071)
  
  ## Utilities
  source('utilities/utilities.R', chdir = TRUE)
  source('utilities/knn.R', chdir = TRUE)
  
  ##Cette option permet d'afficher les valeurs réelles
  ##au lieu des notations scientifiques
  options(scipen=999)
  
  #print(colClassesParams)
  
  ## Read data
  dataset<- read.table(datasetName,header=T,sep=",", colClasses=colClassesParams)
  
  ## Normalized data
  datasetNormalized <- normalizeDataset(dataset, discreteAttributes, ClassAttributeIndex)
  
  ## Information gain & Information gain ratio
  #execute_information_gain(dataset, discreteAttributes, continuousAttributes, ClassAttributeIndex)
  
  ## Naive Bayes
  #print("Results for Naive Bayes")
  #execute_nb(dataset, ClassAttributeIndex)
  
  ## Decision Tree using information gain
  #print("Results for Decision Tree using information gain")
  #execute_dt(dataset,'information', ClassAttributeIndex)
  
  #print("")
  
  ## Decision Tree using gini index
  #print("Results for Decision Tree using gini index")
  #execute_dt(dataset,'gini', ClassAttributeIndex)
  
  #print("")
  
  ## KNN
  #print("Results for KNN")
  #execute_knn(datasetNormalized, ClassAttributeIndex)
  
  ## Default classifier
  #print("Results for Default Classifier")
  #execute_default_classifier(dataset, ClassAttributeIndex)
  
  
  ## McNemar
  execute_mcnemar(dataset, datasetNormalized, ClassAttributeIndex)
  
}


## McNemar main function
execute_mcnemar <- function(dataset, datasetNormalized, ClassAttributeIndex){
  
  print("McNemar let's go")  
  
  
  ## Validation croisée à faire pour chaque algorithme et chaque hyperparamètre
  ### à la place de du hold out --> séparation aléatoire du dataset 5 fois
  
  ### Pour faire la validation croisée, on doit séparer notre dataset en 3 part égales
  ### 3 parts car c'est écrit dans les consignes du projet final ("validation croisée 3 fois")
  
  ### chaque part devient le testData à tour de rôle
  ### les deux autres parts deviennent des trainData qui vont servir pour créer le modèle
  ### la précision sera calculé pour le testData sur le modèle
  ### on effectue ceci 3 fois (pour chaque part) pour avoir la précision moyenne
  
  ### la précision moyenne est la moyenne des précisions obtenus pour les 3 parts
  ### comme chaque part/modèle est testé 2 fois(vu qu'il y a 2 testData)
  ### on aura 6 précisions sur lesquels on devra faire la moyenne
  
  ## La validation croisée nous permettra d'obtenir les précisions pour les algorithmes
  ### ces précisions seront utilisées pour le test mcNemar dans le cas où p-value est plus petit que alpha
  ### alpha à définir
  
  
  ## Test mcnemar
  ### pour obtenir les valeurs du tableau de contingence
  ### il faut d'abord faire les validation croisées pour les deux algorithmes qu'on compare
  ### il est donc important qu'on ait les mêmes parts de données pour les deux algorithmes
  ### afin d'avoir les résultats des prédictions pour chaque part de données pour les deux algorithmes
  ### pour chaque prédiction, donc instance, on récupère la prédiction de l'algorithme A et B
  ### puis on met à jour le tableau de contingence
  
  ### ce tableau de contingence sera passé en paramètre pour le test mcnemar
  ### ce test va nous retourner une valeur p-value
  ### si cette valeur est plus petite qu'alpha, une valeur à définir (0.05 ou 0.01), ca veut dire que les algos sont significativement différents
  ### dans ce cas la, on doit regarder les précisions moyennes, faites durant la validation croisée, des deux algos
  ### on accorde 1 point pour celui qui a une précision plus élevée et 0 pour l'autre
  
  ### si p-value est plus grande qu'alpha, cela veut dire que les algos sont pareils
  ### on accorde 0.5 aux deux algos
  
  
  set.seed(7)
  
  lastColumn <- ClassAttributeIndex - 1
  
  ## Divide the dataset into 3 parts -> each part will become a testData 
  
  ## First part
  testIndex_1 <- sample(1:dim(dataset)[1],size=(1/3)*dim(dataset)[1])
  testData_1 <- dataset[testIndex_1,]
  testDataNormalized_1 <- datasetNormalized[testIndex_1,]
  
  ## Second part
  remaining_data <- dataset[-testIndex_1,]
  remaining_data_normalized <- datasetNormalized[-testIndex_1,]
  testIndex_2 <- sample(1:dim(remaining_data)[1], size=dim(remaining_data)[1]/2) ## Get half of the remaining data
  testData_2 <- remaining_data[testIndex_2,]
  testDataNormalized_2 <- remaining_data_normalized[testIndex_2,]
  
  ## Third part
  testData_3 <- remaining_data[-testIndex_2,]
  testIndex_3 <- as.numeric(rownames(testData_3))
  testDataNormalized_3 <- remaining_data_normalized[-testIndex_2,]
  
  ## TrainData for each part
  trainData_1 <- dataset[-testIndex_1,]
  trainData_2 <- dataset[-testIndex_2,]
  trainData_3 <- dataset[-testIndex_3,]
  trainDataNormalized_1 <- datasetNormalized[-testIndex_1,]
  trainDataNormalized_2 <- datasetNormalized[-testIndex_2,]
  trainDataNormalized_3 <- datasetNormalized[-testIndex_3,]
  
  
  ## Get correct / wrong predictions for Decision Tree
  dt_correct_wrong_1 <- get_correct_wrong("decisionTree", trainData_1, testData_1, ClassAttributeIndex)
  dt_correct_wrong_2 <- get_correct_wrong("decisionTree", trainData_2, testData_2, ClassAttributeIndex)
  dt_correct_wrong_3 <- get_correct_wrong("decisionTree", trainData_3, testData_3, ClassAttributeIndex)
  
  ## Get correct / wrong predictions for Naive Bayes
  nb_correct_wrong_1 <- get_correct_wrong("naive", trainData_1, testData_1, ClassAttributeIndex)
  nb_correct_wrong_2 <- get_correct_wrong("naive", trainData_2, testData_2, ClassAttributeIndex)
  nb_correct_wrong_3 <- get_correct_wrong("naive", trainData_3, testData_3, ClassAttributeIndex)
  
  ## Get correct / wrong predictions for KNN
  knn_correct_wrong_1 <- get_correct_wrong("knn", trainDataNormalized_1, testDataNormalized_1, ClassAttributeIndex)
  knn_correct_wrong_2 <- get_correct_wrong("knn", trainDataNormalized_2, testDataNormalized_2, ClassAttributeIndex)
  knn_correct_wrong_3 <- get_correct_wrong("knn", trainDataNormalized_3, testDataNormalized_3, ClassAttributeIndex)
  
  ## Get correct / wrong predictions for Default Classifier
  dc_correct_wrong_1 <- get_correct_wrong("default", trainData_1, testData_1, ClassAttributeIndex)
  dc_correct_wrong_2 <- get_correct_wrong("default", trainData_2, testData_2, ClassAttributeIndex)
  dc_correct_wrong_3 <- get_correct_wrong("default", trainData_3, testData_3, ClassAttributeIndex)
  
  
  ## Get predictions for Decision Tree
  dt_cross_validation_accuracy <- get_cross_validation_accuracy(dt_correct_wrong_1, dt_correct_wrong_2, dt_correct_wrong_3)
  
  ## Get predictions for Naive Bayes
  nb_cross_validation_accuracy <- get_cross_validation_accuracy(nb_correct_wrong_1, nb_correct_wrong_2, nb_correct_wrong_3)
  
  ## Get predictions for KNN
  knn_cross_validation_accuracy <- get_cross_validation_accuracy(knn_correct_wrong_1, knn_correct_wrong_2, knn_correct_wrong_3)
  
  ## Get predictions for Default Classifier
  dc_cross_validation_accuracy <- get_cross_validation_accuracy(dc_correct_wrong_1, dc_correct_wrong_2, dc_correct_wrong_3)
  
  
  ## Display average precisions
  print(paste("Précision moyenne pour l'algorithme Decision Tree : ", dt_cross_validation_accuracy))
  print(paste("Précision moyenne pour l'algorithme Naive Bayes : ", nb_cross_validation_accuracy))
  print(paste("Précision moyenne pour l'algorithme KNN : ", knn_cross_validation_accuracy))
  print(paste("Précision moyenne pour le Default Classifier : ", dc_cross_validation_accuracy))
  
}


## Get cross validation accuracy for algorithms
get_cross_validation_accuracy <- function(CorrectWrong_1, CorrectWrong_2, CorrectWrong_3){
  
  ## Get the Number of Correct for each part
  numCorrect_1 <- length(which(CorrectWrong_1))
  numCorrect_2 <- length(which(CorrectWrong_2))
  numCorrect_3 <- length(which(CorrectWrong_3))
  
  ## Get the accuracy, i.e. the % of correct for each part
  accuracy_1 <- numCorrect_1/length(CorrectWrong_1)
  accuracy_2 <- numCorrect_2/length(CorrectWrong_2)
  accuracy_3 <- numCorrect_3/length(CorrectWrong_3)
  
  ## Return average accuracy
  cross_validation_accuracy <- (accuracy_1 + accuracy_2 + accuracy_3) / 3
  cross_validation_accuracy
  
}

## Get correct / wrong predictions
get_correct_wrong <- function(algorithm, trainData, testData, ClassAttributeIndex){
  
  ## Train the models for each part
  model <- trainModel(algorithm, trainData, testData, ClassAttributeIndex) 
  
  if(algorithm == "decisionTree" || algorithm == "naive" || algorithm == "default"){
    
    ## Get predictions for each part
    if(algorithm == "default"){
      
      predictions <- names(which.max(table(trainData[,ClassAttributeIndex])))
      
    }else{
      
      predictions <- predict(model,testData,type="class")
      
    }
    
    ## Compare the true labels of the testing instances with the predictions
    CorrectWrong <- (predictions==testData[,ClassAttributeIndex])
    
  }else if(algorithm == "knn"){
    
    ## Knn can't be used with predict(), so we directly compare the model with the labels
    CorrectWrong <- (model == testData[,ClassAttributeIndex])
    
  }
  
  ## Return predictions
  CorrectWrong
  
}

## Train model based on algorithm
trainModel <- function(algorithm, trainData, testData, ClassAttributeIndex){
  
  ## Get formula name
  formulaName <- getFormulaName(trainData, ClassAttributeIndex)
  
  ## Initialize model
  model <- NULL
  
  ## All models are trained using the parameters with the highest accuracies
  
  if(algorithm == "decisionTree"){
    
    ## Train a Decision Tree
    model <- rpart(formula=as.formula(formulaName), 
                   data=trainData, parms=list(split="information"), 
                   minsplit=5, cp=0.01)
    
  }else if(algorithm == "naive"){
    
    ## Train a Naive Bayes
    model <- naiveBayes(formula=as.formula(formulaName),data=trainData)
    
  }else if (algorithm == "knn"){
    
    ## Train and Test Data without label
    trainDataNoLab <- trainData[,-ClassAttributeIndex]
    testDataNoLab <- testData[,-ClassAttributeIndex]
    
    ## Only Train Data label
    trainDataLab <- trainData[,ClassAttributeIndex]
    
    ## Train a KNN model
    model <- knn(trainDataNoLab, testDataNoLab, trainDataLab, 20)
    
  }
  
  ## Return model
  model
  
}


## Information gain main function
execute_information_gain <- function(dataset, discreteAttributes, continuousAttributes, ClassAttributeIndex){
  
  ## Information gain for discrete attributes
  information_gain_discrete(dataset, discreteAttributes, ClassAttributeIndex)
  
  ## Information gain for continuous attributes
  information_gain_continuous(dataset, continuousAttributes, ClassAttributeIndex)
  
}

## Information gain of discrete attributes
information_gain_discrete <- function(dataset, discreteAttributes, ClassAttributeIndex){
  
  ## For each discrete attribute
  for(i in discreteAttributes) {
    
    ## Name of discrete attribute
    print(paste("Nom de la variable : ",names(dataset)[i]))
    
    ## Entropy
    print(paste("Entropie : ",entropy(dataset[,i])))
    
    ## Normalized Entropy
    print(paste("Entropie normalisée : ", normalizedEntropy(dataset, dataset[,i])))
    
    ##Conditional Entropy
    print(paste("Entropie conditionnelle : ",conditionalEntropy(dataset[,i],dataset[,ClassAttributeIndex])))
    
    ##Information gain
    infoGain <- informationGain(dataset[,i],dataset[,ClassAttributeIndex])
    print(paste("Information gain : ",infoGain))
    
    ##Information gain ratio
    infoGainRatio <- informationGainRatio(dataset[,i],dataset[,ClassAttributeIndex])
    print(paste("Information gain ratio : ",infoGainRatio))
    
    print("")
    print("--------------------------------------------")
  }
  
}

## Information gain of continuous attributes
information_gain_continuous <- function(dataset, continuousAttributes, ClassAttributeIndex){
  
  ## For each continuous attribute
  for(j in continuousAttributes) {
    
    ## Name of continuous attribute
    varName <- names(dataset)[j]
    print(paste("Nom de la variable : ",varName))
    
    ## We get the best threshold for which the information gain is the highest
    bestThreshold <- getBestThreshold(dataset[,j],dataset[,ClassAttributeIndex])
    
    ## We compute the information gain for the best threshold
    infoGain <- informationGain(as.factor(dataset[,j] < bestThreshold), dataset[,ClassAttributeIndex])
    
    ## Information gain ratio
    infoGainRatio <- informationGainRatio(as.factor(dataset[,j] < bestThreshold), dataset[,ClassAttributeIndex])
    
    print(paste("Le meilleur seuil a été trouvé pour t = ", bestThreshold))
    print(paste("Information gain = ",infoGain))
    print(paste("Information gain ratio = ",infoGainRatio))
    
    print("")
    print("--------------------------------------------")
  }
  
}

## Entropy
entropy <- function(x) {
  
  ## First, we compute the probability of each value for the attribute x
  p <- prop.table(table(x))
  
  ## Then, we compute the products
  products <- p*log2(p)
  
  ## Finally we get the negative of the sum
  -sum(products)
  
}

## Conditional Entropy
conditionalEntropy <- function(x,y){
  
  condProbsYgivenX <- prop.table(table(x,y),1)
  
  ## We add 0.00001 to avoid null values --> will not work if null values
  res <- condProbsYgivenX * log2(condProbsYgivenX+0.00001)
  
  res <- -rowSums(res)
  
  probabilityF <- prop.table(table(x))
  
  condEntrYgivenF <- sum(res * probabilityF)
  
  condEntrYgivenF
}

## Normalized Entropy
normalizedEntropy <- function(dataset,x){
  
  ##Récupération du nombre de valeurs unique
  nbValeurs <- length(unique(x))
  
  entropy(x) / log2(nbValeurs)
  
}

## Information gain
informationGain <- function(x,y){
  
  entropy(y) - conditionalEntropy(x,y)
  
}

## Information gain ratio
informationGainRatio <- function(x,y){
  
  informationGain(x,y) / entropy(x)
  
}

## Best threshold function
getBestThreshold <- function(x,y) {
  
  ## Get all distinct values for the attribute x and sort them
  sortedUnique <- sort(unique(x))
  
  ## Number of unique values
  nbValeurs <- length(sortedUnique)
  
  bestThreshold <- 1
  bestInfoGain <- 0
  
  ## For each value
  for(i in sortedUnique){
    
    ## Compute the information gain for threshold t = i
    infoGain <- informationGain(as.factor(x < i), y)
    
    ## Keep the highest information gain
    if(infoGain > bestInfoGain){
      bestThreshold = i
      bestInfoGain = infoGain
    }
    
  }
  
  ## Return best threshold
  bestThreshold
  
}


## Default Classifier main function
execute_default_classifier <- function(dataset, ClassAttributeIndex){
  
  ## Get average accuracy for default classifier
  averageAccuracy <- getAverageAccuracy("default", dataset, ClassAttributeIndex, , , , )
  
  ## Display average accuracy
  print(paste("Average accuracy for Default Classifier: ",averageAccuracy))
  
}


## Naive Bayes main function
execute_nb <- function(dataset, ClassAttributeIndex){
  
  formulaName <- getFormulaName(dataset, ClassAttributeIndex)
  
  ## Get average accuracy for Naive Bayes
  averageAccuracy <- getAverageAccuracy("naive", dataset, ClassAttributeIndex, , , , )
  
  ## Display average accuracy
  print(paste("Average accuracy for Naive Bayes : ",averageAccuracy))
}



## KNN main function
execute_knn <- function(datasetNormalized, ClassAttributeIndex){
  
  print("")
  
  ## Nearest neighbors
  kValues <- c(1,3,5,10,20,50)
  
  ## Best accuracy found
  bestAccuracy = 0
  bestAccuracyKValue = 0
  bestAccuracyCp = 0
  
  for(k in 1:length(kValues)){
    
    ## Get average accuracy for current k value
    averageAccuracy <- getAverageAccuracy("knn",datasetNormalized,
                                          ClassAttributeIndex,,,,k)
    
    ## Display average accuracy
    print(paste("Average accuracy for k = ",kValues[k]," : ",averageAccuracy))
    
    ## Set best accuracy combination
    if(averageAccuracy > bestAccuracy){
      bestAccuracy = averageAccuracy
      bestAccuracyKValue = k
    }
    
    ## Visualizing knn for each value of k
    
    ### For this we need to choose 2 continuous attributes
    index1 = which(colnames(datasetNormalized)=="BA3") ## BA3
    index2 = which(colnames(datasetNormalized)=="BA6") ## BA6
    
    ### visualizeKNN is a function from knn.R
    visualizeKNN(datasetNormalized,index1,index2,kValues[k], 100)
    
  }
  
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
      
      ## Get average accuracy for current combination
      averageAccuracy <- getAverageAccuracy("decisionTree",dataset,
                                            ClassAttributeIndex,selection,
                                            minSplits[x],cps[y],)
      
      ## Display average accuracy
      print(paste("Average accuracy for [selection criteria=",selection,
                  ", minsplit=",minSplits[x],", cp=",cps[y],"] : ",averageAccuracy))
      
      ## Set best accuracy combination
      if(averageAccuracy > bestAccuracy){
        bestAccuracy = averageAccuracy
        bestAccuracyMinsplit = minSplits[x]
        bestAccuracyCp = cps[y]
      }
      
      ## Visualize Decision Tree for current combination
      
      ### Get formula name
      formulaName <- getFormulaName(dataset, ClassAttributeIndex)
      
      ### Train a Decision Tree for current combination using whole dataset
      model <- rpart(formula=as.formula(formulaName), 
                     data=dataset, parms=list(split=selection), 
                     minsplit=minSplits[x], cp=cps[y])
      
      ### Draw Decision Tree
      draw_dt(model,selection,minSplits[x],cps[y])
    }
  }
  
  print("")
  
  ## Display combination with highest accuracy
  print(paste("The best accuracy has been found for the hyperparameters : ",
              "Minsplit = ",bestAccuracyMinsplit,", Cp = ",bestAccuracyCp))
  print(paste("With an average accuracy of : ", bestAccuracy))
}

## Visualize Decision Tree
draw_dt <- function(model,selection,minSplit,cp){
  
  ## Code from "Plotting rpart trees with the rpart.plot package, by Stephen Milborrow"
  ## Makes plots easier to read by limiting the number of characters per line
  split.fun <- function(x, labs, digits, varlen, faclen)
  {
    # replace commas with spaces (needed for strwrap)
    labs <- gsub(",", " ", labs)
    for(i in 1:length(labs)) {
      # split labs[i] into multiple lines
      labs[i] <- paste(strwrap(labs[i], width=25), collapse="\n")
    }
    labs
  }
  
  prp(model, split.fun=split.fun, main=paste("selection criteria = ",selection,
                                             ", minsplit = ",minSplit,", cp = ",cp))
  
}


getFormulaName <- function(dataset, ClassAttributeIndex){
  
  ## Name of Class attribute
  ClassAttributeName <- names(dataset)[ClassAttributeIndex]
  
  ## Convert name to formula type
  newClassName <- paste(ClassAttributeName, "~.",sep="")
  
  ## Return new formula name
  newClassName
  
}


getAverageAccuracy <- function(algorithm,dataset,ClassAttributeIndex,selection,minSplit,cp,k){
  
  ## Test 5 times and get average accuracy
  
  ## Set seed to get same sequence of random values
  set.seed(7)
  
  ## Data columns without label
  lastColumn <- ClassAttributeIndex - 1
  
  ## Total for accuracy to get average
  totalAccuracy = 0
  
  ## Variable to use in loop
  i = 0
  while(i < 5){
    
    ## Create the training dataset
    
    ## get 2/3 of the data for training
    trainIndex <- sample(1:dim(dataset)[1],size=(2/3)*dim(dataset)[1])
    trainData <- dataset[trainIndex,]
    
    ## TrainData with labels only
    trainDataLab <- trainData[,ClassAttributeIndex]
    
    ## TrainData without the labels
    trainDataNoLab <- trainData[,1:lastColumn]
    
    
    ## Creating the testing data
    #(actually the rest of the data)
    testData <- dataset[-trainIndex,]
    ## TrainData without the labels
    testDataNoLab <- testData[,1:lastColumn]
    
    
    ## Formula name
    formulaName <- getFormulaName(dataset, ClassAttributeIndex)
    
    
    ## Create model for prediction
    model <- NULL
    accuracy = 0
    
    if(algorithm == "decisionTree"){
      
      ## Train a Decision Tree on trainData
      model <- rpart(formula=as.formula(formulaName), 
                     data=trainData, parms=list(split=selection), 
                     minsplit=minSplit, cp=cp)
      
      ## Accuracy for Decision Tree
      accuracy <- getAccuracy("decisionTree",model,,testData,ClassAttributeIndex)
      
    }else if(algorithm == "knn"){
      
      ## Train KNN
      ### knn is a function from utilities.R
      model <- knn(trainDataNoLab, testDataNoLab, trainDataLab, k)
      
      ## Accuracy for KNN
      accuracy <- getAccuracy("knn",model,,testData,ClassAttributeIndex)
      
    }else if(algorithm == "naive"){
      
      #Train a Naive Bayes
      model <- naiveBayes(formula=as.formula(formulaName),data=trainData)
      
      ## Accuracy for Naive Bayes
      accuracy <- getAccuracy("naive",model,,testData,ClassAttributeIndex)
      
    }else if(algorithm == "default"){
      
      ## Accuracy for Default Classifier
      accuracy <- getAccuracy("default",,trainData,testData,ClassAttributeIndex)
    }
    
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


getAccuracy <- function(algorithm,model,trainData,testData,ClassAttributeIndex){
  
  numCorrect = 0
  
  if(algorithm == "decisionTree" || algorithm == "naive" || algorithm == "default"){
    
    if(algorithm == "default" ){
      
      #Get the majority class which will be used to predict
      predictions <- names(which.max(table(trainData[,ClassAttributeIndex])))
      
    }else{
      
      ## For Decision Tree and Naive Bayes
      ## Get the predictions
      predictions <- predict(model,testData,type="class")
      
    }
    
    ## Compare the true labels of the testing instances with the predictions
    CorrectWrong <- (predictions==testData[,ClassAttributeIndex])
    
    ## Get the Number of Correct
    numCorrect <- length(which(CorrectWrong))
    
  }else if(algorithm == "knn"){
    
    ## Get sum of correct predictions
    ### Add 1 for each correct, else 0
    numCorrect <- sum(ifelse(as.character(model) == as.character(testData[,ClassAttributeIndex]), 1,0))
    
  }
  
  ## Get the accuracy, i.e. the % of correct
  accuracy <- numCorrect/dim(testData)[1]
  
  ## Return accuracy
  accuracy
}


normalizeDataset <- function(dataset, discreteAttributes, ClassAttributeIndex){
  
  ## Dataset class name
  className <- colnames(dataset)[ClassAttributeIndex]
  ## Dataset with label only
  datasetLabel <- dataset[,ClassAttributeIndex]
  
  ## Dataset without label
  datasetNoLabel <- dataset[,-ClassAttributeIndex]
  
  ## Dataset with discrete attributes only
  discreteDataset <- dataset[,discreteAttributes]
  
  ## Dataset with continuous attributes only
  continuousDataset <- datasetNoLabel[,-discreteAttributes]
  
  ## Convert discrete to numeric
  discreteDatasetToNumeric <- discreteToNumeric(discreteDataset)
  
  ## Adding all attributes to a new dataset which will be normalized
  ### Adding continuous attributes
  datasetToBeNormalized <- continuousDataset
  ### Adding converted discrete attributes
  datasetToBeNormalized[,colnames(discreteDataset)] <- discreteDatasetToNumeric
  
  ## Normalize new dataset --> the label is not normalized
  datasetNormalized <- normalize(datasetToBeNormalized)
  
  ## Finally, we add the label to the normalized dataset
  datasetNormalized[,className] <- datasetLabel
  
  ## Return new normalized dataset
  datasetNormalized
}


