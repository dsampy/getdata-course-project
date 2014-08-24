createDataDirectory <- function() {
  if (!file.exists("./data")) {
    dir.create("./data")
  }
}

downloadAndExtractData <- function(dataUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") {
  setwd("./data")
  download.file(dataUrl, destfile="./data.zip", method="curl")
  unzip("./data.zip")
  unlink("./data.zip")
  setwd("../")
}

readFeatureLabels <- function() {
  as.vector(read.table("./data/UCI HAR Dataset/features.txt")[, 2])
}

readAndNormalizeData <- function(type) {
  readSubjectIds <- function() {
    fileName <- sprintf("./data/UCI HAR Dataset/%1$s/subject_%1$s.txt", type)
    as.character(read.table(fileName)[, 1])
  }
  
  readActivityIds <- function() {
    fileName <- sprintf("./data/UCI HAR Dataset/%1$s/y_%1$s.txt", type)
    as.character(read.table(fileName)[, 1])
  }
  
  readMeasurements <- function() {
    fileName <- sprintf("./data/UCI HAR Dataset/%1$s/X_%1$s.txt", type)
    read.table(fileName)
  }

  featureLabels <- readFeatureLabels()
  stdAndMeanFeatureFilter <- grepl("(std|mean)\\(\\)$", featureLabels)
  stdAndMeanFeatureLabels <- featureLabels[stdAndMeanFeatureFilter]
  
  result <- readMeasurements()
  result <- result[ , stdAndMeanFeatureFilter]
  result <- cbind(readSubjectIds(), readActivityIds(), result)
  colnames(result) <- c("subjectId", "activity", stdAndMeanFeatureLabels)
  levels(result$activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
  result
}

readAndNormalizeTestData <- function() {
  readAndNormalizeData("test")
}

readAndNormalizeTrainingData <- function() {
  readAndNormalizeData("train")
}

createMergeData <- function() {
  rbind(readAndNormalizeTestData(), readAndNormalizeTrainingData())
}

writeData <- function(data, fileName) {
  write.table(data, sprintf("./data/%s.txt", fileName), quote=FALSE, row.names=FALSE)
}

createAndWriteMergeData <- function() {
  mergeData <- createMergeData()
  writeData(mergeData, "merge")
  mergeData
}

createTidyData <- function(mergeData) {
  tidyData <- mergeData
  tidyData
}

createAndWriteTidyData <- function(mergeData) {
  tidyData <- createTidyData(mergeData)
  writeData(tidyData, "tidy")
  tidyData
}

run <- function() {
  createDataDirectory()
  downloadAndExtractData()
  mergeData <- createAndWriteMergeData()
  tidyData <- createAndWriteTidyData(mergeData)
}

run()