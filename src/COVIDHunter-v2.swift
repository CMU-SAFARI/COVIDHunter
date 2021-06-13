// COVIDHunter

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
let X = 0.02780 //the hospitalizations-to-cases ratio, for CRW-100% = 4.288% for CTC-100% = 2.780%
let Y = 0.01739 //the deaths-to-cases ratio, for CRW-100% = 2.730% for CTC-100% = 1.739%
let R0_INTRINSIC = 2.7 //https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1008031#pcbi.1008031.s001
let R0_INTRINSIC_VARIANT1 = 6.0
let ASYMPTOMATIC_PERCENTAGE = 0  // Percentage of infections that are asymptomatic relative to symptomatic.  Asymptomatic folks gain immunity but are less contagious

let IMPORTED_MUTATION_RATE = 0    // Percentage of imported cases that are of mutated variant 1 (as of FIRST_VARIANT_DAY).  Set to 0 to disable mutations
let FIRST_VARIANT_DAY = 345  // First day a traveller can bring in the mutated virus
let R0_ASYMPTOMATIC = 2.0
let R0_ASYMPTOMATIC_VARIANT1 = 3.0

// Vaccination parameters
let ENABLE_VACCINATIONS = true
let FIRST_VACCINATION_DAY = 380 // note:  the model assumes that you gain immunity immediately after vaccination.   Starting 2 weeks later accounts for the fact that in reality you need to wait 2 weeks for partial immunity.
let VACCINATION_RATE = 0.3     // Percentage of population vaccinated per day


// Brazil's model: Temperature dependence parameters
let TEMP_SCALING_FACTOR = 0.05 // Linear scaling of infectiousness per degree temperature drop. 0.05 => 5% more infectious per degree of temperature drop
let TEMP_SCALING_FLOOR = 10.0 // Limit temperature below which linear temperature scaling is no longer applied to the R0 value.
let TEMP_SCALING_CEILING = 26.0 // Limit temperature above which linear temperature scaling is no longer applied to the R0 value.
// CTC's model: Temperature dependence parameters
let TEMP_SCALING_FACTOR_CTC = 0.0367 // Linear scaling of infectiousness per degree temperature drop. 0.05 => 5% more infectious per degree of temperature drop
let TEMP_SCALING_FLOOR_CTC = 1.0 // Limit temperature below which linear temperature scaling is no longer applied to the R0 value.
let TEMP_SCALING_CEILING_CTC = 29.0 // Limit temperature above which linear temperature scaling is no longer applied to the R0 value.
// Harvard CRW model
let CRW_Harvard = [0.997142857, 0.992428571, 0.998857143, 1.002714286, 0.995571429, 0.990714286, 0.978571429, 0.964571429, 0.948428571, 0.923571429, 0.902571429, 0.902285714, 0.900428571, 0.865, 0.869285714, 0.869, 0.858142857, 0.847857143, 0.851, 0.857142857, 0.851, 0.843428571, 0.85, 0.856428571, 0.851428571, 0.845428571, 0.84, 0.841857143, 0.846857143, 0.848714286, 0.841, 0.833571429, 0.836285714, 0.849714286, 0.864428571, 0.874142857, 0.890714286, 0.902428571, 0.906285714, 0.922714286, 0.945142857, 0.960285714, 0.959285714, 0.984285714, 1.018142857, 1.034285714, 1.017714286, 1.026428571, 1.037142857]
let CRW_Harvard_TRANSITIONS = [3, 10, 17, 24, 31, 38, 44, 51, 58, 66, 73, 80, 87, 116, 123, 130, 137, 144, 151, 158, 165, 172, 179, 186, 193, 200, 207, 214, 221, 228, 235, 242, 249, 256, 263, 270, 277, 284, 291, 298, 305, 312, 319, 326, 333, 340, 347, 354, 361]

// Fei Wang's "High Temperature and High Humidity Reduce the Transmission of COVID-19"
//  Before lockdown in China and the U.S.:
//  1) one-degree Celsius increase in temperature reduces R value by about 0.023 in China and 0.020 in the U.S.
//  2) one percent relative humidity rise reduces R value by about 0.0078 in China and 0.0080 in the U.S.
//  After lockdown, For China, it's statistically significant (with p values lower than 0.05), and one-degree Celsius increase in temperature and one percent increase in relative humidity reduce R values by 0.0209 and 0.0054, respectively.  For the U.S. the estimated effects of the temperature and relative humidity on R values are still negative but no longer statistically significant (with p values 0.141 and 0.073, respectively).
let Wang_TEMP_SCALING_FACTOR = 0.02 // Linear scaling of infectiousness per degree temperature drop. 0.05 => 5% more infectious per degree of temperature drop
let Wang_Humidity_SCALING_FACTOR = 0.008 // Linear scaling of infectiousness per degree temperature drop. 0.05 => 5% more infectious per degree of temperature drop

// Average temperature data by month (high and low) in degrees C. At this point daily temperatures are used so only the high value is factored in
let TEMP_MONTHLY_HIGH = [4, 6, 11, 15, 19, 23, 25, 24, 20, 15, 9, 5]
let TEMP_November_HIGH = [13, 15, 12, 12, 8, 8, 8, 3, 6, 6, 9, 6, 5, 6, 4, 5, 2, 4, 3, 6, 7, 7, 8, 9, 9, 10, 9, 7, 4, 5]
let TEMP_MONTHLY_LOW = [-1, 0, 3,  6, 10, 13,  15, 15, 12, 8,  3, 0]
// Relative humidity https://www.worlddata.info/europe/switzerland/climate.php
let Humidity_MONTHLY_HIGH = [80, 77, 71, 69, 71, 70, 68, 72, 76, 80, 80, 80]

// Mitigation factor, M changes with time and addresses to what extent the population takes mitigation measures to
// protect themselves from the virus. Mitigation measures include items like social distancing, handwashing,
// contract tracing, quarantine, and lockdowns. A Mitigation value of 0.0 implies no mitigation whatsoever while a
// mitigation value of 1.0 implies perfect isolation of all infected individuals so no further spread is possible.
// Note: the M value and corresponding initial day for the transition need to line up 1:1 as shown below.
//////////////////////////////////////////////////////////////////Brazil Temperature model
// This is to fit the curve with 100%
//let M =           [0, 0.2233, 0.329, 0.384, 0.4, 0.4444, 0.7315, 0.6944, 0.6574, 0.6296, 0.5, 0.4815, 0.3704, 0.412, 0.406, 0.438, 0.5019, 0.55, 0.7, 0.75,    0, 0.75]
//let TRANSITIONS = [1,     56,     58,   59,   63,     73,    77,    118,    132,    151, 158,    160,    174,    185,   245,   284,   293,   294, 303,  330,   355,  370, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999
// This is to fit the curve with 10%, better fitting
//let M =           [0, 0.19, 0.19, 0.22, 0.25, 0.3444, 0.5515, 0.7, 0.7044, 0.5074, 0.50296, 0.5, 0.04815, 0.0504, 0.112, 0.2,0.338, 0.35, 0.32, 0.585, 0.6,    0, 0.6]
//let TRANSITIONS = [1,  56,  58,   59,   63,     73,    77,    90,    118,    132,    151, 158,    160,    174,     185, 210,  230,   264,  280,    303, 330,  355, 370, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999
//////////////////////////////////////////////////////////////////CTC Temperature model
// This is to fit the curve with 100%
let M =           [0, 0.45, 0.7,  0.7, 0.65, 0.63, 0.5, 0.355, 0.6, 0.7, 0.7, 0.71, 0.73, 0.73, 0.6, 0.35, 0.6]
let TRANSITIONS = [1,   58,  77,  118,  132,  151, 174,   245, 284, 303, 320,  330,  356,  387, 425,  475,  505, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999

// This is to fit the curve with 50%
//let M =           [0, 0.35, 0.66,  0.7, 0.65, 0.63, 0.5, 0.35, 0.5, 0.65, 0.68, 0.69, 0.69, 0.35, 0.7, 0.7]
//let TRANSITIONS = [1,   58,   76,  100,  132,  151, 174,  235,  274,  303,  320,  330,  356, 387, 420, 450, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999

// This is to fit the curve with 50% without the effect of the Temperature (you need to remove Ct from the equation)
//let M =           [0, 0.13, 0.6,  0.7, 0.65, 0.63, 0.6, 0.6, 0.45, 0.57, 0.59, 0.58, 0.55, 0.13, 0.55, 0.55]
//let TRANSITIONS = [1,   58, 76,  100,  132,  151, 174,  235,  274,  303,  320,  330,  356, 387, 420, 450, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999


// This is to fit the curve with 10%, better fitting
//let M =           [0, 0.27, 0.585, 0.7, 0.4, 0.2, 0.55, 0.55, 0.44, 0.44, 0.42, 0.3, 0.2]
//let TRANSITIONS = [1,   63,    77,  90, 188, 235, 293,  303, 330,  356,  387, 420, 450,9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999

//////////////////////////////////////////////////////////////////Harvard CRW Temperature model (find the difference at each transition and multiply it as a percentage with the equation)
// This is to fit the curve with 100%
//let M =           [0, 0.45, 0.7,  0.7, 0.65, 0.63, 0.5, 0.36, 0.37, 0.6, 0.71,  0.71, 0.71, 0.73,  0.35, 0.73, 0.73]
//let TRANSITIONS = [1,   58,  77,  118,  132,  151, 174,  245, 260, 284, 303,  320, 330,  356,  387, 420,  450, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999
// This is to fit the curve with 50%
//let M =           [0, 0.35, 0.7,  0.71, 0.65, 0.63, 0.5, 0.35, 0.5, 0.68, 0.7, 0.71, 0.71, 0.35, 0.71, 0.71]
//let TRANSITIONS = [1,   58,   76,  100,  132,  151, 174,  235,  274,  303,  320,  330,  356, 387, 420, 450, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999

// This is to fit the curve with 10%
//let M =           [0, 0.27, 0.485, 0.7, 0.4, 0.2, 0.7, 0.5,  0.6, 0.58, 0.2]
//let TRANSITIONS = [1,   63,    77,  90, 188, 245,  293,  303,  330, 356, 387, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999
//////////////////////////////////////////////////////////////////Fei Wang's "High Temperature and High Humidity Reduce the Transmission of COVID-19"
// This is to fit the curve with 100%
//let M =           [0, 0.3, 0.45, 0.54, 0.7, 0.3, 0.37, 0.45, 0.57, 0.72, 0.8, 0.57]
//let TRANSITIONS = [1,   56,   63,  77,  90,  245, 284,   293, 303,  330,  355,  380, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999
// This is to fit the curve with 10%
//let M =           [0, 0.27, 0.4, 0.7, 0.4, 0.2, 0.3, 0.4, 0.4, 0.2, 0.4]
//let TRANSITIONS = [1,   63,  77,  90, 188, 245, 293, 303,  330, 355,  380, 9999] // Day from start of sim that we move to next pandemic 'phase'. Last entry should be 9999



// *** End of user settings ***

import Foundation
import GameplayKit

let nibFile = NSNib.Name("MyView")
var topLevelObjects : NSArray?

Bundle.main.loadNibNamed(nibFile, owner:nil, topLevelObjects: &topLevelObjects)

enum State {case HEALTHY; case INFECTED; case INFECTED_ASYMPTOMATIC; case ASYMPTOMATIC; case CONTAGIOUS; case IMMUNE; case VACCINATED}

class Person {
    var state = State.HEALTHY;            // healthy,  uninfected
    var day_infected = -1;    // unassigned as no infection
    var day_infectious = -1;  // unassigned as not yet infectious
    var variant = false;          // variant of virus with which person is infected
    var traveler = false;     // returning travellers are allowed to violate r value level
}
var people = [Person]()
var victims = [Int](repeating: 0, count: NUM_DAYS)
var infections = [Int](repeating: 0, count: NUM_DAYS)
var spreaders = [Int](repeating: 0, count: NUM_DAYS)

   // denominator for calculated actual and intrinsic R value
var total_infections = 0                                   // total infections across the pandemic
var total_infections_variant = 0
var total_travelers = 0
var total_vaccinated = 0


init_people(count: POPULATION)
people[0].state = State.INFECTED  // infect a person
people[0].day_infected = FIRST_INFECTION_DAY      // first day of simulation
people[0].day_infectious = FIRST_INFECTION_DAY+5  // start from day first person is infectious

var free_person_ptr = 1  // pointer to first healthy person in array of people (runtime optimization)
var sick_person_ptr = 0  // pointer to last still sick person in array of people (runtime optimization)
var done = false


var weekly_spreaders = 0
var weekly_victims = 0
var weekly_infections = 0

var vaccinations_per_day = Int(Double(POPULATION) * VACCINATION_RATE/100)
var vaccinations_done = false

print("Day, Uninfected, Daily Cases (Variant 1), Daily Cases (Variant 2), Daily Hospitalizations, Daily Deaths, Active Cases, Contagious, Immune, Total Vaccinated, asymptomatic Cases, Travelers, R0, Ce(t), M(t), R0*(1-M(t)), R0*Ce(t), R(t)=R0*Ce(t)*(1-M(t)), Observed R(t)")

var phase = 0 // current phase of pandemic
var CRWphase = 0
var VariationInCRW = 0.0
var CRWfactor = 0.0
var day = 0 // current day
var dayInYear=0

var month = START_MONTH-1 // convert month to a 0-11 representation for internal use

while (!done && day<NUM_DAYS) {
    // Check for a transition to a new phase of behavior
    if (day==TRANSITIONS[phase+1]) {
        phase+=1
    }
    // Check for a transition to a new CRW
    if (day%365 == 0) {
        dayInYear=0 // start new month (note approximates all months as having 30 days)
    } else {
        dayInYear+=1
    }
    if (dayInYear==CRW_Harvard_TRANSITIONS[CRWphase+1]) {
        if ((CRWphase+1) % (CRW_Harvard.count-1) == 0) {
            CRWphase = 0;
            VariationInCRW = CRW_Harvard[CRWphase] - CRW_Harvard[CRW_Harvard.count-1];
        } else {
            CRWphase+=1;
            VariationInCRW = CRW_Harvard[CRWphase] - CRW_Harvard[CRWphase-1];
        }
    }
    CRWfactor = 1+VariationInCRW
    //print("\(day), \(dayInYear), \(CRWphase), \(VariationInCRW), \(CRW_Harvard[CRWphase]), \(CRWfactor)")
    done = process_people(day: day, phase: phase, CRWfactor: CRWfactor)
    day+=1
    if (day%30 == 0) {
        month+=1 // start new month (note approximates all months as having 30 days)
        if (month%12 == 0) {
            month=0; // start new year
        }
    }
}

if (!done) {
    print("COVIDHunter completes after \(NUM_DAYS) days. STOP Reason = Completed requested number of days (disease is still active)")
} else {
    print("COVIDHunter completes after \(day) days. STOP Reason = No more active disease in population.")
}
let infected = String(format: "%2.3f", (Double(total_infections))/Double(POPULATION)*100.0)
let infected_variant = String(format: "%2.3f", (Double(total_infections_variant))/Double(POPULATION)*100.0)
let immune   = String(format: "%2.3f", Double(sick_person_ptr)/Double(POPULATION)*100.0)
let vaccinated = String(format: "%2.3f", Double(total_vaccinated)/Double(POPULATION)*100.0)
print("total infected_base=\(infected)% total_infected_variant=\(infected_variant) total immune=\(immune)%  total vaccinated=\(vaccinated)%")
// for i in 0..<phase {
//    let infected = String(format: "%2.3f", infections[i]/Double(POPULATION)*100.0)
//    print("phase=\(i) day_start=\(TRANSITIONS[i]) intrinsic_r=\(R0_INTRINSIC * M[phase]) %infected=\(infected)")
// }


// Given a contagious person (spreader) pick a random victim
// note:  victim cannot be same person as spreader so need to avoid that case
func pick_victim(spreader: Int) -> Int {
    var person = 0
    repeat {
        person = Int.random(in: 0..<POPULATION)
    } while person == spreader
    return person
}

// Given a contagious person (spreader),  pick the number of people that person tries to infect (note:  some may be immune).
// Once we have picked a number of victims for the day such that our intrinsic R0 including temperature and mitigation is reached we stop infecting.
// Subsequent infectious folks will not infect anyone (with the exception of returning infected travelers).
func pick_number_of_victims(traveler: Bool, day: Int, symptomatic: Bool, R0Mt: Double) -> Int {
                
    let random = GKRandomSource()
    let result = GKGaussianDistribution(randomSource: random, lowestValue: 0, highestValue : MAX_VICTIMS)

    if (symptomatic) {
        spreaders[day]+=1
        var new_symptomatic_victims = result.nextInt()
    
        if (traveler==false && Double(victims[day]+new_symptomatic_victims)/(Double(spreaders[day]+1)) > R0Mt) {
            new_symptomatic_victims = 0;   // our R0 value is currently too high so done infecting for the day (except for travelers)
        } else {
            victims[day]+=new_symptomatic_victims
        }
        return new_symptomatic_victims
    } else {
        var new_asymptomatic_victims = (result.nextInt() * ASYMPTOMATIC_PERCENTAGE)/100
        if (traveler==false && Double(victims[day]+new_asymptomatic_victims)/(Double(spreaders[day]+1)) > R0Mt) {
            new_asymptomatic_victims = 0;   // our R0 value is currently too high so done infecting for the day (except for travelers)
        }
        
        return new_asymptomatic_victims
    }
}

// Return the number of days of incubation (period from which person is infected until they are infectious).
func incubation_period() -> Int {
    let random = GKRandomSource()
    let result = GKGaussianDistribution(randomSource: random, lowestValue: MIN_INCUBATION_DAYS, highestValue : MAX_INCUBATION_DAYS)
    return result.nextInt()
}

// Compute temperature coefficient for this day (based on monthly average daytime hi temperature).  Clamp temperature if it exceeds min or max point beyond which further scaling occurs prior to computing Ct
// Note: use the monthly average high temperature as daytime temperatures (when most folks are out and about) are what first order matter.
func compute_temperature_scaling(month: Int) -> Double {
    var temp = Double(TEMP_MONTHLY_HIGH[month])
    temp = temp > TEMP_SCALING_CEILING ? TEMP_SCALING_CEILING : temp
    temp = temp < TEMP_SCALING_FLOOR ? TEMP_SCALING_FLOOR : temp
    var Ct = 1 + ((15 - temp)*TEMP_SCALING_FACTOR) // 10 < temp < 26
    Ct = Ct >= 0.0 ? Ct : 0.0 // negative temperature coefficient does not make sense.
    return Ct
}

func compute_temperature_scaling_CTC(month: Int, day: Int) -> Double {
    /*if ((day >= 305) && (day <= 334)) {
        var temp = Double(TEMP_November_HIGH[day-305])
        temp = temp > TEMP_SCALING_CEILING_CTC ? TEMP_SCALING_CEILING_CTC : temp
        temp = temp < TEMP_SCALING_FLOOR_CTC ? TEMP_SCALING_FLOOR_CTC : temp
        var Ct = 1 + ((15 - temp)*TEMP_SCALING_FACTOR_CTC) // 10 < temp < 26
        Ct = Ct >= 0.0 ? Ct : 0.0 // negative temperature coefficient does not make sense.
        return Ct
    } else {*/
        var temp = Double(TEMP_MONTHLY_HIGH[month])
        temp = temp > TEMP_SCALING_CEILING_CTC ? TEMP_SCALING_CEILING_CTC : temp
        temp = temp < TEMP_SCALING_FLOOR_CTC ? TEMP_SCALING_FLOOR_CTC : temp
        var Ct = 1 + ((15 - temp)*TEMP_SCALING_FACTOR_CTC) // 10 < temp < 26
        Ct = Ct >= 0.0 ? Ct : 0.0 // negative temperature coefficient does not make sense.
        return Ct
    //}
    
}

func compute_Wang_scaling_daily(month: Int, day: Int) -> Double {
    if ((day >= 305) && (day <= 334)) {
        let temp = Double(TEMP_November_HIGH[day-305])
        let hum = Double(Humidity_MONTHLY_HIGH[month])
        var Ct = 1 + ((15 - temp)*Wang_TEMP_SCALING_FACTOR) + ((70 - hum)*Wang_TEMP_SCALING_FACTOR)
        Ct = Ct >= 0.0 ? Ct : 0.0 // negative temperature coefficient does not make sense.
        //print("\(temp)")
        return Ct
    } else {
        let temp = Double(TEMP_MONTHLY_HIGH[month])
        let hum = Double(Humidity_MONTHLY_HIGH[month])
        var Ct = 1 + ((15 - temp)*Wang_TEMP_SCALING_FACTOR) + ((70 - hum)*Wang_TEMP_SCALING_FACTOR)
        Ct = Ct >= 0.0 ? Ct : 0.0 // negative temperature coefficient does not make sense.
        //print("\(temp)")
        return Ct
    }
    
}

func compute_Wang_scaling(month: Int) -> Double {
    let temp = Double(TEMP_MONTHLY_HIGH[month])
    let hum = Double(Humidity_MONTHLY_HIGH[month])
    var Ct = 1 + ((15 - temp)*Wang_TEMP_SCALING_FACTOR) + ((70 - hum)*Wang_TEMP_SCALING_FACTOR)
    Ct = Ct >= 0.0 ? Ct : 0.0 // negative temperature coefficient does not make sense.
    return Ct
}


// Iterate through the population and spread disease from contagious people (spreaders) to other folks (victims).  Not all victims become infected since
// some are immune (have already had the infection and their immune system prevents them from getting infectious again).
func process_people(day: Int, phase: Int, CRWfactor: Double) -> Bool {
    var infected_original = 0
    var infected_variant1 = 0
    var infected_asymptomatic = 0
    var contagious = 0
    var asymptomatic = 0
    var illegal = 0
    var immune = 0
    var newly_infected = [0, 0]
    var first_sick_person = POPULATION
    
    // Compute temperature scaling coefficient Ct
    //Brazil
    //let Ct = compute_temperature_scaling(month: month)
    //Wang
    //let Ct = compute_Wang_scaling(month: month)
    //let Ct = compute_Wang_scaling_daily(month: month, day: day)
    //CTC
    let Ct = compute_temperature_scaling_CTC(month: month, day: day)
    
    // Compute R0Mt which is R0 including both mitigation measures (1-M) and the temperature coefficient (Ct)
    //Brazil & Wang & CTC
    let R0Mt = (day >= FIRST_INFECTION_DAY) ? R0_INTRINSIC * (1.0-M[phase]) * Ct : 0.0    //print("\(M[phase])")
    //Harvard CRW
    //let R0Mt = (day >= FIRST_INFECTION_DAY) ? Double(R0_INTRINSIC) * (1.0-M[phase]) * CRWfactor : 0.0
    
    //print("\(R0Mt), \(CRW_Harvard[CRWphase]), \(Ct), \(CRWphase)")
    
    
    // Compute R0Mt which is R0 including both mitigation measures (1-M) and the temperature coefficient (Ct)
    
    let R0Mt_asymptomatic = (day >= FIRST_INFECTION_DAY) ? R0_ASYMPTOMATIC * (1.0-M[phase]) * Ct : 0.0
    let R0Mt_variant1 = (day >= FIRST_VARIANT_DAY) ? R0_INTRINSIC_VARIANT1 * (1.0-M[phase]) * Ct : 0.0
    let R0Mt_asymptomatic_variant1 = (day >= FIRST_VARIANT_DAY) ? R0_ASYMPTOMATIC_VARIANT1 * (1.0-M[phase]) * Ct : 0.0
    
    // compute weekly victims and spreaders based on last 7 days
    weekly_victims=0
    weekly_spreaders=0
    weekly_infections=0
    for i in day-7..<day-1 {
        if (i>=0) {
            weekly_victims += victims[i]
            weekly_spreaders += spreaders[i]
            weekly_infections += infections[i]
        }
    }
    
    // compute true R value based on the new infections and spreaders in the past week.  This value is for informative purposes only (does not impact sim)
    let Rt:Double = weekly_spreaders != 0 ? Double(weekly_infections)/Double(weekly_spreaders) : 0.0
    
    // iterate though all sick folks in the population and update their state
    for i in sick_person_ptr..<free_person_ptr {
        switch people[i].state {
        
        case State.INFECTED_ASYMPTOMATIC:
            if (i < first_sick_person) {
                first_sick_person = i
            }
            infected_asymptomatic+=1
            if (day >= people[i].day_infectious) {
                people[i].state = .ASYMPTOMATIC;  // person is infected but asymptomatic
            }
        case State.INFECTED:
            if (i < first_sick_person) {
                first_sick_person = i
            }
            if (people[i].variant==true) {
                infected_variant1+=1
            } else {
                infected_original+=1
            }
            if (day >= people[i].day_infectious) {
                people[i].state = .CONTAGIOUS;   // person is now infectious
            }
        case State.ASYMPTOMATIC:
            if (i < first_sick_person) {
                first_sick_person = i
            }
            asymptomatic+=1
            // determine number of people to spreaad the virus to
            let victim_count = pick_number_of_victims(traveler: people[i].traveler, day: day, symptomatic: false, R0Mt: people[i].variant ? R0Mt_asymptomatic_variant1 : R0Mt_asymptomatic)
            for _ in 0..<victim_count {
                let victim = pick_victim(spreader: i)
                if (people[victim].state == .HEALTHY) {
                    if (Int.random(in: 0..<100) < ASYMPTOMATIC_PERCENTAGE) {
                        newly_infected[people[i].variant==true ? 1 : 0] += infect_person(day: day, state: State.INFECTED_ASYMPTOMATIC, variant: people[i].variant)
                    } else {
                        newly_infected[people[i].variant==true ? 1 : 0] += infect_person(day: day, state: State.INFECTED, variant: people[i].variant)
                    }
                }
            }
            
            people[i].state = .IMMUNE    // this person is done being asymptomatic and is now immune
        case State.CONTAGIOUS:
            if (i < first_sick_person) {
                first_sick_person = i
            }
            contagious+=1
            // determine number of people to spreaad the virus to
            let victim_count = pick_number_of_victims(traveler: people[i].traveler,  day: day, symptomatic: true, R0Mt: people[i].variant ? R0Mt_variant1 : R0Mt)
            for _ in 0..<victim_count {
                let victim = pick_victim(spreader: i)
                if (people[victim].state == .HEALTHY) {
                    if (Int.random(in: 0..<100) < ASYMPTOMATIC_PERCENTAGE) {
                        newly_infected[people[i].variant==true ? 1 : 0] += infect_person(day: day, state: State.INFECTED_ASYMPTOMATIC, variant: people[i].variant)
                    } else {
                        newly_infected[people[i].variant==true ? 1 : 0] += infect_person(day: day, state: State.INFECTED, variant: people[i].variant)
                    }
                }
            }
 
            people[i].state = .IMMUNE   // this person is done infecting people and is now immune
        case State.IMMUNE:
            immune+=1
        case State.VACCINATED:
            break;
        default:
            if (i < first_sick_person) {
                 first_sick_person = i
             }
            illegal+=1
        }
    }
    
    // bump sick_person_ptr (runtime optimiztion to avoid scanning from start of array)
    sick_person_ptr = first_sick_person==POPULATION ? sick_person_ptr : first_sick_person
    
    // Handle travelers who randomly return to population (if r value is 0.0 then no travellers either => disease not present anywhere)
    if (day>=FIRST_TRAVEL_DAY && day <= LAST_TRAVEL_DAY) {
        for _ in 0..<TRAVELERS_PER_DAY {
            if (Int.random(in: 0..<100) < TRAVEL_SICK_RATE) {
                let person = pick_victim(spreader: 0)
                let virus_variant = day>=FIRST_VARIANT_DAY ? (Int.random(in: 0..<100) < IMPORTED_MUTATION_RATE) ? true : false : false
                if (people[person].state == .HEALTHY) {
                    newly_infected[virus_variant==true ? 1 : 0] += infect_person(day: day, state: .INFECTED, variant:virus_variant)  // Assumes travellers are always contagious
                    total_travelers+=1
                }
            }
        }
    }
    
    // handle vaccinations.   Once vaccinations start, vaccinated folks become immune
    if (ENABLE_VACCINATIONS==true && day>=FIRST_VACCINATION_DAY && !vaccinations_done) {
        var last_count = 0
      for _ in 0..<vaccinations_per_day  {
            var person = pick_victim(spreader:0)
            var count = 0
            while people[person].state == .VACCINATED && count < 20 {   // pick a new person if already vaccinated
                person = pick_victim(spreader:0)
                count+=1
            }
            if (count==10 && last_count==20) {
                vaccinations_done = true
            } else {
                if (people[person].state == .HEALTHY || people[person].state == .IMMUNE) {
                    people[person].state = .VACCINATED
                    total_vaccinated += 1
                }
            }
            last_count = count
        }
    }
    
    let hospitalizations_number = String(format: "%2.3f", X * Double(newly_infected[0]+newly_infected[1]))
    let deaths_number = String(format: "%2.3f", Y * Double(newly_infected[0]+newly_infected[1]))
    let intrinsic_r_string = String(format: "%2.3f", R0_INTRINSIC)
    let phase_string = String(format: "%2.3f", R0_INTRINSIC*(1.0-M[phase]))
    let phase_temp_r_string = String(format: "%2.3f", R0Mt)
    let temp_r_string = String(format: "%2.3", R0_INTRINSIC*Ct)
    let actual_r_string = String(format: "%2.3f", Rt)
    let M_string = String(format: "%2.3f", M[phase])
    let C_string = String(format: "%2.3f", Ct)
    
    print("\(day+1), \(POPULATION-free_person_ptr), \(newly_infected[0]), \(newly_infected[1]), \(hospitalizations_number), \(deaths_number), \(infected_original), \(contagious), \(sick_person_ptr+immune), \(total_vaccinated),  \(asymptomatic), \(total_travelers), \(intrinsic_r_string), \(C_string), \(M_string), \(phase_string), \(temp_r_string), \(phase_temp_r_string), \(actual_r_string)")
    
    //print("Day, Uninfected, new infections base, active infections, contagious, asymptomatic, immune, travelers, R0i (intrinsic R0), R0i*Ct (intrinsic including migitation), R0i*Ct (temperature adjusted R0), R0i*Ct*(1-M) (temp adjusted R0 including mitigation), Rt (observed R number), new infections variant, vaccations")
    //print("\(day), \(POPULATION-free_person_ptr), \(newly_infected[0]), \(infected_original), \(contagious), \(asymptomatic), \(sick_person_ptr+immune), \(total_travelers), \(intrinsic_r_string), \(phase_string), \(temp_r_string), \(phase_temp_r_string), \(actual_r_string), \(newly_infected[1]), \(total_vaccinated)")
        
    return contagious+infected_original+infected_variant1+asymptomatic==0 && TRAVEL_SICK_RATE==0
}

// Mark a new person as infected on a given day
func infect_person(day: Int,  state: State, variant: Bool) -> Int {
    // note:  use 'free person pointer' vs 'victim' as a runtime optimization.  This prevents having to scan entire population for sick people.
    people[free_person_ptr].state = state // infect the victim if the person is not already infected
    people[free_person_ptr].day_infected = day  // infection date is today
    people[free_person_ptr].day_infectious = day + incubation_period()
    people[free_person_ptr].variant = variant
    if (state == .INFECTED) {
        infections[day] += 1   //   count as an actual infection
        if (variant) {
            total_infections_variant += 1
        } else {
            total_infections += 1
        }
    }
    free_person_ptr+=1
    return 1
}

func init_people(count: Int) {
    for  _ in 0..<count {
        people.append(Person())
    }
}
