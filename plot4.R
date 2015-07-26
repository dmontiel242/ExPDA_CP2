## This first line will likely take a few seconds. Be patient!
library(dplyr)
library(reshape2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#identify SCC values which arise from coal and combustion keywords.  'comb' is abbreviation for combustion is Short.Name
filtSCC <- SCC[grepl('coal',SCC[,'Short.Name'],ignore.case=TRUE) &grepl('comb',SCC[,'Short.Name'],ignore.case=TRUE),'SCC']
#filter rows of NEI data related to coal and combustion keywords
filtNEI <- filter(NEI,SCC==filtSCC)
meltNEI = melt(filtNEI,id = c('fips','SCC','Pollutant','type','year'),measure.vars='Emissions')
tmp <-dcast(data = meltNEI,year~variable,sum)

qplot(year, Emissions, data=tmp)+geom_smooth(method=lm,se=FALSE)+ggtitle('Total Coal Combustion Emissions in United States versus Year')
ggsave('plot4.png')