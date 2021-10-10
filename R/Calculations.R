As_svy_mean=function(Outcome,Group=NULL,Design,Median=FALSE)
{
	if(Median & is.null(Group))
	{

S=svyquantile(Outcome,Design,quantiles=0.5,na.rm=TRUE)


Category=names(S)
Estimation=round(S[[1]],4)[1]
CI=paste0(round(confint(S)[1],4),"-",
			round(confint(S)[2],4))
Res=data.frame(Category,Estimation,CI)
names(Res)[c(2,3)]=c(Category,"95%CI")

}else if(Median & !is.null(Group))
	{
S=svyby(Outcome,Group,Design,svyquantile,quantiles=0.5,vartype="ci",na.rm=TRUE)
S=data.frame(S)

Category=rownames(S)
Estimation=round(S[,which(sapply(S, is.numeric)==TRUE)[1]],4)
CI=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[1]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[1]],4))
Res=data.frame(Category,Estimation,CI)
names(Res)[c(2,3)]=c(colnames(S)[2],"95%CI")

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
names(Res)[c(2,3)]=c(colnames(S)[2],"95%CI")
}

return(Res)
}


#PtotalCat
PtotalCat_svy_mean=function(Outcome,Group=NULL,Design,Median=FALSE)
{
	 if(is.null(Group)) 
	{
S=svymean(Outcome,Design,na.rm=TRUE)

S1=data.frame(S)
Category=rownames(S1)
Estimation=round(S1[,1],4)
CI=paste0(round(confint(S)[,1],4),"-",
			round(confint(S)[,2],4))

Res=data.frame(Category,Estimation,CI)
names(Res)[c(2,3)]=c("PtotalCat","95%CI")

}else if(!is.null(Group))
	{
S=svyby(Outcome,Group,Design,svymean,vartype="ci",na.rm=TRUE)
S=data.frame(S)

Category=rownames(S)

Estimation1=round(S[,which(substr(colnames(S),1,10)=="PtotalCat1")],4)
CI1=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[1]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[1]],4))


Estimation2=round(S[,which(substr(colnames(S),1,10)=="PtotalCat2")],4)
CI2=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[2]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[2]],4))


Estimation3=round(S[,which(substr(colnames(S),1,10)=="PtotalCat3")],4)
CI3=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[3]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[3]],4))

Res=data.frame(Category,Estimation1,CI1,Estimation2,CI2,Estimation3,CI3)
names(Res)[c(2,3,4,5,6,7)]=c(colnames(S)[which(substr(colnames(S),1,10)=="PtotalCat1")],"95%CI_Low",
				colnames(S)[which(substr(colnames(S),1,10)=="PtotalCat2")],"95%CI_Moderate",
				colnames(S)[which(substr(colnames(S),1,10)=="PtotalCat3")],"95%CI_High")
}

return(Res)
}


