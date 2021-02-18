# In this script we develop a tool to plot data in a map"

source("./config.R")

tif <- raster("~/results/radar_climatology/LIASE_A/month/feb_2014-2018_corr.tif")
feb_1 <- aggregate(tif, 1) #remostreo a 1km
feb_df <- as.data.frame(feb_1, xy = T)
colnames(feb_df) <- c("lon","lat","mm")

feb <- ggplot(data=feb_df, aes(lon, lat, fill=mm)) +
  aes() +
  geom_tile() + 
  coord_sf() + # coord_fixed(1.2)
  # theme(legend.position="top") +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  geom_raster() + 
  scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent")#,
                       #breaks=c(300,350,400,450,500,550,600,650))
