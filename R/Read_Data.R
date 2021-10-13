
Read_Data=function(Dir,Data)
{

suppressMessages(suppressWarnings(library(survey)))
suppressMessages(suppressWarnings(library(RODBC)))
suppressMessages(suppressWarnings(library(knitr)))
suppressMessages(suppressWarnings(library(rlist)))
suppressMessages(suppressWarnings(library(dplyr)))
suppressMessages(suppressWarnings(library(stringr)))	
	
setwd(Dir)
#Reading a dataset and data preparation
channel <- odbcConnectAccess(Data) 

d1=which(substr(sqlTables(channel)$TABLE_NAME,1,4)=="data")
d2=which(sqlTables(channel)$TABLE_NAME %in% c("MasterDataset","MasterDataSet","masterdataset","masterDataSet"))
if(length(d1)>1)
	{
n=length(which(substr(sqlTables(channel)$TABLE_NAME,1,4)=="data"))
Agdata=list()	

	for(i in 1:n)
	{
		Name=sqlTables(channel)$TABLE_NAME[d1[i]]
		Agdata[[Name]]=sqlFetch(channel,sqlTables(channel)$TABLE_NAME[d1[i]])
	}

if(length(which(names(Agdata[[1]])=="id"))==0)
 {
	my_data=data.frame(merge(Agdata[[1]],Agdata[[2]], by="ID"))
}else if(length(which(names(Agdata[[1]])=="id"))!=0){
	my_data=data.frame(merge(Agdata[[1]],Agdata[[2]], by="id"))
	}
	}
 if(length(d2>0)){
		my_data=data.frame(sqlFetch(channel,sqlTables(channel)$TABLE_NAME[d2[1]]))
		}

if(length(which(names(my_data)=="age"))!=0)
 {
	if(length(which(names(my_data)=="Valid"))!=0)
		{
			my_data$valid=my_data$Valid
			my_data$AGE=my_data$age
			
		}else{
 my_data$P1=my_data$p1;my_data$P2=my_data$p2;my_data$P3a=my_data$p3a;my_data$P3b=my_data$p3b;my_data$P4=my_data$p4;
 my_data$P5=my_data$p5;my_data$P6a=my_data$p6a;my_data$P6b=my_data$p6b;my_data$P7=my_data$p7;my_data$P8=my_data$p8;
 my_data$P9a=my_data$p9a;my_data$P9b=my_data$p9b;my_data$P10=my_data$p10;my_data$P11=my_data$p11;my_data$P12a=my_data$p12a;
 my_data$P12b=my_data$p12b;my_data$P13=my_data$p13;my_data$P14=my_data$p14;my_data$P15a=my_data$p15a;my_data$P15b=my_data$p15b;
 my_data$P16a=my_data$p16a;my_data$P16b=my_data$p16b;
 my_data$AGE=my_data$age
			 }
 }
my_data$age4y<-cut(my_data$AGE, breaks=c(18,29,44,59,69))
my_data$age5y<-cut(my_data$AGE, breaks=c(17,19,24,29,34,39,44,49,54,59,64,69))

return(my_data)
}


