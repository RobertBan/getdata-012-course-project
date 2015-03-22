#######################################################################################################################
## Getting and Cleaning Data
## Course Project
## Robert Ban
## 2015-03-20
#######################################################################################################################
## This script downloads the experiment data archive (if not already present in the working directory)
## from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## and unpacks it.
## 
## Then it reads in raw data collected from sensors in an experiment conducted with accelerometers
## in the Samsung Galaxy S smartphone, details:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## The script applies several transformations to the data loaded:
## 1) Merges training and test data
## 2) Eliminates from the data measurements that are not mean and std
## 3) Labels observations with the types of activities the subjects were performing
## 4) Adds subject IDs to the observations and sets readable names for variables
## 5) Computes average values of each variable for each activity and each subject
## 
## Finally, the script writes out cleaned data into a text file called t_data_set.txt
#######################################################################################################################
library(LaF)
library(ffbase)
library(stringr)
library(dplyr)

## Download the experiment data is not available in the current working directory
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
        dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        dwnlRes <- download.file(dataURL, "getdata-projectfiles-UCI HAR Dataset.zip", mode="wb")
        if (dwnlRes != 0){
                stop("Could not download getdata-projectfiles-UCI HAR Dataset.zip file.")
        }
}
## Unpack the file
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

## Read in activity labels
actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE)


## Read in column labels
columninfo <- read.table("./UCI HAR Dataset/features.txt", sep=" ", header=FALSE)
cols <- tbl_df(columninfo)

## Create index and names for column selection
cols <- filter(cols, !grepl("meanFreq|angle", V2))
cols <- filter(cols, grepl("mean|std", V2))
colnames <- as.vector(cols$V2)
## Reformat column names to make them easier to use in analysis
## e.g. tBodyAcc-mean()-X becomes tBodyAccMeanX
colnames <- str_replace(colnames, "\\(\\)", "")
colnames <- str_replace_all(colnames, "-", "")
colnames <- str_replace_all(colnames, "mean", "Mean")
colnames <- str_replace_all(colnames, "std", "Std")
colindex <- cols$V1
## Read in Y test data (activities)
actTST <- read.table("./UCI HAR Dataset/test/Y_test.txt", header=FALSE)
## Read in Y training data
activities <- read.table("./UCI HAR Dataset/train/Y_train.txt", header=FALSE)
## Put together Y data from training and test sets
activities <- bind_rows(activities, actTST)
## Replace activity IDs with activity labels
activities <- inner_join(activities, actlabels)
activities <- select(activities, Activity = V2)


## Read in subject IDs (test)
subjects_tst <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
## Read in subject IDs (training)
subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
## Put together subject IDs from training and test sets
subjects <- bind_rows(subjects, subjects_tst)
names(subjects) <- "Subject"


## Read in X data (test), use laf_open_fwf to avoid memory issues
tst_laf <- laf_open_fwf("./UCI HAR Dataset/test/X_test.txt", column_widths=rep(16, 561), column_types=rep("numeric", 561))
tst_d_laf <- laf_to_ffdf(tst_laf, nrows=1000)
tst_data <- as.data.frame(tst_d_laf)
## Read in X data (training), use laf_open_fwf to avoid memory issues
tr_laf <- laf_open_fwf("./UCI HAR Dataset/train/X_train.txt", column_widths=rep(16, 561), column_types=rep("numeric", 561))
tr_d_laf <- laf_to_ffdf(tr_laf, nrows=1000)
tr_data <- as.data.frame(tr_d_laf)
## Put together X data from training and test sets
tr_data <- bind_rows(tr_data, tst_data)

## Retain selected measurements only, attach activity names and subjects to observations
tr_data <- select(tr_data, colindex)
names(tr_data) <- colnames
tr_data <- bind_cols(tr_data, activities)
tr_data <- bind_cols(tr_data, subjects)


## Prepare final data set
finald <- tr_data %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
## Write cleaned data frame out
write.table(finald, "t_data_set.txt", row.names=FALSE)