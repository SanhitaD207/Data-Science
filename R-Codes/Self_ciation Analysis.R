# Case study on self-citations - https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0195773#pone-0195773-g002
# Try to plot the graph in Fig 1
# by Sanhita Dhamdhere 10/07/2019
# Using R version 3.6.1 (2019-07-05) -- "Action of the Toes"

# load BBmisc package for normalize function, ggplot2 for plotting and caTools for sampling
library(BBmisc)
library(ggplot2)
library(caTools)

# load data from selfcitefirst_sample01wheader.tsv file
df = read.delim("path to/selfcitefirst_sample01wheader.tsv", header = TRUE)

# subset the data and use only the following columns
cite_data = subset(df, select = c("year_span","gender","auth_last_npapers","auth_prev_papers","is_self_cite", "source_ncites"))

# remove data where there is no gender value
cite_data = cite_data[cite_data$gender == "M" | cite_data$gender == "F",]

# fix citations to a range of 10-60
cite_data = cite_data[cite_data$source_ncites <= 60 & cite_data$source_ncites >= 10, ]

# normalize year_span column as the age
cite_data$age = normalize(cite_data$year_span, method = "range", range=c(0,100), margin = 1L, on.constant = "quiet")

# splitting data into male and female data
df_F = subset(cite_data, gender == "F")
df_M = subset(cite_data, gender == "M")

# proportions for male and female
prop_F = (nrow(df_F)) / (nrow(cite_data))
prop_M = (nrow(df_M)) / (nrow(cite_data))

# split data into training and test data 
train_ind_M = sample(seq_len(nrow(df_M)),size = floor(0.75*nrow(df_M)))
train_data_M = df_M[train_ind_M,]
test_data_M = df_M[-train_ind_M,]

train_ind_F = sample(seq_len(nrow(df_F)),size = floor(0.75*nrow(df_F)))
train_data_F = df_F[train_ind_F,]
test_data_F = df_F[-train_ind_F,]

# apply glm to age and gender with is_self_cite as target variable
model_M = glm(is_self_cite ~ age, data = train_data_M, family = 'binomial')
model_F = glm(is_self_cite ~ age, data = train_data_F, family = 'binomial')

# prediction formed using the model and applied to test data
pred_M = predict(model_M, newdata = test_data_M, type = "response")
pred_F = predict(model_F, newdata = test_data_F, type = "response")

# plotting the predicted values
ggplot() +
  geom_line(data=test_data_M, aes(age, -pred_M + 0.2), color = "Red") + 
  geom_line(data=test_data_F, aes(age, -pred_F + 0.2), color = "Blue") + 
  geom_hline(yintercept = prop_M, linetype = 2, colour = "Red") + 
  geom_hline(yintercept = prop_F, linetype = 2, colour = "Blue")
