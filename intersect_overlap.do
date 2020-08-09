* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use intersect_tracts_by_reporting_districts.dta
format %12.0g fips
drop objectid
drop area
sort rd
joinby fips using social_explorer_race_citizenship.dta
drop if percentage < 10
drop if totalpopulation == 0
drop if strpos(rd, "-") > 0
drop if strpos(rd, "?") > 0
drop if strpos(rd, "A") > 0
drop if strpos(rd, "B") > 0
drop if strpos(rd, "C") > 0
drop if strpos(rd, "D") > 0
drop if strpos(rd, "E") > 0
drop if strpos(rd, "N") > 0
drop if strpos(rd, "S") > 0
drop if mi(rd)
destring, replace
drop if rd < 0101 | rd > 2199
sort rd
joinby rd using lapd_reporting_districts.dta, unm(both)
drop if _merge == 1
tab _merge
recode percentage . = 0 

/* create and save rdpopulation variable
collapse (sum) totalpopulation, by(rd)
rename totalpopulation rdpopulation
save rdpopulation.dta, replace
*/

joinby rd using rdpopulation.dta
// _merge already exists, cannot use unm(both)

/* create and save overlap variable
gen weightedpopulation = (totalpopulation/rdpopulation)
gen overlap = (percentage/100) * weightedpopulation
collapse (sum) overlap, by(rd)
// gsort -overlap
// command spikeplot overlap, round(0.1)
save overlap.dta, replace
*/

joinby rd using overlap.dta
gen goodoverlap = 1 if overlap >= 0.8
recode goodoverlap . = 0
keep if goodoverlap == 1
drop _merge
joinby rd using lapd_reporting_districts.dta, unm(both)
tab _merge
gen hl = 0
recode hl 0 = 1 if (hispanicorlatinx/totalpopulation) <= 0.393
recode hl 0 = 2 if ((hispanicorlatinx/totalpopulation) > 0.393) & ((hispanicorlatinx/totalpopulation) < 0.7)
recode hl 0 = 3 if (hispanicorlatinx/totalpopulation) >= 0.7
recode hl 3 = . if _merge == 2
tab hl
drop fips percentage totalpopulation whitealone blackalone indigenousalone asianalone pacificislanderalone someotherracealone twoormoreraces nothispanicorlatinx nothlwhitealone nothlblackalone nothlindigenousalone nothlasianalone nothlpacificislanderalone nothlsomeotherracealone nothltwoormoreraces hispanicorlatinx hlwhitealone hlblackalone hlindigenousalone hlasianalone hlpacificislanderalone hlsomeotherraceaone hltwoormoreraces nativeborn foreignborn naturalizedcitizen notacitizen rdpopulation overlap goodoverlap _merge
save ohl.dta, replace
