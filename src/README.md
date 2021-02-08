
##  <a name="usage"></a>Using COVIDHunter
- Install Xcode
- Add New Swift Project
- Use COVIDHunter/src/COVIDHunter.swift
- Run the project
- Change the default settings as needed, [Available parameters](#parameter)
    
    
## <a name="parameter"></a>Available parameters
| General Variable      | Value (Switzerland) |  Description |
| --------------------- |:-------------------:| :------------|
||                        **General Settings:**                             ||
| `START_MONTH`           | 1                   |  Start simulation on January (use normal 1-12 representation for month here)       |
| `NUM_DAYS`              | 730                 |  Maximum number of simulation days        |
| `FIRST_INFECTION_DAY`   | 45                  |  The day of first infection that is imported into population       |
| `MAX_VICTIMS`          | 25                  |  maximum number of folks one person can infect (minimum is always 0). Assumes a normal distribution      |
| `POPULATION` :wrench:           | 8654622             |   Population size to simulate (in this case Swiss population in 2020)       |
||                        **Virus Properties:**                             ||
| `X` :wrench:   | 0.02780                   |  hospitalizations-to-cases ratio, for CRW-100% = 4.288% for CTC-100% = 2.780% |
| `Y` :wrench:   | 0.01739                   |   deaths-to-cases ratio, for CRW-100% = 2.730% for CTC-100% = 1.739%       |
| `MIN_INCUBATION_DAYS`   | 1                   |   minimum number of days from being infected to being contagious       |
| `MAX_INCUBATION_DAYS`   | 5                   |   maximum number of days from being infected to being contagious       |
| `R0_INTRINSIC`   :wrench:       | 2.7                 |   The base reproduction number, R0    |
||                        **Travel Information:**                            ||
| `TRAVEL_SICK_RATE`      | 15                  |   percent chance a traveler returning from a trip abroad is contagious and undetected       |
| `TRAVELERS_PER_DAY`     | 100                 |   Number of travelers entering country from abroad every day as of first travel day      |
| `FIRST_TRAVEL_DAY`      | 45                  |   The day of first infection that is imported into population       |
| `LAST_TRAVEL_DAY`       | 9999                |   Point at which potentially infected travelers (some of whom are contagious) start entering country  
||                        **Environmental Chnage Information (CTC):**                             ||
| `TEMP_SCALING_FACTOR_CTC`  | 0.0367          |   Linear scaling of infectiousness per degree temperature drop. 0.0367 => 3.67% more infectious per degree of temperature drop      |
| `TEMP_SCALING_FLOOR_CTC`   | 1                 |   Limit temperature below which linear temperature scaling is no longer applied to the R0 value.    |
| `TEMP_SCALING_CEILING_CTC`   | 29                  |   Limit temperature above which linear temperature scaling is no longer applied to the R0 value.     |
| `TEMP_MONTHLY_HIGH`  | [4, 6, 11, 15, 19, 23, 25, 24, 20, 15, 9, 5]                  |   Monthly average of daytime temperature data (high) in degrees C.      |
||                        **Environmental Change Information (Harvard CRW):**                             ||
| `CRW_Harvard` :wrench:  | [0.997142857, 0.992428571, 0.998857143, 1.002714286, 0.995571429, 0.990714286, 0.978571429, 0.964571429, 0.948428571, 0.923571429, 0.902571429, 0.902285714, 0.900428571, 0.865, 0.869285714, 0.869, 0.858142857, 0.847857143, 0.851, 0.857142857, 0.851, 0.843428571, 0.85, 0.856428571, 0.851428571, 0.845428571, 0.84, 0.841857143, 0.846857143, 0.848714286, 0.841, 0.833571429, 0.836285714, 0.849714286, 0.864428571, 0.874142857, 0.890714286, 0.902428571, 0.906285714, 0.922714286, 0.945142857, 0.960285714, 0.959285714, 0.984285714, 1.018142857, 1.034285714, 1.017714286, 1.026428571, 1.037142857]                  |   CRW value extracted from https://projects.iq.harvard.edu/covid19/global      |
| `CRW_Harvard_TRANSITIONS` :wrench:  | [3, 10, 17, 24, 31, 38, 44, 51, 58, 66, 73, 80, 87, 116, 123, 130, 137, 144, 151, 158, 165, 172, 179, 186, 193, 200, 207, 214, 221, 228, 235, 242, 249, 256, 263, 270, 277, 284, 291, 298, 305, 312, 319, 326, 333, 340, 347, 354, 361]                  |    Day transition of CRW value, extracted from: https://projects.iq.harvard.edu/covid19/global     |
||                        **Mitigation Measures:**                             ||
| `M` :wrench:  | [0, 0.45, 0.7,  0.7, 0.65, 0.63, 0.5, 0.35, 0.6, 0.7,  0.7, 0.7, 0.73,  0.35, 0.73, 0.73]                  |   The strength of each mitigation measure, this is an example for fitting the curve of observed cases with a certinty rate of 100% with CTC environmental approach      |
| `TRANSITIONS`  :wrench: | [1,   58,  77,  118,  132,  151, 174,  245, 284, 303,  320, 330,  356,  387, 420,  450, 9999]                  |   Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999      |

:wrench: Indicates that these parameters should be changed based on the subject country. Other parameters can be used with their default value.

##  <a name="output">An Example of COVIDHunter Simulation Output</a>
This is an example of the simulation output of COVIDHunter. We only show below the entries for 99th and 100th days.

```
Day, Uninfected, Daily Cases, Daily Hospitalizations, Daily Deaths, Active Cases, Contagious, Immune, Travelers, R0, Ce(t), M(t), R0*(1-M(t)), R0*Ce(t), R(t)=R0*Ce(t)*(1-M(t)), Observed R(t)
99, 8533775, 2136, 59.381, 37.145, 6956, 2662, 112109, 776, 2.700, 1.000, 0.700, 0.810, 2.700, 0.810, 0.801
100, 8531868, 1907, 53.015, 33.163, 6702, 2390, 114769, 786, 2.700, 1.000, 0.700, 0.810, 2.700, 0.810, 0.800
COVIDHunter model completes after 100 days. STOP Reason = Completed requested number of days (disease is still active)
total infected (all phases)=1.418% total immune (all phases)=1.230%
Program ended with exit code: 0
```
