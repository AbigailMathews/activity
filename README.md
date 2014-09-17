
This project involves wearable computing data, namely data collected using the accelerometers from the Samsung Galaxy S smartphone. The ultimate intention of the data collection project is to deduce which sorts of measurements on the smartphone accelerometer correspond to different activities, so that users interested in tracking their exercise and fitness will be better able to track their activity.

###Files Associated With this Project:

The R script **run_Analysis.R** obtains and manipulates the Activity data in order
to produce a tidy data set upon which subsequent analysis can be based.

The output of this script is supplied in the file **activity.txt** 

Further information about the columnar values in the tidy dataset as well as details about data transformations performed is available in the file **CodeBook.md**

###Using the Script

run_Analysis.R does not depend on the user having previously downloaded or unzipped any data. However, because different systems may behave differently, it is possible that a user might find that he or she must manually download and/or extract files into a directory called 'data' in order to proceed.

If a manual download is required, the pertinent source is: 
[UCI_HAR.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The run_Analysis script currently assumes that a working directory c:\\r exists on the user's hard disk. If one does not exist, the user may either create one, or change the directory assignment on the second line of the script to reflect the preferred directory destination.

###run_analysis.R and its Output

The run\_analysis.R script take as input the files from the publicly available data set containing data on:  
- Activity(Y)  
- Subject(S)  
- Measurements(X)  
These data initial consist of 6 files: 'Test' and 'Train', with an X, Y and S file for each. These files are read in to R and combined to create a large dataframe containing the full collection of measurements.  

The way these files fit together has been usefully diagrammed by David Hood:
![Diagram of File Fit](https://coursera-forum-screenshots.s3.amazonaws.com/ab/a2776024af11e4a69d5576f8bc8459/Slide2.png)   
[David Hood's Helpful FAQ](https://class.coursera.org/getdata-007/forum/thread?thread_id=49)  

The data is subset to contain only those columns that pertain to mean or standard deviation. After this, run\_analysis performs some cleaning to make column names more accessible, and also assigns meaningful labels to each activity.  

Finally, the data is aggregated, so that there is one observation for each Subject/Activity pair which represents the average value of all measurements associated with this pair. The resulting data set is a managable 180 observations of 81 variables. The final tidy data set is written out as **activity.txt**
