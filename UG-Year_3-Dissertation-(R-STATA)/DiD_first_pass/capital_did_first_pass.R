library(dplyr)
library(fixest)
library(ggplot2)
library(broom)


global_data_DiD <- read.csv("global_data_DiD.csv")

# Define Treated Group
global_data_DiD_treated <- global_data_DiD %>%
  mutate(treated = ifelse(delta_institutions != 0, 1, 0))

# Define Control Group
control_candidates <- global_data_DiD_treated %>%
  filter(delta_institutions == 0)

# Function to check if a country-year is a valid control
is_valid_control <- function(country, year, data) {
  subset <- data %>%
    filter(countrycode == country & year >= (year - 6) & year <= (year + 6))
  
  # Ensure rolling_sum_institutions is 0 for the entire window
  return(nrow(subset) == 13 && all(subset$rolling_sum_institutions == 0, na.rm = TRUE))
}

# Determining valid controls
global_data_DiD_control <- global_data_DiD_treated %>%
  rowwise() %>%
  mutate(control = ifelse(is_valid_control(countrycode, year, global_data_DiD_treated), 1, 0)) %>%
  ungroup()

# Assign Event Time
treated_countries <- global_data_DiD_control %>%
  filter(treated == 1) %>%
  group_by(countrycode) %>%
  summarize(first_treatment_year = min(year), .groups = 'drop')

global_data_DiD_event <- global_data_DiD_control %>%
  left_join(treated_countries, by = "countrycode") %>%
  mutate(event_time = ifelse(treated == 1, year - first_treatment_year, NA))


# Run the Difference-in-Differences regression
DiD_model <- feols(ln_capital_per_capita ~ i(event_time, delta_institutions, ref = -1) | countrycode + year, 
                   data = global_data_DiD_final, cluster = ~countrycode)

# Display regression results
summary(DiD_model)

# Plot
event_plot <- tidy(DiD_model, conf.int = TRUE) %>%
  filter(grepl("event_time::", term)) %>%
  mutate(event_time = as.numeric(gsub("event_time::", "", term)))

ggplot(event_plot, aes(x = event_time, y = estimate)) +
  geom_point() +
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = 0.2) +
  geom_vline(xintercept = -1, linetype = "dashed", color = "red") +
  labs(title = "Difference-in-Differences Event Study",
       x = "Years Since Treatment",
       y = "Effect on ln_capital_per_capita") +
  theme_minimal()


