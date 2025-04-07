set matsize 5000
set more off

cap ssc install xtabond2 
cap ssc install xtivreg2 
cap ssc install spmat 
cap ssc install spmack
cap ssc install xtdpdgmm


global project "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code"


*****************************************************************************************************************
****************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc <=8000 ***
*** approx. percentiles 1-30
****************************************************************************


gen gdp_ok = (year == 2015 & gdp_per_capita <= 8000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country


****************************************************************************
*** Growth of ln_capital_per_capita, Level of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         capacity_L1_4_avg ///
         capacity_L5_8_avg ///
         capacity_L9_12_avg ///
         capacity_L13_16_avg ///
         capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(capacity_L1_4_avg capacity_L5_8_avg capacity_L9_12_avg ///
             capacity_L13_16_avg capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital capacity_L1_4_avg capacity_L5_8_avg ///
             capacity_L9_12_avg capacity_L13_16_avg capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.capacity_L1_4_avg ///
         D.capacity_L5_8_avg ///
         D.capacity_L9_12_avg ///
         D.capacity_L13_16_avg ///
         D.capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.capacity_L1_4_avg D.capacity_L5_8_avg D.capacity_L9_12_avg ///
             D.capacity_L13_16_avg D.capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.capacity_L1_4_avg D.capacity_L5_8_avg ///
             D.capacity_L9_12_avg D.capacity_L13_16_avg D.capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 

****************************************************************************
*** Growth of ln_capital_per_capita, Level of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         insticap_L1_4_avg ///
         insticap_L5_8_avg ///
         insticap_L9_12_avg ///
         insticap_L13_16_avg ///
         insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(insticap_L1_4_avg insticap_L5_8_avg insticap_L9_12_avg ///
             insticap_L13_16_avg insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital insticap_L1_4_avg insticap_L5_8_avg ///
             insticap_L9_12_avg insticap_L13_16_avg insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.insticap_L1_4_avg ///
         D.insticap_L5_8_avg ///
         D.insticap_L9_12_avg ///
         D.insticap_L13_16_avg ///
         D.insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.insticap_L1_4_avg D.insticap_L5_8_avg D.insticap_L9_12_avg ///
             D.insticap_L13_16_avg D.insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.insticap_L1_4_avg D.insticap_L5_8_avg ///
             D.insticap_L9_12_avg D.insticap_L13_16_avg D.insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 



*****************************************************************************************************************
**********************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc 8000<...<=15000 ***
*** approx. percentiles 30-50
**********************************************************************************

gen gdp_ok = (year == 2015 & gdp_per_capita > 8000 & gdp_per_capita <= 15000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country



****************************************************************************
*** Growth of ln_capital_per_capita, Level of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         capacity_L1_4_avg ///
         capacity_L5_8_avg ///
         capacity_L9_12_avg ///
         capacity_L13_16_avg ///
         capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(capacity_L1_4_avg capacity_L5_8_avg capacity_L9_12_avg ///
             capacity_L13_16_avg capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital capacity_L1_4_avg capacity_L5_8_avg ///
             capacity_L9_12_avg capacity_L13_16_avg capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.capacity_L1_4_avg ///
         D.capacity_L5_8_avg ///
         D.capacity_L9_12_avg ///
         D.capacity_L13_16_avg ///
         D.capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.capacity_L1_4_avg D.capacity_L5_8_avg D.capacity_L9_12_avg ///
             D.capacity_L13_16_avg D.capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.capacity_L1_4_avg D.capacity_L5_8_avg ///
             D.capacity_L9_12_avg D.capacity_L13_16_avg D.capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 

****************************************************************************
*** Growth of ln_capital_per_capita, Level of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         insticap_L1_4_avg ///
         insticap_L5_8_avg ///
         insticap_L9_12_avg ///
         insticap_L13_16_avg ///
         insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(insticap_L1_4_avg insticap_L5_8_avg insticap_L9_12_avg ///
             insticap_L13_16_avg insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital insticap_L1_4_avg insticap_L5_8_avg ///
             insticap_L9_12_avg insticap_L13_16_avg insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.insticap_L1_4_avg ///
         D.insticap_L5_8_avg ///
         D.insticap_L9_12_avg ///
         D.insticap_L13_16_avg ///
         D.insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.insticap_L1_4_avg D.insticap_L5_8_avg D.insticap_L9_12_avg ///
             D.insticap_L13_16_avg D.insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.insticap_L1_4_avg D.insticap_L5_8_avg ///
             D.insticap_L9_12_avg D.insticap_L13_16_avg D.insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*****************************************************************************************************************
**********************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc 15000<...<=27000 ***
*** approx percentiles 50-70
**********************************************************************************

gen gdp_ok = (year == 2015 & gdp_per_capita > 15000 & gdp_per_capita <= 27000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country


****************************************************************************
*** Growth of ln_capital_per_capita, Level of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         capacity_L1_4_avg ///
         capacity_L5_8_avg ///
         capacity_L9_12_avg ///
         capacity_L13_16_avg ///
         capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(capacity_L1_4_avg capacity_L5_8_avg capacity_L9_12_avg ///
             capacity_L13_16_avg capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital capacity_L1_4_avg capacity_L5_8_avg ///
             capacity_L9_12_avg capacity_L13_16_avg capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.capacity_L1_4_avg ///
         D.capacity_L5_8_avg ///
         D.capacity_L9_12_avg ///
         D.capacity_L13_16_avg ///
         D.capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.capacity_L1_4_avg D.capacity_L5_8_avg D.capacity_L9_12_avg ///
             D.capacity_L13_16_avg D.capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.capacity_L1_4_avg D.capacity_L5_8_avg ///
             D.capacity_L9_12_avg D.capacity_L13_16_avg D.capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 

****************************************************************************
*** Growth of ln_capital_per_capita, Level of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         insticap_L1_4_avg ///
         insticap_L5_8_avg ///
         insticap_L9_12_avg ///
         insticap_L13_16_avg ///
         insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(insticap_L1_4_avg insticap_L5_8_avg insticap_L9_12_avg ///
             insticap_L13_16_avg insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital insticap_L1_4_avg insticap_L5_8_avg ///
             insticap_L9_12_avg insticap_L13_16_avg insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.insticap_L1_4_avg ///
         D.insticap_L5_8_avg ///
         D.insticap_L9_12_avg ///
         D.insticap_L13_16_avg ///
         D.insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.insticap_L1_4_avg D.insticap_L5_8_avg D.insticap_L9_12_avg ///
             D.insticap_L13_16_avg D.insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.insticap_L1_4_avg D.insticap_L5_8_avg ///
             D.insticap_L9_12_avg D.insticap_L13_16_avg D.insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 


*****************************************************************************************************************
**********************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc 27000<...<=48000 ***
*** approx percemtiles 70-90
**********************************************************************************

gen gdp_ok = (year == 2015 & gdp_per_capita > 27000 & gdp_per_capita <= 48000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country


****************************************************************************
*** Growth of ln_capital_per_capita, Level of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         capacity_L1_4_avg ///
         capacity_L5_8_avg ///
         capacity_L9_12_avg ///
         capacity_L13_16_avg ///
         capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(capacity_L1_4_avg capacity_L5_8_avg capacity_L9_12_avg ///
             capacity_L13_16_avg capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital capacity_L1_4_avg capacity_L5_8_avg ///
             capacity_L9_12_avg capacity_L13_16_avg capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.capacity_L1_4_avg ///
         D.capacity_L5_8_avg ///
         D.capacity_L9_12_avg ///
         D.capacity_L13_16_avg ///
         D.capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.capacity_L1_4_avg D.capacity_L5_8_avg D.capacity_L9_12_avg ///
             D.capacity_L13_16_avg D.capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.capacity_L1_4_avg D.capacity_L5_8_avg ///
             D.capacity_L9_12_avg D.capacity_L13_16_avg D.capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 

****************************************************************************
*** Growth of ln_capital_per_capita, Level of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         insticap_L1_4_avg ///
         insticap_L5_8_avg ///
         insticap_L9_12_avg ///
         insticap_L13_16_avg ///
         insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(insticap_L1_4_avg insticap_L5_8_avg insticap_L9_12_avg ///
             insticap_L13_16_avg insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital insticap_L1_4_avg insticap_L5_8_avg ///
             insticap_L9_12_avg insticap_L13_16_avg insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.insticap_L1_4_avg ///
         D.insticap_L5_8_avg ///
         D.insticap_L9_12_avg ///
         D.insticap_L13_16_avg ///
         D.insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.insticap_L1_4_avg D.insticap_L5_8_avg D.insticap_L9_12_avg ///
             D.insticap_L13_16_avg D.insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.insticap_L1_4_avg D.insticap_L5_8_avg ///
             D.insticap_L9_12_avg D.insticap_L13_16_avg D.insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 


*****************************************************************************************************************
**********************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc 48000<...       ***
*** approx percemtiles 90-99
**********************************************************************************

gen gdp_ok = (year == 2015 & gdp_per_capita > 48000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country


****************************************************************************
*** Growth of ln_capital_per_capita, Level of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         capacity_L1_4_avg ///
         capacity_L5_8_avg ///
         capacity_L9_12_avg ///
         capacity_L13_16_avg ///
         capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(capacity_L1_4_avg capacity_L5_8_avg capacity_L9_12_avg ///
             capacity_L13_16_avg capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital capacity_L1_4_avg capacity_L5_8_avg ///
             capacity_L9_12_avg capacity_L13_16_avg capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of Capacity, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.capacity_L1_4_avg ///
         D.capacity_L5_8_avg ///
         D.capacity_L9_12_avg ///
         D.capacity_L13_16_avg ///
         D.capacity_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.capacity_L1_4_avg D.capacity_L5_8_avg D.capacity_L9_12_avg ///
             D.capacity_L13_16_avg D.capacity_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.capacity_L1_4_avg D.capacity_L5_8_avg ///
             D.capacity_L9_12_avg D.capacity_L13_16_avg D.capacity_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 

****************************************************************************
*** Growth of ln_capital_per_capita, Level of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         insticap_L1_4_avg ///
         insticap_L5_8_avg ///
         insticap_L9_12_avg ///
         insticap_L13_16_avg ///
         insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(insticap_L1_4_avg insticap_L5_8_avg insticap_L9_12_avg ///
             insticap_L13_16_avg insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital insticap_L1_4_avg insticap_L5_8_avg ///
             insticap_L9_12_avg insticap_L13_16_avg insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
****************************************************************************
*** Growth of ln_capital_per_capita, Growth of insticap, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.insticap_L1_4_avg ///
         D.insticap_L5_8_avg ///
         D.insticap_L9_12_avg ///
         D.insticap_L13_16_avg ///
         D.insticap_L17_20_avg ///
         L.D.ln_human_capital, ///
         gmm(D.insticap_L1_4_avg D.insticap_L5_8_avg D.insticap_L9_12_avg ///
             D.insticap_L13_16_avg D.insticap_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.insticap_L1_4_avg D.insticap_L5_8_avg ///
             D.insticap_L9_12_avg D.insticap_L13_16_avg D.insticap_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
