Getting-and-Cleaning-Data
=========================

Getting and Cleaning Data Course Project

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


How to use:

Download the train and test data (link below) and decompressed it in your local directory.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Clone this project, open the R Studio, set the working directory and run the following commands in R:
'''
sources("run_analysis.R")
create_tidy_data()
'''

You can specify the train and test data root directory (for example):
'''
create_tidy_data("C:/getting-and-cleaning-data/UCI HAR Dataset/")

It will create a new tidy data file containing the mean and standard deviation averages for each activity/subject.
For details how it works, please look at the methods and comments in the run_analysis.R script.
