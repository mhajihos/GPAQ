  #ptotal (unweighted mean & median values)
  
Ptotal=function(data)
{
data%>%

  mutate(ptotalday = (p1t3+p4t6+p7t9+p10t12+p13t15)/7) %>% 
 #pTotal Levels
  mutate(p1t3 = ifelse(p1t3cln==1, p2*p3*8, NA)) %>% 
  mutate(p4t6 = ifelse(p4t6cln==1, p5*p6*4, NA)) %>% 
  mutate(p7t9 = ifelse(p7t9cln==1, p8*p9*4, NA)) %>% 
  mutate(p10t12 = ifelse(p10t12cln==1, p11*p12*8, NA)) %>% 
  mutate(p13t15 = ifelse(p13t15cln==1, p14*p15*4, NA)) %>% 
  mutate(ptotal = p1t3+p4t6+p7t9+p10t12+p13t15) %>% 
  mutate(ptotalCat = ifelse((p2+p5+p8+p11+p14)>6 & ptotal>2999, " _High level", NA)) %>%
  mutate(ptotalCat = replace(ptotalCat, (p2+p11)>2 & ptotal>1499, " _High level")) %>% 
  mutate(ptotalCat = replace(ptotalCat, is.na(ptotalCat) & ((p2+p5+p8+p11+p14)>=5) & ptotal>=600, " _Moderate level")) %>% 
  mutate(ptotalCat = replace(ptotalCat, is.na(ptotalCat) & ((p2+p11)==3 | (p2+p11)==4) & p12>=20 & p3>=20, " _Moderate level")) %>% 
  mutate(ptotalCat = replace(ptotalCat, is.na(ptotalCat) & p2>=3 & p11>=3 & (p12>=20 | p3>=20), " _Moderate level")) %>% 
  mutate(ptotalCat = replace(ptotalCat, is.na(ptotalCat) & ((p2>=3 & p11<3 & p3>=20) | (p11>=3 & p2<3 & p12>=20)), " _Moderate level")) %>% 
  mutate(ptotalCat = replace(ptotalCat, is.na(ptotalCat) & (p5+p8+p14)>=5 & ((p5*p6)+(p8*p9)+(p14*p15))>=150, " _Moderate level")) %>% 
  mutate(ptotalCat = replace(ptotalCat, p1t3cln==1 & p4t6cln==1 & p7t9cln==1 & p10t12cln==1 & p13t15cln==1 & is.na(ptotalCat), " _Low Level")) %>% 
  mutate(ptotalCat = factor(ptotalCat)) %>% 
  mutate(cln_ptotal = if_else(p1t3cln==1 & p4t6cln==1 & p7t9cln==1 & p10t12cln==1 & p13t15cln==1, 1, 2, missing = 2)) %>% 
  mutate(cln_ptotal = replace(cln_ptotal, is.na(p1) & is.na(p4) & is.na(p7) & is.na(p10) & is.na(p13), 2))%>%
  
  return(data)

}
