  #Ptotal (unweighted mean & median values)
  
Ptotal=function(Data)
{
Data%>%

  mutate(Ptotalday = (P1t3+P4t6+P7t9+P10t12+P13t15)/7) %>% 
 #PTotal Levels
  mutate(P1t3 = ifelse(P1t3cln==1, P2*P3*8, NA)) %>% 
  mutate(P4t6 = ifelse(P4t6cln==1, P5*P6*4, NA)) %>% 
  mutate(P7t9 = ifelse(P7t9cln==1, P8*P9*4, NA)) %>% 
  mutate(P10t12 = ifelse(P10t12cln==1, P11*P12*8, NA)) %>% 
  mutate(P13t15 = ifelse(P13t15cln==1, P14*P15*4, NA)) %>% 
  mutate(Ptotal = P1t3+P4t6+P7t9+P10t12+P13t15) %>% 
  mutate(PtotalCat = ifelse((P2+P5+P8+P11+P14)>6 & Ptotal>2999, "3) High level", NA)) %>%
  mutate(PtotalCat = replace(PtotalCat, (P2+P11)>2 & Ptotal>1499, "3) High level")) %>% 
  mutate(PtotalCat = replace(PtotalCat, is.na(PtotalCat) & ((P2+P5+P8+P11+P14)>=5) & Ptotal>=600, "2) Moderate level")) %>% 
  mutate(PtotalCat = replace(PtotalCat, is.na(PtotalCat) & ((P2+P11)==3 | (P2+P11)==4) & P12>=20 & P3>=20, "2) Moderate level")) %>% 
  mutate(PtotalCat = replace(PtotalCat, is.na(PtotalCat) & P2>=3 & P11>=3 & (P12>=20 | P3>=20), "2) Moderate level")) %>% 
  mutate(PtotalCat = replace(PtotalCat, is.na(PtotalCat) & ((P2>=3 & P11<3 & P3>=20) | (P11>=3 & P2<3 & P12>=20)), "2) Moderate level")) %>% 
  mutate(PtotalCat = replace(PtotalCat, is.na(PtotalCat) & (P5+P8+P14)>=5 & ((P5*P6)+(P8*P9)+(P14*P15))>=150, "2) Moderate level")) %>% 
  mutate(PtotalCat = replace(PtotalCat, P1t3cln==1 & P4t6cln==1 & P7t9cln==1 & P10t12cln==1 & P13t15cln==1 & is.na(PtotalCat), "1) Low Level")) %>% 
  mutate(PtotalCat = factor(PtotalCat)) %>% 
  mutate(cln = if_else(P1t3cln==1 & P4t6cln==1 & P7t9cln==1 & P10t12cln==1 & P13t15cln==1, 1, 2, missing = 2)) %>% 
  mutate(cln = replace(cln, is.na(P1) & is.na(P4) & is.na(P7) & is.na(P10) & is.na(P13), 2))

}