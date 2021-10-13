WHOPH_Data=function(Data,id,weights,strata)
{

df=DC(Data)
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
STEPSC<-svydesign(id=~id, weights=~weights, strata = ~strata, data=df_valid, nest=TRUE)


return(STEPSC)
}
