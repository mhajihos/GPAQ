\name{gpaq}
\alias{gpaq}
\title{gpaq: Calculating Unweighted Variables for the Global Physical Activity Questionnaire (GPAQ)}
\usage{
gpaq (Data)
}
\description{
Prepare a dataset with unweighted variables and indiviual measures
}
\Arguments{
\item{Data} {Data is the dataframe which contains all information from the GPAQ – Global Physical Activity questionnaire}
}
\Value{
An object of class 'data.frame'
}
\examples{
data=gpaq(my_data)
class(data)
 "data.frame"
}
