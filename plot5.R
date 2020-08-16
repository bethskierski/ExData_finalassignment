## Read saved files into R and store as NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Create subset dataframe from EI Sector codes for rows containing "On-Road" or "Non-Road" in name, which represent motor vehicle sources
motor <- SCC[grep("Mobile - On-Road|Mobile - Non-Road", SCC$EI.Sector), ]

## Merge coal dataframe with NEI dataframe by SCC code
motor_all <- merge(NEI, motor)

## Extract out Baltimore city data only
balt <- subset(motor_all, fips == "24510")

## Calculate sums of Emissions by year
sums <- tapply(balt$Emissions, balt$year, FUN=sum)

## Arrange Total Emissions and year in a data frame
sumdf <- data.frame(year=names(sums), Emissions=sums)

#create png file
png(file = "plot5.png")

## Plot Total Emissions points for each year of interest
plot(sumdf$year, sumdf$Emissions, main = "Baltimore City Motor Vehicle Emissions by Year", xlab = "Year", ylab = "Total Emissions")

#close graphic device
dev.off()