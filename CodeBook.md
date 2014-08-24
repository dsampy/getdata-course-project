To create the merged and tidy datasets, the following files from the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) are processed:

- **activity_labels.txt**: Used to add human-understandable activity labels
- **features.txt**: Used to add human-understandable measurement labels
- **test/subject_test.txt**: Used to add subject IDs to test dataset (which is combined with the training dataset to create the final merged dataset)
- **test/X_test.txt**: Used to add measurement values to test dataset (which is combined with the training dataset to create the final merged dataset)
- **test/y_test.txt**: Used to add activity labels to the test dataset (which is combined with the training dataset to create the final merged dataset)
- **train/subject_train.txt**: Used to add subject IDs to test dataset (which is combined with the test dataset to create the final merged dataset)
- **train/X_train.txt**: Used to add measurement values to test dataset (which is combined with the test dataset to create the final merged dataset)
- **train/y_train.txt**: Used to add activity labels to the test dataset (which is combined with the test dataset to create the final merged dataset)

## Merged Dataset Creation
To actually create the merged dataset, the following process is followed:

1. The raw dataset is downloaded from [this URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) (by default) and extracted into the data directory (which is created automatically if it doesn't previously exist)
2. To normalize both the test and training datasets:
	1. Read the subject IDs from the corresponding subject_(test|train).txt file
	2. Read the activity IDs from the corresponding y_(test|train).txt file
	3. Read the measurement data from the corresponding X_(test|train).txt file
	4. Each of the above three matrices should have the same number of rows; column-merge them into a single matrix (so that the structure is essentially (subjectId, activityId, measurement...))
	5. Filter out measurement columns whose column names (as defined in features.txt) does not end with either "mean()" (for mean-based measurements) or "std()" (for standard deviation-based measurements).  I wasn't sure if we were to include the (mean|std)()-XYZ measurements here or not so I erred on the side of excluding them.
	6. Normalize the activity column to transpose the integer (read "factor") values to strings using the activity_labels.txt file as a guide.
3. Once both files have been processed as described above, they will both have the same number of columns; consequently, the final step is to row-merge them into a single data frame and then write the resultant dataset to the filesystem as merged.txt.

Here is a list of column names/descriptions in the merged dataset:

* **subjectId**:
	* Description: unique subject identifier
	* Data Type: string
	* Is NA/NaN Allowed: no
* **activity**:
	* Description: label describing activity type
	* Data Type: string (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
	* Is NA/NaN Allowed: no
* **tBodyAccMag-mean()**:
	* Description: average of tBodyAccMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tBodyAccMag-std()**:
	* Description:  standard deviation of tBodyAccMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tGravityAccMag-mean()**:
	* Description:  average of tGravityAccMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tGravityAccMag-std()**:       
	* Description:  standard deviation of tGravityAccMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tBodyAccJerkMag-mean()**:
	* Description:  average of tBodyAccJerkMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tBodyAccJerkMag-std()**:
	* Description:  standard deviation of tBodyAccJerkMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tBodyGyroMag-mean()**:
	* Description:  average of tBodyGyroMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tBodyGyroMag-std()**:
	* Description:  standard deviation of tBodyGyroMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tBodyGyroJerkMag-mean()**:
	* Description:  average of tBodyGyroJerkMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **tBodyGyroJerkMag-std()**:
	* Description:  standard deviation of tBodyGyroJerkMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **fBodyAccMag-mean()**:
	* Description:  average of fBodyAccMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **fBodyAccMag-std()**:
	* Description:  standard deviation of fBodyAccMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **fBodyBodyAccJerkMag-mean()**:
	* Description:  average of fBodyBodyAccJerkMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **fBodyBodyAccJerkMag-std()**:
	* Description:  standard deviation of fBodyBodyAccJerkMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **fBodyBodyGyroMag-mean()**:
	* Description:  average of fBodyBodyGyroMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **fBodyBodyGyroMag-std()**:
	* Description:  standard deviation of fBodyBodyGyroMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **fBodyBodyGyroJerkMag-mean()**:
	* Description:  average of fBodyBodyGyroJerkMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no
* **fBodyBodyGyroJerkMag-std()**:
	* Description:  standard deviation of fBodyBodyGyroJerkMag measurement (see features_info.txt for more information)
	* Data Type: numeric (bounded between [-1:1])
	* Is NA/NaN Allowed: no

## Tidy Dataset Creation
Currently, the "tidy" dataset is the same as the merged dataset; this is due to the fact that I still haven't quite grokked how apply (and its related functions) work in R.  Obviously, this means that the project is not complete and, assuming that I do not update this section and the corresponding code with the appropriate implementation, I expect that I will not get full credit.  Still, I'm hoping that my effort does at least entitle me to partial credit.