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
             institutions_L13_16_avg institutions_L17_20_avg L(1/2).D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L(1/2).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
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
	


****************************************************************************
*** Growth of TFP, Growth of Institutions, Joint Regression ***
****************************************************************************

xtabond2 D.ln_rtfpna ///
         D.institutions_L1_4_avg ///
         D.institutions_L5_8_avg ///
         D.institutions_L9_12_avg ///
         D.institutions_L13_16_avg ///
         D.institutions_L17_20_avg ///
         L.D.ln_rtfpna, ///
		 `yeardummies' ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123) 	


*Alpha = 0.5: Elastic net 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year, ///
    alpha(0.5) ///
    lopt ///
    seed(123)
	

*Alpha = 1: Lasso
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year, ///
    alpha(1) ///
    seed(123)


	
	
	

