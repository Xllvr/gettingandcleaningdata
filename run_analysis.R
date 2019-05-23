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
