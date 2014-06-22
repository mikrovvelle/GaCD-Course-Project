## datadir and outputdir are the only values that you should 
## need to change. Just make sure datadir points to the 
## top-level path of the "UCI HAR Dataset" used for this project,
## and "results" is somewhere you don't mind writing the csv
## files.
##
## By default, this script is intended to run next in the 
## parent directory of the UCI HAR Dataset. You should make
## sure that analysis_tools.R is also in the same directory
## as this one.
datadir="UCI HAR Dataset"
outputdir="results"


## The rest of the script will import a tidied version of the
## source data into the workspace, and write two CSV files:
## 1. The full data with ~10k observations, ~80 variables
## 2. The mean data, which gives the mean of each reading,
##    per subject, per activity.
source("analysis_tools.R")
fulldata <- importUCI(datadir)

fulldata_melted <- summarizeUCI(fulldata)
fulldata_means <- allmeansUCI(fulldata_melted)

dir.create(outputdir, showWarnings=FALSE)
write.csv(fulldata,
    file.path(outputdir,"stdmeandata_UCI_HAR.txt"))
write.csv(fulldata_means,
    file.path(outputdir,"summaryTable_UCI_HAR.txt"))