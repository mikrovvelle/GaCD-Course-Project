# Code book: UCI HAR Dataset

There are two R scripts responsible for processing the sources data into a tidy data set:

1. `run_analysis.R`: the high-level script that imports the data into the workspace, and exports the tidy csv files.
2. `analysis_tools.R`: the low-level implementation of imports, and data reshaping in order to prepare the data for export

## Running the process

The two R scripts should be placed 'next to' the 'UCI HAR Dataset' directory that results from extracting the zip file from the following address:

    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

From the R console, in the same directory as the source files, the user can simply run:

    `source("run_analysis.R")`

This will import and process the needed data and output the two required csv files (with txt suffixes) into a new `results` directory.

## Input Data summary

Input data is extracted from two directories and compiled from three files in each directory.

| directory | subject             | activity      | measurements  |
|-----------|---------------------|---------------|---------------|
| `test`    | `subject_test.txt`  | `y_test.txt`  | `X_test.txt`  |
| `trial`   | `subject_trial.txt` | `y_trial.txt` | `X_trial.txt` |

The rows in the files of each directory correspond with each other. That is, row 303 represents the same measurement in all three files in the test directory.

## Identifier data

Measurements are linked to a person (subject) and an activity (e.g. walking, sitting). These two key columns were given their own 1-column file identify each row's subject or activity, respectively.

### Subject:

1. `train/subject_train.txt`
2. `test/subject_test.txt`

The subject represents an individual being observed. Although there was a 'test' and 'trial' run, the subjects in those runs were given unique integer identifiers, so there is only one person represented by any given number.

### Activity

1. `train/y_train.txt`
2. `test/y_test.txt`

There were six activities observed, they are listed in the `activity_labels.txt` file in the top-level directory. They are listed here with their indices as well:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

The R `merge()` function was used to incorporate the activity names in the output data set. The indices (integers) are left out of the final data set because they are redundant to their names.


## Processing measurement data

2 input files were imported holding measurement data:

1. `train/X_train.txt`
2. `test/X_test.txt`

Both of these files use the same format, with observations on each row, columns representing specific summary measurements, and rows corresponding with those in the other files as described in the section above.

## Processing metadata

There are 561 independent measurements in each row, so 561 columns in the `X_train.txt` and `X_test.txt` files. Columns are not labeled in these files. Rather, the columns are listed in the `features.txt` files in the top-level directory. These 561 rows were extracted from this file and used as column names for measurements in the tidy data set.

The measurment column names have a naming structure:

- The letter 't' or 'f' to indicate time or frequency domain, respectively
- The Name of the Measurement itself
- An optional '-X', '-Y' or '-Z' to indicate along which axis the measurement took place
- '-fun()' to indicate a function name used to summarize the data

Only columns that measured mean or standard deviation (`std`) were included, as specified in the instructions.

## Output data

Data is output as a csv file using the R `write.csv` function, to two files:

- `summaryTable_UCI_HAR.txt`: the large data set without any further summarization. This is a simple CSV file with all of the observations.
- `stdmeandata_UCI_HAR.txt`: the mean of each of these measurements per Subject and Activity. 

Note that for the 2nd file, each subject is given a single row, and each (measurement + activity) combination is given its own column, for a total of 81x6=486 columns. This qualifies as a 'wide' tidy data set. The discussion of 'wide' vs. 'long' tidy data can be found in the forum FAQ here:

https://class.coursera.org/getdata-004/forum/thread?thread_id=262

Both files should be importable into Excel or R with default tools: comma-separation, double-quote text qualifiers.

## Technical note

R's `read.table` function was used for importation, with `sep=""` to allow for multiple whitespace characters to be imported.




