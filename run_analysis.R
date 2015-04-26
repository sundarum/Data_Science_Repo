# Script to analyse the activity data
# We will be using dplyr for this code, hence let us load dplyr first
library(dplyr);
rm(list = ls());

# Section 1. Reading the details of activity labels and feature labels  
# This is common for both test and training datasets
Activity_Lables <- read.table ("./UCI HAR Dataset/activity_labels.txt");
Feature_Labels <- read.table ("./UCI HAR Dataset/features.txt");

# Section 2. Extract the features corresponding to mean and standard 
# deviation. We will use it to rename the columns once we have read the datasets
Mean_Features <- grep("mean",as.character(Feature_Labels$V2),ignore.case = FALSE)
STD_Features  <- grep("std",as.character(Feature_Labels$V2),ignore.case = FALSE)
Column_Index  <- c(Mean_Features,STD_Features) %>% sort() 
Column_Names  <- as.character(Feature_Labels$V2[Column_Index]) 

# Section 3. Read the Activity and the Subject data from test and train data
Sub_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt");
Sub_Test  <- read.table("./UCI HAR Dataset/test/subject_test.txt");

Act_Train <- read.table("./UCI HAR Dataset/train/y_train.txt");
Act_Test  <- read.table("./UCI HAR Dataset/test/y_test.txt");


# Section 4. Read, extract and rename relavent columns from test and training files
Training_Df <- read.table("./UCI HAR Dataset/train/X_train.txt")%>% tbl_df()%>% select(Column_Index);
Testing_Df  <- read.table("./UCI HAR Dataset/test/X_test.txt")%>% tbl_df() %>% select(Column_Index);
colnames(Training_Df) <- Column_Names ;
colnames(Testing_Df)  <- Column_Names;

# Section 5. Add the activity type and the subject Id columns to test and train 
# datasets
Training_Df$Activity_Type <- unlist(Act_Train);
Training_Df$Subject_ID <- unlist(Sub_Train);

Testing_Df$Activity_Type <- unlist(Act_Test);
Testing_Df$Subject_ID <- unlist(Sub_Test);

## Section 6. Remove all unwanted temporary variables
rm(Act_Test,Act_Train,Sub_Test,Sub_Train, Column_Index, Column_Names, 
   Mean_Features, STD_Features)

## Section 7. Merge the Dataframes
Final_DF <- rbind(Training_Df, Testing_Df);
rm(Testing_Df,Training_Df,Feature_Labels);

## Section 8. Change the activity column to a factor with appropriate lables
Final_DF$Activity_Type <- factor(Final_DF$Activity_Type,
                                 labels = Activity_Lables$V2);

## Section 9. Calculate means for all columns grouped by subject ID and activity
# ID
Result <- Final_DF %>% group_by(Subject_ID, Activity_Type) %>% summarise_each(funs(mean))
    