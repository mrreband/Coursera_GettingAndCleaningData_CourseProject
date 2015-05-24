# Course Project - Getting And Cleaning Data
Course project repository for Coursera - Getting and Cleaning Data

## Project Instructions
> You should create one R script called run_analysis.R that does the following.
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names.
> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Packages Used
*require(plyr) - *ddply*
*require(dplyr) - *select*

##Reading Data
Assume the data has been zipped into its own folder, ".\UCI HAR Dataset"

2 metadata tables: 

Data Table | Dimensions
---------- | ----------
features | [561, 2]
activity_labels | [6, 2]

6 case data tables: 
Data Table | Dimensions
---------- | ----------
subject_train | [7352, 1]
x_train | [7352, 561]
y_train | [7352, 1]
subject_test | [2947, 1]
x_test | [2947, 1]
y_test | [2947, 1]

Read metadata first (features, activity_labels)
features data is used to assign column names when reading in both x-data files (x_train, x_test)
*i.e. *read.table(..., col.names=features$feature)*

all other data sets get col.names manually assigned when reading
*i.e. *read.table(..., col.names=c("id","activity"))*


##Merging Data
merge training data with test (row bind for vertical concatenation)
merge subject_data, x_data, y_data (column bind for horizontal concatenation)


##Extracting Mean and Standard Deviation Variables

Make a list of columns to keep: 
*all columns with "mean" or "std" in the name, 
*exact match on activity_id - ^activity_id$
*exact match on subject_id - ^subject_id$

Filter out all other columns not in our keeper list

## Merging Descriptive Activity Names
merge in activity labels, 
Join data$activity_id with activity_labels$id
remove activity_id column -- no longer needed

## Descriptive variable names
Descriptive names were assigned according to features when reading the data in.  
Clean them so that they follow the recommendations outlined in "Editing Text Variables" lecture: 
*all lowercase when possible
*not duplicated
*not have underscores or whitespaces
*Variable values should be made into factor variables when applicable
*Variable values should be descriptive (use TRUE/FALSE instead of 0/1, MALE/FEMALE, etc)

## Independent Tidy Data set with the average of each variable for each activity and each subject.
step5data <- ddply(data, .(subjectid, activity), colwise(mean))
write.table(step5data, "step5_tidy_data.txt", row.name=FALSE)