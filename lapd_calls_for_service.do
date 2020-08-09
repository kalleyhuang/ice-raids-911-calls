* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service.dta
/* gen W_Low = Low / 486
gen W_Middle = Middle / 358
gen W_High = High / 291

/* use lapd_calls_for_service_2017.dta
append using lapd_calls_for_service_2018.dta
append using lapd_calls_for_service_2019.dta
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
gen date2 = date1
format date2 %tdNN/DD/YY
sort date1
save lapd_calls_for_service.dta, replace */

// February 6, 2017 - February 10, 2017
gen Feb6_Pulse = 1 if (Date1 >= date("02/06/2017", "MDY")) & (Date1 <= date("02/10/2017", "MDY"))
recode Feb6_Pulse . = 0
gen Feb6_Step = 1 if Date1 >= date("02/06/2017", "MDY")
recode Feb6_Step . = 0
gen Feb6_Count = Date1 - date("02/10/2017", "MDY") if (Date1 > date("02/10/2017", "MDY")) & (Date1 < date("05/21/2017", "MDY"))
recode Feb6_Count . = 0
gen Feb6_PulseNew = 1 if (Date1 == date("02/06/2017", "MDY"))
recode Feb6_PulseNew . = 0

// May 21, 2017 - May 25, 2017
gen May21_Pulse = 1 if (Date1 >= date("05/21/2017", "MDY")) & (Date1 <= date("05/25/2017", "MDY"))
recode May21_Pulse . = 0
gen May21_Step = 1 if Date1 >= date("05/21/2017", "MDY")
recode May21_Step . = 0
gen May21_Count = Date1 - date("05/25/2017", "MDY") if (Date1 > date("05/25/2017", "MDY")) & (Date1 < date("09/24/2017", "MDY"))
recode May21_Count . = 0
gen May21_PulseNew = 1 if (Date1 == date("05/21/2017", "MDY"))
recode May21_PulseNew . = 0

// September 24, 2017 - September 27, 2017
gen Sep24_Pulse = 1 if (Date1 >= date("09/24/2017", "MDY")) & (Date1 <= date("09/27/2017", "MDY"))
recode Sep24_Pulse . = 0
gen Sep24_Step = 1 if Date1 >= date("09/24/2017", "MDY")
recode Sep24_Step . = 0
gen Sep24_Count = Date1 - date("09/27/2017", "MDY") if (Date1 > date("09/27/2017", "MDY")) & (Date1 < date("02/11/2018", "MDY"))
recode Sep24_Count . = 0
gen Sep24_PulseNew = 1 if (Date1 == date("09/24/2017", "MDY"))
recode Sep24_PulseNew . = 0

// February 11, 2018 - February 15, 2018
gen Feb11_Pulse = 1 if (Date1 >= date("02/11/2018", "MDY")) & (Date1 <= date("02/15/2018", "MDY"))
recode Feb11_Pulse . = 0
gen Feb11_Step = 1 if Date1 >= date("02/11/2018", "MDY")
recode Feb11_Step . = 0
gen Feb11_Count = Date1 - date("02/15/2018", "MDY") if (Date1 > date("02/15/2018", "MDY")) & (Date1 < date("06/10/2018", "MDY"))
recode Feb11_Count . = 0
gen Feb11_PulseNew = 1 if (Date1 == date("02/11/2018", "MDY"))
recode Feb11_PulseNew . = 0

// June 10, 2018 - June 12, 2018
gen Jun10_Pulse = 1 if (Date1 >= date("06/10/2018", "MDY")) & (Date1 <= date("06/12/2018", "MDY"))
recode Jun10_Pulse . = 0
gen Jun10_Step = 1 if Date1 >= date("06/10/2018", "MDY")
recode Jun10_Step . = 0
gen Jun10_Count = Date1 - date("06/12/2018", "MDY") if (Date1 > date("06/12/2018", "MDY")) & (Date1 < date("09/23/2018", "MDY"))
recode Jun10_Count . = 0
gen Jun10_PulseNew = 1 if (Date1 == date("06/10/2018", "MDY"))
recode Jun10_PulseNew . = 0

// September 23, 2018 - September 25, 2018
gen Sep23_Pulse = 1 if (Date1 >= date("09/23/2018", "MDY")) & (Date1 <= date("09/25/2018", "MDY"))
recode Sep23_Pulse . = 0
gen Sep23_Step = 1 if Date1 >= date("09/23/2018", "MDY")
recode Sep23_Step . = 0
gen Sep23_Count = Date1 - date("09/25/2018", "MDY") if (Date1 > date("09/25/2018", "MDY")) & (Date1 < date("06/17/2019", "MDY"))
recode Sep23_Count . = 0
gen Sep23_PulseNew = 1 if (Date1 == date("09/23/2018", "MDY"))
recode Sep23_PulseNew . = 0

// June 17, 2019 - July 13, 2019
gen Jun17_Pulse = 1 if (Date1 >= date("06/17/2019", "MDY")) & (Date1 <= date("07/13/2019", "MDY"))
recode Jun17_Pulse . = 0
gen Jun17_Step = 1 if Date1 >= date("06/17/2019", "MDY")
recode Jun17_Step . = 0
gen Jun17_Count = Date1 - date("07/13/2019", "MDY") if Date1 > date("07/13/2019", "MDY")
recode Jun17_Count . = 0

// Low Outliers
drop if Date1 == 21548
drop if Date1 == 21549
drop if Date1 == 21736

// High Outliers
drop if Low > 2200

gen Day = dow(Date1)
gen Season = 1 if Date1 >= mdy(12,21,year(Date1)) | Date1 < mdy(3,20,year(Date1))  
recode Season . = 2 if inrange(Date1,mdy(3,21,year(Date1)),mdy(6,20,year(Date1))) 
recode Season . = 3 if inrange(Date1,mdy(6,21,year(Date1)),mdy(9,20,year(Date1)))
recode Season . = 4 if inrange(Date1,mdy(9,21,year(Date1)),mdy(12,20,year(Date1)))

save lapd_calls_for_service.dta, replace */

/* regress Low Feb6_Pulse i.Day i.Season
regress Low May21_Pulse i.Day i.Season
regress Low Sep24_Pulse i.Day i.Season
regress Low Feb11_Pulse i.Day i.Season
regress Low Jun10_Pulse i.Day i.Season
regress Low Sep23_Pulse i.Day i.Season
regress Low Jun17_Pulse i.Day i.Season
regress Middle Feb6_Pulse i.Day i.Season
regress Middle May21_Pulse i.Day i.Season
regress Middle Sep24_Pulse i.Day i.Season
regress Middle Feb11_Pulse i.Day i.Season
regress Middle Jun10_Pulse i.Day i.Season
regress Middle Sep23_Pulse i.Day i.Season
regress Middle Jun17_Pulse i.Day i.Season
regress High Feb6_Pulse i.Day i.Season
regress High May21_Pulse i.Day i.Season
regress High Sep24_Pulse i.Day i.Season
regress High Feb11_Pulse i.Day i.Season
regress High Jun10_Pulse i.Day i.Season
regress High Sep23_Pulse i.Day i.Season
regress High Jun17_Pulse i.Day i.Season

regress Low Feb6_Step i.Day i.Season
regress Low May21_Step i.Day i.Season
regress Low Sep24_Step i.Day i.Season
regress Low Feb11_Step i.Day i.Season
regress Low Jun10_Step i.Day i.Season
regress Low Sep23_Step i.Day i.Season
regress Low Jun17_Step i.Day i.Season
regress Middle Feb6_Step i.Day i.Season
regress Middle May21_Step i.Day i.Season
regress Middle Sep24_Step i.Day i.Season
regress Middle Feb11_Step i.Day i.Season
regress Middle Jun10_Step i.Day i.Season
regress Middle Sep23_Step i.Day i.Season
regress Middle Jun17_Step i.Day i.Season
regress High Feb6_Step i.Day i.Season
regress High May21_Step i.Day i.Season
regress High Sep24_Step i.Day i.Season
regress High Feb11_Step i.Day i.Season
regress High Jun10_Step i.Day i.Season
regress High Sep23_Step i.Day i.Season
regress High Jun17_Step i.Day i.Season

regress Low Feb6_Count i.Day i.Season
regress Low May21_Count i.Day i.Season
regress Low Sep24_Count i.Day i.Season
regress Low Feb11_Count i.Day i.Season
regress Low Jun10_Count i.Day i.Season
regress Low Sep23_Count i.Day i.Season
regress Low Jun17_Count i.Day i.Season
regress Middle Feb6_Count i.Day i.Season
regress Middle May21_Count i.Day i.Season
regress Middle Sep24_Count i.Day i.Season
regress Middle Feb11_Count i.Day i.Season
regress Middle Jun10_Count i.Day i.Season
regress Middle Sep23_Count i.Day i.Season
regress Middle Jun17_Count i.Day i.Season
regress High Feb6_Count i.Day i.Season
regress High May21_Count i.Day i.Season
regress High Sep24_Count i.Day i.Season
regress High Feb11_Count i.Day i.Season
regress High Jun10_Count i.Day i.Season
regress High Sep23_Count i.Day i.Season
regress High Jun17_Count i.Day i.Season

regress Low Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season
regress Middle Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season
regress High Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season

regress Low May21_Pulse May21_Step May21_Count i.Day i.Season
regress Middle May21_Pulse May21_Step May21_Count i.Day i.Season
regress High May21_Pulse May21_Step May21_Count i.Day i.Season

regress Low Sep24_Pulse Sep24_Step Sep24_Count i.Day i.Season
regress Middle Sep24_Pulse Sep24_Step Sep24_Count i.Day i.Season
regress High Sep24_Pulse Sep24_Step Sep24_Count i.Day i.Season

regress Low Feb11_Pulse Feb11_Step Feb11_Count i.Day i.Season
regress Middle Feb11_Pulse Feb11_Step Feb11_Count i.Day i.Season
regress High Feb11_Pulse Feb11_Step Feb11_Count i.Day i.Season

regress Low Jun10_Pulse Jun10_Step Jun10_Count i.Day i.Season
regress Middle Jun10_Pulse Jun10_Step Jun10_Count i.Day i.Season
regress High Jun10_Pulse Jun10_Step Jun10_Count i.Day i.Season

regress Low Sep23_Pulse Sep23_Step Sep23_Count i.Day i.Season
regress Middle Sep23_Pulse Sep23_Step Sep23_Count i.Day i.Season
regress High Sep23_Pulse Sep23_Step Sep23_Count i.Day i.Season */

tsset Date2, daily
regress High l.High Sep23_Pulse Sep23_Step Sep23_Count i.Day i.Season // 54.8
regress High l7.High Sep23_Pulse Sep23_Step Sep23_Count i.Season
regress d.High Sep23_Pulse i.Day i.Season
regress d.High Sep23_PulseNew i.Day i.Season
regress d.High Sep23_Pulse Sep23_PulseNew i.Day i.Season
gen HighD = d.High
regress High Sep23_PulseNew i.Day i.Season
regress High Sep23_Pulse Sep23_PulseNew i.Day i.Season
regress High l.High Sep23_Pulse i.Day i.Season
regress High l.High Feb6_Pulse i.Day i.Season

regress Low l.Low Feb6_Pulse Feb6_PulseNew i.Day i.Season // -10, -69
regress Middle l.Middle Feb6_Pulse Feb6_PulseNew i.Day i.Season // -40, 6
regress High l.High Feb6_Pulse Feb6_PulseNew i.Day i.Season // -7, 17

regress Low l.Low May21_Pulse May21_PulseNew i.Day i.Season // -18, 102
regress Middle l.Middle May21_Pulse May21_PulseNew i.Day i.Season // -21, 29
regress High l.High May21_Pulse May21_PulseNew i.Day i.Season // -28, 36

regress Low l.Low Sep24_Pulse Sep24_PulseNew i.Day i.Season // -40, 100
regress Middle l.Middle Sep24_Pulse Sep24_PulseNew i.Day i.Season // -14, 130
regress High l.High Sep24_Pulse Sep24_PulseNew i.Day i.Season // -40, 62

regress Low l.Low Feb11_Pulse Feb11_PulseNew i.Day i.Season // 50, -48
regress Middle l.Middle Feb11_Pulse Feb11_PulseNew i.Day i.Season // 55, 35
regress High l.High Feb11_Pulse Feb11_PulseNew i.Day i.Season // 34, -29

regress Low l.Low Jun10_Pulse Jun10_PulseNew i.Day i.Season // 41, 18
regress Middle l.Middle Jun10_Pulse Jun10_PulseNew i.Day i.Season // 81, -99
regress High l.High Jun10_Pulse Jun10_PulseNew i.Day i.Season // 15, -21

regress Low i.Day i.Season // 28, -63
regress Middle l.Middle Sep23_Pulse Sep23_PulseNew i.Day i.Season // 83, -183
regress High l.High Sep23_Pulse Sep23_PulseNew i.Day i.Season // 11, 86

regress Low l.Low Feb6_Pulse i.Day i.Season
regress Low l.Low May21_Pulse i.Day i.Season
regress Low l.Low Sep24_Pulse i.Day i.Season
regress Low l.Low Feb11_Pulse i.Day i.Season
regress Low l.Low Jun10_Pulse i.Day i.Season
regress Low l.Low Sep23_Pulse i.Day i.Season

regress Mid l.Mid Feb6_Pulse i.Day i.Season
regress Mid l.Mid May21_Pulse i.Day i.Season
regress Mid l.Mid Sep24_Pulse i.Day i.Season
regress Mid l.Mid Feb11_Pulse i.Day i.Season
regress Mid l.Mid Jun10_Pulse i.Day i.Season
regress Mid l.Mid Sep23_Pulse i.Day i.Season

regress High l.High Feb6_Pulse i.Day i.Season
regress High l.High May21_Pulse i.Day i.Season
regress High l.High Sep24_Pulse i.Day i.Season
regress High l.High Feb11_Pulse i.Day i.Season
regress High l.High Jun10_Pulse i.Day i.Season
regress High l.High Sep23_Pulse i.Day i.Season

predict Low_Pred
predict Middle_Pred
predict High_Pred

drop if Date2 > 20896
line Low Low_Pred Date2

line High High_Pred Date2, xline(20856 20860)

#delimit;
line Low Date2 || line Middle Date2 || line High Date2, xline(20856 20960 21086 21226 21345 21450 21717)
xtitle("Date")
ytitle("Total 911 Calls")
graphregion(color(white))
title("Hispanic and Non Hispanic 911 Calls")
subtitle("Los Angeles Police Department, 2017 - 2018")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls.png, width(2000) replace

drop if Date1 > 20896
#delimit;
line Low Date2 || line Middle Date2 || line High Date2, xline(20856 20860)
xtitle("Date")
ytitle("Total 911 Calls")
graphregion(color(white))
title("Hispanic and Non Hispanic 911 Calls")
subtitle("ICE Raid, February 6, 2017 - February 10, 2017")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls_Feb6.png, width(2000) replace

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service.dta
drop if Date1 < 20924 | Date1 > 21000
#delimit;
line Low Date2 || line Middle Date2 || line High Date2, xline(20960 20964)
xtitle("Date")
ytitle("Total 911 Calls")
graphregion(color(white))
title("Hispanic and Non Hispanic 911 Calls")
subtitle("ICE Raid, May 21, 2017 - May 25, 2017")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls_May21.png, width(2000) replace

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service.dta
drop if Date1 < 21050 | Date1 > 21125
#delimit;
line Low Date2 || line Middle Date2 || line High Date2, xline(21086 21089)
xtitle("Date")
ytitle("Total 911 Calls")
graphregion(color(white))
title("Hispanic and Non Hispanic 911 Calls")
subtitle("ICE Raid, September 24, 2017 - September 27, 2017")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls_Sep24.png, width(2000) replace

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service.dta
drop if Date1 < 21190 | Date1 > 21266
#delimit;
line Low Date2 || line Middle Date2 || line High Date2, xline(21226 21230)
xtitle("Date")
ytitle("Total 911 Calls")
graphregion(color(white))
title("Hispanic and Non Hispanic 911 Calls")
subtitle("ICE Raid, February 11, 2018 - February 15, 2018")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls_Feb11.png, width(2000) replace

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service.dta
drop if Date1 < 21309 | Date1 > 21383
#delimit;
line Low Date2 || line Middle Date2 || line High Date2, xline(21345 21347)
xtitle("Date")
ytitle("Total 911 Calls")
graphregion(color(white))
title("Hispanic and Non Hispanic 911 Calls")
subtitle("ICE Raid, June 10, 2018 - June 12, 2018")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls_Jun10.png, width(2000) replace

cd /Volumes/KALLEY/Stata/
clear
use lapd_calls_for_service.dta
drop if Date1 < 21414 | Date1 > 21488
#delimit;
line Low Date2 || line Middle Date2 || line High Date2, xline(21450 21452)
xtitle("Date")
ytitle("Total 911 Calls")
graphregion(color(white))
title("Hispanic and Non Hispanic 911 Calls")
subtitle("ICE Raid, September 23, 2018 - September 25, 2018")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
graph export 911_Calls_Sep23.png, width(2000) replace
