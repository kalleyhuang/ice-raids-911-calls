* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use calls_by_hl.dta
gen month = month(datesrf)
collapse (sum) codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint, by(hl month) 
tsset hl month

#delimit;
graph pie codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint if hl==1
;
