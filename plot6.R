library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#get all sources related to the word "vehicle"
mv <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
mvsource <- SCC[mv,]$SCC

#retrieve baltimore data pertaining to vehicle data only
baltimoredata <- subset(NEI, fips == "24510" & (NEI$SCC %in% mvsource) )

#los angeles data
ladata <- subset(NEI, fips == "06037" & (NEI$SCC %in% mvsource))

combdata <- rbind(baltimoredata,ladata)

# group by year and sum up the emissions data
combdata <- combdata %>% group_by(fips, year) %>% mutate(totem = sum(Emissions))

combdata <- combdata %>% distinct(year) %>% mutate(County = ifelse(fips== "06037", "Los Angeles","Baltimore"))



png(filename="plot6.png")
qplot(y = totem, x = year, data = combdata, color = County) + geom_line() +
  labs(y = "Total Emissions") + 
  labs(x = "Year") + labs(title = "Total Emissions in Baltimore & Los Angeles (1999 - 2008)") 
dev.off()