########################################################################
# Author: Francesc Roura Adserias 29/08/2020
# This script is the main script of the radar_climatology repository
# It is executed in the form "Rscript main.R initial_date final_date" #
########################################################################

# input arguments
argv <- commandArgs(trailingOnly = TRUE)
date.ini <- as.Date(x = as.character(argv[1]), format = "%Y%m%d")
date.fin <- as.Date(x = as.character(argv[2]), format = "%Y%m%d")
date.ini <- as.Date(x = as.character(20130101), format = "%Y%m%d") #must be the first day of the month
date.ini <- as.Date(x = as.character(20141231), format = "%Y%m%d") #must be the first day of the month
#date.fin <- as.Date(x = as.character(20210331), format = "%Y%m%d") #must be the last day of the month

#sanity check
if(date.ini < as.Date(x = as.character(20130101), format = "%Y%m%d")) {
	stop(paste0("Initial date ", date.ini, " is out of range"))
} else if (date.fin > as.Date(x = as.character(20210331), format = "%Y%m%d")){
	stop(paste0("End date ", date.fin, " is out of range"))
}

#load other scripts
source("./config.R")
source("./clim.R")
source("./data_check.R")
source("./cut.R")

available.files <- exists_data(date.ini, date.fin, data.dir) # list with available and not available files

months = tolower(month.abb)

wrk_files <- list()
ppt_low <- list()
ppt_mod <- list()
ppt_high <- list()
event_low <- list()
event_mod <- list()
event_high <- list()

ppt_low0 <- ppt_mod0 <- ppt_high0 <- event_low0 <- event_mod0 <- event_high0 <- 0

month_fileout <- NULL #array containing monthly filenames 

#cut files according to shapefile intensity (1h) or daily (24h) accumulation files
for (imonth in months) {
	month <- paste0("(", imonth, ")")
	if (!int_an){ 
	  cut_files(available.files$monthly_24h[[imonth]][,1], shp.dir, outdir)
	}

	if (int_an) {
		cut_files(available.files$monthly_1h[[imonth]][,1], shp.dir, outdir)
	}

	# list of working cut files daily
	if (!int_an){
	  wrk_files$monthly_24h[[imonth]] <- array(c(paste0(outdir, shp.name, available.files$monthly_24h[[imonth]][,1]),
					available.files$monthly_24h[[imonth]][,2]),
					dim=c(length(available.files$monthly_24h[[imonth]][,2]), 2))
	}

	# list of working cut files hourly
	if (int_an) {
		wrk_files$monthly_1h[[imonth]] <- array(c(paste0(outdir, shp.name, available.files$monthly_1h[[imonth]][,1]),
					available.files$monthly_1h[[imonth]][,2]),
					dim=c(length(available.files$monthly_1h[[imonth]][,2]), 2))
	}

	# Monthy stats 24h
	if (!int_an){
	  out <- paste0(outdir, shp.name, "/month/")
	  dir.create(out, recursive = T)
	  outdir1 = paste0(out, imonth, "_")
	  filein = wrk_files$monthly_24h[[imonth]]
	
	  clim(filein, outdir1, length(available.files$not_monthly_24h[[imonth]]), corr=T)
	  
	  month_fileout <- c(month_fileout, paste0(outdir1, 
	                                           levels(factor(filein[,2]))[1],
	                                           "-",
	                                           levels(factor(filein[,2]))[length(levels(factor(filein[,2])))],
	                                           "_corr",
	                                           ".tif"))
	}
	# Monthy stats 1h
	if (int_an){
	  out <- paste0(outdir, shp.name, "/month_int/")
	  dir.create(out, recursive = T)
	  outdir1 = paste0(out, imonth, "_")
	  filein = wrk_files$monthly_1h[[imonth]]

	  clim(filein, outdir1, length(available.files$not_monthly_1h[[imonth]]), corr=T)
	}
}

# create output subdirs

dir.create(outdir, paste0(shp.name, "/seas"), recursive = T)
dir.create(outdir, paste0(shp.name, "/anual"), recursive = T)

if (!int_an){
  # Seasonal stats
  #sumar de 3 en 3
  djf <- sum(raster(month_fileout[12]), 
 	  	raster(month_fileout[1]),
 	  	raster(month_fileout[2]))
  mam <- sum(raster(month_fileout[3]), 
 	  	raster(month_fileout[4]),
 		  raster(month_fileout[5]))
  jja <- sum(raster(month_fileout[6]), 
  		raster(month_fileout[7]),
  		raster(month_fileout[8]))
  son <- sum(raster(month_fileout[9]), 
  		raster(month_fileout[10]),
  		raster(month_fileout[11]))
    
  writeRaster(djf , paste0(outdir, shp.name, "/djf.tif"), overwrite = T)
  writeRaster(mam , paste0(outdir, shp.name, "/mam.tif"), overwrite = T)
  writeRaster(jja , paste0(outdir, shp.name, "/jja.tif"), overwrite = T)
  writeRaster(son , paste0(outdir, shp.name, "/son.tif"), overwrite = T)

    print(paste0("Seasonal mean written at ", data.dir, shp.name, "/"))

  # Annual stats
   # tots
   anual <- sum(raster(month_fileout[1]), 
  		raster(month_fileout[2]),
  		raster(month_fileout[3]),
  		raster(month_fileout[4]), 
  		raster(month_fileout[5]),
  		raster(month_fileout[6]),
  		raster(month_fileout[7]), 
  		raster(month_fileout[8]),
  		raster(month_fileout[9]),
  		raster(month_fileout[10]), 
  		raster(month_fileout[11]),
  		raster(month_fileout[12]))
 		
    writeRaster(anual , paste0(outdir, shp.name, "/anual.tif"), overwrite = T)
    print(paste0("Anual mean written at ", data.dir, shp.name, "/"))
}

# intensity (hourly) analysis
if(int_an){
  for (imonth in months) {
    # select days with non 0 ppt
    filein = wrk_files$monthly_1h[[imonth]]
    for(i in 1:length(filein[,1])){  	
      tif <- tif0 <- raster(filein[i,1])
      if(maxValue(tif) > 0){
      
        #count events intensities 0, 0.3, 0.8 mm/h ### change it 3,7.6
        event_low <- (tif > 0 & tif < 3 )
        event_mod  <- (tif >= 3 & tif <= 7.6 )
        event_high  <- (tif > 7.6)
      
        event_low0 <- event_low + event_low0
        event_mod0 <- event_mod + event_mod0
        event_high0 <- event_high + event_high0
        
        #count precipitation acumulation in different intensity events
        ppt_low <- mask(tif0, event_low, maskvalue=0,updatevalue=0)
        ppt_mod <- mask(tif0, event_mod, maskvalue=0,updatevalue=0)
        ppt_high <- mask(tif0, event_high, maskvalue=0,updatevalue=0) 
      
        ppt_low0 <- ppt_low + ppt_low0
        ppt_mod0 <- ppt_mod + ppt_mod0
        ppt_high0 <- ppt_high + ppt_high0
      }
    }
    writeRaster(event_low0, paste0(outdir, shp.name, "/month_int/event_low_", imonth, ".tif"), overwrite=T)
    writeRaster(event_mod0, paste0(outdir, shp.name, "/month_int/event_mod_", imonth, ".tif"), overwrite=T)
    writeRaster(event_high0, paste0(outdir, shp.name, "/month_int/event_high_", imonth, ".tif"), overwrite=T)
    print(paste0(imonth, " event count completed"))
    
    writeRaster(ppt_low0, paste0(outdir, shp.name, "/month_int/ppt_low_", imonth, ".tif"), overwrite=T)
    writeRaster(ppt_mod0, paste0(outdir, shp.name, "/month_int/ppt_mod_", imonth, ".tif"), overwrite=T)
    writeRaster(ppt_high0, paste0(outdir, shp.name, "/month_int/ppt_high_", imonth, ".tif"), overwrite=T)
    print(paste0(imonth, " ppt acumulation completed"))
    
    # reinitialize
    ppt_low0 <- ppt_mod0 <- ppt_high0 <- event_low0 <- event_mod0 <- event_high0 <- 0
    
  }
}
  
