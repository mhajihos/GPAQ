 #Pcomposition (unweighted)

Pcomposition=function(Data)
{
Data%>%
  mutate(P1t3 = ifelse(P1t3cln==1, P2*P3, NA)) %>% 
  mutate(P4t6 = ifelse(P4t6cln==1, P5*P6, NA)) %>% 
  mutate(P7t9 = ifelse(P7t9cln==1, P8*P9, NA)) %>% 
  mutate(P10t12 = ifelse(P10t12cln==1, P11*P12, NA)) %>% 
  mutate(P13t15 = ifelse(P13t15cln==1, P14*P15, NA)) %>% 
  mutate(Ptotal = P1t3+P4t6+P7t9+P10t12+P13t15) %>% 
  mutate(Percentwork = (P1t3+P4t6)/Ptotal) %>% 
  mutate(Percenttrans = P7t9/Ptotal) %>% 
  mutate(Percentrec = (P10t12+P13t15)/Ptotal) %>% 
  mutate(cln = if_else(P1t3cln==1 & P4t6cln==1 & P7t9cln==1 & P10t12cln==1 & 
                             P13t15cln==1, 1, 2, missing = 2)) %>% 
  mutate(cln = replace(cln, is.na(P1) & is.na(P4) & is.na(P7) & 
                             is.na(P10) & is.na(P13), 2)) %>% 
  mutate(cln = replace(cln, Ptotal==0, 2))
}