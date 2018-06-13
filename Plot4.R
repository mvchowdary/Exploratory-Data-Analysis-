#Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for 
#Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system 
#to make a plot answer this question.

coal_comb<-SCC[grep("[Cc]oal",SCC$EI.Sector),]
NEI_sub_coal <- filter(NEI, NEI$SCC %in% coal_comb$SCC)
NEI_coal_comb <- merge(x = NEI_sub_coal, y = SCC,    by= "SCC")
NEI_coal_comb_t <- NEI_coal_comb %>%     group_by(year) %>%    summarize(Total_Coal_Comb = sum(Emissions, na.rm = TRUE))
png("plot4.png")
NEI_coal_comb_plot <- ggplot(NEI_coal_comb_t, aes(year, Total_Coal_Comb)) +
    geom_point(color = "red", 
               size = 4, 
               alpha = 1/3) + 
    xlab("Year") +
    ylab("Total Emissions [Tons]") +
    ggtitle("Total Annual Coal Combustion Emissions in the US")
print(NEI_coal_comb_plot)
dev.off()
NEI_coal_comb_tot_2008 <- NEI_coal_comb_t[NEI_coal_comb_t$year == 2008, 2]
NEI_coal_comb_tot_1999 <- NEI_coal_comb_t[NEI_coal_comb_t$year == 1999, 2]
NEI_coal_comb_delta <- NEI_coal_comb_tot_2008 - NEI_coal_comb_tot_1999
NEI_coal_comb_delta
# Output Total_Coal_Comb
#       -228694.3
