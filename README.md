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
Read_Data(Dir,Data)# To read the dataset
```
* Arguments\
    Dir is the directory with the STEPS data in ".mdb" ACCESS format. for example: "C:\\Users\\WHOData"\
    Data is the name of the dataset. for example: "ARM.STEPS.mdb"
* Outputs\
    Output is an object of class "data.frame"
* Examples\
    dt= Read_Data (Dir= "C:\\Users\\WHOData",Data= "ARM.STEPS.mdb")\
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
    Data is the output object of Read_Data function\
    id is an argument of function svydesign\
    weights is an argument of function svydesign\
    strata is an argument of function svydesign
* Outputs\
    Output is an object of class "survey.design2" and "survey.design" 
* Examples\
     data= WHOPH_Data (Data= dt,id= psu,weights= wstep1,strata= stratum)\
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


```
## Examples for Mean
As_svy_mean ( ~Meet, ~age4y,Design= data)
        Category          Meet1) doesn't meet recs         95%CI
1       (18,29]                   0.0991             0.0748-0.1233
2       (29,44]                   0.1143             0.0954-0.1332
3       (44,59]                   0.1233             0.1066-0.1401
4       (59,69]                   0.2341             0.2035-0.2647
```

            
```
As_svy_mean ( ~Meet, ~age4y+sex,Design= data) 
        Category       Meet1) doesn't meet recs         95%CI
1   (18,29].Men             0.0800                  0.0498-0.1102
2   (29,44].Men             0.1051                  0.0769-0.1333
3   (44,59].Men             0.1315                  0.1058-0.1573
4   (59,69].Men             0.2714                  0.2177-0.325
5   (18,29].Women           0.1190                  0.081-0.1569
6   (29,44].Women           0.1232                  0.0981-0.1484
7   (44,59].Women           0.1162                  0.0943-0.1381
8   (59,69].Women           0.2084                  0.1727-0.2441

```
            
```
As_svy_mean ( ~Meet, ~age4y+UrbanRural+sex,Design= data)
              Category          Meet1) doesn't meet recs            95%CI
1       (18,29].rural.Men               0.0761                  0.0342-0.118
2       (29,44].rural.Men               0.0903                  0.0526-0.128
3       (44,59].rural.Men               0.1189                  0.087-0.1508
4       (59,69].rural.Men               0.2054                  0.1404-0.2705
5       (18,29].urban.Men               0.0836                  0.0403-0.1268
6       (29,44].urban.Men               0.1159                  0.0758-0.156
7       (44,59].urban.Men               0.1456                  0.1045-0.1867
8       (59,69].urban.Men               0.3270                  0.2472-0.4068
9       (18,29].rural.Women             0.1369                  0.0763-0.1975
10      (29,44].rural.Women             0.1114                  0.0742-0.1487
11      (44,59].rural.Women             0.1119                  0.0829-0.1409
12      (59,69].rural.Women             0.2350                  0.1807-0.2893
13      (18,29].urban.Women             0.1020                  0.0559-0.1481
14      (29,44].urban.Women             0.1312                  0.0975-0.1649
15      (44,59].urban.Women             0.1201                  0.0878-0.1524
16      (59,69].urban.Women             0.1922                  0.1452-0.2393

```
            
```
As_svy_mean ( ~Meet,Design= data) # data is the output of WHOPH_Data function
                  Category                  Meet1) doesn't meet recs         95%CI
1       Meet1) doesn't meet recs                   0.1315               0.1208-0.1422
```

```
## Examples for Median
As_svy_mean( ~Ptotalday, ~age4y,Design= data,Median= TRUE)
            Category        Ptotalday           25%le-75%le
1           (18,29]         145.7143            124.2857-180
2           (29,44]         182.8571            158.5714-214.2857
3           (44,59]         180.0000            171.4286-202.8571
4           (59,69]         60.0000             60-80

```
            
```
As_svy_mean( ~Ptotalday, ~age4y+sex,Design= data,Median= TRUE)
                Category         Ptotalday         25%le-75%le
1           (18,29].Men          211.4286        171.4286-244.2857
2           (29,44].Men          257.1429        231.4286-287.1429
3           (44,59].Men          240.0000        214.2857-265.7143
4           (59,69].Men          60.0000             60-90
5           (18,29].Women        120.0000        111.4286-150
6           (29,44].Women        120.0000           120-150
7           (44,59].Women        128.5714           120-160
8           (59,69].Women        60.0000             60-80
```
            
```
As_svy_mean( ~Ptotalday, ~age4y+UrbanRural+sex,Design= data,Median= TRUE)
              Category              Ptotalday          25%le-75%le
1          (18,29].rural.Men        261.4286            218.5714-300
2          (29,44].rural.Men        301.4286            274.2857-351.4286
3          (44,59].rural.Men        278.5714            244.2857-308.5714
4          (59,69].rural.Men        68.5714             60-120
5          (18,29].urban.Men        145.7143            120-214.2857
6          (29,44].urban.Men        222.8571            197.1429-257.1429
7          (44,59].urban.Men        214.2857            180-257.1429
8          (59,69].urban.Men        51.4286             40-80
9          (18,29].rural.Women      120.0000            85.7143-180
10         (29,44].rural.Women      180.0000            139.2857-240
11         (44,59].rural.Women      186.4286            180-222.8571
12         (59,69].rural.Women      60.0000             60-96.4286
13         (18,29].urban.Women      107.1429            80-128.5714
14         (29,44].urban.Women      85.7143             68.5714-115.7143
15         (44,59].urban.Women      107.1429            90-120
16         (59,69].urban.Women      60.0000             60-77.1429

```
            
```
As_svy_mean( ~Ptotalday,Design= data,Median= TRUE)
            Category        Ptotalday       25%le-75%le
1           Ptotalday       137.1429        128-150
```
        

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
* Examples
```
PtotalCat_svy_mean( ~PtotalCat, ~age4y,Design= data)

            Category            PtotalCat1..Low.Level                       95%CI_Low             PtotalCat2..Moderate.level
1           (18,29]                0.1323                               0.1042-0.1603                     0.2566
2           (29,44]                0.1553                               0.1337-0.177                      0.2665
3           (44,59]                0.1482                               0.1302-0.1663                     0.2566
4           (59,69]                0.2842                               0.2517-0.3167                     0.3876
 
        95%CI_Moderate          PtotalCat3..High.level                      95%CI_High
1       0.2198-0.2935                 0.6111                             0.5697-0.6526
2       0.2394-0.2937                 0.5781                             0.548-0.6082
3       0.2338-0.2794                 0.5951                             0.5697-0.6206
4       0.3533-0.4218                 0.3282                             0.2951-0.3614
```
```
PtotalCat_svy_mean( ~PtotalCat, ~UrbanRural,Design= data)

```
```
PtotalCat_svy_mean( ~PtotalCat ,~sex,Design= data)

```
```
PtotalCat_svy_mean( ~PtotalCat, ~age4y+sex,Design= data)

```
```
PtotalCat_svy_mean( ~PtotalCat, ~UrbanRural+sex,Design= data)

```
```
PtotalCat_svy_mean( ~PtotalCat, ~age4y+UrbanRural+sex,Design= data)

```
```
PtotalCat_svy_mean( ~PtotalCat,Design= data)

```
            
## Useful Links
[WHO European Office for the Prevention and Control of NCDs (NCD Office)](https://www.euro.who.int/en/health-topics/noncommunicable-diseases/pages/who-european-office-for-the-prevention-and-control-of-noncommunicable-diseases-ncd-office)\
[WHO STEPS Program](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/steps)\
[WHO Physical Activity Surveillance](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/physical-activity-surveillance)

