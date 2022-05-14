#pnovigorous (unweighted)

Pnovigorous<-function(data)
{
data%>%
   mutate(vig = if_else(p1==1 | p10==1, "_did vigorous physical activity", "_did no vigorous physical activity", 
                         missing = "_did no vigorous physical activity")) %>% 
   mutate(vig = factor(vig))%>% 
   mutate(cln_vigorous = if_else(p1t3cln==1 & p4t6cln==1 & p7t9cln==1 & p10t12cln==1 & p13t15cln==1, 1, 2, missing = 2)) %>% 
   mutate(cln_vigorous = replace(cln_vigorous, is.na(p1) & is.na(p4) & is.na(p7) & is.na(p10) & is.na(p13), 2))%>%
  
  return(data)
}
