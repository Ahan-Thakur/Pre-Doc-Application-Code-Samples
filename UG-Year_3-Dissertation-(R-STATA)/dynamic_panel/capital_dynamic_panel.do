

set matsize 5000
set more off

cap ssc install xtabond2 
cap ssc install xtivreg2 
cap ssc install spmat 
cap ssc install spmack
cap ssc install xtdpdgmm
cap ssc install ridge2sls


global project "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code"


*******************************************************
*******************************************************
***       CAPITAL DYNAMIC PANELS SYSTEM GMM         ***
*******************************************************
*******************************************************


****************************************************************************
*** Growth of ln_capital_per_capita, Level of Institutions, Joint Regression ***
****************************************************************************



xtabond2 D.ln_capital_per_capita ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 

xtabond2 D.ln_capital_per_capita ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L.D.ln_capital_per_capita, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 
		 
		 
ridge2sls D.ln_capital_per_capita ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_capital_per_capita ///
    (institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
     institutions_L13_16_avg institutions_L17_20_avg L.D.ln_capital_per_capita) ///
    i.year ///
    ridge(orr) kr(0.0001)
		 
		 
cvlasso D.ln_capital_per_capita ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    D.L.ln_capital_per_capita ///
    i.year, ///
    alpha(0) ///
    lopt ///
    seed(123)
	
ridge2sls D.ln_capital_per_capita ///
     institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
     institutions_L13_16_avg institutions_L17_20_avg ///
     L.D.ln_capital_per_capita ///
    (institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
     institutions_L13_16_avg institutions_L17_20_avg ///
     L.D.ln_capital_per_capita) ///
     ridge(orr) kr(0.0001) diag
	
	
cvlasso D.ln_capital_per_capita ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_capital_per_capita ///
    i.year, ///
    alpha(0 0.25 0.5 0.75 1) ///
    seed(123)

cvlasso D.ln_capital_per_capita ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L.D.ln_capital_per_capita ///
    i.year, ///
    alpha(1) ///
    lopt ///
    seed(123)


****************************************************************************
*** Growth of ln_capital_per_capita, Level of Institutions, 4 year bins ***
****************************************************************************

**Average Lag 1-4 of institutions, 1 lag of capital

xtabond2 D.ln_capital_per_capita ///
         institutions_L1_4_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L1_4_avg, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) /// 
         gmm(L.D.ln_capital_per_capita institutions_L1_4_avg, lag(3 4) equation(level) collapse) ///
         robust twostep

		 

**Average Lag 5-8 of institutions, 1 lag of capital

xtabond2 D.ln_capital_per_capita ///
         institutions_L5_8_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L5_8_avg, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) /// 
         gmm(L.D.ln_capital_per_capita institutions_L5_8_avg, lag(2 3) equation(level) collapse) ///
         robust twostep

**Average Lag 9-12 of institutions, 1 lag of capital
		 
xtabond2 D.ln_capital_per_capita ///
         institutions_L9_12_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L9_12_avg, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) /// 
         gmm(L.D.ln_capital_per_capita institutions_L9_12_avg, lag(2 3) equation(level) collapse) ///
         robust twostep
		 
**Average Lag 13-16 of institutions, 1 lag of capital 
		 
xtabond2 D.ln_capital_per_capita ///
         institutions_L13_16_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L13_16_avg, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) /// 
         gmm(L.D.ln_capital_per_capita institutions_L13_16_avg, lag(2 3) equation(level) collapse) ///
         robust twostep
		 
		 
**Average Lag 17-20 of institutions, 1 lag of capital 
		 
xtabond2 D.ln_capital_per_capita ///
         institutions_L17_20_avg ///
         L(1).D.ln_capital_per_capita, ///
         gmm(institutions_L17_20_avg, lag(2 3) collapse) ///
         gmm(L.D.ln_capital_per_capita, lag(2 3) collapse) /// 
         gmm(L.D.ln_capital_per_capita institutions_L17_20_avg, lag(2 3) equation(level) collapse) ///
         robust twostep


		 
		 

