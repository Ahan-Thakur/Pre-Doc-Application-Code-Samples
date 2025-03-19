library(ggplot2)

output_dir <- "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/global_data_figures"
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

###--------------------------------------------------------------------------###
### CREATING SCATTER PLOTS OF PANEL DATA ###
###--------------------------------------------------------------------------###

create_scatter_plot <- function(data, x_var, y_var, x_label, y_label, file_name) {
  p <- ggplot(data, aes_string(x = x_var, y = y_var, color = "countrycode")) +
    geom_point(shape = 4, size = 1) +  # Smaller x markers
    theme_minimal(base_family = "Times New Roman") +
    labs(x = x_label, y = y_label) +
    theme(text = element_text(size = 14), legend.position = "none", panel.background = element_rect(fill = "white", color = "white"), plot.background = element_rect(fill = "white", color = "white"))
  
  ggsave(filename = file.path(output_dir, paste0(file_name, ".png")), plot = p, width = 8, height = 6, dpi = 300)
}

create_scatter_plot(global_data, "ln_manual_TFP", "institutions", "Log TFP", "Institutions", "ln_TFP_vs_institutions")
create_scatter_plot(global_data, "ln_human_capital", "institutions", "Log Human Capital", "Institutions", "ln_human_capital_vs_institutions")
create_scatter_plot(global_data, "ln_capital_per_capita", "institutions", "Log Capital per capita", "Institutions", "ln_capital_per_capita_vs_institutions")
create_scatter_plot(global_data, "ln_gdp_per_capita", "institutions", "Log GDP per capita", "Institutions", "ln_gdp_per_capita_vs_institutions")


###--------------------------------------------------------------------------###
### CREATING COUNTRY SPECIFIC TIME SERIES ###
###--------------------------------------------------------------------------###


create_time_series_plot <- function(data, country_code) {
  country_data <- subset(data, countrycode == country_code)
  
  p <- ggplot(country_data, aes(x = year)) +
    geom_line(aes(y = ln_gdp_per_capita, color = "Log GDP per capita"), size = 1) +
    geom_line(aes(y = ln_human_capital, color = "Log Human Capital"), size = 1) +
    geom_line(aes(y = ln_manual_TFP, color = "Log TFP"), size = 1) +
    geom_line(aes(y = ln_capital_per_capita, color = "Log Capital per capita"), size = 1) +
    geom_line(aes(y = institutions * max(c(country_data$ln_gdp_per_capita, country_data$ln_human_capital, country_data$ln_manual_TFP, country_data$ln_capital_per_capita)) / 1, color = "Institutions"), size = 1) +
    scale_color_manual(values = c("Institutions" = "purple", "Log GDP per capita" = "blue", "Log Human Capital" = "green", "Log TFP" = "red", "Log Capital per capita" = "orange")) +
    scale_y_continuous(
      name = "Proximate Factor Values", 
      sec.axis = sec_axis(~ . / max(c(country_data$ln_gdp_per_capita, country_data$ln_human_capital, country_data$ln_manual_TFP, country_data$ln_capital_per_capita)) * 1, name = "Institutions")
    ) +
    theme_minimal(base_family = "Times New Roman") +
    labs(x = "Year", color = "Variable", title = paste("Time Series for", country_code)) +
    theme(text = element_text(size = 14), panel.background = element_rect(fill = "white", color = "white"), plot.background = element_rect(fill = "white", color = "white"))
  
  file_name <- paste0(country_code, "_variable_series.png")
  ggsave(filename = file.path(output_dir, file_name), plot = p, width = 8, height = 6, dpi = 300)
}

# Generate the time series plots for multiple countries
country_codes <- c("USA", "BRA", "ARG", "MEX", "THA", "CHN", "IND", "HUN", "POL", "FRA", "DEU")
lapply(country_codes, function(cc) create_time_series_plot(global_data, cc))
