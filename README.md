---
title: "run_analysis"
output: html_document
---

run_analysis tidies data for further analysis from

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data are here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This program assumes that within the working directory, are the unzipped data. Unzip defaults to create a directory "UCI HAR Dataset"

```{r}
dir()
[1] "getdata-projectfiles-UCI HAR Dataset.zip" "run_analysis.html"                       
[3] "run_analysis.md"                          "run_analysis.R"                          
[5] "run_analysis.txt"                         "UCI HAR Dataset"  
```

The end result is a clean dataset as described in the run_analysis_codebook.pdf found in this repository

**Required libraries**

This program requires the following libraries, and does not install them for you

```{r}
library(dplyr)
library(tidyr)
library(data.table)
```

**Process**

1. Read in data from the Samsung data

2. Union the test and training datasets to form a single set (step 1 in assignment)

3. Extract only the data for mean and standard deviations for each measurement (step 2)

4. Tidy data
- I separated out the measurement domain (time vs frequency) and calculation time from step 3 - as the data as reflected meant that column data reflected more than one variable. It's entirely possible that I could have split out names (ie., Acc vs AccJerk), but each of these are still reflective of the same data represented, and so I left them intact.

5. Use descriptive activity names to name the activities in the data set (step 3)

```{r}
#merge in activity names for readability
tidy_activities <- merge(tidy_activities,
                         activity_labels,by.x="activity", by.y="V1") 
```
6. Name columns descriptively (step 4)

```{r}
names(agg_results) <- c("subject","activity","domain","signal","calctype","axis","average")
```

7. Write out results of tidy data set that shoes the average of each variable for each actvity and each subject. (step 5)




