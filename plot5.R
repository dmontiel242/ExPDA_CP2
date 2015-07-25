## This first line will likely take a few seconds. Be patient!
library(dplyr)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

meltNEI = melt(NEI,id = c('fips','SCC','Pollutant','type','year'),measure.vars='Emissions')
tmp <-dcast(data = meltNEI,fips+type+year~variable,sum)

#approximate all 'ON-ROAD' type emissions as coming from motor vehicles
filtNEI <- filter(tmp,type=='ON-ROAD' & fips=='24510')
#plot total emissions versus year for baltimore city
qplot(year, Emissions, data=filtNEI)+geom_smooth(method=lm,se=FALSE)
ggsave(filename='plot5.png')