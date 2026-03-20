// --------------------------------------------------------------------------------------------------------------
// 								
//									Replication Code for:
//
//	Replication: Do Coaches Stick With What Barely Worked? Evidence of Outcome Bias in Sports
//
//				Author names: Meier, Pascal Flurin; Flepp, Raphael; Franck, Egon
// --------------------------------------------------------------------------------------------------------------


// -----------------------------------------------------------------------------------------
// 									Preparatory steps
// ----------------------------------------------------------------------------------------- 

* This file (re)produces the results in the accompanying paper. The results have been produced on July 13, 2023 using STATA/SE 16.1. Log file can be requested.

* Variable names: See the accompanying data handbook

* Note: As outlined in the paper, we focus on the conventional RD estimate with a conventional variance estimator and bias-corrected RD estimate with robust standard errors. We ignore bias-corrected RD estimates with conventional variance estimator as estimated using the "rdrobust" command. For readibilty and comprehensibility of the code, we keep it as simple as possible. As a consequence, the bias-corrected RD estimates with conventional variance estimator are also displayed in the excel output. 

* 1. Install packages
ssc install rdrobust

* 2. Set working directory
cd 

* 3. Set maxvar
set maxvar 32767

*4. Run the code below
log using LogFile_Replication_OutcomeBias, replace

 
// -----------------------------------------------------------------------------------------
// 										NBA
// ----------------------------------------------------------------------------------------- 

*Load data
use "NBA_JEP.dta", clear 

*Generate team season FE
egen team_season_id=group(team season)
tabulate team_season_id, generate(fe_team_season)

*Figure A1: Histogram NBA
hist scorediff
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs10))) editcopy
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
graph save figure_a1.gph, replace

*Figure 1: RDD Plot - NBA
rdplot lineupchange scorediff if scorediff<=15 & scorediff>=-15, p(2) ci(95) shade
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .title.text = {}
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush LineupChange
gr_edit .xaxis1.reset_rule -15 15 3 , tickset(major) ruletype(range) 
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(vvthin)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(linestyle(color(gs14))) editcopy
graph save figure_1.gph, replace

*Figure A5: Sensitivity to the Bandwidth - NBA
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(5.01) 
estimates store m1
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(10.01) 
estimates store m2
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(15.01) 
estimates store m3
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) 
estimates store m4
coefplot m1 m2 m3 m4, replace xline(0) yline(0) asequation swapnames levels(95) vertical

gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .plotregion1._xylines[1].style.editstyle linestyle(color(none)) editcopy
gr_edit .yaxis1.style.editstyle draw_major_grid(yes) editcopy 
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(thin)))) editcopy 
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs15)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(force_nomax(no))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(draw_max(yes))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot3.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot5.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot7.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot1._set_type rcap
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot3._set_type rcap
gr_edit .plotregion1.plot3.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot5._set_type rcap
gr_edit .plotregion1.plot5.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot7._set_type rcap
gr_edit .plotregion1.plot7.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Bandwidth
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush Conventional RD Treatment Estimator
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 1 1 `"5 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 2 2 `"10 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 3 3 `"15 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 4 4 `"data-driven"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .yaxis1.reset_rule -0.15 0.05 0.05 , tickset(major) ruletype(range) 
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(pattern(longdash)) editcopy
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(color(black)) editcopy
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(width(vthin)) editcopy
gr_edit .plotregion1._xylines[2].z = 0.0
graph save figure_a5.gph, replace

*Table 1 Panel A: Results - Basketball
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_a.xls, replace nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(I All (1990/91-2019/20))
rdrobust lineupchange scorediff, c(0) covs(home winperc5games) vce(cluster team_season_id) all
outreg2 using table_1_panel_a.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(II All (1990/91-2019/20))
rdrobust lineupchange scorediff, c(0) covs(home winperc5games fe_team_season*) vce(cluster team_season_id) all
outreg2 using table_1_panel_a.xls, append nonote dec(3) addtext(Team-Season FE, Yes, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(III All (1990/91-2019/20))
rdrobust lineupchange scorediff if season_n<=2004, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_a.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(IV Early (1990/91-2004/05))
rdrobust lineupchange scorediff if season_n>=2005, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_a.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(V Late (2005/06-2019/20))

*Table A1 Panel A: Descriptive Statisics
tabstat lineupchange scorediff home winperc5games, statistics(n mean sd p25 p50 p75) col(stats) varwidth(4) save
return list
matrix A = r(Stat2)
putexcel set "table_a1_panel_a.xls", replace
putexcel A1 = matrix(A), names 
matrix results = r(StatTotal)'
putexcel set "table_a1_panel_a.xls", modify
putexcel A1 = matrix(results), names nformat(0.000)

*Table A2: Winning Percentage in Prior Five Games
rdrobust winperc5games scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_a2.xls, replace nonote dec(3) addtext(FE, No, Controls, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(I NBA)


// -----------------------------------------------------------------------------------------
// 										WNBA
// ----------------------------------------------------------------------------------------- 

*Load data
use "WNBA_JEP.dta", clear 

*Generate team season FE
egen team_season_id=group(team season)
tabulate team_season_id, generate(fe_team_season)

*Figure A2: Histogram WNBA
hist scorediff
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs10))) editcopy
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
graph save figure_a2.gph, replace

*Figure 2: RDD Plot – WNBA
rdplot lineupchange scorediff if scorediff<=15 & scorediff>=-15, p(2) ci(95) shade
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .title.text = {}
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush LineupChange
gr_edit .xaxis1.reset_rule -15 15 3 , tickset(major) ruletype(range) 
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(vvthin)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(linestyle(color(gs14))) editcopy
graph save figure_2.gph, replace

*Table 1 Panel B: Results - Basketball
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_b.xls, replace nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(I All (1997-2019))
rdrobust lineupchange scorediff, c(0) covs(home winperc5games) vce(cluster team_season_id) all
outreg2 using table_1_panel_b.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(II All (1997-2019))
rdrobust lineupchange scorediff, c(0) covs(home winperc5games fe_team_season*) vce(cluster team_season_id) all
outreg2 using table_1_panel_b.xls, append nonote dec(3) addtext(Team-Season FE, Yes, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(III All (1997-2019))
rdrobust lineupchange scorediff if season_n<=2007, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_b.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(IV Early (1997-2009))
rdrobust lineupchange scorediff if season_n>=2008, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_b.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(V Late (2010-2019))

*Figure A6: Sensitivity to the Bandwidth - WNBA
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(5.01) 
estimates store m1
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(10.01) 
estimates store m2
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(15.01) 
estimates store m3
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) 
estimates store m4
coefplot m1 m2 m3 m4, replace xline(0) yline(0) asequation swapnames levels(95) vertical

gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .plotregion1._xylines[1].style.editstyle linestyle(color(none)) editcopy
gr_edit .yaxis1.style.editstyle draw_major_grid(yes) editcopy 
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(thin)))) editcopy 
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs15)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(force_nomax(no))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(draw_max(yes))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot3.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot5.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot7.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot1._set_type rcap
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot3._set_type rcap
gr_edit .plotregion1.plot3.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot5._set_type rcap
gr_edit .plotregion1.plot5.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot7._set_type rcap
gr_edit .plotregion1.plot7.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Bandwidth
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush Conventional RD Treatment Estimator
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 1 1 `"5 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 2 2 `"10 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 3 3 `"15 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 4 4 `"data-driven"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .yaxis1.reset_rule -0.15 0.05 0.05 , tickset(major) ruletype(range) 
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(pattern(longdash)) editcopy
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(color(black)) editcopy
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(width(vthin)) editcopy
gr_edit .plotregion1._xylines[2].z = 0.0
graph save figure_a6.gph, replace

*Table A1 Panel B: Descriptive Statisics
tabstat lineupchange scorediff home winperc5games, statistics(n mean sd p25 p50 p75) col(stats) varwidth(4) save
return list
matrix A = r(Stat2)
putexcel set "table_a1_panel_b.xls", replace
putexcel A1 = matrix(A), names 
matrix results = r(StatTotal)'
putexcel set "table_a1_panel_b.xls", modify
putexcel A1 = matrix(results), names nformat(0.000)

*Table A2: Winning Percentage in Prior Five Games
rdrobust winperc5games scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_a2.xls, append nonote dec(3) addtext(FE, No, Controls, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(II WNBA)


// -----------------------------------------------------------------------------------------
// 										College Basketball
// ----------------------------------------------------------------------------------------- 

*Load data
use "NCAA_JEP.dta", clear 

*Generate team season FE
egen team_season_id=group(team season)
tabulate team_season_id, generate(fe_team_season)

*Figure A3: Histogram Collegiate basketball
hist scorediff
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs10))) editcopy
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
graph save figure_a3.gph, replace

*Figure 3: RDD Plot - Collegiate basketball
rdplot lineupchange scorediff if scorediff<=15 & scorediff>=-15, p(2) ci(95) shade
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .title.text = {}
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush LineupChange
gr_edit .xaxis1.reset_rule -15 15 3 , tickset(major) ruletype(range) 
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(vvthin)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(linestyle(color(gs14))) editcopy
graph save figure_3.gph, replace

*Table 1 Panel C: Results - Basketball
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_c.xls, replace nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(I All (2006/07-2019/20))
rdrobust lineupchange scorediff, c(0) covs(home winperc5games) vce(cluster team_season_id) all
outreg2 using table_1_panel_c.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(II All (2006/07-2019/20))
rdrobust lineupchange scorediff, c(0) covs(home winperc5games fe_team_season*) vce(cluster team_season_id) all
outreg2 using table_1_panel_c.xls, append nonote dec(3) addtext(Team-Season FE, Yes, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(III All (2006/07-2019/20))
rdrobust lineupchange scorediff if season_n<=2012, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_c.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(IV Early (2006/07-2012/13))
rdrobust lineupchange scorediff if season_n>=2013, c(0) vce(cluster team_season_id) all
outreg2 using table_1_panel_c.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(V Late (2013/14-2019/20))

*Figure A7: Sensitivity to the Bandwidth - Collegiate basketball
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(5.01) 
estimates store m1
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(10.01) 
estimates store m2
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(15.01) 
estimates store m3
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) 
estimates store m4
coefplot m1 m2 m3 m4, replace xline(0) yline(0) asequation swapnames levels(95) vertical

gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .plotregion1._xylines[1].style.editstyle linestyle(color(none)) editcopy
gr_edit .yaxis1.style.editstyle draw_major_grid(yes) editcopy 
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(thin)))) editcopy 
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs15)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(force_nomax(no))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(draw_max(yes))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot3.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot5.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot7.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot1._set_type rcap
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot3._set_type rcap
gr_edit .plotregion1.plot3.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot5._set_type rcap
gr_edit .plotregion1.plot5.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot7._set_type rcap
gr_edit .plotregion1.plot7.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Bandwidth
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush Conventional RD Treatment Estimator
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 1 1 `"5 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 2 2 `"10 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 3 3 `"15 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 4 4 `"data-driven"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .yaxis1.reset_rule -0.15 0.05 0.05 , tickset(major) ruletype(range) 
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(pattern(longdash)) editcopy
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(color(black)) editcopy
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(width(vthin)) editcopy
gr_edit .plotregion1._xylines[2].z = 0.0
graph save figure_a7.gph, replace

*Table A1 Panel C: Descriptive Statisics
tabstat lineupchange scorediff home winperc5games, statistics(n mean sd p25 p50 p75) col(stats) varwidth(4) save
return list
matrix A = r(Stat2)
putexcel set "table_a1_panel_c.xls", replace
putexcel A1 = matrix(A), names 
matrix results = r(StatTotal)'
putexcel set "table_a1_panel_c.xls", modify
putexcel A1 = matrix(results), names nformat(0.000)

*Table A2: Winning Percentage in Prior Five Games
rdrobust winperc5games scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_a2.xls, append nonote dec(3) addtext(FE, No, Controls, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(III NCAA)

// -----------------------------------------------------------------------------------------
// 										NFL
// ----------------------------------------------------------------------------------------- 

*Load data
use "NFL_JEP.dta", clear 

*Generate team season FE
egen team_season_id=group(team season)
tabulate team_season_id, generate(fe_team_season)

*Figure A4: Histogram NFL
hist scorediff
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs10))) editcopy
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
graph save figure_a4.gph, replace

*Figure 4: RDD Plot – NFL (LineupChange)
rdplot lineupchange scorediff if scorediff<=15 & scorediff>=-15, p(2) ci(95) shade
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .title.text = {}
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush LineupChange
gr_edit .xaxis1.reset_rule -15 15 3 , tickset(major) ruletype(range) 
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(vvthin)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(linestyle(color(gs14))) editcopy
graph save figure_4.gph, replace

*Figure 5: RDD Plot – NFL (LineupChangeNum) 
rdplot lineupchangenumber scorediff if scorediff<=15 & scorediff>=-15, p(2) ci(95) shade
gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .title.text = {}
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Running Variable: ScoreDiff
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush LineupChangeOffNum
gr_edit .xaxis1.reset_rule -15 15 3 , tickset(major) ruletype(range) 
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(vvthin)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs14)))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(shadestyle(color(gs14))) editcopy
gr_edit .plotregion1.plot2.style.editstyle area(linestyle(color(gs14))) editcopy
graph save figure_5.gph, replace

*Table 2, Panel A: Results – NFL
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_2_panel_a.xls, replace nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(I All (2004-2019))
rdrobust lineupchange scorediff, c(0) covs(home winperc5games) vce(cluster team_season_id) all
outreg2 using table_2_panel_a.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(II All (2004-2019))
rdrobust lineupchange scorediff, c(0) covs(home winperc5games fe_team_season*) vce(cluster team_season_id) all
outreg2 using table_2_panel_a.xls, append nonote dec(3) addtext(Team-Season FE, Yes, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(III All (2004-2019))
rdrobust lineupchange scorediff if season_n<=2004, c(0) vce(cluster team_season_id) all
outreg2 using table_2_panel_a.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(IV Early (1990-2004))
rdrobust lineupchange scorediff if season_n>=2005, c(0) vce(cluster team_season_id) all
outreg2 using table_2_panel_a.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(V Late (2005-2019))

*Table 2, Panel B: Results – NFL
rdrobust lineupchangenumber scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_2_panel_b.xls, replace nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(I All (2004-2019))
rdrobust lineupchangenumber scorediff, c(0) covs(home winperc5games) vce(cluster team_season_id) all
outreg2 using table_2_panel_b.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(II All (2004-2019))
rdrobust lineupchangenumber scorediff, c(0) covs(home winperc5games fe_team_season*) vce(cluster team_season_id) all
outreg2 using table_2_panel_b.xls, append nonote dec(3) addtext(Team-Season FE, Yes, Covariates, Yes) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(III All (2004-2019))
rdrobust lineupchangenumber scorediff if season_n<=2004, c(0) vce(cluster team_season_id) all
outreg2 using table_2_panel_b.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(IV Early (1990-2004))
rdrobust lineupchangenumber scorediff if season_n>=2005, c(0) vce(cluster team_season_id) all
outreg2 using table_2_panel_b.xls, append nonote dec(3) addtext(Team-Season FE, No, Covariates, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(V Late (2005-2019))

*Figure A8: Sensitivity to the Bandwidth - NFL
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(5.01) 
estimates store m1
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(10.01) 
estimates store m2
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) h(15.01) 
estimates store m3
rdrobust lineupchange scorediff, c(0) vce(cluster team_season_id) 
estimates store m4
coefplot m1 m2 m3 m4, replace xline(0) yline(0) asequation swapnames levels(95) vertical

gr_edit .style.editstyle boxstyle(shadestyle(color(white))) editcopy
gr_edit .style.editstyle boxstyle(linestyle(color(white))) editcopy
gr_edit .plotregion1._xylines[1].style.editstyle linestyle(color(none)) editcopy
gr_edit .yaxis1.style.editstyle draw_major_grid(yes) editcopy 
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(width(thin)))) editcopy 
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(linestyle(color(gs15)))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(force_nomax(no))) editcopy
gr_edit .yaxis1.style.editstyle majorstyle(gridstyle(draw_max(yes))) editcopy
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot3.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot5.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot7.style.editstyle area(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot2.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot4.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot6.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(fillcolor(white)) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(linestyle(color(black))) editcopy
gr_edit .plotregion1.plot8.style.editstyle marker(symbol(square)) editcopy
gr_edit .plotregion1.plot1._set_type rcap
gr_edit .plotregion1.plot1.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot3._set_type rcap
gr_edit .plotregion1.plot3.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot5._set_type rcap
gr_edit .plotregion1.plot5.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .plotregion1.plot7._set_type rcap
gr_edit .plotregion1.plot7.style.editstyle area(linestyle(width(thin))) editcopy
gr_edit .xaxis1.title.text = {}
gr_edit .xaxis1.title.text.Arrpush Bandwidth
gr_edit .yaxis1.title.text = {}
gr_edit .yaxis1.title.text.Arrpush Conventional RD Treatment Estimator
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 1 1 `"5 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 2 2 `"10 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 3 3 `"15 points"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .xaxis1.edit_tick 4 4 `"data-driven"', tickset(major)
gr_edit .xaxis1.major.num_rule_ticks = 0
gr_edit .yaxis1.reset_rule -0.15 0.05 0.05 , tickset(major) ruletype(range) 
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(pattern(longdash)) editcopy
gr_edit .legend.draw_view.setstyle, style(no)
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(color(black)) editcopy
gr_edit .plotregion1._xylines[2].style.editstyle linestyle(width(vthin)) editcopy
gr_edit .plotregion1._xylines[2].z = 0.0
graph save figure_a8.gph, replace

*Table A1 Panel D: Descriptive Statisics
tabstat lineupchange lineupchangenumber scorediff home winperc5games, statistics(n mean sd p25 p50 p75) col(stats) varwidth(4) save
return list
matrix A = r(Stat2)
putexcel set "table_a1_panel_d.xls", replace
putexcel A1 = matrix(A), names 
matrix results = r(StatTotal)'
putexcel set "table_a1_panel_d.xls", modify
putexcel A1 = matrix(results), names nformat(0.000)

*Table A2: Winning Percentage in Prior Five Games
rdrobust winperc5games scorediff, c(0) vce(cluster team_season_id) all
outreg2 using table_a2.xls, append nonote dec(3) addtext(FE, No, Controls, No) addstat(Bandwidth Regression, e(h_l), #L, e(N_h_l), #R, e(N_h_r)) symbol(***,**,*) alpha(0.001, 0.01, 0.05) cttop(IV NFL)

log close