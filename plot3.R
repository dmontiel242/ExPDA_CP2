## This first line will likely take a few seconds. Be patient!
library(dplyr)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#select only data for Baltimore City based on SCC value

filtNEI<-filter(NEI,fips=='24510')
meltNEI <- melt(filtNEI,id = c('fips','SCC','Pollutant','type','year'),measure.vars='Emissions')

tmp <-dcast(data = meltNEI,type+year~variable,sum)


qplot(year, Emissions, data=tmp)+geom_smooth(method=lm,se=FALSE)+facet_grid(.~type)+ggtitle('Total Emissions for 4 Types of Emission')
ggsave(filename='plot3.png')