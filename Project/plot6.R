# Print the current working directory
print(getwd())
# Declare our working variables
data.dir <- "./Data"
file.name <- "./Data/NEI_data.zip"
url       <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zip.file <- "./Data/NEI_data.zip"

# Check if the data is downloaded and download when applicable. This piece of code will firstly check to see
# if the Data Folder exisits, If Not, Create and Download the file. 
if (!dir.exists(data.dir)) {
        dir.create(data.dir, showWarnings = TRUE)
        print("Data directory doesnt exist, so it was created")
}
# Check to see if the data set exists, if not download it 
if (!file.exists(zip.file)) {
        # Download and extract the data set files
        download.file(url, destfile = file.name)
        unzip(file.name,exdir = data.dir)
        print("Downloaded the source file for plotting..")
}

# Read downloaded data files
# read national emissions data
NEI <- readRDS("./Data/summarySCC_PM25.rds")
#read source code classification data
SCC <- readRDS("./Data/Source_Classification_Code.rds")

require(ggplot2)
require(dplyr)

balti.em <- summarise(group_by(filter(NEI, fips == "24510" & type=="ON-ROAD"), year), Emissions = sum(Emissions))
la.em <- summarise(group_by(filter(NEI, fips == "06037" & type=="ON-ROAD"), year), Emissions = sum(Emissions))
# merge the datasets 
balti.em$County <- "Baltimore City, MD"
la.em$County <- "Los Angeles County, CA"
both.em <- rbind(balti.em, la.em)

plot6 <- ggplot(both.em, aes(x = year, y = Emissions, fill = County, label = round(Emissions, 2))) +
        geom_bar(stat = "identity") +
        facet_grid(. ~ County) +
        ylab(expression('PM'[2.5])) + 
        xlab('Year') + 
        scale_y_continuous(limits = c(0, 4800)) +
        theme(legend.position='none') +
        ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') +
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

print(plot6)

