# _Exploratory Data Analysis Project 2_

##### About
This project is for the Coursera Data Science Specialisation : Exploratory Data Analysis. The objective of this project is to explore data and produce some data visualizations 
using some of the visualization libraries in R. This project is based on the Selcuk Fidan, TomLous, mmorales, candidobrau respective publications. 


Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.


1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
![](https://github.com/jacintod/ExData_Plotting2/blob/master/Project/plot1.png)

## Execution
```R
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

# Test Plot
# png("plot1.png", width=number.add.width, height=number.add.height)
# Group total NEI emissions per year:
total.PM25.emissions <- summarise(group_by(NEI, year), Emissions=sum(Emissions))
clrs <- c("red", "green", "blue", "yellow")
x1<-barplot(height=total.PM25.emissions$Emissions/1000, names.arg=total.PM25.emissions$year,
            xlab="years", ylab=expression('total PM'[2.5]*' emission in kilotons'),ylim=c(0,8000),
            main=expression('Total PM'[2.5]*' emissions at various years in kilotons'),col=clrs)

## Add text at top of bars
text(x = x1, y = round(total.PM25.emissions$Emissions/1000,2), label = round(total.PM25.emissions$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")
```
