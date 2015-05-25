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


Columns in x-data to keep: 
* all columns with "mean" or "std" in the name, 
* exact match on activity_id - ^activity_id$
* exact match on subject_id - ^subject_id$
