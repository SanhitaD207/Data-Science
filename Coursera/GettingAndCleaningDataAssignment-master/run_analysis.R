#Importing data after the folder is downloaded and unzipped
testdata<-read.table("UCI HAR Dataset/test/X_test.txt")
traindata<-read.table("UCI HAR Dataset/train/X_train.txt")
testlabel<-read.table("UCI HAR Dataset/test/y_test.txt")
trainlabel<-read.table("UCI HAR Dataset/train/y_train.txt")
trainsubject<-read.table("UCI HAR Dataset/train/subject_train.txt")
testsubject<-read.table("UCI HAR Dataset/test/subject_test.txt")
label_activity<-read.table("UCI HAR Dataset/activity_labels.txt")
feature<-read.table("UCI HAR Dataset/features.txt")

#Combining test and train data (Point 1)
finaldata<-rbind(testdata,traindata)

#Separating measurements on the mean and standard deviation (Point 2)
meanstd <- grep("mean()|std()", feature[, 2])
meanstddata<-finaldata[,meanstd]

finalsubjectdata<-rbind(testsubject,trainsubject)
finalactivitydata<-rbind(testlabel,trainlabel)

#Assigning names to the activity
names(finalsubjectdata) <- 'subject'
names(finalactivitydata) <- 'activity'

#Combining all the data together
fulldata<-cbind(finaldata,finalsubjectdata,finalactivitydata)

#Updating the activity levels in combined data (POint 3)
act_group <- factor(fulldata$activity)
levels(act_group) <- label_activity[,2]
fulldata$activity<-act_group

#Adding labels the data set with descriptive variable names (Point 4)
featureNames <- sapply(feature[, 2], function(x) {gsub("[()]", "",x)})
names(finaldata)<-featureNames

# Creating  independent tidy data set with the average of each variable for each activity and each subject(Point 5)
melted <- melt(fulldata, id=c("subject","activity"))
tidy <- dcast(melted, subject+activity ~ variable, mean)

# write the tidy data set to a file
write.table(tidy, "tidy.txt", row.names=FALSE)
