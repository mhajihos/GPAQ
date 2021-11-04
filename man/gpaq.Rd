\name{gpaq}
\alias{gpaq}
\title{gpaq: Calculating Unweighted Variables for the Global Physical Activity Questionnaire (GPAQ)}
\usage{
gpaq (Data)
}
\description{
Prepare a dataset with unweighted variables and indiviual measures
}
\arguments{
\item{Data}  {a 'dataframe' which contains all variables in the GPAQ – Global Physical Activity questionnaire.}
}
\value{
An object of class 'data.frame'
}
\examples{
data=gpaq(my_data)
class(data)
 "data.frame"
}
