# Getting And Clearning Data - Course Project
The script is heavily commented, but I'll repeat most of the explanation here, step by step.
* we begin by loading the library dplyr
* we then read all 6 tables (subjects, activity and data for the training and test sets). the subjects are converted to factors.
* we get the column names and grep just those with mean or std
* we use sapply to strip the numbers from the column names
* we keep just the interesting columns in the data sets
* we get the activity names
* we use them to rename (using sapply) the activities from numbers to names
* we cbind the training set with the subjects and activities
* we do the same to the test set
* we set the column names after extending them with "Subject" and "Activity"
* we rbind the whole set together
* using dplyr, we group_by the subjects and activies and use summarise_each to summarise the whole set at once.
* we print the result as a .txt file

The Code Book for sum_set:
* Subject - The subject number
* Activity - The Activity the subject was engaged in
* The other variables - means of the means and standard deviations for each activity measured for each subject. The full list of variables is described in the file "features_info.txt".

