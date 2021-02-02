# COVIDHunter: An Accurate, Flexible, and Environment-Aware Open-Source COVID-19 Outbreak Simulation Model
a simulation model that evaluates the current mitigation measures (i.e., non-pharmaceutical intervention) that are applied to a region and provides insight into what strength the upcoming mitigation measure should be and for how long it should be applied, while considering the potential effect of environmental conditions. Our model accurately forecasts the numbers of infected and hospitalized patients, and deaths for a given day. Described by Alser et al. (preliminary version at ...).

## <a name="started"></a>Getting Started
```sh
git clone https://github.com/CMU-SAFARI/SneakySnake
cd SneakySnake && make

./main [DebugMode] [KmerSize] [ReadLength] [IterationNo] [ReadRefFile] [# of reads] [# of threads] [EditThreshold]
# Short sequences
./main 0 100 100 100 ../Datasets/ERR240727_1_E2_30000Pairs.txt 30000 10 10
# Long sequences
./main 0 20500 100000 20500 ../Datasets/LongSequences_100K_PBSIM_10Pairs.txt 10 40 20000
```

## Table of Contents
- [Getting Started](#started)
- [Key Idea](#idea)
- [Benefits of COVIDHunter](#results)
- [Using COVIDHunter](#usage)
- [Available parameters](#parameter)
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
SneakySnake is already implemented and designed to be used for CPUs, FPGAs, and GPUs. Integrating one of these versions of SneakySnake with existing read mappers or sequence aligners requires performing three key steps: 1) preparing the input data for SneakySnake, 2) overlapping the computation time of our hardware accelerator with the data transfer time or with the computation time of the to-be-accelerated read mapper/sequence aligner, and 3) interpreting the output result of our hardware accelerator. 
1. All three versions of SneakySnake require at least two inputs: a pair of genomic sequences and an edit distance threshold. Other input parameters are the values of t and y, where t is the width of the chip maze of each subproblem and y is the number of iterations performed to solve each subproblem. Sneaky-on-Chip and Snake-on-GPU use a 2-bit encoded representation of bases packed in uint32 words. This requirement is not unique to Sneaky-on-Chip and Snake-on-GPU. Minimap2 and most hardware accelerators use a similar representation and hence this step can be opted out from the complete pipeline. If this is not the case, we already provide the script to prepare such a compact representation in our implementation. For Snake-on-Chip, it is provided in lines 187 to 193 in
https://github.com/CMU-SAFARI/SneakySnake/blob/master/Snake-on-Chip/Snake-on-Chip_test.cpp and for Snake-on-GPU, it is provided in lines 650 to 710 in
https://github.com/CMU-SAFARI/SneakySnake/blob/master/Snake-on-GPU/Snake-on-GPU.cu. We also observe that widely adopting efficient formats such as UCSC’s .2bit (https://genome.ucsc.edu/goldenPath/help/twoBit.html) format (instead of FASTA and FASTQ) can maximize the benefits of using hardware accelerators and reducing the resources needed to process the genomic data.
2. The second step is left to the developer. If the developer is integrating, for example, Snake-on-Chip with an FPGA-based read mapper, then a single SneakySnake filtering unit of Snake-on-Chip (or more) can be directly integrated on the same FPGA chip, given that the FPGA resource usage of a single filtering unit is very insignificant (<1.5%). This can eliminate the need for overlapping the computation time with the data transfer time. The same thing applies when the developer integrates Snake-on-GPU with an GPU-based read mapper. The developer needs to evaluate whether utilizing the entire FPGA chip for only Snake-on-Chip (achieving more filtering) is more beneficial than combining Snake-on-Chip with an FPGA-based read mapper on the same FPGA chip.
3. For the third step, both Sneaky-on-Chip and Snake-on-GPU return back to the developer an array that contains the filtering result (whether a sequence pair is similar or dissimilar) that appear in the same order of their original sequence pairs (input data to the first step). An array element with a value of 1 indicates that the pair of sequences at the corresponding index of the input data are similar and hence a sequence alignment is necessary.

## <a name="parameter"></a>Available parameters
| General Variable      | Value (Switzerland) |  Description |
| --------------------- |:-------------------:| :------------|
||                        **General Sttings:**                             ||
| `START_MONTH`           | 1                   |  Start simulation on January (use normal 1-12 representation for month here)       |
| `NUM_DAYS`              | 730                 |  Maximum number of simulation days        |
| `FIRST_INFECTION_DAY`   | 45                  |  The day of first infection that is imported into population       |
| `MAX_VICTIMS`          | 25                  |  maximum number of folks one person can infect (minimum is always 0). Assumes a normal distribution      |
||                        **Virus Properties:**                             ||
| `POPULATION`            | 8654622             |   Population size to simulate (in this case Swiss population in 2020)       |
| `MIN_INCUBATION_DAYS`   | 1                   |   minimum number of days from being infected to being contagious       |
| `MAX_INCUBATION_DAYS`   | 5                   |   maximum number of days from being infected to being contagious       |
| `R0_INTRINSIC`          | 2.7                 |   The base reproduction number, R0    |
||                        **Travel Information:**                            ||
| `TRAVEL_SICK_RATE`      | 15                  |   percent chance a traveler returning from a trip abroad is contagious and undetected       |
| `TRAVELERS_PER_DAY`     | 100                 |   Number of travelers entering country from abroad every day as of first travel day      |
| `FIRST_TRAVEL_DAY`      | 45                  |   The day of first infection that is imported into population       |
| `LAST_TRAVEL_DAY`       | 9999                |   Point at which potentially infected travelers (some of whom are contagious) start entering country  
||                        **Environmental Chnage Information (CTC):**                             ||
| `TEMP_SCALING_FACTOR_CTC`   | 0.0367          |   Linear scaling of infectiousness per degree temperature drop. 0.0367 => 3.67% more infectious per degree of temperature drop      |
| `TEMP_SCALING_FLOOR_CTC`   | 1                 |   Limit temperature below which linear temperature scaling is no longer applied to the R0 value.    |
| `TEMP_SCALING_CEILING_CTC`   | 29                  |   Limit temperature above which linear temperature scaling is no longer applied to the R0 value.     |
| `TEMP_MONTHLY_HIGH`   | [4, 6, 11, 15, 19, 23, 25, 24, 20, 15, 9, 5]                  |   Monthly average of daytime temperature data (high) in degrees C.      |
||                        **Environmental Chnage Information (Harvard CRW):**                             ||
| `CRW_Harvard`   | [0.997142857, 0.992428571, 0.998857143, 1.002714286, 0.995571429, 0.990714286, 0.978571429, 0.964571429, 0.948428571, 0.923571429, 0.902571429, 0.902285714, 0.900428571, 0.865, 0.869285714, 0.869, 0.858142857, 0.847857143, 0.851, 0.857142857, 0.851, 0.843428571, 0.85, 0.856428571, 0.851428571, 0.845428571, 0.84, 0.841857143, 0.846857143, 0.848714286, 0.841, 0.833571429, 0.836285714, 0.849714286, 0.864428571, 0.874142857, 0.890714286, 0.902428571, 0.906285714, 0.922714286, 0.945142857, 0.960285714, 0.959285714, 0.984285714, 1.018142857, 1.034285714, 1.017714286, 1.026428571, 1.037142857]                  |   CRW value extracted from https://projects.iq.harvard.edu/covid19/global      |
| `CRW_Harvard_TRANSITIONS`   | [3, 10, 17, 24, 31, 38, 44, 51, 58, 66, 73, 80, 87, 116, 123, 130, 137, 144, 151, 158, 165, 172, 179, 186, 193, 200, 207, 214, 221, 228, 235, 242, 249, 256, 263, 270, 277, 284, 291, 298, 305, 312, 319, 326, 333, 340, 347, 354, 361]                  |    Day transition of CRW value, extracted from: https://projects.iq.harvard.edu/covid19/global     |
||                        **Mitigation Measures:**                             ||
| `M`   | [0, 0.45, 0.7,  0.7, 0.65, 0.63, 0.5, 0.35, 0.6, 0.7,  0.7, 0.7, 0.73,  0.35, 0.73, 0.73]                  |   The strength of each mitigation measure, this is an example for fitting the curve of observed cases with a certinty rate of 100% with CTC environmental approach      |
| `TRANSITIONS`   | [1,   58,  77,  118,  132,  151, 174,  245, 284, 303,  320, 330,  356,  387, 420,  450, 9999]                  |   Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999      |


##  <a name="contact"></a>Getting help
If you have any suggestion for improvement, please contact alserm at ethz dot ch
If you encounter bugs or have further questions or requests, you can raise an issue at the [issue page][issue].

## <a name="cite"></a>Citing COVIDHunter

If you use COVIDHunter in your work, please cite:

> Soon

[issue]: https://github.com/CMU-SAFARI/COVIDHunter/issues
