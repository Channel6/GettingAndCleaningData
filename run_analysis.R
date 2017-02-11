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

## STEP 1: Merge the training and the test sets to create one data set.
# Read into data frames
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
Y_train <- read.table("y_train.txt")
Y_test <- read.table("y_test.txt")

# Unify name, and clean subject files headers
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"

# Add column names for measurement files
featurenames <- read.table("features.txt")
names(X_train) <- featurenames$V2
names(X_test) <- featurenames$V2

# Get activity levels
activity_labels <- read.table("activity_labels.txt")

# Combine files into one dataset
train <- cbind(subject_train, Y_train, X_train)
test <- cbind(subject_test, Y_test, X_test)
combined <- rbind(train, test)

## STEP 2: Extract only the measurements on the mean and standard deviation
## 	of each measurement

# Determine which columns contain mean() or std()
statcolumns <- grepl("mean\\(\\)", names(combined)) || grepl("std\\(\\)", names(combined))

# Keep the subjectID and activity columns
statcolumns[1:2] <- TRUE

# Clean out irrelevant columns
combined <- combined[, statcolumns]

## STEP 3: Use descriptive activity names to name the activities
##	in the data set.
## STEP 4: Appropriately label the data set with descriptive
##	activity names.

# Convert the activity column from integer to factor
combined$activity <- factor(
			combined$activity,
			labels=c(
				"Walking",
				"Walking Upstairs",
				"Walking Downstairs",
				"Sitting",
				"Standing",
				"Laying"
				)
)


## STEP 5: Create a second, independent tidy data set with the
##	average of each variable for each activity and each subject.

# Create the tidy data set
melted <- melt(
		combined,
		id=c(
			"subjectID",
			"activity"
		)
)

tidy <- dcast(
		melted,
		subjectID+activity ~ variable,
		mean
)

# write the tidy data set to a file
write.csv(tidy, "tidy.csv", row.names=FALSE)
