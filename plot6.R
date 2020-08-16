## Read saved files into R and store as NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Create subset dataframe from EI Sector codes for rows containing "On-Road" or "Non-Road" in name, which represent motor vehicle sources
motor <- SCC[grep("Mobile - On-Road|Mobile - Non-Road", SCC$EI.Sector), ]

## Merge coal dataframe with NEI dataframe by SCC code
motor_all <- merge(NEI, motor)

## Extract out Baltimore city data only
balt <- subset(motor_all, fips == "24510")

## Extract out Los Angeles county data only
losang <- subset(motor_all, fips == "06037")

## Calculate sums of Emissions by year
sums_balt <- tapply(balt$Emissions, balt$year, FUN=sum)
sums_losang <- tapply(losang$Emissions, losang$year, FUN=sum)

## Arrange Total Emissions and year in a data frame
sumdf_balt <- data.frame(year=names(sums_balt), Emissions=sums_balt)
sumdf_losang <- data.frame(year=names(sums_losang), Emissions=sums_losang)

#create png file
png(file = "plot6.png")

## Plot Total Emissions points for each year of interest
par(mfrow=c(1,2))
plot(sumdf_balt$year, sumdf_balt$Emissions, main = "Baltimore City", xlab = "Year", ylab = "Total Emissions")
plot(sumdf_losang$year, sumdf_losang$Emissions, main = "Los Angeles County", xlab = "Year", ylab = "Total Emissions")

#close graphic device
dev.off()