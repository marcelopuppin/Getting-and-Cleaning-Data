# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(plyr)

# Creates a tidy data with mean and stardard deviation averages by activity and subject. 
# Parameter:
# - path_ini should contain the root path to the train/test data
#
# How to use:
# > source("run_analysis.R")
# > create_tidy_data()
#
create_tidy_data <- function(path_ini = paste(getwd(),"/UCI HAR Dataset/", sep="")) {
  ROOT <<- path_ini
  
  print("Merging train and test data ...")
  data_Y <- merge_train_with_test("y", c("y"))
  data_X <- merge_train_with_test("X", get_features())
  data_subject <- merge_train_with_test("subject", c("subject"))
  
  print("Extracting data ...")
  column_names <- colnames(data_X)
  data_mean <- data_X[, filter_columns_by("mean()", column_names)]
  data_std <- data_X[, filter_columns_by("std()", column_names)]
  
  print("Labeling data ...")
  data_Y <- label_column_data_by("activity", data_Y)
  
  data_merged <- cbind(data_Y, data_subject, data_mean, data_std)
  
  print("Summarizing ...")
  data_tidy <- ddply(data_merged, .(activity, subject), numcolwise(mean, na.rm=TRUE))
  
  path <- paste(ROOT, "/", "tidy_data.txt", sep="")
  print(paste("Created tidy data file at", path))
  write.table(data_tidy, path, append=FALSE)
}

# Merge train and test data into a data set.
# data_name = "x", "Y" or "subject"
# col_names = feature, activity or subject column name(s)
merge_train_with_test <- function(data_name, col_names) {
  train_path <- get_type_path("train")
  test_path <- get_type_path("test")
  
  train <- read.table(paste(train_path, data_name, "_train.txt", sep=""))
  colnames(train) <- col_names
  
  test <- read.table(paste(test_path, data_name, "_test.txt", sep=""))
  colnames(test) <- col_names
  
  data <- rbind(train, test)
  
  data
}

# Filter the column names by pattern matching
# pattern = "mean()" or "std()"
# column_names = all column names from data set
filter_columns_by <- function(pattern, column_names) {
  filtered_column_names <- NULL
  for(column_name in column_names) {
    if (length(grep(pattern, column_name, fixed=TRUE)) > 0) {
      filtered_column_names <- cbind(filtered_column_names, column_name)
    }
  }
  filtered_column_names
}

# Map each row from a data column with the correspondent label
# label_name = "activity"
# column_data = data (column) to be labeled
label_column_data_by <- function(label_name, column_data) {
  labels <- get_labels(label_name)
  i <- 0
  for(row in column_data){
    i = i + 1
    column_data[i] <- labels[row]
  }
  colnames(column_data) <- c(label_name)
  column_data
}

# Helper functions:
#
get_type_path <- function(type) {
  path <- paste(ROOT, "/", type, "/", sep="")
  path
}

get_features <- function() {
  path <- paste(ROOT, "/features.txt", sep="")
  data <- read.table(path)
  features <- t(data)
  features <- c(features[2,])
  features
}

get_labels <- function(label_name) {
  path <- paste(ROOT, "/", label_name, "_labels.txt", sep="")
  labels <- read.table(path)
  colnames(labels) <- c("id", label_name)
  labels[,label_name]
}