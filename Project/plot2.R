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

number.add.width<-800    # width length to make the changes faster
number.add.height<-800   # height length to make the changes faster

# Load our required libraries
require(dplyr)

balti.em <- summarise(group_by(filter(NEI, fips == "24510"), year), sumBaltiEM = sum(Emissions))
# str(total.em)   # we have the 4 years here

colo <- c("red3", "green3", "blue3", "yellow3")
plot2 <- barplot(balti.em$sumBaltiEM/1000
                 , names = balti.em$year
                 , xlab = "year"
                 , ylab = "total PM'[2.5]*' emission in kilotons"
                 , ylim = c(0,4)
                 , main = expression('Total PM'[2.5]*' emissions for Baltimore City Maryland at various years in kilotons')
                 , col = colo
)
## Add text at top of bars
text(x = plot2
     , y = round(balti.em$sumBaltiEM/1000,2)
     , label = round(balti.em$sumBaltiEM/1000,2)
     , pos = 3
     , cex = 0.8
     , col = "black"
)