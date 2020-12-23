###########################################################################################
##Takes as input a NUMERIC data frame or matrix and converts all nominal attributes to 
##continuous, it does that using the 1 of N-1 encoding. Which means that if you have a
##nominal attribute that takes N values, this will now be replaced by N-1 attributes. Each
##of these attributes corresponds to one of the N-1 values of the original discrete attribute.
##The N-1 new attributes can take 0 or 1 as values. We put a value of 1 to the attribute
##that is associated with the value that the intance has taken. 
##    For example we have the 
##    attribute color that takes values: red, green, blue
##    and we have the following instances five instances
##          color
##    x.1   red
##    x.2   red
##    x.3   green
##    x.4   blue
##    x.5   green
## Then in the one of N-1 representation we will have two new attributes "red" "green"
## and the instances will have the following representation
##          red		green
##    x.1 =   1             0
##    x.2 =   1             0
##    x.3 =   0             1
##    x.4 =   0             0
##    x.5 =   0             1
## note how blue is encoded as the absense of both red and green. 
##
##
## ATTENTION: the code removes the discrete attributes and replaces them with new 
##            numeric ones AT THE END OF THE DATA FRAME.
##
###########################################################################################
discreteToNumeric<-function(data){
	numInstances <- dim(data)[1]
	numAttrs <- dim(data)[2]
	oneOfN <- NULL
	for(i in 1:numAttrs){
		if(is.factor(data[,i])){
			if(is.null(oneOfN)){
				oneOfN<-data.frame(model.matrix(~ data[,i])[1:numInstances,2:nlevels(data[,i])])
				names(oneOfN)<-sub('data\\[\\, i\\]',names(data)[i],colnames(model.matrix(~ data[,i]))[2:nlevels(data[,i])])
			}
			else{
				oneOfN <- data.frame(oneOfN, model.matrix(~ data[,i])[1:numInstances,2:nlevels(data[,i])] )
				names(oneOfN)[(dim(oneOfN)[2]-nlevels(data[,i])+2):dim(oneOfN)[2]] <- 
					sub('data\\[\\, i\\]',names(data)[i],(colnames(model.matrix(~ data[,i]))[2:nlevels(data[,i])]))
				
			}
		}
	}
 	factorIndeces <- unlist(lapply(data,is.factor))	
	data.frame (data[,!factorIndeces], oneOfN)
}


###########################################################################################
##Takes as input a NUMERIC data frame or matrix and normalizes it, i.e. removes from each
##line the overall mean and then divides each column by its standard deviation. The final
##result is a mutlivariate distribution with 0 mean and 1 standard deviation.
###########################################################################################
normalize <- function(data){
	#get the vector of means of the attributes
	m<-colMeans(data[,1:(dim(data)[2])])

	#get the standard deviation of each attribute
	std<-sqrt(diag(cov(data[,1:(dim(data)[2])])))

	#create a vector of ones, as many ones as instances
	ones <- rep(1,dim(data)[1])

	#To the matrix multiplication of the n x 1 matrix ones
	#with the 1 x d matrix m which contains the mean of each attribute.
	#The result is a n x d matrix where each line contains the means.
	meanPerLine<-as.matrix(ones,ncol=1)%*%as.vector(m)


	#To the matrix multiplication of the n x 1 matrix ones
	#with the 1 x d matrix m which contains the std of each attribute.
	#The result is a n x d matrix where each line contains the stds
	stdPerLine<-as.matrix(ones,ncol=1)%*%as.vector(std)

	normData <- (data[,1:(dim(data)[2])] - meanPerLine) / stdPerLine

	normData
}

############################################################
#simple function that draws on a plane the training instances
#using their first two attributes only, and colors them according
#to the class to which they belong

colorPerClass <- function(mydata, drawSymbol,drawSize){
	numAttributes <- dim(mydata)[2]
	#draw the traininng points
	numClasses <- nlevels(mydata[,numAttributes])
	for( i in 1:numClasses){
		 classI <- mydata[mydata[,numAttributes]==levels(mydata[,numAttributes])[i],]
		 points(classI[,1],classI[,2],pch=drawSymbol,col=i,cex=drawSize)
	}	
}
#############################################################


#############################################################
#The function takes as input a dataset contained in data
#selects two of its columns given by xIndex and yIndex and
#generates an artificial dataset which covers in a uniform
#manner all the points in the square [minX,maxX] x [minY,maxY].
#step determines the spacing on each axis as well as 
#the number of the finally generated points which will be step x step
#############################################################
generateArtificialTestData <- function(xIndex, yIndex, data,step=20){
	maxX <- max(data[,xIndex])
	minX <- min(data[,xIndex])
	maxY <- max(data[,yIndex])
	minY <- min(data[,yIndex])
	
	#create a regular grid of points covering the whole plane
	#in [(minX,minY),(maxX,maxY)]. 
	#the variable step determines the regularity of the 
	#grid. The grid will contain step x step training
	#points, so attention because it can be quite intensive
	xPoints<-seq(minX,maxX,(maxX-minX)/step)
	yPoints<-seq(minY,maxY,(maxY-minY)/step)
	xPoints <- rep(xPoints,length(yPoints))
	xPoints <- sort(xPoints)
	artificialTestData <- data.frame(xPoints,yPoints)
	
	names(artificialTestData) <- names(data)[c(xIndex,yIndex)]
	
	#return the generated test dat
	artificialTestData

}


############################################################
#simple function that draws on a plane the training instances
#using their first two attributes only, and colors them according
#to the class to which they belong

colorPerClass <- function(mydata, drawSymbol,drawSize){
	numAttributes <- dim(mydata)[2]
	#draw the traininng points
	numClasses <- nlevels(mydata[,numAttributes])
	for( i in 1:numClasses){
		 classI <- mydata[mydata[,numAttributes]==levels(mydata[,numAttributes])[i],]
		 points(classI[,1],classI[,2],pch=drawSymbol,col=i,cex=drawSize)
	}	
}
#############################################################


