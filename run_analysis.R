library(dplyr)
library(tidyr)
library(data.table)

#read in datasets
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")

#read in labels and features
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#read in activities
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")

#apply subject information for grouping later
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")

#union test and training datasets
t_data <- rbind(X_test,X_train)
t_activities <- rbind(y_test,y_train)
t_subject <- rbind(test_subjects, train_subjects)

#add labels to dataset
names(t_data) <- features[,2]

#get just the columns required
measure_extract <- t_data[(grep(("mean|std"),colnames(t_data)))]
measure_extract <- measure_extract[, -grep("Freq", names(measure_extract))]

#add subject information to prepare for group
t_union_group_activities <- mutate(measure_extract,t_subject[,1])
t_union_group_activities <- mutate(t_union_group_activities,t_activities[,1])

#tidy
tidy_activities <- gather(t_union_group_activities,
                      "measurement_untidy","value",1:66)

names(tidy_activities) <- c("subject","activity",
                        "measurement_untidy","value")

tidy_activities <- tidy_activities %>% 
  separate(measurement_untidy, 
           c("type","function","axis"), sep="-")

tidy_activities <- tidy_activities %>% 
  separate(type, 
           c("domain","signal"), sep=1)

#merge in activity names for readability
tidy_activities <- merge(tidy_activities,
                         activity_labels,by.x="activity", by.y="V1") 
tidy_activities<- tidy_activities[,c(2,8,3,4,5,6,7)]
names(tidy_activities) <- c("subject","activity","domain","signal","function","axis","value")

#group and avg to get new dataset
agg_results <- DT[,mean(value),
               by = c("subject","activity","domain","signal","function","axis")]
names(agg_results) <- c("subject","activity","domain","signal","calctype","axis","average")
agg_results <- agg_results[order(subject,activity,-domain,signal,axis,calctype),]

#write out dataset
write.table(agg_results,file="run_analysis.txt",row.names=FALSE)
