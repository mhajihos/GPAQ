#Data Cleaning P1-P16

DC=function(data)
{
data %>%
### Clean Recode P1-P3
  mutate(P3a = replace(P3a, P3a==15 & (is.na(P3b) | P3b==0 | P3b==15 | P3b==77 | P3b==88 | P3b==99), 0)) %>% 
  mutate(P3b = replace(P3b, P3a==15 & (is.na(P3b) | P3b==0 | P3b==15 | P3b==77 | P3b==88 | P3b==99), 15)) %>% 
  mutate(P3a = replace(P3a, P3a==30 & (is.na(P3b) | P3b==0 | P3b==30 | P3b==77 | P3b==88 | P3b==99), 0)) %>% 
  mutate(P3b = replace(P3b, P3a==30 & (is.na(P3b) | P3b==0 | P3b==30 | P3b==77 | P3b==88 | P3b==99), 15)) %>% 
  mutate(P3a = replace(P3a, P3a==45 & (is.na(P3b) | P3b==0 | P3b==45 | P3b==77 | P3b==88 | P3b==99), 0)) %>% 
  mutate(P3b = replace(P3b, P3a==45 & (is.na(P3b) | P3b==0 | P3b==45 | P3b==77 | P3b==88 | P3b==99), 45)) %>% 
  mutate(P3a = replace(P3a, P3a==60 & (is.na(P3b) | P3b==0 | P3b==60 | P3b==77 | P3b==88 | P3b==99), 1)) %>% 
  mutate(P3b = replace(P3b, P3a==60 & (is.na(P3b) | P3b==0 | P3b==60 | P3b==77 | P3b==88 | P3b==99), 0)) %>%
  mutate(P3a = replace(P3a, (P3a==7 & P3b==77) | (P3a==8 & P3b==88) | (P3a==9 & P3b==99), 0)) %>% 
  mutate(P3b = replace(P3b, (P3a==7 & P3b==77) | (P3a==8 & P3b==88) | (P3a==9 & P3b==99), 0)) %>% 
  mutate(P3b = replace(P3b, P3b==77 | P3b==88 | P3b==99, 0)) %>% 
  mutate(P3a = replace(P3a, P3a==77 | P3a==88 | P3a==99, 0)) %>% 
  # Recode variables into minutes only
  mutate(P3amin = ifelse(is.na(P3a), 0, P3a*60)) %>% 
  mutate(P3bmin = ifelse(is.na(P3b), 0, P3b)) %>% 
  mutate(P3 = P3amin + P3bmin) %>% 
  # Cleans P1-P3
  mutate(P2 = replace(P2, is.na(P2) | P2==99, 0)) %>% 
  mutate(P2cln = if_else((P1==1 & P2>0 & P2<8) | (P1==2 & P2==0), 1, 2, missing = 2)) %>% 
  mutate(P3cln = if_else(P2cln==1 & P2>0 & P2<8 & P3>9 & P3<961, 1, 2, missing = 2)) %>% 
  mutate(P3cln = replace(P3cln, P2cln==1 & P2==0 & P3==0, 1)) %>% 
  mutate(P1t3cln = if_else(P3cln==1 & valid==1, 1, 2, missing = 2)) %>% 
  mutate(P1t3cln = replace(P1t3cln, is.na(P1) & P2==0 & P3==0 & valid==1, 1)) %>% 
  ### Clean Recode P4-P6
  mutate(P6a = replace(P6a, P6a==15 & (is.na(P6b) | P6b==0 | P6b==15 | P6b==77 | P6b==88 | P6b==99), 0)) %>% 
  mutate(P6b = replace(P6b, P6a==15 & (is.na(P6b) | P6b==0 | P6b==15 | P6b==77 | P6b==88 | P6b==99), 15)) %>% 
  mutate(P6a = replace(P6a, P6a==30 & (is.na(P6b) | P6b==0 | P6b==30 | P6b==77 | P6b==88 | P6b==99), 0)) %>% 
  mutate(P6b = replace(P6b, P6a==30 & (is.na(P6b) | P6b==0 | P6b==30 | P6b==77 | P6b==88 | P6b==99), 30)) %>% 
  mutate(P6a = replace(P6a, P6a==45 & (is.na(P6b) | P6b==0 | P6b==45 | P6b==77 | P6b==88 | P6b==99), 0)) %>% 
  mutate(P6b = replace(P6b, P6a==45 & (is.na(P6b) | P6b==0 | P6b==45 | P6b==77 | P6b==88 | P6b==99), 45)) %>% 
  mutate(P6a = replace(P6a, P6a==60 & (is.na(P6b) | P6b==0 | P6b==60 | P6b==77 | P6b==88 | P6b==99), 1)) %>% 
  mutate(P6b = replace(P6b, P6a==60 & (is.na(P6b) | P6b==0 | P6b==60 | P6b==77 | P6b==88 | P6b==99), 0)) %>% 
  mutate(P6a = replace(P6a, (P6a==7 & P6b==77) | (P6a==8 & P6b==88) | (P6a==9 & P6b==99), 0)) %>% 
  mutate(P6b = replace(P6b, (P6a==7 & P6b==77) | (P6a==8 & P6b==88) | (P6a==9 & P6b==99), 0)) %>% 
  mutate(P6b = replace(P6b, P6b==77 | P6b==88 | P6b==99, 0)) %>% 
  mutate(P6a = replace(P6a, P6a==77 | P6a==88 | P6a==99, 0)) %>% 
  # Recode variables into minutes only
  mutate(P6amin = ifelse(is.na(P6a), 0, P6a*60)) %>% 
  mutate(P6bmin = ifelse(is.na(P6b), 0, P6b)) %>% 
  mutate(P6 = P6amin + P6bmin) %>% 
  # Cleans P4-P6
  mutate(P5 = replace(P5, is.na(P5) | P5==99, 0)) %>% 
  mutate(P5cln = if_else((P4==1 & P5>0 & P5<8) | (P4==2 & P5==0), 1, 2, missing = 2)) %>% 
  mutate(P6cln = if_else(P5cln==1 & P5>0 & P5<8 & P6>9 & P6<961, 1, 2, missing = 2)) %>% 
  mutate(P6cln = replace(P6cln, P5cln==1 & P5==0 & P6==0, 1)) %>% 
  mutate(P4t6cln = if_else(P6cln==1 & valid==1, 1, 2, missing = 2)) %>% 
  mutate(P4t6cln = replace(P4t6cln, is.na(P4) & P5==0 & P6==0 & valid==1, 1)) %>% 
  ### Clean Recode P7-P9
  mutate(P9a = replace(P9a, P9a==15 & (is.na(P9b) | P9b==0 | P9b==15 | P9b==77 | P9b==88 | P9b==99), 0)) %>% 
  mutate(P9b = replace(P9b, P9a==15 & (is.na(P9b) | P9b==0 | P9b==15 | P9b==77 | P9b==88 | P9b==99), 15)) %>% 
  mutate(P9a = replace(P9a, P9a==30 & (is.na(P9b) | P9b==0 | P9b==30 | P9b==77 | P9b==88 | P9b==99), 0)) %>% 
  mutate(P9b = replace(P9b, P9a==30 & (is.na(P9b) | P9b==0 | P9b==30 | P9b==77 | P9b==88 | P9b==99), 30)) %>% 
  mutate(P9a = replace(P9a, P9a==45 & (is.na(P9b) | P9b==0 | P9b==45 | P9b==77 | P9b==88 | P9b==99), 0)) %>% 
  mutate(P9b = replace(P9b, P9a==45 & (is.na(P9b) | P9b==0 | P9b==45 | P9b==77 | P9b==88 | P9b==99), 45)) %>% 
  mutate(P9a = replace(P9a, P9a==60 & (is.na(P9b) | P9b==0 | P9b==60 | P9b==77 | P9b==88 | P9b==99), 1)) %>% 
  mutate(P9b = replace(P9b, P9a==60 & (is.na(P9b) | P9b==0 | P9b==60 | P9b==77 | P9b==88 | P9b==99), 0)) %>% 
  mutate(P9a = replace(P9a, (P9a==7 & P9b==77) | (P9a==8 & P9b==88) | (P9a==9 & P9b==99), 0)) %>% 
  mutate(P9b = replace(P9b, (P9a==7 & P9b==77) | (P9a==8 & P9b==88) | (P9a==9 & P9b==99), 0)) %>% 
  mutate(P9b = replace(P9b, P9b==77 | P9b==88 | P9b==99, 0)) %>% 
  mutate(P9a = replace(P9a, P9a==77 | P9a==88 | P9a==99, 0)) %>% 
  # Recode variables into minutes only
  mutate(P9amin = ifelse(is.na(P9a), 0, P9a*60)) %>% 
  mutate(P9bmin = ifelse(is.na(P9b), 0, P9b)) %>% 
  mutate(P9 = P9amin + P9bmin) %>% 
  # Cleans P7-P9
  mutate(P8 = replace(P8, is.na(P8) | P8==99, 0)) %>% 
  mutate(P8cln = if_else((P7==1 & P8>0 & P8<8) | (P7==2 & P8==0), 1, 2, missing = 2)) %>% 
  mutate(P9cln = if_else(P8cln==1 & P8>0 & P8<8 & P9>9 & P9<961, 1, 2, missing = 2)) %>% 
  mutate(P9cln = replace(P9cln, P8cln==1 & P8==0 & P9==0, 1)) %>% 
  mutate(P7t9cln = if_else(P9cln==1 & valid==1, 1, 2, missing = 2)) %>% 
  mutate(P7t9cln = replace(P7t9cln, is.na(P7) & P8==0 & P9==0 & valid==1, 1)) %>% 
  ### Clean Recode P10-P12
  mutate(P12a = replace(P12a, P12a==15 & (is.na(P12b) | P12b==0 | P12b==15 | P12b==77 | P12b==88 | P12b==99), 0)) %>% 
  mutate(P12b = replace(P12b, P12a==15 & (is.na(P12b) | P12b==0 | P12b==15 | P12b==77 | P12b==88 | P12b==99), 15)) %>% 
  mutate(P12a = replace(P12a, P12a==30 & (is.na(P12b) | P12b==0 | P12b==30 | P12b==77 | P12b==88 | P12b==99), 0)) %>% 
  mutate(P12b = replace(P12b, P12a==30 & (is.na(P12b) | P12b==0 | P12b==30 | P12b==77 | P12b==88 | P12b==99), 30)) %>% 
  mutate(P12a = replace(P12a, P12a==45 & (is.na(P12b) | P12b==0 | P12b==45 | P12b==77 | P12b==88 | P12b==99), 0)) %>%
  mutate(P12b = replace(P12b, P12a==45 & (is.na(P12b) | P12b==0 | P12b==45 | P12b==77 | P12b==88 | P12b==99), 45)) %>%
  mutate(P12a = replace(P12a, P12a==60 & (is.na(P12b) | P12b==0 | P12b==60 | P12b==77 | P12b==88 | P12b==99), 1)) %>%
  mutate(P12b = replace(P12b, P12a==60 & (is.na(P12b) | P12b==0 | P12b==60 | P12b==77 | P12b==88 | P12b==99), 0)) %>%
  mutate(P12a = replace(P12a, (P12a==7 & P12b==77) | (P12a==8 & P12b==88) | (P12a==9 & P12b==99), 0)) %>% 
  mutate(P12b = replace(P12b, (P12a==7 & P12b==77) | (P12a==8 & P12b==88) | (P12a==9 & P12b==99), 0)) %>% 
  mutate(P12b = replace(P12b, P12b==77 | P12b==88 | P12b==99, 0)) %>% 
  mutate(P12a = replace(P12a, P12a==77 | P12a==88 | P12a==99, 0)) %>% 
  # Recode variables into minutes only
  mutate(P12amin = ifelse(is.na(P12a), 0, P12a*60)) %>% 
  mutate(P12bmin = ifelse(is.na(P12b), 0, P12b)) %>% 
  mutate(P12 = P12amin + P12bmin) %>% 
  # Cleans P10-P12
  mutate(P11 = replace(P11, is.na(P11) | P11==99, 0)) %>% 
  mutate(P11cln = if_else((P10==1 & P11>0 & P11<8) | (P10==2 & P11==0), 1, 2, missing = 2)) %>% 
  mutate(P12cln = if_else(P11cln==1 & P11>0 & P11<8 & P12>9 & P12<961, 1, 2, missing = 2)) %>% 
  mutate(P12cln = replace(P12cln, P11cln==1 & P11==0 & P12==0, 1)) %>% 
  mutate(P10t12cln = if_else(P12cln==1 & valid==1, 1, 2, missing = 2)) %>% 
  mutate(P10t12cln = replace(P10t12cln, is.na(P10) & P11==0 & P12==0 & valid==1, 1)) %>% 
  ### Clean Recode P13-P15
  mutate(P15a = replace(P15a, P15a==15 & (is.na(P15b) | P15b==0 | P15b==15 | P15b==77 | P15b==88 | P15b==99), 0)) %>% 
  mutate(P15b = replace(P15b, P15a==15 & (is.na(P15b) | P15b==0 | P15b==15 | P15b==77 | P15b==88 | P15b==99), 15)) %>% 
  mutate(P15a = replace(P15a, P15a==30 & (is.na(P15b) | P15b==0 | P15b==30 | P15b==77 | P15b==88 | P15b==99), 0)) %>% 
  mutate(P15b = replace(P15b, P15a==30 & (is.na(P15b) | P15b==0 | P15b==30 | P15b==77 | P15b==88 | P15b==99), 30)) %>% 
  mutate(P15a = replace(P15a, P15a==45 & (is.na(P15b) | P15b==0 | P15b==45 | P15b==77 | P15b==88 | P15b==99), 0)) %>% 
  mutate(P15b = replace(P15b, P15a==45 & (is.na(P15b) | P15b==0 | P15b==45 | P15b==77 | P15b==88 | P15b==99), 45)) %>% 
  mutate(P15a = replace(P15a, P15a==60 & (is.na(P15b) | P15b==0 | P15b==60 | P15b==77 | P15b==88 | P15b==99), 1)) %>% 
  mutate(P15b = replace(P15b, P15a==60 & (is.na(P15b) | P15b==0 | P15b==60 | P15b==77 | P15b==88 | P15b==99), 0)) %>%
  mutate(P15a = replace(P15a, (P15a==7 & P15b==77) | (P15a==8 & P15b==88) | (P15a==9 & P15b==99), 0)) %>% 
  mutate(P15b = replace(P15b, (P15a==7 & P15b==77) | (P15a==8 & P15b==88) | (P15a==9 & P15b==99), 0)) %>%
  mutate(P15b = replace(P15b, P15b==77 | P15b==88 | P15b==99, 0)) %>% 
  mutate(P15a = replace(P15a, P15a==77 | P15a==88 | P15a==99, 0)) %>% 
  # Recode variables into minutes only
  mutate(P15amin = ifelse(is.na(P15a), 0, P15a*60)) %>% 
  mutate(P15bmin = ifelse(is.na(P15b), 0, P15b)) %>% 
  mutate(P15 = P15amin + P15bmin) %>% 
  # Cleans P13-P15
  mutate(P14 = replace(P14, is.na(P14) | P14==99, 0)) %>% 
  mutate(P14cln = if_else((P13==1 & P14>0 & P14<8) | (P13==2 & P14==0), 1, 2, missing = 2)) %>% 
  mutate(P15cln = if_else(P14cln==1 & P14>0 & P14<8 & P15>9 & P15<961, 1, 2, missing = 2)) %>% 
  mutate(P15cln = replace(P15cln, P14cln==1 & P14==0 & P15==0, 1)) %>% 
  mutate(P13t15cln = if_else(P15cln==1 & valid==1, 1, 2, missing = 2)) %>% 
  mutate(P13t15cln = replace(P13t15cln, is.na(P13) & P14==0 & P15==0 & valid==1, 1))%>% 
  mutate(P16a = replace(P16a, P16a==15 & (is.na(P16b) | P16b==0 | P16b==15 | P16b==77 | P16b==88 | P16b==99), 0)) %>% 
  mutate(P16b = replace(P16b, P16a==15 & (is.na(P16b) | P16b==0 | P16b==15 | P16b==77 | P16b==88 | P16b==99), 15)) %>%
  mutate(P16a = replace(P16a, P16a==30 & (is.na(P16b) | P16b==0 | P16b==30 | P16b==77 | P16b==88 | P16b==99), 0)) %>% 
  mutate(P16b = replace(P16b, P16a==30 & (is.na(P16b) | P16b==0 | P16b==30 | P16b==77 | P16b==88 | P16b==99), 30)) %>% 
  mutate(P16a = replace(P16a, P16a==45 & (is.na(P16b) | P16b==0 | P16b==45 | P16b==77 | P16b==88 | P16b==99), 0)) %>% 
  mutate(P16b = replace(P16b, P16a==45 & (is.na(P16b) | P16b==0 | P16b==45 | P16b==77 | P16b==88 | P16b==99), 45)) %>% 
  mutate(P16a = replace(P16a, P16a==60 & (is.na(P16b) | P16b==0 | P16b==60 | P16b==77 | P16b==88 | P16b==99), 1)) %>% 
  mutate(P16b = replace(P16b, P16a==60 & (is.na(P16b) | P16b==0 | P16b==60 | P16b==77 | P16b==88 | P16b==99), 0)) %>% 
  mutate(P16a = replace(P16a, (P16a==7 & P16b==77) | (P16a==8 & P16b==88) | (P16a==9 & P16b==99), 0)) %>% 
  mutate(P16b = replace(P16b, (P16a==7 & P16b==77) | (P16a==8 & P16b==88) | (P16a==9 & P16b==99), 0)) %>% 
  mutate(P16b = replace(P16b, P16b==77 | P16b==88 | P16b==99, 0)) %>% 
  mutate(P16a = replace(P16a, P16a==77 | P16a==88 | P16a==99, 0)) %>% 
  # Recode variables into minutes only
  mutate(P16amin = ifelse(P16a>=0 & P16a<=24, P16a*60, NA)) %>% 
  mutate(P16bmin = ifelse(P16b>=0 & P16b<=60, P16b, NA)) %>% 
  mutate(P16 = P16amin + P16bmin) %>% 
  # Cleans P16
  mutate(P16cln = if_else(P16>=0 & P16<1441, 1, 2, missing = 2))%>% 
return(data)
}
