set matsize 5000
set more off

cap ssc install xtabond2 
cap ssc install xtivreg2 
cap ssc install spmat 
cap ssc install spmack
cap ssc install xtdpdgmm


global project "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code"


*******************************************************
*******************************************************
*** Estimate dynamic panel model using System GMM ***
*******************************************************
*******************************************************


****************************************************************************
*** Growth of TFP, Level of Institutions, 4 year bins ***
****************************************************************************

**Average Lag 1-4 of institutions, 1 lag of TFP

xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         L(1/3).D.ln_rtfpna, ///
         gmm(institutions_L1_4_avg, lag(5 6) collapse) ///
         gmm(L.D.ln_rtfpna, lag(5 6) collapse) /// 
         gmm(L.D.ln_rtfpna institutions_L1_4_avg, lag(5 6) equation(level) collapse) ///
         robust twostep

		 
		 
**Average Lag 5-8 of institutions, 1 lag of TFP

xtabond2 D.ln_rtfpna ///
         institutions_L5_8_avg ///
         L(1/2).D.ln_rtfpna, ///
         gmm(institutions_L5_8_avg, lag(5 6) collapse) ///
         gmm(L.D.ln_rtfpna, lag(5 6) collapse) /// 
         gmm(L.D.ln_rtfpna institutions_L5_8_avg, lag(5 6) equation(level) collapse) ///
         robust twostep

**Average Lag 9-12 of institutions, 1 lag of TFP
		 
xtabond2 D.ln_rtfpna ///
         institutions_L9_12_avg ///
         L(1/2).D.ln_rtfpna, ///
         gmm(institutions_L9_12_avg, lag(5 6) collapse) ///
         gmm(L.D.ln_rtfpna, lag(5 6) collapse) /// 
         gmm(L.D.ln_rtfpna institutions_L9_12_avg, lag(5 6) equation(level) collapse) ///
         robust twostep
		 
**Average Lag 13-16 of institutions, 1 lag of TFP 
		 
xtabond2 D.ln_rtfpna ///
         institutions_L13_16_avg ///
         L(1/2).D.ln_rtfpna, ///
         gmm(institutions_L13_16_avg, lag(5 6) collapse) ///
         gmm(L.D.ln_rtfpna, lag(5 6) collapse) /// 
         gmm(L.D.ln_rtfpna institutions_L13_16_avg, lag(5 6) equation(level) collapse) ///
         robust twostep



		 
****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************

tabulate year, generate(year_dummy)
ds year_dummy*
local yeardummies `r(varlist)'

xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1/2).D.ln_rtfpna, ///
		 `yeardummies' ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123) 	


*Alpha = 0.5: Elastic net 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year, ///
    alpha(1) ///
    seed(123)
