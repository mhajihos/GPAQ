#Main-Shiny_App_Code

GPAQ_Shiny=function()
{

suppressMessages(suppressWarnings(require(shinythemes)))
suppressMessages(suppressWarnings(require(shiny)))
suppressMessages(suppressWarnings(require(GPAQ)))	
suppressMessages(suppressWarnings(require(dplyr)))	
suppressMessages(suppressWarnings(require(survey)))	
suppressMessages(suppressWarnings(require(RODBC)))
suppressMessages(suppressWarnings(require(Hmisc)))	
suppressMessages(suppressWarnings(require(gridExtra)))	
suppressMessages(suppressWarnings(require(data.table)))	
suppressMessages(suppressWarnings(require(ggplot2)))	
suppressMessages(suppressWarnings(require(plotly)))
suppressMessages(suppressWarnings(require(ggforce)))

	
roundUp=function(x, nice=c(1,2,4,5,6,8,10)) {
    if(length(x) != 1) stop("'x' must be of length 1")
    10^floor(log10(x)) * nice[[which(x <= 10^floor(log10(x)) * nice)[[1]]]]
}


ui = navbarPage(
  "WHO Global Physical Activity Questionnaire (GPAQ)",collapsible = TRUE,
		 inverse = TRUE, theme = shinytheme("spacelab"),
  tabPanel("Individual Level GPAQ (Unweighted)",
		fluidPage( 
			tabsetPanel(
				tabPanel("Vigorous-Intensity Activities", br(),
					fluidPage( 
						fluidRow(
						column(4,
    					
						numericInput(inputId = "p2", label = "
						In a typical week, how many days as part of your work?",
						value =1)),
    			
						column(4,
						numericInput(inputId = "p3a", label = "
						How many hours at work on a typical day?",
						value =1)),
			
						column(4,
						numericInput(inputId = "p3b", label = "
						How many minutes at work on a typical day?",
						value =1))),


						fluidRow(
						column(4,
						numericInput(inputId = "p11", label = "
						In a typical week, on how many days for sports, fitness or recreational activities?",
						value =1)),
	
						column(4,
						numericInput(inputId = "p12a", label = "
						How many hours for sports, fitness or recreational activities on a typical day?",
						value =1)),
	
						column(4,
						numericInput(inputId = "p12b", label = "
						How many minutes for sports, fitness or recreational activities on a typical day?",
						value = 1))),

mainPanel(tags$head(
	  tags$style(type="text/css",
	".test_type {color: red;
                           font-size:12 px; 
                           font-style: italic;}",
      ".shiny-output-error {visibility: hidden;}",
      ".shiny-output-error:before {visibility: hidden;}")),
	tags$div(class="test_type"))
)),
		

			tabPanel("Moderate-Intensity Activities", br(),
				fluidPage( 
						fluidRow(
						column(4,
						numericInput(inputId = "p5", label = "
						In a typical week, how many days as part of your work?",
						value =1)),

						column(4,
						numericInput(inputId = "p6a", label = "
						How many hours at work on a typical day?",
						value =1)),
			
						column(4,
						numericInput(inputId = "p6b", label = " 
						How many minutes at work on a typical day?",
						value =1))),

						fluidRow(
						column(4,
						numericInput(inputId = "p14", label = "
						In a typical week, on how many days for sports, fitness or recreational activities?",
						value =1)),

						column(4,	
						numericInput(inputId = "p15a", label = "
						How many hours for sports, fitness or recreational activities on a typical day?",
						value = 1)),

						column(4,	
						numericInput(inputId = "p15b", label = "
						How many minutes for sports, fitness or recreational activities on a typical day?",
						value =1))),
						

mainPanel(tags$head(
	  tags$style(type="text/css",
	".test_type {color: red;
                           font-size:12 px; 
                           font-style: italic;}",
      ".shiny-output-error {visibility: hidden;}",
      ".shiny-output-error:before {visibility: hidden;}")),
	tags$div(class="test_type"))
)),
	

			tabPanel("Walking or Bicycling/Sitting or Reclining ", br(),
			fluidPage( 
					fluidRow(
					column(4,
					numericInput(inputId = "p8", label = " 
					In a typical week, on how many days do you walk or bicycle for at least 10 minutes continuously to get to and from places?",
					value =1)),
	
					column(4,
					numericInput(inputId = "p9a", label = "
					How much time do you spend walking or bicycling for travel on a typical day? (Hours)",
					value =1)),
	
					column(4,
					numericInput(inputId = "p9b", label = "
					How much time do you spend walking or bicycling for travel on a typical day? (Minutes)",
					value =1))),

					fluidRow(
					column(4,
					numericInput(inputId = "p16a", label = "
					How much time do you usually spend sitting or reclining on a typical day? (Hours)",
					value =1)),
					
					column(4,
					numericInput(inputId = "p16b", label = " 
					How much time do you usually spend sitting or reclining on a typical day? (Minutes)",
					value =1))),
					

mainPanel(tags$head(
	  tags$style(type="text/css",
	".test_type {color: red;
                           font-size:12 px; 
                           font-style: italic;}",
      ".shiny-output-error {visibility: hidden;}",
      ".shiny-output-error:before {visibility: hidden;}")),
	tags$div(class="test_type"))
)),
		
			tabPanel("Results", br(),
			fluidPage(
mainPanel(tags$head(
	  tags$style(type="text/css",
	".test_type {color: red;
                           font-size:12 px; 
                           font-style: italic;}",
      ".shiny-output-error { visibility: hidden; }",
      ".shiny-output-error:before { visibility: hidden; }")),
	tags$div(class="test_type"),
	tabPanel('Results',align="center",
 plotlyOutput("plot1", height =400, width =400))))
)))),

			tabPanel("Population Level GPAQ (Weighted)",
			fluidPage(
			sidebarLayout(
       		sidebarPanel(
			fileInput(inputId = "file_inputter", label = "Microsoft Access MDB file"),
			
			selectInput(inputId = "Outcome", label = "Please choose the outcome variable", 
			choices =c("meet","percentwork","percenttrans","percentrec",
					"work","trans","rec","vig","ptotalCat")),

			 selectInput(inputId = "Group", label = "Please choose the grouping variable(s):
					For example: age4y, sex,or Urban/Rural(or ur)",
				choices =NULL),
			
			radioButtons(inputId="Facet",label = "Stratification variable:",
               			   choices=c("None","Age_categories"="age4y","Urban/Rural"="ur","Sex"="sex")),

			radioButtons(inputId="Levels",label = "Only when outcome is ptotalCat:",
               			   choices=c("High","Moderate","Low")),


			actionButton("do2", "Run")),

mainPanel(
	  tags$style(type="text/css",
      ".shiny-output-error { visibility: hidden; }",
      ".shiny-output-error:before { visibility: hidden; }"),
	tags$div(style="margin-bottom:50px;"),
	h2("Please Upload Microsoft Access MDB file"),
	tabPanel('Results',tableOutput('table2')),
 plotlyOutput("plot2", height =600, width =600))
)))
)
			





server = function(input, output,session) {
options(shiny.maxRequestSize=100*1024^2)


#Individual Level
data = reactive({
my_data=data.frame(p2=input$p2,p3a=input$p3a,
			p3b=input$p3b,p5=input$p5,p6a=input$p6a,
			p6b=input$p6b,p8=input$p8,p9a=input$p9a,
			p9b=input$p9b,p11=input$p11,p12a=input$p12a,
			p12b=input$p12b,p14=input$p14,p15a=input$p15a,
			p15b=input$p15b,p16a=input$p16a,p16b=input$p16b,valid=1,wstep1=1)

my_data$p1=1
my_data$p4=1
my_data$p7=1
my_data$p10=1
my_data$p13=1
my_data=data.frame(my_data)

data=gpaq(my_data)
data$meet=as.factor(substring(data$meet,2))
data$work=as.factor(substring(data$work,2))
data$trans=as.factor(substring(data$trans,2))
data$rec=as.factor(substring(data$rec,2))
data$vig=as.factor(substring(data$vig,2))
data$ptotalCat=as.factor(substring(data$ptotalCat,3))

Res=c("meet","ptotal","percentwork","percenttrans","percentrec",
		"work","trans","rec","vig","pworkday","ptravelday",
		"precday","ptotalday","ptotalCat")
data2=data[,Res]
data2=as.data.frame(data2)
data2[,c(3:5)]=paste(round(data2[,c(3:5)],4)*100,"%")
data2[,c(10:13)]=round(data2[,c(10:13)],2)


return(data2)
})


output$plot1 = renderPlotly({


df=setDT(data())
Names=c("Meet WHO recommendations",
	"Total Physical Activity Score","Percent of all activity from work-related activities",
		"Percent of all activity from transportation-related activities",
		"Percent of all activity from recreational activities",
		"Indicates whether or not respondent did any work-related activity",
		"Indicates whether or not respondent did any transport-related activity",
		"Indicates whether or not respondent did any recreationrelated activity",
		"Indicates whether or not respondent did any vigorous physical activity",
		"Average work-related activity per day in minutes",
		"Average transport related activity per day in minutes",
		"Average recreation related activity per day in minutes",
		"Sum of all activity per week divided by 7 to get avg. per day in minutes",
		"Total Physical Activity Score Category")

df=data.frame(Measures=Names,Results=t(df))
  summary_statistics = tableGrob(
    df,
    theme = ttheme_default(
      base_size =14,
      base_colour = "grey25",
      parse = T
      ),
    rows = NULL
    )

value=as.numeric(df[2,2])
fig <- plot_ly(
domain = list(x = c(0,roundUp(value)), y = c(0,roundUp(value))),
value = value,
title = list(text="Total Physical Activity Score\n(WHO Recommendations is above 600)"),
type = "indicator",
mode = "gauge+number+delta",
delta= list(reference=600),
gauge= list(

axis = list(range= list(0,roundUp(value)),tick0=0,dtick=200,tickwidth=1, tickcolor="white"),
bar = list(color= "blue",tickwidth=2),
steps = list(
      list(range = c(0, 599), color = "red"),
	list(range = c(600,1200), color = "yellow"),
	list(range = c(1201,roundUp(value)), color = "lightgreen"))
))
fig = fig%>%
layout(
margin =list(l=50,r=50),
font = list(color="Black", family ="Arial"))

fig

})



#Population Level
Popdata = reactive({
    inFile = input$file_inputter
    if (is.null(inFile)) return(NULL)
   channel= odbcConnectAccess(inFile$datapath)

Popdata1=sqlFetch(channel,"data1",as.is=T)
Popdata2=sqlFetch(channel,"data2",as.is=T)
my_Popdata=data.frame(merge(Popdata1,Popdata2, by="QR"))
names(my_Popdata)=tolower(names(my_Popdata))

my_Popdata$age4y=NA
	my_Popdata$age4y[18<=my_Popdata$age & my_Popdata$age<=29]="18-29"
	my_Popdata$age4y[30<=my_Popdata$age & my_Popdata$age<=44]="30-44"
	my_Popdata$age4y[45<=my_Popdata$age & my_Popdata$age<=59]="45-59"
	my_Popdata$age4y[60<=my_Popdata$age & my_Popdata$age<=69]="60-69"
Data=gpaq(my_Popdata)
Data1=data.frame(Data)

})


observe({
  
    # Change values for columns 
    s_options = as.list(colnames(Popdata()))
	updateSelectInput(inputId = "Group", choices = s_options)
  	})


observeEvent(input$do2,{

if(Popdata()==NULL){
      sendSweetAlert(
        session = session,
        title = "Error...",
        text = "Please Upload Microsoft Access MDB file",
        type = "error")
} else {
output$plot2<- renderPlotly({

if(input$Facet=="None" & input$Outcome=="meet"){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group))

R=As_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_meet")
Names=R[,1]
Average=R[,2]*100
LCI=as.numeric(substr(R[,3],1,5))
UCI=as.numeric(substr(R[,3],8,12))
Res=data.frame(factor(Names),Average,LCI=LCI*100,UCI=UCI*100)
names(Res)[1]="Groups"

P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The proportion of people who do not\n meet the WHO recommendations")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

ggplotly(P)

}else if(input$Facet!="None" & input$Outcome=="meet"){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group,"+",input$Facet))
R=As_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_meet")
Names=R[,1]
Average=R[,2]*100
LCI=as.numeric(substr(R[,3],1,5))
UCI=as.numeric(substr(R[,3],8,12))
Res=data.frame(factor(Names),Average,LCI=LCI*100,UCI=UCI*100)
names(Res)[1]="Groups"

P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The proportion of people who do not\n meet the WHO recommendations")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))


ggplotly(P) 

}else if(input$Facet=="None" & (input$Outcome %in% c("percentwork","percenttrans","percentrec"))){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group))

R=As_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_composition")
Names=R[,1]
Average=R[,2]*100
LCI=as.numeric(substr(R[,3],1,5))
UCI=as.numeric(substr(R[,3],8,12))
Res=data.frame(factor(Names),Average,LCI=LCI*100,UCI=UCI*100)
names(Res)[1]="Groups"

if(input$Outcome=="percentwork"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The average of all activity \n from work-related activities")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

}else if(input$Outcome=="percenttrans"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The average of all activity \n from transportation-related activities")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

}else if(input$Outcome=="percentrec"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The average of all activity \n from recreational activities")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))
}

ggplotly(P)

}else if(input$Facet!="None" & (input$Outcome %in% c("percentwork","percenttrans","percentrec"))){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group,"+",input$Facet))

R=As_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_composition")
Names=R[,1]
Average=R[,2]*100
LCI=as.numeric(substr(R[,3],1,5))
UCI=as.numeric(substr(R[,3],8,12))
Res=data.frame(factor(Names),Average,LCI=LCI*100,UCI=UCI*100)
names(Res)[1]="Groups"

if(input$Outcome=="percentwork"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The average of all activity \n from work-related activities")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

}else if(input$Outcome=="percenttrans"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The average of all activity \n from transportation-related activities")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

}else if(input$Outcome=="percentrec"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The average of all activity \n from recreational activities")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))
}

ggplotly(P)

}else if(input$Facet=="None" & (input$Outcome %in% c("work","trans","rec"))){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group))

R=As_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_activity")
Names=R[,1]
Average=R[,2]*100
LCI=as.numeric(substr(R[,3],1,5))
UCI=as.numeric(substr(R[,3],8,12))
Res=data.frame(factor(Names),Average,LCI=LCI*100,UCI=UCI*100)
names(Res)[1]="Groups"

if(input$Outcome=="work"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("he proportion of people who \n did no work related activity")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

}else if(input$Outcome=="trans"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The proportion of people who \n did no transport related activity")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

}else if(input$Outcome=="rec"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The proportion of people who \n did no recreation related activity")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))
}

ggplotly(P)

}else if(input$Facet!="None" & (input$Outcome %in% c("work","trans","rec"))){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group,"+",input$Facet))

R=As_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_activity")
Names=R[,1]
Average=R[,2]*100
LCI=as.numeric(substr(R[,3],1,5))
UCI=as.numeric(substr(R[,3],8,12))
Res=data.frame(factor(Names),Average,LCI=LCI*100,UCI=UCI*100)
names(Res)[1]="Groups"

if(input$Outcome=="work"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("he proportion of people who \n did no work related activity")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

}else if(input$Outcome=="trans"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The proportion of people who \n did no transport related activity")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))

}else if(input$Outcome=="rec"){
P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The proportion of people who \n did no recreation related activity")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))
}

ggplotly(P)%>%
  layout(autosize =TRUE, width = 500, height = 500)

}else if(input$Facet=="None" & input$Outcome=="vig"){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group))

R=As_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_vigorous")
Names=R[,1]
Average=R[,2]*100
LCI=as.numeric(substr(R[,3],1,5))
UCI=as.numeric(substr(R[,3],8,12))
Res=data.frame(factor(Names),Average,LCI=LCI*100,UCI=UCI*100)
names(Res)[1]="Groups"

P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The proportion of people who \n did no recreation related activity")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))
ggplotly(P)

}else if(input$Facet!="None" & input$Outcome=="vig"){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group,"+",input$Facet))
R=As_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_vigorous")
Names=R[,1]
Average=R[,2]*100
LCI=as.numeric(substr(R[,3],1,5))
UCI=as.numeric(substr(R[,3],8,12))
Res=data.frame(factor(Names),Average,LCI=LCI*100,UCI=UCI*100)
names(Res)[1]="Groups"

P = ggplot(data=Res, aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
	geom_point()+ 
	geom_errorbarh(height=.1)+
	geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
	scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
	theme_minimal()+ggtitle("The proportion of people who \n did no recreation related activity")+
	theme(text=element_text(family="Times",size=12, color="black"))+
	theme(panel.spacing = unit(1, "lines"))
ggplotly(P)

}else if(input$Facet=="None" & input$Outcome=="ptotalCat" & input$Levels=="High"){

Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group))
R1=PtotalCat_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_ptotal")

Names=R1[,1]
Ave1=R1[,2]*100
LCI1=as.numeric(substr(R1[,3],1,5))
UCI1=as.numeric(substr(R1[,3],8,12))
T1="The proportion of people in High level of physical activity"

Ave2=R1[,4]*100
LCI2=as.numeric(substr(R1[,5],1,5))
UCI2=as.numeric(substr(R1[,5],8,12))
T2="The proportion of people in Moderate level of physical activity"

Ave3=R1[,6]*100
LCI3=as.numeric(substr(R1[,7],1,5))
UCI3=as.numeric(substr(R1[,7],8,12))
T3="The proportion of people in Low level of physical activity"

Res=data.frame(factor(Names),Average=as.numeric(rbind(Ave1,Ave2,Ave3)),
			LCI=as.numeric(rbind(LCI1*100,LCI2*100,LCI3*100)),
			UCI=as.numeric(rbind(UCI1*100,UCI2*100,UCI3*100)),
			Level=factor(rep(c("High","Moderate","Low"),each=length(Names))))
names(Res)[1]="Groups"

 P = ggplot(data=subset(Res,Res$Level=="High"), aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
 geom_point()+ 
 geom_errorbarh(height=.1)+
 geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
 scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
 theme_minimal()+ggtitle("The proportion of people \n at high level of physical activity")+
 theme(text=element_text(family="Times",size=12, color="black"))+
 theme(panel.spacing = unit(1, "lines"))
ggplotly(P)
}

else if(input$Facet=="None" & input$Outcome=="ptotalCat" & input$Levels=="Moderate")
{

Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group))
R1=PtotalCat_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_ptotal")

Names=R1[,1]
Ave1=R1[,2]*100
LCI1=as.numeric(substr(R1[,3],1,5))
UCI1=as.numeric(substr(R1[,3],8,12))
T1="The proportion of people in High level of physical activity"

Ave2=R1[,4]*100
LCI2=as.numeric(substr(R1[,5],1,5))
UCI2=as.numeric(substr(R1[,5],8,12))
T2="The proportion of people in Moderate level of physical activity"

Ave3=R1[,6]*100
LCI3=as.numeric(substr(R1[,7],1,5))
UCI3=as.numeric(substr(R1[,7],8,12))
T3="The proportion of people in Low level of physical activity"

Res=data.frame(factor(Names),Average=as.numeric(rbind(Ave1,Ave2,Ave3)),
			LCI=as.numeric(rbind(LCI1*100,LCI2*100,LCI3*100)),
			UCI=as.numeric(rbind(UCI1*100,UCI2*100,UCI3*100)),
			Level=factor(rep(c("High","Moderate","Low"),each=length(Names))))
names(Res)[1]="Groups"

 P = ggplot(data=subset(Res,Res$Level=="Moderate"), aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
 geom_point()+ 
 geom_errorbarh(height=.1)+
 geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
 scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
 theme_minimal()+ggtitle("The proportion of people \n at moderate level of physical activity")+
 theme(text=element_text(family="Times",size=12, color="black"))+
 theme(panel.spacing = unit(1, "lines"))
ggplotly(P)
}

else if(input$Facet=="None" & input$Outcome=="ptotalCat" & input$Levels=="Low")
{

Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group))
R1=PtotalCat_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_ptotal")

Names=R1[,1]
Ave1=R1[,2]*100
LCI1=as.numeric(substr(R1[,3],1,5))
UCI1=as.numeric(substr(R1[,3],8,12))
T1="The proportion of people in High level of physical activity"

Ave2=R1[,4]*100
LCI2=as.numeric(substr(R1[,5],1,5))
UCI2=as.numeric(substr(R1[,5],8,12))
T2="The proportion of people in Moderate level of physical activity"

Ave3=R1[,6]*100
LCI3=as.numeric(substr(R1[,7],1,5))
UCI3=as.numeric(substr(R1[,7],8,12))
T3="The proportion of people in Low level of physical activity"

Res=data.frame(factor(Names),Average=as.numeric(rbind(Ave1,Ave2,Ave3)),
			LCI=as.numeric(rbind(LCI1*100,LCI2*100,LCI3*100)),
			UCI=as.numeric(rbind(UCI1*100,UCI2*100,UCI3*100)),
			Level=factor(rep(c("High","Moderate","Low"),each=length(Names))))
names(Res)[1]="Groups"

 P = ggplot(data=subset(Res,Res$Level=="Low"), aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
 geom_point()+ 
 geom_errorbarh(height=.1)+
 geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
 scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
 theme_minimal()+ggtitle("The proportion of people \n at low level of physical activity")+
 theme(text=element_text(family="Times",size=12, color="black"))+
 theme(panel.spacing = unit(1, "lines"))
ggplotly(P)

}else if(input$Facet!="None" & input$Outcome=="ptotalCat" & input$Levels=="High"){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group,"+",input$Facet))

R1=PtotalCat_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_ptotal")
Names=R1[,1]
Ave1=R1[,2]*100
LCI1=as.numeric(substr(R1[,3],1,5))
UCI1=as.numeric(substr(R1[,3],8,12))
T1="The proportion of people in High level of physical activity"

Ave2=R1[,4]*100
LCI2=as.numeric(substr(R1[,5],1,5))
UCI2=as.numeric(substr(R1[,5],8,12))
T2="The proportion of people in Moderate level of physical activity"

Ave3=R1[,6]*100
LCI3=as.numeric(substr(R1[,7],1,5))
UCI3=as.numeric(substr(R1[,7],8,12))
T3="The proportion of people in Low level of physical activity"


Res=data.frame(factor(Names),Average=as.numeric(rbind(Ave1,Ave2,Ave3)),
			LCI=as.numeric(rbind(LCI1*100,LCI2*100,LCI3*100)),
			UCI=as.numeric(rbind(UCI1*100,UCI2*100,UCI3*100)),
			Level=factor(rep(c("High","Moderate","Low"),each=length(Names))))
names(Res)[1]="Groups"


 P = ggplot(data=subset(Res,Res$Level=="High"), aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
 geom_point()+ 
 geom_errorbarh(height=.1)+
 geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
 scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
 theme_minimal()+ggtitle("The proportion of people \n at high level of physical activity")+
 theme(text=element_text(family="Times",size=12, color="black"))+
 theme(panel.spacing = unit(1, "lines"))
ggplotly(P)

}else if(input$Facet!="None" & input$Outcome=="ptotalCat" & input$Levels=="Moderate"){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group,"+",input$Facet))

R1=PtotalCat_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_ptotal")
Names=R1[,1]
Ave1=R1[,2]*100
LCI1=as.numeric(substr(R1[,3],1,5))
UCI1=as.numeric(substr(R1[,3],8,12))
T1="The proportion of people in High level of physical activity"

Ave2=R1[,4]*100
LCI2=as.numeric(substr(R1[,5],1,5))
UCI2=as.numeric(substr(R1[,5],8,12))
T2="The proportion of people in Moderate level of physical activity"

Ave3=R1[,6]*100
LCI3=as.numeric(substr(R1[,7],1,5))
UCI3=as.numeric(substr(R1[,7],8,12))
T3="The proportion of people in Low level of physical activity"


Res=data.frame(factor(Names),Average=as.numeric(rbind(Ave1,Ave2,Ave3)),
			LCI=as.numeric(rbind(LCI1*100,LCI2*100,LCI3*100)),
			UCI=as.numeric(rbind(UCI1*100,UCI2*100,UCI3*100)),
			Level=factor(rep(c("High","Moderate","Low"),each=length(Names))))
names(Res)[1]="Groups"


 P = ggplot(data=subset(Res,Res$Level=="Moderate"), aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
 geom_point()+ 
 geom_errorbarh(height=.1)+
 geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
 scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
 theme_minimal()+ggtitle("The proportion of people \n at moderate level of physical activity")+
 theme(text=element_text(family="Times",size=12, color="black"))+
 theme(panel.spacing = unit(1, "lines"))
ggplotly(P)

}else if(input$Facet!="None" & input$Outcome=="ptotalCat" & input$Levels=="Low"){
Y=as.formula(paste0("~",input$Outcome))
X=as.formula(paste0("~",input$Group,"+",input$Facet))

R1=PtotalCat_svy_mean(Y,X,Data=Popdata(),id=psu,weights=wstep1,strata =stratum,CLN="cln_ptotal")
Names=R1[,1]
Ave1=R1[,2]*100
LCI1=as.numeric(substr(R1[,3],1,5))
UCI1=as.numeric(substr(R1[,3],8,12))
T1="The proportion of people in High level of physical activity"

Ave2=R1[,4]*100
LCI2=as.numeric(substr(R1[,5],1,5))
UCI2=as.numeric(substr(R1[,5],8,12))
T2="The proportion of people in Moderate level of physical activity"

Ave3=R1[,6]*100
LCI3=as.numeric(substr(R1[,7],1,5))
UCI3=as.numeric(substr(R1[,7],8,12))
T3="The proportion of people in Low level of physical activity"


Res=data.frame(factor(Names),Average=as.numeric(rbind(Ave1,Ave2,Ave3)),
			LCI=as.numeric(rbind(LCI1*100,LCI2*100,LCI3*100)),
			UCI=as.numeric(rbind(UCI1*100,UCI2*100,UCI3*100)),
			Level=factor(rep(c("High","Moderate","Low"),each=length(Names))))
names(Res)[1]="Groups"


 P = ggplot(data=subset(Res,Res$Level=="Low"), aes(y=Groups, x=Average, xmin=LCI, xmax=UCI,color=Groups))+
 geom_point()+ 
 geom_errorbarh(height=.1)+
 geom_vline(xintercept=0, color="black", linetype="dashed", alpha=.5)+
 scale_x_continuous(limits=c(0,100), breaks=seq(0,100,10), name="Average")+
 theme_minimal()+ggtitle("The proportion of people \n at low level of physical activity")+
 theme(text=element_text(family="Times",size=12, color="black"))+
 theme(panel.spacing = unit(1, "lines"))
ggplotly(P)
}


})
}})
}

shinyApp(ui = ui, server = server)


}

