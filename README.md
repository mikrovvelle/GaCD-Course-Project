# Getting and Cleaning Data: Course Project

This is the course project for Coursera/Johns Hopkins "Getting and Cleaning Data" data science course. The contents consist of three files

1. `run_analysis.R`
2. `analysis_tools.R`
3. `CodeBook.md`

The script `run_analysis.R` uses functions from `analysis_tools.R` to import, process and tidy data from the data set at the following address:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To run the script and reproduce the results I submitted, follow the steps below:

1. Download the and unzip zip file in the link into the same directory as this tool.
2. Open the R Console or R studio and `setwd()` into the directory with these scripts and the downloaded data set.
3. run `source("run_analysis.R")` in R.

The script may take a minute or two depending on your machine's power. It will import several variables into the workspace. Most importantly,

- `fulldata`: the source data for the large unsummarized output data, and
- `fulldata_means`: the means of the source data per subject and activity.

More information on how this is done, and details of the data, can be found in the `CodeBook.md` file.
