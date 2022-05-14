 #pcomposition (unweighted)

Pcomposition<-function(data)
{
data%>%
  mutate(p1t3 <- ifelse(p1t3cln==1, p2*p3, NA)) %>% 
  mutate(p4t6 <- ifelse(p4t6cln==1, p5*p6, NA)) %>% 
  mutate(p7t9 <- ifelse(p7t9cln==1, p8*p9, NA)) %>% 
  mutate(p10t12 <- ifelse(p10t12cln==1, p11*p12, NA)) %>% 
  mutate(p13t15 <- ifelse(p13t15cln==1, p14*p15, NA)) %>% 
  mutate(ptotal <- p1t3+p4t6+p7t9+p10t12+p13t15) %>% 
  mutate(percentwork <- ((p1t3+p4t6)/ptotal)) %>% 
  mutate(percenttrans <- (p7t9/ptotal)) %>% 
  mutate(percentrec <- ((p10t12+p13t15)/ptotal)) %>% 
  mutate(cln_composition <- if_else(p1t3cln==1 & p4t6cln==1 & p7t9cln==1 & p10t12cln==1 & 
                             p13t15cln==1, 1, 2, missing = 2)) %>% 
  mutate(cln_composition <- replace(cln_composition, is.na(p1) & is.na(p4) & is.na(p7) & 
                             is.na(p10) & is.na(p13), 2)) %>% 
  mutate(cln_composition <- replace(cln_composition, ptotal==0, 2))%>%
  
  return(data)
}
