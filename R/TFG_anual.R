# Francesc Roura Adserias # treball final de grau
# aquest script fa l'acumulada anual amb la suma mensual.

setwd("/home/francesc/TFG/")

library(tiff)
library(sp)
library(raster)
library(rgdal)

sum <- 0

#### 24h aggregate ####
for(year in 2013:2019){ # 7 anys, dels que volem trobar-ne la suma.
  
  for(mes in 1:12){ # recorrem tots els mesos de l'any
    
    if(mes<10){ # cosa del nomdel filein
      filein  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_0",as.character(mes),"_CMP24KG_24h_A.tif")
    }else{
      filein  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_",as.character(mes),"_CMP24KG_24h_A.tif")
    }
    
    if(!file.exists(filein)){ # si el fitxer no existeix, no sumem res.
      tif <- 0
    } else {
      tif <- raster(filein)
      sum <- sum + tif
    }

  if(mes == 12){ # escrivim la suma anual
    
    fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/year_agg_XXX_RNN_",
                      as.character(year),
                      "_",
                      "CMP24KG_24h_A.tif")
    
    writeRaster(sum, fileout, overwrite=T)
    
    sum <- 0
    }
  }
}
  print(year)
