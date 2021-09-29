require(tibble) #Library for viewing the data
require(caTools) #Library for splitting data into train and test dataset
require(rpart) #Library for creating Decision Tree Model
require(rpart.plot) #Library for plotting decision tree

#Loading iris dataset
data <- read.csv('C:/Users/umendra/Downloads/Iris.csv')
view(data)
data$Id <- NULL
view(data)

#Split Data into Train and Testing dataset
sam <- sample.split(data,SplitRatio = 0.8)
train <- subset(data,sam==T)
test <- subset(data,sam==F)

#Creating model
model <- rpart(Species~.,data=train,method='class')
summary(model)

#Plotting Decision Tree Model
rpart.plot(model,cex=0.8)

#Prediction
pre <- predict(model,test,type='class')
table(Actual=test$Species,Predicted=pre)

#Checking for another various values
var <- data.frame(SepalLengthCm=0,SepalWidthCm=0,PetalLengthCm=0,
                  PetalWidthCm=0,Species="Ver")
view(var)
#Run below three lines for getting predictaion of your data
var<-edit(var)
var$Species <- predict(model,var,type='class')
var$Species
#view(var)
