* Kalley Huang

cd /Volumes/KALLEY/Stata/
clear
use calls_over_time.dta
// collapse (sum) codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint, by(hl month year)
/* sort year month
gen my = ym(year, month)
format my %tmNN/YY
gen yeardec = year + (month - 1)/12
drop radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint */
tsset hl date1
// reshape wide codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint, i(hl) j(my)
reshape wide codesix man grp codethirty suspnow domviol party amb susp trespasssusp radio posssusp family woman jo manwmn hrmisd invest busn trafficstop unknowntrouble suspjl neighbor complaint, i(date1) j(hl)
gen total1 = codesix1 + man1 + grp1 + codethirty1 + suspnow1 + domviol1 + party1 + amb1 + susp1 + trespasssusp1 + radio1 + posssusp1 + family1 + woman1 + jo1 + manwmn1 + hrmisd1 + invest1 + busn1 + trafficstop1 + unknowntrouble1 + suspjl1 + neighbor1 + complaint1
gen total2 = codesix2 + man2 + grp2 + codethirty2 + suspnow2 + domviol2 + party2 + amb2 + susp2 + trespasssusp2 + radio2 + posssusp2 + family2 + woman2 + jo2 + manwmn2 + hrmisd2 + invest2 + busn2 + trafficstop2 + unknowntrouble2 + suspjl2 + neighbor2 + complaint2
gen total3 = codesix3 + man3 + grp3 + codethirty3 + suspnow3 + domviol3 + party3 + amb3 + susp3 + trespasssusp3 + radio3 + posssusp3 + family3 + woman3 + jo3 + manwmn3 + hrmisd3 + invest3 + busn3 + trafficstop3 + unknowntrouble3 + suspjl3 + neighbor3 + complaint3
gen p_codesix1 = codesix1 * 100 / total1
gen p_man1 = man1 * 100 / total1
gen p_grp1 = grp1  * 100 / total1
gen p_codethirty1 = codethirty1  * 100 / total1
gen p_suspnow1 = suspnow1  * 100 / total1
gen p_domviol1 = domviol1  * 100 / total1
gen p_party1 = party1  * 100 / total1
gen p_amb1 = amb1  * 100 / total1
gen p_susp1 = susp1  * 100 / total1
gen p_trespasssusp1 = trespasssusp1  * 100 / total1
gen p_radio1 = radio1 * 100 / total1
gen p_posssusp1 = posssusp1 * 100 / total1
gen p_family1 = family1 * 100 / total1
gen p_woman1 = woman1 * 100 / total1
gen p_jo1 = jo1 * 100 / total1
gen p_manwmn1 = manwmn1 * 100 / total1
gen p_hrmisd1 = hrmisd1 * 100 / total1
gen p_invest1 = invest1 * 100 / total1
gen p_busn1 = busn1 * 100 / total1
gen p_trafficstop1 = trafficstop1 * 100 / total1
gen p_unknowntrouble1 = unknowntrouble1 * 100 / total1
gen p_suspjl1 = suspjl1 * 100 / total1
gen p_neighbor1 = neighbor1 * 100 / total1
gen p_complaint1 = complaint1 * 100 / total1

gen p_codesix2 = codesix2  * 100 / total2
gen p_man2 = man2  * 100 / total2
gen p_grp2 = grp2  * 100 / total2
gen p_codethirty2 = codethirty2  * 100 / total2
gen p_suspnow2 = suspnow2  * 100 / total2
gen p_domviol2 = domviol2  * 100 / total2
gen p_party2 = party2  * 100 / total2
gen p_amb2 = amb2  * 100 / total2
gen p_susp2 = susp2  * 100 / total2
gen p_trespasssusp2 = trespasssusp2  * 100 / total2
gen p_radio2 = radio2 * 100 / total2
gen p_posssusp2 = posssusp2 * 100 / total2
gen p_family2 = family2 * 100 / total2
gen p_woman2 = woman2 * 100 / total2
gen p_jo2 = jo2 * 100 / total2
gen p_manwmn2 = manwmn2 * 100 / total2
gen p_hrmisd2 = hrmisd2 * 100 / total2
gen p_invest2 = invest2 * 100 / total2
gen p_busn2 = busn2 * 100 / total2
gen p_trafficstop2 = trafficstop2 * 100 / total2
gen p_unknowntrouble2 = unknowntrouble2 * 100 / total2
gen p_suspjl2 = suspjl2 * 100 / total2
gen p_neighbor2 = neighbor2 * 100 / total2
gen p_complaint2 = complaint2 * 100 / total2

gen p_codesix3 = codesix3  * 100 / total3
gen p_man3 = man3 * 100 / total3
gen p_grp3 = grp3 * 100 / total3
gen p_codethirty3 = codethirty3 * 100 / total3
gen p_suspnow3 = suspnow3 * 100 / total3
gen p_domviol3 = domviol3 * 100 / total3
gen p_party3 = party3 * 100 / total3
gen p_amb3 = amb3 * 100 / total3
gen p_susp3 = susp3 * 100 / total3
gen p_trespasssusp3 = trespasssusp3 * 100 / total3
gen p_radio3 = radio3 * 100 / total3
gen p_posssusp3 = posssusp3 * 100 / total3
gen p_family3 = family3 * 100 / total3
gen p_woman3 = woman3 * 100 / total3
gen p_jo3 = jo3 * 100 / total3
gen p_manwmn3 = manwmn3 * 100 / total3
gen p_hrmisd3 = hrmisd3 * 100 / total3
gen p_invest3 = invest3 * 100 / total3
gen p_busn3 = busn3 * 100 / total3
gen p_trafficstop3 = trafficstop3 * 100 / total3
gen p_unknowntrouble3 = unknowntrouble3 * 100 / total3
gen p_suspjl3 = suspjl3* 100 / total3
gen p_neighbor3 = neighbor3 * 100 / total3
gen p_complaint3 = complaint3 * 100 / total3

save call_types_tsset.dta, replace

// group by crime
// if difference between groups is statistically significant
line p_codesix1 p_codesix2 p_codesix3 date1
line p_domviol1 p_domviol2 p_domviol3 date1

#delimit;
line p_codesix1 p_codesix2 p_codesix3 yeardec, xline(2017.5 2018.083 2019.417)
xtitle("Month")
xlabel(2017(1)2019)
text(5 2017.5 "ICE Raid", placement(e))
ytitle("Percentage of Domestic Violence 911 Calls")
graphregion(color(white))
title("Hispanic and Non Hispanic Domestic Violence 911 Calls")
subtitle("Los Angeles Police Department, 2017 - 2019")
note("Assuming geographic uniformity.")
legend(label(1 "Low Hispanic(<39.3%)") label(2 "Mid Hispanic") label (3 "High Hispanic (>70%)"))
;
// gen ch_spending = (const_spending-l1.const_spending)*100/l1.const_spending/
