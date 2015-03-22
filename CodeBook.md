# Getting and Cleaning Data – Course project – Data Dictionary
## Study Design
The raw data were collected from sensors in an experiment conducted with accelerometers in the Samsung Galaxy S smartphone. Details can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The raw data are made up of two data sets (training and test) stored in their respective subdirectories. Each data set is made up of:
- sensor data: X_train.txt and X_test.txt, respectively;
- activity IDs for each observation: Y_train.txt and Y_test.txt, respectively. For each row in X_train.txt there is a corresponding row in Y_train.txt, which contains the activity the subject was performing. Similarly, for each row in X_test.txt there is a corresponding row in Y_test.txt. Hence, the Y_ files can be seen as containing an extra column for each observation, with an activity ID;
- subject IDs for each observation: subject_train.txt and subject_test.txt, respectively. For each row in X_train.txt there is a corresponding row in subject_train.txt, which contains the activity the subject was performing. Similarly, for each row in X_test.txt there is a corresponding row in subject_test.txt. Hence, the subject_ files can be seen as containing an extra column for each observation, with a subject ID;
- common for both data sets is the file features.txt, which contains the names of the columns in files X_train.txt and X_test.txt;
- common for both data sets is the file activity_labels.txt, which contains descriptive labels for the activity IDs in Y_train.txt and Y_test.txt.

## Transformations Applied
The script applies several transformations to the data retrieved from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  
  
1. Merges training and test data (files Y_text.txt and X_test.txt).  
2. Retains measurements on the mean and standard deviation only, i.e. variable names (specified in features.txt) containing "mean" and "std", except mean frequency and angle variables.
3. Labels observations with the types of activities the subjects were performing (labels taken from activity_labels.txt)
4. Adds subject IDs (taken from files Y_text.txt and X_test.txt) to the observations and sets readable names for variables.
5. Computes average values of each variable retained for the final data set, for each activity and each subject.
  
Finally, the script writes out the summarised data into a text file called t_data_set.txt  

## Code Book
The final data set is made of the average values of each variable, for each activity and each subject. The columns are:
- Activity: the label of the activity (e.g. WALKING)
- Subject: the subject ID
The rest of the variables contain the average values (per activity and subject) of the corresponding variables in the raw data set. Minor transformations have been applied to the names in order to make them easier to read and use in analysis scripts.  
E.g.  tBodyAcc-mean()-X  was renamed tBodyAccMeanX
- tBodyAccMeanX
- tBodyAccMeanY
- tBodyAccMeanZ
- tBodyAccStdX
- tBodyAccStdY
- tBodyAccStdZ
- tGravityAccMeanX
- tGravityAccMeanY
- tGravityAccMeanZ
- tGravityAccStdX
- tGravityAccStdY
- tGravityAccStdZ
- tBodyAccJerkMeanX
- tBodyAccJerkMeanY
- tBodyAccJerkMeanZ
- tBodyAccJerkStdX
- tBodyAccJerkStdY
- tBodyAccJerkStdZ
- tBodyGyroMeanX
- tBodyGyroMeanY
- tBodyGyroMeanZ
- tBodyGyroStdX
- tBodyGyroStdY
- tBodyGyroStdZ
- tBodyGyroJerkMeanX
- tBodyGyroJerkMeanY
- tBodyGyroJerkMeanZ
- tBodyGyroJerkStdX
- tBodyGyroJerkStdY
- tBodyGyroJerkStdZ
- tBodyAccMagMean
- tBodyAccMagStd
- tGravityAccMagMean
- tGravityAccMagStd
- tBodyAccJerkMagMean
- tBodyAccJerkMagStd
- tBodyGyroMagMean
- tBodyGyroMagStd
- tBodyGyroJerkMagMean
- tBodyGyroJerkMagStd
- fBodyAccMeanX
- fBodyAccMeanY
- fBodyAccMeanZ
- fBodyAccStdX
- fBodyAccStdY
- fBodyAccStdZ
- fBodyAccJerkMeanX
- fBodyAccJerkMeanY
- fBodyAccJerkMeanZ
- fBodyAccJerkStdX
- fBodyAccJerkStdY
- fBodyAccJerkStdZ
- fBodyGyroMeanX
- fBodyGyroMeanY
- fBodyGyroMeanZ
- fBodyGyroStdX
- fBodyGyroStdY
- fBodyGyroStdZ
- fBodyAccMagMean
- fBodyAccMagStd
- fBodyBodyAccJerkMagMean
- fBodyBodyAccJerkMagStd
- fBodyBodyGyroMagMean
- fBodyBodyGyroMagStd
- fBodyBodyGyroJerkMagMean
- fBodyBodyGyroJerkMagStd