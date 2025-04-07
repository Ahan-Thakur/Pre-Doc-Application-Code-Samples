clear all
set matsize 5000
set more off

use "C:\Ahan\Ahan\University 3rd Year\Dissertation\Dissertation Code\unified_dataset\global_data_sc.dta"

import delimited "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/countrycode_regions.csv", clear varnames(1)

save "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/countrycode_regions.dta", replace

use "C:\Ahan\Ahan\University 3rd Year\Dissertation\Dissertation Code\unified_dataset\global_data_sc.dta"

merge m:1 countrycode using "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/countrycode_regions.dta"

drop if _merge == 2
drop _merge

encode countrycode, gen(ncountrycode)

xtset ncountrycode year

* Generate lagged variables explicitly
forvalues i = 1/25 {
    gen Capacity_L`i' = L`i'.institutions
}

* Calculate the average of the 4 lags
egen capacity_L1_4_avg = rowmean(Capacity_L1 Capacity_L2 Capacity_L3 Capacity_L4)
egen capacity_L5_8_avg = rowmean(Capacity_L5 Capacity_L6 Capacity_L7 Capacity_L8)
egen capacity_L9_12_avg = rowmean(Capacity_L9 Capacity_L10 Capacity_L11 Capacity_L12)
egen capacity_L13_16_avg = rowmean(Capacity_L13 Capacity_L14 Capacity_L15 Capacity_L16)
egen capacity_L17_20_avg = rowmean(Capacity_L17 Capacity_L18 Capacity_L19 Capacity_L20)
egen capacity_L21_24_avg = rowmean(Capacity_L21 Capacity_L22 Capacity_L23 Capacity_L24)




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




forvalues i = 1/25 {
    gen insticap_L`i' = L`i'.insticap
}

* Calculate the average of the 4 lags
egen insticap_L1_4_avg = rowmean(insticap_L1 insticap_L2 insticap_L3 insticap_L4)
egen insticap_L5_8_avg = rowmean(insticap_L5 insticap_L6 insticap_L7 insticap_L8)
egen insticap_L9_12_avg = rowmean(insticap_L9 insticap_L10 insticap_L11 insticap_L12)
egen insticap_L13_16_avg = rowmean(insticap_L13 insticap_L14 insticap_L15 insticap_L16)
egen insticap_L17_20_avg = rowmean(insticap_L17 insticap_L18 insticap_L19 insticap_L20)
egen insticap_L21_24_avg = rowmean(insticap_L21 insticap_L22 insticap_L23 insticap_L24)






