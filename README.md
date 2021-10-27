## WHOPH
## Overview
WHOPH packages is based on The Global Physical Activity Questionnaire which was developed by WHO for physical activity surveillance in countries. It collects information on physical activity participation in three settings (or domains) as well as sedentary behaviour, comprising 16 questions (P1-P16). The domains are:\
• Activity at work\
• Travel to and from places\
• Recreational activities\
WHOPH is working only on R 32bit and has 5 dependencies listed in the DESCRIPTION file : survey, dplyr.

## Installation
```
# install.packages("devtools")
devtools::install_github("mhajihos/WHOPH")
require(WHOPH)
```
## Read_Data For Mac or Windows
```
    
```

## UNWPA_Data
```
UNWPA_Data (Data) # To prepare the unweighted dataset
```
* Arguments\
    Data is the dataframe which contains all information from the GPAQ – Global Physical Activity questionnaire.
* Outputs\
    Output is an object of class "data.frame" including unweighted variables in the GPAQ questionnaire.
* Examples
```
data= UNWPA_Data (Data) 
class (data)

[1] "data.frame"
```

## As_svy_mean
```
As_svy_mean (Outcome,Group=NULL,Data,id,weights,strata,CLN,Median=FALSE)# For mean and median of any combination of factors
```
* Arguments\
        Outcome is the outcome of interest. for example: Meet wich shows if the WHO recommendation for physical activity was met or not.\
        Group is the group of interest. The default is NULL for when only the outcome variable is in our interest. Group can be any combination of categorical variables. Examples for group can be: ~age4y, ~age4y+sex, ~age4y+UrbanRural+sex, etc.\
        Data is the output object of UNWPA_Data function.\
        id, weights, starta are variables in the output of the UNWPA_Data function and arguments for svydesign function.\
        CLN depends on the analysis. There are six CLN variables in the ouput of the UNWPA_Data function.\
        "cln_composition"\
            For the analysis of the outcome variables "percentwork" "percenttrans" "percentrec".\
        "cln_meet"\
            For the analysis of the outcome variable "meet".\
        "cln_activity"\
            For the analysis of the outcome variable "work" "trans" "rec".\
        "cln_vigorous"\
            For the analysis of the outcome variable "vig".\
        "cln_specific"\
            For the analysis of the outcome variable "pworkday" "ptravelday" "precday".\
        "cln_Ptotal"\
            For the analysis of the outcome variable "ptotalday" "ptotalCat".\
        Median is a logical argument. Default is FALSE when we are interested in the weighted average [and 95%CI] value and TRUE for weighted median [and 25%le-75%le] values.
* Outputs\
    Output is a matrix with number of rows equal to the combination number of categories for Group arguments and three columns. The first column indicate the group of interest, the second group is the average or median and the third column is the 95% confidence interval for the average or 25% and 75% percentiles for the median.


```
## Examples for Mean
As_svy_mean(~meet,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")

        Category          Meet1) doesn't meet recs         95%CI
1       18-29                   0.0966                  0.0712-0.122
2       30-44                   0.1143                  0.0938-0.1348
3       45-59                   0.1233                  0.1025-0.1442
4       60-69                   0.2341                  0.1905-0.2778
```

            
```
As_svy_mean(~meet,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")

        Category       Meet1) doesn't meet recs         95%CI
1       18-29.Men              0.0767               0.0489-0.1046
2       30-44.Men              0.1051               0.0749-0.1354
3       45-59.Men              0.1315               0.1027-0.1604
4       60-69.Men              0.2714               0.2019-0.3409
5       18-29.Women            0.1177               0.0765-0.1589
6       30-44.Women            0.1232               0.0974-0.1491
7       45-59.Women            0.1162               0.0905-0.142
8       60-69.Women            0.2084               0.1643-0.2524

```
            
```
As_svy_mean(~meet,~age4y+UrbanRural+sex,Data=Data,id=psu,weights=wstep1,strata =stratum,CLN="cln_meet")

              Category          Meet1) doesn't meet recs            95%CI
1          18-29.rural.Men               0.0725                 0.0334-0.1117
2          30-44.rural.Men               0.0903                 0.0478-0.1328
3          45-59.rural.Men               0.1189                 0.0784-0.1593
4          60-69.rural.Men               0.2054                 0.1149-0.296
5          18-29.urban.Men               0.0806                 0.0412-0.12
6          30-44.urban.Men               0.1159                 0.0739-0.1578
7          45-59.urban.Men               0.1456                 0.1043-0.1869
8          60-69.urban.Men               0.3270                 0.2278-0.4263
9          18-29.rural.Women             0.1367                 0.0677-0.2058
10         30-44.rural.Women             0.1114                 0.0738-0.1491
11         45-59.rural.Women             0.1119                 0.0743-0.1494
12         60-69.rural.Women             0.2350                 0.1582-0.3118
13         18-29.urban.Women             0.0997                 0.0536-0.1459
14         30-44.urban.Women             0.1312                 0.0963-0.1661
15         45-59.urban.Women             0.1201                 0.0847-0.1554
16         60-69.urban.Women             0.1922                 0.1393-0.2452

```
            
```
As_svy_mean(~meet,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")

                  Category                  Meet1) doesn't meet recs         95%CI
1           meet1) doesn't meet recs                0.1315                 0.1147-0.1483
```

```
## Examples for Median
As_svy_mean(~ptotalday,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)

            Category        Ptotalday            25%le-75%le
1           18-29           145.7143            124.2857-185
2           30-44           182.8571            150-217.8571
3           45-59           180.0000            171.4286-205.7143
4           60-69            60.0000            60-85.7143

```
            
```
As_svy_mean(~ptotalday,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)

                Category         Ptotalday         25%le-75%le
1               18-29.Men       210.0000        171.4286-244.2857
2               30-44.Men       257.1429        229.2857-291.4286
3               45-59.Men       240.0000        214.2857-267.8571
4               60-69.Men       60.0000             58-90
5               18-29.Women     117.8571        80-131.4286
6               30-44.Women     120.0000        115.7143-150
7               45-59.Women     128.5714        120-162.8571
8               60-69.Women      60.0000        60-85.7143
```
            
```
As_svy_mean(~ptotalday,~age4y+UrbanRural+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)

              Category              Ptotalday          25%le-75%le
1       18-29.rural.Men             257.1429        205.7143-300
2       30-44.rural.Men             301.4286        265.7143-351.4286
3       45-59.rural.Men             278.5714        240-311.4286
4       60-69.rural.Men             68.5714         57.1429-128
5       18-29.urban.Men             145.7143        120-214.2857
6       30-44.urban.Men             222.8571           180-270
7       45-59.urban.Men             214.2857        180-257.1429
8       60-69.urban.Men             51.4286             40-80
9       18-29.rural.Women           120.0000        72.8571-180
10      30-44.rural.Women           180.0000        128.5714-242.8571
11      45-59.rural.Women           186.4286        171.4286-234.2857
12      60-69.rural.Women           60.0000            60-105
13      18-29.urban.Women           111.4286        85.7143-131.4286
14      30-44.urban.Women           85.7143         68.5714-120
15      45-59.urban.Women           107.1429            90-120
16      60-69.urban.Women           60.0000         60-85.7143

```
            
```
As_svy_mean(~ptotalday,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)

            Category        Ptotalday       25%le-75%le
1           ptotalday       137.1429        120-157.1429
```
        

## PtotalCat_svy_mean
```
PtotalCat_svy_mean (Outcome,Group=NULL,Data,id,weights,strata,CLN) # For mean of Total physical activity categories for any combination of factors
```
* Arguments\
        Outcome is the outcome of interest. PtotalCat is the outcome of interest with three levels "Low", "Moderate", and "High"\
        Group is the group of interest. The default is NULL for when only the outcome variable is in our interest. Group can be any combination of categorical variables. Examples for group can be: ~age4y, ~age4y+sex, ~age4y+UrbanRural+sex, etc.\
        Data is the output object of UNWPA_Data function.\
        id, weights, starta are variables in the output of the UNWPA_Data function and arguments for svydesign function.\
        CLN is the "cln_Ptotal" for the analysis of the outcome variable "ptotalCat".
* Outputs\
    Output is a matrix with number of rows equal to the combination number of categories for Group arguments and seven columns. The first column indicate the group of interest, columns two to seven are the average and 95% confidence intervals for Low, Moderate, and High categories for total physical activity, respectively.
* Examples
```
PtotalCat_svy_mean(~ptotalCat,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal")

        Category        95%CI_Low   95%CI_Moderate 95%CI_High     95%CI_Low 95%CI_Moderate
1       18-29           0.1287  0.1014-0.1561     0.2584 0.2192-0.2975         0.6129
2       30-44           0.1553  0.1299-0.1807     0.2665  0.235-0.2981         0.5781
3       45-59           0.1482  0.1265-0.1699     0.2566 0.2307-0.2826         0.5951
4       60-69           0.2842  0.2408-0.3276     0.3876 0.3489-0.4262         0.3282
     95%CI_High
1  0.569-0.6568
2 0.5388-0.6174
3 0.5645-0.6258
4 0.2854-0.3711
```

```
PtotalCat_svy_mean( ~PtotalCat, ~age4y+sex,Design= data)

        Category                PtotalCat1..Low.Level                       95%CI_Low               PtotalCat2..Moderate.level
1       (18,29].Men                0.1129                                   0.0754-0.1503                     0.1697
2       (29,44].Men                0.1396                                   0.1077-0.1715                     0.1977
3       (44,59].Men                0.1559                                   0.1284-0.1833                     0.1978
4       (59,69].Men                0.3079                                   0.253-0.3628                      0.3215
5       (18,29].Women              0.1526                                   0.1107-0.1944                     0.3473
6       (29,44].Women              0.1707                                   0.1413-0.2                        0.3335
7       (44,59].Women              0.1417                                   0.1179-0.1655                     0.3073
8       (59,69].Women              0.2678                                   0.2281-0.3075                     0.4332

        95%CI_Moderate           PtotalCat3..High.level                      95%CI_High
1       0.1249-0.2146                 0.7174                                0.6632-0.7716
2       0.1591-0.2363                 0.6627                                0.6181-0.7073
3       0.165-0.2305                  0.6464                                0.6083-0.6845
4       0.2674-0.3755                 0.3706                                0.3134-0.4279
5       0.2907-0.4039                 0.5002                                0.4405-0.5598
6       0.296-0.3711                  0.4958                                0.4563-0.5353
7       0.2759-0.3388                 0.5510                                0.5171-0.5849
8       0.3898-0.4767                 0.2990                                0.2598-0.3381

```


```
PtotalCat_svy_mean( ~PtotalCat, ~age4y+UrbanRural+sex,Design= data)

              Category                  PtotalCat1..Low.Level             95%CI_Low
1           (18,29].rural.Men                0.1087                     0.052-0.1653
2           (29,44].rural.Men                0.1139                     0.0708-0.1569
3           (44,59].rural.Men                0.1315                     0.0982-0.1647
4           (59,69].rural.Men                0.2338                     0.1665-0.3011
5           (18,29].urban.Men                0.1167                     0.0671-0.1662
6           (29,44].urban.Men                0.1583                     0.1132-0.2033
7           (44,59].urban.Men                0.1829                     0.1385-0.2273
8           (59,69].urban.Men                0.3704                     0.2895-0.4514
9           (18,29].rural.Women              0.1451                     0.0839-0.2063
10          (29,44].rural.Women              0.1223                     0.0835-0.1611
11          (44,59].rural.Women              0.1291                     0.0984-0.1599
12          (59,69].rural.Women              0.2562                     0.2003-0.3121
13          (18,29].urban.Women              0.1596                     0.1023-0.2169
14          (29,44].urban.Women              0.2033                     0.1621-0.2446
15          (44,59].urban.Women              0.1528                     0.1173-0.1884
16          (59,69].urban.Women              0.2748                     0.2209-0.3288

                PtotalCat2..Moderate.level                  95%CI_Moderate          PtotalCat3..High.level
1                      0.1339                               0.0741-0.1938                 0.7574
2                      0.1607                               0.103-0.2183                  0.7254
3                      0.1877                               0.1419-0.2335                 0.6808
4                      0.3199                               0.2417-0.398                  0.4463
5                      0.2023                               0.1367-0.2678                 0.6811
6                      0.2246                               0.1728-0.2764                 0.6171
7                      0.2089                               0.1619-0.2559                 0.6082
8                      0.3228                               0.2482-0.3974                 0.3068
9                      0.3123                               0.2332-0.3913                 0.5426
10                     0.2690                               0.2143-0.3237                 0.6087
11                     0.2215                               0.1826-0.2605                 0.6493
12                     0.3981                               0.3325-0.4638                 0.3457
13                     0.3804                               0.3002-0.4606                 0.4600
14                     0.3770                               0.3266-0.4275                 0.4196
15                     0.3835                               0.3367-0.4304                 0.4636
16                     0.4544                               0.397-0.5118                  0.2707

                      95%CI_High
1                   0.6803-0.8345
2                   0.6595-0.7914
3                   0.6297-0.7319
4                   0.3607-0.5319
5                   0.6052-0.7569
6                   0.5573-0.677
7                   0.5511-0.6653
8                   0.2328-0.3808
9                   0.4565-0.6288
10                  0.549-0.6685
11                  0.6041-0.6945
12                  0.2827-0.4087
13                  0.378-0.542
14                  0.3687-0.4705
15                  0.4159-0.5114
16                  0.2211-0.3203

```

```
PtotalCat_svy_mean( ~PtotalCat,Design= data)

                    Category                PtotalCat         95%CI
1           PtotalCat1) Low Level           0.1669          0.155-0.1789
2           PtotalCat2) Moderate level      0.2802          0.2655-0.295
3           PtotalCat3) High level          0.5528          0.5365-0.5692

```
            
## Useful Links
[WHO European Office for the Prevention and Control of NCDs (NCD Office)](https://www.euro.who.int/en/health-topics/noncommunicable-diseases/pages/who-european-office-for-the-prevention-and-control-of-noncommunicable-diseases-ncd-office)\
[WHO STEPS Program](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/steps)\
[WHO Physical Activity Surveillance](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/physical-activity-surveillance)

