setwd("C:/Users/sadhamdh/Documents/R/specdata/")

pollutantmean<-function(directory,pollutant,id=1:332){
  dir<-c("specdata")
  pol<-c("sulfate","nitrate")
  total<-0
  sum_final<-0
  len<-length(id)
 
  common_path <- "C:/Users/sadhamdh/Documents/R/specdata/"
  file_list <- list.files(common_path)

  for (i in 1:length(file_list)){
    assign(file_list[i], 
     read.csv(paste(common_path, file_list[i], sep=''))
  )}

 
 if (directory==dir && pollutant==pol[1]){
    for (i in id){
      data<-read.csv(file_list[i])
      this_sum<-sum(data$sulfate, na.rm = TRUE)
      cur_mean<-mean(data$sulfate, na.rm = TRUE)
      no<-this_sum/cur_mean
      sum_final<-sum_final+this_sum
      total<-total+no
    }
    return(sum_final/total)
   }
   else
 if (directory==dir && pollutant==pol[2]){
    for (i in id){
      data<-read.csv(file_list[i])
      this_sum<-sum(data$nitrate, na.rm = TRUE)
      cur_mean<-mean(data$nitrate, na.rm = TRUE)
      no<-this_sum/cur_mean
      sum_final<-sum_final+this_sum
      total<-total+no
    }
    return(sum_final/total)
   }
}
