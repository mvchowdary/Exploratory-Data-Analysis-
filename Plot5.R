#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
library(ggplot2)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

names(SCC)
veh_comb<-SCC[grep("[Vv]eh",SCC$Short.Name),]
nei_veh_col<- NEI %>% 
    filter(fips=="24510" & NEI$SCC %in% veh_comb$SCC)  %>% 
    merge(y=veh_comb ,by.x="SCC",by.y="SCC") %>%
    group_by(year)  %>%
    summarise(veh_emm_tot=sum(Emissions,na.rm=T))

png("plot5.png")
ggp<-ggplot(nei_veh_col,aes(year,veh_emm_tot)) +
    geom_point(col="Red",size=4,alpha=1/3) +
    xlab("Year") +
    ylab("Total Emissions [Tons]") +
    ggtitle("Total Annual VehicleEmissions in the US")

print(ggp)
dev.off()

balt_veh_emm_2008<-nei_veh_col[nei_veh_col$year==2008,2]
balt_veh_emm_1999<-nei_veh_col[nei_veh_col$year==1999,2]
tot_veh_emi_baltimore<-balt_veh_emm_2008-balt_veh_emm_1999

tot_veh_emi_baltimore
#Output 
#   -258.5445
