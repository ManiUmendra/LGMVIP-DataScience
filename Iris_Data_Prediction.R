#Library for viewing the data
library(tibble)
#Library for splitting data into train and test dataset
library(caTools)
#Library for label encoding
library(superml)
#Library for creating svm model
library(e1071) 

#Loading iris dataset
data <- iris
view(data)

#Label Encoding Species columns of data
label <-LabelEncoder$new()
data$Species <- label$fit_transform(data$Species)
view(data)

#Creating testing and traing dataset
sam <- sample.split(data,SplitRatio = 0.8)
train <- subset(data,sam==T)
test <- subset(data,sam==F)

#Creating model
model <- svm(Species~.,data=data,type='C-classification',
             family='linear')
summary(model)

#Prediction over testing dataset
pre <- predict(model,test)
table<-table(Actual=test$Species,Predicted=pre)
table

#Checking accuracy of model
(sum(diag(table))*100)/sum(t)

