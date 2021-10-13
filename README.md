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

