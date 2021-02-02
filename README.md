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
- [Getting help](#contact)
- [Citing SneakySnake](#cite)

##  <a name="idea"></a>The key idea 
The key idea of COVIDHunter is to quantify the spread of COVID-19 in a geographical region by calculating the daily reproduction number, R, of COVID-19 and scaling the reproduction number based on changes in both mitigation measures and environmental conditions. The R number describes how a pathogen spreads in a particular population by quantifying the average number of new infections caused by each infected person at a given point in time. The R number changes during the course of the pandemic due to the change in the ability of a pathogen to establish an infection during a season and mitigation measures that lead to the scarcity of susceptible individuals.

##  <a name="results"></a>Benefits of COVIDHunter 
To our knowledge, there is currently no model capable of accurately monitoring the current epidemiological situation and predicting future scenarios while considering a reasonably low number of parameters and accounting for the effects of environmental conditions. In this work, we develop such a COVID-19 outbreak simulation model, COVIDHunter.
COVIDHunter accurately forecasts for a given day 1) the reproduction number, 2) the number of infected people, 3) the number of hospitalized people, 4) the number of deaths, and 5) number of individuals at each stage of the COVID-19 infection.
COVIDHunter evaluates the effect of different current and future mitigation measures on the five numbers forecasted by COVIDHunter.
We release the source code of the COVIDHunter implementation and show how to flexibly configure our model for any scenario and easily extend it for different measures and conditions than we account for.

##  <a name="usage"></a>Using COVIDHunter:
SneakySnake is already implemented and designed to be used for CPUs, FPGAs, and GPUs. Integrating one of these versions of SneakySnake with existing read mappers or sequence aligners requires performing three key steps: 1) preparing the input data for SneakySnake, 2) overlapping the computation time of our hardware accelerator with the data transfer time or with the computation time of the to-be-accelerated read mapper/sequence aligner, and 3) interpreting the output result of our hardware accelerator. 
1. All three versions of SneakySnake require at least two inputs: a pair of genomic sequences and an edit distance threshold. Other input parameters are the values of t and y, where t is the width of the chip maze of each subproblem and y is the number of iterations performed to solve each subproblem. Sneaky-on-Chip and Snake-on-GPU use a 2-bit encoded representation of bases packed in uint32 words. This requirement is not unique to Sneaky-on-Chip and Snake-on-GPU. Minimap2 and most hardware accelerators use a similar representation and hence this step can be opted out from the complete pipeline. If this is not the case, we already provide the script to prepare such a compact representation in our implementation. For Snake-on-Chip, it is provided in lines 187 to 193 in
https://github.com/CMU-SAFARI/SneakySnake/blob/master/Snake-on-Chip/Snake-on-Chip_test.cpp and for Snake-on-GPU, it is provided in lines 650 to 710 in
https://github.com/CMU-SAFARI/SneakySnake/blob/master/Snake-on-GPU/Snake-on-GPU.cu. We also observe that widely adopting efficient formats such as UCSC’s .2bit (https://genome.ucsc.edu/goldenPath/help/twoBit.html) format (instead of FASTA and FASTQ) can maximize the benefits of using hardware accelerators and reducing the resources needed to process the genomic data.
2. The second step is left to the developer. If the developer is integrating, for example, Snake-on-Chip with an FPGA-based read mapper, then a single SneakySnake filtering unit of Snake-on-Chip (or more) can be directly integrated on the same FPGA chip, given that the FPGA resource usage of a single filtering unit is very insignificant (<1.5%). This can eliminate the need for overlapping the computation time with the data transfer time. The same thing applies when the developer integrates Snake-on-GPU with an GPU-based read mapper. The developer needs to evaluate whether utilizing the entire FPGA chip for only Snake-on-Chip (achieving more filtering) is more beneficial than combining Snake-on-Chip with an FPGA-based read mapper on the same FPGA chip.
3. For the third step, both Sneaky-on-Chip and Snake-on-GPU return back to the developer an array that contains the filtering result (whether a sequence pair is similar or dissimilar) that appear in the same order of their original sequence pairs (input data to the first step). An array element with a value of 1 indicates that the pair of sequences at the corresponding index of the input data are similar and hence a sequence alignment is necessary.

##  <a name="contact"></a>Getting help
If you have any suggestion for improvement, please contact alserm at ethz dot ch
If you encounter bugs or have further questions or requests, you can raise an issue at the [issue page][issue].

## <a name="cite"></a>Citing COVIDHunter

If you use COVIDHunter in your work, please cite:

> Soon

[issue]: https://github.com/CMU-SAFARI/COVIDHunter/issues
