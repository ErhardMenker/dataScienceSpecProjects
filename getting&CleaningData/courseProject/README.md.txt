=============================================
Getting & Cleaning Data Project Documentation
Author: Erhard Menker
=============================================

This markdown document explains what is occurring in the pipeline located at ./run_analysis.r

Please note that the variables are explained at ./CodeBook.md either directly or by its pointing to original source documentation

PROGRAM OVERVIEW
================
 
The pipeline at ./run_analysis.r has no dependencies on any other R programs, but does pull in data from web sources

The program is broken into multiple sections that are each meant to fulfill a broad purpose in the data cleaning process

Note that the setting of the working directory should be done at the beginning and is commented out at the beginning for reproducibility. All further...
...paths are relative paths to run from any working directory

PREPROCESSING
=============

- Check to see if there is a folder at the main level of the working directory called data. If this does not exist, create it.

- Download the data at the URL named in ./CodeBook.md that contains all of the project's data and save it in the data folder as "project1.zip"

- Unzip the file, this will create a new folder at the level of "project1.zip" called "UCI HAR Dataset"

- Reset the working directory in a relative way to "./data/UCI HAR Dataset"

IMPORT
======

- Fetch the dependent (Y) and the independent (X) variables for both the training set and store them in their respective dataframes of X_TEST, Y_TEST, X_TRAIN, and Y_TRAIN

- Extract the names/mappings of the columns and rows into the dataframes COL_NAMES and ROW_NAMES, respectively.

MERGE
=====

- Create a TRAIN and TEST dataframes by column binding the dependent and independent data frames of the TRAIN and TEST dataframes,  respectively.

- CREATE a final dataframe called DF by row binding the TRAIN and TEST dataframes.

RENAME
======

- Rename the dependent variable column title as "activity"

- Rename the independent variable column titles by placing over the default titles the column names provided in COL_NAMES

- Rename the dependent row titles, or activities, by going into ROW_NAMES and replacing the index with the corresponding named activity.

- In these calls, space delimiters and all lower case inputs are all placed in accordance with "tidy data".

SUBSET
======

- Convert DF into the outputted dataframe DF_ALL by only keeping columns that identify the activity or have an indicator that they measure the mean or standard deviation.

AGGREGATE
=========

- Initialize an output dataframe called DF_SMRY to have the same column names as DF_ALL and as many rows as there are activity categories.

- Overwrite the numerical values for each activity category value as an NA.

- Split the dataframe on the activity categories. 

- Iterate through each of these dataframes and correspond this to a row index in DF_SMRY where in each first column the activity name is placed.

- In each subsequent column for a given activity/row, calculate the mean from the iterated dataframe's column and place it in the column of the corresponding row/activity.

CLEAN UP
========

- Clear out all of the objects except for DF_ALL and DF_SMRY to reduce clutter.