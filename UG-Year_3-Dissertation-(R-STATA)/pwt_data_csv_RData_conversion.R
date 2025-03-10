input_dir <- "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/pwt_data_raw"
output_dir <- "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/pwt_data"

csv_file <- file.path(input_dir, "pwt_data_raw.csv")  
rdata_file <- file.path(output_dir, "pwt_data_raw.RData")

data <- read.csv(csv_file)

save(data, file = rdata_file)

cat("CSV file successfully converted to RData:", rdata_file, "\n")
