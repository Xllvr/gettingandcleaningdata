## Dataset and Required Packages
install.packages("dplyr")
library(dplyr)
download.files("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./UCI HAR Dataset")

## Obtaining Data from Dataset
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activity"))
test.subj <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test.x <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
test.y <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "label")
train.subj <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train.x <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
train.y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")

## Combining Data from the Test and Train Datasets
X <- rbind(test.x, train.x)
Y <- rbind(test.y, train.y)
Subject <- rbind(test.subj, train.subj)
Merged <- cbind(Subject, X, Y)

## Tidying up the combined data
Tidy <- Merged %>% select(subject, label, contains("mean"), contains("std"))

## Naming the tidied data
Tidy$label <- activities[Tidy$label, 2]
names(Tidy)[2] <- "activity"
names(Tidy) <- gsub("Acc", "Accelerometer", names(Tidy))
names(Tidy) <- gsub("Gyro", "Gyroscope", names(Tidy))
names(Tidy) <- gsub("tBody", "TimeBody", names(Tidy))
names(Tidy) <- gsub("fBody", "FrequencyBody", names(Tidy))
names(Tidy) <- gsub("Mag", "Magnitude", names(Tidy))
names(Tidy) <- gsub("BodyBody", "Body", names(Tidy))

## Finalizing data
Final <- Tidy %>%
        group_by(subject, activity) %>%
        summarize_all(list(mean))
write.table(Final, "finalized.txt", row.names = FALSE)
