library(data.table)
bb <- read.csv('/Users/Abhinav/Desktop/HPF/OLD DATA/1. 31668681_BB.csv')
setDT(bb)
final_data <- data.table(percent = c(seq(0, 100, 1)))
DropoffDataStream <- function(dt, pid) {
  p <- dt[, .(Count, percent)]
  final_data <<- p[final_data, on = "percent"]
  setnames(final_data, "Count", as.character(pid[1]))
  return(pid[1])
}
pid <- bb[, DropoffDataStream(.SD, .BY), postid]

#percentconvert <- function(ch)
#{
  # d <- sum(final_data[, get(ch)], na.rm = TRUE)
  #  (final_data[,get(ch)])
  # final_data[final_data[,get(ch)]/colSums(get(ch),na.rm = TRUE)]
   
#}

#res = t(as.matrix(final_data[, -c("percent")])) / colSums(final_data[, -c("percent")], na.rm = TRUE)

res2 = apply(final_data[, -c("percent")], 2, function(x){
  x / sum(x, na.rm = TRUE) * 100
})

final <- as.data.table(res2)
final <- data.table(PercentageofVideo=seq(0, 100, 1),final)
write.csv(res2, file = "/Users/Abhinav/Desktop/HPF/OLD DATA/New form/1. 31668681_BB.csv")


metric <- data.table(POSTID=character(),drop5=double(),Avg100=double(),Avg95 = double())
setDT(metric)
metriccal <- function(ch)
{
  x<-seq(0, 100, 1)
  y<- final[, get(ch)]
  y[is.na(y)] <- 0
   z <- crossprod(x,y)/100
   d <- sum(y[1:6])
   e <- crossprod(x[7:101],y[7:101])/(100-d)
   metric <<- rbind(metric, data.table(POSTID = ch, drop5 = d, Avg100 = z[[1]][1], Avg95 = e[[1]][1]))
  print(z)
}

cols = c(colnames(final[, -c("PercentageofVideo")]))
lapply(cols,metriccal)

#cols = c(colnames(final_data[, -c("percent")]))

#lapply(cols,percentconvert)
