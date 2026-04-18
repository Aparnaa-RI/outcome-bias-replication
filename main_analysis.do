*******************************************************
* Aparnaa Iyer
* Term Project: Replication and IPL Extension
* Main analysis do-file
*******************************************************

capture log close
clear all
set more off

*------------------------------------------------------
* 1. Set working directory
*------------------------------------------------------
cd "C:\Users\rames\Desktop"

*------------------------------------------------------
* 2. Open prepared IPL dataset
*------------------------------------------------------
use "ipl_cricket_analysis_ready.dta", clear

*------------------------------------------------------
* 3. Start log file
*------------------------------------------------------
log using "final_analysis_log.smcl", replace

*------------------------------------------------------
* 4. Main regression results
*------------------------------------------------------

* Spec (1): Close games within 5 runs, team fixed effects
reg lineup_change won score_diff i.team_id if close5==1 & !missing(lineup_change)

* Spec (2): Close games within 10 runs, team fixed effects
capture confirm variable close10
if _rc {
    gen close10 = abs(score_diff) <= 10
}
reg lineup_change won score_diff i.team_id if close10==1 & !missing(lineup_change)

* Spec (3): Close games within 15 runs, team fixed effects
reg lineup_change won score_diff i.team_id if close15==1 & !missing(lineup_change)

* Spec (4): Close games within 5 runs, team and season fixed effects
reg lineup_change won score_diff i.team_id i.season_id if close5==1 & !missing(lineup_change)

*------------------------------------------------------
* 5. Descriptive statistics
*------------------------------------------------------

* Full sample means by previous match result
mean lineup_change if won==0 & !missing(lineup_change)
mean lineup_change if won==1 & !missing(lineup_change)

* Close games (±5 runs) means by previous match result
mean lineup_change if close5==1 & won==0 & !missing(lineup_change)
mean lineup_change if close5==1 & won==1 & !missing(lineup_change)

*------------------------------------------------------
* 6. Figures
*------------------------------------------------------

* Figure 1: Full sample
preserve
keep if !missing(lineup_change)
graph bar lineup_change, over(won, relabel(1 "Lost" 2 "Won")) ///
    title("Average Opening Lineup Change by Previous Match Result") ///
    ytitle("Mean of lineup_change") ///
    name(fig1, replace)
graph export "figure1_full_sample.png", replace
restore

* Figure 2: Close games within ±5 runs
preserve
keep if close5==1 & !missing(lineup_change)
graph bar lineup_change, over(won, relabel(1 "Lost" 2 "Won")) ///
    title("Average Opening Lineup Change in Close Games (±5 Runs)") ///
    ytitle("Mean of lineup_change") ///
    name(fig2, replace)
graph export "figure2_close5.png", replace
restore

*------------------------------------------------------
* 7. Close log
*------------------------------------------------------
log close