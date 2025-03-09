# Load the RData file
data <- readRDS("C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/vdem_data_raw/V-Dem-CY-Full+Others-v14.rds")

colnames(data)[colnames(data) == "country_name"] <- "country"
colnames(data)[colnames(data) == "country_text_id"] <- "countrycode"
colnames(data)[colnames(data) == "v2x_polyarchy"] <- "elecdem"
colnames(data)[colnames(data) == "v2x_libdem"] <- "libdem"
colnames(data)[colnames(data) == "v2x_delibdem"] <- "delibdem"
colnames(data)[colnames(data) == "v2x_egaldem"] <- "egaldem"

# Select relevant columns
selected_vars <- c("country", "countrycode", "year", "elecdem", "libdem", "delibdem", "egaldem")
vdem_data_clean <- data[selected_vars]

# Create new variable "institutions" 
vdem_data_clean$institutions <- (vdem_data_clean$elecdem + vdem_data_clean$libdem + vdem_data_clean$delibdem + vdem_data_clean$egaldem) / 4

# Remove rows with missing values in key columns
required_vars <- c("libdem", "elecdem", "delibdem", "egaldem")
vdem_data_clean <- vdem_data_clean[complete.cases(vdem_data_clean[, required_vars]), ]

# Define output directory
output_dir <- "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/vdem_data"

# Save the cleaned data as an RData file
save(vdem_data_clean, file = file.path(output_dir, "vdem_data_clean.RData"))

# Print message confirming successful processing
cat("Processed dataset successfully saved as 'vdem_data_clean.RData' in:", output_dir, "\n")
