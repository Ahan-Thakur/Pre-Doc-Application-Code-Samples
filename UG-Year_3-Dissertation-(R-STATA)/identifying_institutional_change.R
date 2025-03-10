library(here)
library(dplyr)
library(tidyr)
library(fixest)
library(ggplot2)
library(tibble)
library(readr)
library(zoo)

####################################################################################################
### Creating Paths
####################################################################################################

# Define file paths
input_file <- "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/global_data.RData"
output_dir <- "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/data_analysis"
output_file <- file.path(output_dir, "global_data_DiD.RData")

load(input_file)

# Ensure global_data is a data frame
global_data <- as.data.frame(global_data)



####################################################################################################
### Creating Variable "delta_institutions" and "real_delta_institutions"
### where "delta_institutions" = 0 for all institutions(t) - institutions(t-1) < 0.002; else = actual value of change
### and where "real_delta_institutions" = institutions(t) - institutions(t-1) 
####################################################################################################


#global_data_DiD <- global_data %>%
#  arrange(countrycode, year) %>% 
#  group_by(countrycode) %>%
#  mutate(delta_institutions = ifelse(abs(institutions - lag(institutions)) >= 0.002, 
#                                     institutions - lag(institutions), 
#                                     0)) %>%
#  ungroup()

global_data_DiD <- global_data %>%
  arrange(countrycode, year) %>%
  group_by(countrycode) %>%
  mutate(real_delta_institutions = institutions - lag(institutions),
         delta_institutions = ifelse(abs(real_delta_institutions) >= 0.002, 
                                     real_delta_institutions, 
                                     0)) %>%
  ungroup()

global_data_DiD <- global_data_DiD %>%
  arrange(countrycode, year) %>%
  group_by(countrycode) %>%
  mutate(real_rolling_sum_institutions = ifelse(row_number() %% 6 == 0,  # Only compute every 6 years
                                           rollapply(real_delta_institutions, 
                                                     width = 6, 
                                                     FUN = sum, 
                                                     align = "right", 
                                                     fill = NA, 
                                                     partial = FALSE), 
                                           NA)) %>%
  ungroup()

global_data_DiD <- global_data_DiD %>%
  mutate(rolling_sum_institutions = ifelse(is.na(real_rolling_sum_institutions) | real_rolling_sum_institutions < 0.002, 
                                           0, 
                                           real_rolling_sum_institutions))

# Save the modified dataset
save(global_data_DiD, file = output_file)

# Print confirmation message
cat

# CSV conversion for STATA
output_file <- file.path(output_dir, "global_data_DiD.csv")
write.csv(global_data_DiD, output_file, row.names = FALSE)
cat("CSV file saved to:", output_file, "\n")

####################################################################################################
### Checking Number of observations with institutional change above threshold across the 2 years
####################################################################################################

num_changes <- global_data_DiD %>%
  filter(delta_institutions != 0) %>%
  nrow()

# Print the result
cat("Number of observations where delta_institutions is not 0:", num_changes, "\n")

### Observation Counts:
## Threshold = 0.2 results in 38 observations 
## Threshold = 0.1 results in 143 observations
## Threshold = 0.05 results in 309 observations
## Threshold = 0.01 results in 1411 observations 
## Threshold = 0.005 results in 2200 observations 
## Threshold = 0.002 results in 3323 observations <-- **selected**
## Threshold = 0.001 results in 4062 observations 

