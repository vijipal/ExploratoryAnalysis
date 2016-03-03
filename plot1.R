library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")

#using dplyr package
USdata <- group_by(NEI,year)

#add a column for total emissions and get one row for each year
USdata <- USdata %>% mutate(totem = round(sum(Emissions))) %>% distinct(year)

png(filename = "plot1.png")
with(USdata,plot(totem~year,col="red", xlab="Year", ylab="Total Emissions", main="Total PM Emissions in US"))
lines(USdata$year, USdata$totem, col="blue")
dev.off()

