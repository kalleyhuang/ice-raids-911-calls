* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service_2018.dta
gen date1 = date(dispatchdate, "MDY")
rename reportingdistrict rd
joinby rd using uhl.dta 
gen lowhl = 1 if hl == 1
gen midhl = 1 if hl == 2
gen highhl = 1 if hl == 3
recode lowhl . = 0
recode midhl . = 0
recode highhl . = 0
collapse (sum) lowhl midhl highhl, by(date1)
gen intervention = 1 if (date1 > date("02/11/2018", "MDY"))
recode intervention . = 0
gen date2 = date1
format date2 %tdNN/DD/YY
sort date1
drop if date1 == 21548
drop if date1 == 21549
#delimit;
line lowhl date2, xline(21226) || line midhl date2, xline(21226) || line highhl date2, xline(21226)
xtitle(Date)
ytitle(Total 911 Calls)
title("Hispanic and Non Hispanic 911 Calls")
subtitle("Los Angeles Police Department, 2018")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls_2018.png, width(2000) replace
gen dayofweek = dow(date1)
regress lowhl intervention i.dayofweek
regress midhl intervention i.dayofweek
regress highhl intervention i.dayofweek
gen season = 1 if ((date1 < date("03/20/2017", "MDY")) | (date1 >= date("12/21/2017", "MDY")))
recode season . = 2 if ((date1 >= date("03/20/2017", "MDY")) & (date1 < date("06/21/2017", "MDY")))
recode season . = 3 if ((date1 >= date("06/21/2017", "MDY")) & (date1 < date("09/23/2017", "MDY")))
recode season . = 4 if ((date1 >= date("09/23/2017", "MDY")) & (date1 < date("12/21/2017", "MDY"))) 
regress lowhl intervention i.season
regress midhl intervention i.season
regress highhl intervention i.season
regress lowhl intervention
regress midhl intervention
regress highhl intervention
