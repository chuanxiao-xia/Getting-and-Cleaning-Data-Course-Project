# Getting-and-Cleaning-Data-Course-Project

This is the course project of "Getting and Cleaning Data". This project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

## Original Data

The original data is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the course project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Getting and Cleaning data with run_analysis.R

I have created one R script called run_analysis.R that does the following.

    1. Merges the training and the test sets to create one data set.
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
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
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
    3. Uses descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive variable names. 
            Activity_labels <- read.table("activity_labels.txt",header=FALSE)
            colnames(Activity_labels) <- c("Activity", "Activity_labels")
            mean_std_data <- merge(mean_std_data, Activity_labels, by.x="Activity",
                                   by.y="Activity")
    4. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
            gb_data <- group_by(mean_std_data, Activity_labels, Subject)
            tidy_data <- summarise_each(gb_data, funs(mean), -Activity)
    5. Final Tidy data file using write.table
            write.table(tidy_data, file="tidy_data.txt",row.name=FALSE)

## Final tidy data

The final tidy data created by the R script have 88 variables and 180 rows. There are two factor variables: "Subject" and "Activity_labels". Other varibles are all numerical variables which represent the average of each measurements (only including the measurements on the mean and standard deviation for each measurement).
