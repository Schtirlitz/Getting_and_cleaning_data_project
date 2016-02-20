# Getting and Cleaning Data Course Project
# Made by Alexander
# Date: 20.02.2016
# WARNING: This script was made for running on my own machine. For correct running you don't need to use part
#          of the script that called "work directory"
# ------------------------------------------
# 1. library
library(reshape2) # we will need it for using MELT and DCAST
#-------------------------------------------

# 2. work directory
setwd("D:\\yandex_disk\\Big_Data\\Course_3_Getting_and_Clearing_Data")
if (!file.exists("Project")) {dir.create("Project")} # if dir doesn't exist then create the dir
setwd("D:\\yandex_disk\\Big_Data\\Course_3_Getting_and_Clearing_Data\\Project")
#-------------------------------------------

# 3. Download and unzip dataset
URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
dist_zip <- 'dataset.zip'
if (!file.exists(dist_zip)) {download.file(URL, dist_zip)} #download zip-file to work directory
if (!file.exists("UCI HAR Dataset")) {unzip(dist_zip)}
#-------------------------------------------

# 4. Load data that describe labels for activities and features
activ_label <- read.table('UCI HAR Dataset\\activity_labels.txt') #Links the class labels with their activity name
feature_label <- read.table('UCI HAR Dataset\\features.txt') #List of all features
#str(activ_label)
#str(feature_label)
# change type of columns from 'factor' to 'char' for future working with them
activ_label[,2] <- as.character(activ_label[,2])
feature_label[,2] <- as.character(feature_label[,2])
#-------------------------------------------

# 5. Create list of feature data that contain data about mean and standard deviation
feature_row_list <- grep("*.mean*.|*.std*.",feature_label[,2]) # list of rows with required name
feature_names <- feature_label[feature_row_list,2]
#-------------------------------------------

# 6. Make a names more fit (clear dirty symbols)
feature_names <- gsub("-mean","Mean", feature_names)
feature_names <- gsub("-std","Std", feature_names)
feature_names <- gsub("[-()]","", feature_names)
#-------------------------------------------

# 7. Load the datasets
#Train
training_dataset <- read.table("UCI HAR Dataset/train/X_train.txt")[feature_row_list] # read just required columns 
training_labels <- read.table("UCI HAR Dataset/train/Y_train.txt")
training_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
training_dataset <- cbind(training_subjects, training_labels, training_dataset)

#Test
test_dataset <- read.table("UCI HAR Dataset/test/X_test.txt")[feature_row_list] # read just required columns
test_labels <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_dataset <- cbind(test_subjects, test_labels, test_dataset)
#-------------------------------------------

# 8. Join data into 1 data-frame and call columns of joined data-frame
Joined_Dataset <- rbind(training_dataset, test_dataset)
names(Joined_Dataset) <- c("Subject", "Label", feature_names)
#-------------------------------------------

# 9. Convert "Subject" and "Label" from integer to factor
Joined_Dataset$Subject <- as.factor(Joined_Dataset$Subject)
#Appropriately labels the data set with descriptive variable names
Joined_Dataset$Label <- factor(Joined_Dataset$Label,levels = activ_label[,1], labels = activ_label[,2])
#-------------------------------------------

# 10. Creat the 2nd, independent tidy data set with the average of each variable for each activity and each subject
#Cast functions Cast a molten data frame into an array or data frame.
Melted_Dataset <- melt(Joined_Dataset, id = c("Subject", "Label"))
Mean_Dataset <- dcast(Melted_Dataset, Subject + Label ~ variable, mean)
#-------------------------------------------

# 11. Write tidy data to "tidy.txt"
write.table(Mean_Dataset, "tidy.txt", row.names = FALSE, quote = FALSE)

# THE END
