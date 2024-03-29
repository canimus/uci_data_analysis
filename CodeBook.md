# Code Book

This file includes a brief explanation of the **run_analysis.R** file performs an analysis over the data set provided by the UCI in the area of Human Activity Recognition Using Smartphones Data Set.



> **Notice:** To successfully run this R file an internet connection is required to download the source files from a specific URL

### Structure of file
- Download Files
- Merging Data Sets
- Filtering based on Features
- Adding Meaningful labels
- Writing tidy data set into a CSV file

## Download Files

The first step in the analysis is obtaining the source files for the analysis. These files are available in the following URL.

`https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`

After completing the download from the URL provided the downloaded file is placed in a temporary folder and extracted for analysis. Last step is closing the connection for the open file.

```R
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
unzip(temp)
unlink(temp)
```

## Merging Data Sets

This section incorporates combining the **training** and **test** data into a single data frame. Each of the files in the source data contains metrics, activities and subjects. Subjects represent the people wearing the band or devices, and activities represent the different types of activities measured by the wearable device.

#### Activities:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING


## Filtering based on Features

The following line obtains the list of indexes in the columns that will be used in the `tidy.df` data frame. This line collects the required means and standard deviation columns required in the study.

The `grep` command in R allows the use of regular expressions to match specific strings and obtain the matching conditions in a data frame. One important aspect during the implementation of this filtering routine is the use of scape characters for `(` using the `\` back slash scape character.

```R
features.filtered <- rbind(features[grep("mean\\(", features$V2),], features[grep("std\\(", features$V2),])
```

## Adding Meaningful labels

The main tidy data frame contains only the standard `V#` headers or column names. To assist in the understanding of the data, we will be using the features text file available in the source files to allocate the required header names to the tidy data frame.

Examples of this headers are provided in the originated files but look like:
```R
> as.list(head(names(tidy.df)))
[[1]]
[1] "activity_id"

[[2]]
[1] "tBodyAcc-mean()-X"

[[3]]
[1] "tBodyAcc-mean()-Y"

[[4]]
[1] "tBodyAcc-mean()-Z"

[[5]]
[1] "tGravityAcc-mean()-X"

[[6]]
[1] "tGravityAcc-mean()-Y"
```

Following the principles of tidy data, each observation is in 1 row, and each column contains only 1 value.

## Writing tidy data set into a CSV file

The following line collects the statistics using the `dplyr` package to create summaries per column and grouping based on the activity and the individual. The approach by this operation is to minimise the assignment of variables and handle the summary in a pipeline form with concatenated instructions.

```R
tidy.df.means <- tidy.df %>% group_by(activity_name,subject_id) %>% summarise_each(funs(mean))
# Wriring CSV File
write.csv(tidy.df.means, "tidy_data_table.txt", row.names=FALSE)
```

> **output:**  tidy_data_table.txt
