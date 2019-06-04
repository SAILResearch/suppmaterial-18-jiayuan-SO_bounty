library("foreach")
library("doSNOW")
library(ROCR)
library(rms)
library(doParallel)


bootstrapLRM<-function(boot, data, formula =NA, cpun){
  cl <- makeCluster(cpun, type="SOCK")
  registerDoParallel(cl)
  results_Metrics <- data.frame()
  results <- foreach(i=1:boot, .packages=c('AUC','caret','ROCR','rms'), .verbose = T) %dopar% {
    set.seed(i)
    print(i)
    index <- sample(nrow(data),nrow(data),replace=T)
    trainD <- data[index,]
    testD <- data
    
    fit <- lrm(formula, data = trainD, x=T, y= T,se.fit=T, tol=1e-200, penalty =  1)
    testD$predictRes <- predict(fit,testD)
    trainD$predictRes <- predict(fit,trainD)

    # auc of test data
    pr <- prediction(testD$predictRes, testD$Label)
    auc <- performance(pr, measure = "auc")
    aucV_tested <- auc@y.values[[1]]
    
    #auc of training data
    pr <- prediction(trainD$predictRes, trainD$Label)
    auc <- performance(pr, measure = "auc")
    aucV_trained <- auc@y.values[[1]]
    
    optimism <- aucV_trained - aucV_tested
    
    list(i, data.frame(auc= aucV_tested,optimism = optimism ))
  }
  stopCluster(cl)
  
  totalA <- c()
  totalO<-c()
  for(i in seq(1,boot,1)){
    totalA <- c(totalA,results[i][[1]][[2]]$auc)
    totalO<-c(totalO , abs(results[i][[1]][[2]]$optimism))
  }
  perfResult=list(auc=totalA,optimism = totalO)
  
  return (perfResult)
  
}
