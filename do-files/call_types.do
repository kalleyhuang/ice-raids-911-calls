* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service_2017.dta
append using lapd_calls_for_service_2018.dta
append using lapd_calls_for_service_2019.dta
gen date1 = date(dispatchdate, "MDY")
gen date2 = date1
format date2 %tdNN/DD/YY
sort date1
drop incidentnumber areaoccurred dispatchdate dispatchtime

/* create and save call variable
sort calltypedescription
by calltypedescription: gen frequency = _N
by calltypedescription: keep if _n==1
gsort -frequency calltypedescription
gen percentage = frequency / 961870 * 100
keep if percentage > 1
list calltypedescription frequency percentage
drop reportingdistrict datesrf datehif
gen call = _n
save call_types.dta, replace
*/

joinby calltypedescription using call_types.dta
drop frequency percentage
gen codesix = 1 if call == 1
gen man = 1 if call == 2
gen grp = 1 if call == 3
gen codethirty = 1 if call == 4
gen suspnow = 1 if call == 5
gen domviol = 1 if call == 6
gen party = 1 if call == 7
gen amb = 1 if call == 8
gen susp = 1 if call == 9
gen trespasssusp = 1 if call == 10
gen radio = 1 if call == 11
gen posssusp = 1 if call == 12
gen family = 1 if call == 13
gen woman = 1 if call == 14
gen jo = 1 if call == 15
gen manwmn = 1 if call == 16
gen hrmisd = 1 if call == 17
gen invest = 1 if call == 18
gen busn = 1 if call == 19
gen trafficstop = 1 if call == 20
gen unknowntrouble = 1 if call == 21
gen suspjl = 1 if call == 22
gen neighbor = 1 if call == 23
gen complaint = 1 if call == 24
drop calltypedescription call
rename reportingdistrict rd
sort rd
joinby rd using uhl.dta
save calls_by_hl.dta, replace
joinby rd using lapd_areas.dta
collapse (sum) codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint, by(date1 hl)
gen month = month(date1)
gen year = year(date1)
collapse (sum) codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint, by(month year area)
joinby area using areahl.dta
joinby area using area.dta 
// collapse (sum) codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint, by(datesrf)
// collapse (sum) codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint, by(rd)
gen intervention = 1 if (month > 5)
recode intervention . = 0
// gen datehif = datesrf
// format datehif %tdNN/DD
/* #delimit;
line domviol datehif, xline(20220)
xtitle(Date)
ytitle(Total Domestic Violence 911 Calls)
title("Domestic Violence 911 Calls")
subtitle("Los Angeles Police Department, 2015")
note("The Los Angeles Police Department joined the 287(g) program on May 12, 2015.")
; */
/* gen dayofweek = dow(datesrf)
regress domviol intervention i.dayofweek
gen season = 1 if ((datesrf < date("03/20/2015", "MDY")) | (datesrf >= date("12/21/2015", "MDY")))
recode season . = 2 if ((datesrf >= date("03/20/2015", "MDY")) & (datesrf < date("06/21/2015", "MDY")))
recode season . = 3 if ((datesrf >= date("06/21/2015", "MDY")) & (datesrf < date("09/23/2015", "MDY")))
recode season . = 4 if ((datesrf >= date("09/23/2015", "MDY")) & (datesrf < date("12/21/2015", "MDY")))*/
gen season = 1 if (month <= 3)
recode season . = 2 if (month > 3 | month <= 6)
recode season . = 3 if (month > 6 | month <= 9)
recode season . = 4 if (month > 9 | month <= 12)
save calls_over_time.dta, replace
