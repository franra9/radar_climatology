# Author: Francesc Roura Adserias 29/08/2020
# this script is the main script of the radar_climatology repository

########################################################################
# It is excecuted in the form "Rscript main.R initial_date final_date" #
########################################################################
argv <- commandArgs(trailingOnly = TRUE)
date.ini <- as.Date(x = as.character(argv[1]), format = "%Y%m%d")
date.fin <- as.Date(x = as.character(argv[2]), format = "%Y%m%d")
date.ini <- as.Date(x = as.character(20180201), format = "%Y%m%d") #must be the first day of the month
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
	clim(filein = wrk_files$monthly_24h[[imonth]], outdir = paste0(out, imonth, "_"), length(available.files$not_monthly[[imonth]]), corr=T)
}
