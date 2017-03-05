############################################################################################

### Program to analyze pollutant data stored in any combination of the 332 unique CSVs

############################################################################################

# FUNCTION 1
# pollutantmean() goes into a directory and takes the mean of a pollutant...
# ... (sulfate or nitrate) for any file indices in the id argument.

pollutantmean <- function(directory, pollutant, id = 1:332) {
    # go to the file path where the CSVs are stored
    setwd(directory)
    df_final <- data.frame()
    # go through each CSV and concatenate it to one data frame
    for(file_idx in id) {
        # concatenate extra leading zeros to csv numbers that are too small
        if(file_idx < 10) {
            file_idx <- paste("00", file_idx, sep = "")
        } else if(file_idx < 100) {
            file_idx <- paste("0", file_idx, sep = "")
        }
        
        file <- paste(as.character(file_idx), ".csv", sep = "")
        df_indiv <- read.csv(file)
        df_final <- rbind(df_final, df_indiv)
    }
    mean(df_final[c(pollutant)][!is.na(df_final[c(pollutant)])])
}

#Question Group 1
pollutantmean("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", "sulfate", 1:10)
pollutantmean("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", "nitrate", 70:72)
pollutantmean("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", "sulfate", 34)
pollutantmean(directory = "C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", pollutant = "nitrate")
############################################################################################

############################################################################################

#FUNCTION 2
# complete() returns a data frame listing the CSV and its number of complete cases

complete <- function(directory = NULL, id = 1:332) {
    # go to the file path where the CSVs are stored
    setwd(directory)
    # initialize a data frame
    df_output <- data.frame()
    for(file_idx in id) {
        # create this equality because this row id as is will be stored in data frame
        row_id = file_idx
        # concatenate extra leading zeros to csv numbers that are too small
        if(file_idx < 10) {
            file_idx <- paste("00", file_idx, sep = "")
        } else if(file_idx < 100) {
            file_idx <- paste("0", file_idx, sep = "")
        }
        
        file <- paste(as.character(file_idx), ".csv", sep = "")
        df_indiv <- read.csv(file)
        
        sum <- sum(complete.cases(df_indiv$nitrate, df_indiv$sulfate))
        df_output <- rbind(df_output, c(row_id, sum))
    }
    colnames(df_output) <- c("id", "nobs")
    return(df_output)
}

complete(directory = "C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", id = c(2, 4, 8, 10, 12))

# Question Group 2
cc <- complete("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

cc <- complete("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])
############################################################################################

############################################################################################

# FUNCTION 3
# corr() returns a vector of correlations that exceed a certain observation threshold

corr <- function(directory, threshold = 0) {
    # go to the file path where the CSVs are stored
    setwd(directory)
    output <- as.numeric(vector())
    for(file_idx in 1:332) {
        # concatenate extra leading zeros to csv numbers that are too small
        if(file_idx < 10) {
            file_idx <- paste("00", file_idx, sep = "")
        } else if(file_idx < 100) {
            file_idx <- paste("0", file_idx, sep = "")
        }
        
        # read in the file after concatenating the csv to the index
        file <- paste(as.character(file_idx), ".csv", sep = "")
        df <- read.csv(file)  
        non_miss <- complete.cases(df$nitrate, df$sulfate)
        # if the amount of non-missing exceeds the threshold, calculate the correlation of the...
        # ...complete cases and concatenate to the vector
        if(sum(non_miss) >= threshold) {
            correl <- cor(df$nitrate[non_miss], df$sulfate[non_miss])
            output <- c(output, correl)
        }
    }
    return(output)
}

cr <- corr("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", 400)
head(cr)

#Question Group 3
cr <- corr("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", 2000)                
n <- length(cr)                
cr <- corr("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))

