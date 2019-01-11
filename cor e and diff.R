library(data.table)
library(ggplot2)
data <- read.csv("/Users/Abhinav/Desktop/HPF/Avg/Perform E EW.csv")
setDT(data)
x <- data$Engagement
xw <- data$EngagementWT


d1 <- data$diff1
d2 <- data$diff2

cor(d1,x)
cor(d2,x)

cor(d1,xw)
cor(d2,xw)


pdf("/Users/Abhinav/Desktop/HPF/Avg/correlation/cor.pdf")
ggplot(data,aes(x=diff1,y=Engagement)) + geom_point() + ggtitle("diff1 vs engagement")
ggplot(data,aes(x=diff2,y=Engagement)) + geom_point() + ggtitle("diff2 vs engagement")
ggplot(data,aes(x=diff1,y=EngagementWT)) + geom_point() + ggtitle("diff1 vs engagementWT")
ggplot(data,aes(x=diff2,y=EngagementWT)) + geom_point() + ggtitle("diff2 vs engagementWT")

dev.off()



#diff1E <- data %>%
#  filter(diff1 > 75) %>%
 # filter(Engagement <0.01)


#diff2E <- data %>%
#  filter(diff2 > 75) %>%
 # filter(Engagement <0.01)



#diff1EW <- data %>%
#  filter(diff1 > 75) %>%
#  filter(EngagementWT <0.01)


#diff2EW <- data %>%
  #filter(diff2 > 75) %>%
  #filter(EngagementWT <0.01)


data[diff1>75 & Engagement<0.01]
data[diff2>75 & Engagement<0.01]
data[diff1>75 & EngagementWT<0.01]

data[diff2< -100 & Engagement<0.01]


data[Engagement>0.04]
