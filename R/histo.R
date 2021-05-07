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

  # accumulation
  sum <- ppt_high + ppt_mod + ppt_low

  r_masked0 <- raster::mask(sum, shape,inverse=TRUE) #irr
  r_masked1 <- raster::mask(sum, shape,inverse=FALSE) #non irr

  # histos
  a1 <- as.data.frame(r_masked1)
  a0 <- as.data.frame(r_masked0)

  dat1 = data.frame(acc_ppt=Vectorize(a1$layer), group="east")
  dat2 = data.frame(acc_ppt=Vectorize(a0$layer), group="west")
  dat = rbind(dat1, dat2)
  
  png(paste0(outdir,"plots/hist_ppt_",month,".png"))
  ggplot(dat, aes(acc_ppt, fill=group, colour=group)) +
    geom_histogram(aes(y=..density..), alpha=0.6, 
                   position="identity", lwd=0.2) +
    ggtitle("Normalized")
  dev.off()
