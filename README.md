## Getting and Cleaning Data project

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

* Download and unzip the dataset if it does not already exist in the working directory
* Load the activity and feature info
* Finding only the desired features that holds mean and std data
* Cleaning the feature names
* Loads both training and test datasets
* Sets apropriate column names
* Factorizing activity and subject columns
* Merges both datasetes
* Aggregates the new dataset by subject and actvity, for each pair calculates the average
* Saving the new dataset into tidyData.txt 
