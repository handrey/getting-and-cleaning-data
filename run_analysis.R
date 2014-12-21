library(dplyr)

#creating a vector of features names
features_df <- tbl_df(read.table("./features.txt", col.names = c("Id", "feature_Name")))

features_df <- select(features_df, feature_Name)
features_vec <- gsub("[[:punct:]]","",features_df$feature_Name)
features_vec <- gsub("[[:digit:]]","",features_vec)
features_vec <- gsub("\\.+","_",features_vec)

########EXTRACTING TRAIN SET############

#reading activities table from train
activity_train <- read.table("./train/y_train.txt", col.names = "activity")

#reading subjects table from train
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")

#putting coluumn names corresponding to each measure 
measures_train <- read.table("./train/X_train.txt", col.names = features_vec)

#creating a train_set putting altogether
train_set <- mutate(measures_train, activity = activity_train$activity, subject = subject_train$subject)
rm("activity_train")
rm("measures_train")

########EXTRACTING TEST SET############

#reading activities table from test
activity_test <- read.table("./test/y_test.txt", col.names = "activity")

#reading subjects table from test
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")

#putting coluumn names corresponding to each measure 
measures_test <- read.table("./test/X_test.txt", col.names = features_vec)
rm("features_vec")

#creating a test_set putting altogether
test_set <- mutate(measures_test, activity = activity_test$activity, subject = subject_test$subject)
rm("activity_test")
rm("measures_test")

#putting both dataset together
data_set <- rbind(train_set, test_set)

#extracting columns
data_set <- select(data_set, subject, activity, contains("mean"), contains("std"))

#labeling activities names
data_set$activity[data_set$activity == 1] <- "WALKING"
data_set$activity[data_set$activity == 2] <- "WALKING_UPSTAIRS"
data_set$activity[data_set$activity == 3] <- "WALKING_DOWNSTAIRS"
data_set$activity[data_set$activity == 4] <- "SITTING"
data_set$activity[data_set$activity == 5] <- "STANDING"
data_set$activity[data_set$activity == 6] <- "LAYING"


data_set <- tbl_df(data_set)

#creating the second data set
statistics <- group_by(data_set, activity, subject)
statistics <- summarise_each(statistics, funs(mean), tBodyAccmeanX:fBodyBodyGyroJerkMagstd)
