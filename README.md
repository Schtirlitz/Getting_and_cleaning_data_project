# Getting and Cleaning Data - Course Project

This is the course project for the Coursera's course "Getting and Cleaning Data".
There are 3 files
* R-script: `run_analysis.R` - executive file
* Result-file: `tidy.txt` - file contains result tidy data
* Code Book: CodeBook.md - describes the variables, the data, and any transformations or work that R-script performed to clean up the data 

## R-script does the following (block-by-block):
1. Library: connect all nesesary library
2. Work directory: set work directory
3. Download and unzip dataset: download and unzip dataset to work directory if it does not already exist
4. load data that describe labels for activities and features
5. Create list of feature data that contain data about mean and standard deviation
6. Make a column names more fit (clear dirty symbols)
7. Load the datasets (train and test)
8. Join data into 1 data-frame and call columns of joined data-frame
9. Convert "Subject" and "Label" from integer to factor
10. Create the 2nd, independent tidy data set with the average of each variable for each activity and each subject
11. Write tidy data to "tidy.txt"
