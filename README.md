# Human Activity Recognition Analysis
## Coursera: Getting and Cleanning Data / Project 2


This project is the second assignment in the course for getting and cleaning data from the John Hopkins University delivered in Coursera. The purpose of this analysis is to consolidate a tidy data set that provides statistical information for certain metrics collected in wearable devices.


### Description of Files:
- **run_analysis.R**: Contains the entire assignment and produces a text file that consolidates the data set requested in the project. It expects a predefined folder structure with the origin of the data as a zip file and unzipped into the local directory
- **tidy_data_table.txt**: This is the product of successfully executing the *run_analysis.R* file. It contains a subset of all the metrics provided in the UCI data sample, including only `mean() # Means` and `std() # Standard Deviation` columns of the metrics available. It provides groups based on activity and subject.
