# this script applies a correction factor to the monthly sum depending on the number of missing days.
#FRA 07 12 2019

#library(tiff)
#library(sp)
#library(raster)
#library(rgdal)

wd <- "~/results/radar_SMC_ppt_TFG/CMP24KG_24h/"
mis_fil_perc <- "/home/francesc/data/radar_SMC_ppt_TFG/CMP24KG_24h/percentatge_dies_sense_dades_13-19.txt"

setwd(wd)

llindar <- 80

percent <- read.table(mis_fil_perc, header = T)

for(i in 1:length(percent$year)){
  
  if(percent$month[i]<10){
    month  <- paste0(0,percent$month[i])
  }else{
    month  <- percent$month[i]
  }
  
  filein  <- paste0(wd,"monthly_agg/monthly_agg_XXX_RNN_",as.character(percent$year[i]),"_",month,"_CMP24KG_24h_A.tif")
  
  if(!file.exists(filein)){
    print(filein)
    stop("the previous file does not exist.")
    
  }

  if(percent$perc_exist[i] < llindar){
    print(paste0("el fitxer ", filein ," està per sota del ", llindar ," % de consistència de dades i no es considerarà"))
  } else {
    
  tif <- raster(filein)
  # tif0 <-raster(filein)
  
  tif <- tif*1/(percent$perc_exist[i]/100)
    
  fileout <- paste0(wd,"monthly_agg_corr/monthly_agg_XXX_RNN_",as.character(percent$year[i]),"_",month,"_CMP24KG_24h_A.tif")
  print(fileout)
  writeRaster(tif, fileout, overwrite=T)
  }
}

print(paste0("Monthly corrected accumulations with a threshold of ",llindar ,"% of existing data have been saved at ", fileout))

