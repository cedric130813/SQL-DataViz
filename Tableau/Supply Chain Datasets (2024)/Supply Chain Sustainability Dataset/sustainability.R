library(data.table)
library(tidyverse)

distances = read.csv("distances.csv", stringsAsFactors = T)
gps_loc = read.csv("gps_locations.csv", stringsAsFactors = T)
orders = read.csv("order_lines.csv", stringsAsFactors = T)
uomConvert = read.csv("uom_conversions.csv", stringsAsFactors = T)

# merge the dataframes based on common item code
masterOrder = merge(uomConvert, orders, by = 'Item.Code')

# split gps loc's location using comma separator
masterGpsLoc = gps_loc %>% 
  separate_wider_delim(Location, ", ", names = c("Country", "City"), too_many = "merge")

# ... to be continued

# total value of customer order
masterOrder$TotalValue= masterOrder$Units * masterOrder$Euros

write.csv(masterGpsLoc,file = "masterGps.csv")
write.csv(masterOrder,file = "masterOrder.csv")
write.csv(distances, file = "masterDistance.csv")
