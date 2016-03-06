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

The end result is a clean dataset as described in the run_analysis_codebook.txt found in this repository

**Required libraries**

This program requires the following libraries, and does not install them for you

```{r}
library(dplyr)
library(tidyr)
library(data.table)
```
