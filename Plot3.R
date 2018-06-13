#Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 
#for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting
#system to make a plot answer this question.
library(ggplot2)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore_emmission_by_type<-NEI %>%
    filter(fips == "24510") %>%
    group_by(year,type) %>%
    summarise(sum_by_type=sum(Emissions),na.rm=T)

names(baltimore_emmission_by_type)
png("plot3.png")
ggp<-ggplot(data =baltimore_emmission_by_type,aes(year,sum_by_type) ) +
    geom_point(color = "red", size = 5, alpha = 1/3) + 
    facet_grid(. ~ type) +
    xlab("Year") +
    ylab("Total Emissions [Tons]") +
    ggtitle("Total Annual Emissions in Baltimore by Year")
print(ggp)
dev.off()

