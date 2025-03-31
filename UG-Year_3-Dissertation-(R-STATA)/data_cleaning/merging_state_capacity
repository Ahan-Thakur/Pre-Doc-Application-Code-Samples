cd "C:\Ahan\Ahan\University 3rd Year\Dissertation\Dissertation Code\unified_dataset"

use "C:\Ahan\Ahan\University 3rd Year\Dissertation\Dissertation Code\state_capacity_data_raw\StateCapacityDataset_v1.dta", clear

rename iso3 countrycode

sort countrycode year
save temp_statecapacity.dta, replace

import delimited "C:\Ahan\Ahan\University 3rd Year\Dissertation\Dissertation Code\unified_dataset\global_data.csv", clear

sort countrycode year

merge 1:1 countrycode year using temp_statecapacity.dta

tab _merge

drop if missing(cgdpo)
drop if missing(Capacity)

drop _merge

save "global_data_sc.dta", replace

erase temp_statecapacity.dta
