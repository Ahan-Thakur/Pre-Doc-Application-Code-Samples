clear all
set matsize 5000
set more off

cap ssc install xtabond2 
cap ssc install xtivreg2 
cap ssc install spmat 
cap ssc install spmack
cap ssc install xtdpdgmm


global project "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code"

import delimited "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code/unified_dataset/global_data.csv"

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

gen D_institutions_1_4_vs_5_8_avg = institutions_L1_4_avg - institutions_L5_8_avg

*Panel is not strongly balanced so we use System GMM*


*******************************************************
*******************************************************
*** Estimate dynamic panel model using System GMM ***
*******************************************************
*******************************************************


*************************************************************
*** Growth of ln_capital_per_capita, Level of Institutions ***
*************************************************************

**Average Lag 1-4 of institutions, 1 lag of capital

xtabond2 D.ln_human_capital ///
         institutions_L1_4_avg ///
         L(1).D.ln_human_capital, ///
         gmm(institutions_L1_4_avg, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital, lag(2 3) collapse) /// 
         gmm(L.D.ln_human_capital institutions_L1_4_avg, lag(2 3) equation(level) collapse) ///
         robust twostep

**Average Lag 5-8 of institutions, 1 lag of capital

xtabond2 D.ln_human_capital ///
         institutions_L5_8_avg ///
         L(1).D.ln_human_capital, ///
         gmm(institutions_L5_8_avg, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital, lag(2 3) collapse) /// 
         gmm(L.D.ln_human_capital institutions_L5_8_avg, lag(2 3) equation(level) collapse) ///
         robust twostep
		 
