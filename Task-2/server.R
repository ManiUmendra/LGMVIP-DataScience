
#Importing Library
library(shiny)
library(shinydashboard)
library(ggplot2)
library(patchwork)
library(tidyverse)
library(dplyr)


#Extracting Dataset From My Folder
dta <- read.csv('C:/Users/umendra/OneDrive/Documents/DataSet/globalterrorismdb_0718dist.csv')
data <- read.csv('C:/Users/umendra/OneDrive/Documents/DataSet/globalterrorismdb_0718dist.csv')

#Cleaning of Data
#i.e removing the unwanted columns and rows
data <- data[,c(2,3,4,9,11,13,14,15,30,36,38,40,42,59,83,98,99)]
colnames(data) <- c('Year','Month','Day','Country','Region','City','Latitude','Longitude','AttackType','TargetType','TargetSubtype','Target','Penalty','Group','WeapType','WeapDetail','TotalKill')
rows <- which(!complete.cases(data))
data <- data[-rows,]


b1 <- as.data.frame(table(data$Year)) # Data of Attack in each Year

#Arranging Data of attack according to each 205 countries
country <- as.data.frame(table(data$Country))
country <- country %>% arrange(c(Freq))
country <- country[(nrow(country)-20):nrow(country),]

#Arranging Data of Attack according to given 12 regions
region <- as.data.frame(table(data$Region))

#Data of type of weapon used by Terrorist
weap <- as.data.frame(table(data$WeapType))
levels(weap$Var1)[12]<-'Vehicle'
#Extracting Data of terrorist groups
terGrp <- as.data.frame(table(data$Group))
terGrp <- arrange(terGrp,Freq)
terGrp <- terGrp[(nrow(terGrp)-10):nrow(terGrp),]

#Data Extraction of which weapon used in which region mostly
mat <- as.matrix(table(Weap=data$WeapType,Reg=data$Region))
v <- c()
reg <- c()
exp <- c()

for(i in 1:nrow(mat)){
   ind <- which(max(mat[i,])==mat[i,])
   v[i] <- mat[i,ind]
   reg[i] <- colnames(mat)[ind]
   exp[i] <- rownames(mat)[i]}
wepReg <- data.frame(v,reg,exp)
wepReg$exp[12] <- 'Vehicle' 

#Data Analysing of the cause of riots/attacks in each of the country
tr<-as.matrix(table(Reg=data$Region,Ter=data$Group))
grp <- c()
for(i in 1:nrow(tr)){
    ind <- which(max(tr[i,])==tr[i,])
    v[i] <- tr[i,ind]
    reg[i] <- rownames(tr)[i]
    grp[i] <- colnames(tr)[ind]}
df <- data.frame(v,reg,grp)
df$grp <- gsub('Unknown','Unknown Group',df$grp)
colnames(df)<-c('No. Of Attacks','Country','Terrorist Group')

#This is the Graphical Section 
#Here is the code for visual representation of data obtained above
plot1 <- ggplot(b1,mapping=aes(x=Var1,y=Freq,fill=Var1)) + geom_bar(stat = 'identity')+labs(x='Year',y='No. Of Attacks',title='Attacks In Each Year')+theme(axis.text.x = element_text(angle=90))
plot2 <- ggplot(country,mapping=aes(x=Var1,y=Freq,fill=Var1)) + geom_bar(stat = 'identity')+labs(x='Country',y='No. of Attacks',title='Attacks In Each Country')+theme(axis.text.x = element_text(angle=90))
plot3 <- ggplot(region,mapping=aes(x=Var1,y=Freq,fill=Var1)) + geom_bar(stat='identity') + labs(x='Prominent Region',y='No. of Attacks',title='Attacks In Each Region')+theme(axis.text.x = element_text(angle=90))
plot4 <- ggplot(data,mapping=aes(x=factor(Year),y=TotalKill,fill=factor(data$Year)))+geom_bar(stat='identity')+labs(x='Year',y='Casualities',title='Total Casualities In Each Attack Per Year')+theme(axis.text.x = element_text(angle=120))#+geom_label(label=unique(data$Year))
plot5 <- ggplot(data,mapping=aes(x=Region,y=TotalKill,fill=Region))+geom_bar(stat='identity')+labs(x='Region',y='Casualities',title='Total Casualities In Each Region')+theme_bw()+theme(axis.text.x = element_text(angle=90))
plot6 <- ggplot(weap,mapping=aes(x=Var1,y=as.factor(Freq),fill=Freq))+geom_bar(stat='identity')+labs(x='Explosive',y='Frequency',title='Class Of Explosive')+theme_bw()+theme(axis.text.x = element_text(angle=90),axis.text.y=element_text(angle=0))
plot7 <- ggplot(wepReg,mapping=aes(x=factor(exp),y=factor(v),fill=reg))+geom_bar(stat='identity')+labs(x='Explosive',y='Frequency',title='Explosive Used in Various Region')+theme_dark()+theme(axis.text.x=element_text(angle=120))
plot8 <- ggplot(terGrp,mapping=aes(x=factor(Var1),y=factor(Freq),fill=Var1))+geom_bar(stat='identity')+theme(axis.text.x=element_text(angle=90))+labs(x='Terrorist Group',y='No. Of Attacks',title='Attacks Done By Terrorist Groups')

#Function for output into the GUI part of program
shinyServer(function(session,input,output){
  output$odata <- renderTable(head(dta))
  output$strr <- renderPrint(str(dta))
  output$summ <- renderPrint(summary(dta))
  output$datC <- renderTable(head(data))
  
  
  output$strrC <- renderPrint(str(data))
  output$bar <- renderPlot({plot1})
  output$con <- renderPlot({plot2})
  output$hot <- renderPlot({plot3})
  output$cas1 <- renderPlot({plot4})
  output$cas2 <- renderPlot({plot5})
  output$exp1 <- renderPlot({plot6})
  output$exp2 <- renderPlot({plot7})
  output$group1 <- renderPlot({plot8})
  output$group2 <- renderTable({df})
})