#this script computes things with hourly averages, makes histograms.

source("./config.R")

months <- c("jan",
            "feb",
            "mar",
            "apr",
            "may",
            "jun",
            "jul",
            "aug",
            "sep",
            "oct",
            "nov",
            "dec")
# this applies to hourly analysis normalize (do average) #
if(any(months[2:3] == month)){
  nor <- 2021 - 2013 +1
} else {
  nor <- 2020 - 2013 +1
}
###################################

#for(month in months){
#  event_high <- raster(paste0(outdir, shp.name, "/month_int/event_high_",month,".tif"))
#  event_mod <- raster(paste0(outdir, shp.name, "/month_int/event_mod_",month,".tif"))
#  event_low <- raster(paste0(outdir, shp.name, "/month_int/event_low_",month,".tif"))
#
#  ppt_high <- raster(paste0(outdir, shp.name, "/month_int/ppt_high_",month,".tif"))
#  ppt_mod <- raster(paste0(outdir, shp.name, "/month_int/ppt_mod_",month,".tif"))
#  ppt_low <- raster(paste0(outdir, shp.name, "/month_int/ppt_low_",month,".tif"))
#
#  shape <- shapefile("/home/francesc/data/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp")
#
#  # accumulation
#  sum <- ppt_high + ppt_mod + ppt_low
#
#  r_masked0 <- raster::mask(sum, shape,inverse=TRUE) #irr
#  r_masked1 <- raster::mask(sum, shape,inverse=FALSE) #non irr
#
#  # histos
#  a1 <- as.data.frame(r_masked1)
#  a0 <- as.data.frame(r_masked0)
#
#  dat1 = data.frame(acc_ppt=Vectorize(a1$layer), group="east")
#  dat2 = data.frame(acc_ppt=Vectorize(a0$layer), group="west")
#  dat = rbind(dat1, dat2)
#  
#  png(paste0(outdir,"plots/hist_ppt_",month,".png"))
#  ggplot(dat, aes(acc_ppt, fill=group, colour=group)) +
#    geom_histogram(aes(y=..density..), alpha=0.6, 
#                   position="identity", lwd=0.2) +
#    ggtitle("Normalized")
#  dev.off()
#}
  event_high <- raster(paste0(outdir, shp.name, "/month_int/event_high_",month,".tif"))
  event_mod <- raster(paste0(outdir, shp.name, "/month_int/event_mod_",month,".tif"))
  event_low <- raster(paste0(outdir, shp.name, "/month_int/event_low_",month,".tif"))

  ppt_high <- raster(paste0(outdir, shp.name, "/month_int/ppt_high_",month,".tif"))
  ppt_mod <- raster(paste0(outdir, shp.name, "/month_int/ppt_mod_",month,".tif"))
  ppt_low <- raster(paste0(outdir, shp.name, "/month_int/ppt_low_",month,".tif"))

  shape <- shapefile("/home/francesc/data/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp")

  sum <- event_low + event_low*0
  sum <- event_low + event_mod + event_high
  # maps from hourly basis
  # accumulation
  #sum <- ppt_high + ppt_mod + ppt_low
  sum <- sum/nor
  # plot raster also:
  #tif <- sum
  #png(paste0(outdir,"plots/hourly_clim_",month,".png"))
  #spplot(tif,
  #       main=list(label=paste0(month," mean precipitation (mm), hourly basis"),cex=1),
  #       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
  #       col.regions = pal(400),
  #       scales = list(draw = TRUE),
  #       xlab = "longitude", ylab = "latitude",
  #       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
  #                        list(east, fill=NA, first=FALSE),
  #                        list(comarques, fill=NA, first=FALSE)))
  ## Close the png file
  #dev.off() 
  
  # histos  given raster and shapefile to split raster in 2 regions####
  r_masked0 <- raster::mask(sum, shape,inverse=TRUE) #irr, west
  r_masked1 <- raster::mask(sum, shape,inverse=FALSE) #non irr, east

  a1 <- as.data.frame(r_masked1)
  a0 <- as.data.frame(r_masked0)

  dat1 = data.frame(acc_ppt=Vectorize(a1$layer), group="east")
  dat2 = data.frame(acc_ppt=Vectorize(a0$layer), group="west")
  dat = rbind(dat1, dat2)
  
  png(paste0(outdir,"plots/hist_1_event_",month,".png"))
  ggplot(dat, aes(acc_ppt, fill=group, colour=group)) +
    geom_histogram(aes(y=..density..), alpha=0.6, 
                   position="identity", lwd=0.2) +
    ggtitle(paste0("Normalized distribution. ppt #events ",month ))
  dev.off()
