## Read saved files into R and store as NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Create subset dataframe from SCC codes for rows containing "Coal" in name
coal <- SCC[grep("[Cc]oal", SCC$Short.Name), ]

## Include only coal sources that seem to be combustion related
coal_2 <- coal[grep("[Cc]omb", coal$Short.Name), ]

## Merge coal dataframe with NEI dataframe by SCC code
coal_all <- merge(NEI, coal_2)

## Calculate sums of Emissions by year
sums <- tapply(coal_all$Emissions, coal_all$year, FUN=sum)

## Arrange Total Emissions and year in a data frame
sumdf <- data.frame(year=names(sums), Emissions=sums)

#create png file
png(file = "plot4.png")

## Plot Total Emissions points for each year of interest
plot(sumdf$year, sumdf$Emissions, main = "Total Emissions from Coal Combusion Sources by Year", xlab = "Year", ylab = "Total Emissions")

#close graphic device
dev.off()