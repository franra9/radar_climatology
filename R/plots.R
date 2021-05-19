# In this script we develop a tool to plot data in a map"

source("./config.R")

# plot shapefiles
east <- shapefile("/home/francesc/data/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp")
area_a <- shapefile("/home/francesc/data/radar_SMC_ppt_TFG/shape/LIASE_area_interior.shp") #rectangle que fem servir de motlle
comarques <- shapefile("/home/francesc/data/radar_SMC_ppt_TFG/shape/shapefiles_catalunya_comarcas/shapefiles_catalunya_comarcas.shp")

#palette
pal <- colorRampPalette(c("yellow","blue"))#, ffff66

#----------------------------------------------------
#plot monthly means.
#----------------------------------------------------
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
apendix <- c(paste0(months[1:3],"_2013-2021_corr.tif"),
             paste0(months[4:12],"_2013-2020_corr.tif"))

#for(i in 1:12){
#        tif <- raster(paste0(outdir,"/", shp.name,"/month/", apendix[i]))
#        png(paste0(outdir,"plots/", months[i],".png"))
#        spplot(tif,
#               main=list(label=paste0(months[i], " mean precipitation (mm)"), cex=1),
#               at=c(seq(minValue(tif), quantile(maxValue(tif), 0.99), (quantile(tif, 0.99) - minValue(tif))/10)),
#               col.regions = pal(400),
#               scales = list(draw = TRUE),
#               xlab = "longitude", ylab = "latitude",
#               sp.layout = list(list(area_a, fill=NA, first=FALSE), 
#                                list(east, fill=NA, first=FALSE),
#                                list(comarques, fill=NA, first=FALSE)))
#        # Close the png file
#        dev.off()
#        print(i)
#}
#dev.off()
#stop()

tif <- raster(paste0(outdir,"/", shp.name,"/month/jan_2013-2021_corr.tif"))
png(paste0(outdir,"/plots/jan.png"))
spplot(tif,
       main=list(label="Jan mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10), quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

tif <- raster(paste0(outdir,"/", shp.name,"/month/feb_2013-2021_corr.tif"))
png(paste0(outdir,"/plots/feb.png"))
spplot(tif,
       main=list(label="Feb mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

tif <- raster(paste0(outdir,"/", shp.name,"/month/mar_2013-2021_corr.tif"))
png(paste0(outdir,"/plots/mar.png"))
spplot(tif,
       main=list(label="Mar mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

tif <- raster(paste0(outdir,"/", shp.name,"/month/apr_2013-2020_corr.tif"))
png(paste0(outdir,"/plots/apr.png"))
spplot(tif,
       main=list(label="Apr mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

tif <- raster(paste0(outdir,"/", shp.name,"/month/may_2013-2020_corr.tif"))
png(paste0(outdir,"/plots/may.png"))
spplot(tif,
       main=list(label="May mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

tif <- raster(paste0(outdir,"/", shp.name,"/month/jun_2013-2020_corr.tif"))
png(paste0(outdir,"/plots/jun.png"))
spplot(tif,
       main=list(label="Jun mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

tif <- raster(paste0(outdir,"/", shp.name,"/month/jul_2013-2020_corr.tif"))
png(paste0(outdir,"/plots/jul.png"))
spplot(tif,
       main=list(label="Jul mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 
tif <- raster(paste0(outdir,"/", shp.name,"/month/aug_2013-2020_corr.tif"))
png(paste0(outdir,"/plots/aug.png"))
spplot(tif,
       main=list(label="Aug mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 
tif <- raster(paste0(outdir,"/", shp.name,"/month/sep_2013-2020_corr.tif"))
png(paste0(outdir,"/plots/sep.png"))
spplot(tif,
       main=list(label="Sep mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 
tif <- raster(paste0(outdir,"/", shp.name,"/month/oct_2013-2020_corr.tif"))
png(paste0(outdir,"/plots/oct.png"))
spplot(tif,
       main=list(label="Oct mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 
tif <- raster(paste0(outdir,"/", shp.name,"/month/nov_2013-2020_corr.tif"))
png(paste0(outdir,"/plots/nov.png"))
spplot(tif,
       main=list(label="Nov mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 
tif <- raster(paste0(outdir,"/", shp.name,"/month/dec_2013-2020_corr.tif"))
png(paste0(outdir,"plots/dec.png"))
spplot(tif,
       main=list(label="Dec mean precipitation (mm)",cex=1),
       at=c(seq(minValue(tif), quantile(tif, 0.99), (quantile(tif, 0.99) - minValue(tif))/10),quantile(tif, 0.99) + 5 ),
       col.regions = pal(400),
       scales = list(draw = TRUE),
       xlab = "longitude", ylab = "latitude",
       sp.layout = list(list(area_a, fill=NA, first=FALSE), 
                        list(east, fill=NA, first=FALSE),
                        list(comarques, fill=NA, first=FALSE)))
# Close the png file
dev.off() 

print(paste0("Monthly plots for ", shp.name ," have been produced and stored in", outdir))

