#Pnoactivitybyset (unweighted)

Pnoactivitybyset=function(Data)
{
Data%>%
  mutate(work = if_else(P1==1 | P4==1, "_did work activity", "_did no work activity", 
                            missing = "_did no work activity")) %>% 
  mutate(work = factor(work)) %>% 
  mutate(trans = if_else(P7==1, "_did transport activity", "_did no transport activity", 
                             missing = "_did no transport activity")) %>% 
  mutate(trans = factor(trans)) %>%
  mutate(rec = if_else(P10==1 | P13==1, "_did recreation activity", "_did no recreation activity", 
  					missing = "_did no recreation activity")) %>% 
  mutate(rec = factor(rec)) %>% 
  mutate(cln = if_else(P1t3cln==1 & P4t6cln==1 & P7t9cln==1 & P10t12cln==1 & P13t15cln==1, 1, 2, missing = 2)) %>% 
  mutate(cln = replace(cln, is.na(P1) & is.na(P4) & is.na(P7) & is.na(P10) & is.na(P13), 2))
  return(Data)
}
