# COVIDHunter 🦠:construction:: An Accurate, Flexible, and Environment-Aware Open-Source COVID-19 Outbreak Simulation Model
A COVID-19 outbreak simulation model that evaluates the current mitigation measures (i.e., non-pharmaceutical intervention) that are applied to a region and provides insight into what strength the upcoming mitigation measure should be and for how long it should be applied, while considering the potential effect of environmental conditions. Our model accurately forecasts the numbers of infected and hospitalized patients, and deaths for a given day. Described by Alser et al. (preliminary version at ...).


## <a name="started"></a>Getting Started
```
    Install Xcode
    Add New Swift Project
    Use COVIDHunter/src/COVIDHunter.swift
    Run the project
    Change the default settings as needed
```

## Table of Contents
- [Getting Started](#started)
- [Key Idea](#idea)
- [Benefits of COVIDHunter](#results)
- [Using COVIDHunter](#usage)
- [Available parameters](#parameter)
- [An Example of COVIDHunter Simulation Output](#output)
- [Getting help](#contact)
- [Citing SneakySnake](#cite)

##  <a name="idea"></a>The key idea 
The key idea of COVIDHunter is to quantify the spread of COVID-19 in a geographical region by calculating the daily reproduction number, R, of COVID-19 and scaling the reproduction number based on changes in both mitigation measures and environmental conditions. The R number describes how a pathogen spreads in a particular population by quantifying the average number of new infections caused by each infected person at a given point in time. The R number changes during the course of the pandemic due to the change in the ability of a pathogen to establish an infection during a season and mitigation measures that lead to the scarcity of susceptible individuals.

##  <a name="results"></a>Benefits of COVIDHunter 
To our knowledge, there is currently no model capable of accurately monitoring the current epidemiological situation and predicting future scenarios while considering a reasonably low number of parameters and accounting for the effects of environmental conditions. In this work, we develop such a COVID-19 outbreak simulation model, COVIDHunter.
COVIDHunter accurately forecasts for a given day 1) the reproduction number, 2) the number of infected people, 3) the number of hospitalized people, 4) the number of deaths, and 5) number of individuals at each stage of the COVID-19 infection.
COVIDHunter evaluates the effect of different current and future mitigation measures on the five numbers forecasted by COVIDHunter.
We release the source code of the COVIDHunter implementation and show how to flexibly configure our model for any scenario and easily extend it for different measures and conditions than we account for.

##  <a name="usage"></a>Using COVIDHunter
- Install Xcode
- Add New Swift Project
- Use COVIDHunter/src/COVIDHunter.swift
- Run the project
- Change the default settings as needed, [Available parameters](#parameter)
    
    
## <a name="parameter"></a>Available parameters
| General Variable      | Value (Switzerland) |  Description |
| --------------------- |:-------------------:| :------------|
||                        **General Sttings:**                             ||
| `START_MONTH`           | 1                   |  Start simulation on January (use normal 1-12 representation for month here)       |
| `NUM_DAYS`              | 730                 |  Maximum number of simulation days        |
| `FIRST_INFECTION_DAY`   | 45                  |  The day of first infection that is imported into population       |
| `MAX_VICTIMS`          | 25                  |  maximum number of folks one person can infect (minimum is always 0). Assumes a normal distribution      |
||                        **Virus Properties:**                             ||
| `POPULATION` :wrench:           | 8654622             |   Population size to simulate (in this case Swiss population in 2020)       |
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
||                        **Environmental Chnage Information (Harvard CRW):**                             ||
| `CRW_Harvard` :wrench:  | [0.997142857, 0.992428571, 0.998857143, 1.002714286, 0.995571429, 0.990714286, 0.978571429, 0.964571429, 0.948428571, 0.923571429, 0.902571429, 0.902285714, 0.900428571, 0.865, 0.869285714, 0.869, 0.858142857, 0.847857143, 0.851, 0.857142857, 0.851, 0.843428571, 0.85, 0.856428571, 0.851428571, 0.845428571, 0.84, 0.841857143, 0.846857143, 0.848714286, 0.841, 0.833571429, 0.836285714, 0.849714286, 0.864428571, 0.874142857, 0.890714286, 0.902428571, 0.906285714, 0.922714286, 0.945142857, 0.960285714, 0.959285714, 0.984285714, 1.018142857, 1.034285714, 1.017714286, 1.026428571, 1.037142857]                  |   CRW value extracted from https://projects.iq.harvard.edu/covid19/global      |
| `CRW_Harvard_TRANSITIONS` :wrench:  | [3, 10, 17, 24, 31, 38, 44, 51, 58, 66, 73, 80, 87, 116, 123, 130, 137, 144, 151, 158, 165, 172, 179, 186, 193, 200, 207, 214, 221, 228, 235, 242, 249, 256, 263, 270, 277, 284, 291, 298, 305, 312, 319, 326, 333, 340, 347, 354, 361]                  |    Day transition of CRW value, extracted from: https://projects.iq.harvard.edu/covid19/global     |
||                        **Mitigation Measures:**                             ||
| `M` :wrench:  | [0, 0.45, 0.7,  0.7, 0.65, 0.63, 0.5, 0.35, 0.6, 0.7,  0.7, 0.7, 0.73,  0.35, 0.73, 0.73]                  |   The strength of each mitigation measure, this is an example for fitting the curve of observed cases with a certinty rate of 100% with CTC environmental approach      |
| `TRANSITIONS`  :wrench: | [1,   58,  77,  118,  132,  151, 174,  245, 284, 303,  320, 330,  356,  387, 420,  450, 9999]                  |   Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999      |

:wrench: Indicates that these parameters should be changed based on the subject country. Other parameters can be used with their default value.

##  <a name="output">An Example of COVIDHunter Simulation Output</a>
If you have any suggestion for improvement, please contact alserm at ethz dot ch
If you encounter bugs or have further questions or requests, you can raise an issue at the [issue page][issue].

<table class="tableizer-table">
<thead><tr class="tableizer-firstrow"><th>Day</th><th> Uninfected</th><th> Daily Cases</th><th> Daily Hospitalizations</th><th> Daily Deaths</th><th> Active Cases</th><th> Contagious</th><th> Immune</th><th> Travelers</th><th> R0</th><th> Ce(t)</th><th> M(t)</th><th> R0*(1-M(t))</th><th> R0*Ce(t)</th><th> R(t)=R0*Ce(t)*(1-M(t))</th><th> Observed R(t)</th></tr></thead><tbody>
 <tr><td>0</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>1</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>2</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>3</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>4</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>5</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>6</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>7</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>8</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>9</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>10</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>11</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>12</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>13</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>14</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>15</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>16</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>17</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>18</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>19</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>20</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>21</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>22</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>23</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>24</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>25</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>26</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>27</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>28</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>29</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.404</td><td>0</td><td>2.7</td><td>3.79</td><td>0</td><td>0</td></tr>
 <tr><td>30</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>31</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>32</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>33</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>34</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>35</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>36</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>37</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>38</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>39</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>40</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>41</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>42</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>43</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>44</td><td>8654621</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>0</td><td>0</td></tr>
 <tr><td>45</td><td>8654606</td><td>15</td><td>0.417</td><td>0.261</td><td>1</td><td>0</td><td>0</td><td>15</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>0</td></tr>
 <tr><td>46</td><td>8654594</td><td>12</td><td>0.334</td><td>0.209</td><td>16</td><td>0</td><td>0</td><td>27</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>0</td></tr>
 <tr><td>47</td><td>8654581</td><td>13</td><td>0.361</td><td>0.226</td><td>28</td><td>0</td><td>0</td><td>40</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>0</td></tr>
 <tr><td>48</td><td>8654561</td><td>20</td><td>0.556</td><td>0.348</td><td>39</td><td>2</td><td>0</td><td>60</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>0</td></tr>
 <tr><td>49</td><td>8654520</td><td>41</td><td>1.14</td><td>0.713</td><td>50</td><td>9</td><td>2</td><td>77</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>0</td></tr>
 <tr><td>50</td><td>8654468</td><td>52</td><td>1.446</td><td>0.904</td><td>78</td><td>13</td><td>11</td><td>94</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>30</td></tr>
 <tr><td>51</td><td>8654377</td><td>91</td><td>2.53</td><td>1.582</td><td>108</td><td>22</td><td>24</td><td>111</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>9.182</td></tr>
 <tr><td>52</td><td>8654278</td><td>99</td><td>2.752</td><td>1.722</td><td>174</td><td>25</td><td>78</td><td>132</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>6.375</td></tr>
 <tr><td>53</td><td>8654147</td><td>131</td><td>3.642</td><td>2.278</td><td>241</td><td>32</td><td>90</td><td>149</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>4.978</td></tr>
 <tr><td>54</td><td>8653935</td><td>212</td><td>5.894</td><td>3.687</td><td>315</td><td>57</td><td>115</td><td>158</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>4.451</td></tr>
 <tr><td>55</td><td>8653635</td><td>300</td><td>8.34</td><td>5.217</td><td>446</td><td>81</td><td>206</td><td>176</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>4.214</td></tr>
 <tr><td>56</td><td>8653231</td><td>404</td><td>11.231</td><td>7.026</td><td>635</td><td>111</td><td>246</td><td>187</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>3.962</td></tr>
 <tr><td>57</td><td>8652702</td><td>529</td><td>14.706</td><td>9.199</td><td>892</td><td>147</td><td>483</td><td>199</td><td>2.7</td><td>1.33</td><td>0</td><td>2.7</td><td>3.592</td><td>3.592</td><td>3.848</td></tr>
 <tr><td>58</td><td>8652287</td><td>415</td><td>11.537</td><td>7.217</td><td>1210</td><td>211</td><td>600</td><td>212</td><td>2.7</td><td>1.33</td><td>0.45</td><td>1.485</td><td>3.592</td><td>1.975</td><td>3.771</td></tr>
 <tr><td>59</td><td>8651670</td><td>617</td><td>17.153</td><td>10.73</td><td>1320</td><td>305</td><td>780</td><td>229</td><td>2.7</td><td>1.33</td><td>0.45</td><td>1.485</td><td>3.592</td><td>1.975</td><td>3.698</td></tr>
 <tr><td>60</td><td>8650954</td><td>716</td><td>19.905</td><td>12.451</td><td>1523</td><td>414</td><td>1289</td><td>250</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>3.116</td></tr>
 <tr><td>61</td><td>8650137</td><td>817</td><td>22.713</td><td>14.208</td><td>1761</td><td>478</td><td>1471</td><td>259</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>2.716</td></tr>
 <tr><td>62</td><td>8649310</td><td>827</td><td>22.991</td><td>14.382</td><td>2101</td><td>477</td><td>2222</td><td>277</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>2.349</td></tr>
 <tr><td>63</td><td>8648322</td><td>988</td><td>27.466</td><td>17.181</td><td>2351</td><td>577</td><td>2810</td><td>290</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>2.1</td></tr>
 <tr><td>64</td><td>8647059</td><td>1263</td><td>35.111</td><td>21.964</td><td>2601</td><td>738</td><td>3431</td><td>306</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.93</td></tr>
 <tr><td>65</td><td>8645671</td><td>1388</td><td>38.586</td><td>24.137</td><td>3052</td><td>812</td><td>4250</td><td>315</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.779</td></tr>
 <tr><td>66</td><td>8644251</td><td>1420</td><td>39.476</td><td>24.694</td><td>3608</td><td>832</td><td>5050</td><td>326</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.749</td></tr>
 <tr><td>67</td><td>8642485</td><td>1766</td><td>49.095</td><td>30.711</td><td>3994</td><td>1034</td><td>6000</td><td>341</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.716</td></tr>
 <tr><td>68</td><td>8640382</td><td>2103</td><td>58.463</td><td>36.571</td><td>4521</td><td>1239</td><td>7183</td><td>351</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.713</td></tr>
 <tr><td>69</td><td>8638151</td><td>2231</td><td>62.022</td><td>38.797</td><td>5320</td><td>1304</td><td>8877</td><td>369</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.712</td></tr>
 <tr><td>70</td><td>8635502</td><td>2649</td><td>73.642</td><td>46.066</td><td>5996</td><td>1555</td><td>9484</td><td>387</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.706</td></tr>
 <tr><td>71</td><td>8632558</td><td>2944</td><td>81.843</td><td>51.196</td><td>6921</td><td>1724</td><td>11777</td><td>404</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.707</td></tr>
 <tr><td>72</td><td>8629025</td><td>3533</td><td>98.217</td><td>61.439</td><td>7790</td><td>2075</td><td>13539</td><td>428</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.706</td></tr>
 <tr><td>73</td><td>8625098</td><td>3927</td><td>109.171</td><td>68.291</td><td>9015</td><td>2308</td><td>15741</td><td>440</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.706</td></tr>
 <tr><td>74</td><td>8620597</td><td>4501</td><td>125.128</td><td>78.272</td><td>10294</td><td>2648</td><td>18490</td><td>455</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.705</td></tr>
 <tr><td>75</td><td>8615637</td><td>4960</td><td>137.888</td><td>86.254</td><td>11878</td><td>2917</td><td>21288</td><td>472</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.704</td></tr>
 <tr><td>76</td><td>8609616</td><td>6021</td><td>167.384</td><td>104.705</td><td>13282</td><td>3556</td><td>24257</td><td>488</td><td>2.7</td><td>1.147</td><td>0.45</td><td>1.485</td><td>3.096</td><td>1.703</td><td>1.704</td></tr>
 <tr><td>77</td><td>8605942</td><td>3674</td><td>102.137</td><td>63.891</td><td>15335</td><td>3968</td><td>28427</td><td>510</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>1.702</td></tr>
 <tr><td>78</td><td>8601829</td><td>4113</td><td>114.341</td><td>71.525</td><td>14568</td><td>4441</td><td>32550</td><td>524</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>1.7</td></tr>
 <tr><td>79</td><td>8597104</td><td>4725</td><td>131.355</td><td>82.168</td><td>13562</td><td>5119</td><td>37600</td><td>532</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>1.523</td></tr>
 <tr><td>80</td><td>8592271</td><td>4833</td><td>134.357</td><td>84.046</td><td>13069</td><td>5218</td><td>43381</td><td>548</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>1.371</td></tr>
 <tr><td>81</td><td>8588280</td><td>3991</td><td>110.95</td><td>69.403</td><td>13583</td><td>4319</td><td>48788</td><td>562</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>1.236</td></tr>
 <tr><td>82</td><td>8584415</td><td>3865</td><td>107.447</td><td>67.212</td><td>13397</td><td>4177</td><td>54068</td><td>576</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>1.123</td></tr>
 <tr><td>83</td><td>8580208</td><td>4207</td><td>116.955</td><td>73.16</td><td>12709</td><td>4553</td><td>58590</td><td>590</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>1.028</td></tr>
 <tr><td>84</td><td>8575876</td><td>4332</td><td>120.43</td><td>75.333</td><td>12214</td><td>4702</td><td>61674</td><td>602</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>0.925</td></tr>
 <tr><td>85</td><td>8572155</td><td>3721</td><td>103.444</td><td>64.708</td><td>12511</td><td>4035</td><td>65973</td><td>615</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>0.925</td></tr>
 <tr><td>86</td><td>8568466</td><td>3689</td><td>102.554</td><td>64.152</td><td>12217</td><td>4015</td><td>70778</td><td>629</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>0.924</td></tr>
 <tr><td>87</td><td>8564627</td><td>3839</td><td>106.724</td><td>66.76</td><td>11733</td><td>4173</td><td>75086</td><td>638</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>0.924</td></tr>
 <tr><td>88</td><td>8560810</td><td>3817</td><td>106.113</td><td>66.378</td><td>11421</td><td>4151</td><td>78433</td><td>654</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>0.923</td></tr>
 <tr><td>89</td><td>8557219</td><td>3591</td><td>99.83</td><td>62.447</td><td>11325</td><td>3913</td><td>82414</td><td>665</td><td>2.7</td><td>1.147</td><td>0.7</td><td>0.81</td><td>3.096</td><td>0.929</td><td>0.922</td></tr>
 <tr><td>90</td><td>8554257</td><td>2962</td><td>82.344</td><td>51.509</td><td>11224</td><td>3692</td><td>86767</td><td>680</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.921</td></tr>
 <tr><td>91</td><td>8551190</td><td>3067</td><td>85.263</td><td>53.335</td><td>10376</td><td>3810</td><td>90463</td><td>692</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.92</td></tr>
 <tr><td>92</td><td>8548182</td><td>3008</td><td>83.622</td><td>52.309</td><td>9688</td><td>3755</td><td>93758</td><td>699</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.902</td></tr>
 <tr><td>93</td><td>8545420</td><td>2762</td><td>76.784</td><td>48.031</td><td>9247</td><td>3449</td><td>97365</td><td>708</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.883</td></tr>
 <tr><td>94</td><td>8542894</td><td>2526</td><td>70.223</td><td>43.927</td><td>8859</td><td>3150</td><td>101072</td><td>719</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.863</td></tr>
 <tr><td>95</td><td>8540429</td><td>2465</td><td>68.527</td><td>42.866</td><td>8306</td><td>3079</td><td>104140</td><td>731</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.844</td></tr>
 <tr><td>96</td><td>8538077</td><td>2352</td><td>65.386</td><td>40.901</td><td>7826</td><td>2945</td><td>107102</td><td>747</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.823</td></tr>
 <tr><td>97</td><td>8535911</td><td>2166</td><td>60.215</td><td>37.667</td><td>7452</td><td>2726</td><td>109282</td><td>757</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.802</td></tr>
 <tr><td>98</td><td>8533775</td><td>2136</td><td>59.381</td><td>37.145</td><td>6956</td><td>2662</td><td>112109</td><td>776</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.801</td></tr>
 <tr><td>99</td><td>8531868</td><td>1907</td><td>53.015</td><td>33.163</td><td>6702</td><td>2390</td><td>114769</td><td>786</td><td>2.7</td><td>1</td><td>0.7</td><td>0.81</td><td>2.7</td><td>0.81</td><td>0.8</td></tr>
 <tr><td>COVIDHunter model completes after 100 days. STOP Reason = Completed requested number of days (disease is still active)</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
 <tr><td>total infected (all phases)=1.418% total immune (all phases)=1.230%</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
 <tr><td>Program ended with exit code: 0</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td></td></tr>
</tbody></table>


##  <a name="contact"></a>Getting help
If you have any suggestion for improvement, please contact alserm at ethz dot ch
If you encounter bugs or have further questions or requests, you can raise an issue at the [issue page][issue].

## <a name="cite"></a>Citing COVIDHunter

If you use COVIDHunter in your work, please cite:

> Soon

[issue]: https://github.com/CMU-SAFARI/COVIDHunter/issues
