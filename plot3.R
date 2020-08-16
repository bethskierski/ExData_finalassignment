## Read NEI file into R
NEI <- readRDS("summarySCC_PM25.rds")

## Extract out Baltimore city data only
balt <- subset(NEI, fips == "24510")

## Split Baltimore data frame by type
balt_type <- split(balt, balt$type)

## Create new df that captures Emissions sums by year & type for Baltimore
balt_type <- balt %>% group_by(year, type) %>% summarize(Total.Emissions = sum(Emissions))

#create png file
png(file = "plot3.png")

## Make plot with facets in ggplot, showing Baltimore emissions by type
g <- qplot(year, Total.Emissions, data = balt_type, facets = .~type)
g + ggtitle("Total Emissions by type and year in Baltimore City")

#close graphic device
dev.off()
