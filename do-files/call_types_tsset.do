cd /Volumes/KALLEY/Stata/
clear
use call_types_tsset.dta

regress codesix3 Feb6_Pulse i.Day i.Season // - 8.69
regress man3 Feb6_Pulse i.Day i.Season // 1.22
regress grp3 Feb6_Pulse i.Day i.Season // -2.46
regress codethirty3 Feb6_Pulse i.Day i.Season // -0.50
regress suspnow3 Feb6_Pulse i.Day i.Season // 2.94
regress domviol3 Feb6_Pulse i.Day i.Season // 5.47
regress amb3 Feb6_Pulse i.Day i.Season // 3.38
regress susp3 Feb6_Pulse i.Day i.Season // -0.02
regress trespasssusp3 Feb6_Pulse i.Day i.Season // -0.08
regress radio3 Feb6_Pulse i.Day i.Season // -1.17
regress posssusp3 Feb6_Pulse i.Day i.Season // -0.66
regress family3 Feb6_Pulse i.Day i.Season // -1.65
regress woman3 Feb6_Pulse i.Day i.Season // 0.26
regress jo3 Feb6_Pulse i.Day i.Season // -1.15
regress manwmn3 Feb6_Pulse i.Day i.Season // -3.12
regress hrmisd3 Feb6_Pulse i.Day i.Season // 2.57
regress invest3 Feb6_Pulse i.Day i.Season // -8.24
regress busn3 Feb6_Pulse i.Day i.Season // 0.51
regress trafficstop3 Feb6_Pulse i.Day i.Season // -9.24
regress unknowntrouble3 Feb6_Pulse i.Day i.Season // 1.75
regress suspjl3 Feb6_Pulse i.Day i.Season // 2.06
regress neighbor3 Feb6_Pulse i.Day i.Season // 0.50
regress complaint3 Feb6_Pulse i.Day i.Season // -0.68

regress p_codesix3 Feb6_Pulse i.Day i.Season // -0.73
regress p_man3 Feb6_Pulse i.Day i.Season // 0.64
regress p_grp3 Feb6_Pulse i.Day i.Season // -0.36
regress p_codethirty3 Feb6_Pulse i.Day i.Season // -0.01
regress p_suspnow3 Feb6_Pulse i.Day i.Season // 0.88
regress p_domviol3 Feb6_Pulse i.Day i.Season // 1.41
regress p_amb3 Feb6_Pulse i.Day i.Season // 0.89
regress p_susp3 Feb6_Pulse i.Day i.Season // 0.14
regress p_trespasssusp3 Feb6_Pulse i.Day i.Season // 0.18
regress p_radio3 Feb6_Pulse i.Day i.Season // -0.28
regress p_posssusp3 Feb6_Pulse i.Day i.Season // -0.05
regress p_family3 Feb6_Pulse i.Day i.Season // -0.28
regress p_woman3 Feb6_Pulse i.Day i.Season // 0.16
regress p_jo3 Feb6_Pulse i.Day i.Season // -0.24
regress p_manwmn3 Feb6_Pulse i.Day i.Season // -0.63
regress p_hrmisd3 Feb6_Pulse i.Day i.Season // 0.62
regress p_invest3 Feb6_Pulse i.Day i.Season // -1.72
regress p_busn3 Feb6_Pulse i.Day i.Season // 0.18
regress p_trafficstop3 Feb6_Pulse i.Day i.Season // -1.94
regress p_unknowntrouble3 Feb6_Pulse i.Day i.Season // 0.46
regress p_suspjl3 Feb6_Pulse i.Day i.Season // 0.55
regress p_neighbor3 Feb6_Pulse i.Day i.Season // 0.14
regress p_complaint3 Feb6_Pulse i.Day i.Season // -0.10

regress p_invest3 May21_Pulse i.Day i.Season // -1.13
regress p_invest3 Sep24_Pulse i.Day i.Season // -1.14
regress p_invest3 Feb11_Pulse i.Day i.Season // -0.02
regress p_invest3 Jun10_Pulse i.Day i.Season // 0.10
regress p_invest3 Sep23_Pulse i.Day i.Season // -0.49

regress p_trafficstop3 May21_Pulse i.Day i.Season // -1.70
regress p_trafficstop3 Sep24_Pulse i.Day i.Season // -0.75
regress p_trafficstop3 Feb11_Pulse i.Day i.Season // 0.14
regress p_trafficstop3 Jun10_Pulse i.Day i.Season // -0.67
regress p_trafficstop3 Sep23_Pulse i.Day i.Season // 2.01

regress p_codesix3 Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season
regress p_man3 Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season
regress p_grp3 Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season
regress p_codethirty3 Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season
regress p_suspnow3 Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season
regress p_trespasssusp3 Feb6_Pulse Feb6_Step Feb6_Count i.Day i.Season

// February 6
drop if Date1 < 20856 | Date1 > 20915
line p_codesix1 p_codesix2 p_codesix3 Date2
line p_man1 p_man2 p_man3 Date2 // 
line p_grp1 p_grp2 p_grp3 Date2
line p_codethirty1 p_codethirty2 p_codethirty3 Date2 // 
line p_suspnow1 p_suspnow2 p_suspnow3 Date2
line p_domviol1 p_domviol2 p_domviol3 Date2
line p_party1 p_party2 p_party3 Date2
line p_amb1 p_amb2 p_amb3 Date2
line p_susp1 p_susp2 p_susp3 Date2
line p_trespasssusp1 p_trespasssusp2 p_trespasssusp3 Date2 // 
line p_radio1 p_radio2 p_radio3 Date2
line p_posssusp1 p_posssusp2 p_posssusp3 Date2
line p_family1 p_family2 p_family3 Date2
line p_woman1 p_woman2 p_woman3 Date2
line p_jo1 p_jo2 p_jo3 Date2
line p_manwmn1 p_manwmn2 p_manwmn3 Date2
line p_hrmisd1 p_hrmisd2 p_hrmisd3 Date2
line p_invest1 p_invest2 p_invest3 Date2 // 
line p_busn1 p_busn2 p_busn3 Date2 //\
line p_trafficstop1 p_trafficstop2 p_trafficstop3 Date2 //\
line p_unknowntrouble1 p_unknowntrouble2 p_unknowntrouble3 Date2
line p_suspjl1 p_suspjl2 p_suspjl3 Date2
line p_neighbor1 p_neighbor2 p_neighbor3 Date2
line p_complaint1 p_complaint2 p_complaint3 Date2 //

clear
use call_types_tsset.dta

// May 21
drop if Date1 < 20960 | Date1 > 21021
line p_codesix1 p_codesix2 p_codesix3 Date2
line p_man1 p_man2 p_man3 Date2 // 
line p_grp1 p_grp2 p_grp3 Date2
line p_codethirty1 p_codethirty2 p_codethirty3 Date2 // 
line p_suspnow1 p_suspnow2 p_suspnow3 Date2
line p_domviol1 p_domviol2 p_domviol3 Date2
line p_party1 p_party2 p_party3 Date2
line p_amb1 p_amb2 p_amb3 Date2
line p_susp1 p_susp2 p_susp3 Date2
line p_trespasssusp1 p_trespasssusp2 p_trespasssusp3 Date2 // 
line p_radio1 p_radio2 p_radio3 Date2
line p_posssusp1 p_posssusp2 p_posssusp3 Date2
line p_family1 p_family2 p_family3 Date2
line p_woman1 p_woman2 p_woman3 Date2
line p_jo1 p_jo2 p_jo3 Date2
line p_manwmn1 p_manwmn2 p_manwmn3 Date2
line p_hrmisd1 p_hrmisd2 p_hrmisd3 Date2
line p_invest1 p_invest2 p_invest3 Date2 // 
line p_busn1 p_busn2 p_busn3 Date2 //\
line p_trafficstop1 p_trafficstop2 p_trafficstop3 Date2 //\
line p_unknowntrouble1 p_unknowntrouble2 p_unknowntrouble3 Date2
line p_suspjl1 p_suspjl2 p_suspjl3 Date2
line p_neighbor1 p_neighbor2 p_neighbor3 Date2
line p_complaint1 p_complaint2 p_complaint3 Date2 //
