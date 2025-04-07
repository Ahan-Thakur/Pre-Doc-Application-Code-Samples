
	  
	   
****************************************
***  PHYSICAL CAPITAL PER CAPITA     ***
****************************************

tsset ncountrycode year

local H = 20  // maximum horizon

forvalues h = 0/`H' {
    gen ln_kpc_lead`h' = F`h'.ln_capital_per_capita
}

matrix IRF = J(`=`H'+1', 3, .)  // rows = H+1, columns = horizon / coef / se

forvalues h = 0/`H' {
    quietly reghdfe ln_kpc_lead`h' institutions ///
        L.ln_capital_per_capita, ///
        absorb(ncountrycode year)

    matrix IRF[`=`h'+1', 1] = `h'
    matrix IRF[`=`h'+1', 2] = _b[institutions]
    matrix IRF[`=`h'+1', 3] = _se[institutions]
}

clear
svmat IRF, names(col)

rename c1 horizon
rename c2 irf
rename c3 se

gen ub = irf + 1.96 * se
gen lb = irf - 1.96 * se

twoway (rarea ub lb horizon, color(gs15%80)) ///
       (line irf horizon, lwidth(medthick) lcolor(navy)), ///
       title("Impulse Response of log capital per capita to Institutional Shock") ///
       yline(0, lpattern(dash)) ///
       xtitle("Years after Shock") ytitle("Response") ///
       legend(on)

	 
****************************************************************************************

****************************************
***           HUMAN CAPITAL          ***
****************************************


	   
tsset ncountrycode year

local H = 20  // maximum horizon

forvalues h = 0/`H' {
    gen ln_hc_lead`h' = F`h'.ln_human_capital
}

matrix IRF = J(`=`H'+1', 3, .)  // rows = H+1, columns = horizon / coef / se

forvalues h = 0/`H' {
    quietly reghdfe ln_hc_lead`h' institutions ///
        L.ln_human_capital, ///
        absorb(ncountrycode year)

    matrix IRF[`=`h'+1', 1] = `h'
    matrix IRF[`=`h'+1', 2] = _b[institutions]
    matrix IRF[`=`h'+1', 3] = _se[institutions]
}

clear
svmat IRF, names(col)

rename c1 horizon
rename c2 irf
rename c3 se

gen ub = irf + 1.96 * se
gen lb = irf - 1.96 * se

twoway (rarea ub lb horizon, color(gs15%80)) ///
       (line irf horizon, lwidth(medthick) lcolor(navy)), ///
       title("Impulse Response of log human capital to Institutional Shock") ///
       yline(0, lpattern(dash)) ///
       xtitle("Years after Shock") ytitle("Response") ///
       legend(on)
	   
	   
	   
****************************************************************************************

****************************************
***              TFP                 ***
****************************************
	   
	   
tsset ncountrycode year

local H = 20  // maximum horizon

forvalues h = 0/`H' {
    gen ln_tfp_lead`h' = F`h'.ln_rtfpna
}

matrix IRF = J(`=`H'+1', 3, .)  // rows = H+1, columns = horizon / coef / se

forvalues h = 0/`H' {
    quietly reghdfe ln_tfp_lead`h' institutions ///
        L.ln_rtfpna, ///
        absorb(ncountrycode year)

    matrix IRF[`=`h'+1', 1] = `h'
    matrix IRF[`=`h'+1', 2] = _b[institutions]
    matrix IRF[`=`h'+1', 3] = _se[institutions]
}

clear
svmat IRF, names(col)

rename c1 horizon
rename c2 irf
rename c3 se

gen ub = irf + 1.96 * se
gen lb = irf - 1.96 * se

twoway (rarea ub lb horizon, color(gs15%80)) ///
       (line irf horizon, lwidth(medthick) lcolor(navy)), ///
       title("Impulse Response of log TFP(na) to Institutional Shock") ///
       yline(0, lpattern(dash)) ///
       xtitle("Years after Shock") ytitle("Response") ///
       legend(on)
	   
	   
	   
	   
	   
	   
tsset ncountrycode year

local H = 20  // maximum horizon

forvalues h = 0/`H' {
    gen ln_kpc_lead`h' = F`h'.ln_capital_per_capita
}

matrix IRF = J(`=`H'+1', 3, .)  // rows = H+1, columns = horizon / coef / se

forvalues h = 0/`H' {
    quietly reghdfe ln_kpc_lead`h' institutions ///
        L.ln_capital_per_capita, ///
        absorb(ncountrycode year)

    matrix IRF[`=`h'+1', 1] = `h'
    matrix IRF[`=`h'+1', 2] = _b[institutions]
    matrix IRF[`=`h'+1', 3] = _se[institutions]
}

clear
svmat IRF, names(col)

rename c1 horizon
rename c2 irf
rename c3 se

gen ub = irf + 1.96 * se
gen lb = irf - 1.96 * se

twoway (rarea ub lb horizon, color(gs15%80)) ///
       (line irf horizon, lwidth(medthick) lcolor(navy)), ///
       title("Impulse Response of log capital per capita to Capacity Shock") ///
       yline(0, lpattern(dash)) ///
       xtitle("Years after Shock") ytitle("Response") ///
       legend(on)
	   
	   
	   
	   
