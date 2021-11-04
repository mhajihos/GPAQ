
PtotalCat_svy_mean=function(Outcome,Group=NULL,Data,id,weights,strata,CLN)
{
Data_subset=subset(Data,Data[,CLN]==1)
attach(Data_subset)
Design=svydesign(id=id, weights=weights, strata=strata,data=Data_subset, nest=TRUE)

	 if(is.null(Group)) 
	{
S=svymean(Outcome,Design,na.rm=TRUE)

S1=data.frame(S)
Category=rownames(S1)
Estimation=round(S1[,1],4)
CI=paste0(round(confint(S)[,1],4),"-",
			round(confint(S)[,2],4))

Res=data.frame(Category,Estimation,CI)
names(Res)[c(2,3)]=c("ptotalCat","95%CI")

}else if(!is.null(Group))
	{
S=svyby(Outcome,Group,Design,svymean,vartype="ci",na.rm=TRUE)
S=data.frame(S)

Category=rownames(S)

Estimation1=round(S[,which(substr(colnames(S),1,10)=="ptotalCat1")],4)
CI1=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[1]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[1]],4))


Estimation2=round(S[,which(substr(colnames(S),1,10)=="ptotalCat2")],4)
CI2=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[2]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[2]],4))


Estimation3=round(S[,which(substr(colnames(S),1,10)=="ptotalCat3")],4)
CI3=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[3]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[3]],4))

Res=data.frame(Category,Estimation1,CI1,Estimation2,CI2,Estimation3,CI3)
names(Res)[c(2,3,4,5,6,7)]=c(colnames(S)[which(substr(colnames(S),1,10)=="ptotalCat1")],"95%CI_Low",
				colnames(S)[which(substr(colnames(S),1,10)=="ptotalCat2")],"95%CI_Moderate",
				colnames(S)[which(substr(colnames(S),1,10)=="ptotalCat3")],"95%CI_High")
}
detach(Data_subset)
return(Res)
}