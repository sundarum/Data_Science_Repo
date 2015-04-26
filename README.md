# Getting and Cleaning Data
This repository has my project submission for the "Getting and Cleaning Data" course from courseera.

## Scripts and file in the Repo
You will find run_analysis.R script file. This script is standalone and it has the complete implementation of the problem statement. THere are no other dependant functions are scripts.

you will find a file Final_result.txt, this has the final tidy data. You can read it in R using 


result <- read.table("Final_Result.txt")

## Working assumptions
I extracted the data files into a sub directory in the working directory called "UCI HAR Dataset". The script assumes, that you will have the same data folder in your working directory. The script "run_analysis.R" takes relative path from the working directory to "UCI HAR Dataset" as ".\UCI HAR Dataset\". By default, the unzip operation will create the required folder structure in the working directory, if you have done "extract here" in Windows.

Unzipping the file is not done programmatically in the script.

The script uses "dplyr" pacjage intensively. so you need to have the "dplyr" package insalled in your machine. I am using R 3.1.2 version for my implementation.
