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
gen institutions_L1 = L1.institutions
gen institutions_L2 = L2.institutions
gen institutions_L3 = L3.institutions
gen institutions_L4 = L4.institutions

gen institutions_L5 = L5.institutions
gen institutions_L6 = L6.institutions
gen institutions_L7 = L7.institutions
gen institutions_L8 = L8.institutions

* Calculate the average of the 4 lags
egen institutions_L1_4_avg = rowmean(institutions_L1 institutions_L2 institutions_L3 institutions_L4)
egen institutions_L5_8_avg = rowmean(institutions_L5 institutions_L6 institutions_L7 institutions_L8)

gen D_institutions_1_4_vs_5_8_avg = institutions_L1_4_avg - institutions_L5_8_avg

*Panel is not strongly balanced so we use System GMM*


*******************************************************
*******************************************************
*** Estimate dynamic panel model using System GMM ***
*******************************************************
*******************************************************



*************************************************************
*** Level of ln_capital_per_capita, Level of Institutions ***
*************************************************************

**Lag 1-4 of institutions, 1 lag of capital
**Instruments: Endogenous lags of capital 2-3, Endogenous lags of institutions 2-4

**N**
xtabond2 ln_capital_per_capita ///
         L(1/4).institutions ///
         L(1).ln_capital_per_capita, ///
         gmm(institutions, lag(2 4)) ///                                 
         gmm(L.ln_capital_per_capita, lag(2 3)) ///                      
         gmm(L.ln_capital_per_capita institutions, lag(1 1) equation(level)) ///      
         robust twostep

*Collapsing instruments

**N**
xtabond2 ln_capital_per_capita ///
         L(1/4).institutions ///
         L(1).ln_capital_per_capita, ///
         gmm(institutions, lag(2 4) collapse) ///                                 
         gmm(L.ln_capital_per_capita, lag(2 3)) ///                      
         gmm(L.ln_capital_per_capita institutions, lag(1 1) equation(level)) ///      
         robust twostep

		 
		 
**Average Lag 1-4 of institutions, 1 lag of capital
**Instruments: Endogenous lags of capital 2-3, Endogenous average lag of institutions 2-2

**N**
xtabond2 ln_capital_per_capita ///
         institutions_L1_4_avg ///
         L(1).ln_capital_per_capita, ///
         gmm(institutions_L1_4_avg, lag(2 4)) ///
         gmm(L.ln_capital_per_capita, lag(2 3)) ///
         gmm(L.ln_capital_per_capita institutions_L1_4_avg, lag(1 1) equation(level)) ///
         robust twostep



		 
*************************************************************
*** Growth of ln_capital_per_capita, Level of Institutions ***
*************************************************************

**Average Lag 1-4 of institutions, 1 lag of capital

xtabond2 D.ln_capital_per_capita ///
         institutions_L1_4_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L1_4_avg, lag(1 2) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) /// 
         gmm(L.D.ln_capital_per_capita institutions_L1_4_avg, lag(1 1) equation(level) collapse) ///
         robust twostep

**Average Lag 5-8 of institutions, 1 lag of capital

xtabond2 D.ln_capital_per_capita ///
         institutions_L5_8_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L5_8_avg, lag(1 2) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) /// 
         gmm(L.D.ln_capital_per_capita institutions_L5_8_avg, lag(1 1) equation(level) collapse) ///
         robust twostep

**Average Lag 1-4 of institutions, Average Lag 5-8 of institutions, 1 lag of capital

xtabond2 D.ln_capital_per_capita ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg, lag(2 4) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita institutions_L1_4_avg institutions_L5_8_avg, lag(1 1) equation(level) collapse) ///
         robust twostep

pwcorr institutions_L1_4_avg institutions_L5_8_avg, sig
**Correlation of 0.968
**Extremely high persistence of institutions introduces multicollinearity and excessively inflates standard errors






*************************************************************************
*** Growth of ln_capital_per_capita, Growth of Institutions, Averages ***
*************************************************************************

xtabond2 D.ln_capital_per_capita ///
         D_institutions_1_4_vs_5_8_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(D_institutions_1_4_vs_5_8_avg, lag(1 2) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) /// 
         gmm(L.D.ln_capital_per_capita D_institutions_1_4_vs_5_8_avg, lag(1 1) equation(level) collapse) ///
         robust twostep


*************************************************************************
*** Growth of ln_capital_per_capita, Growth of Institutions           ***
*************************************************************************

xtabond2 D.ln_capital_per_capita ///
         L(1/4).D.institutions ///
         L(1).D.ln_capital_per_capita, ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) ///
         gmm(L(1/4).D.institutions, lag(2 4) collapse) ///
         gmm(L.D.ln_capital_per_capita L(1/4).D.institutions, lag(1 1) equation(level) collapse) ///
         robust twostep









		 




		 


		 




         


		 



	
	
	
