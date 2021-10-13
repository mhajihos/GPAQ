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
## Read_Data
```
Read_Data(Dir,Data)
```
* Arguments\
    Dir is the directory with the STEPS data in ".mdb" ACCESS format. for example: "C:\\Users\\WHOData"\
    Data is the names of the dataset. for example: "ARM.STEPS.mdb"
* Outputs\
    Output is an object of class "data.frame"
* Examples\
    dt= Read_Data (Dir= "C:\\Users\\WHOData",Data= "ARM.STEPS.mdb")
    names(dt)

``` 
 [1] "id"                              "i4"                             
 [3] "end"                             "i7"                             
 [5] "deviceid"                        "minage"                         
 [7] "subscriberid"                    "maxage"                         
 [9] "pid"                             "hh_size"                        
 [11] "pid_note"                        "hh_size_note"                   
 [13] "i1a"                             "i1b"                            
 [15] "i1other"                         "i3"                             
 [17] "i5"                              "c1"                             
 [19] "dobnote"                         "c3"                             
 [21] "c4"                              "c5"                             
 [23] "c7"                              "c8"                             
 [25] "note1"                           "smoked_tb_showcard"             
 [27] "t1"                              "t2"                             
 [29] "t3"                              "t4"                             
 [31] "t4type"                          "t5a"                            
 [33] "t5aw"                            "t5b"                            
 [35] "t5bw"                            "t5c"                            
 [37] "t5cw"                            "t5d"                            
 [39] "t5dw"                            "t5e"                            
 [41] "t5ew"                            "t5f"                            
 [43] "t5fw"                            "t5other"                        
 [45] "t6"                              "t7"                             
 [47] "t8"                              "t10"       
```

## WHOPH_Data
```
WHOPH_Data (Data,id,weights,strata) # To prepare the dataset
```
* Arguments\
    Data is the output object of Read_Data function
* Outputs\
    Output is an object of class "survey.design2" and "survey.design" 
* Examples
     data= WHOPH_Data (Data= dt,id= psu,weights= wstep1,strata= stratum)
     class (data)
```
[1] "survey.design2" "survey.design" 
```

## As_svy_mean
```
As_svy_mean (Outcome,Group=NULL,Design,Median=FALSE)# For mean and median of any combination of factors
```
* Arguments\
        Outcome is the outcome of interest. for example: Meet wich shows if the WHO recommendation for physical activity was met or not.\
        Group is the group of interest. The default is NULL for when only the outcome variable is in our interest. Group can be any combination of categorical variables. Examples for group can be: ~age4y, ~age4y+sex, ~age4y+UrbanRural+sex, etc.\
        Design is the output object of WHOPH_Data function.\
        Median is a logical argument. Default is FALSE when we are interested in the weighted average [and 95%CI] value and TRUE for weighted median [and 25%le-75%le] values.
* Outputs\
    Output is a matrix with number of rows equal to the combination number of categories for Group arguments and three columns. The first column indicate the group of interest, the second group is the average or median and the third column is the 95% confidence interval for the average or 25% and 75% percentiles for the median.
* Examples for mean\
            As_svy_mean ( ~Meet, ~age4y,Design= data) # data is the output of WHOPH_Data function\
            As_svy_mean ( ~Meet, ~age4y+sex,Design= data) # data is the output of WHOPH_Data function\
            As_svy_mean ( ~Meet, ~age4y+UrbanRural+sex,Design= data) # data is the output of WHOPH_Data function\
            As_svy_mean ( ~Meet,Design= data) # data is the output of WHOPH_Data function.
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
* Outputs\
    Output is a matrix with number of rows equal to the combination number of categories for Group arguments and seven columns. The first column indicate the group of interest, columns two to seven are the average and 95% confidence intervals for Low, Moderate, and High categories for total physical activity, respectively.
* Examples\
            PtotalCat_svy_mean( ~PtotalCat, ~age4y,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat, ~UrbanRural,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat ,~sex,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat, ~age4y+sex,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat, ~UrbanRural+sex,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat, ~age4y+UrbanRural+sex,Design= data)\
            PtotalCat_svy_mean( ~PtotalCat,Design= data).
            
## Useful Links
[WHO European Office for the Prevention and Control of NCDs (NCD Office)](https://www.euro.who.int/en/health-topics/noncommunicable-diseases/pages/who-european-office-for-the-prevention-and-control-of-noncommunicable-diseases-ncd-office)\
[WHO STEPS Program](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/steps)\
[WHO Physical Activity Surveillance](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/physical-activity-surveillance)

