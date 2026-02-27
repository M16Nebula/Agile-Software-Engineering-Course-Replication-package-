📦 Replication Package for: [Your Paper Title]
Automated Software Engineering (ASE) — Replication Materials
This repository contains the full replication package accompanying the paper:
[Full Paper Title]
Authors: [Your Names]
Journal: Automated Software Engineering
The package includes datasets, survey instruments, user story sets, R analysis scripts, and outputs necessary to fully reproduce all results reported in the manuscript.

📁 Repository Structure
├── data/
│   ├── dataset_raw.csv
│   ├── dataset_processed.csv
│   ├── codebook.md
│   └── README_data.md
│
├── survey/
│   ├── survey_items.md
│   ├── 1ka_export.csv
│   ├── 1ka_screenshot.pdf
│   └── README_survey.md
│
├── user_stories/
│   ├── set_A/
│   │   ├── stories.pdf
│   │   └── stories.csv
│   ├── set_B/
│   ├── set_C/
│   └── README_userstories.md
│
├── analysis/
│   ├── scripts/
│   │   ├── 01_cleaning.R
│   │   ├── 02_descriptive_stats.R
│   │   ├── 03_role_based_analysis.R
│   │   ├── 04_engagement_models.R
│   │   └── 05_visualizations.R
│   ├── output/
│   │   ├── tables/
│   │   ├── figures/
│   │   └── logs/
│   └── README_analysis.md
│
├── LICENSE
└── README.md

📘 Dataset
All datasets used in the study are available in the data/ directory.
Contents


dataset_raw.csv
Direct export from source (no preprocessing).


dataset_processed.csv
Ready-to-analyze version used in the paper. Contains:

Student roles
Expected vs. actual LLM usage ratings
Task complexity labels
Engagement variables
Teamwork and Scrum perception scores
Derived variables used in R scripts



codebook.md
Full explanation of variables, value ranges, and coding decisions.


Notes

Data are anonymized following guidelines for educational research.
IDs are pseudonymized and cannot be linked back to students.


📋 Survey Instrument (1KA)
The survey is stored in the survey/ directory.
Files


survey_items.md
Contains the full text of all survey items exactly as presented to students, including:

Expected LLM usage items
Actual LLM usage items
Task complexity perceptions
Engagement scale items
Scrum and teamwork perception items
Demographics
Open-ended questions



1ka_export.csv
Raw export from 1KA (1ka.si) including:

Item IDs
Response options
Raw answers



1ka_screenshot.pdf
PDF of the 1KA survey form for archival purposes.



📝 User Story Sets
The project used multiple user story sets for team assignments.
They are included in the user_stories/ directory.
Each set contains:

.pdf version (student-facing)
.csv version (machine-readable)
Metadata describing:

Story complexity
Dependencies
Intended technical roles
Acceptance criteria count



Sets included

Set A — baseline complexity
Set B — medium complexity
Set C — higher complexity / cross-cutting concerns


📊 R Analyses
All statistical analyses from the manuscript are contained in the analysis/ directory.
🔧 Scripts
1. 01_cleaning.R

Loads raw data
Re-codes survey items
Constructs scales (e.g., engagement, Scrum perception)
Generates the cleaned dataset used throughout the analysis

2. 02_descriptive_stats.R

Summary statistics for all main variables
Role distributions
Plotting histograms, boxplots, and correlation heatmaps

3. 03_role_based_analysis.R

Compares expected vs. actual LLM usage across roles
Includes:

ANOVA / Kruskal tests
Post-hoc comparisons
Effect sizes
Visualizations



4. 04_engagement_models.R

Regression models linking engagement with:

Teamwork ratings
Scrum phase perceptions
LLM usage patterns



5. 05_visualizations.R

Generates:

Figures for the manuscript
Role-based heatmaps
Engagement trajectories
Complexity × LLM usage plots



📤 Output
All generated tables and figures used in the submission appear in:
analysis/output/tables/
analysis/output/figures/

Each artifact is named consistently with its corresponding figure or table number in the paper.

🔁 Reproduction Guide
Requirements

R ≥ 4.2
R packages listed in analysis/README_analysis.md
(Optional) RStudio

Run the full pipeline
From the analysis/scripts/ directory:
Rsource("01_cleaning.R")source("02_descriptive_stats.R")source("03_role_based_analysis.R")source("04_engagement_models.R")source("05_visualizations.R")Show more lines
Alternatively:
Rmake allShow more lines
(if you include a Makefile)

📄 License
Specify the license here, e.g.:

This replication package is released under the MIT License.
All datasets are anonymized and may be reused for research and teaching purposes.


🙌 Citation
If you use this dataset or code, please cite:
[Your citation here]


Need further help?
I can also prepare:

A README_data.md, README_survey.md, and README_analysis.md
A Makefile for automated execution
Zenodo metadata for archiving
A badge set (DOI, license, reproducibility)

Just say the word!
