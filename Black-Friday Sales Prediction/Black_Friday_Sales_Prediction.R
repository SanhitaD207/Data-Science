library(dplyr)
library(ggplot2)
library(caret)
library(caretEnsemble)
library(VIM)
library(gridExtra)

black_friday <- read.csv("train.csv")

#Converting Marital Status Column
black_friday$Marital_Status <- factor(black_friday$Marital_Status)

#Converting Occupation Column
black_friday$Occupation <- factor(black_friday$Occupation)

#Converting User_ID Column
black_friday$User_ID <- factor(black_friday$User_ID)

#Converting Product_Category_2 Column
black_friday$Product_Category_2 <- 
  factor(black_friday$Product_Category_2)

#Converting Product_Category_3 Column
black_friday$Product_Category_3 <- factor(black_friday$Product_Category_3)

#Imputing 0 for NA in Product_Category_2
black_friday$Product_Category_2 <- as.numeric(black_friday$Product_Category_2)

black_friday[is.na(black_friday$Product_Category_2), "Product_Category_2"] <- 0

#Imputing 0 For NA in Product_Category_3
black_friday$Product_Category_3 <- as.numeric(black_friday$Product_Category_3)

black_friday[is.na(black_friday$Product_Category_3), "Product_Category_3"] <- 0

black_friday_machine <- black_friday %>%
  select(-User_ID, -Product_ID)

summary(black_friday_machine)


set.seed(366284)
black_friday_sample <- createDataPartition(y = black_friday_machine$Purchase, p = 0.1, list=FALSE)
black_friday_sample <- black_friday_machine[black_friday_sample, ]


inTrain <- createDataPartition(y = black_friday_sample$Purchase, 
                               p = 0.7, list=FALSE)
train <- black_friday_sample[inTrain, ]
test <- black_friday_sample[-inTrain, ]

#Setting Control Parameters
control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, savePredictions = TRUE, classProbs = TRUE)

#Creating List with Model Types to be Used
algorithmList <- c('glmnet', 'lm', 'rpart')

#Building Models
models <- caretList(Purchase ~ ., train, trControl = control, methodList = algorithmList)

#Testing Models Predictive Accuracy
results <- resamples(models)
summary(results)



