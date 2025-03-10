library(dplyr)
library(ggplot2)
library(tidyr)


load("C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/pwt_data/pwt_data_clean.RData")
load("C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/vdem_data/vdem_data_clean.RData")

global_data <- full_join(pwt_data_clean, vdem_data_clean, by = c("countrycode", "year"))

# Create TFP variable manually 
global_data$manual_TFP <- global_data$gdp_per_capita / 
  ((global_data$capital_per_capita ^ global_data$capital_share) * 
     (global_data$hc ^ global_data$labsh))


# Create new variables with natural logarithm 
global_data <- global_data %>%
  mutate(
    ln_human_capital = log(hc),
    ln_cn = log(cn),
    ln_ctfp = log(ctfp),
    ln_cwtfp = log(cwtfp),
    ln_rtfpna = log(rtfpna),
    ln_rwtfpna = log(rtfpna),
    ln_gdp_per_capita = log(gdp_per_capita),
    ln_capital_per_capita = log(capital_per_capita),
    ln_manual_TFP = log(manual_TFP),
    ln_institutions = log(institutions),
  ) %>%
  tidyr::drop_na()  # Remove rows with missing values

# Save the merged dataset
save(global_data, file = "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/global_data.RData")

# Print confirmation message
print("Merged dataset saved successfully.")

