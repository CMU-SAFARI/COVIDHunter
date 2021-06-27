# COVIDHunter: An Accurate, Flexible, and Environment-Aware Open-Source COVID-19 Outbreak Simulation Model
A COVID-19 outbreak simulation model that evaluates the current mitigation measures (i.e., non-pharmaceutical intervention) that are applied to a region and provides insight into what strength the upcoming mitigation measure should be and for how long it should be applied, while considering the potential effect of environmental conditions. Our model accurately forecasts the numbers of cases, hospitalizations, and deaths for a given day. Described by Alser et al. (preliminary version at https://arxiv.org/abs/2102.03667 and https://doi.org/10.1101/2021.02.06.21251265).

## :white_check_mark: COVIDHunter Version 2 (June 2021)
- Compatible with COVIDHunter version 1
  - The reproduction number, R. 
  - The number of infected persons.
  - The number of hospitalized persons. 
  - The number of deaths.
  - The number of individuals at each stage of the COVID-19 infection (healthy, infected, contagious, and immune).
  - The strength and the duration of each mitigation measure.
- Support for a mutated virus with a different R0 value.
- Support for asymptomatic cases.
- Support for vaccinations.

To disable the new features in Version 2, please set the following parameters `FIRST_VARIANT_DAY`, `ASYMPTOMATIC_PERCENTAGE`, and `ENABLE_VACCINATIONS` to large number (larger than `NUM_DAYS`), 0, and false, respectively.



## <a name="demo"></a>Switzerland Case Study (using COVIDHunter)
Switzerland Case Study (using COVIDHunter): https://mealser.github.io/COVIDHunter


## <a name="started"></a>Getting Started
1. Install Xcode, [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/).
2. Add New Swift Project (File -> New -> Project -> macOS -> Command Line Tool). A new file, called main.swift, will be generated.
3. Copy the content of https://github.com/CMU-SAFARI/COVIDHunter/blob/main/src/COVIDHunter.swift to main.swift.
4. Run the project.
5. [An Example of COVIDHunter Simulation Output](#output).


## Table of Contents
- [Key Idea](#idea)
- [Benefits of COVIDHunter](#results)
- [Using COVIDHunter](#started)
  - [Getting Started](#started)
  - [Available Parameters](#parameter)
  - [An Example of COVIDHunter Simulation Output](#output)
- [Case Studies](#demo)  
   - [Switzerland Case Study (using COVIDHunter)](#demo)
   - [Reproducing Switzerland Case Study Results](#reproduce)
- [Supplementary Materials](#supp)
- [Getting Help](#contact)
- [Citing COVIDHunter](#cite)

##  <a name="idea"></a>The Key Idea 
The key idea of COVIDHunter is to quantify the spread of COVID-19 in a geographical region by calculating the daily reproduction number, R, of COVID-19 and scaling the reproduction number based on changes in both mitigation measures and environmental conditions. The R number describes how a pathogen spreads in a particular population by quantifying the average number of new infections caused by each infected person at a given point in time. The R number changes during the course of the pandemic due to the change in the ability of a pathogen to establish an infection during a season and mitigation measures that lead to the scarcity of susceptible individuals.

##  <a name="results"></a>Benefits of COVIDHunter 
To our knowledge, there is currently no model capable of accurately monitoring the current epidemiological situation and predicting future scenarios while considering a reasonably low number of parameters and accounting for the effects of environmental conditions. In this work, we develop such a COVID-19 outbreak simulation model, COVIDHunter. COVIDHunter accurately forecasts for a given day:

1. The reproduction number, R. 
2. The number of infected persons.
3. The number of hospitalized persons. 
4. The number of deaths.
5. The number of individuals at each stage of the COVID-19 infection (healthy, infected, contagious, and immune).
6. The strength and the duration of each mitigation measure.

COVIDHunter evaluates the effect of different current and future mitigation measures on the five numbers forecasted by COVIDHunter.
We release the source code of the COVIDHunter implementation and show how to flexibly configure our model for any scenario and easily extend it for different measures and conditions than we account for.

##  <a name="usage"></a>Using COVIDHunter
1. Install Xcode, [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/).
2. Add New Swift Project (File -> New -> Project -> macOS -> Command Line Tool). A new file, called main.swift, will be generated.
3. Copy the content of https://github.com/CMU-SAFARI/COVIDHunter/blob/main/src/COVIDHunter.swift to main.swift.
4. Change the default settings as needed, [Available parameters](#parameter).
5. Run the project.
6. [An Example of COVIDHunter Simulation Output](#output).

    
## <a name="parameter"></a>Available Parameters
### COVIDHunter Version 2 (additional parameters to Version 1)
| General Variable      | Value (Switzerland) |  Description |
| --------------------- |:-------------------:| :------------|
||                        **Virus Properties:**                             ||
| `R0_INTRINSIC_VARIANT1`     :wrench:      | 6.0                  |   The base reproduction number, R0, for the virus variant       |
| `IMPORTED_MUTATION_RATE`    :wrench:       | 1                  |  Percentage of imported cases that are of mutated variant 1 (as of FIRST_VARIANT_DAY).  Set to 0 to disable mutations       |
| `FIRST_VARIANT_DAY`      :wrench:     | 345                 | First day a traveller can bring in the mutated virus      |
||                        **Asymptomatic Cases:**                             ||
| `ASYMPTOMATIC_PERCENTAGE`    :wrench:       | 25                  |  Percentage of infections that are asymptomatic relative to symptomatic.  Asymptomatic folks gain immunity but are less contagious       |
| `R0_ASYMPTOMATIC`      :wrench:     | 2.0                  |  The base reproduction number, R0, for the asymptomatic cases      |
| `R0_ASYMPTOMATIC_VARIANT1` :wrench:          | 3.0                  |  The base reproduction number, R0, for the asymptomatic cases caused by the virus variant      |
||                        **Vaccination:**                             ||
| `ENABLE_VACCINATIONS`    :wrench:       | true                 |  Start simulation on January (use normal 1-12 representation for month here)       |
| `FIRST_VACCINATION_DAY`   :wrench:        | 380                  |  Our model assumes that you gain immunity immediately after vaccination. Thus you can increase this number by 14 days to account for the fact that vaccination will be effective (provide immunity) after two weeks.     |
| `VACCINATION_RATE`    :wrench:       | 0.3                  |  Percentage of population vaccinated against COVID-19 per day      |

### COVIDHunter Version 1
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

##  <a name="reproduce">Reproducing Switzerland Case Study Results</a>
To reproduce the exact same results we presented in our COVIDHunter paper for the Switzerland case study please follow the following steps:
1. Install Xcode, [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/).
2. Add New Swift Project (File -> New -> Project -> macOS -> Command Line Tool). A new file, called main.swift, will be generated.
3. Copy the content of https://github.com/CMU-SAFARI/COVIDHunter/blob/main/src/COVIDHunter.swift to main.swift.
5. Change the default settings in main.swift based on each configuration file provided in this directory: https://github.com/CMU-SAFARI/COVIDHunter/tree/main/Reproduce-Switzerland-Case-Study-Results.
6. Run the project.

##  <a name="supp">Supplementary Materials</a>
- Page 9-14: https://arxiv.org/pdf/2102.03667.pdf
- https://github.com/CMU-SAFARI/COVIDHunter/tree/main/Evaluation_Results

##  <a name="contact"></a>Getting Help
If you have any suggestion for improvement, please contact alserm at ethz dot ch
If you encounter bugs or have further questions or requests, you can raise an issue at the [issue page](https://github.com/CMU-SAFARI/COVIDHunter/issues).

## <a name="cite"></a>Citing COVIDHunter

If you use COVIDHunter in your work, please cite:

> Mohammed Alser, Jeremie S. Kim, Nour Almadhoun Alserr, Stefan W. Tell, Onur Mutlu, 
> "COVIDHunter: An Accurate, Flexible, and Environment-Aware Open-Source COVID-19 Outbreak Simulation Model", 
> medRxiv preprint **medRxiv**:10.1101/2021.02.06.21251265 (2021). [link](https://doi.org/10.1101/2021.02.06.21251265)

> Mohammed Alser, Jeremie S. Kim, Nour Almadhoun Alserr, Stefan W. Tell, Onur Mutlu, 
> "COVIDHunter: An Accurate, Flexible, and Environment-Aware Open-Source COVID-19 Outbreak Simulation Model", 
> arXiv preprint **arXiv**:2102.03667 (2021). [link](https://arxiv.org/abs/2102.03667)

Below is bibtex format for citation.

```bibtex
@article {Alser2021.02.06.21251265,
	author = {Alser, Mohammed and Kim, Jeremie S. and Almadhoun Alserr, Nour and Tell, Stefan W. and Mutlu, Onur},
	title = {COVIDHunter: An Accurate, Flexible, and Environment-Aware Open-Source COVID-19 Outbreak Simulation Model},
	elocation-id = {2021.02.06.21251265},
	year = {2021},
	doi = {10.1101/2021.02.06.21251265},
	publisher = {Cold Spring Harbor Laboratory Press},
	abstract = {Motivation: Early detection and isolation of COVID-19 patients are essential for successful implementation of mitigation strategies and eventually curbing the disease spread. With a limited number of daily COVID- 19 tests performed in every country, simulating the COVID-19 spread along with the potential effect of each mitigation strategy currently remains one of the most effective ways in managing the healthcare system and guiding policy-makers. We introduce COVIDHunter, a flexible and accurate COVID-19 outbreak simulation model that evaluates the current mitigation measures that are applied to a region and provides suggestions on what strength the upcoming mitigation measure should be. The key idea of COVIDHunter is to quantify the spread of COVID-19 in a geographical region by simulating the average number of new infections caused by an infected person considering the effect of external factors, such as environmental conditions (e.g., climate, temperature, humidity) and mitigation measures. Results: Using Switzerland as a case study, COVIDHunter estimates that the policy-makers need to keep the current mitigation measures for at least 30 days to prevent demand from quickly exceeding existing hospital capacity. Relaxing the mitigation measures by 50\% for 30 days increases both the daily capacity need for hospital beds and daily number of deaths exponentially by an average of 23.8x, who may occupy ICU beds and ventilators for a period of time. Unlike existing models, the COVIDHunter model accurately monitors and predicts the daily number of cases, hospitalizations, and deaths due to COVID-19. Our model is flexible to configure and simple to modify for modeling different scenarios under different environmental conditions and mitigation measures. Availability: https://github.com/CMU-SAFARI/COVIDHunter},
	URL = {https://doi.org/10.1101/2021.02.06.21251265},
	eprint = {https://www.medrxiv.org/content/early/2021/02/08/2021.02.06.21251265.full.pdf},
	journal = {medRxiv}
}
```

```bibtex
@misc{alser2021covidhunter,
      title={COVIDHunter: An Accurate, Flexible, and Environment-Aware Open-Source COVID-19 Outbreak Simulation Model}, 
      author={Mohammed Alser and Jeremie S. Kim and Nour Almadhoun Alserr and Stefan W. Tell and Onur Mutlu},
      year={2021},
      eprint={2102.03667},
      archivePrefix={arXiv},
      abstract = {Motivation: Early detection and isolation of COVID-19 patients are essential for successful implementation of mitigation strategies and eventually curbing the disease spread. With a limited number of daily COVID- 19 tests performed in every country, simulating the COVID-19 spread along with the potential effect of each mitigation strategy currently remains one of the most effective ways in managing the healthcare system and guiding policy-makers. We introduce COVIDHunter, a flexible and accurate COVID-19 outbreak simulation model that evaluates the current mitigation measures that are applied to a region and provides suggestions on what strength the upcoming mitigation measure should be. The key idea of COVIDHunter is to quantify the spread of COVID-19 in a geographical region by simulating the average number of new infections caused by an infected person considering the effect of external factors, such as environmental conditions (e.g., climate, temperature, humidity) and mitigation measures. Results: Using Switzerland as a case study, COVIDHunter estimates that the policy-makers need to keep the current mitigation measures for at least 30 days to prevent demand from quickly exceeding existing hospital capacity. Relaxing the mitigation measures by 50\% for 30 days increases both the daily capacity need for hospital beds and daily number of deaths exponentially by an average of 23.8x, who may occupy ICU beds and ventilators for a period of time. Unlike existing models, the COVIDHunter model accurately monitors and predicts the daily number of cases, hospitalizations, and deaths due to COVID-19. Our model is flexible to configure and simple to modify for modeling different scenarios under different environmental conditions and mitigation measures. Availability: https://github.com/CMU-SAFARI/COVIDHunter},
      primaryClass={q-bio.PE}
}
```
