*ssc install reghdfe, replace
*ssc install ftools, replace
*ssc install ivreg2, replace

clear

import delimited "C:\Ahan\Ahan\University 3rd Year\Dissertation\Dissertation Code\data_analysis\global_data_DiD.csv", clear

encode countrycode, gen(country_id)

destring delta_institutions, replace force

* Replace NA values in `delta_institutions` with 0
replace delta_institutions = 0 if missing(delta_institutions)

* Define Treated Group
gen treated = (delta_institutions != 0)

* Define Control Group
gen control = 0  // Initialize control variable

* Valid controls: delta_institutions == 0 AND rolling_sum_institutions == 0 for 6 years before & after
gen valid_control = .
bysort country_id (year): replace valid_control = 1 if delta_institutions == 0
bysort country_id (year): replace valid_control = 0 if rolling_sum_institutions != 0 | rolling_sum_institutions != 0 
replace control = 1 if valid_control == 1

drop valid_control  // Clean up

* Assign Event Time for Treated Observations
gen first_treatment_year = .
bysort country_id (year): replace first_treatment_year = year if treated == 1 & first_treatment_year == .
bysort country_id (year): replace first_treatment_year = first_treatment_year[_n-1] if first_treatment_year == . & _n > 1

* Compute event time (relative to treatment)
gen event_time = year - first_treatment_year

* Keep only relevant event times (-6 to +6)
keep if event_time >= -6 & event_time <= 6


* Run Difference-in-Differences Regression
reghdfe ln_capital_per_capita i.event_time##c.delta_institutions, absorb(country_id year) cluster(country_id)


