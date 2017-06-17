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


SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# merge both data sets according to SCC-number
mrg <- merge(x = NEI, y = SCC.coal, by = 'SCC')  # 53400 rows
mrg.sum <- summarise(group_by(mrg, year), Emissions=sum(Emissions))

plot4 <- ggplot(data = mrg.sum, aes(x = year, y = Emissions / 1000)) +
        geom_line(aes(group = 1, col = Emissions)) +
        geom_point(aes(size = 2, col = Emissions)) + 
        ggtitle(expression('Total Emissions of PM'[2.5])) +
        ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
        geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = 1.5, vjust = 1.5)) + 
        theme(legend.position = 'none') +
        scale_color_gradient(low = 'black', high = 'red')

print(plot4)