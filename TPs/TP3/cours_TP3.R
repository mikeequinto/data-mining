## On prend 10 indices aléatoires dans le dataset myDataIris
## dim(myDataIris)[1], c'est égale au nombre d'instances = 150
## 1 : dim(myDataIris)[1], on va prendre les données qui ont un indice entre 1 et 150
trainingIndeces <- sample(1:dim(myDataIris)[1], 10)

## On prend la moitié des instances
## 0.5 * dim(myDataIris)[1] = 75
trainingIndeces <- sample(1 : dim(myDataIris)[1], 0.5 * dim(myDataIris)[1])

## On peut vérifier en regardant le length de trainingIndeces
length(trainingIndeces)

## trainingData contient donc les instances dont les indices sont dans trainingIndeces
trainingData <- myDataIris[trainingIndeces, ]

## Permet de créer l'arbre de décision
## ~ indique qu'il faut prendre toutes les variables
rpart(formula=type.~., trainingData)

## Dans l'exemple ci-dessous, on prend que les variables sepal_width et petal_length
rpart(formula=type.~sepal_width+petal_length, trainingData)

## Voici le output de la commande rpart, avec ~(toutes les variables)
#> rpart(formula=type.~., trainingData)
#n= 75 

#node), split, n, loss, yval, (yprob)
#* denotes terminal node

#1) root 75 46 Iris_versicolor (0.2933333 0.3866667 0.3200000)  ## distribution de setosa versicolor et virginica
#  2) petal_length< 2.35 22  0 Iris_setosa (1.0000000 0.0000000 0.0000000) * ##0 erreurs, tout le monde fait partie de setosa
#  3) petal_length>=2.35 53 24 Iris_versicolor (0.0000000 0.5471698 0.4528302)  ##53 instances qui ont un petal length >= 2.35, 24 qui ne sont pas versicolor
#    6) petal_length< 4.75 26  0 Iris_versicolor (0.0000000 1.0000000 0.0000000) * ##26 instances ayant length < 4.75, 0 ne sont pas versicolor
#    7) petal_length>=4.75 27  3 Iris_virginica (0.0000000 0.1111111 0.8888889) * ##pareil

##Pour avoir une représentation visuelle de l'output
#> dt <- rpart(formula=type.~., trainingData)
#> plot(dt, compress=T, uniform=T, margin=0.2)
#> text(dt, digits=3, use.n=T)

## Permet de controller la suite de nombre aléatoires générée
#> set.seed(1)
#> sample(1:100, 10)
#[1] 68 39  1 34 87 43 14 82 59 51
#> set.seed(1)
#> sample(1:100, 10)

##On refait la même chose, mais cette fois-ci on appelle sample sans le set.seed
#> set.seed(2)
#> sample(1:100, 10)
#[1] 85 79 70  6 32  8 17 93 81 76
#> sample(1:100, 10)
#[1] 41 50 75 65  3 80 99 55 63  8
#[1] 68 39  1 34 87 43 14 82 59 51



## voici un tableau qui montre les instances bien classés et non
#> table(predictedResults, trueLabelsTestData)
#trueLabelsTestData
#predictedResults  Iris_setosa Iris_versicolor Iris_virginica
#Iris_setosa              28               0              0  ## 0 erreurs
#Iris_versicolor           0              18              1  ## 1 erreur
#Iris_virginica            0               3             25  ## 1 erreur


