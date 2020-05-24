# Creació Francesc Roura Adserias 13/12/2019
# En aquest programa es calcula la climatologia de tot el període que tenim.
#=======================================
# Això inclou:
# - Mitjana anual
# - Mitjana de cada mes
# - Mitjana de cada estació
#=======================================

library(tiff)
library(sp)
library(raster)
library(rgdal)
library(ggplot2)

# Mitjana anual

sumtot <- 0
for(year in 2014:2018){
  filein <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/year_agg_XXX_RNN_",as.character(year),"_CMP24KG_24h_A.tif")
  tif <- raster(filein)
  sumtot <- sumtot + tif
  summary(tif)
}

fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/clim/year_agg_XXX_RNN_","mean","_CMP24KG_24h_A.tif")
summary(sumtot/5)
# writeRaster(sumtot/5, fileout, overwrite=T)

plot(sumtot/5)

# Mitjana mensual

sumtot0=0
for(mes in 1:12){
  if(mes<10){
    mes <- paste0("0",mes)  
  } else {
    mes <- mes
  }
  sumtot <- 0
  nmes <- 0
  for(year in 2013:2019){
    filein <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_",as.character(mes),"_CMP24KG_24h_A.tif")
    print(filein)
    if(!file.exists(filein)){ #comptatge del nombre d'anys amb dades del mes en qüestió
      nmes <- nmes
      tif <- 0
    } else {
      nmes <- nmes + 1
      tif <- raster(filein)
    }
    sumtot <- sumtot + tif
    # summary(tif)
  }
  fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_",as.character(mes),"_","mean","_CMP24KG_24h_A.tif")
  # writeRaster(sumtot/nmes, fileout, overwrite=T)
}

hist1 <- hist(raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/clim/monthly_agg_XXX_RNN_12_mean_CMP24KG_24h_A.tif"),xlab="monthly ppt (mm)")
hist1 <- hist(raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/year_agg_XXX_RNN_2018_CMP24KG_24h_A.tif"),xlab="anual ppt (mm)")
#   # plot((2.3),(1.2))
# plot(raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/clim/year_agg_XXX_RNN_mean_CMP24KG_24h_A.tif", ))
# # barplot(as.vector(hist1$density),as.vector(hist1$counts), xlab = "Number of points" , ylab = "ppt (mm)", rownames = as.character(hist1$mids))

plot(hist1)
plot()
plot(x=sin(2),y=2)

# as. (hist1)
write(plot(hist1),file="/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/histo/histogram_01_mean.png")
