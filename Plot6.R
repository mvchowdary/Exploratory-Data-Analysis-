#6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
#sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
library(ggplot2)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_Veh_Emmission_Baltimore<- NEI %>% 
    filter(fips=="24510" & NEI$SCC %in% veh_comb$SCC)  %>% 
    merge(y=veh_comb ,by.x="SCC",by.y="SCC") %>%
    group_by(year)  %>%
    summarise(total=sum(Emissions,na.rm=T))

NEI_Veh_Emmission_LA<- NEI %>%
    filter(fips=="06037" & NEI$SCC %in% veh_comb$SCC) %>%
    group_by(year) %>%
    summarise(total=sum(Emissions,na.rm=T))

NEI_Veh_Emmission_Baltimore<-cbind(NEI_Veh_Emmission_Baltimore,"city"=rep("Baltimore",nrow(NEI_Veh_Emmission_Baltimore)))
NEI_Veh_Emmission_LA<-cbind(NEI_Veh_Emmission_LA,"city"=rep("LA",nrow(NEI_Veh_Emmission_LA)))

NEI_Veh_Baltimore_LA <-rbind(NEI_Veh_Emmission_Baltimore,NEI_Veh_Emmission_LA)

png("plot6.png")
g<-ggplot(NEI_Veh_Baltimore_LA,aes(year,total,col=city)) +
    geom_point(size=4,alpha=1/3) +
    xlab("Year") +
    ylab("Total Emissions [Tons]") +
    ggtitle("Total Annual VehicleEmissions in the US")

print(g)
dev.off()

getwd()



