## Read NEI file into R
NEI <- readRDS("summarySCC_PM25.rds")

## Calculate sums of Emissions by year
sums <- tapply(NEI$Emissions, NEI$year, FUN=sum)

## Arrange Total Emissions and year in a data frame
sumdf <- data.frame(year=names(sums), Emissions=sums)

#create png file
png(file = "plot1.png")

## Plot Total Emissions points for each year of interest
plot(sumdf$year, sumdf$Emissions, main = "Total Emissions by Year", xlab = "Year", ylab = "Total Emissions")

#close graphic device
dev.off()
