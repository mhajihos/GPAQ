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
  mutate(meet = if_else(ptotal>=600, "2) meets recs", "1) doesn't meet recs", missing = "1) doesn't meet recs")) %>% 
  mutate(meet = factor(meet)) %>% 
  
  # UpDATED: Calculate additional >=1200 MET-minutes/week
  mutate(mets1200 = if_else(ptotal>=1200, "2) meets recs", "1) doesn't meet recs", missing = "1) doesn't meet recs")) %>% 
  mutate(mets1200 = factor(mets1200))
}
