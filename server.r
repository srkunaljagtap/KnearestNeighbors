

library(shiny)
library(UsingR)
library(MASS)
library(class)
shinyServer(function(input, output) {
  
  inputData<-reactive({
    
    inFile <- input$data
    
    if (is.null(inFile))
      return(NULL)
    
  file <- read.csv(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    
  })
  
  
  
  #Output Table
  output$table <- renderTable({

    inFile <- input$data
    if(input$default == T) 
    {
data(iris)
N1 <- input$obs
file<- iris[sample(nrow(iris[1:N1,])),]
    }
    else
    {
      if(is.null(input$data))  {
        return(NULL)
      } 
      file <- read.csv(inFile$datapath, header = input$header,
                       sep = input$sep, quote = input$quote)
      
      file<- file[1:input$obs,]
    }
  })
  
    
  
  
  
   # output plot of data 
    output$plot <- renderPlot({
    inFile <- input$data
    if(input$default == T) 
    {
      data(iris)
      N1 <- input$obs
      file<- iris[sample(nrow(iris[1:N1,])),]
      
      
    }
    else {
      
      if(is.null(input$data))     
        return(NULL) 
      
      file <- read.csv(inFile$datapath, header = input$header,
                       sep = input$sep, quote = input$quote)
      
      file<- file[1:input$obs,]
      
    }
    
    
    responseY <- (colnames(file)[ncol(file)])
    predictorX <- as.matrix(file[,1:(dim(file)[2]-1)])
    
    # principal components analysis using correlation matrix
    pca <- princomp(predictorX, cor=T) 
    pc.comp <- pca$scores
    x<- -1*pc.comp[,1]
    y <- -1*pc.comp[,2]
    
    plot(x, y, cex = 1, font = 3,xlab = "Explanatory Variable",ylab = "Outcome Variable")
    points(x, y, pch = 16, cex = 0.8, col = "red")
    title("Plot of Data")
    
    
  })
  

   output$KNNSummary <- renderPrint({
     
     
     inFile <- input$data
     
     if(input$default == T) 
     {
       data(iris)
       N1 <- input$obs
       file<- iris[sample(nrow(iris[1:N1,])),]
     }
     else {
       
       if(is.null(input$data))     
         return(NULL) 
       
       file <- read.csv(inFile$datapath, header = input$header,
                        sep = input$sep, quote = input$quote)
       
       file<- file[1:input$obs,]
     }
     
     
     
     responseY <- as.matrix(file[,dim(file)[2]])
     predictorX <- as.matrix(file[,1:(dim(file)[2]-1)])
     
     # principal components analysis using correlation matrix
     pca <- princomp(predictorX, cor=T)
     pc.comp <- pca$scores
     x<- -1*pc.comp[,1]
     y <- -1*pc.comp[,2]
     file1 <- cbind(x,y)
     
     N <- input$obs
     percent <- input$traindata/100
     ntrains <- floor(percent * N)
     ntest <- ntrains+1
     X.train <- file1[1:ntrains,]
     X.test <- file1[ntest:N,]
     responseY <- responseY[1:ntrains,]
     model.knn <- knn(train=X.train, test=X.test , cl=responseY, k=input$Kvalue, prob=T)  
    # summary(model.knn)
    model.knn
    
   })
  
  
  
  
  # Summary
  output$summary <-renderPrint({
    inFile <- input$data
    
    if(input$default == T) 
    {
      data(iris)
      N1 <- input$obs
      file<- iris[sample(nrow(iris[1:N1,])),]
      
    }
    else {
      
      
      if(is.null(input$data))     
        return()          
      file <- read.csv(inFile$datapath, header = input$header,
                       sep = input$sep, quote = input$quote)
      
      file<- file[1:input$obs,]
    }
    
    
    summary(file)
    
  })  
  
})
