##########################################################
##		Coursera Data Science			##
##		Getting and Cleaning Data		##
##		Week 4 - Final project			##
##		Public Domain - 2017			##
##########################################################

## STEP 0: load required packages

# Init packages and variables
library("dplyr", "tidyr", "plyr")
X_train <- X_test <- y_train <- y_test <- NULL
subject_train <- subject_test <- NULL

# Get required files
datadir <- "./data"
if(!file.exists(datadir)){
	dir.create(datadir)
}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(
	url,
	destfile = paste(datadir, "/dataset.zip", sep=""),
	method = "wget",
	quiet = TRUE
)
unzip(
	zipfile = paste(datadir, "/dataset.zip", sep=""),
	exdir = datadir
)
datafiles <- file.path(datadir, "UCI HAR Dataset")
files <- list.files(datafiles, recursive = TRUE)	

## STEP 1: Merge the training and the test sets to create one data set.
# Read into data frames
subject_train <- read.table(
	file.path(
		datafiles,
		"train",
		"subject_train.txt"
	),
	header = FALSE
)
subject_test <- read.table(
	file.path(
		datafiles,
		"test",
		"subject_test.txt"
	),
	header = FALSE
)
X_train <- read.table(
	file.path(
		datafiles,
		"train",
		"X_train.txt"
	),
	header = FALSE
)
X_test <- read.table(
	file.path(
		datafiles,
		"test",
		"X_test.txt"
	),
	header = FALSE
)
Y_train <- read.table(
	file.path(
		datafiles,
		"train",
		"y_train.txt"
	),
	header = FALSE
)
Y_test <- read.table(
	file.path(
		datafiles,
		"test",
		"y_test.txt"
	),
	header = FALSE
)
feature_test <- read.table(
	file.path(
		datafiles,
		"test",
		"X_test.txt"
	),
	header = FALSE
)
feature_train <- read.table(
	file.path(
		datafiles,
		"train",
		"X_train.txt"
	),
	header = FALSE
)

# Concat data tables by rows
subject <- rbind(subject_train, subject_test)
activity <- rbind(Y_train, Y_test)
features <- rbind(X_train, X_test)

# Add column names for measurement files
featurenames <- read.table(file.path(datafiles, "features.txt"), header = FALSE)

# Set names to variables
names(subject) <- c("subject")
names(activity) <- c("activity")
names(features) <- featurenames$V2

# Merge columns, create a master frame
combined <- cbind(subject, activity)
Data <- cbind(features, combined)


## STEP 2: Extract only the measurements on the mean and standard deviation
## 	of each measurement
# Get appropriate column names
subfeaturenames <- featurenames$V2[grep("mean\\(\\)|std\\(\\)", featurenames$V2)]
# Subset data frame by above subfeaturenames
selectnames <- c(
	as.character(subfeaturenames),
	"subject",
	"activity"
)
Data <- subset(
	Data,
	select = selectnames
)

## STEP 3: Use descriptive activity names to name the activities in the data set
# read activity names
activitylabels <- read.table(
	file.path(
		datafiles,
		"activity_labels.txt"
	),
	header = FALSE
)

## STEP 4: Appropriately label the data set with descriptive variable names
betternames <- list()
betternames <- c(betternames,
	list(c("^t", "time")),
	list(c("^f", "frequency")),
	list(c("Acc", "Accelerometer")),
	list(c("Gyro", "Gyroscope")),
	list(c("Mag", "Magnitude")),
	list(c("BodyBody", "Body"))
)
for(i in 1:length(betternames)){
	names(Data) <- gsub(betternames[[i]][1], betternames[[i]][2], names(Data))
}

## STEP 5: Create a second, independent tidy data set with the average of each variable
##	for each activity and each subject.
Data2 <- aggregate(. ~subject + activity, Data, mean)
Data2 <- Data2[
	order(
		Data2$subject,
		Data2$activity
	),
]
write.table(
	Data2,
	file = "tidydata.txt",
	row.name = FALSE
)
