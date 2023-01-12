# Tested in R 4.0.3 in RStudio 1.3.1093
# 2023-01-12 Stace Beaulieu
# This example plots a time series of the temperature from the CTD at ~350-m depth on the Apex Surface Mooring of the Global Argentine Basin Array, using data from the Data Explorer ERDDAP.
# QARTOD flags are used to color the points on the plot.

# Installation
#install.packages("readr")
#install.packages("ggplot2")
#install.packages("dplyr")

library(readr)
library(ggplot2)
library(dplyr)
# temperature used in recorded demo
df <- read_csv("http://erddap.dataexplorer.oceanobservatories.org/erddap/tabledap/ooi-ga01sumo-rii11-02-ctdmoq016.csvp?time%2Csea_water_temperature%2Csea_water_temperature_qc_agg&time%3E=2015-03-15T21%3A30%3A00Z&time%3C=2018-01-14T10%3A22%3A00Z") 
# salinity 
# df <- read_csv("http://erddap.dataexplorer.oceanobservatories.org/erddap/tabledap/ooi-ga01sumo-rii11-02-ctdmoq016.csvp?time%2Csea_water_practical_salinity%2Csea_water_practical_salinity_qc_agg&time%3E=2015-03-15T21%3A30%3A00Z&time%3C=2018-01-14T10%3A22%3A00Z") 

colnames(df) <- c('time','temperature','flag')
ggplot(df, aes(time, temperature, color = factor(flag))) +
  geom_point() +
  ylim(2, 14)

#additional steps to determine % QARTOD flag 3
q1 <- filter(df, flag==1)
q3 <- filter(df, flag==3)
isTRUE(nrow(q1)+nrow(q3) == nrow(df)) #confirm no values other than 1 or 3 in df$flag
nrow(q3)/nrow(df)
