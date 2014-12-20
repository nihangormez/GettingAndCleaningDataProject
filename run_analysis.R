
# read acivity labels
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels)=c("Activity_Code","Activity")
# read features
features<-read.table("./UCI HAR Dataset/features.txt")

## Read test data :: 9 subjects
# subject identifier for test group
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test)=c("SubjectNo")
# features for test group data 2947x561
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(X_test)=features[,2]
X_testS<-X_test[,grepl("mean()",names(X_test))|grepl("std()",names(X_test))]
# activity code for test group data
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
colnames(y_test)=c("ActivityCode")
y_test<-merge(activity_labels,y_test, by.x="Activity_Code", by.y="ActivityCode", all=TRUE)
testdata<-cbind(y_test, subject_test, X_testS)

## Read train data :: 21 subject
# subject identifier for test group
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train)=c("SubjectNo")
# features for test group data 2947x561
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(X_train)=features[,2]
X_trainS<-X_train[,grepl("mean()",names(X_train))|grepl("std()",names(X_train))]
# activity code for test group data
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
colnames(y_train)=c("ActivityCode")
y_train<-merge(activity_labels,y_train, by.x="Activity_Code", by.y="ActivityCode", all=TRUE)
traindata<-cbind(y_train, subject_train, X_trainS)
# merge train and test data
mergeData<-rbind(testdata,traindata)

# create clean data
colsIncl<-grepl("mean()",names(mergeData))
colsIncl[2:3]<-TRUE
cleandata<-mergeData[,colsIncl]
write.table(cleandata,"cleandata.txt",row.name=FALSE)