1. Download dataset
* Dataset was download into UCI HAR Dataset (unzipped file)

2. Extracting data from dataset
* `features` <- `features.txt` 

  _features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ_

* `activities` <- `activity_labels.txt`

  _links the class labels with their activity name_

* `test.subj/train.subj` <- `subject_test/subject_train.txt`

  _list of subjects for the test and training phases_
  
* `test.x/train.x` <- `X_test/X_train.txt`

  _contains recorded features_
  
* `test.y/train.y` <- `y_test/y_train.txt`

  _contains labels for activities_
  
  
3. Merging data
* `X` merges `test.x` and `train.x` using rbind
* `Y` merges `test.y` and `train.y` using rbind
* `Subject` merges `test.subj` and `train.subj` using rbind
* `Merged` combines all the merged data (`X`, `Y`, `Subject`) using cbind

4. Tidying up data through extraction (Means and Standard Deviations only)
* `Tidy` subsets `Merged` by selecting only the columns that contain '`mean`' and '`std`' for each measurement, as well as the `subject` and `label`

5. Use descriptive names for activities
* Numbers in `label` column in `Tidy` swapped with the actual names of the activities from the `activities` variable, which were contained in the 2nd column of `activities`

6. Appropriately label dataset with descriptive names
* `label` column renamed to `activities`
* All `Acc` renamed to `Accelerometer`
* All `Gyro` renamed to `Gyroscope`
* All `t` prefixes changed to `Time`
* All `f` prefixes changed to `Frequency`
* All `BodyBody` shortened to `Body`
* All `Mag` changed to `Magnitude`

7. Creating that independent dataset
* `Final` was created by grouping `Tidy` by subject and activity before taking the means of every variable
* Exported `Final` as a text file `finalized.txt`