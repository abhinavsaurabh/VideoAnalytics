library(data.table)
data <- read.csv("/Users/Abhinav/Desktop/HPF/Avg bucket/Combine ALL ORDER1.csv")
#data = read.csv("~/Downloads/Combine New.csv")
setDT(data)
data[,avg:=rowMeans(data[, -c("Percentage.of.Video.Watched")])]
data2 <- data.table(ShowName=character(),episode=character(),diff1=double(),diff2=double())
setDT(data2)

VideoPerformance <- function(ch)
{
  sub <- data[, c(ch, "avg"),with = FALSE]
  #print(sub)
  sub[, cumavg := cumsum(avg)]
  sub[, cumavg := c(100, 100 - cumavg)]
  arr <- seq(0, 95, 5)
  
  
  sub[, cumIP := cumsum(get(ch)) ]
  sub[, cumIP := c(100, 100 - cumIP)]
  
  NormDiff <- function(z) {
    ans <- sapply(arr, function(x) {
      if(x==0){
        100*(1 - (z[x+5]/z[x+1]))
      }
      else if(x==95){
        100*(1 - (z[x+6]/z[x]))
      }
      else
        100*(1-(z[x+5]/z[x]))
      
    })
  }
  
  avg <- NormDiff(sub$cumavg) 
  IP <- NormDiff(sub$cumIP) 
  
  new <- data.table(index=seq(1, 20, 1),Avg = c(avg),  IP= c(IP))
  new[, diff := c(avg -IP)]
  cal<-  sum(new$diff)
  setDT(new)
  new2 <- new[1:(.N-2), ]
  cal2 <- sum(new2$diff)
  
  #For names in graph
  ch1 = unlist(strsplit(ch, split = "E"))[1]              # for IP names
  ch2 = unlist(strsplit(ch, split = "E"))[2]              # for Episode no.
  ch2 = paste0("E", ch2)                                  # E is removed so adding it again
  ch = paste(name_trans[ch1], ch2, sep = " : ",cal,cal2 )    
  
  
  library(ggplot2)
  p = ggplot(new,aes(x=index,y=diff)) + geom_point() + geom_line() +
    geom_vline(xintercept =0) + geom_hline(yintercept =0) + labs(title= ch)
  #print(p)
  p
}



Videodata <- function(ch)
{
  sub <- data[, c(ch, "avg"),with = FALSE]
  #print(sub)
  sub[, cumavg := cumsum(avg)]
  sub[, cumavg := c(100, 100 - cumavg)]
  arr <- seq(0, 95, 5)
  
  
  sub[, cumIP := cumsum(get(ch)) ]
  sub[, cumIP := c(100, 100 - cumIP)]
  
  
  sub[, cum2IP := cumsum(get(ch))]
  sub[,cum2IP := c(100 - cum2IP)]
  d<- sub[7:nrow(sub),sum(cum2IP)]/sub[7, (100*cum2IP)]
  
  NormDiff <- function(z) {
    ans <- sapply(arr, function(x) {
      if(x==0){
        100*(1 - (z[x+5]/z[x+1]))
      }
      else if(x==95){
        100*(1 - (z[x+6]/z[x]))
      }
      else
        100*(1-(z[x+5]/z[x]))
      
    })
  }
  
  avg <- NormDiff(sub$cumavg) 
  IP <- NormDiff(sub$cumIP) 
  
  
  new <- data.table(index=seq(1, 20, 1),Avg = c(avg),  IP= c(IP))
  new[, diff := c(avg -IP)]
  cal<-  sum(new$diff)
  setDT(new)
  new2 <- new[1:(.N-2), ]
  cal2 <- sum(new2$diff)
  
  #For names in graph
  ch1 = unlist(strsplit(ch, split = "E"))[1]              # for IP names
  ch2 = unlist(strsplit(ch, split = "E"))[2]              # for Episode no.
  ch2 = paste0("E", ch2)                                  # E is removed so adding it again
  data2 <<- rbind(data2, data.table(ShowName=name_trans[ch1],episode=ch2,diff1=cal,diff2=cal2))
}

metric <- data.table(ShowCode=character(),ShowName=character(),episode=character(),drop5=double(),Avg100=double(),Avg95 = double())
metriccal <- function(ch)
{
  x<-seq(0, 100, 1)
  y<- data[, get(ch)]
  y[is.na(y)] <- 0
  z <- crossprod(x,y)/100
  d <- sum(y[1:6])
  e <- crossprod(x[7:101],y[7:101])/(100-d)
  
  ch1 = unlist(strsplit(ch, split = "E"))[1]              # for IP names
  ch2 = unlist(strsplit(ch, split = "E"))[2]              # for Episode no.
  ch2 = paste0("E", ch2)                                  # E is removed so adding it again
  
  metric <<- rbind(metric, data.table(ShowCode = ch1,ShowName = name_trans[ch1],episode= ch2, drop5 = d, Avg100 = z[[1]][1], Avg95 = e[[1]][1]))
  
}

# 
cols = c(colnames(data[, -c("Percentage.of.Video.Watched","avg")]))

# lapply(cols, calc)
# 
# pdf("plots.pdf")
# lapply(cols, calc)
# dev.off()


showname = read.csv("/Users/Abhinav/Desktop/HPF/Avg bucket/Show Name1.csv", stringsAsFactors = FALSE)
name_trans = showname$Show.Name
names(name_trans) = showname$Show.Code

#cols = sapply(strsplit(cols, split = "E"), function(x) x[1])
# then modify 
# p = ggplot(new,aes(x=index,y=diff)) + geom_point() + geom_line() + labs(title = name_trans[ch])

# run following command to test the output
#lapply(cols[1:3], calc)

#pdf("/Users/Abhinav/Desktop/HPF/Avg/plots1.pdf")
#VideoPerformance('simran')
#dev.off()

pdf("/Users/Abhinav/Desktop/HPF/Avg/Avg5buck.pdf")
lapply(cols, VideoPerformance)
dev.off()
lapply(cols, Videodata)
write.csv(data2, file = "/Users/Abhinav/Desktop/HPF/Avg bucket/Perform.csv")
lapply(cols,metriccal)
write.csv(metric, file = "/Users/Abhinav/Desktop/HPF/Avg bucket/metric.csv")
