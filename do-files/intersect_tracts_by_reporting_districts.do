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

/* overlap code start
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
recode hl 0 = 1 if (hispanicorlatinx/totalpopulation) <= 0.176
recode hl 0 = 2 if ((hispanicorlatinx/totalpopulation) > 0.176) & ((hispanicorlatinx/totalpopulation) < 0.338)
recode hl 0 = 3 if (hispanicorlatinx/totalpopulation) >= 0.5
recode hl 3 = . if _merge == 2
tab hl
overlap code finish */

/* uniformity assumption code start
gen wtotalpopulation = totalpopulation * (percentage/100) 
gen wwhitealone = whitealone * (percentage/100) 
gen wblackalone = blackalone * (percentage/100) 
gen windigenousalone = indigenousalone * (percentage/100) 
gen wasianalone = asianalone * (percentage/100) 
gen wpacificislanderalone = pacificislanderalone * (percentage/100) 
gen wsomeotherracealone = someotherracealone * (percentage/100) 
gen wtwoormoreraces = twoormoreraces * (percentage/100) 
gen wnothispanicorlatinx = nothispanicorlatinx * (percentage/100) 
gen wnothlwhitealone = nothlwhitealone * (percentage/100) 
gen wnothlblackalone = nothlblackalone * (percentage/100) 
gen wnothlindigenousalone = nothlindigenousalone* (percentage/100) 
gen wnothlasianalone = nothlasianalone * (percentage/100) 
gen wnothlpacificislanderalone = nothlpacificislanderalone * (percentage/100) 
gen wnothlsomeotherracealone = nothlsomeotherracealone * (percentage/100) 
gen wnothltwoormoreraces = nothltwoormoreraces * (percentage/100) 
gen whispanicorlatinx = hispanicorlatinx * (percentage/100) 
gen whlwhitealone = hlwhitealone * (percentage/100) 
gen whlblackalone = hlblackalone * (percentage/100) 
gen whlindigenousalone = hlindigenousalone * (percentage/100) 
gen whlasianalone = hlasianalone * (percentage/100) 
gen whlpacificislanderalone = hlpacificislanderalone * (percentage/100) 
gen whlsomeotherraceaone = hlsomeotherraceaone * (percentage/100) 
gen whltwoormoreraces = hltwoormoreraces * (percentage/100) * (percentage/100) 
gen wnativeborn = nativeborn * (percentage/100) 
gen wforeignborn = foreignborn * (percentage/100) 
gen wnaturalizedcitizen = naturalizedcitizen* (percentage/100) 
gen wnotacitizen = notacitizen * (percentage/100)
drop totalpopulation whitealone blackalone indigenousalone asianalone pacificislanderalone someotherracealone twoormoreraces nothispanicorlatinx nothlwhitealone nothlblackalone nothlindigenousalone nothlasianalone nothlpacificislanderalone nothlsomeotherracealone nothltwoormoreraces hispanicorlatinx hlwhitealone hlblackalone hlindigenousalone hlasianalone hlpacificislanderalone hlsomeotherraceaone hltwoormoreraces nativeborn foreignborn naturalizedcitizen notacitizen
collapse (sum) wtotalpopulation wwhitealone wblackalone windigenousalone wasianalone wpacificislanderalone wsomeotherracealone wtwoormoreraces wnothispanicorlatinx wnothlwhitealone wnothlblackalone wnothlindigenousalone wnothlasianalone wnothlpacificislanderalone wnothlsomeotherracealone wnothltwoormoreraces whispanicorlatinx whlwhitealone whlblackalone whlindigenousalone whlasianalone whlpacificislanderalone whlsomeotherraceaone whltwoormoreraces wnativeborn wforeignborn wnaturalizedcitizen wnotacitizen, by(rd)
gen hl = 0
recode hl 0 = 1 if (whispanicorlatinx/wtotalpopulation) <= 0.176
recode hl 0 = 2 if ((whispanicorlatinx/wtotalpopulation) > 0.176) & ((whispanicorlatinx/wtotalpopulation) < 0.338)
recode hl 0 = 3 if (whispanicorlatinx/wtotalpopulation) >= 0.5
tab hl
drop wtotalpopulation wwhitealone wblackalone windigenousalone wasianalone wpacificislanderalone wsomeotherracealone wtwoormoreraces wnothispanicorlatinx wnothlwhitealone wnothlblackalone wnothlindigenousalone wnothlasianalone wnothlpacificislanderalone wnothlsomeotherracealone wnothltwoormoreraces whispanicorlatinx whlwhitealone whlblackalone whlindigenousalone whlasianalone whlpacificislanderalone whlsomeotherraceaone whltwoormoreraces wnativeborn wforeignborn wnaturalizedcitizen wnotacitizen
save uhl.dta, replace
uniformity assumption code finish */

/*
gen goodoverlap = 1 if percentage >= 90
recode goodoverlap . = 0
keep if goodoverlap == 1
// keep if any goodoverlap associated with rd == 1?
collapse (sum) totalpopulation whitealone blackalone indigenousalone asianalone pacificislanderalone someotherracealone twoormoreraces nothispanicorlatinx nothlwhitealone nothlblackalone nothlindigenousalone nothlasianalone nothlpacificislanderalone nothlsomeotherracealone nothltwoormoreraces hispanicorlatinx hlwhitealone hlblackalone hlindigenousalone hlasianalone hlpacificislanderalone hlsomeotherraceaone hltwoormoreraces nativeborn foreignborn naturalizedcitizen notacitizen, by(rd)
joinby rd using lapd_reporting_districts.dta, unm(both)
tab _merge
gen hl = 0
recode hl 0 = 1 if (hispanicorlatinx/totalpopulation) <= 0.176
recode hl 0 = 2 if ((hispanicorlatinx/totalpopulation) > 0.176) & ((hispanicorlatinx/totalpopulation) < 0.338)
recode hl 0 = 3 if (hispanicorlatinx/totalpopulation) >= 0.5
recode hl 3 = . if _merge == 2
tab hl
*/
