setwd("C:/Users/sadhamdh/Documents/R/specdata/")

complete<-function(directory,id=1:332){
  dir<-c("specdata")
  len<-length(id)
  nobs<-c()
  no<-0
 
  common_path <- "C:/Users/sadhamdh/Documents/R/specdata/"
  file_list <- list.files(common_path)

  for (i in 1:length(file_list)){
    assign(file_list[i], 
     read.csv(paste(common_path, file_list[i], sep=''))
  )}

 
 if (directory==dir ){
    for (i in id){
      no<-0
      data<-read.csv(file_list[i])
      count<-nrow(data)
      for (j in 1:count){
         if( !is.na(data$sulfate[j]) && !is.na(data$nitrate[j])){
         no<-no+1
        }
      }
      nobs<-c(nobs,no)
    }
    df<-data.frame(id,nobs)
    return(df)
   }
   
}
