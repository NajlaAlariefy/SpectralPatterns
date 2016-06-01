#' Pattern Detection of Single Spectra on their Multi-components
#'
#' This function will take in a set of spectra (single components, and their respective multi-components) and return patterns detected based on correlation results of three extracted features (means, variance, and turn-points).
#' @param spectra takes in a dataframe of spectra, this version accepts three-bases only. They should be organized as follows: C1, C2, C3, C1+C2, C1+C3, C2+C3, C1+C2+C3 
#' @keywords spectra, pattern detection, correlation
#' @export
#' @examples
#' cat_function()

spectralPatterns <- function(spectra)
{
library(reshape2)
library(ggplot2)
d <- spectra
rownames(d) <- gsub("X", "", rownames(d))
cnames <- c('C3 + C1','C3','C2 + C3','C2','C1 + C2 + C3','C1 + C2','C1')
cnames <- cnames[c(7,4,2,6,1,3,5)]
colnames(d) <- cnames
d <- d[-14519,]
asNumeric <- function(x) as.numeric(as.character(x))
factorsNumeric <- function(d) modifyList(d, lapply(d[, sapply(d, is.factor)],    asNumeric))
d <- factorsNumeric(d)
d <- d[,1:7] + 0.01865
shifted <- d 
x0 = 500
xx <- seq(x0, 4000, 0.24108)
xx[14518] <- 4000
d$x = as.double(as.character(xx[1:14518]))
d.m = melt(d, id.var= "x")
 
 
means <- matrix(, nrow = 426, ncol = 7)
colnames(means) <- c("C1","C2","C3","C1 + C2","C3 + C1","C2 + C3", "C1 + C2 + C3")
for (i in 1:426)
{
        means[i,1] <- mean(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),1])
        means[i,2] <- mean(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),2])
        means[i,3] <- mean(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),3])
        means[i,4] <- mean(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),4])
        means[i,5] <- mean(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),5])
        means[i,6] <- mean(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),6] )                  
        means[i,7] <- mean(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),7]  )              
}   
vars <- matrix(, nrow = 426, ncol = 7)
colnames(vars) <- c("C1","C2","C3","C1 + C2","C3 + C1","C2 + C3", "C1 + C2 + C3")
for (i in 1:426)
{
        vars[i,1] <- var(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),1])
        vars[i,2] <- var(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),2])
        vars[i,3] <- var(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),3])
        vars[i,4] <- var(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),4])
        vars[i,5] <- var(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),5])
        vars[i,6] <- var(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),6])                  
        vars[i,7] <- var(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),7])              
}  
library('pastecs')
turnpoints <- matrix(, nrow = 426, ncol = 7)
colnames(turnpoints) <- c("C1","C2","C3","C1 + C2","C3 + C1","C2 + C3", "C1 + C2 + C3")

for (i in 1:426)
{
        turnpoints[i,1] <- turnpoints(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),1])$nturns
        turnpoints[i,2] <- turnpoints(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),2])$nturns
        turnpoints[i,3] <- turnpoints(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),3])$nturns
        turnpoints[i,4] <- turnpoints(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),4])$nturns
        turnpoints[i,5] <- turnpoints(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),5])$nturns
        turnpoints[i,6] <- turnpoints(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),6])$nturns                 
        turnpoints[i,7] <- turnpoints(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),7])$nturns             
}
t1 <- MulticomponentAnalysisXC(turnpoints,5,0.7,shifted,1)
m2 <- MulticomponentAnalysisXC(means,5,0.7,shifted)
v2 <- MulticomponentAnalysisXC(vars,5,0.7,shifted)


combination(m2,v2,t1)
}
MulticomponentAnalysisXC <- function(features, window, threshold, data, t = 0)
{
        #creating an empty dataframe
        d <- as.data.frame(setNames(replicate(3,numeric(0), simplify = F), c('C1','C2', 'C3')))
        
        #creating correlation vectors based on window size
        for (i in 1:(nrow(features)/window))
        {
                for (ii in 1:3)
                {
                        xc <- ccf(features[((i-1)*window):((i-1)*window +window),ii],features[((i-1)*window):((i-1)*window +window),7], plot=FALSE)
                        d[i,ii] <-  xc$acf[xc$lag ==0] #taking correlation at lag 0
                }
        }
        #taking only the maximum value of correlation
        d[,4] <- colnames(d)[apply(d,1,which.max)]
        
        
        #If the differences between the correlation values exceed the threshold, label them differently
        for (i in 1:nrow(d))
        {
                if (abs(d[i,1]- d[i,2] ) <= threshold && ( d[i,1] == max(d[i,1:3]) ||  d[i,2] == max(d[i,1:3])))
                        d[i,4] <- c('C1 + C2')  
                if (abs(d[i,2]- d[i,3] ) <= threshold  && ( d[i,2] == max(d[i,1:3]) ||  d[i,3] == max(d[i,1:3])))
                        d[i,4] <- c('C2 + C3')  
                if (abs(d[i,1]- d[i,3] ) <= threshold  && ( d[i,1] == max(d[i,1:3]) ||  d[i,3] == max(d[i,1:3])))
                        d[i,4] <- c('C1 + C3')  
                if (abs(d[i,1]- d[i,2] ) <= threshold && abs(d[i,1]- d[i,3] ) <= threshold && abs(d[i,3]- d[i,2] ) <= threshold)
                        d[i,4] <- c('All')  
        }
        
        #iterate through the labels we added, and choose only one of the two best. (It could be removed if the section above is)
        d <- iterate(features, d,window)
        
        #creating a dataframe for plotting
        #adding a label column, and a column for the windowed multicomponent
        featurescc <- as.data.frame(features[,6:7])
        colnames(featurescc) <- c('Label', 'Multicomponent')
        for (i in 1:nrow(d))
        {
                for (ii in 1:window)
                        featurescc[((i-1)*window) + ii,1] <- d[i,4]
        }
        
        if (nrow(featurescc) > (((nrow(d)-1)*window) + window))
                for(i in (((nrow(d)-1)*window) + window):nrow(featurescc)) 
                        featurescc[i,1] <- d[nrow(d),4]
        featurescc[,1] <- as.factor(featurescc[,1])
        
        if (t == 0)
        {
                
                featurescc[,2] <- featurescc[nrow(featurescc):1,2]
        }
        featurescc[,1] <- featurescc[nrow(featurescc):1,1]
        featurescc[,3] <- 1:nrow(featurescc)  
        
        # for (i in 1:426)
        #        {join[i,7] <- mean(shifted[(((i-1)*68)-((i-1)*34)):((((i-1)*68)-((i-1)*34)) +68),7]}
        
        join <- data[,6:7]
        colnames(join) <- c('Label', 'Multicomponent')
        join[,1] <- c('All')
        
        for (i in 1:nrow(featurescc))
        {
                for (ii in 0:34)
                        join[((i-1)*34) + ii,1] <- as.character(featurescc[i,1])
        }
        
        if (t ==0)
                join[,1] <- join[nrow(join):1,1]
        join[,1] <- as.factor(join[,1])        
        join[,2] <- join[nrow(join):1,2]
        join[,3] <- 1:nrow(join)  
        library(ggplot2)
        # ggplot(featurescc, aes(V3,Multicomponent,  xlab = "", ylab= "")) + geom_line() + geom_point(data=featurescc, aes(V3,Multicomponent, colour=Label),size=3)+ xlab("") + ylab("") +  scale_colour_manual(values =c('yellow', 'black', 'blue', 'red','purple','blue', 'red')) +  guides(colour = guide_legend(override.aes = list(size=8))) 
        for (i in 1:nrow(featurescc))
        {featurescc[i,4] <- featurescc[i,3] * 34
         # featurescc[i,2] <- join[featurescc[i,4] *34,2]
        }
        names(featurescc)[[4]] <- c('index')
        title <- c("Means for ",as.character(window), "windows.")
        g<- ggplot(join, aes(V3,Multicomponent,  xlab = "", ylab= "")) + geom_line() +
                geom_point(data=join, aes(V3,Multicomponent, colour=Label),size=2) + xlab("") + ylab("") +scale_colour_grey() + theme_bw() +  guides(colour = guide_legend(override.aes = list(size=8)))  +   ggtitle(title) + 
                theme(plot.title = element_text(lineheight=.8,size=12, fC2="bold"))
        
        print(g)
        join
}  

iterate <- function(features,d,window)
{
        dd <- as.data.frame(setNames(replicate(3,numeric(0), simplify = F), c('C1 + C2','C1 + C3', 'C2 + C3')))
        for (i in 1:(nrow(features)/window))
        {
                if (d[i,4] == c('C2 + C3') )
                {  
                        xc1 <- ccf(features[((i-1)*window):((i-1)*window +window),2],features[((i-1)*window):((i-1)*window +window),6], plot=FALSE)
                        xc2 <-ccf(features[((i-1)*window):((i-1)*window +window),3],features[((i-1)*window):((i-1)*window +window),6], plot=FALSE)
                        
                        if ( xc1$acf[xc1$lag ==0] < xc2$acf[xc2$lag ==0])
                                d[i,4] <- c('C3')
                        else
                                d[i,4] <- c('C2')
                }
                
                
                if (d[i,4] ==  c('C1 + C3') )
                { xc1 <- ccf(features[((i-1)*window):((i-1)*window +window),1],features[((i-1)*window):((i-1)*window +window),5], plot=FALSE)
                  xc2 <-ccf(features[((i-1)*window):((i-1)*window +window),3],features[((i-1)*window):((i-1)*window +window),5], plot=FALSE)
                  
                  if ( xc1$acf[xc1$lag ==0] < xc2$acf[xc2$lag ==0])
                          d[i,4] <- c('C3')
                  else
                          d[i,4] <- c('C1')}
                
                
                if (d[i,4] ==   c('C1 + C2')   )
                { xc1 <- ccf(features[((i-1)*window):((i-1)*window +window),1],features[((i-1)*window):((i-1)*window +window),6], plot=FALSE)
                  xc2 <-ccf(features[((i-1)*window):((i-1)*window +window),2],features[((i-1)*window):((i-1)*window +window),6], plot=FALSE)
                  
                  if ( xc1$acf[xc1$lag ==0] < xc2$acf[xc2$lag ==0])
                          d[i,4] <- c('C2')
                  else
                          d[i,4] <- c('C1')}
        }
        
        
        #take in data
        #check if it's closer to their components
        #remark them
        #return data
        return(d)
} 
combination <- function(m,v,t)
{
        #create new vector
        m[,3] <- c(0)
        C1 <- m
        C2 <- m
        C3 <- m
        weights(m,v,t,C1, 'C1')
        weights(m,v,t,C2,'C2')
        weights(m,v,t,C3,'C3')
        
        
        
}
weights <- function(m,v,t,comp, label)
{
        
        
        for (i in 1:dim(m)[[1]])
        {#if label matches label, add one
                #print(comp[1:10,3])
                if(m[i,1] == label)
                {  comp[i,3] <- comp[i,3] + 1}
                #print(comp[i,3])
                if(v[i,1] == label)
                { comp[i,3] <- comp[i,3] + 1}
                #print(comp[i,3])
                if(t[i,1] == label)
                { comp[i,3] <- comp[i,3] + 1}
                #print(comp[i,3])
        } 
        comp[,1] <- as.factor(comp[,3])
        comp[,4] <- 1:nrow(comp)
        names(comp)[[4]] <- c('index')
        names(comp)[[1]] <- c('DetectionScore')
        g <- ggplot(comp, aes(index,Multicomponent,  xlab = "", ylab= "")) + geom_line() +
                geom_point(data=comp, aes(index,Multicomponent, colour=DetectionScore),size=2) + ggtitle(label) + xlab("") + ylab("") +
                guides(colour = guide_legend(override.aes = list(size=8))) +
                scale_colour_manual(values =c('gray80', 'gray40', 'gray15', 'black'))   + theme(panel.background = element_rect(fill = 'white', colour = 'white'),panel.border = element_rect(colour = "black", fill=NA, size=1),legend.position = c(0.9, 0.8))
        print(g)
}


 
