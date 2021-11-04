#' As_svy_mean: Calculating the Weighted Mean or Median of any Combination of the Factors for the Global Physical Activity Questionnaire (GPAQ)
#'
#' Prepare the output for the weighted measures explained in the GPAQ Analysis Guide at the population level
#'
#' @param Outcome the outcome of interest. for example: "meet" which reports percentage of respondents who do not meet WHO recommendations on physical activity for health.
#' @param Group the group of interest. The default is NULL for when only the outcome variable is in our interest. Group can be any combination of categorical variables. Examples for group can be: ~age4y, ~age4y+sex, ~age4y+UrbanRural+sex, etc.
#' @param Data the output object of gpaq function.
#' @param id an argument in the "svydesign" function.
#' @param weights an argument in the "svydesign" function.
#' @param starta an argument in the "svydesign" function.
#' @param CLN  depends on the analysis. There are five CLN variables in the output of the gpaq function. see details.
#' @param Median  a logical argument. The default is FALSE when we are interested in the weighted average (and 95%CI) value and TRUE for weighted median (and 25%le-75%le) values.
#'
#' @return Output is a matrix with number of rows equal to the combination number of categories for Group arguments and three columns. The first column indicate the group of interest, the second group is the average or median and the third column is the 95% confidence interval for the average or 25% and 75% percentiles for the median.
#'
#'@details
#' "cln_composition" is for the analysis of the outcome variables "percentwork" "percenttrans" "percentrec".
#' "cln_meet" is for the analysis of the outcome variable "meet".
#' "cln_activity" is for the analysis of the outcome variable "work" "trans" "rec".
#' "cln_vigorous" is for the analysis of the outcome variable "vig".
#' "cln_specific" is for the the analysis of the outcome variable "pworkday" "ptravelday" "precday".
#'
#' @examples
#' Examples for Mean
#'    As_svy_mean(~meet,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")
#'    As_svy_mean(~meet,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")
#'    As_svy_mean(~meet,~age4y+ur+sex,Data=Data,id=psu,weights=wstep1,strata =stratum,CLN="cln_meet")
#'
#'    As_svy_mean(~meet,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_meet")
#'
#' Examples for Median
#'    As_svy_mean(~ptotalday,~age4y,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)
#'    As_svy_mean(~ptotalday,~age4y+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)
#'    As_svy_mean(~ptotalday,~age4y+UrbanRural+sex,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)
#'
#'    As_svy_mean(~ptotalday,Data=Data,id=psu, weights=wstep1,strata =stratum,CLN="cln_Ptotal",Median=TRUE)
#'
#' @export



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
