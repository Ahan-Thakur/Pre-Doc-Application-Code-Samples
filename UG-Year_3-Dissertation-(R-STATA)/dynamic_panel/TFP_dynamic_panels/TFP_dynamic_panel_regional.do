set matsize 5000
set more off

cap ssc install xtabond2 
cap ssc install xtivreg2 
cap ssc install spmat 
cap ssc install spmack
cap ssc install xtdpdgmm


global project "C:/Ahan/Ahan/University 3rd Year/Dissertation/Dissertation Code"


********************************************************************************************************
****************************************
******      EU/EEA/CH/UK        ********
****************************************

****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1/2).D.ln_rtfpna ///
		 if custom_region == "europe", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1/2).D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L(1/2).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "europe", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "europe", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "europe", ///
    alpha(0) ///
    lopt ///
    seed(123) 	



********************************************************************************************************
*****************************************************
******      LATIN AMERICA & CARIBBEAN        ********
*****************************************************

****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "latin_america", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "latin_america", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "latin_america", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "latin_america", ///
    alpha(0) ///
    lopt ///
    seed(123) 	




********************************************************************************************************
*****************************************************
******          SOUTHEAST ASIA               ********
*****************************************************

****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "southeast_asia", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "southeast_asia", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "southeast_asia", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "southeast_asia", ///
    alpha(0) ///
    lopt ///
    seed(123) 	










********************************************************************************************************
*****************************************************
******          SOUTH ASIA                   ********
*****************************************************


****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "south_asia", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "south_asia", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "south_asia", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "south_asia", ///
    alpha(0) ///
    lopt ///
    seed(123) 	








********************************************************************************************************
*************************************************************
******          SUB SAHARAN AFRICA                   ********
*************************************************************


****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "sub_saharan_africa", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "sub_saharan_africa", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "sub_saharan_africa", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "sub_saharan_africa", ///
    alpha(0) ///
    lopt ///
    seed(123) 	















********************************************************************************************************
*************************************************************
******          CIS & Other Europe                 ********
*************************************************************


****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "cis", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "cis", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "cis", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(5 6) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(5 6) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "cis", ///
    alpha(0) ///
    lopt ///
    seed(123) 	









********************************************************************************************************
*************************************************************
******          Northeast Asia                       ********
*************************************************************


****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "northeast_asia", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "northeast_asia", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "northeast_asia", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "northeast_asia", ///
    alpha(0) ///
    lopt ///
    seed(123) 	








********************************************************************************************************
********************************************************************
******          Middle-East North-Africa                    ********
********************************************************************

****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "mena", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "mena", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "mena", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "mena", ///
    alpha(0) ///
    lopt ///
    seed(123) 	






********************************************************************************************************
********************************************************************
******          Oceania                                     ********
********************************************************************

****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "oceania", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "oceania", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "oceania", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "oceania", ///
    alpha(0) ///
    lopt ///
    seed(123) 	












********************************************************************************************************
********************************************************************
******          Northern America                            ********
********************************************************************



****************************************************************************
*** Growth of TFP, Level of Institutions, Joint Regression ***
****************************************************************************


xtabond2 D.ln_rtfpna ///
         institutions_L1_4_avg ///
         institutions_L5_8_avg ///
         institutions_L9_12_avg ///
         institutions_L13_16_avg ///
         institutions_L17_20_avg ///
         L(1).D.ln_rtfpna ///
		 if custom_region == "northern_america", ///
         gmm(institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
             institutions_L13_16_avg institutions_L17_20_avg L(1).D.ln_rtfpna, lag(2 3) collapse) ///
         gmm(L(1).D.ln_rtfpna institutions_L1_4_avg institutions_L5_8_avg ///
             institutions_L9_12_avg institutions_L13_16_avg institutions_L17_20_avg, ///
             lag(2 3) equation(level) collapse) ///
	     iv(year) ///
         robust twostep 
		 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    institutions_L1_4_avg institutions_L5_8_avg institutions_L9_12_avg ///
    institutions_L13_16_avg institutions_L17_20_avg ///
    L(1/2).D.ln_rtfpna ///
    i.year ///
	if custom_region == "northern_america", ///
    alpha(0) ///
    lopt ///
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
         L.D.ln_rtfpna ///
		 if custom_region == "northern_america", ///
         gmm(D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
             D.institutions_L13_16_avg D.institutions_L17_20_avg L.D.ln_rtfpna, lag(3 4) collapse) ///
         gmm(L.D.ln_rtfpna D.institutions_L1_4_avg D.institutions_L5_8_avg ///
             D.institutions_L9_12_avg D.institutions_L13_16_avg D.institutions_L17_20_avg, ///
             lag(3 4) equation(level) collapse) ///
		 iv(year) ///
         robust twostep 
		 

*Alpha = 0: Ridge 		 
cvlasso D.ln_rtfpna ///
    D.institutions_L1_4_avg D.institutions_L5_8_avg D.institutions_L9_12_avg ///
    D.institutions_L13_16_avg D.institutions_L17_20_avg ///
    L.D.ln_rtfpna ///
    i.year ///
	if custom_region == "northern_america", ///
    alpha(0) ///
    lopt ///
    seed(123) 	















