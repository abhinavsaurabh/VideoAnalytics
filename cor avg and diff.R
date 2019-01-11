library(data.table)
library(ggplot2)
data <- read.csv("/Users/Abhinav/Desktop/HPF/Avg bucket/Perform.csv")
setDT(data)

avg <- data$Avg5

d1 <- data$diff1
d2 <- data$diff2

cor(d1,x)
cor(d2,x)



cor(d1,avg)
cor(d2,avg)
pdf("/Users/Abhinav/Desktop/HPF/Avg/correlation/cor2.pdf")

ggplot(data,aes(x=diff2,y=avg)) + geom_point() + ggtitle("diff2 vs Avg")
ggplot(data,aes(x=diff1,y=avg)) + geom_point() + ggtitle("diff1 vs Avg")
dev.off()


