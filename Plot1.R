#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of
#the years 1999, 2002, 2005, and 2008.

library(ggplot2)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
total_emmision_year<-NEI %>% group_by(year) %>% summarize(total_emmision =sum(Emissions ,na.rm=TRUE))
png("plot1.png")
with(total_emmision_year, 
     print(plot(x = year, 
                y = total_emmision, 
                ylab = "Total Annual Emissions [Tons]", 
                xlab = "Year",
                main = "Total Annual Emissions in the US by Year",
                cex = 2,
                pch = 2,
                col = "red",
                lwd = 3)))

dev.off()
emmision_1999<-total_emmision_year[total_emmision_year$year==1999,2]
emmision_2008<-total_emmision_year[total_emmision_year$year==2008,2]
emmision_2008_1999<-emmision_2008-emmision_1999
emmision_2008_1999
#  total_emmision
#       -3868761
