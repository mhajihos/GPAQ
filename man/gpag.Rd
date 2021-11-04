\name{gpag}
\alias{gpag}
\title{gpag: Calculating Unweighted Variables for the Global Physical Activity Questionnaire (GPAQ)}
\usage{
gpag (Data)
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
data=gpag(my_data)
class(data)
 "data.frame"
}
