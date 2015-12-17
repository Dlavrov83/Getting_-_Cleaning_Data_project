#################
## Dany Lavrov ##
## 17/12/2015  ##
#################

# Set zip file name
filename <- "getdata_dataset.zip"

# Check whether the zip file already exists, if not download the dataset
if (!file.exists(filename)){
    fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  
# Unzip the dataset
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

# Read activity labels and features
actlbl = read.table("UCI HAR Dataset/activity_labels.txt")
features = read.table("UCI HAR Dataset/features.txt")
actlbl[,2] = as.character(actlbl[,2])
features[,2] = as.character(features[,2])

# Finding only desired features
DF.idx = grep(".*mean.*|.*std.*", features[,2])
DF.names = features[DF.idx,2]

# Cleaning features names
DF.names = gsub("mean()", "Mean", DF.names)
DF.names = gsub("std()", "STD", DF.names)
DF.names = gsub("[-()]", "", DF.names)

# Loading training data and creating a data frame
data_train = read.table("UCI HAR Dataset/train/X_train.txt")[DF.idx]
colnames(data_train) = DF.names
activities_train = read.table("UCI HAR Dataset/train/y_train.txt")
colnames(activities_train) = c("Activity")
subjects_train = read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subjects_train) = c("Subject")
train = cbind.data.frame(subjects_train, activities_train, data_train)

# Loading test data and creating a data frame
data_test = read.table("UCI HAR Dataset/test/X_test.txt")[DF.idx]
colnames(data_test) = DF.names
activities_test = read.table("UCI HAR Dataset/test/y_test.txt")
colnames(activities_test) = c("Activity")
subjects_test = read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(subjects_test) = c("Subject")
test = cbind.data.frame(subjects_test, activities_test, data_test)

# Merging the data
mergedData = rbind.data.frame(train, test)
mergedData[,2] = actlbl[mergedData[,2], 2]

# Factorizing "Subject" & "Activity" columns
mergedData[,1] = factor(mergedData[,1])
mergedData[,2] = factor(mergedData[,2])

# Creating new tidy data that hold the means for each subject-activity pair
tidyData = aggregate.data.frame(mergedData[,DF.names],by=list(Subject=mergedData$Subject,Activity = mergedData$Activity),mean)

# Writing the tidy datset into a file
write.table(tidyData, "tidyData.txt", row.names = FALSE)