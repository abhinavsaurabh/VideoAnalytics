library(ggplot2)
library(data.table)
data <- read.csv("/Users/Abhinav/Desktop/HPF/latest/metric.csv")
setDT(data)
data1<-  data[Show.Code == "IP2" |Show.Code == "IP11" |Show.Code == "IP15" |Show.Code == "IP19" | Show.Code == "IP25" |Show.Code == "IP37"| Show.Code == "IP38"]
data2<-  data[Show.Code == "IP7" |Show.Code == "IP12" |Show.Code == "IP16" |Show.Code == "IP20" | Show.Code == "IP28" ]
data3<-  data[Show.Code == "IP8" |Show.Code == "IP13" |Show.Code == "IP18" |Show.Code == "IP21" | Show.Code == "IP24" | Show.Code == "IP26" ]
data4<-  data[Show.Code == "IP6" |Show.Code == "IP23" |Show.Code == "IP29" |Show.Code == "IP31" | Show.Code == "IP33" | Show.Code == "IP39"]
data5<-  data[Show.Code == "IP10" |Show.Code == "IP14" |Show.Code == "IP17" |Show.Code == "IP22" | Show.Code == "IP30" |Show.Code == "IP40"| Show.Code=="IP42" ]
data6 <- data[Show.Code == "IP3" |Show.Code == "IP33" |Show.Code == "IP35" |Show.Code == "IP41" |Show.Code == "IP43"]


setDT(data1)
setDT(data2)
setDT(data3)
setDT(data4)
setDT(data5)



data1$Dates <- as.Date(data1$Dates , "%d/%m/%y")
data2$Dates <- as.Date(data2$Dates , "%d/%m/%y")
data3$Dates <- as.Date(data3$Dates , "%d/%m/%y")
data4$Dates <- as.Date(data4$Dates , "%d/%m/%y")
data5$Dates <- as.Date(data5$Dates , "%d/%m/%y")
data6$Dates <- as.Date(data6$Dates , "%d/%m/%y")




pdf("/Users/Abhinav/Desktop/HPF/latest/graph.pdf")
ggplot(data1,aes(x=Dates,y=Avg95,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line()  + ggtitle("Aarohe") +theme(legend.position="bottom")

ggplot(data2,aes(x=Dates,y=Avg95,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("Bollywood Baaja")+theme(legend.position="bottom")

ggplot(data3,aes(x=Dates,y=Avg95,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("HPF")+theme(legend.position="bottom")

ggplot(data4,aes(x=Dates,y=Avg95,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("Jasmine")+theme(legend.position="bottom")

ggplot(data5,aes(x=Dates,y=Avg95,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("Mastiband")+theme(legend.position="bottom")
ggplot(data6,aes(x=Dates,y=Avg95,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("Neha Kumari")+theme(legend.position="bottom")
dev.off()
