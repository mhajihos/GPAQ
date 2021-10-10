#Psedentary (unweighted mean & median values)
  
Psedentary=function(data)
{
data%>%
mutate(cln = if_else(P16cln==1, 1, 2, missing = 2))%>%
  return(data)
}
