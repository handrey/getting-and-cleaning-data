This code is inteded to perform analysis on a data set
provided that describes measurements from a smartphone.

This script first creates a vector containing the variables names
used in the data_set that join both train and test sets. To make 
the names more readable, regular expressions are used to exclude
some features from them

The next step is to read the y_train.txt and subject_train files
in order to creat a data frame that contains the number of activity 
and the subject that performed that task. In addition, the variable
measures_train is used to store the data from X_train.txt that 
contain all the measurements from the train set. Variable train_set
put everything together from train data.

The same thing described above is applied to the test set, that includes
all measurements from test.

Variable data_set is created to put together measurements from both test
and train set. Data_set is modificated to store only columns with mean and
std measurements.

The next step substitute the number of activity by its name.

At last, statistics is created to store the mean of each measurement
column from data_set variable.