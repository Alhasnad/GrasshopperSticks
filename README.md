## GrasshopperSticks
This repository contains data and code relating to the study:

### **High rises and optimal temperatures: Grasshopper microclimate selection** 

#### Authors:
Alhassani, N. & E.A.R. Welti

## rawdata file:

#### ***GhopSticks.xls*** :
* Contains project data including Metadata (README tab), grasshopper presence/heights (GhopSticks tab; synthesized to presence only data in GhopSticksPresence tab), other insects noted on sticks (OtherInsects tab), stick temperatures from radar gun (Temps tab), tabs pertaining to microclimate sensors not used in this study due to a high degree of missing data (tabs: Microclimate Numbers, SensorTimes), and information about stick shading (Sensor Info tab)

#### ***temp_sticks.csv*** :
* CSV file containing information on stick parameters and temperatures; heights provided in cm & temperature provided in Celsius; DOY= Day of Year (Julian date); TOD= categorical Time of Day

#### ***GhopPresence_ResponsesDrivers.csv*** :
* CSV file with grasshopper presence data, matched with stick parameters

## outputs file:

#### ***Temp_stickLevel.csv*** :
* CSV file containing stick temperatures and parameters synthesized at the per stick level (e.g. providing mean stick temperatures rather than temperatures at every 10 cm point up stick heights); temperature provided in Celsius;SE= Standard Error; SD = Standard Deviation;  DOY= Day of Year (Julian date)


## R file:

#### ***TempModels.R*** :
* R script containing code for models examining drivers of stick temperature at a given point and models of whole-stick temperature variation

#### ***GhopModel_Plot.R*** :
* R script containing code for models examining drivers of grasshopper perch height and to create interaction plot of stick mean temperature and temperature variation (temperature Standard Deviation) on grasshopper perch heights

## plots file:

#### ***Temp_interactionPlot.tiff*** :
*main results figure showing effect of interaction between stick mean temperature and temperature variation (TempSD= Temperature Standard Deviation) on grasshopper perch heights