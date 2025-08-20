# Slides and source code of my presentations 

In this repository I have collected both the LaTeX-Beamer templates and the Julia/Python/MATLAB scripts I've used to make the presentations I gave at various conferences, seminars and poster sessions.

Each subdirectory is associated one-to-one to a single talk or conference event.

The structure of each subdirectory follows this scheme:

```bash
yy-mm-EVENT/
├── doc/                # LaTeX source files and compiled PDF of the notes
|   ├── abstract/       # LaTeX template and abstract code 
|   └── presentation/   # Beamer template and slides code 
├── inc/                # Include files collecting the source code in src/ 
├── sim/                # Scripts used to generate the figures in the notes
└── src/                # Functions and modules used by the scripts in sim/ 
```

The subdriectories are sorted in ascending chronological order and they are associated to the following events:
- December 2024: conference talk at the [./24-12-NZMS/](joint meeting of the American, Australian and New Zealand Mathematical Societies) (NZMS) in Auckland, NZ;
- May 2025: poster session at the [./25-05-SIAM/](biennial meeting of the Society of the Industrial and Applied Mathematics) (SIAM) in Denver, US;
- May 2025: seminar at the [./25-05-UoE/](Centre for Systems, Dynamics and Control) (CSDC) in Exeter, UK;
- July 2025: conference talk at the [./25-07-GTP/](biennial Global Tipping Points conference) (GTP) in Exeter, UK;
- July 2025: short talk at the [./25-07-P@W/](summer school on Recent Trends in Probability and Statistics) (P@W) in Coventry, UK;
- September 2025: two-parts seminar at the [./25-09-CMSS/](Centre of Mathematical Social Sciences) (CMSS) in Auckland, NZ;
