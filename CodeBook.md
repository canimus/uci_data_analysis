# Code Book

This file includes a brief explanation of the **run_analysis.R** file performs an analysis over the data set provided by the UCI in the area of Human Activity Recognition Using Smartphones Data Set.

### Structure of file
- Download Files
- Merging Data Sets
- Filtering based on Features
- Adding Meaningful labels
- Writing a tidy data set into a CSV file

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

```R
features.filtered <- rbind(features[grep("mean\\(", features$V2),], features[grep("std\\(", features$V2),])
```
