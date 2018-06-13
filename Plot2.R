#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == 
#"24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering 
#this question.
library(ggplot2)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

tot_emissions_baltimore <- NEI %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(Total_Emissions_Baltimore = sum(Emissions,na.rm=TRUE))
png("plot2.png")

with(tot_emissions_baltimore, 
   print(plot(x = year, 
          y = Total_Emissions_Baltimore , 
          ylab = "Total Annual Emissions [Tons]", 
          xlab = "Year",
          main = "Total Annual Emissions in Baltimore by Year",
          cex = 2,
          pch = 2,
          col = "red",
          lwd = 3)))
dev.off()
balt_emmision_1999<-tot_emissions_baltimore[tot_emissions_baltimore$year==1999,2]
balt_emmision_2008<-tot_emissions_baltimore[tot_emissions_baltimore$year==2008,2]
balt_emmision_2008_1999<-balt_emmision_2008-balt_emmision_1999
balt_emmision_2008_1999

