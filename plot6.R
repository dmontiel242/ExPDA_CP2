## This first line will likely take a few seconds. Be patient!
library(dplyr)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#use reshape2 functions to generate table of total Emissions for each, fips, type and year
meltNEI = melt(NEI,id = c('fips','SCC','Pollutant','type','year'),measure.vars='Emissions')
tmp <-dcast(data = meltNEI,fips+type+year~variable,sum)

#approximate 'ON-ROAD' type of emissions are caused by motor vehicles
filtNEI2 <- filter(tmp,type=='ON-ROAD' & (fips=='24510' |fips=='06037'))
#plot total emissions versus year for each city

qplot(year, Emissions, data=filtNEI2)+geom_smooth(method=lm,se=FALSE)+facet_wrap(~fips,scales='free')
ggsave(filename='plot6.png')