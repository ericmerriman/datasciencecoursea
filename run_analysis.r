setwd("~/R")
library(stringr)
library(plyr)

read.table("y_train.txt")->zy
read.table("x_train.txt")->z
read.table("x_test.txt")->zz
read.table("y_test.txt")->zzy
read.table("subject_train.txt")->zyx
read.table("subject_test.txt")->zyxx
read.table("activity_labels.txt")->m
colnames(m)<-c("Activity","Desc")
tstst<-cbind(zyxx,zzy,zz)
trnst<-cbind(zyx,zy,z)
## STEP 1
totst<-rbind(tstst,trnst)
read.table("features.txt",sep = " ")->ftr
ftrr<-cbind(as.numeric(ftr[,1]),as.character(ftr[,2]))
colnames(totst)<-c("Subject","Activity",ftrr[,2])
## STEP 2
join(m,totst,by = "Activity")->j
str_detect(names(j),"Mean")|str_detect(names(j),"mean")|str_detect(names(j),"std")->v
## STEP 3
cbind(j[,3],j[,2],j[,which(v)])->msmtcol
## STEP 4
fnldst<-data.frame()
fnlfnldst<-data.frame()
names(msmtcol)<-c("Subject","Activity",names(msmtcol[3:88]))
split(msmtcol,msmtcol$Subject)->xx
for (i in 1:30)
{
  split(xx[[i]],xx[[i]]$Activity)->kk
  for(j in 1:6)
  {
  fnldst<-rbind(fnldst,cbind(kk[[j]][1,1],kk[[j]][1,2],sapply(kk[[j]][,3:88],mean)))
  }
 fnlfnldst<- rbind(fnlfnldst,fnldst)
}
colnames(fnlfnldst)<-c("Subject","Activity","Value")
join(m,fnlfnldst,by = "Activity")->finalDataSet
paste("Mean of ",rownames(fnlfnldst))head(->rownames(finalDataSet)
