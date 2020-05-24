#TFG plots. Aquí faig els plots dels rasters.

library(RColorBrewer)
require(rgdal)
require(maptools)
require(raster)
require(ggplot2)
require(jpeg)
library(rasterVis)
library(sp)
library(sf)
library(gridExtra)
library(latticeExtra)

tif1 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_01_mean_CMP24KG_24h_A.tif")

jan <- aggregate(tif1, 1)

jan <- as.data.frame(jan, xy = T)

colnames(jan) <- c("lon","lat","jan")

jan <- data.frame(jan)

pal <- colorRampPalette(c("yellow","blue"))#, ffff66

est <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp")
area_a <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_area_interior.shp") #rectangle que fem servir de motlle
comarques <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/shapefiles_catalunya_comarcas/shapefiles_catalunya_comarcas.shp")

#plot mean annual
tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/clim/year_agg_XXX_RNN_mean_CMP24KG_24h_A.tif")
png("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/plots/year_agg_XXX_RNN_mean_CMP24KG_24h_A.png")
spplot(tif,
       main=list(label="annual mean precipitation (mm)",cex=1),
       at=c(seq(350,580,10),660),
       col.regions = pal(400),
       # maxpixels = ncell(dem)/10,
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                    # list(est, fill=NA, first=FALSE),
                     list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

#plot mean summer
tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/clim/seasonal_agg_XXX_RNN_mean_06_07_08_CMP24KG_24h_A.tif")
png("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/plots/seasonal_agg_XXX_RNN_mean_06_07_08_CMP24KG_24h_A.png")
spplot(tif,
       main=list(label="summer mean precipitation (mm)",cex=1),
       at=c(seq(55,120,5)),
       col.regions = pal(400),
       # maxpixels = ncell(dem)/10,
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        # list(est, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

#plot mean July/Aug
tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_07_mean_CMP24KG_24h_A.tif")
png("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/plots/monthly_agg_XXX_RNN_07_mean_CMP24KG_24h_A.png")
spplot(tif,
       main=list(label="Jul mean precipitation (mm)",cex=1),
       at=c(seq(10,50,2.5), 60,75),
       col.regions = pal(400),
       # maxpixels = ncell(dem)/10,
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(est, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

tif <- crop(tif,area_a)

plot(tif)
plot(est, bg="transparent", add=TRUE)

r_masked0 <- raster::mask(tif, est,inverse=TRUE)
r_masked1 <- raster::mask(tif, est,inverse=FALSE)

cellStats(r_masked0, stat='mean', na.rm=TRUE, asSample=TRUE)
cellStats(r_masked1, stat='mean', na.rm=TRUE, asSample=TRUE)

cellStats(r_masked0, stat='sd', na.rm=TRUE, asSample=TRUE)
cellStats(r_masked1, stat='sd', na.rm=TRUE, asSample=TRUE)

### aug+jul #############################

ppt_high  <- (julaug > 100)
# Suma per a intensitats (comentar si només es vol comptar numero d'hores)
julaug <- mask(julaug,!ppt_high,maskvalue=0,updatevalue=0)

# shape <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_area_interior.shp") #rectangle que fem servir de motlle
shape <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp")
ppt <- crop(tif,shape)

r_masked0 <- raster::mask(ppt, shape,inverse=TRUE) #non irr
r_masked1 <- raster::mask(ppt, shape,inverse=FALSE) #irr

cellStats(r_masked0, stat='mean', na.rm=TRUE, asSample=TRUE)
cellStats(r_masked1, stat='mean', na.rm=TRUE, asSample=TRUE)

cellStats(r_masked0, stat='sd', na.rm=TRUE, asSample=TRUE)
cellStats(r_masked1, stat='sd', na.rm=TRUE, asSample=TRUE)

hist(r_masked0)
hist(r_masked1)


 # ggplot(data=df, aes(lon, lat, fill=jan)) +
 #   # scale_color_manual(breaks = c("20", "25", "35"), values=c("red", "blue", "green")) +
 #   # scale_fill_gradientn(colours = c("#FFFF00","#0000CC")) +
 #   # scale_fill_brewer(type = "seq", palette = c("blue", "yellow")) +
 #   # scale_fill_discrete()
 #   geom_polygon(data = comarques, aes(x = long, y = lat, group = group), colour = "black", fill = NA) +
 #   scale_colour_manual(values = jan$jan, limits = c("4", "6", "20", "35")) +
 #   aes() + 
 #   geom_tile() +  
 #   coord_sf() +   # coord_fixed(1.2)
 #   # scale_color_gradientn(colours = rainbow(5))
   # theme_light()
   # shape <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_area_interior.shp") #rectangle que fem servir de motlle
   # theme(legend.position="right") +
   # 
   # scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
   #                      breaks=c(300,350,400,450,500,550,600,650))

# library(cowplot)

# require(ggplot)

# setwd("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/")
# plot(shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/shapefiles_catalunya_comarcas/shapefiles_catalunya_comarcas.shp"))
# 
# 
# shp = shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/shapefiles_catalunya_comarcas/shapefiles_catalunya_comarcas.shp")
# # shp1 <- readOGR(dsn="/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_extrem_interior.shp",layer = "LIASE_extrem_interior")
# tif = raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/clim/year_agg_XXX_RNN_mean_CMP24KG_24h_A.tif")
# tif <-projectRaster(from = tif, crs=crs("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
# 
# 
# 
# # png("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/plots/rplot.png", width = 350, height = 350)
# # # 2. Create the plot
# #   cuts=c(300,350,400,450,500,550,600,650) #set breaks
# #   pal <- colorRampPalette(c("red","blue"))
# # 
# #   plot(tif, breaks=cuts, col = pal(9), main="Yearly precipitation mean (mm)",ylab = "latitude (deg)", xlab = "longitude (deg)")
# #   p <- plot(shp, bg="transparent", add=TRUE)
# # 
# #   # multiplot(plotlist = c(p,p), cols = 1, layout = NULL) 
# #   write 'efe burro'
# # 
# #   # 3. Close the file
# # dev.off()
# 
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/clim/year_agg_XXX_RNN_mean_CMP24KG_24h_A.tif")
# 
# tif1 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_01_mean_CMP24KG_24h_A.tif")
# tif2<- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_02_mean_CMP24KG_24h_A.tif")
# tif3 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_03_mean_CMP24KG_24h_A.tif")
# tif4 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_04_mean_CMP24KG_24h_A.tif")
# tif5 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_05_mean_CMP24KG_24h_A.tif")
# tif6 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_06_mean_CMP24KG_24h_A.tif")
# tif7 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_07_mean_CMP24KG_24h_A.tif")
# tif8 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_08_mean_CMP24KG_24h_A.tif")
# tif9 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_09_mean_CMP24KG_24h_A.tif")
# tif10 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_10_mean_CMP24KG_24h_A.tif")
# tif11 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_11_mean_CMP24KG_24h_A.tif")
# tif12 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_12_mean_CMP24KG_24h_A.tif")
# 
# shp <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_area_interior.shp") #rectangle que fem servir de motlle
# comarques <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/shapefiles_catalunya_comarcas/shapefiles_catalunya_comarcas.shp")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_2014_06_07_08_CMP24KG_24h_A.tif")
# 
# summary(tif)
# 
# 
# #################
# #plot monthly agregate A
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_04_mean_CMP24KG_24h_A.tif")
# 
# plot(shp)
# plot(comarques)
# plot(tif, main="dec mean ppt (mm)", pal <- colorRampPalette(c("yellow","blue")), col=pal(9),breaks=c(0,10,20,30,40,50,60,70,100), xlab="lon(deg)", ylab="lat (deg)")
# plot(tif, main="JJA mean ppt (mm)", pal <- colorRampPalette(c("yellow","blue")), col=pal(10),breaks=c(seq(50,200,25)), xlab="lon(deg)", ylab="lat (deg)")
# plot(shp, bg="transparent", add=TRUE)
# plot(comarques, bg="transparent", add=TRUE)
# #################
# 
# #################
# #intensities A
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_04_mean_CMP24KG_24h_A.tif")
# 
# plot(shp)
# plot(comarques)
# plot(tif, main="dec mean ppt (mm)", pal <- colorRampPalette(c("yellow","blue")), col=pal(9),breaks=c(0,10,20,30,40,50,60,70,100), xlab="lon(deg)", ylab="lat (deg)")
# plot(tif, main="JJA mean ppt (mm)", pal <- colorRampPalette(c("yellow","blue")), col=pal(10),breaks=c(seq(10,100,10)), xlab="lon(deg)", ylab="lat (deg)")
# plot(shp, bg="transparent", add=TRUE)
# plot(comarques, bg="transparent", add=TRUE)
# plot(shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp"),bg="transparent", add=TRUE)
# #################
# 
# 
# 
# 
# jan <- aggregate(tif1, 1) #remostreo a 1km
# feb <- aggregate(tif2, 1)
# mar <- aggregate(tif3, 1)
# apr <- aggregate(tif4, 1)
# may <- aggregate(tif5, 1)
# jun <- aggregate(tif6, 1)
# jul <- aggregate(tif7, 1)
# aug <- aggregate(tif8, 1)
# sep <- aggregate(tif9, 1)
# oct <- aggregate(tif10, 1)
# nov <- aggregate(tif11, 1)
# dec <- aggregate(tif12, 1)
# 
# jan <- as.data.frame(jan, xy = T)
# feb <- as.data.frame(feb, xy = T)
# mar <- as.data.frame(mar, xy = T)
# apr <- as.data.frame(apr, xy = T)
# may <- as.data.frame(may, xy = T)
# jun <- as.data.frame(jun, xy = T)
# jul <- as.data.frame(jul, xy = T)
# aug <- as.data.frame(aug, xy = T)
# sep <- as.data.frame(sep, xy = T)
# oct <- as.data.frame(oct, xy = T)
# nov <- as.data.frame(nov, xy = T)
# dec <- as.data.frame(dec, xy = T)
# 
# colnames(jan) <- c("lon","lat","jan")
# 
# jan <- data.frame(jan)
# 
# df <- data.frame(jan,
#                  "feb" = feb$monthly_agg_XXX_RNN_02_mean_CMP24KG_24h_A,
#                  "mar" = mar$monthly_agg_XXX_RNN_03_mean_CMP24KG_24h_A,
#                  "apr" = apr$monthly_agg_XXX_RNN_04_mean_CMP24KG_24h_A,
#                  "may" = may$monthly_agg_XXX_RNN_05_mean_CMP24KG_24h_A,
#                  "jun" = jun$monthly_agg_XXX_RNN_06_mean_CMP24KG_24h_A,
#                  "jul" = jul$monthly_agg_XXX_RNN_07_mean_CMP24KG_24h_A,
#                  "aug" = aug$monthly_agg_XXX_RNN_08_mean_CMP24KG_24h_A,
#                  "sep" = sep$monthly_agg_XXX_RNN_09_mean_CMP24KG_24h_A,
#                  "oct" = oct$monthly_agg_XXX_RNN_10_mean_CMP24KG_24h_A,
#                  "nov" = nov$monthly_agg_XXX_RNN_11_mean_CMP24KG_24h_A,
#                  "dec" = dec$monthly_agg_XXX_RNN_12_mean_CMP24KG_24h_A
#                  )
# plot(shape)
# ggplot(data=df, aes(lon, lat, fill=jan))+
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#    # shape <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_area_interior.shp") #rectangle que fem servir de motlle
#   theme(legend.position="right") +
# 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
#   
# plot(data=df$jan, x=df$lon, y=df$lat, pal=c("grey","blue"))
# 
# ggplot(data=df$jan)
# # sp::spplot(tif,
# #            cuts=c(300,350,400,450,500,550,600,650), #set breaks
# #            col.regions=colorRampPalette(c("yellow","blue")),
# #            scales = list(draw = TRUE),
# #            aspect = c(xmax(tif) - xmin(tif), ymax(tif) - ymin(tif)),
# #            xlim = c(xmin(tif),xmax(tif))
# #            )
# 
# 
# # https://stackoverflow.com/questions/15813101/controlling-legend-and-colors-for-raster-values-in-r
# # a aquesta pagina es parla dels cuts en les dades
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_01_mean_CMP24KG_24h_A.tif")
# jan_1 <- aggregate(tif, 1) #remostreo a 1km
# jan_df <- as.data.frame(jan_1, xy = T)
# colnames(jan_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_02_mean_CMP24KG_24h_A.tif")
# feb_1 <- aggregate(tif, 1) #remostreo a 1km
# feb_df <- as.data.frame(feb_1, xy = T)
# colnames(feb_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_03_mean_CMP24KG_24h_A.tif")
# mar_1 <- aggregate(tif, 1) #remostreo a 1km
# mar_df <- as.data.frame(mar_1, xy = T)
# colnames(mar_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_04_mean_CMP24KG_24h_A.tif")
# apr_1 <- aggregate(tif, 1) #remostreo a 1km
# apr_df <- as.data.frame(apr_1, xy = T)
# colnames(apr_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_05_mean_CMP24KG_24h_A.tif")
# may_1 <- aggregate(tif, 1) #remostreo a 1km
# may_df <- as.data.frame(may_1, xy = T)
# colnames(may_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_06_mean_CMP24KG_24h_A.tif")
# jun_1 <- aggregate(tif, 1) #remostreo a 1km
# jun_df <- as.data.frame(jun_1, xy = T)
# colnames(jun_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_07_mean_CMP24KG_24h_A.tif")
# jul_1 <- aggregate(tif, 1) #remostreo a 1km
# jul_df <- as.data.frame(jul_1, xy = T)
# colnames(jul_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_08_mean_CMP24KG_24h_A.tif")
# aug_1 <- aggregate(tif, 1) #remostreo a 1km
# aug_df <- as.data.frame(aug_1, xy = T)
# colnames(aug_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_09_mean_CMP24KG_24h_A.tif")
# sep_1 <- aggregate(tif, 1) #remostreo a 1km
# sep_df <- as.data.frame(sep_1, xy = T)
# colnames(sep_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_10_mean_CMP24KG_24h_A.tif")
# oct_1 <- aggregate(tif, 1) #remostreo a 1km
# oct_df <- as.data.frame(oct_1, xy = T)
# colnames(oct_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_11_mean_CMP24KG_24h_A.tif")
# nov_1 <- aggregate(tif, 1) #remostreo a 1km
# nov_df <- as.data.frame(nov_1, xy = T)
# colnames(nov_df) <- c("lon","lat","alt")
# 
# tif <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_12_mean_CMP24KG_24h_A.tif")
# dec_1 <- aggregate(tif, 1) #remostreo a 1km
# dec_df <- as.data.frame(dec_1, xy = T)
# colnames(dec_df) <- c("lon","lat","alt")
# 
# 
# # ploteig
# # jan <- ggplot(data=dem_2_df, aes(lon, lat, fill=alt)) +
# #   aes() +
# #   geom_tile() + 
# #   coord_sf() + # coord_fixed(1.2)
# #   theme_bw()
# jan <- ggplot(data=jan_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   geom_raster() + 
#   theme(axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# 
# 
# feb <- ggplot(data=feb_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   theme(axis.title.y=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks.y=element_blank(),
#         axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# 
# mar <- ggplot(data=mar_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   theme(axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# apr <- ggplot(data=apr_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   theme(axis.title.y=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks.y=element_blank(),
#         axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# may <- ggplot(data=may_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme() +
#   # theme(legend.position="top") +
#   theme(axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() +
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# jun <- ggplot(data=jun_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   theme(axis.title.y=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks.y=element_blank(),
#         axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# jul <- ggplot(data=jul_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   theme(axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# aug <- ggplot(data=aug_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   theme(axis.title.y=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks.y=element_blank(),
#         axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# sep <- ggplot(data=sep_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   theme(axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# oct <- ggplot(data=oct_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") +
#   theme(axis.title.y=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks.y=element_blank(),
#         axis.title.x=element_blank(),
#         axis.text.x=element_blank(),
#         axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# nov <- ggplot(data=nov_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   # theme(legend.position="top") 
#   # geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# dec <- ggplot(data=dec_df, aes(lon, lat, fill=alt)) +
#   aes() +
#   geom_tile() + 
#   coord_sf() + # coord_fixed(1.2)
#   theme(axis.title.y=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks.y=element_blank()) +
#   
#   # theme(legend.position="top") +
# # theme(axis.title.x=element_blank(),
# #       axis.text.x=element_blank(),
# #       axis.ticks.x=element_blank()) +
#   geom_raster() + 
#   scale_fill_gradientn(colors=c("khaki2","blue"),na.value = "transparent",
#                        breaks=c(300,350,400,450,500,550,600,650))
# 
# grid.arrange(
#   respect = T, #coses deles mides
#   jan,
#   feb,
#   mar,
#   apr,
#   may,
#   jun,
#   jul,
#   aug,
#   sep,
#   oct,
#   nov,
#   dec,
#   nrow = 6,
#   widths	= c(238,200),
#   heights = c(100,100,100,100,100,133),
#   top = "Mean monthly ppt (mm)",
#   bottom = textGrob(
#     "",
#     gp = gpar(fontface = 3, fontsize = 9),
#     hjust = 0,
#     x = 0
#   )
# )
# 
# ggplot(tif)
# 
# gg <- ggplot(tif)  # add axis lables and plot title.
# 
# 
# print(gg)
# 
# # plot(tif)
# # plot(shp1, bg="transparent", add=TRUE)
# # plot(shp, bg="transparent", add=TRUE)
# 
# 
# 
# cuts=c(300,350,400,450,500,550) #set breaks
# pal <- colorRampPalette(c("ffff66","blue"))
# 
# 
# plot(tif, breaks=cuts, col = pal(9), main="Yearly precipitation mean (mm)",ylab = "latitude (deg)", xlab = "longitude (deg)")
# plot(shp, bg="transparent", add=TRUE)
# save(p,file="/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/plots/yearly_mean.png")