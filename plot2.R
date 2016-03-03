
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")

#retrieve data for baltimore city
baltdata <- filter(NEI, fips=="24510")

#group by year and sum emissions per year
baltdata <- baltdata %>% group_by(year) %>% mutate(totem = round(sum(Emissions)))

#retrieve one row per year for plotting
baltdata <- distinct(baltdata,year)

png(filename = "plot2.png")
with(baltdata,plot(year,totem,col="red", xlab="Year", ylab="Total Emissions", main="Total PM Emissions in Baltimore"))
lines(baltdata$year, baltdata$totem, col="blue")
dev.off()


                   
