# Getting And Cleaning Data - Course Project
Course project for Week 4 of Getting and Cleaning Data on Coursera.

'Dplyr' package used in addition to R base packages.

The r_analysis.R script in this repository will download and carry out the following modifications to the UCI HAR Dataset
(for more information on the indicators and measurements used from this dataset, please see CODEBOOK in this repository):

    1. Reads in the 'subject', 'test' and 'training' datasets, in order to merge them into one single dataframe. 
          Also reads in the 'features' and 'activity_labels' in order to name the columns in above datasets.
          Uses - read.table(), rbind() & cbind().
          
    2. Extracts the mean and standard deviation for each measurement.
          Uses - library(dplyr), select() & %>% (pipeline operator)   
          
    3. Uses descriptive activity names to name the activities in the data set
          Activity names are in column 2 of the 'extracteddf' dataframe.
    
    4. Appropriately labels the data set with descriptive variable names.
          Uses - gsub() to replace non-meaningful variable names with an appropriate label, e.g 'Acc' replaced by 'Accelerometer', "^t" replaced by "Time".
          
   
    5. From the data set produced by setp 4, a second independent data set is created 'tidydatanew' with the average of each variable for each activity and each subject.
          Uses - library(dplyr), group_by(), %>% (pipeline operator), summarise_all & write.table ().
    
