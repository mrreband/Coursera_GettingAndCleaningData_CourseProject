# You should create one R script called run_analysis.R that does the following.
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
require(plyr)
require(dplyr)

#############################################################
#read metadata
features <- read.table("features.txt", sep=" ", header=FALSE, col.names=c("id","feature"))
activity_labels <- read.table("activity_labels.txt", sep=" ", header=FALSE, col.names=c("id","activity"))

#read training data
subject_train <- read.table("train/subject_train.txt",header=FALSE, col.names="subject_id")
x_train <- read.table("train/X_train.txt",header=FALSE, col.names=features$feature)
y_train <- read.table("train/Y_train.txt",header=FALSE, col.names="activity_id")

#read test data
subject_test <- read.table("test/subject_test.txt",header=FALSE, col.names="subject_id")
x_test <- read.table("test/X_test.txt",header=FALSE, col.names=features$feature)
y_test <- read.table("test/Y_test.txt",header=FALSE, col.names="activity_id")

#############################################################
#merge training data with test (row bind for vertical concatenation)
x_data <- rbind(x_test, x_train)
y_data <- rbind(y_test, y_train)
subject_data <- rbind(subject_test,subject_train)

#merge subject_data, x_data, y_data (column bind for horizontal concatenation)
data <- cbind(subject_data, x_data, y_data)

#############################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

#make a list of columns to keep -- all columns with "mean" or "std" in the name, or exact matches on "activity_id" and "subject_id"
keeperCols <- grep("^activity_id$|^subject_id$|mean()|std()", names(data))

#filter out all other columns
data <- data[,keeperCols]

#############################################################
# 3. Uses descriptive activity names to name the activities in the data set

#merge in activity labels, join on y-data
data <- merge(data,activity_labels,by.x="activity_id",by.y="id")

#remove activity_id -- no longer needed
data <- select(data,-activity_id)

#############################################################
# 4. Appropriately labels the data set with descriptive variable names.

#all lowercase when possible
names(data) <- tolower(names(data))

#descriptive
#(names were assigned according to features when reading the data in)

#not duplicated
#make sure no trues are returned from here: count(duplicated(names(data)))

#not have underscores or whitespaces
names(data) <- make.names(names(data), allow_=FALSE)
names(data) <- gsub("\\.","",names(data))

#Should be made into factor variables when applicable
#Should be descriptive (use TRUE/FALSE instead of 0/1, MALE/FEMALE, etc)


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# step5data <- ddply(data, .(subjectid, activity), colwise(mean))
# write.table(step5data, "step5_tidy_data.txt", row.name=FALSE)
