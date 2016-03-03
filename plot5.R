library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#get all sources related to the word "vehicle"
mv <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
mvsource <- SCC[mv,]$SCC

#retrieve baltimore data pertaining to vehicle data only
mvdata <- subset(NEI, fips == "24510" & (NEI$SCC %in% mvsource) )

# group by year and sum up the emissions data
mvdata <- mvdata %>% group_by(year) %>% mutate(totem = sum(Emissions))

baltdata <- distinct(mvdata,year)

png(filename="plot5.png")
with(baltdata, plot(year,totem,col="red", xlab="Year", ylab="Total Emissions", main="Motor Vehicle Emissions in Baltimore"))
lines(baltdata$year, baltdata$totem, col="blue")
dev.off()