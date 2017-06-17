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

balti.em <- subset(NEI, fips == 24510)
balti.em$year <- factor(balti.em$year, levels=c('1999', '2002', '2005', '2008'))  # !! important !! otherwise, only one boxplot per Type

plot3 <- ggplot(data = balti.em, aes(x = year, y = log10(Emissions))) +
        geom_boxplot(aes(fill = type)) +
        stat_boxplot(geom = "errorbar") +
        facet_grid( . ~ type) +
        guides(fill = FALSE) +
        ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) +
        xlab('Year') + 
        ggtitle('Emissions per Type in Baltimore City, Maryland') +
        geom_jitter(alpha = 0.13)

print(plot3)