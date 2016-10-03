# Merges the training and the test sets to create one data set.
setwd("test")
subject_test<-read.table("subject_test.txt")
X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
colnames(y_test)<-"activity label"
setwd("..")
features<-read.table("features.txt")
setwd("train")
subject_train<-read.table("subject_train.txt")
X_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")
colnames(y_train)<-"activity label"
colnames(X_train)<-features[,2]
colnames(X_test)<-features[,2]
Data_type<-matrix("test", 2947,1)
colnames(subject_test)<-"subject"
colnames(subject_train)<-"subject"
test<-cbind(subject_test, Data_type,y_test,X_test)
Data_type<-matrix("train", 7352,1)
train<-cbind(subject_train, Data_type, y_train, X_train)
master<-rbind(test, train)
# Extracts only the measurements on the mean and standard deviation for each measurement.
nm<-names(master)
mn<-grep("mean()", nm)
std<-grep("std()", nm)
total<-sort(c(std,mn))
MSMaster<-master[,total]
MSMaster<-cbind(master[,1:3], MSMaster)
# Uses descriptive activity names to name the activities in the data set
setwd("..")
activity_labels<-read.table("activity_labels.txt")
MSMaster$`activity label`= sub(activity_labels[1,1], activity_labels[1,2], MSMaster$`activity label`)
MSMaster$`activity label`= sub(activity_labels[2,1], activity_labels[2,2], MSMaster$`activity label`)
MSMaster$`activity label`= sub(activity_labels[3,1], activity_labels[3,2], MSMaster$`activity label`)
MSMaster$`activity label`= sub(activity_labels[4,1], activity_labels[4,2], MSMaster$`activity label`)
MSMaster$`activity label`= sub(activity_labels[5,1], activity_labels[5,2], MSMaster$`activity label`)
MSMaster$`activity label`= sub(activity_labels[6,1], activity_labels[6,2], MSMaster$`activity label`)
# Appropriately labels the data set with descriptive variable names.
nam<-names(MSMaster)
nam[4:43]<-sub("t", "time series ", nam[4:43])
nam<-sub("f", "FFT ", nam)
nam<-sub("BodyBody", "Body", nam)
names(MSMaster)<-nam
# A second, independent tidy data set with the average of each variable for 
# each activity and each subject.
U<-unique(MSMaster$subject)
MeanMaster<-data.frame(matrix(0,1,82))
colnames(MeanMaster)<-names(MSMaster)
MeanMaster<-MeanMaster[-1,]
for (i in 1:length(U)){
  sub1<-subset(MSMaster, subject==U[i] & `activity label`=="STANDING")
  a1<-t(matrix(colMeans(sub1[4:82])))
  r1<-cbind(sub1[1,1:3], a1)
  colnames(r1)<-names(MSMaster)
  sub2<-subset(MSMaster, subject==U[i] & `activity label`=="WALKING_UPSTAIRS")
  a2<-t(matrix(colMeans(sub2[4:82])))
  r2<-cbind(sub2[1,1:3], a2)
  colnames(r2)<-names(MSMaster)
  sub3<-subset(MSMaster, subject==U[i] & `activity label`=="WALKING_DOWNSTAIRS")
  a3<-t(matrix(colMeans(sub3[4:82])))
  r3<-cbind(sub3[1,1:3], a3)
  colnames(r3)<-names(MSMaster)
  sub4<-subset(MSMaster, subject==U[i] & `activity label`=="SITTING")
  a4<-t(matrix(colMeans(sub4[4:82])))
  r4<-cbind(sub4[1,1:3], a4)
  colnames(r4)<-names(MSMaster)
  sub5<-subset(MSMaster, subject==U[i] & `activity label`=="WALKING")
  a5<-t(matrix(colMeans(sub5[4:82])))
  r5<-cbind(sub5[1,1:3], a5)
  colnames(r5)<-names(MSMaster)
  sub6<-subset(MSMaster, subject==U[i] & `activity label`=="LAYING")
  a6<-t(matrix(colMeans(sub6[4:82])))
  r6<-cbind(sub6[1,1:3], a6)
  colnames(r6)<-names(MSMaster)
  MeanMaster<-rbind(MeanMaster, r1,r2,r3,r4,r5,r6)
}
write.table(MeanMaster, "output.txt")