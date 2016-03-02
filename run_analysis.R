#load required libraries
library(dplyr)

#read the subject lists and turn them to factors
train_subjects <- readLines("train/subject_train.txt")
train_subjects <- factor(train_subjects)
test_subjects <- readLines("test/subject_test.txt")
test_subjects <- factor(test_subjects)

#read the 4 files: Training and test, data and activity
train_data <- read.table("train/X_train.txt")
test_data <- read.table("test/X_test.txt")
train_activity <- readLines("train/y_train.txt")
test_activity <- readLines("test/y_test.txt")

#get the column names and list those with mean and std
colnames <- readLines("features.txt")
relevant_colnames <- grep("mean|std", colnames)

#get the colnames without the number and keep the relevant ones
func <- function(x) {x[2]}
colnames <- sapply(strsplit(colnames, " "), func)
colnames <- colnames[relevant_colnames]

#select just the columns with mean and std
train_data <- select(train_data, relevant_colnames)
test_data <- select(test_data, relevant_colnames)

#get activity labels as names
activity_labels <- readLines("activity_labels.txt")
func <- function(x) {x[2]}
activity_labels <- sapply(strsplit(activity_labels, " "), func)

#rename activity labels in the actual sets
func <- function(x){activity_labels[x]}
train_activity <- sapply(as.numeric(train_activity), func)
test_activity <- sapply(as.numeric(test_activity), func)

#cbind the training set
train_set <- cbind(train_subjects, train_data)
train_set <- cbind(train_set, train_activity)

#cbind the test set
test_set <- cbind(test_subjects, test_data)
test_set <- cbind(test_set, test_activity)

#extend the colnames with the new columns
colnames <- c("Subject", colnames)
colnames <- c(colnames, "Activity")

#use colnames as the data sets' names
names(train_set) <- colnames
names(test_set) <- colnames

#rbind the whole lot together
data_set <- rbind(train_set, test_set)

#do the requested summarization and create the text file
data_set <- tbl_df(data_set)
data_set <- group_by(data_set, Subject, Activity)
sum_set <- summarise_each(data_set, funs(mean))
write.table(sum_set, file="sum_set.txt", row.names = FALSE)