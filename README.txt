README – Replication Package for:
“Do Coaches Stick With What Barely Worked? Evidence of Outcome Bias in Sports”
Journal of Economic Psychology (2023)

Files included in this folder:
- Code_Replication_OutcomeBias.do
- NBA_JEP.dta
- NFL_JEP.dta
- NCAA_JEP.dta
- WNBA_JEP.dta

How to run the replication package:

1. Open Stata.

2. Set the working directory to this folder (the folder containing the .do file and all .dta files).

3. If needed, install the following Stata packages in the Command window:
   ssc install coefplot
   ssc install outreg2

4. Run the replication code by typing:
   do "Code_Replication_OutcomeBias.do"

5. The code will reproduce and export the tables and figures from the main paper into the root directory (this folder).

Notes:
- The data files must remain in the same folder as the .do file.
- The dataset filenames should be:
  NBA_JEP.dta
  NFL_JEP.dta
  NCAA_JEP.dta
  WNBA_JEP.dta
