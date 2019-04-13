Getting and Cleaning Data Course Project
========================================

The goal of this project is to prepare tidy data that can be used for later analysis. The dataset provided is the Human Activity Recognition Using Smartphones Dataset, available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. It represents data collected from the accelerometers from the Samsung Galaxy S smartphone. 


The Code Book (CodeBook.md)
===========================
The code book describes the variables and transformations that have been performed to clean up the original dataset.


run_analysis.R script
=====================
The run_analysis.R script in this repository works as follows:
1. It first downloads the data set from the target URL into the working directory.
2. The downloaded file is then unzipped into a folder called "uci_har_dataset".
3. The files in the folder are then read.
4. The training datasets are merged. Following merging, the column names for the training dataset are changed to 'subject' and 'activity'.
5. The test datasets are merged next. Following merging, the column names for the test dataset are changed to 'subject' and 'activity'.
6. The training and test datasets (both now containing similar column names) are subsequently merged.
7. Next, the script goes on to extract only the mean and standard deviation values from the merged dataset.
8. Descriptive activity names are subsequently applied to name the activities in the dataset created in step 7.
9. The script then labels the dataset with descriptive variable names.
10. Finally, from the dataset created in step 9, the script creates a second, independent tidy data set with the average of each variable for each activity and each subject.

