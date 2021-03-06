##Use my standard openning including call function
if (Sys.info()["sysname"]=="Linux"){
        source('/home/bryan/GitHub/MyWork/StdOpen.R')     
}else{
        source('C:/GitHub/MyWork/StdOpen.R')   
}

library(UsingR)

data(father.son)

x <- father.son$sheight
n <-length(x)
b <- 10000 ##Bootstrap number of samples 

resamples <- matrix(sample(x,n*b,replace=TRUE),b,n)

medians <-apply (resamples,1,median)

hist(medians,main = paste("Histogram of Medians of \n", b, "Bootstraps" ))
rug(medians)

abline(v=median(x),col="red")

sd(medians)

quantile(medians, c(.025,.975))

abline(v=quantile(medians, c(.025)),col="blue")
abline(v=quantile(medians, c(.975)),col="blue")
