#Replication Materials 📦
This repository contains the full replication package accompanying the paper:
An Empirical Study of Student Team Collaboration and Success in an Agile Software Engineering Course
Authors: Damjan Fujs, Damjan Vavpotič and Marko Poženel.
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

Notes

Data are anonymized following guidelines for educational research.
IDs are pseudonymized and cannot be linked back to students.


📋 Survey Instrument (1KA)
Contains the full text of all survey items exactly as presented to students, including:

📝 User Story Sets
The project used multiple user story sets for team assignments.


📊 R Analyses
All statistical analyses from the manuscript are contained in the analysis/ directory.

🙌 Citation
If you use this dataset or code, please cite:
[TO BE DONE WHEN PUBLISHED]


