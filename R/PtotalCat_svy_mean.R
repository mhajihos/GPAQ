#' PtotalCat_svy_mean: Calculating the Weighted Mean for the Total Physical Activity Categories and any Combination of the Factors for the Global Physical Activity Questionnaire (GPAQ)
#'
#' Prepare the output for Total Physical Activity Categories (Low, Medium, and High) explained in the GPAQ Analysis Guide at the population level
#'
#' @param Outcome the outcome of interest. PtotalCat is the outcome of interest with three levels "Low", "Moderate", and "High".
#' @param Group the group of interest. The default is NULL for when only the outcome variable is in our interest. Group can be any combination of categorical variables. Examples for group can be: ~age4y, ~age4y+sex, ~age4y+UrbanRural+sex, etc.
#' @param Data the output object of gpaq function.
#' @param id an argument in the "svydesign" function.
#' @param weights an argument in the "svydesign" function.
#' @param starta an argument in the "svydesign" function.
#' @param CLN   is the "cln_ptotal" for the analysis of the outcome variable "ptotalCat".
#'
#' @return Output is a matrix with number of rows equal to the combination number of categories for Group arguments and seven columns. The first column indicate the group of interest, columns two to seven are the average and 95 percent confidence intervals for Low, Moderate, and High categories for total physical activity, respectively.
#'
#' @examples
#'    PtotalCat_svy_mean(~ptotalCat,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_ptotal")
#'    PtotalCat_svy_mean(~ptotalCat,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_ptotal")
#'    PtotalCat_svy_mean(~ptotalCat,~age4y+ur+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_ptotal")
#'
#'    PtotalCat_svy_mean(~ptotalCat,Data=Data,id=psu,	weights=wstep1,strata =stratum,CLN="cln_ptotal")
#'
#' @export






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

Estimation1=round(S[,which(substr(colnames(S),12,15)=="High")],4)
CI1=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[1]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[1]],4))


Estimation2=round(S[,which(substr(colnames(S),12,19)=="Moderate")],4)
CI2=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[2]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[2]],4))


Estimation3=round(S[,which(substr(colnames(S),12,14)=="Low")],4)
CI3=paste0(round(S[,which(substr(colnames(S),1,4)=="ci_l")[3]],4),"-",
				round(S[,which(substr(colnames(S),1,4)=="ci_u")[3]],4))

Res=data.frame(Category,Estimation1,CI1,Estimation2,CI3,Estimation3,CI2)
names(Res)[c(2,3,4,5,6,7)]=c("High","95%CI_High",
				"Moderate","95%CI_Moderate",
				"Low","95%CI_Low")
}
detach(Data_subset)
return(Res)
}
