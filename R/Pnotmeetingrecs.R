  #Pnotmeetingrecs (unweighted)

Pnotmeetingrecs=function(Data)
{
Data%>%
 
  mutate(P1t3 = ifelse(P1t3cln==1, P2*P3*8, NA)) %>% 
  mutate(P4t6 = ifelse(P4t6cln==1, P5*P6*4, NA)) %>% 
  mutate(P7t9 = ifelse(P7t9cln==1, P8*P9*4, NA)) %>% 
  mutate(P10t12 = ifelse(P10t12cln==1, P11*P12*8, NA)) %>% 
  mutate(P13t15 = ifelse(P13t15cln==1, P14*P15*4, NA)) %>% 
  mutate(Ptotal = P1t3+P4t6+P7t9+P10t12+P13t15) %>%
  mutate(Meet = if_else(Ptotal>=600, "2) meets recs", "1) doesn't meet recs", missing = "1) doesn't meet recs")) %>% 
  mutate(Meet = factor(Meet)) %>% 
  
  # UPDATED: Calculate additional >=1200 MET-minutes/week
  mutate(mets1200 = if_else(Ptotal>=1200, "2) meets recs", "1) doesn't meet recs", missing = "1) doesn't meet recs")) %>% 
  mutate(mets1200 = factor(mets1200))
  return(Data)
}
