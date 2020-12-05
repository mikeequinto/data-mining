

### TP 1 ###

runAnalysis <- function(datasetNAme,
                        DiscreteAttributesIndeces,
                        ContinuousAttributesIndeces,
                        IndecesAttrsToRemoveIndeces,
                        ClassAttributeIndex) {
  
  ##runAnalysis("investing_program_prediction_data.csv", c(1,2,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27),c(3,4,5,6,7,8,9),26,28)
  
  ##Cette option permet d'afficher les valeurs réelles sur les graphes
    ##au lieu des notations scientifiques
  options(scipen=10000)
  
  ##Préparation du dataset
  dataset <- read.table(file=datasetNAme, header=TRUE, sep=",")
  
  ##Pour chaque attribut discret
  for(i in DiscreteAttributesIndeces) {
    
    ##Nom de la variable
    varName <- names(dataset)[i]
    
    ##Calcul de la distribution
    dist <- table(dataset[,i])
    
    ##Calcul du probability distribution
    print(paste("Distribution de la probabilité de ",varName))
    probDist <- prop.table(dist)
    print(probDist)
    
    
    ##Calcul de la distribution conditionnelle
    ##condDist <- table(dataset[,c(i,ClassAttributeIndex)])   ##P(f | target)
    ##condDist <- table(dataset[,c(ClassAttributeIndex,i)])   ##P(target | f) sans transpose
    condDist <- t(table(dataset[,c(i, ClassAttributeIndex)])) ##P(target | f) avec transpose
    
    
    ##Calcul du conditional probability
    print("")
    print(paste("Probabilité conditionnelle (InvType | ", varName, ")"))
    probDistCond <- prop.table(condDist, 2) ##le 2 permet de faire la distribution par colonne et non par ligne (1)
                                            ##Le total des pourcentages est égale à 1 par colonne
    print(probDistCond)
    
    ##Récupération du nombre de valeurs uniques de la variable
    valUnique <- length(unique(dataset[,i]))
    
    if(valUnique < 20){
      ##Visualisation du probability distribution avec un barplot avec légende
      barplot(probDist, main=paste("probability distribution of ",varName), legend=rownames(probDist))
    }else{
      ##Visualisation du probability distribution avec un barplot sans légende
      barplot(probDist, main=paste("probability distribution of ",varName))
    }
    
    ##Visualisation du conditional probablity avec un barplot
    barplot(probDistCond, main=paste("conditional probability of ",varName), legend=rownames(probDistCond))
    
    
    print("")
    print("--------------------------------------------")
  }
  
  
  ##Pour chaque attribut continu
  for(j in ContinuousAttributesIndeces) {
    
    ##Nom de la variable
    varNameContinu <- names(dataset)[j]
    
    print(paste("Attribut n° ",j," : ",varNameContinu))
    
    ##Calcul de la moyenne
    moyenne <- mean(dataset[,j])
    print(paste("moyenne ",moyenne))
    
    ##Calcul de la variance
    variance <- var(dataset[,j])
    print(paste("variance ", variance))
    
    ##Calcul de la moyenne conditionnelle
    condMean <- aggregate(dataset[,j],by=list(InvType=dataset[,ClassAttributeIndex]),FUN=mean)
    print("moyenne conditionnelle : ")
    print(condMean)
    
    ##Calcul de la variance conditionnelle
    varCond <- aggregate(dataset[,j],by=list(InvType=dataset[,ClassAttributeIndex]),FUN=var)
    print("variance conditionnelle : ")
    print(varCond)
    
    
    
    ##Calcul de la distribution
      ##distContinu <- table(dataset[,j]) Ceci ne marche que pour les variables discretes
      ##Pour les variables continues pas besoin de table
    distContinu <- dataset[,j]
    
    ##Visualisation de la distribution avec un histogramme
    hist(distContinu, main=paste("Histogramme de la distribution de ",varNameContinu), xlab=varNameContinu)
    
    ##Calcul et visualisation de la distribution conditionnelle
    conditionalDistribution(dataset, j, ClassAttributeIndex)
    
    
    print("")
    print("--------------------------------------------")
  }
  
  ##Nuage de points pour les attributs les plus utiles
  scatterPlot(dataset,1,27)
  
}

##Méthode permettant le calcul et la visualisation avec histogramme 
    ##de la distribution conditionnelle pour les attributs continus
conditionalDistribution <- function(dataset, currentAttributeIndex, ClassAttributeIndex) {
  
  ##Pour chaque valeur unique de la variable cible
  for(i in unique(dataset[,ClassAttributeIndex])){
    
    ##Nom de la variable actuelle
    varName <- names(dataset)[currentAttributeIndex]
    
    ##Récupération des instances qui ont la même valeur pour la variable cible
    dataset2 <- dataset[dataset[,ClassAttributeIndex]== i,]
    
    ##Calcul de la distribution du nouveau dataset
    distContinu <- dataset2[, currentAttributeIndex]
    
    ##Calcul de la distribution conditionnelle
    condDistContinu <- table(dataset2[,c(currentAttributeIndex, ClassAttributeIndex)])
    
    hist(distContinu, main=paste("Histogramme de la distribution conditionnelle de ",
                                 varName, " pour InvType = ",i), xlab=varName)
    
  }
  
}


##Méthode permettant de créer le nuage de points pour les 2 attributs les plus utiles
scatterPlot <- function(dataset,x,y) {
  
  ##Il faut auparavant installer les pacakages ggplot2 et hrbrthemes
  
  ##Nous avons choisi les attributs SE1 et IA3 (1,27)
  
  ggplot2::ggplot(myData, 
                  ggplot2::aes(x=myData$SE1, 
                               y=myData$IA3, 
                               color=myData$InvType))+ggplot2::geom_point(size=1)+hrbrthemes::theme_ipsum()+ ggplot2::scale_y_continuous(breaks=seq(0,9, by=1))
  
}



