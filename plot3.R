library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")

baltdata <- filter(NEI, fips=="24510")
baltdata <- baltdata %>% transform(type = factor(type)) %>%  group_by(type,year)

png(filename = "plot3.png")
q <- qplot(year, Emissions, data=baltdata, facets = .~type)
## Add layers
q + scale_x_continuous(breaks = seq(1999, 2008, 3)) + theme_bw() + geom_point(size = 3, aes(colour=type)) + 
  geom_line() + labs(y = "Total Emissions") + 
  labs(x = "Year") + labs(title = "Total Emissions in Baltimore (1999 - 2008)") + 
  theme(axis.text = element_text(size = 8), axis.title = element_text(size = 14),
        plot.title = element_text(vjust = 2), 
        legend.title = element_text(size = 11)) +
  scale_colour_discrete(name = "Type")


dev.off()
