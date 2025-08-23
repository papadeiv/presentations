# Slides and source code of my presentations 

In this repository I have collected both the LaTeX-Beamer templates and the Julia/Python/MATLAB scripts I've used to make some of the presentations I gave.

Each subdirectory is associated one-to-one to a single event such as conference presentations, seminar talks and poster sessions.

The structure of each subdirectory is kept consistent in the repo and it follows this scheme:

```bash
yy-mm-EVENT/
├── doc/                # Compiled PDF of the slides and source code 
│   ├── abstract/       # LaTeX template and abstract code 
│   └── presentation/   # Beamer template and slides code 
├── inc/                # Include files collecting the source code in src/ 
├── sim/                # Scripts used to generate the figures in the notes
└── src/                # Functions and modules used by the scripts in sim/ 
```

The subdriectories are sorted in ascending chronological order and they are associated to the following events:
- December 2024: conference talk at the [joint meeting of the American, Australian and New Zealand Mathematical Societies](./24-12-NZMS/) (NZMS) in Auckland, NZ;
- May 2025: poster session at the [biennial conference on Dynamical Systems of the Society of the Industrial and Applied Mathematics](./25-05-SIAM/) (SIAM) in Denver, US;
- May 2025: seminar at the [Centre for Systems, Dynamics and Control](./25-05-UoE/) (CSDC) in Exeter, UK;
- July 2025: talk at the [biennial Global Tipping Points conference](./25-07-GTP/) (GTP) in Exeter, UK;
- July 2025: short talk at the [summer school on Recent Trends in Probability and Statistics](./25-07-P@W/) (P@W) in Coventry, UK;
- September 2025: two-parts seminar at the [Centre of Mathematical Social Sciences](./25-09-CMSS/) (CMSS) in Auckland, NZ.
