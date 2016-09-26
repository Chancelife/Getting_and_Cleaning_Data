setwd("D:/Rdir/Coursera/Rdata/assignment")
library(dplyr)
#####
# (0.download, unzip and read data into R)
# 0.1: download raw zipped data
if(!file.exists("./data")) dir.create("./data")
DataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(DataUrl, destfile = "./data/getcleanData.zip")

# 0.2: unzip
listZip <- unzip("./data/getcleanData.zip", exdir = "./data")

# 0.3: reading data
train.x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
test.x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
#####
# 1. Merge the training and the test sets to create one data set.
trainData <- cbind(train.subject, train.y, train.x)
testData <- cbind(test.subject, test.y, test.x)
#subjects <- rbind(train.subject, test.subject)
CData <- rbind(trainData, testData)
#####
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]
findexes <- grep(("mean\\(\\)|std\\(\\)"), features)
CData <- CData[, c(1, 2, findexes+2)]
colnames(CData) <- c("subject", "activity", features[findexes])
#####
# 3. Use descriptive activity names to name the activities in the data set
activityName <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
CData$activity <- factor(CData$activity, levels = activityName[,1], labels = activityName[,2])
#####
# 4. Appropriately labels the data set with descriptive variable names.
#switch char "t" to word "time"
names(CData) <- gsub("^t", "time", names(CData))
#switch char "f" to word "frequence"
names(CData) <- gsub("^f", "frequence", names(CData))
#swutch "-std" to " standard deviation"
names(CData) <- gsub("-std", " standard deviation", names(CData))
#####
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
AverageData <- CData %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
write.table(AverageData, "./AverageData.txt", row.names = FALSE)