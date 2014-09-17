---
title: "CodeBook"
output: html_document
---

This Code Book provides information about the 'Human Activity Recognition Using Smartphones Data Set' both by collecting relevant material published with the original data set, and by providing information about transformations made to the data to create a tidy data set reporting the average mean and standard deviation values for each Subject/Activity pair.

The original data set was published as:

**Human Activity Recognition Using Smartphones Dataset -** *Version 1.0*

>Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
>Smartlab - Non Linear Complex Systems Laboratory  
>DITEN - Università degli Studi di Genova.  
>Via Opera Pia 11A, I-16145, Genoa, Italy.  
>activityrecognition@smartlab.ws  
>www.smartlab.ws  


The full original downloadable data set, including many helpful descriptions of the data, is available here: [UCI_HAR.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
##Background

The human activity recognition data was collected from a group of 30 volunteers within an age bracket of 19-48 years. Each subject performed six activities:

- Walking
- WalkingUp
- WalkingDown 
- Sitting
- Standing
- Laying

These activities were performed while wearing the Samsung Galaxy S II smartphone on the waist. Each activity performed is labelled with the appropriate activity label.

##Original Data Set Processing

*This section derives (with modifications, as appropriate) from the document* [Data Set Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) *and in the* **README.txt** *and* **features_info.txt** *included in the original zip file.*

The study authors describe the collection and processing of their measurements:

Using the smartphone's embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 

###Features

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals TimeAccelerometer-XYZ and TimeGyroscope-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAccelerometer-XYZ and TimeGravityAccelerometer-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccelerometerJerk-XYZ and TimeBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccelerometerMagnitude, TimeGravityAccelerometerMagnitude, TimeBodyAccelerometerJerkMagnitude, TimeBodyGyroscopeMagnitude, TimeBodyGyroscopeJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FrequencyBodyAccelerometer-XYZ, FrequencyBodyAccelerometerJerk-XYZ, FrequencyBodyGyroscope-XYZ, FrequencyBodyAccelerometerJerkMagnitude, FrequencyBodyGyroscopeMagnitude, FrequencyBodyGyroscopeJerkMagnitude. 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

For each of these signal variables, both a Mean and Standard Deviation measurement is recorded. 

##Feature Names as they Appear in Tidy Data Set:

- Subject : This is the subject code 1-30
- Activity : One of the 6 Activity Labels listed above (Walking, WalkingUp, etc.)

The feature variables, produced as described above:  

- TimeBodyAccelerometer-XYZ
- TimeGravityAccelerometer-XYZ
- TimeBodyAccelerometerJerk-XYZ
- TimeBodyGyroscope-XYZ
- TimeBodyGyroscopeJerk-XYZ
- TimeBodyAccelerometerMagnitude
- TimeGravityAccelerometerMagnitude
- TimeBodyAccelerometerJerkMagnitude
- TimeBodyGyroscopeMagnitude
- TimeBodyGyroscopeJerkMagnitude
- FrequencyBodyAccelerometer-XYZ !
- FrequencyBodyAccelerometerJerk-XYZ !
- FrequencyBodyGyroscope-XYZ !
- FrequencyBodyAccelerometerMagnitude !
- FrequencyBodyAccelerometerJerkMagnitude !
- FrequencyBodyGyroscopeMagnitude !
- FrequencyBodyGyroscopeJerkMagnitude !

For any entry that reads -XYZ at the end, there are actually three separate columns, one for each direction - X, Y and Z. So these 17 types of generic features actually represent 33 separate features.

For each of the 33 features, -Mean (Mean value) and -StdDev (Standard deviation) are reported. In addition, for those features annotated with a '!', a -MeanFreq value is reported, which may be considered extraneous (see note below in section entitled 'Choosing Only Columns Pertaining to Mean and Standard Deviation')

These features represent a set of 79 columns, which along with our Subject and Activity columns, comprise the full dataset.

In all cases, **features are normalized and bounded within [-1,1].** For this reason, there are no units associated with the readings.

##Notes on Transformations Applied to create this Data Set

The six original data files representing the Subject(S), the Activity(Y), and the Measurement(X) data for both the Test and Train sets were combined into a single data set, and labelled with the appropriate column variable names and activity names.

I regret that in the attempt to make column names more accessible, some of these names became quite long. The use of CamelCase may also be somewhat distracting, however, it seemed the only reasonable alternative in this situation.

After the names column and activity names were correctly assigned, I pulled out just those columns pertaining to the mean or standard deviation measurements in preparation for creating the final tidy data set.

###Assigning Descriptive Values to Activities:

Rather than using the merge method of assigning descriptive values to the Activity column, which threatens to reorder (scramble) the data, I played it safe and used a simple subset, manually inputting the desired activity label into a factor upon which I could subset. Since there were only six values to consider, this was not too unwieldy.

###Choosing Only Columns Pertaining to Mean and Standard Deviation:

There are several ways of choosing these columns, but I decided to select all possible columns that included the term 'mean' or 'std', even though this may result in an initial dataframe that is slightly larger than is necessary for any subsequent analysis. As an example, it is likely the measurements that fit the -MeanFreq pattern are not truly relevant here, since these might be considered measurements of frequency, rather than mean values. Here I feel that while it is usually a simple matter to discard extraneous data further down the line, it can be challenging to reconstruct discarded data. So here I err on the side of including some extraneous columns.

##Final Aggregation and File Output

When the cleaned, large data set is aggregated by computing the average value of the measurements for each Subject/Activity pair, the resultant data set comprises 180 observations of the 81 variables outlined above. This is represented in the file **activity.txt**.

##Original Project Information

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
