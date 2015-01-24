# Getting-and-Cleaning-Data-Course-Project

This is the course project of "Getting and Cleaning Data". This project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

1. Original Data

The original data is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the course project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


2. Getting and Cleaning data with run_analysis.R

I have created one R script called run_analysis.R that does the following.

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

3. Final tidy data

The final tidy data created by the R script have 88 variables and 180 rows. There are two factor variables: "Subject" and "Activity_labels". Other varibles are all numerical variables which represent the average of each measurements (only including the measurements on the mean and standard deviation for each measurement).
