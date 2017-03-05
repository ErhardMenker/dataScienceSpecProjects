############################################################################################

### Program to analyze hospital data provided by the U.S. Health and Human Services

############################################################################################

# Set working directory
setwd("C:/Data/Analytics_Studies/R/Data_Science_Specialization/R_Programming/Program3_Data")

# Import packages
require("stringr")

############################################################################################

# FUNCTION 1
# best() the best hospital in a state based on a certain outcome

best <- function(state, outcome) {
    # read in the file
    df <- read.csv("outcome-of-care-measures.csv")
    
    states <- df$State
    # throw an error if the passed in state is not in the list of states 
    if(!(state %in% states)) {
        stop("invalid state")
    }
    
    # subset a data frame considering just the state's data
    df_state <- df[states == state, ]
    
    # capitalize the first letter of the outcome
    outcome <- paste(toupper(substr(outcome, 1, 1)), substr(outcome, 2, nchar(outcome)), sep = "", collapse = " ")
    # subset the appropriate column of deaths
    outcome_col <- paste("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep = "")
    # throw an error if the passed in outcome is not in the list of outcomes
    if(!(outcome_col %in% names(df_state))) {
        stop("invalid outcome")
    }
    
    # data frame for a given state with hospital names and mortality data
    df_outcome <- df_state[, c("Hospital.Name", outcome_col)]
    
    # sort the data frame alphabetically by hospital names for iterative minimization
    df_outcome[order(df_outcome$Hospital.Name), ]
    
    # subset the outcome column as numeric, coercing non-numbers to NAs with as.character()
    vals <- as.numeric(as.character(df_outcome[, 2]))
    # subset the sites as a character vector
    sites <- as.character(df_outcome[, 1])
    
    # iterate through the vals and sites vectors and iteratively find the min
    min <- Inf
    for(idx in 1:length(sites)) {
        val <- vals[idx]
        # go to the next iteration if value is an NA
        if(is.na(val)) next
        site <- sites[idx]
        # if value greater than previous max, set this equal to new max 
        if(val < min) { 
            min <- val
            min_site <- site
        }
    }

    return(min_site)
}

# Function 1 Applications
best("SC", "Heart.Attack")
best("NY", "pneumonia")
best("AK", "pneumonia")

############################################################################################

# FUNCTION 2
# rankhospital() looks at the hospitals in a state and finds the nth best hospital by outcome

rankhospital <- function(state, outcome, rank) {
    # read in the file
    df <- read.csv("outcome-of-care-measures.csv")
    
    states <- df$State
    # throw an error if the passed in state is not in the list of states 
    if(!(state %in% states)) {
        stop("invalid state")
    }
    
    # subset a data frame considering just the state's data
    df_state <- df[states == state, ]
    
    # capitalize the first letter of the outcome
    outcome <- paste(toupper(substr(outcome, 1, 1)), substr(outcome, 2, nchar(outcome)), sep = "", collapse = " ")
    # subset the appropriate column of deaths
    outcome_col <- paste("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep = "")
    # throw an error if the passed in outcome is not in the list of outcomes
    if(!(outcome_col %in% names(df_state))) {
        stop("invalid outcome")
    }
    
    # data frame for a given state with hospital names and mortality data
    df_outcome <- df_state[, c("Hospital.Name", outcome_col)]
    # get the outcome as a coerced numeric vector, put back in DF
    outcomes <- as.numeric(as.character(df_outcome[, 2]))
    hospitals <- as.character(df_outcome$Hospital.Name)
    df_final <- data.frame(hospitals, outcomes)
    # remove NAs
    df_final <- df_final[complete.cases(df_final[, 1], df_final[, 2]), ]
    # sort by mortality outcomes
    df_final <- df_final[order(df_final$outcomes, df_final$hospitals), ]
    
    # code some special non-integer cases
    if(rank == "best") rank <- 1
    if(rank == "worst") rank <- nrow(df_final)
    # return NA if the rank input exceeds row
    if(rank > nrow(df_final)) return(c(NA))
 
    return(as.character(df_final[rank, 1]))
}

# Function 2 Applications
rankhospital("NC", "Heart.Attack", "worst")
rankhospital("WA", "Heart.Attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "Heart.Attack", 7)

############################################################################################

# FUNCTION 3
# rankall() lists every state's nth best hospital in a data frame format

rankall <- function(outcome, num = "best") { 
    # read in the file
    df <- read.csv("outcome-of-care-measures.csv")
    
    # create a new DF with just the states, hospitals, and outcome results
    # capitalize the first letter of the outcome
    outcome <- paste(toupper(substr(outcome, 1, 1)), substr(outcome, 2, nchar(outcome)), sep = "", collapse = " ")
    # subset the appropriate column of deaths
    outcome_col <- paste("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep = "")
    # throw an error if the passed in outcome is not in the list of outcomes
    if(!(outcome_col %in% names(df))) {
        stop("invalid outcome")
    }
    df_outcome <- df[, c("State", "Hospital.Name", outcome_col)]
    
    # rename allowable character inputs
    if(num == "best") num <- 1

    # create a list of unique states
    states <- unique(as.character(df$State))
    
    # initialize hospital and state character vectors to be filled
    states_ord <- ""
    hosp_ord <- ""
    
    # loop through each state and extract the rank, appending to df_return
    for(state in states) {
        
        # subset just rows from this state
        df_state <- df_outcome[state == df$State, ]
        # recreate this data frame with vectors via coercion
        Outcomes <-  as.numeric(as.character(df_state[, outcome_col]))
        Hospitals <- df_state[, 2]
        df_state <- data.frame(Hospitals, Outcomes)
        # strike NAs 
        df_state <- df_state[complete.cases(df_state$Hospitals, df_state$Outcomes), ]
        # sort the data frame first by outcomes then by hospitals alphabetically
        df_state <- df_state[order(df_state$Outcomes, df_state$Hospitals), ]
        
        # special state-by-state non-integer cases
        if(num == "worst") num <- nrow(df_state)
        # subset the hospital name
        if(num <= nrow(df_state)){ 
            hosp <- as.character(df_state[num, 1])
        } else {
            hosp <- NA
        }
        
        # concatenate the iterated state and its matched hospital to the list, in order
        if(states_ord == "") {
            states_ord <- state
        } else {
            states_ord <- c(states_ord, state)
        }
        
        if(hosp_ord == "") {
            hosp_ord <- hosp
        } else {
            hosp_ord <- c(hosp_ord, hosp)
        }
    }
    unsort_return <- data.frame(hospital = hosp_ord, state = states_ord)
    return(unsort_return[order(unsort_return$state),])
}  

# Function 3 Applications
r <- rankall("Heart.Attack", 4)
as.character(subset(r, state == "HI")$hospital)

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
