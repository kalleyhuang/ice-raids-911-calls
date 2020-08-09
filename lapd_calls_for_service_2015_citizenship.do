* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service_2015.dta
gen datesrf = date(dispatchdate, "MDY")
rename reportingdistrict rd
joinby rd using uc.dta 
// rename c uc
gen lowc = 1 if c == 0
gen highc = 1 if c == 1
recode lowc . = 0
recode highc . = 0
/* joinby rd using oc.dta 
rename c oc
gen olowc = 1 if oc == 0
gen ohighc = 1 if oc == 1
recode olowc . = 0
recode ohighc . = 0 */
collapse (sum) lowc highc, by(datesrf)
gen intervention = 1 if (datesrf > date("05/12/2015", "MDY"))
recode intervention . = 0
gen datehif = datesrf
format datehif %tdNN/DD
#delimit;
line lowc datehif, xline(20220) || line highc datehif, xline(20220)
xtitle(Date)
ytitle(Total 911 Calls)
title("Hispanic and Non Hispanic 911 Calls")
subtitle("Los Angeles Police Department, 2015")
note("The Los Angeles Police Department joined the 287(g) program on May 12, 2015."
	"Assuming geographic uniformity.")
legend(label(1 "Low Non-Citizens(<12.8%)") label(2 "High Hispanic (>12.8%)"))
;
graph export 911_Calls_Citizenship.png, width(2000) replace
/* #delimit;
line olowc datehif, xline(20220) || line ohighc datehif, xline(20220)
xtitle(Date)
ytitle(Total 911 Calls)
title("Hispanic and Non Hispanic 911 Calls")
subtitle("Los Angeles Police Department, 2015")
note("The Los Angeles Police Department joined the 287(g) program on May 12, 2015."
	"Filtering by overlap (>80%).")
legend(label(1 "Low Non-Citizens(<12.8%)") label(2 "High Hispanic (>12.8%)"))
;
graph export 911_Calls_O_Citizenship.png, width(2000) replace */
gen lc = lowc / 430
gen hc = highc / 705
// gen olc = olowc / 258
// gen ohc = ohighc / 446
#delimit;
line lc datehif, xline(20220) || line hc datehif, xline(20220)
xtitle(Date)
ytitle(Total 911 Calls)
title("Hispanic and Non Hispanic 911 Calls")
subtitle("Los Angeles Police Department, 2015")
note("The Los Angeles Police Department joined the 287(g) program on May 12, 2015."
	"Assuming geographic uniformity.")
legend(label(1 "Low Non-Citizens(<12.8%)") label(2 "High Hispanic (>12.8%)"))
;
graph export 911_Calls_Citizenship_Adjusted.png, width(2000) replace
/* #delimit;
line olc datehif, xline(20220) || line ohc datehif, xline(20220)
xtitle(Date)
ytitle(Total 911 Calls)
title("Hispanic and Non Hispanic 911 Calls")
subtitle("Los Angeles Police Department, 2015")
note("The Los Angeles Police Department joined the 287(g) program on May 12, 2015."
	"Filtering by overlap (>80%).")
legend(label(1 "Low Non-Citizens(<12.8%)") label(2 "High Hispanic (>12.8%)"))
;
graph export 911_Calls_O_Citizenship_Adjusted.png, width(2000) replace */
regress lowc intervention
regress highc intervention
regress lc intervention
regress hc intervention
// regress olowc intervention
// regress ohighc intervention
