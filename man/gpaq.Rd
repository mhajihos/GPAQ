% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gpaq.R
\name{gpaq}
\alias{gpaq}
\title{gpag: Calculating Unweighted variables for the Global Physical Activity Questionnaire (GPAQ)}
\usage{
gpaq(Data)
}
\arguments{
\item{Data}{Data is the dataframe which contains all information from the GPAQ – Global Physical Activity questionnaire}
}
\value{
An object of class 'data.frame'
}
\description{
Prepare a dataset with unweighted variables and indiviual measures
}
\details{
gpaq function generates unweighted variables mentioned in the GPAQ Analysis Guide at the individual level. Unweighted variables are listed as follows:\cr
"meet": reports percentage of respondents who do not meet WHO recommendations on physical activity for health.\cr
"ptotal" sum of all activities per week.\cr
"ptotalday": sum of all activities per week divided by 7 to get avg. per day.\cr
"percentwork": percent of all activity from work related activities.\cr
"percenttrans": percent of all activity from transportation related activities.\cr
"percentrec": percent of all activity from recreational activities.\cr
"work": indicates whether or not respondent did any work related activity.\cr
"trans": indicates whether or not respondent did any transport related activity.\cr
"rec": indicates whether or not respondent did any recreation related activity.\cr
"vig": indicates whether or not respondent did any vigorous activity.\cr
"pworkday": Average work-related activity per day in minutes.\cr
"ptravelday": Average transportrelated activity per day in minutes.\cr
"precday": Average recreationrelated activity per day in minutes.\cr
"ptotalCat": indicates whether or not respondent had "Low", "Medium", or "High" physical activity.\cr
}
\examples{
data=gpag(my_data)

}
