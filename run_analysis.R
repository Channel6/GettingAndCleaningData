##########################################################
##		Coursera Data Science			##
##		Getting and Cleaning Data		##
##		Week 4 - Final project			##
##		Public Domain - 2017			##
##########################################################

## STEP 0: load required packages

# Init packages and variables
library(dplyr)
X_train <- X_test <- y_train <- y_test <- NULL
subject_train <- subject_test <- NULL

## STEP 1: Merge the training and the test sets to create one data set.
# read into data frames
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")

# unify name, and clean subject files headers
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"


