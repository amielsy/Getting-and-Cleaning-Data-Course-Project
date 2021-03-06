# Code Book

This code book provides additional information about the variables, data and transformations used in this project.
[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.  
Source: (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

###Requirements for run_analysis.R

1.Merges the training and the test sets to create one data set.  
2.Extracts only the measurements on the mean and standard deviation for each measurement.  
3.Uses descriptive activity names to name the activities in the data set.    
4.Appropriately labels the data set with descriptive variable names.  
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

###Transformations done on original dataset

Extract wanted features from feature.txt. We only want the variables with mean or standard deviation.  
Combine the datasets:
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt
into 1 dataset. Subject files make up the subject column. Y files make up the activity column. X files make up the columns from the wanted features from feature.txt.

Change the activity column from numbers to its appropriate activity using activity_labels.txt.  
Then, appropriately label the data set with descriptive activity names. I removed the parentheses and dash characters from the variables and changed the starting t with time and starting f with freq(frequency). For example:  
tBodyAcc-mean()-X -> timeBodyAccmeanX  
fBodyAcc-std()-X -> freqBodyAccstdX

Finally, create another independent tidy data set with the average of each variable for each activity and each subject. Then print this to tiny.txt.

###Variables

Subject - ID of the subject. Values from 1-30  
Activity - possible values are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  
features (columns 3-81) - Features are extracted from measurements of the acceloremeter and gyroscope from the subject doing the activities. Features are normalized and bounded within [-1,1]. 
