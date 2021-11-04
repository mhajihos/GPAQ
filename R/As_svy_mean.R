As_svy_mean=function(Outcome,Group=NULL,Data,id,weights,strata,CLN,Median=FALSE)
{
Data_subset=subset(Data,Data[,CLN]==1)
attach(Data_subset)
Design=svydesign(id=id, weights=weights, strata=strata,data=Data_subset, nest=TRUE)

	if(Median & is.null(Group))
	{

S=svyquantile(Outcome,Design,quantiles=0.5,na.rm=TRUE)


Category=names(S)
Estimation=round(S[[1]],4)[1]
CI=paste0(round(confint(S)[1],4),"-",
			round(confint(S)[2],4))
Res=data.frame(Category,Estimation,CI)
names(Res)[c(2,3)]=c(Category,"25%le-75%le")

}else if(Median & !is.null(Group))
	{
S=svyby(Outcome,Group,Design,svyquantile,quantiles=0.5,vartype="ci",na.rm=TRUE)
S=data.frame(S)

Category=rownames(S)
Estimation=round(S[,which(sapply(S, is.numeric)==TRUE)[1]],4)
CI=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[1]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[1]],4))
Res=data.frame(Category,Estimation,CI)
names(Res)[c(2,3)]=c(colnames(S)[which(sapply(S, is.numeric)==TRUE)][1],"25%le-75%le")

}else if(!Median & is.null(Group)) 
	{
S=svymean(Outcome,Design,na.rm=TRUE)


Category=names(S)[1]
Estimation=round(S[[1]],4)[1]
CI=paste0(round(confint(S)[1,1],4),"-",
			round(confint(S)[1,2],4))
Res=data.frame(Category,Estimation,CI)
names(Res)[c(2,3)]=c(Category,"95%CI")

}else if(!Median & !is.null(Group))
	{
S=svyby(Outcome,Group,Design,svymean,vartype="ci",na.rm=TRUE)
S=data.frame(S)

Category=rownames(S)
Estimation=round(S[,which(sapply(S, is.numeric)==TRUE)[1]],4)
CI=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[1]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[1]],4))
Res=data.frame(Category,Estimation,CI)
names(Res)[c(2,3)]=c(colnames(S)[which(sapply(S, is.numeric)==TRUE)][1],"95%CI")
}
detach(Data_subset)
return(Res)
}