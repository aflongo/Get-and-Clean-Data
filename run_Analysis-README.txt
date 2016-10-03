The script run_analysis.R works with the Samsung dataset to output a tidy dataset with the average of each variable for each activity and each subject.
Here, the directory must be initially set to "UCI HAR Dataset". 
There are several files describing the datasets within the "UCI HAR Dataset" directory.
These files were used to create a master dataset that where the test and training data were combined into one dataframe.
Descriptions of the activity were added for each observation. 
The variable names were made to be a little more descriptive.
Finally, the data was broken down by test subject and activity type.
The mean values for each test subject and activity type were determined with colMeans.
The data was then reconstructed into a dataframe. 