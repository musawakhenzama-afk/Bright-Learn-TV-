# BrightTV Viewership Analysis


This repository contains code, summaries and a 20-minute presentation to help BrightTV's Customer Value Management (CVM) team grow the subscription base.


## Contents
- `data/` - place the original `BrightTV_Viewership.csv` here (DO NOT commit PII to public repos).
- `data_summary/` - generated CSV summaries (daily, hourly, weekday, top channels).
- `notebooks/` - Jupyter notebook for exploratory analysis.
- `scripts/` - python scripts to run the analysis and create the presentation automatically.
- `outputs/` - charts and generated PPTX.
- `recommendations.md` - tactical recommendations and initiatives for CVM.


## How to run
1. Create a Python 3.9+ virtual environment and activate it:


```bash
python -m venv .venv
source .venv/bin/activate # macOS / Linux
.\.venv\Scripts\activate # Windows
