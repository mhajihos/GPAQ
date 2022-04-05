## GPAQ
## Overview
GPAQ packages is based on The Global Physical Activity Questionnaire which was developed by WHO for physical activity surveillance in countries. It collects information on physical activity participation in three settings (or domains) as well as sedentary behaviour, comprising 16 questions (P1-P16). The domains are:\
• Activity at work\
• Travel to and from places\
• Recreational activities\
GPAQ package has 2 dependencies listed in the DESCRIPTION file : survey, dplyr.

## Installation
```
# install.packages("devtools")
devtools::install_github("mhajihos/GPAQ")
require(GPAQ)

#Functions
?gpaq
?As_svy_mean
?PtotalCat_svy_mean
?GPAQ_Shiny

```
## Read_Data For Mac or Windows
```
 if(.Platform$OS.type == "unix") 
 {

  # MacOS

  library(Hmisc) # needed to load mdb data in MacOS

  data1 <- mdb.get("Dataset.mdb", tables = "data1")

  data2 <- mdb.get("Dataset.mdb", tables = "data2")

    } else {

  # Windows

  library(RODBC)

  channel <- odbcConnectAccess("Dataset.mdb")

  data1 <- sqlFetch(channel,"data1", as.is=TRUE)

  data2 <- sqlFetch(channel,"data2", as.is=TRUE)

  odbcClose(channel)

    }   
my_data<- data.frame(merge(data1,data2, by="QR"))

#Change variable names to lowercase
names(my_data)<- tolower(names(my_data))

#Creat a new categorical age variable
my_data$age4y=NA
	my_data$age4y[18<=my_data$age & my_data$age<=29]="18-29"
	my_data$age4y[30<=my_data$age & my_data$age<=44]="30-44"
	my_data$age4y[45<=my_data$age & my_data$age<=59]="45-59"
	my_data$age4y[60<=my_data$age & my_data$age<=69]="60-69"
table(my_data$age4y)
```

### gpag (Data)
```
data= gpag (my_data) 
class (data)

[1] "data.frame"
```

### As_svy_mean (Outcome,Group=NULL,Data,id,weights,strata,CLN,Median=FALSE)
```
## Examples for Mean
As_svy_mean(~meet,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")

        Category          Meet1) doesn't meet recs         95%CI
1        18-29                   0.0658              0.0386-0.0931
2        30-44                   0.1100              0.0819-0.1382
3        45-59                   0.1385              0.1068-0.1701
4        60-69                   0.1863              0.1471-0.2255
```

            
```
As_svy_mean(~meet,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")

        Category            Meet1) doesn't meet recs         95%CI
1      18-29.Men                   0.0703                0.0304-0.1103
2      30-44.Men                   0.1002                0.0687-0.1317
3      45-59.Men                   0.1474                0.101-0.1937
4      60-69.Men                   0.1842                0.1269-0.2416
5      18-29.Women                 0.0601                0.0285-0.0918
6      30-44.Women                 0.1207                0.084-0.1574
7      45-59.Women                 0.1313                0.0981-0.1645
8      60-69.Women                 0.1879                0.1387-0.2371

```
            
```
As_svy_mean(~meet,~age4y+UrbanRural+sex,Data=Data,id=psu,weights=wstep1,strata =stratum,CLN="cln_meet")

              Category                Meet1) doesn't meet recs            95%CI
1         18-29.Rural.Men                     0.0872                 0.0315-0.1428
2         30-44.Rural.Men                     0.1332                 0.0763-0.19
3         45-59.Rural.Men                     0.1489                 0.104-0.1937
4         60-69.Rural.Men                     0.1923                 0.1333-0.2512
5         18-29.Urban.Men                     0.0675                 0.0218-0.1132
6         30-44.Urban.Men                     0.0914                 0.0546-0.1281
7         45-59.Urban.Men                     0.1467                 0.0842-0.2093
8         60-69.Urban.Men                     0.1814                 0.1068-0.256
9         18-29.Rural.Women                   0.1057                 0.0346-0.1768
10        30-44.Rural.Women                   0.1717                 0.1176-0.2257
11        45-59.Rural.Women                   0.1142                 0.0731-0.1553
12        60-69.Rural.Women                   0.2232                 0.1654-0.2809
13        18-29.Urban.Women                   0.0535                 0.0188-0.0882
14        30-44.Urban.Women                   0.1085                 0.0648-0.1521
15        45-59.Urban.Women                   0.1360                 0.0952-0.1768
16        60-69.Urban.Women                   0.1779                 0.1168-0.2389

```
            
```
As_svy_mean(~meet,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")

                  Category                  Meet1) doesn't meet recs         95%CI
1           meet1) doesn't meet recs                   0.1157            0.0968-0.1347
```

```
## Examples for Median
As_svy_mean(~ptotalday,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)

            Category        Ptotalday            25%le-75%le
1            18-29          122.1429           107.1429-145.7143
2            30-44          124.2857           111.4286-150
3            45-59          128.5714           120-157.1429
4            60-69          75.0000              60-90

```
            
```
As_svy_mean(~ptotalday,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)

                Category         Ptotalday         25%le-75%le
1              18-29.Men         141.4286         111.4286-180
2              30-44.Men         171.4286         140-214.2857
3              45-59.Men         180.0000         154.2857-211.4286
4              60-69.Men         85.7143          66.4286-120
5              18-29.Women       102.8571         85.7143-128.5714
6              30-44.Women       100.0000            90-120
7              45-59.Women       111.4286         98.5714-128.5714
8              60-69.Women       65.0000           60-85.7143
```
            
```
As_svy_mean(~ptotalday,~age4y+UrbanRural+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)

              Category              Ptotalday          25%le-75%le
1         18-29.Rural.Men          168.5714         102.8571-244.2857
2         30-44.Rural.Men          248.5714            180-300
3         45-59.Rural.Men          210.0000         171.4286-244.2857
4         60-69.Rural.Men          115.7143         68.5714-162.8571
5         18-29.Urban.Men          141.4286         111.4286-194.2857
6         30-44.Urban.Men          150.7143         127.8571-204.2857
7         45-59.Urban.Men          171.4286         131.4286-192.8571
8         60-69.Urban.Men          81.4286             60-100
9         18-29.Rural.Women        90.0000          71.4286-180
10        30-44.Rural.Women        131.4286         102.8571-188.5714
11        45-59.Rural.Women        150.0000         120-192.8571
12        60-69.Rural.Women        77.1429          60-102.8571
13        18-29.Urban.Women        102.8571         85.7143-132.8571
14        30-44.Urban.Women        94.2857          82.8571-111.4286
15        45-59.Urban.Women        102.8571         85.7143-120
16        60-69.Urban.Women        64.2857             60-90

```
            
```
As_svy_mean(~ptotalday,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)

            Category        Ptotalday       25%le-75%le
1           ptotalday       120          112.8571-137.1429
```
        

### PtotalCat_svy_mean (Outcome,Group=NULL,Data,id,weights,strata,CLN)
```
PtotalCat_svy_mean(~ptotalCat,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal")

    Category        ptotalCat1..Low.Level     95%CI_Low         ptotalCat2..Moderate.level
1    18-29                0.1193             0.081-0.1576                      0.2355
2    30-44                0.1610             0.1253-0.1966                     0.2951
3    45-59                0.1892             0.1528-0.2256                     0.2941
4    60-69                0.2260             0.1853-0.2666                     0.4093
    
    95%CI_Moderate                  ptotalCat3..High.level          95%CI_High
1    0.1901-0.2809                        0.6452                  0.5909-0.6995
2    0.257-0.3333                         0.5439                  0.499-0.5888
3    0.2557-0.3325                        0.5167                  0.4751-0.5582
4    0.3644-0.4542                       0.3647                   0.3165-0.413
```

```
PtotalCat_svy_mean(~ptotalCat,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal")

        Category            ptotalCat1..Low.Level     95%CI_Low                 ptotalCat2..Moderate.level
1      18-29.Men                  0.1223            0.071-0.1737                      0.1282
2      30-44.Men                  0.1501            0.1117-0.1884                     0.2299
3      45-59.Men                  0.2167            0.1665-0.2668                     0.2169
4      60-69.Men                  0.2187            0.1617-0.2756                     0.3899
5      18-29.Women                0.1155            0.0725-0.1586                     0.3702
6      30-44.Women                0.1728            0.1259-0.2198                     0.3662
7      45-59.Women                0.1671            0.1269-0.2073                     0.3563
8      60-69.Women                0.2319            0.1832-0.2806                     0.4252
    
        95%CI_Moderate              ptotalCat3..High.level              95%CI_High
1      0.077-0.1794                        0.7495                     0.6755-0.8234
2      0.1801-0.2798                       0.6200                     0.5648-0.6751
3      0.1745-0.2593                       0.5664                     0.5111-0.6217
4      0.318-0.4618                        0.3915                     0.3179-0.465
5      0.2857-0.4546                       0.5143                     0.4313-0.5973
6      0.3181-0.4143                       0.4610                     0.4047-0.5172
7      0.309-0.4036                        0.4766                     0.4254-0.5279
8      0.3747-0.4756                       0.3429                     0.2909-0.3949

```


```
PtotalCat_svy_mean(~ptotalCat,~age4y+UrbanRural+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal")

            Category                  ptotalCat1..Low.Level       95%CI_Low
1          18-29.Rural.Men                  0.1454             0.0692-0.2216
2          30-44.Rural.Men                  0.1882             0.1252-0.2512
3          45-59.Rural.Men                  0.1903             0.1418-0.2389
4          60-69.Rural.Men                  0.2399             0.1789-0.301
5          18-29.Urban.Men                  0.1184             0.0601-0.1768
6          30-44.Urban.Men                  0.1399             0.0944-0.1853
7          45-59.Urban.Men                  0.2272             0.1601-0.2944
8          60-69.Urban.Men                  0.2112             0.1373-0.285
9          18-29.Rural.Women                0.1517             0.0716-0.2319
10         30-44.Rural.Women                0.2310             0.1662-0.2957
11         45-59.Rural.Women                0.1683             0.1117-0.2249
12         60-69.Rural.Women                0.2658             0.2041-0.3274
13         18-29.Urban.Women                0.1103             0.0624-0.1581
14         30-44.Urban.Women                0.1588             0.1028-0.2149
15         45-59.Urban.Women                0.1668             0.1179-0.2157
16         60-69.Urban.Women                0.2223             0.1622-0.2823
               
               ptotalCat2..Moderate.level      95%CI_Moderate          ptotalCat3..High.level
1                      0.1915                  0.1034-0.2795                 0.6632
2                      0.1613                  0.1138-0.2087                 0.6505
3                      0.1971                  0.1486-0.2456                 0.6126
4                      0.2888                  0.2231-0.3545                 0.4712
5                      0.1175                  0.0605-0.1745                 0.7641
6                      0.2483                  0.1867-0.3099                 0.6118
7                      0.2249                  0.1689-0.281                  0.5478
8                      0.4254                  0.3314-0.5195                 0.3634
9                      0.3999                  0.2995-0.5003                 0.4484
10                     0.2375                  0.1875-0.2875                 0.5316
11                     0.2872                  0.237-0.3374                  0.5445
12                     0.3525                  0.2973-0.4078                 0.3817
13                     0.3658                  0.2699-0.4617                 0.5239
14                     0.3971                  0.3389-0.4554                 0.4440
15                     0.3754                  0.3171-0.4337                 0.4578
16                     0.4459                  0.3832-0.5086                 0.3318
                     
                     95%CI_High
1                 0.5707-0.7556
2                 0.5686-0.7325
3                 0.5535-0.6716
4                 0.3922-0.5503
5                 0.6805-0.8477
6                 0.5455-0.6781
7                 0.4747-0.6209
8                 0.268-0.4588
9                 0.338-0.5587
10                0.4575-0.6057
11                0.4781-0.6109
12                0.3171-0.4463
13                0.4299-0.618
14                0.3766-0.5115
15                0.3953-0.5204
16                0.2676-0.3961


```

```
PtotalCat_svy_mean(~ptotalCat,Data=Data,id=psu,	weights=wstep1,strata =stratum,CLN="cln_Ptotal")

                    Category                 PtotalCat         95%CI
1           ptotalCat1) Low Level             0.1658       0.1415-0.1901
2           ptotalCat2) Moderate level        0.2943       0.2734-0.3152
3           ptotalCat3) High level            0.5399       0.5103-0.5696

```

### GPAQ_Shiny:Shiny app for the Global Physical Activity Questionnaire (GPAQ)
# This function will Lunch a shiny app on the local server for weighted and unweighted analysis
            
## Useful Links
[WHO European Office for the Prevention and Control of NCDs (NCD Office)](https://www.euro.who.int/en/health-topics/noncommunicable-diseases/pages/who-european-office-for-the-prevention-and-control-of-noncommunicable-diseases-ncd-office)\
[WHO STEPS Program](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/steps)\
[WHO Physical Activity Surveillance](https://www.who.int/teams/noncommunicable-diseases/surveillance/systems-tools/physical-activity-surveillance)

