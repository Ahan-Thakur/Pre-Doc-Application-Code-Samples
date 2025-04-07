clear all
set matsize 5000
set more off


*Merge regions
global project "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code"

import delimited "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/global_data.csv", clear

import delimited "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/countrycode_regions.csv", clear varnames(1)

save "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/countrycode_regions.dta", replace

import delimited "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/global_data.csv", clear

merge m:1 countrycode using "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/countrycode_regions.dta"

drop if _merge == 2
drop _merge


encode countrycode, gen(ncountrycode)

xtset ncountrycode year

* Generate lagged variables explicitly
forvalues i = 1/25 {
    gen institutions_L`i' = L`i'.institutions
}

* Calculate the average of the 4 lags
egen institutions_L1_4_avg = rowmean(institutions_L1 institutions_L2 institutions_L3 institutions_L4)
egen institutions_L5_8_avg = rowmean(institutions_L5 institutions_L6 institutions_L7 institutions_L8)
egen institutions_L9_12_avg = rowmean(institutions_L9 institutions_L10 institutions_L11 institutions_L12)
egen institutions_L13_16_avg = rowmean(institutions_L13 institutions_L14 institutions_L15 institutions_L16)
egen institutions_L17_20_avg = rowmean(institutions_L17 institutions_L18 institutions_L19 institutions_L20)
egen institutions_L21_24_avg = rowmean(institutions_L21 institutions_L22 institutions_L23 institutions_L24)





