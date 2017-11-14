###########################################################
# This code implements the proposed Bayesian ICC Framework
# which takes into account non-constant variances and 
# multiple heterogeneous studies
#########################################################
# Written by Carly Bobak on March 22, 2017
# Based on initial work done by James O'Malley
#########################################################

library(rjags)

#set working directory
setwd("")

#set path to BUGS file
BUGS<-"C:/Users/...ICC.bug"

#load the data
ICCdata<-read.table("ICCdata.txt",sep=" ",col.names=c("patient", "study", "rater", "da", "sdm"), skip=1)

#set initial conditions
IC<-list(be=c(0.4, 0, 0), isigma=c(0.25, 0.25, 0.25), itau=c(0.3, 0.3, 0.3), itau2 = 0.3)

parameters = c("be", "sigma", "tau", "taustudy","ICC")    # The parameter(s) to be monitored.
adaptSteps = 500              # Number of steps to "tune" the samplers.
burnInSteps = 1000            # Number of steps to "burn-in" the samplers.
nChains = 3                   # Number of chains to run.
numSavedSteps=50000           # Total number of steps in chains to save.
thinSteps=1                   # Number of steps to "thin" (1=keep every step).
nIter = ceiling( ( numSavedSteps * thinSteps ) / nChains ) # Steps per chain.

# Create, initialize, and adapt the model:
jagsModel = model<-jags.model(BUGS,data=ICCdata,inits=IC)

# Burn-in:
cat( "Burning in the MCMC chain...\n" )
update( jagsModel , n.iter=burnInSteps )

# Main phase of MCMC model: draws from the posterior distribution are saved in codaSamples
cat( "Sampling final MCMC chain...\n" )
codaSamples = coda.samples( jagsModel , variable.names=parameters ,
                            n.iter=nIter , thin=thinSteps )
# resulting codaSamples object has these indices:
#   codaSamples[[ chainIdx ]][ stepIdx , paramIdx ]
mcmcChain = as.matrix( codaSamples )

## Summarize results ##
mcmcRes<-data.frame(mcmcChain)
result <- sapply(mcmcRes , function(x) rbind( mean = mean(x) , lower = quantile(x,0.025), upper =quantile(x,0.975)))
row.names(result)<-cbind("mean","lower bound", "upper bound")
summaryresults=data.frame(t(result))
print('Summary Results')
print(summaryresults) #Prints results


## A basic checks that the MCMC chains converged: plots of parameters should appear random ##

print('Description of all of the MCMC output from fitted model')
print(summary(mcmcChain))

#put sampled values in a vector
ICCSample1=mcmcChain[,"ICC[1]"]
ICCSample2=mcmcChain[,"ICC[2]"]
ICCSample3=mcmcChain[,"ICC[3]"]

#plots of sequences of draws of the ICC for a randomly selected patient in each of the studies
par(mfrow=c(3,1), srt=0, mai=c(0.6, 0.6, 0.4, 0.2), mgp=c(2,1,0))
plot(ICCSample1,type="l",main="MCMC Chain ICC in Study 1",xlab="iteration",ylab="estimate")
plot(ICCSample2,type="l",main="MCMC Chain ICC in Study 2",xlab="iteration",ylab="estimate")
plot(ICCSample3,type="l",main="MCMC Chain ICC in Study 3",xlab="iteration",ylab="estimate")


