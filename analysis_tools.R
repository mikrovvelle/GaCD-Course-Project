importUCI <- function(datadir="UCI HAR Dataset") {

    datadir <- "UCI HAR Dataset"

    ## for picking out mean and stdev columns
    library("stringr")

    bothruns <- list()
    for (run in c("test","train")) {
        ## header rows for both sets
        labels <- read.table(paste(datadir,"/features.txt",sep=""))

        ## import test data
        Tmp <- read.table(
            file.path(datadir,run,paste("X_",run,".txt",sep="")),
            header=FALSE)
        colnames(Tmp) <- labels$V2

        ## extract only mean and standard deviation (std) columns
        means <- str_detect(colnames(Tmp), "mean")
        stds <- str_detect(colnames(Tmp), "std")
        Tmp <- Tmp[means|stds]

        acts <- read.table(
            file.path(datadir,run,paste("y_",run,".txt",sep="")),
            header=FALSE)
        Tmp <- cbind(acts$V1, Tmp)
        colnames(Tmp)[1] <- "activity"

        subjects <- read.table(
            file.path(datadir,run,paste("subject_",run,".txt",sep="")),
            header=FALSE)
        Tmp <- cbind(subjects$V1, Tmp)
        colnames(Tmp)[1] <- "subject"

        ## label this data frame as the "test"/"train" run
        Tmp <- cbind(rep(run, length(Tmp[,1])), Tmp)
        colnames(Tmp)[1] <- "run"

        bothruns[[run]] <- Tmp
    }
    fulldata <- rbind(bothruns[["test"]], bothruns[["train"]])

    ## merge with activity labels so we have descriptive names
    actlables <- read.table(
        file.path(datadir,"activity_labels.txt"))
    colnames(actlables) <- c("activity", "activity-name")
    fulldata <- merge(fulldata, actlables, all.x=TRUE)

    ## rearrange columns to put key data up front
    ## (no longer need activity index number)
    z <- length(fulldata)
    fulldata <- fulldata[c(3,z,4:(z-1))]
    colnames(fulldata)[2] <- "activity"
    fulldata
}

summarizeUCI <- function(fulldata) {
    z <- length(fulldata)
    ## fdm = full data melted, long version of wide fulldata
    fdm <- melt(fulldata, id=c("subject","activity"),
        measure.vars=3:z)
    fdm
}

allmeansUCI <- function(fdm) {
    allmeans <- tapply(fdm$value, 
        list(fdm$subject, fdm$activity, fdm$variable), 
        mean)
    allmeans
}
