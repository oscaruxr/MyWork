##Clear the environment
##Use my standard openning including call function
if (Sys.info()["sysname"]=="Linux"){
  source('/home/bryan/GitHub/MyWork/StdOpen.R')     
}else{
  source('C:/GitHub/MyWork/StdOpen.R')   
}

##Set printing to 1 row of 3 columns
par(mfrow=c(1,3))

##Create the data Three attributes
nbr = 100 ##Number of observations for each group
nbrgrp = 3 ##Number of clusters for K-Means

##Speed
s1<- rnorm(nbr,70,15)
s2<- rnorm(nbr,90,6)
s3<- rnorm(nbr,20,4)
speed<-c(s1,s2,s3)
rm(s1,s2,s3)

##Cycles
c1<- rbinom(nbr,3,.6)
c2<- rbinom(nbr,3,.4)
c3<- rbinom(nbr,3,.8)
cycle<-c(c1,c2,c3)
rm(c1,c2,c3)

##Wear
w1<- rchisq(nbr,5)
w2<- rchisq(nbr,4)
w3<- rchisq(nbr,7)
wear<-c(w1,w2,w3)
rm(w1,w2,w3)

##Establish Group Numbers
group<- c(rep(1,100),rep(2,100), rep(3,100))

##Make a dataframe
df <-data.frame(speed=speed, cycle=cycle, wear=wear, group=group)
rm(speed,cycle,wear)

##View means of speed, cycle, and wear
aggregate(. ~ group, data = df, mean)

##View sd of speed, cycle, and wear
aggregate(. ~ group, data = df, sd)

##View correlation matrix (not including group variable)
cor(df[,-4])

##View boxplots
boxplot(speed~group, data=df, main="Speed", xlab="Group")
boxplot(cycle~group, data=df, main="Cycle", xlab="Group")
boxplot(wear~group, data=df, main="Wear", xlab="Group")

##K-Means Cluster (not including the group column)
cl <-kmeans(df[,-4],nbrgrp)

## Compare Group to Cluster assigned using adjusted rank index
## The adjusted Rand index provides a measure of the agreement between two partitions, adjusted for chance. 
## It ranges from -1 (no agreement) to 1 (perfect agreement). 
errortable<-table(df[,4],cl$cluster)
randIndex(errortable)

##Plot the values of speed, cycle, and wear colored by cluster
plot(df[,1], col=cl$cluster,main="Speed",)
abline(v=c(nbr,nbr+nbr))

plot(df[,2], col=cl$cluster, main="Cycle")
abline(v=c(nbr,nbr+nbr))
       
plot(df[,3], col=cl$cluster, main="Wear")
abline(v=c(nbr,nbr+nbr))
 
##Reset to one row row column
par(mfrow=c(1,1))

##
plotcluster(df, cl$cluster)

##Cluster plot
clusplot(df, cl$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

##Pairs graph
with(df, pairs(df[,-4], col=c(1:3)[cl$cluster])) 
