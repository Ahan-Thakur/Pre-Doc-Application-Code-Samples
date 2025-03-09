use "C:\Users\leyat20\OneDrive - The University of Nottingham\Applied Econometrics II Coursework\oecd_phillips_assignment.dta", clear
tsset qdate 

twoway (tsline dinf_USA) 
twoway (tsline dinf_MEX)
twoway (tsline dunemp_USA) 
twoway (tsline dunemp_MEX)
twoway (tsline inflation_USA) 
twoway (tsline inflation_MEX)
twoway (tsline unemp_USA) 
twoway (tsline unemp_MEX)

twoway (tsline dinf_USA dunemp_USA)
twoway (tsline dinf_MEX dunemp_MEX)

graph twoway scatter (inflation_USA unemp_USA)

gen tb = ((qdate>=1990q1 & qdate<=2015q4))


label variable tb "Time Break"

corrgram dinf_MEX if tb==1

ac dinf_MEX if tb == 1
pac dinf_MEX if tb == 1

corrgram dinf_USA if tb == 1

ac dinf_USA if tb == 1
pac dinf_USA if tb == 1

summarize dinf_MEX
summarize dinf_USA

summarize dunemp_MEX
summarize dunemp_USA

*QUESTION2

*USA AR(1)
reg dunemp_USA l(1/1).dunemp_USA if tb==1
estat bgodfrey, lag(4)
estat ic
*-25.91896  -20.79027

*USA AR(2)
reg dunemp_USA l(1/2).dunemp_USA if tb==1
estat bgodfrey, lag(4)
estat ic
*-25.66748  -17.97444

*USA AR(3)
reg dunemp_USA l(1/3).dunemp_USA if tb==1
estat bgodfrey, lag(4)
estat ic
*-23.82753  -13.57014

*USA AR(4)
reg dunemp_USA l(1/4).dunemp_USA if tb==1
estat bgodfrey, lag(4)
estat ic
*-23.93075  -11.10901

*USA ARDL(1,1) yes 1
reg dunemp_USA l(1/1).dunemp_USA l(1/1).dinf_USA if tb==1
estat bgodfrey, lag(4)
estat ic
nlcom ((_b[L1.dinf_USA]) / (1-_b[L1.dunemp_USA]))
predict f1
gen u1 = dunemp_USA - f1
predict sef1, stdp
gen LL1 = f1 - 1.645*sef1
gen UL1 = f1 + 1.645*sef1
gen u1_sqr = u1^2
gen abu1 = abs(u1)

list qdate dunemp_USA f1 LL1 UL1 u1 u1_sqr abu1 if tin(2016q1,2019q4), separator(0) noobs

*-27.34627  -19.65322

*USA ARDL(1,2) yes 2
reg dunemp_USA l(1/1).dunemp_USA l(1/2).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
nlcom ((_b[L1.dinf_USA] + _b[L2.dinf_USA]) / (1-_b[L1.dunemp_USA] ))
predict f2
gen u2 = dunemp_USA - f2
predict sef2, stdp
gen LL2 = f2 - 1.645*sef2
gen UL2 = f2 + 1.645*sef2
gen u2_sqr = u2^2
gen abu2 = abs(u2)
list qdate dunemp_USA f2 LL2 UL2 u2 u2_sqr abu2 if tin(2016q1,2019q4)
* -26.70637  -16.44897

*USA ARDL(1,3)
reg dunemp_USA l(1/1).dunemp_USA l(1/3).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
* -25.36709  -12.54535

*USA ARDL(1,4)
reg dunemp_USA l(1/1).dunemp_USA l(1/4).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-24.0952  -8.709115

*USA ARDL(2,1) 
reg dunemp_USA l(1/2).dunemp_USA l(1/1).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-26.65226  -16.39487

*USA ARDL(2,2)
reg dunemp_USA l(1/2).dunemp_USA l(1/2).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-26.17411  -13.35237

*USA ARDL(2,3)
reg dunemp_USA l(1/2).dunemp_USA l(1/3).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-25.75628  -10.37019

*USA ARDL(2,4)
reg dunemp_USA l(1/2).dunemp_USA l(1/4).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-25.11237   -7.16193

*USA ARDL(3,1)
reg dunemp_USA l(1/3).dunemp_USA l(1/1).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-24.66004   -11.8383

*USA ARDL(3,2)
reg dunemp_USA l(1/3).dunemp_USA l(1/2).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-24.1845  -8.798409

*USA ARDL(3,3)
reg dunemp_USA l(1/3).dunemp_USA l(1/3).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-23.76468  -5.814244

*USA ARDL(3,4)
reg dunemp_USA l(1/3).dunemp_USA l(1/4).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-23.35817  -2.843384

*USA ARDL(4,1)
reg dunemp_USA l(1/4).dunemp_USA l(1/1).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-23.6689  -8.282812

*USA ARDL(4,2)
reg dunemp_USA l(1/4).dunemp_USA l(1/2).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-23.58194  -5.631499

*USA ARDL(4,3)
reg dunemp_USA l(1/4).dunemp_USA l(1/3).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
*-22.92874  -2.413956

*USA ARDL(4,4) worst yes
reg dunemp_USA l(1/4).dunemp_USA l(1/4).dinf_US if tb==1
estat bgodfrey, lag(4)
estat ic
nlcom ((_b[L1.dinf_USA] + _b[L2.dinf_USA] + _b[L3.dinf_USA] + _b[L4.dinf_USA]) / (1-_b[L1.dunemp_USA] - _b[L2.dunemp_USA] - _b[L3.dunemp_USA] - _b[L4.dunemp_USA]))
predict f3
gen u3 = dunemp_USA - f3
predict sef3, stdp
gen LL3 = f3 - 1.645*sef3
gen UL3 = f3 + 1.645*sef3
gen u3_sqr = u3^2
gen abu3 = abs(u3)
list qdate dunemp_USA f3 LL3 UL3 u3 u3_sqr abu3 if tin(2016q1,2019q4)
* -22.56484   .5142923

tabstat abu1 abu2 abu3 u1_sqr u2_sqr u3_sqr if tin(2016q1,2019q4), stat(mean)

local z "0.0128376  0.0124189  0.0119421"
local i = 1
foreach k of local z{
	di in ye "Model `i'"
	di in gr sqrt(`k')
	local i = `i' + 1
}

*graph
*twoway(tsline dunemp_USA if tin(2016q1,2019q4))
*(tsline f1 if tin(2016q1,2019q4), lcolor(green*0.5) lpattern(solid))
*(tsline lowf1 if tin(2016q1,2019q4), lcolor(red*1.5) lpattern(dash))
*(tsline highf1 if tin(2016q1,2019q4), lcolor(red*1.5) lpattern(dash))
*scheme(s2mono) graphregion(color(white))
*ysize(4) xsize(9) ylabel(, grid glc(black) glw(.2) glp(shortdash))
*legend(rows(1) order(- "bf:dunemp_USA) 2016-2019" 1 - "(bf:Forecasts)" 2 3 4) label(1 "")
*label(2 "ARDL(3,1)")label(3 "Low interval") label(4 "High Interval"))

///twoway(tsline f1 if tin(2016q1,2019q4), lw(.6)) ///
	///(rarea LL1 UL1 qdate if tin(2016q1,2019q4), lcolor(pink) fcolor(pink%30) lpattern(solid) lw(.2)) ///
    ///(tsline f2 if tin(2016q1,2019q4), lcolor(midblue) lpattern(solid) lw(.6)) ///
	//(rarea LL2 UL2 qdate if tin(2016q1,2019q4), lcolor(white%0) fcolor(green%0) lpattern(solid) lw(.2)) ///
	//(tsline f3 if tin(2016q1,2019q4), lcolor(midblue*1.5) lpattern(solid) lw(.6)) ///
    //(rarea LL3 UL3 qdate if tin(2016q1,2019q4), lcolor(white%0) fcolor(yellow%0) lpattern(solid) lw(.2)) ///
    //(tsline dunemp_USA if tin(2016q1,2019q4)) 
	*legend(rows(1) order(- 1 2 3 4 5 6 7) label((1 "kdlsa") label(2 "lksjd") label(3 "lkasdj") label(4 "skdj") label(5 "dklsaj") label(6 "sajd") label(7 "asdj")))
	
global tlabel "2016q1 2016q2 2016q3 2016q4 2017q1 2017q2 2017q3 2017q4 2018q1 2018q2 2018q3 2018q4 2019q1 2019q2 2019q3 2019q4 "
label var f1 "ARDL(1,1)"
label var f2 "ARDL(1,2)"
label var f3 "ARDL(4,4)"
label var UL1 "upper 1"
label var LL1 "lower 1"
twoway (tsline dunemp_USA, lw(.6)) ///
	(rarea LL1 UL1 qdate, lcolor(gs11) fcolor(pink%20) lpattern(solid) lw(.2)) ///
	(tsline f1, lcolor(pink) lpattern(solid) lw(.6)) ///
	(tsline f2, lcolor(black) lpattern(solid) lw(.6)) ///
	(tsline f3, lcolor(blue) lpattern(solid) lw(.6)) if tin(2016q1, 2019q4), ///
	tlabel("$tlabel") xtitle("Quarter") ytitle("Change in Unempl USA")scheme(s2mono) graphregion(color(white)) ///
	ysize(4) xsize(9) ylabel(, grid glc(black) glw(.2) glp(shortdash))
	

	*scheme(s2mono) graphregion(color(white)) ///
	*ysize(4) xsize(9) ylabel(, grid glc(black) glw(.2) glp(shortdash)) ///
	*legend(rows(1) order(- "bf:dunemp_USA 2016-2019" 1 - "(bf:Forecasts)" 2 3) label(1 "") ///
	*label(2 "ARDL(3,1)")label(3 "Low interval")) ///
	*xline(2006.5, lcolor(purple) lw(.6) lpattern(dash)) yscale(range(-5.5, 10.1)) xmtick(##10) 
	


	

	
*mexico
*Mex AR(1) yes1
reg dunemp_MEX l(1/1).dunemp_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
nlcom ((_b[L1.dunemp_MEX]) / (1-_b[L1.dunemp_MEX]))
predict f4
gen u4 = dunemp_MEX - f4
predict sef4, stdp
gen LL4 = f4 - 1.645*sef4
gen UL4 = f4 + 1.645*sef4
gen u4_sqr = u4^2
gen abu4 = abs(u4)
list qdate dunemp_MEX f4 LL4 UL4 u4 u4_sqr abu4 if tin(2016q1,2019q4), separator(0) noobs
*46.40401    51.5327

*MEX AR(2)
reg dunemp_MEX l(1/2).dunemp_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
*47.9744   55.66744

*MEX AR(3)
reg dunemp_MEX l(1/3).dunemp_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
*48.54029   58.79769

*MEX AR(4)
reg dunemp_MEX l(1/4).dunemp_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
*49.16091   61.98265

*MEX ARDL(1,1)
reg dunemp_MEX l(1/1).dunemp_MEX l(1/1).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic


* 48.01202   55.70507

*MEX ARDL(1,2) yes 2
reg dunemp_MEX l(1/1).dunemp_MEX l(1/2).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
nlcom ((_b[L1.dinf_MEX] + _b[L2.dinf_MEX]) / (1-_b[L1.dunemp_MEX] ))
predict f5
gen u5 = dunemp_USA - f5
predict sef5, stdp
gen LL5 = f5 - 1.645*sef5
gen UL5 = f5 + 1.645*sef5
gen u5_sqr = u5^2
gen abu5 = abs(u5)
list qdate dunemp_MEX f5 LL5 UL5 u5 u5_sqr abu5 if tin(2016q1,2019q4),separator(0) noobs
*  46.8745   57.13189

*MEX ARDL(1,3)
reg dunemp_MEX l(1/1).dunemp_MEX l(1/3).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
* 48.86104   61.68278

*MEX ARDL(1,4)
reg dunemp_MEX l(1/1).dunemp_MEX l(1/4).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
* 49.36768   64.75377

*MEX ARDL(2,1) 
reg dunemp_MEX l(1/2).dunemp_MEX l(1/1).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
* 49.84571   60.10311

*MEX ARDL(2,2)
reg dunemp_MEX l(1/2).dunemp_MEX l(1/2).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
* 48.03196    60.8537

*MEX ARDL(2,3)
reg dunemp_MEX l(1/2).dunemp_MEX l(1/3).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
*50.02231    65.4084

*MEX ARDL(2,4)
reg dunemp_MEX l(1/2).dunemp_MEX l(1/4).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
* 50.74295   68.69339

*MEX ARDL(3,1)
reg dunemp_MEX l(1/3).dunemp_MEX l(1/1).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
*49.87069   62.69243

*MEX ARDL(3,2)
reg dunemp_MEX l(1/3).dunemp_MEX l(1/2).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
*49.53113   64.91722

*MEX ARDL(3,3)
reg dunemp_MEX l(1/3).dunemp_MEX l(1/3).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
* 51.42812   69.37856

*MEX ARDL(3,4)
reg dunemp_MEX l(1/3).dunemp_MEX l(1/4).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
* 52.21598   72.73077

*MEX ARDL(4,1)
reg dunemp_MEX l(1/4).dunemp_MEX l(1/1).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
*50.64404   66.03013

*MEX ARDL(4,2)
reg dunemp_MEX l(1/4).dunemp_MEX l(1/2).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
*51.20555   69.15599

*MEX ARDL(4,3)
reg dunemp_MEX l(1/4).dunemp_MEX l(1/3).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
* 52.88591    73.4007

*MEX ARDL(4,4) worst yes
reg dunemp_MEX l(1/4).dunemp_MEX l(1/4).dinf_MEX if tb==1
estat bgodfrey, lag(4)
estat ic
nlcom ((_b[L1.dinf_MEX] + _b[L2.dinf_MEX] + _b[L3.dinf_MEX] + _b[L4.dinf_MEX]) / (1-_b[L1.dunemp_MEX] - _b[L2.dunemp_MEX] - _b[L3.dunemp_MEX] - _b[L4.dunemp_MEX]))
predict f6
gen u6 = dunemp_MEX - f6
predict sef6, stdp
gen LL6 = f6 - 1.645*sef6
gen UL6 = f6 + 1.645*sef6
gen u6_sqr = u6^2
gen abu6 = abs(u6)
list qdate dunemp_MEX f6 LL6 UL6 u6 u6_sqr abu6 if tin(2016q1,2019q4)
*  53.9916   77.07074

tabstat abu4 abu5 abu6 u4_sqr u5_sqr u6_sqr if tin(2016q1,2019q4), stat(mean)

local z "0.015749  0.0151439  0.0147031"
local i = 4
foreach k of local z{
	di in ye "Model `i'"
	di in gr sqrt(`k')
	local i = `i' + 1
}

*graph
*twoway(tsline dunemp_USA if tin(2016q1,2019q4))
*(tsline f1 if tin(2016q1,2019q4), lcolor(green*0.5) lpattern(solid))
*(tsline lowf1 if tin(2016q1,2019q4), lcolor(red*1.5) lpattern(dash))
*(tsline highf1 if tin(2016q1,2019q4), lcolor(red*1.5) lpattern(dash))
*scheme(s2mono) graphregion(color(white))
*ysize(4) xsize(9) ylabel(, grid glc(black) glw(.2) glp(shortdash))
*legend(rows(1) order(- "bf:dunemp_USA) 2016-2019" 1 - "(bf:Forecasts)" 2 3 4) label(1 "")
*label(2 "ARDL(3,1)")label(3 "Low interval") label(4 "High Interval"))

*twoway(tsline f1 if tin(2016q1,2019q4), lw(.6)) ///
*	(rarea LL1 UL1 qdate if tin(2016q1,2019q4), lcolor(pink) fcolor(pink%30) lpattern(solid) lw(.2)) ///
 *   (tsline f2 if tin(2016q1,2019q4), lcolor(midblue) lpattern(solid) lw(.6)) ///
	*(rarea LL2 UL2 qdate if tin(2016q1,2019q4), lcolor(white%0) fcolor(green%0) lpattern(solid) lw(.2)) ///
	*(tsline f3 if tin(2016q1,2019q4), lcolor(midblue*1.5) lpattern(solid) lw(.6)) ///
    *(rarea LL3 UL3 qdate if tin(2016q1,2019q4), lcolor(white%0) fcolor(yellow%0) lpattern(solid) lw(.2)) ///
    *(tsline dunemp_USA if tin(2016q1,2019q4)) 
	*legend(rows(1) order(- 1 2 3 4 5 6 7) label((1 "kdlsa") label(2 "lksjd") label(3 "lkasdj") label(4 "skdj") label(5 "dklsaj") label(6 "sajd") label(7 "asdj")))
	
	
global tlabel "2016q1 2016q2 2016q3 2016q4 2017q1 2017q2 2017q3 2017q4 2018q1 2018q2 2018q3 2018q4 2019q1 2019q2 2019q3 2019q4 "
label var f4 "AR(1)"
label var f5 "ARDL(1,2)"
label var f6 "ARDL(4,4)"
label var UL4 "upper 4"
label var LL4 "lower 4"
twoway (tsline dunemp_MEX, lw(.6)) ///
	(rarea LL4 UL4 qdate, lcolor(gs11) fcolor(pink%20) lpattern(solid) lw(.2)) ///
	(tsline f4, lcolor(pink) lpattern(solid) lw(.6)) ///
	(tsline f5, lcolor(black) lpattern(solid) lw(.6)) ///
	(tsline f6, lcolor(blue) lpattern(solid) lw(.6)) if tin(2016q1, 2019q4), ///
	tlabel("$tlabel") xtitle("Quarter") ytitle("Change in Unempl MEX")scheme(s2mono) graphregion(color(white)) ///
	ysize(4) xsize(9) ylabel(, grid glc(black) glw(.2) glp(shortdash))
	