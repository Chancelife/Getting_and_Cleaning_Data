##Variables:
####Reading data
+train.x, train.y, train.subject, test.x, test.y, test.subject are data readed from .txt file.
####Merge the training and the test sets to create one data set.
+trainData is merged by train.subject, train.y, train.x
+testData is merged by test.subject, test.y, test.x
+CData is merged by trainData and testData shows above
+subjects is from train.subject, test.subject but I didn't use it eventually
####Extract only the measurements on the mean and standard deviation for each measurement. 
+features read from features.txt
+findexes are indexes from features which its name include "mean or standard deviation(std)"
####Use descriptive activity names to name the activities in the data set
+activityName from file activity_labels.txt, includes labels of activities.
####From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
+AverageData is the subset of CData, use as final output
