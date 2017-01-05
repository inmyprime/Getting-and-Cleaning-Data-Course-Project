# Get the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/dataset.zip")
unzip("./data/dataset.zip", exdir = "./data")

# Read the files and give proper column names
pathname <- "./data/UCI HAR Dataset/"

x_train <- read.table(paste0(pathname,"train/X_train.txt"))
y_train <- read.table(paste0(pathname,"train/y_train.txt"))
subject_train <- read.table(paste0(pathname,"train/subject_train.txt"))

x_test <- read.table(paste0(pathname,"test/X_test.txt"))
y_test <- read.table(paste0(pathname,"test/y_test.txt"))
subject_test <- read.table(paste0(pathname,"test/subject_test.txt"))

activity_labels <- read.table(paste0(pathname,"activity_labels.txt"))
features <- read.table(paste0(pathname,"features.txt"))

colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]

# 1. Merges the training and the test sets to create one data set.
x_train$activity <- y_train[,1]
x_train$subject <- subject_train[,1]
x_test$activity <- y_test[,1]
x_test$subject <- subject_test[,1]

oneDataset <- rbind(x_train, x_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
col_names <- colnames(oneDataset)
mean_std <- (col_names == "activity" | col_names == "subject" |
                 grepl("mean\\(\\)", col_names) |
                 grepl("std\\(\\)", col_names))
measurements <- oneDataset[,mean_std]

# 3. Uses descriptive activity names to name the activities in the data set
measurements$activity <- activity_labels[measurements$activity,]$V2

# 4. Appropriately labels the data set with descriptive variable names.
names(measurements) <- gsub("Acc", "Accelerator", names(measurements))
names(measurements) <- gsub("Mag", "Magnitude", names(measurements))
names(measurements) <- gsub("Gyro", "Gyroscope", names(measurements))
names(measurements) <- gsub("^t", "time", names(measurements))
names(measurements) <- gsub("^f", "frequency", names(measurements))
names(measurements)<-gsub("BodyBody", "Body", names(measurements))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- aggregate(. ~ activity + subject, measurements, mean)
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)

# Produce a codebook for the final dataset
install.packages("memisc")
library(memisc)
Write(codebook(tidy_data), file="CodeBook.md")
