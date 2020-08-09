* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service_2017.dta
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
gen intervention = 1 if (date1 > date("07/23/2017", "MDY"))
recode intervention . = 0
gen date2 = date1
format date2 %tdNN/DD/YY
sort date1
save lapd_calls_for_service_2017_analysis.dta, replace
