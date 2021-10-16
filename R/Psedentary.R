#psedentary (unweighted mean & median values)
  
Psedentary=function(data)
{
data%>%
mutate(cln_sedentary = if_else(p16cln==1, 1, 2, missing = 2))%>%
  
  return(data)
}
