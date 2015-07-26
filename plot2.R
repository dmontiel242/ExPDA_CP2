## This first line will likely take a few seconds. Be patient!
library(dplyr)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#select only data for Baltimore City based on SCC value

filtNEI<-filter(NEI,fips=='24510')
meltNEI <- melt(filtNEI,id = c('fips','SCC','Pollutant','type','year'),measure.vars='Emissions')

tmp <-dcast(data = meltNEI,year~variable,sum)

png('plot2.png')
with(tmp,plot(year,Emissions))
title('Total Emissions in Baltimore City vs. Year')
with(tmp,abline(lm(Emissions ~ year)))
dev.off()