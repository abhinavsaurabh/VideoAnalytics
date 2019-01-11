library(ggplot2)
library(data.table)
data <- read.csv("/Users/Abhinav/Desktop/HPF/Avg bucket/metric.csv")
setDT(data)
data1<-  data[Show.Code == "IP2" |Show.Code == "IP11" |Show.Code == "IP15" |Show.Code == "IP19" | Show.Code == "IP25" | Show.Code == "IP38"]
data2<-  data[Show.Code == "IP7" |Show.Code == "IP12" |Show.Code == "IP16" |Show.Code == "IP20" | Show.Code == "IP28" ]
data3<-  data[Show.Code == "IP8" |Show.Code == "IP13" |Show.Code == "IP18" |Show.Code == "IP21" | Show.Code == "IP24" | Show.Code == "IP26" ]
data4<-  data[Show.Code == "IP6" |Show.Code == "IP23" |Show.Code == "IP29" |Show.Code == "IP31" | Show.Code == "IP6" | Show.Code == "IP39"]
data5<-  data[Show.Code == "IP10" |Show.Code == "IP14" |Show.Code == "IP17" |Show.Code == "IP22" | Show.Code == "IP30" |Show.Code == "IP40"| Show.Code=="IP42" ]
data6 <- data[Show.Code == "IP3" |Show.Code == "IP33" |Show.Code == "IP41" |Show.Code == "IP43"]

life <- data[Show.Code == "IP1"]

phm  <- data[Show.Code == "IP4"]
dedd <- data[Show.Code == "IP9"]
pr <- data[Show.Code == "IP5"]

setDT(data1)
setDT(data2)
setDT(data3)
setDT(data4)
setDT(data5)

setDT(life)
setDT(neha)
setDT(phm)
setDT(dedd)
setDT(pr)






data1$Release.Date <- as.Date(data1$Release.Date , "%d/%m/%y")
data2$Release.Date <- as.Date(data2$Release.Date , "%d/%m/%y")
data3$Release.Date <- as.Date(data3$Release.Date , "%d/%m/%y")
data4$Release.Date <- as.Date(data4$Release.Date , "%d/%m/%y")
data5$Release.Date <- as.Date(data5$Release.Date , "%d/%m/%y")

life$Release.Date <- as.Date(life$Release.Date , "%d/%m/%y")
neha$Release.Date <- as.Date(neha$Release.Date , "%d/%m/%y")
phm$Release.Date <- as.Date(phm$Release.Date , "%d/%m/%y")
dedd$Release.Date <- as.Date(dedd$Release.Date , "%d/%m/%y")
pr$Release.Date <- as.Date(pr$Release.Date , "%d/%m/%y")

pdf("/Users/Abhinav/Desktop/HPF/genre/graph123.pdf")
ggplot(life,aes(x=Release.Date,y=Average.watch.Time.af.5.,group = 1))+ geom_point() + geom_line()  + ggtitle("Life Guru") 
ggplot(neha,aes(x=Release.Date,y=Average.watch.Time.af.5.,group = 1))+ geom_point() + geom_line()  + ggtitle("Neha Kumari")
ggplot(phm,aes(x=Release.Date,y=Average.watch.Time.af.5.,group = 1))+ geom_point() + geom_line()  + ggtitle("Phicle Hafte Mein")
ggplot(dedd,aes(x=Release.Date,y=Average.watch.Time.af.5.,group = 1))+ geom_point()+ geom_line()  + ggtitle("De dana dan")
ggplot(pr,aes(x=Release.Date,y=Average.watch.Time.af.5.,group = 1))+ geom_point() + geom_line()  + ggtitle("Preeti")
dev.off()

pdf("/Users/Abhinav/Desktop/HPF/genre/graph.pdf")
ggplot(data1,aes(x=Release.Date,y=Average.watch.Time.af.5.,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line()  + ggtitle("Aarohe") 

ggplot(data2,aes(x=Release.Date,y=Average.watch.Time.af.5.,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("Bollywood Baaja")

ggplot(data3,aes(x=Release.Date,y=Average.watch.Time.af.5.,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("HPF")

ggplot(data4,aes(x=Release.Date,y=Average.watch.Time.af.5.,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("Jasmine")

ggplot(data5,aes(x=Release.Date,y=Average.watch.Time.af.5.,color =factor(Language),group = factor(Show.Code))) + geom_point()+ geom_line() + ggtitle("Mastiband")
dev.off()
