# This file is the confuration file, to load the libraries used.
# Creation froura 20200708
#---------------------
# Libraries
#---------------------

library(tiff)
library(sp)
library(raster)
library(rgdal)
library(ggplot2)

#---------------------
# plotting libraries
#---------------------

require(maptools)
#require(jpeg)
library(rasterVis)
library(sf)
library(gridExtra)
library(latticeExtra)
gpclibPermit()

################
# define rep.dir
################

rep.dir <- "/home/francesc/repositories/radar_climatology/"
data.dir <- "/home/francesc/data/radar_SMC_ppt_TFG/"
outdir <- "/home/francesc/results/radar_climatology/"
shp.dir <- "/home/francesc/data/radar_SMC_ppt_TFG/shape/LIASE_area_interior.shp"
shp.name <- "LIASE_a"
int_an <- T #intensity analysis (expensive in computing default=F)
 
print("Configuration has been loaded, with this parameters:")
cat("Repository directory: "); print(rep.dir)
cat("Data source: "); print(data.dir)
cat("Results directory: "); print(outdir)
cat("Shape path: "); print(shp.dir)
