UNWPA_Data=function(Data)
{
suppressMessages(suppressWarnings(library(survey)))
suppressMessages(suppressWarnings(library(dplyr)))
  
  
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
