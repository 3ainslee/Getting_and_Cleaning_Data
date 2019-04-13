##Downloads the dataset url
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "uci_har_dataset.zip")

##Unzips the dataset into a folder called uci_har_dataset
unzip("uci_har_dataset.zip", exdir="uci_har_dataset")



##Reading each file in the folder created
subject_test <- read.table("uci_har_dataset/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = ' ')
subject_train <- read.table("uci_har_dataset/UCI HAR Dataset/train/subject_train.txt",header = FALSE, sep = ' ')
X_test <- read.table("uci_har_dataset/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("uci_har_dataset/UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("uci_har_dataset/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = ' ')
y_train <- read.table("uci_har_dataset/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = ' ')
activity_labels <- read.table("uci_har_dataset/UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("uci_har_dataset/UCI HAR Dataset/features.txt", header = FALSE, sep = ' ') 
features <- as.character(features[,2])
features_info <- read.table("uci_har_dataset/UCI HAR Dataset/features_info.txt", fill = TRUE , header = FALSE) 


##Merging the training datasets 
train <- data.frame(subject_train, y_train, X_train)
names(train) <- c(c('subject', 'activity'), features)

##Merging testing datasets
test <- data.frame(subject_test, y_test, X_test)
names(test) <- c(c('subject', 'activity'), features)


##Question 1. Merging all training and testing datasets
mergedata <- rbind(train, test)



##Question 2. Extracting only mean and standard deviation values from the merged dataset
meansd<- grep("mean|std", features)
dataset <- mergedata[,c(1,2, meansd + 2)]


##Question 3. Use descriptive activity names to name the activities in the dataset created in step 2

activity_labels <- as.character(activity_labels[,2])
dataset$activity <- activity_labels[dataset$activity]


##Question 4. Appropriately label the dataset with descriptive activity names

newnames <- names(dataset)
newnames <- gsub("[(][)]", "", newnames)
newnames <- gsub("-", "_", newnames)
newnames <- gsub("^t", "Time_domain_", newnames)
newnames <- gsub("^f", "Frequency_domain_", newnames)
newnames <- gsub("Acc", "_Accelerometer_", newnames)
newnames <- gsub("Gyro", "_Gyroscope_", newnames)
newnames <- gsub("Mag", "_Magnitude_", newnames)
newnames <- gsub("mean", "Mean", newnames)
newnames <- gsub("std", "Standard_deviation", newnames)
names(dataset) <- newnames


##Question 5. Using dataset from step 4, create a second, independent tidy data set with the average of each variable for 
##each activity and each subject.
data.tidy <- aggregate(dataset[,3:81], by = list(activity = dataset$activity, subject = dataset$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)
