WHOPH_Data=function(Dir,Data,id,weights,strata)
{
source("Data_Prep.R") #DP(Dir,Data) Function
source("Data_Cleaning.R") #DC(Output of DP) Function
source("Pcomposition.R") #Pcomposition (Output of DC) Function
source("Pnoactivitybyset.R") #Pnoactivitybyset(Output of Pnoactivitybyset) Function
source("Pnotmeetingrecs.R") #Pnotmeetingrecs(Output of Pnotmeetingrecs) Function
source("Pnovigorous.R") #Pnovigorous(Output of Pnovigorous) Function
source("Psedentary.R") #Psedentary(Output of Psedentary) Function
source("Psetspecific.R") #Psetspecific(Output of Psetspecific) Function
source("Ptotal.R") #Ptotal(Output of Ptotal) Function
source("Calculations 05.10.2021.R") #Functions for Calculations

df=DP(Dir,Data)
df=DC(df)
df=Pcomposition(df)
df=Pnoactivitybyset(df)
df=Pnotmeetingrecs(df)
df=Pnovigorous(df)
df=Psedentary(df)
df=Psetspecific(df)
df=Ptotal(df)

df=subset(df, df$cln==1)
df_valid<-subset(df, df$valid==1)

#WStep1
STEPSC<-svydesign(id=~PSU, weights=~WStep1, strata = ~Stratum, data=df_valid, nest=TRUE)


return(STEPSC)
}
