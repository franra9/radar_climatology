# Francesc Roura Adserias # treball final de grau
# this script sums up monthly data to perform anual accumulation.

source("/home/francesc/repositories/radar_climatology/R/TFG.config.R")

year.ini <- format(as.Date(as.character(2015), format="%Y"),"%Y")
year.fin <- format(as.Date(as.character(2016), format="%Y"),"%Y")

filei <- "radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg_corr/monthly_agg_XXX_RNN_"
fileo <- "~/results/radar_SMC_ppt_TFG/CMP24KG_24h/year_agg_corr/"

dir.create(path=fileo, showWarnings=T, recursive=T)

setwd("/home/francesc/data/")

sum <- 0

#### 24h aggregate ####
for(year in year.ini:year.fin){ # 7 anys, dels que volem trobar-ne la suma.
  
  for(month in 1:12){ # recorrem tots els mesos de l'any
    
    if(month < 10){ # cosa del nomdel filein
      filein  <- paste0(filei, as.character(year),"_0",as.character(month),"_CMP24KG_24h_A.tif")
    }else{
      filein  <- paste0(filei, as.character(year),"_",as.character(month),"_CMP24KG_24h_A.tif")
    }
    
    if(!file.exists(filein)){ # si el fitxer no existeix, no sumem res.
      tif <- 0
    } else {
      tif <- raster(filein)
      sum <- sum + tif
    }
print(month)

  if(month == 12){ # escrivim la suma anual
    
    fileout <- paste0(fileo,
		      "year_agg_XXX_RNN_",
                      as.character(year),
                      "_",
                      "CMP24KG_24h_A.tif")
    
    writeRaster(sum, fileout, overwrite=T)
    sum <- 0
    }
  }
}
  print(year); print(paste0("Anual accumulation in each point of the grid saved at saved at ",fileo))
