UNWPA_Data=function(Data)
{
setwd("C:\\Users\\Me\\Google Drive (mhajihos@ualberta.ca)\\WHO-New\\PH_Functions\\WHOPH\\WHOPH-main\\R")

source("DC.R") #DC(Output of DP) Function
source("Pcomposition.R") #Pcomposition (Output of DC) Function
source("Pnoactivitybyset.R") #Pnoactivitybyset(Output of Pnoactivitybyset) Function
source("Pnotmeetingrecs.R") #Pnotmeetingrecs(Output of Pnotmeetingrecs) Function
source("Pnovigorous.R") #Pnovigorous(Output of Pnovigorous) Function
source("Psedentary.R") #Psedentary(Output of Psedentary) Function
source("Psetspecific.R") #Psetspecific(Output of Psetspecific) Function
source("Ptotal.R") #Ptotal(Output of Ptotal) Function
source("Calculations.R") #Functions for Calculations

df=DC(Data)
df=Pcomposition(df)
df=Pnoactivitybyset(df)
df=Pnotmeetingrecs(df)
df=Pnovigorous(df)
df=Psedentary(df)
df=Psetspecific(df)
df=Ptotal(df)

return(df)
}