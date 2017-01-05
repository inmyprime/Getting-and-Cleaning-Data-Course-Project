# Getting and Cleaning Data Course Project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

##Submission Files:

###CodeBook.md:
- Describes  the variables, the data, and any transformations or work that was performed to clean up the data.

###run_analysis.R:
- Download the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip the dataset.
- Read in the training and testing sets and then merge them into one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set.
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- The final result is shown in the file tidy_data.txt.

###tidy_data.txt:
- Tidy data set consists of the average of each variable for each activity and each subject.