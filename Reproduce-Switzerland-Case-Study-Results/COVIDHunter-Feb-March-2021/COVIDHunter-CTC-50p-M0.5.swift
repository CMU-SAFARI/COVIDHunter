
// *** Start of user settings (change these to run an experiment) ***
let START_MONTH = 1 // Start simulation on January 1st (use normal 1-12 representation for month here)
let NUM_DAYS = 730 // maximum number of days simulated (2 years)
let FIRST_INFECTION_DAY = 45 // Day first infection is imported into population.
let POPULATION = 8654622 // Population size to simulate (in this case Swiss population in 2020)
let MIN_INCUBATION_DAYS = 1 // minimum number of days from being infected to being contagious
let MAX_INCUBATION_DAYS = 5 // maximum number of days from being infected to being contagious
let MAX_VICTIMS = 25 // maximum number of folks one person can infect (minimum is always 0). Assumes a normal distribution
let TRAVEL_SICK_RATE = 15 // percent chance a traveler returning from a trip abroad is contagious and undetected
let TRAVELERS_PER_DAY = 100 // Number of travelers entering country from abroad every day as of first travel day
let FIRST_TRAVEL_DAY = 45 // Point at which potentially infected travelers (some of whom are contagious) start entering country
let LAST_TRAVEL_DAY = 9999 // Point at which borders are closed/all travelers placed in strict quarantine
// Intrinsic r value excluding immunity at 15 degree C for a given population -- average number of folks an infected person gives the virus to (but some may already be immune). This is a function of the infectiousnessof the virus given normal (unaware of virus) population behavior and 15 degree C temp.
let R0_INTRINSIC = 2.7 //https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1008031#pcbi.1008031.s001

let X = 0.02780 //the hospitalizations-to-cases ratio, for CRW-100% = 4.288% for CTC-100% = 2.780%
let Y = 0.01739 //the deaths-to-cases ratio, for CRW-100% = 2.730% for CTC-100% = 1.739%

// CTC's model: Temperature dependence parameters
let TEMP_SCALING_FACTOR_CTC = 0.0367 // Linear scaling of infectiousness per degree temperature drop. 0.05 => 5% more infectious per degree of temperature drop
let TEMP_SCALING_FLOOR_CTC = 1.0 // Limit temperature below which linear temperature scaling is no longer applied to the R0 value.
let TEMP_SCALING_CEILING_CTC = 29.0 // Limit temperature above which linear temperature scaling is no longer applied to the R0 value.

// Harvard CRW model
let CRW_Harvard = [0.997142857, 0.992428571, 0.998857143, 1.002714286, 0.995571429, 0.990714286, 0.978571429, 0.964571429, 0.948428571, 0.923571429, 0.902571429, 0.902285714, 0.900428571, 0.865, 0.869285714, 0.869, 0.858142857, 0.847857143, 0.851, 0.857142857, 0.851, 0.843428571, 0.85, 0.856428571, 0.851428571, 0.845428571, 0.84, 0.841857143, 0.846857143, 0.848714286, 0.841, 0.833571429, 0.836285714, 0.849714286, 0.864428571, 0.874142857, 0.890714286, 0.902428571, 0.906285714, 0.922714286, 0.945142857, 0.960285714, 0.959285714, 0.984285714, 1.018142857, 1.034285714, 1.017714286, 1.026428571, 1.037142857]
let CRW_Harvard_TRANSITIONS = [3, 10, 17, 24, 31, 38, 44, 51, 58, 66, 73, 80, 87, 116, 123, 130, 137, 144, 151, 158, 165, 172, 179, 186, 193, 200, 207, 214, 221, 228, 235, 242, 249, 256, 263, 270, 277, 284, 291, 298, 305, 312, 319, 326, 333, 340, 347, 354, 361]

// Average temperature data by month (high and low) in degrees C. At this point daily temperatures are used so only the high value is factored in
let TEMP_MONTHLY_HIGH = [4, 6, 11, 15, 19, 23, 25, 24, 20, 15, 9, 5]

// Mitigation factor, M changes with time and addresses to what extent the population takes mitigation measures to
// protect themselves from the virus. Mitigation measures include items like social distancing, handwashing,
// contract tracing, quarantine, and lockdowns. A Mitigation value of 0.0 implies no mitigation whatsoever while a
// mitigation value of 1.0 implies perfect isolation of all infected individuals so no further spread is possible.
// Note: the M value and corresponding initial day for the transition need to line up 1:1 as shown below.
//////////////////////////////////////////////////////////////////CTC Temperature model

// This is to fit the curve with 50%
let M =           [0, 0.35, 0.66,  0.7, 0.65, 0.63, 0.5, 0.35, 0.5, 0.65, 0.69, 0.7, 0.7, 0.7, 0.5, 0.7]
let TRANSITIONS = [1,   58,   76,  100,  132,  151, 174,   235, 274,  303, 320,  330, 356, 387,  425, 456, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999


// *** End of user settings (change these to run an experiment) ***
