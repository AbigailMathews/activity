
## This script assembles a large data set from the Human Activity 
## Recognition Using Smartphones Data Set, corrects improperly labelled columns,
## applies labels to activities represented in the measurement data, chooses
## columns relating to mean and standard deviation values in the data, and 
## finally writes a new, tidy data set representing the average values of the 
## measurements obtained for each subject performing each activity.


# Download, unzip the appropriate data. 
wd <- "C:/r"

setwd(wd)
if(!file.exists("data")){
  dir.create("data")
}

if(!file.exists("./data/UCI_HAR.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = "./data/UCI_HAR.zip", method="auto")
}

if(!file.exists("./data/x_test.txt")){
  unzip("./data/UCI_HAR.zip", junkpaths=TRUE, exdir="./data")
}

# Read the pertinent files containing the Activities performed (Y), the
# Subject involved (Subject), and the measurement files (X -- 561 columns)
# into R, then piece them together into one large dataframe.

Xtest <- read.table("./data/X_test.txt")
Ytest <- read.table("./data/Y_test.txt")
Xtrain <- read.table("./data/X_train.txt")
Ytrain <- read.table("./data/Y_train.txt")
Strain <- read.table("./data/subject_train.txt")
Stest <- read.table("./data/subject_test.txt")

test <- cbind(Stest, Ytest, Xtest)
train <- cbind(Strain, Ytrain, Xtrain)

# Attach the appropriate labels to the columns

features <- readLines("data/features.txt")
features <- gsub("^[0-9]* ", "", features)
label <- c("Subject", "Activity", as.vector(features))

full <- rbind(test, train)
names(full) <- label

# Select only those feature columns that pertain to Mean and Standard
# Deviation

goodfeatures <- grep("mean|std", names(full))
msfull <- full[,c(1,2,goodfeatures)]

# Do a bunch of substitutions to the names values of msfull to make
# columns names more readable and get rid of special characters

names(msfull) <- sub("\\()","",names(msfull),)
names(msfull) <- sub("^t","Time",names(msfull),)
names(msfull) <- sub("^f","Frequency",names(msfull),)
names(msfull) <- sub("-mean","-Mean",names(msfull),)
names(msfull) <- sub("-std","-StdDev",names(msfull),)
names(msfull) <- sub("Acc","Accelerometer",names(msfull),)
names(msfull) <- sub("Gyro","Gyroscope",names(msfull),)
names(msfull) <- sub("Mag","Magnitude",names(msfull),)
names(msfull) <- sub("BodyBody","Body",names(msfull),)


# Aggregate the data by both Activity and Subject Name. Note this occurs before
# the proper Activity names are assigned so as not to throw warnings.

tidydata <- aggregate(msfull, by=list(msfull$Subject, msfull$Activity), mean)

# Get rid of the two extraneous columns added by the aggregate function

tidydata <- subset(tidydata, select = -c(1,2))

# Substitute the correct Activity labels in the Activity column, replacing
# the numeric values with descriptive terms.

activity <- as.factor(c("Walking", "WalkingUp", "WalkingDown", 
                        "Sitting", "Standing", "Laying"))
tidydata$Activity <- activity[tidydata$Activity]

# Finally, write the new tidy data set out as a text file.

write.table(tidydata, file="activity.txt", row.names=FALSE)