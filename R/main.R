# Author: Francesc Roura Adserias 29/08/2020
# this script is the main script of the radar_climatology repository

########################################################################
# It is excecuted in the form "Rscript main.R initial_date final_date" #
########################################################################
argv <- commandArgs(trailingOnly = TRUE)
date.ini <- as.Date(x = as.character(argv[1]), format = "%Y%m%d")
date.fin <- as.Date(x = as.character(argv[2]), format = "%Y%m%d")
date.ini <- as.Date(x = as.character(20130101), format = "%Y%m%d") #must be the first day of the month
date.fin <- as.Date(x = as.character(20190930), format = "%Y%m%d") #must be the last day of the month

if(date.ini < as.Date(x = as.character(20130101), format = "%Y%m%d")) {
	stop(paste0("Initial date ", date.ini, " is out of range"))
} else if (date.fin > as.Date(x = as.character(20191001), format = "%Y%m%d")){
	stop(paste0("End date ", date.fin, " is out of range"))
}

source("./config.R")
source("./clim.R")
source("./data_check.R")
source("./cut.R")

available.files <- exists_data(date.ini, date.fin, data.dir) # list with available and not available files

months = tolower(month.abb)

wrk_files <- list()
month_fileout <- NULL #array containing monthly filenames

for (imonth in months) {
	month <- paste0("(", imonth, ")")
	cut_files(available.files$monthly_24h[[imonth]][,1], shp.dir, outdir)

	if (int_an) {
		cut_files(available.files$monthly_1h[[imonth]][,1], shp.dir, outdir)
	}

	#working cut files daily
	wrk_files$monthly_24h[[imonth]] <- array(c(paste0(outdir, shp.name, available.files$monthly_24h[[imonth]][,1]),
					available.files$monthly_24h[[imonth]][,2]),
					dim=c(length(available.files$monthly_24h[[imonth]][,2]), 2))

	if (int_an) {
		wrk_files$monthly_1h[[imonth]][,1] <- array(c(paste0(outdir, shp.name, available.files$monthly_1h[[imonth]][,1]),
					available.files$monthly_1h[[imonth]][,2]),
					dim=c(length(available.files$monthly_1h[[imonth]][,2]), 2))
	}

	# Monthy stats
	out <- paste0(outdir, shp.name, "/month/")
	dir.create(out, recursive = T)
	outdir1 = paste0(out, imonth, "_")
	filein = wrk_files$monthly_24h[[imonth]]
	
	clim(filein, outdir1, length(available.files$not_monthly[[imonth]]), corr=T)
	
	month_fileout <- c(month_fileout, paste0(outdir1, 
		levels(factor(filein[,2]))[1],
		"-",
		levels(factor(filein[,2]))[length(levels(factor(filein[,2])))],
		"_corr",
		".tif"))
}

dir.create(outdir, paste0(shp.name, "/seas"), recursive = T)
dir.create(outdir, paste0(shp.name, "/anual"), recursive = T)

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
print(paste0("Seasonal mean written at ", data.dir, shp.name, "/"))
