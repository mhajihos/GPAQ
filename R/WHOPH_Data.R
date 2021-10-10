WHOPH_Data=function(Dir,Data,id,weights,strata)
{


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
