#pnoactivitybyset (unweighted)

Pnoactivitybyset=function(data)
{
data%>%
  mutate(work = if_else(p1==1 | p4==1, "_did work activity", "_did no work activity", 
                            missing = "_did no work activity")) %>% 
  mutate(work = factor(work)) %>% 
  mutate(trans = if_else(p7==1, "_did transport activity", "_did no transport activity", 
                             missing = "_did no transport activity")) %>% 
  mutate(trans = factor(trans)) %>%
  mutate(rec = if_else(p10==1 | p13==1, "_did recreation activity", "_did no recreation activity", 
  					missing = "_did no recreation activity")) %>% 
  mutate(rec = factor(rec)) %>% 
  mutate(cln_activity = if_else(p1t3cln==1 & p4t6cln==1 & p7t9cln==1 & p10t12cln==1 & p13t15cln==1, 1, 2, missing = 2)) %>% 
  mutate(cln_activity = replace(cln_activity, is.na(p1) & is.na(p4) & is.na(p7) & is.na(p10) & is.na(p13), 2))%>%
  
  return(data)
}
