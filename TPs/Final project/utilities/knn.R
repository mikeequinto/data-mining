library(class)

source("utilities.R")

#################################################################################
#This function visualizes the decision surface produced by the kNN algorithm. 
#Since our visualization capabilities are limited to two or three dimensiosns
#it only keeps two attributes from the original dataset. It then produces an
#artificial dataset which it classifies using a "model" build on the original data.
#
#This function creates a number of plots visualizing the decision surface.
#It receives as input:
# data: the training dataset
# xIndex: which attribute should we use as our x dimension in the visualization
# yIndex: which attribute should we use as our y dimension in the visualization
# k: the number of nearest neighbors that we will use
# step: a parameter that controls how many artificial instances we will creat
#
#################################################################################
visualizeKNN<-function(data,xIndex,yIndex,k=3,step=50){


	#select only two attributes to use for learning,
	#so that the results can be easily visualized 
	trainData<-data.frame(data[,xIndex],data[,yIndex],data[,dim(data)[2]])

	#assign the correct names of the attributs also to the trainData data frame
	names(trainData)<-names(data)[c(xIndex,yIndex,dim(data)[2])]


	#Plot the training data. The first call to plot simply creates an empty graph
	#with the correct dimensions.
	title <- "Training Set"
	plot(trainData[,1:2],main=title,xlab=names(trainData)[1],t="n",ylab=names(trainData)[2])
	#it is this call that actually plots the training data with the color of the classes.
	colorPerClass(trainData,21,1.5)
	dev.copy2pdf(file="TrainingSet.pdf")



	#the variable step determines how densely we will sample the x and y coordinate
	#and how many points the testData will contain: step x step
	#The larger its value the more slow will the classification of the train points
	#but the better looking the final figures will be.
	testData <- generateArtificialTestData(xIndex,yIndex,data,step)


	#plot the artificially generated test set
	title <- paste(" Nearest Neighbors: Artificially Generated Testing Data, step:", step, sep=" ")
	plot(testData,main=title,xlab=names(trainData)[1],ylab=names(trainData)[2])
	#and store the plot in the file given by filename
	filename <- paste("step",step,"artGeneratedTestSet.pdf",sep="-")
	dev.copy2pdf(file=filename)


	#train on trainData and test on testData. Store the predictions in the predictions variable
	predictions<-knn(trainData[,1:(dim(trainData)[2]-1)],testData,trainData[,dim(trainData)[2]],k)

	#add to the test matrix the predictions.
	results <- cbind(testData,predictions)


	#Create the testing data plot without plotting the actual instances, just to get the correct title on the graph 
	title <- paste(k," NN: Artif. Gen. Testing Data Classifications, step:", step, sep=" ")
	plot(testData,main=title,xlab=names(trainData)[1],t="n",ylab=names(trainData)[2])

	#and now visualize the classification of the artificially generated testing points
	#CAREFUL: colorPerClass requires that a plot has already been created, and 
	#         goes and draws over it. 
	colorPerClass(results,19,1)

	#and store the plot in the file given by filename
	filename <- paste("step",step,"artGeneratedTestSet-Classifications-k-is",k,sep="-")
	filename <- paste(filename,".pdf",sep="")
	dev.copy2pdf(file=filename)

	#finally overly also the training data in the same figure.
	colorPerClass(trainData,21,1.5)
	filename <- paste("step",step,"artGeneratedTestSet-WithTrainInstances-Classifications-k-is",k,sep="-")
	filename <- paste(filename,"pdf",sep=".")
	dev.copy2pdf(file=filename)
}
