##run_analysis.R

##load packages
library(dplyr)

## Download the data from the web.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "data.zip")
unzip("data.zip")

## Use list.files to see the file name of he unzipped folder in your working directory. 
## We want to see what the name of the unzipped file is in our working directory.
list.files()

## Next we want to see the list of files that our unzipped file contains.
list.files("UCI HAR Dataset")


## 1. Merges the training and the test sets to create one data set.

## Read 'train' and 'test' data into R with read.table function.
## Also read in the data on 'features' and 'activity labels' to name columns when 
## reading in the other data files.
## As the tables are read in, assign each table to a variable name in R. 


## features & activities

features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

##train

trainingsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
trainingdata <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
traininglabels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")

##test

testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")


## Use rbind() to combine 'trainingdata' with 'testdata' into one dataframe called 'data'.
## Then do the same for ' traininglabels' and 'testlabels' and call the dataframe 'labels'.


data <- rbind(trainingdata, testdata)
labels <- rbind(traininglabels, testlabels)
subject <- rbind(trainingsubject, testsubject)

## Now merge the 'data', 'label' & 'subject' dataframes into a single dataframe using cbind().

mergeddf <- cbind(subject, labels, data)

## 2. Extract only the mean and standard deviation for each measurement.

extracteddf <- mergeddf %>% select(subject, code, contains("mean"), contains("std"))


## 3. Use descriptive activities names for activity measurements

extracteddf$code <- activities[extracteddf$code, 2]

## 4. Appropriately labels the data set with descriptive variable names.

names(extracteddf)[2] = "activity"
names(extracteddf)<-gsub("^f", "Frequency", names(extracteddf))
names(extracteddf)<-gsub("-freq()", "Frequency", names(extracteddf), ignore.case = TRUE)
names(extracteddf)<-gsub("angle", "Angle", names(extracteddf))
names(extracteddf)<-gsub("BodyBody", "Body", names(extracteddf))
names(extracteddf)<-gsub("tBody", "TimeBody", names(extracteddf))
names(extracteddf)<-gsub("Acc", "Accelerometer", names(extracteddf))
names(extracteddf)<-gsub("gravity", "Gravity", names(extracteddf))
names(extracteddf)<-gsub("Gyro", "Gyroscope", names(extracteddf))
names(extracteddf)<-gsub("-std()", "STD", names(extracteddf), ignore.case = TRUE)
names(extracteddf)<-gsub("Mag", "Magnitude", names(extracteddf))
names(extracteddf)<-gsub("-mean()", "Mean", names(extracteddf), ignore.case = TRUE)
names(extracteddf)<-gsub("^t", "Time", names(extracteddf))

## 5. From the data set in step 4, creates a second, 
## independent tidy data set with the average of each variable for each activity and each subject.

tidydatanew <- extracteddf %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidydatanew, "tidydatanew.txt", row.name=FALSE)






