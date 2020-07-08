# Francesc Roura Adserias # treball final de grau
# this script sums up monthly data to perform anual accumulation.

setwd("/home/francesc/data/")

library(tiff)
library(sp)
library(raster)
library(rgdal)

sum <- 0

#### 24h aggregate ####
for(year in 2015:2016){ # 7 anys, dels que volem trobar-ne la suma.
  
  for(month in 1:12){ # recorrem tots els mesos de l'any
    
    if(month < 10){ # cosa del nomdel filein
      filein  <- paste0("/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_0",as.character(month),"_CMP24KG_24h_A.tif")
    }else{
      filein  <- paste0("/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(year),"_",as.character(month),"_CMP24KG_24h_A.tif")
    }
    
    if(!file.exists(filein)){ # si el fitxer no existeix, no sumem res.
      tif <- 0
    } else {
      tif <- raster(filein)
      sum <- sum + tif
    }

  if(month == 12){ # escrivim la suma anual
    
    fileout <- paste0("~/results/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/year_agg_XXX_RNN_",
                      as.character(year),
                      "_",
                      "CMP24KG_24h_A.tif")
    
    writeRaster(sum, fileout, overwrite=T)
    
    sum <- 0
    }
  }
}
  print(year)
