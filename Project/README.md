# _Exploratory Data Analysis Project 2_

#### About
This project is for the Coursera Data Science Specialisation : Exploratory Data Analysis. The objective of this project is to explore data and produce some data visualizations 
using some of the visualization libraries in R. This project is based on the Selcuk Fidan, TomLous, mmorales, candidobrau respective publications. 


Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.


### 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
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

### 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
![](https://github.com/jacintod/ExData_Plotting2/blob/master/Project/plot2.png)
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
```
### 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?
![](https://github.com/jacintod/ExData_Plotting2/blob/master/Project/plot3.png)
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
```
### 4.Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
![](https://github.com/jacintod/ExData_Plotting2/blob/master/Project/plot4.png)
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
```
### 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
![](https://github.com/jacintod/ExData_Plotting2/blob/master/Project/plot5.png)
## Execution
```R
![](https://github.com/jacintod/ExData_Plotting2/blob/master/Project/plot5.R)
```