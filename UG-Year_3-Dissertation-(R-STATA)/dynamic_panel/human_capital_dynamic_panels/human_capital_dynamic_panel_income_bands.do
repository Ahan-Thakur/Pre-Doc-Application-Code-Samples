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
*** Restrict dataset to only include countries with 2019 gdppc <=10000 ***
*** approx. percentiles 1-30
****************************************************************************


gen gdp_ok = (year == 2019 & gdp_per_capita <= 10000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country


		 
****************************************************************************
*** Growth of ln_human_capital, Level of Institutions, Joint Regression ***
****************************************************************************

xtabond2 D.ln_human_capital ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)
         robust twostep
		 


*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	
*Diagnostics: negative coefficient on institutions_L1_4_avg
cvlasso D.ln_human_capital institutions_L1_4_avg L.ln_human_capital i.year, alpha(0) lopt


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)
		 
		 
****************************************************************************
*** Growth of ln_human_capital, Growth of Institutions, Joint Regression ***
****************************************************************************
*iv(year) does not pass Hansen test, need to absorb years
		 

xtabond2 D.ln_human_capital ///
         D.institutions_L1_4_avg ///
         D.institutions_L5_8_avg ///
         D.institutions_L9_12_avg ///
         D.institutions_L13_16_avg ///
         D.institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)///
         robust twostep
		 
*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)


*****************************************************************************************************************
**********************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc 10000<...<=17000 ***
*** approx. percentiles 30-50
**********************************************************************************

gen gdp_ok = (year == 2019 & gdp_per_capita > 10000 & gdp_per_capita <= 17000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country

		 
****************************************************************************
*** Growth of ln_human_capital, Level of Institutions, Joint Regression ***
****************************************************************************

xtabond2 D.ln_human_capital ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)
         robust twostep
		 


*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	
*Diagnostics: negative coefficient on institutions_L1_4_avg
cvlasso D.ln_human_capital institutions_L1_4_avg L.ln_human_capital i.year, alpha(0) lopt


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)
		 
		 
****************************************************************************
*** Growth of ln_human_capital, Growth of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_human_capital ///
         D.institutions_L1_4_avg ///
         D.institutions_L5_8_avg ///
         D.institutions_L9_12_avg ///
         D.institutions_L13_16_avg ///
         D.institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)///
         robust twostep
		 
*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)
		 


*****************************************************************************************************************
**********************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc 17000<...<=32000 ***
*** approx percentiles 50-70
**********************************************************************************

gen gdp_ok = (year == 2019 & gdp_per_capita > 17000 & gdp_per_capita <= 32000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country



		 
****************************************************************************
*** Growth of ln_human_capital, Level of Institutions, Joint Regression ***
****************************************************************************

xtabond2 D.ln_human_capital ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)
         robust twostep
		 


*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	
*Diagnostics: negative coefficient on institutions_L1_4_avg
cvlasso D.ln_human_capital institutions_L1_4_avg L.ln_human_capital i.year, alpha(0) lopt


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)
		 
		 
****************************************************************************
*** Growth of ln_human_capital, Growth of Institutions, Joint Regression ***
****************************************************************************
*iv(year) does not pass Hansen test, need to absorb years
		 

xtabond2 D.ln_human_capital ///
         D.institutions_L1_4_avg ///
         D.institutions_L5_8_avg ///
         D.institutions_L9_12_avg ///
         D.institutions_L13_16_avg ///
         D.institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)///
         robust twostep
		 
*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)
	

*****************************************************************************************************************
**********************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc 32000<...<=53000 ***
*** approx percemtiles 70-90
**********************************************************************************

gen gdp_ok = (year == 2019 & gdp_per_capita > 32000 & gdp_per_capita <= 53000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country


		 
****************************************************************************
*** Growth of ln_human_capital, Level of Institutions, Joint Regression ***
****************************************************************************

xtabond2 D.ln_human_capital ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
		 `yeardummies1' ///
         L(1).D.ln_human_capital, ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)
         robust twostep
		 


*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	
*Diagnostics: negative coefficient on institutions_L1_4_avg
cvlasso D.ln_human_capital institutions_L1_4_avg L.ln_human_capital i.year, alpha(0) lopt


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)
		 
		 
****************************************************************************
*** Growth of ln_human_capital, Growth of Institutions, Joint Regression ***
****************************************************************************
*iv(year) does not pass Hansen test, need to absorb years
		 

xtabond2 D.ln_human_capital ///
         D.institutions_L1_4_avg ///
         D.institutions_L5_8_avg ///
         D.institutions_L9_12_avg ///
         D.institutions_L13_16_avg ///
         D.institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)///
         robust twostep
		 
*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)


*****************************************************************************************************************
**********************************************************************************
*** Restrict dataset to only include countries with 2019 gdppc 53000<...       ***
*** approx percemtiles 90-99
**********************************************************************************

gen gdp_ok = (year == 2019 & gdp_per_capita > 53000)
bysort ncountrycode (year): egen keep_country = max(gdp_ok)
keep if keep_country == 1
drop gdp_ok keep_country


		 
****************************************************************************
*** Growth of ln_human_capital, Level of Institutions, Joint Regression ***
****************************************************************************

xtabond2 D.ln_human_capital ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)
         robust twostep
		 


*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	
*Diagnostics: negative coefficient on institutions_L1_4_avg
cvlasso D.ln_human_capital institutions_L1_4_avg L.ln_human_capital i.year, alpha(0) lopt


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)
		 
		 
****************************************************************************
*** Growth of ln_human_capital, Growth of Institutions, Joint Regression ***
****************************************************************************
*iv(year) does not pass Hansen test, need to absorb years
		 

xtabond2 D.ln_human_capital ///
         D.institutions_L1_4_avg ///
         D.institutions_L5_8_avg ///
         D.institutions_L9_12_avg ///
         D.institutions_L13_16_avg ///
         D.institutions_L17_20_avg ///
         L(1).D.ln_human_capital, ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_human_capital, lag(2 3) collapse) ///
         gmm(L.D.ln_human_capital D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year)///
         robust twostep
		 
*Alpha = 0: Ridge 		 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	


*Alpha = 0.5: Elastic net 
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_human_capital ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_human_capital ///
    i.year, ///
    alpha(1) ///
    seed(123)