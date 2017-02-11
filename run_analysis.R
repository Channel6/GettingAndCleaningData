##########################################################
##		Coursera Data Science			##
##		Getting and Cleaning Data		##
##		Week 4 - Final project			##
##		Public Domain - 2017			##
##########################################################

## STEP 0: load required packages

# Init packages and variables
library(dplyr, tidyr, data.table)
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
subject_train <- read.table(file.path(datafiles, "train", "subject_train.txt"), header = FALSE)
subject_test <- read.table(file.path(datafiles, "test", "subject_test.txt"), header = FALSE)
X_train <- read.table(file.path(datafiles, "train", "X_train.txt"), header = FALSE)
X_test <- read.table(file.path(datafiles, "test", "X_test.txt"), header = FALSE)
Y_train <- read.table(file.path(datafiles, "train", "y_train.txt"), header = FALSE)
Y_test <- read.table(file.path(datafiles, "test", "y_test.txt"), header = FALSE)
feature_test <- read.table(file.path(datafiles, "test", "X_test.txt"), header = FALSE)
feature_train <- read.table(file.path(datafiles, "train", "X_train.txt"), header = FALSE)

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


