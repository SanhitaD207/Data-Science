#Loading the data from the file
arr_data<-read.delim("Arrowsmith.txt",header = TRUE, skip = 4)

#Data Cleaning

#Removing the unwanted rows
df=arr_data[-c(16:29)]

#Removing the outliers from nof.MeSH.in.common column
df$nof.MeSH.in.common[df$nof.MeSH.in.common == 99999] <- 0.5

#Removing the outliers from X1st.year.in.MEDLINE column
df[df$X1st.year.in.MEDLINE==9999,]
df[df$X1st.year.in.MEDLINE==NA,]
df[9506,12]<- NA

#Removing the outliers from cohesion.score column
df[df$cohesion.score==0.9999,]
df[df$cohesion.score==NA,]
df[9506,10]<- NA

#Converting data frame to matrix to pass to the apply function
arr_matrix <- data.matrix(df)

#Populating the values of X1,X2 to data frame
df$X1<-ifelse((df$nA > 1 | df$A.lit.size<1000) & (df$nC>1 | df$C.lit.size<1000),1,0)
df$X2<-ifelse((df$nof.MeSH.in.common > 0 & df$nof.MeSH.in.common<99999),1,(ifelse((df$nof.MeSH.in.common==99999),0.5,0)))

#Populating the values of X3,X4 to data frame
df$x3 = ifelse(df$nof.semantic.categories >0, 1, 0)
df$x4 = ifelse(df$cohesion.score < 0.3,df$cohesion.score , 0.3)

#Populating the values of X5,X6 to data frame
df$x5 <- - (abs(log10(df$n.in.MEDLINE) - 3 ))
df$x6 = pmax(pmin(df$X1st.year.in.MEDLINE,2005),1950)

#Populating the values of X7,y to data frame
df$x7 = pmin(8,-log10(df$pAC+0.000000001))   
df$y = ifelse((df$target == 0) | (df$target == 2), 1, 0)

#Calculating the coefficients of the variables using logistic regression
fit<-glm(df$y~df$X1+df$X2+df$x3+df$x4+df$x5+df$x6+df$x7, family = "binomial")
fit

#Calulating the expected value of y based on the formula given in the paper
#df$y_exp = 0.73*df$X1 + 0.99*df$X2 + 1.32*df$x3 + 13.8*df$x4 + 0.59*df$x5 + 0.04*df$x6 + 0.19*df$x7




