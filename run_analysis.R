# 0. Libraries
library(dplyr)
library(data.table)


# Download Data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
unzip(temp)
unlink(temp)

# Course Project 2: Wearable Metrics
# 1. Merges the training and the test sets to create one data set.
# ------------------------------------------------------------------------
# Read the training data frames
train.x <- read.table("uci_dataset_source/train/X_train.txt")
train.y <- read.table("uci_dataset_source/train/y_train.txt")
train.subject <- read.table("uci_dataset_source/train/subject_train.txt")

# Read the test data frames
test.x <- read.table("uci_dataset_source/test/X_test.txt")
test.y <- read.table("uci_dataset_source/test/y_test.txt")
test.subject <- read.table("uci_dataset_source/test/subject_test.txt")

# Merging test and training for each measurement
merge.x <- rbind(train.x, test.x)
merge.y <- rbind(train.y, test.y)
colnames(merge.y) <- "activity_id"
merge.subject <- rbind(train.subject, test.subject)
colnames(merge.subject) <- "subject_id"

# Create a unified data set with x, y and subjects
tidy.df <- cbind(merge.x, merge.y, merge.subject)
# ------------------------------------------------------------------------


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# ------------------------------------------------------------------------
# Reading the feagures
features <- read.table("uci_dataset_source/features.txt")

# Extracting only the mean and the standard deviation into features.filtered
features.filtered <- rbind(features[grep("mean\\(", features$V2),], features[grep("std\\(", features$V2),])

# Extract the values for each measurement and append columns for activity and subject
tidy.df <- cbind(tidy.df[,features.filtered$V1], tidy.df[,c("activity_id", "subject_id")])
colnames(tidy.df) <- c(as.character(features.filtered$V2), "activity_id", "subject_id")
# ------------------------------------------------------------------------


# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# ------------------------------------------------------------------------
activity.labels <- read.table("uci_dataset_source/activity_labels.txt")
colnames(activity.labels) <- c("activity_id", "activity_name")


# This data frame contains labels with the activities and features all together
tidy.df <- merge(tidy.df, activity.labels, by="activity_id", type = "right", all.x = TRUE)
# ------------------------------------------------------------------------


# 5. From the data set in step 4, creates a second, independent
#    tidy data set with the average of each variable for each activity and each subject.
# ------------------------------------------------------------------------
tidy.df.means <- tidy.df %>% group_by(activity_name,subject_id) %>% summarise_each(funs(mean))
write.csv(tidy.df.means, "tidy_data_table.txt", row.names=FALSE)
