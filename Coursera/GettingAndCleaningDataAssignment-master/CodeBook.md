Code Book

Make sure that the data is downloaded and ready in R directory from where the files will be imported.

1. Data Imported 
testdata - Variable value in test data
traindata- Variable value in train data
testlabel- Activity ID for test data
trainlabel- Activity ID for train data
trainsubject - Subject ID for train data
testsubject- Subject ID for test data
label_activity - Activity ID description
feature - Feature description

2.Combining test and train data
finaldata - Merging variable values in test and train data
finalsubjectdata - Merging subject values in test and train data
finalactivitydata- Merging activity values in test and train data
fulldata - Merging all data into one variable

3.Separating measurements on the mean and standard deviation
meanstd - Gets index values of mean/std deviation values
meanstddata - Gets the data based on indices from meanstd

4.Updating the activity levels in combined data
act_group - Gets values of factors

5.Adding labels the data set with descriptive variable names
featureNames - Gets the list of feature names without ()

6.Creating  independent tidy data set with the average of each variable for each activity and each subject
melted - Melts the combined data so that a copy can be made
tidy - Final data created from the melted data
