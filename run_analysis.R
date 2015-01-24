# This is the script for course project of 'Getting and Cleaning Data'
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for 
# each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
# 6.Final Tidy data file using write.table

library(dplyr)
setwd("C:/cxia/learning/Data Science Specialization/Getting and Cleaning Data/UCI HAR Dataset")

# 1. Merges the training and the test sets to create one data set.
# Get train data set
X_train <- read.table("./train/X_train.txt",header=FALSE)
Y_train <- read.table("./train/y_train.txt",header=FALSE)
Subject_train <- read.table("./train/subject_train.txt",header=FALSE)
train_data <- cbind(X_train,Y_train,Subject_train)
# Get test data set
X_test <- read.table("./test/X_test.txt",header=FALSE)
Y_test <- read.table("./test/y_test.txt",header=FALSE)
Subject_test <- read.table("./test/subject_test.txt",header=FALSE)
test_data <- cbind(X_test,Y_test,Subject_test)
# Merge train and test data set
merge_data <- rbind(train_data,test_data)

# 2. Extracts only the measurements on the mean and standard deviation for 
# each measurement. 
#Get descriptive variables name from "features" file
features <- read.table("features.txt",header=FALSE)
listofNames <- as.character(features[,2])
listofNames <- make.names(listofNames, unique=TRUE)
colnames(merge_data) <- listofNames
colnames(merge_data)[562] <- "Activity"
colnames(merge_data)[563] <- "Subject"

#Extracts only the measurements on the mean and standard deviation 
#for each measurement.
mean_std_data <- select(merge_data,contains("mean"),contains("std"),
                        Activity,Subject)

# 3. Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names.
Activity_labels <- read.table("activity_labels.txt",header=FALSE)
colnames(Activity_labels) <- c("Activity", "Activity_labels")
mean_std_data <- merge(mean_std_data, Activity_labels, by.x="Activity",
                       by.y="Activity")

# 5.From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
gb_data <- group_by(mean_std_data, Activity_labels, Subject)
tidy_data <- summarise_each(gb_data, funs(mean), -Activity)

# 6.Final Tidy data file using write.table
write.table(tidy_data, file="tidy_data.txt",row.name=FALSE)
