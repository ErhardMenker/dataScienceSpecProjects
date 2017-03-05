#setwd("C:/Data/Analytics_Studies/R/Data_Science_Specialization/Getting&Cleaning_Data/project1")

# PRE-PROCESSING:
if(!dir.exist(./data)){dir.create(./data)}
# read in the file
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="./data/project1.zip")
# unzip the file
unzip("./data/project1.zip", exdir="./data")
# reset the working directory into the unzipped file
setwd("./data/UCI HAR Dataset")

# IMPORT:
# read in the training and test set data
X_TEST <- read.table("./test/X_test.txt")
Y_TEST <- read.table("./test/y_test.txt")
X_TRAIN <- read.table("./train/X_train.txt")
Y_TRAIN <- read.table("./train/y_train.txt")
# read in the labels for each column
COL_NAMES <- read.table("./features.txt", stringsAsFactors=FALSE)
# read in the labels for each row
ROW_NAMES <- read.table("./activity_labels.txt", stringsAsFactors=FALSE)

# MERGE:
# merge the labels of each set (Y) to the values (X)
TRAIN <- cbind(Y_TRAIN, X_TRAIN)
TEST <- cbind(Y_TEST, X_TEST)
# merge the training and test sets
DF <- rbind(TRAIN, TEST)

# RENAME:
# rename the column names
names(DF)[1] <- "activity"
names(DF)[2:ncol(DF)] <- tolower(COL_NAMES$V2)
# rename the row identifiers
DF$activity <- sapply(DF$activity, 
                      function(x) gsub("_", " ", tolower(ROW_NAMES[match(x, ROW_NAMES$V1), 2])))

# SUBSET:
# recreate the DF with only the columns of means and standard deviations
DF_ALL <- cbind(activity=DF$activity, DF[, grepl("mean|std", names(DF))])

# AGGREGATE:
# create only as many rows as there are unique activities
DF_SMRY <- DF_ALL[1:length(unique(DF$activity)), ]

# set all these rows equal to NAs
for(row in 1:length(unique(DF_ALL$activity))) {
    DF_SMRY[row, ] <- rep(NA, time=ncol(DF_SMRY))
}

# fill in rows with the proper values
row <- 1
split_by_activity <- split(DF_ALL, DF_ALL$activity)
for(entry in split_by_activity) {
    # set the first col entry equal to the activity name
    DF_SMRY[row, 1] <- names(split_by_activity[row])
    # take mean of all numeric DF columns, put in respective column of current activity row
    for(col in 2:ncol(DF_ALL)) {
        DF_SMRY[row, col] <- mean(entry[, col])
    }
    row <- row + 1
}

# CLEAN UP:
# clear everything from the environment except the initial and summary dataframes
rm(list=ls()[!(ls() %in% c("DF_ALL", "DF_SMRY"))])










