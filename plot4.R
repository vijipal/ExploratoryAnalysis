library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get all sources related to the word "vehicle"
mv <- grepl("coal", SCC$EI.Sector, ignore.case=TRUE)
mvsource <- SCC[mv,]$SCC

#retrieve US data pertaining to coal
UScombdata <- subset(NEI, NEI$SCC %in% mvsource)

# group by year and sum up the emissions data
UScombdata <- UScombdata %>% group_by(year) %>% mutate(totem = round(sum(Emissions)))

UScombdata <- distinct(UScombdata,year)

png(filename="plot4.png")
with(UScombdata, plot(year,totem,col="red", xlab="Year", ylab="Total Emissions", main="Coal combustion Emissions in Baltimore"))
lines(UScombdata$year, UScombdata$totem, col="blue")
dev.off()
