library(dplyr)

load("C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/pwt_data/pwt_data_raw.RData")

output_dir <- "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/pwt_data"

selected_vars <- c("countrycode", "country", "year", "cgdpo", "pop", "hc", "ctfp", "cwtfp", "cn", "delta", "labsh", "rtfpna", "rwtfpna")
pwt_data_clean <- data[selected_vars]

# Create new variable: Capital Share (1 - labor share)
pwt_data_clean <- pwt_data_clean %>%
  mutate(capital_share = 1 - labsh)

# Create new variable: GDP per capita (cgdpo / pop)
pwt_data_clean$gdp_per_capita <- pwt_data_clean$cgdpo / pwt_data_clean$pop

# Create new variable: Capital per capita (cn / pop)
pwt_data_clean$capital_per_capita <- pwt_data_clean$cn / pwt_data_clean$pop

# Remove rows with missing values in key columns
required_vars <- c("cgdpo", "pop", "hc", "ctfp", "cwtfp")
pwt_data_clean <- pwt_data_clean[complete.cases(pwt_data_clean[, required_vars]), ]

save(pwt_data_clean, file = file.path(output_dir, "pwt_data_clean.RData"))

# Print message confirming successful processing
cat("Processed dataset successfully saved as 'pwt_data_clean.RData' in:", output_dir, "\n")

