## Getting and cleaning data of Human Activity Recognition Using Smartphones datasets
## Datasets can be downloaded here: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Download and unzip the dataset if it doesn't exist on folder:
if (!file.exists("UCI HAR Dataset")) { 
  
  zipfile <- "getdata_dataset.zip"
  
  if (!file.exists(zipfile))
  {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, zipfile)
  }
  
  unzip(zipfile) 
}

# Extract only the variables with mean and standard 
features <- read.table("UCI HAR Dataset/features.txt")
WantedFeatures <- features[grep(".*mean.*|.*std.*", features[,2]),2]

# Load Test and Train datasets
testSet <- read.table("UCI HAR Dataset/test/X_test.txt")[WantedFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, testSet)

trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")[WantedFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, trainSet)

# Merge datasets, then clean and add labels
combinedData <- rbind(train, test)
WantedFeaturesNames <- gsub('[-()]', '', WantedFeatures)

# Change variable names starting with t -> time, starting with f-> frequency
timeVariables<-grep("^t", WantedFeatures)
freqVariables<-grep("^f", WantedFeatures)
WantedFeaturesNames[timeVariables]<-sub("t", "time", WantedFeaturesNames[timeVariables])
WantedFeaturesNames[freqVariables]<-sub("f", "freq", WantedFeaturesNames[freqVariables])
colnames(combinedData) <- c("subject", "activity", WantedFeaturesNames)

# Change activity numbers to activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
combinedData[,2] <- activityLabels[combinedData[, 2], 2]

# Create a tidy dataset that consists of the mean value of each variable 
# for each subject and activity pair
combinedDataMelted <- melt(combinedData, id = c("subject", "activity"))
combinedDataMean <- dcast(combinedDataMelted, subject + activity ~ variable, mean)
write.table(combinedDataMean, "tidy.txt", row.names = FALSE, quote = FALSE)
