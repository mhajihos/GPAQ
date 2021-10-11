## WHOPH
## Overview
WHOPH packages is based on The Global Physical Activity Questionnaire which was developed by WHO for physical activity surveillance in countries. It collects information on physical activity participation in three settings (or domains) as well as sedentary behaviour, comprising 16 questions (P1-P16). The domains are:\
• Activity at work\
• Travel to and from places\
• Recreational activities\
WHOPH is working only on R 32bit and has 5 dependencies listed in the DESCRIPTION file : survey, RODBC, knitr, dplyr, stringr.

## Installation
```
# install.packages("devtools")
devtools::install_github("mhajihos/WHOPH")
require(WHOPH)
```

## WHOPH_Data
```
WHOPH_Data (Dir,Data,id,weights,strata) # To prepare the dataset
```
* Arguments\
    Dir is the directory with the STEPS data in ".mdb" ACCESS format. for example: "C:\\Users\\WHOData"\
    Data is the names of the dataset. for example: "ARM.STEPS.mdb"\
    id is an argument in "svydesign" package. for example: id="PSU"\
    weights is an argument in "svydesign" package. for example: weights="WStep1"\
    strata is an argument in "svydesign" package. for example: strata="Stratum"

* Examples\
     WHOPH_Data (Dir= "C:\\Users\\WHOData",Data= "ARM.STEPS.mdb",id= "PSU",weights= "WStep1",strata= "Stratum")

## As_svy_mean
```
As_svy_mean (Outcome,Group=NULL,Design,Median=FALSE)# For mean and median of any combination of factors
```
* Arguments\
        Outcome is the outcome of interest. for example: Meet wich shows if the WHO recommendation for physical activity was met or not.\
        Group is the group of interest. The default is NULL for when only the outcome variable is in our interest. Group can be any combination of categorical variables. Examples for group can be: ~age4y, ~age4y+sex, ~age4y+UrbanRural+sex, etc.\
        Design is the output object of WHOPH_Data function.\
        Median is a logical argument. Default is FALSE when we are interested in the weighted average [and 95%CI] value and TRUE for weighted median [and 25%le-75%le] values. 

* Examples for mean\
            As_svy_mean ( ~Meet, ~age4y,Design= data) # data is the output of WHOPH_Data function\
            As_svy_mean ( ~Meet, ~age4y+sex,Design= data) # data is the output of WHOPH_Data function\
            As_svy_mean ( ~Meet, ~age4y+UrbanRural+sex,Design= data) # data is the output of WHOPH_Data function\
            As_svy_mean ( ~Meet,Design= data) # data is the output of WHOPH_Data function.\
* Examples for Median\
            As_svy_mean( ~Ptotalday, ~age4y,Design= data,Median= TRUE)\
            As_svy_mean( ~Ptotalday, ~age4y+sex,Design= data,Median= TRUE)\
            As_svy_mean( ~Ptotalday, ~age4y+UrbanRural+sex,Design= data,Median= TRUE)\
            As_svy_mean( ~Ptotalday,Design= data,Median= TRUE).
        

## PtotalCat_svy_mean
```
PtotalCat_svy_mean (Outcome,Group=NULL,Design) # For mean of Total physical activity categories for any combination of factors
```
* Arguments\
        Outcome is the outcome of interest. PtotalCat is the outcome of interest with three levels "Low", "Moderate", and "High"\
        Group is the group of interest. The default is NULL for when only the outcome variable is in our interest. Group can be any combination of categorical variables. Examples for group can be: ~age4y, ~age4y+sex, ~age4y+UrbanRural+sex, etc.\
        Design is the output object of WHOPH_Data function.

* Examples\
            PtotalCat_svy_mean( ~PtotalCat, ~age4y,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat, ~UrbanRural,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat ,~sex,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat, ~age4y+sex,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat, ~UrbanRural+sex,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat, ~age4y+UrbanRural+sex,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat,Design= data).
            
## Useful Links
[WHO STEPS Program](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/steps)\
[WHO Physical Activity Surveillance](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/physical-activity-surveillance)

