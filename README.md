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

    Category        ptotalCat1..Low.Level     95%CI_Low         ptotalCat2..Moderate.level
1    18-29                0.1287            0.1014-0.1561                     0.2584
2    30-44                0.1553            0.1299-0.1807                     0.2665
3    45-59                0.1482            0.1265-0.1699                     0.2566
4    60-69                0.2842            0.2408-0.3276                     0.3876
    
    95%CI_Moderate                  ptotalCat3..High.level          95%CI_High
1       0.2192-0.2975                   0.6129                      0.569-0.6568
2       0.235-0.2981                    0.5781                      0.5388-0.6174
3       0.2307-0.2826                   0.5951                      0.5645-0.6258
4       0.3489-0.4262                   0.3282                      0.2854-0.3711
```

```
PtotalCat_svy_mean(~ptotalCat,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal")

        Category            ptotalCat1..Low.Level     95%CI_Low                 ptotalCat2..Moderate.level
1       18-29.Men                0.1083                 0.0762-0.1403                     0.1710
2       30-44.Men                0.1396                 0.1045-0.1747                     0.1977
3       45-59.Men                0.1559                 0.1256-0.1861                     0.1978
4       60-69.Men                0.3079                 0.239-0.3768                      0.3215
5       18-29.Women              0.1505                 0.1049-0.1962                     0.3514
6       30-44.Women              0.1707                 0.1397-0.2017                     0.3335
7       45-59.Women              0.1417                 0.1142-0.1692                     0.3073
8       60-69.Women              0.2678                 0.2222-0.3134                     0.4332
    
        95%CI_Moderate              ptotalCat3..High.level              95%CI_High
1       0.1265-0.2155                   0.7208                          0.67-0.7715
2       0.1553-0.2401                   0.6627                          0.6083-0.7171
3       0.1594-0.2361                   0.6464                          0.6028-0.69
4       0.2636-0.3793                   0.3706                          0.3094-0.4319
5       0.2903-0.4125                   0.4980                          0.4293-0.5668
6       0.2925-0.3745                   0.4958                          0.4509-0.5407
7       0.2719-0.3428                   0.5510                          0.5114-0.5906
8       0.3888-0.4777                   0.2990                          0.2499-0.348

```


```
PtotalCat_svy_mean(~ptotalCat,~age4y+UrbanRural+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal")

            Category            ptotalCat1..Low.Level       95%CI_Low
1       18-29.rural.Men                0.1036               0.0571-0.15
2       30-44.rural.Men                0.1139               0.0671-0.1606
3       45-59.rural.Men                0.1315               0.0906-0.1723
4       60-69.rural.Men                0.2338               0.1433-0.3243
5       18-29.urban.Men                0.1125               0.0681-0.157
6       30-44.urban.Men                0.1583               0.1084-0.2081
7       45-59.urban.Men                0.1829               0.138-0.2278
8       60-69.urban.Men                0.3704               0.2731-0.4677
9       18-29.rural.Women              0.1448               0.0744-0.2152
10      30-44.rural.Women              0.1223               0.0808-0.1637
11      45-59.rural.Women              0.1291               0.0901-0.1682
12      60-69.rural.Women              0.2562               0.1812-0.3312
13      18-29.urban.Women              0.1560               0.097-0.215
14      30-44.urban.Women              0.2033               0.16-0.2467
15      45-59.urban.Women              0.1528               0.1144-0.1913
16      60-69.urban.Women              0.2748               0.2173-0.3324
               
               ptotalCat2..Moderate.level      95%CI_Moderate          ptotalCat3..High.level
1                      0.1395                   0.0793-0.1998                 0.7569
2                      0.1607                   0.1009-0.2204                 0.7254
3                      0.1877                   0.1306-0.2449                 0.6808
4                      0.3199                   0.2324-0.4073                 0.4463
5                      0.1999                   0.1356-0.2642                 0.6876
6                      0.2246                   0.1663-0.2829                 0.6171
7                      0.2089                   0.1583-0.2595                 0.6082
8                      0.3228                   0.2458-0.3998                 0.3068
9                      0.3237                   0.2342-0.4132                 0.5316
10                     0.2690                   0.2091-0.3289                 0.6087
11                     0.2215                   0.1814-0.2617                 0.6493
12                     0.3981                   0.3243-0.472                  0.3457
13                     0.3776                   0.2958-0.4593                 0.4664
14                     0.3770                   0.3208-0.4333                 0.4196
15                     0.3835                   0.3297-0.4374                 0.4636
16                     0.4544                   0.399-0.5099                  0.2707
                     
                     95%CI_High
1                   0.6911-0.8227
2                   0.6538-0.7971
3                   0.6197-0.7419
4                   0.3511-0.5416
5                   0.6113-0.7638
6                   0.5402-0.6941
7                   0.5452-0.6711
8                   0.2317-0.3818
9                   0.4229-0.6402
10                  0.5347-0.6827
11                  0.5951-0.7036
12                  0.2669-0.4245
13                  0.3827-0.5502
14                  0.3627-0.4766
15                  0.4101-0.5172
16                  0.2079-0.3336


```

```
PtotalCat_svy_mean(~ptotalCat,Data=Data,id=psu,	weights=wstep1,strata =stratum,CLN="cln_Ptotal")

                    Category                PtotalCat         95%CI
1           ptotalCat1) Low Level           0.1669          0.1486-0.1853
2           ptotalCat2) Moderate level      0.2802          0.2624-0.2981
3           ptotalCat3) High level          0.5528          0.5271-0.5785

```
            
## Useful Links
[WHO European Office for the Prevention and Control of NCDs (NCD Office)](https://www.euro.who.int/en/health-topics/noncommunicable-diseases/pages/who-european-office-for-the-prevention-and-control-of-noncommunicable-diseases-ncd-office)\
[WHO STEPS Program](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/steps)\
[WHO Physical Activity Surveillance](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/physical-activity-surveillance)

