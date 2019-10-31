setwd("C:/Users/sadhamdh/Documents/R/specdata/")

corr<-function(directory,threshold=0){
  cor_vec <-c()

  common_path <- "C:/Users/sadhamdh/Documents/R/specdata/"
  file_list <- list.files(common_path)

  for (i in 1:length(file_list)){
    assign(file_list[i], 
     read.csv(paste(common_path, file_list[i], sep=''))
  )}
   
   output<-complete("specdata")
   for (i in output$id){
       if (output$nobs[i]>threshold){
          sulf<-c()
          nit<-c()
          data<-read.csv(file_list[i])
          count<-nrow(data)
          for (j in 1:count){
            if( !is.na(data$sulfate[j]) && !is.na(data$nitrate[j])){
               sulf<-c(sulf,data$sulfate[j])
               nit<-c(nit,data$nitrate[j])
              }
           }
          cor_value<-cor(sulf,nit,use = "complete.obs")
          cor_vec<-c(cor_vec,cor_value)
        }
     }
     return(cor_vec)
}
