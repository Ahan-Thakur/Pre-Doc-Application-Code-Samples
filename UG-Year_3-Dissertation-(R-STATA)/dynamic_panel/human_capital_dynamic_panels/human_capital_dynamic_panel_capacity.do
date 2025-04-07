clear

set matsize 5000
set more off

cap ssc install xtabond2 
cap ssc install xtivreg2 
cap ssc install spmat 
cap ssc install spmack
cap ssc install xtdpdgmm


*******************************************************
*******************************************************
***    HUMAN CAPITAL DYNAMIC PANELS SYSTEM GMM      ***
*******************************************************
*******************************************************


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
		 
		 