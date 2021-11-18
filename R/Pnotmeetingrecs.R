  #pnotmeetingrecs (unweighted)

Pnotmeetingrecs=function(data)
{
data%>%
 
  mutate(p1t3 = ifelse(p1t3cln==1, p2*p3*8, NA)) %>% 
  mutate(p4t6 = ifelse(p4t6cln==1, p5*p6*4, NA)) %>% 
  mutate(p7t9 = ifelse(p7t9cln==1, p8*p9*4, NA)) %>% 
  mutate(p10t12 = ifelse(p10t12cln==1, p11*p12*8, NA)) %>% 
  mutate(p13t15 = ifelse(p13t15cln==1, p14*p15*4, NA)) %>% 
  mutate(ptotal = p1t3+p4t6+p7t9+p10t12+p13t15) %>%
  mutate(meet = if_else(ptotal>=600, "_meets WHO recommendations", "_doesn't meet WHO recommendations", missing = "_doesn't meet WHO recommendations")) %>% 
  mutate(meet = factor(meet)) %>% 
  
  # UpDATED: Calculate additional >=1200 MET-minutes/week
  mutate(mets1200 = if_else(ptotal>=1200, " _meets recs", " _doesn't meet recs", missing = "_doesn't meet recs")) %>% 
  mutate(mets1200 = factor(mets1200))%>%
  mutate(cln_meet = if_else(p1t3cln==1 & p4t6cln==1 & p7t9cln==1 & p10t12cln==1 & p13t15cln==1, 1, 2, missing = 2)) %>% 
  mutate(cln_meet = replace(cln_meet, is.na(p1) & is.na(p4) & is.na(p7) & is.na(p10) & is.na(p13), 2))%>% 
  
  return(data)
}
