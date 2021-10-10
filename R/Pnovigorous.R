#Pnovigorous (unweighted)

Pnovigorous=function(Data)
{
Data%>%
   mutate(Vig = if_else(P1==1 | P10==1, "_did vigorous physical activity", "_did no vigorous physical activity", 
                         missing = "_did no vigorous physical activity")) %>% 
   mutate(Vig = factor(Vig))%>% 
   mutate(cln = if_else(P1t3cln==1 & P4t6cln==1 & P7t9cln==1 & P10t12cln==1 & P13t15cln==1, 1, 2, missing = 2)) %>% 
   mutate(cln = replace(cln, is.na(P1) & is.na(P4) & is.na(P7) & is.na(P10) & is.na(P13), 2))
}