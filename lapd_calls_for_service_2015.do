* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service_2015.dta
gen datesrf = date(dispatchdate, "MDY")
rename reportingdistrict rd
joinby rd using uhl.dta 
// rename hl uhl
gen lowhl = 1 if hl == 1
gen midhl = 1 if hl == 2
gen highhl = 1 if hl == 3
recode lowhl . = 0
recode midhl . = 0
recode highhl . = 0
/* joinby rd using ohl.dta 
rename hl ohl
gen olowhl = 1 if ohl == 1
gen omidhl = 1 if ohl == 2
gen ohighhl = 1 if ohl == 3
recode olowhl . = 0
recode omidhl . = 0
recode ohighhl . = 0 */
collapse (sum) lowhl midhl highhl, by(datesrf)
gen intervention = 1 if (datesrf > date("05/12/2015", "MDY"))
recode intervention . = 0
gen datehif = datesrf
format datehif %tdNN/DD
#delimit;
line lowhl datehif, xline(20220) || line midhl datehif, xline(20220) || line highhl datehif, xline(20220)
xtitle(Date)
ytitle(Total 911 Calls)
title("Hispanic and Non Hispanic 911 Calls")
subtitle("Los Angeles Police Department, 2015")
note("The Los Angeles Police Department joined the 287(g) program on May 12, 2015."
	"Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls.png, width(2000) replace
/* #delimit;
line olowhl datehif, xline(20220) || line omidhl datehif, xline(20220) || line ohighhl datehif, xline(20220)
xtitle(Date)
ytitle(Total 911 Calls)
title("Hispanic and Non Hispanic 911 Calls")
subtitle("Los Angeles Police Department, 2015")
note("The Los Angeles Police Department joined the 287(g) program on May 12, 2015."
	"Filtering by overlap (>80%).")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls_O.png, width(2000) replace */
gen dayofweek = dow(datesrf)
regress lowhl intervention i.dayofweek
regress midhl intervention i.dayofweek
regress highhl intervention i.dayofweek
gen season = 1 if ((datesrf < date("03/20/2015", "MDY")) | (datesrf >= date("12/21/2015", "MDY")))
recode season . = 2 if ((datesrf >= date("03/20/2015", "MDY")) & (datesrf < date("06/21/2015", "MDY")))
recode season . = 3 if ((datesrf >= date("06/21/2015", "MDY")) & (datesrf < date("09/23/2015", "MDY")))
recode season . = 4 if ((datesrf >= date("09/23/2015", "MDY")) & (datesrf < date("12/21/2015", "MDY"))) 
regress lowhl intervention i.season
regress midhl intervention i.season
regress highhl intervention i.season
regress lowhl intervention i.dayofweek season
regress lowhl intervention
regress midhl intervention
regress highhl intervention
/* no constant regressions suppress constant such that there is no intercept
regress lowhl intervention i.dayofweek, noconstant
regress midhl intervention i.dayofweek, noconstant
regress highhl intervention i.dayofweek, noconstant
regress lowhl intervention i.season, noconstant
regress midhl intervention i.season, noconstant
regress highhl intervention i.season, noconstant */
/* regress olowhl intervention
regress omidhl intervention
regress ohighhl intervention */
