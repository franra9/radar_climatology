# Francesc Roura Adserias # treball final de grau
# aquest script fa l'acumulada anual amb la suma diària.

setwd("/home/francesc/TFG/")

#library(tiff)
#library(sp)
#library(raster)
#library(rgdal)

sum <- 0

# require(lubridate)
# d <- as.Date('2004-01-01')
# month(d) <- month(d) + 1
# day(d) <- days_in_month(d)
# d

#### 24h aggregate ####
# for(year in 2013:2019){ # 7 anys
  

for(year10 in 2013:2019){
    # year10 <- as.character(year10)
    year10 <- as.character(2019)
    mes1 <- c("12","01","02")
    mes2 <- c("03","04","05")
    mes3 <- c("06","07","08")
    mes4 <- c("09","10","11")

#################

sum <- 0
for(mes in mes1){  
  if((mes=="02")|(mes=="01")){
    year <- as.numeric(year10)+1
  } else {
    year <- year10
  }
      filein  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_",as.character(mes),"_CMP24KG_24h_A.tif")
      tif <- raster(filein)
      sum <- sum + tif
      print(filein)
}
    fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_",
                      as.character(year),
                      "_",
                      paste0(mes1, collapse = "_"),
                      "_",
                      "CMP24KG_24h_A.tif")
    
    print(fileout)
    writeRaster(sum, fileout, overwrite=T)

#####################
    
    sum <- 0
    for(mes in mes2){  
      
        year <- year10

      filein  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_",as.character(mes),"_CMP24KG_24h_A.tif")
      tif <- raster(filein)
      sum <- sum + tif
    }
    fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_",
                      as.character(year),
                      "_",
                      paste0(mes2, collapse = "_"),
                      "_",
                      "CMP24KG_24h_A.tif")
    print(fileout)
    writeRaster(sum, fileout, overwrite=T)
    
#####################
    
    sum <- 0
    for(mes in mes3){  

        year <- year10

      filein  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_",as.character(mes),"_CMP24KG_24h_A.tif")
      tif <- raster(filein)
      sum <- sum + tif
    }
    fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_",
                      as.character(year),
                      "_",
                      paste0(mes3, collapse = "_"),
                      "_",
                      "CMP24KG_24h_A.tif")
    print(fileout)
    writeRaster(sum, fileout, overwrite=T)
    
    #####################
    
    sum <- 0
    for(mes in mes4){  
        
        year <- year10
        
        filein  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_",as.character(mes),"_CMP24KG_24h_A.tif")
        tif <- raster(filein)
        sum <- sum + tif
    }
    
      fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_",
                        as.character(year),
                        "_",
                        paste0(mes4, collapse = "_"),
                        "_",
                        "CMP24KG_24h_A.tif")
      print(fileout)
      writeRaster(sum, fileout, overwrite=T)
}
# }


# mitjana estacional summer:
tif1 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_2013_06_07_08_CMP24KG_24h_A.tif")
tif2 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_2014_06_07_08_CMP24KG_24h_A.tif")
tif3 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_2015_06_07_08_CMP24KG_24h_A.tif")
tif4 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_2016_06_07_08_CMP24KG_24h_A.tif")
tif5 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_2017_06_07_08_CMP24KG_24h_A.tif")
tif6 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_2018_06_07_08_CMP24KG_24h_A.tif")
# tif7 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_2019_06_07_08_CMP24KG_24h_A.tif")

tif <- (tif1 + tif2 + tif3 + tif4 + tif5 + tif6 )/6

writeRaster(tif,"/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_mean_06_07_08_CMP24KG_24h_A.tif")
raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/seasonal_agg_corr/seasonal_agg_XXX_RNN_mean_06_07_08_CMP24KG_24h_A.tif")
