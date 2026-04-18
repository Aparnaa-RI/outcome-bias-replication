Aparnaa Iyer
Term Project – Replication and Extension of Meier, Flepp, and Franck (2023)

Files included:
1. ipl_cricket_analysis_ready.dta
   - Prepared IPL dataset used for the extension analysis.

2. main_analysis.do
   - Stata do-file that reproduces the main regression specifications,
     descriptive statistics, and figures for the IPL extension.

3. final_analysis_log.smcl
   - Stata log file generated when running the do-file.

4. figure1_full_sample.png
   - Descriptive figure showing average opening lineup change by previous
     match result in the full sample.

5. figure2_close5.png
   - Descriptive figure showing average opening lineup change by previous
     match result in close games (±5 runs).

6. [Metrics term paper]
   - Final written term paper.

How to run the code:
1. Open Stata.
2. Open the file main_analysis.do.
3. Make sure the working directory in the do-file points to the Desktop
   where the data file is stored.
4. Run the entire do-file.
5. The code loads the prepared IPL dataset, runs the main regressions,
   reports descriptive statistics, and recreates the figures used in the paper.

Notes:
- The extension examines whether IPL teams are more likely to change their
  opening batting lineup after a narrow loss than after a narrow win.
- The main prepared dataset is ipl_cricket_analysis_ready.dta.