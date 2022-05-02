#' gpag: Calculating Unweighted variables for the Global Physical Activity Questionnaire (GPAQ)
#'
#' Prepare a dataset with unweighted variables and indiviual measures
#'
#' @param Data Data is the dataframe which contains all information from the GPAQ – Global Physical Activity questionnaire
#'
#' @return An object of class 'data.frame'
#'
#'@details
#'gpaq function generates unweighted variables mentioned in the GPAQ Analysis Guide at the individual level. Unweighted variables are listed as follows:
#' "meet": reports percentage of respondents who do not meet WHO recommendations on physical activity for health.
#' "ptotal" sum of all activities per week.
#' "ptotalday": sum of all activities per week divided by 7 to get avg. per day.
#' "percentwork": percent of all activity from work-related activities.
#' "percenttrans": percent of all activity from transportation-related activities.
#' "percentrec": percent of all activity from recreational activities.
#' "work": indicates whether or not respondent did any work-related activity.
#' "trans": indicates whether or not respondent did any transport-related activity.
#' "rec": indicates whether or not respondent did any recreationrelated activity.
#' "vig": indicates whether or not respondent did any vigorous activity.
#' "pworkday": percent of all activity from work-related activities.
#' "ptravelday": percent of all activity from transportation-related activities.
#' "precday": percent of all activity from recreational activities.
#' "ptotalCat": indicates whether or not respondent had "Low", "Medium", or "High" physical activity.
#'
#' @examples
#' data=gpag(my_data)
#'
#' @export


gpaq=function(Data)
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


df_valid=subset(df,(df$valid==1 & !is.na(df$wstep1)))
return(df_valid)
}
