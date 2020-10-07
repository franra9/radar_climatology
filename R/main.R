# Author: Francesc Roura Adserias 29/08/2020
# this script is the main script of the radar_climatology repository

########################################################################
# It is excecuted in the form "Rscript main.R initial_date final_date" #
########################################################################
  argv <- commandArgs(trailingOnly = TRUE)
  date.ini <- as.Date(x = as.character(argv[1]), format = "%Y%m%d")
  date.fin <- as.Date(x = as.character(argv[2]), format = "%Y%m%d")
  date.ini <- as.Date(x = as.character(20180101), format = "%Y%m%d")
  date.fin <- as.Date(x = as.character(20190301), format = "%Y%m%d")

if(date.ini < as.Date(x = as.character(20130101), format = "%Y%m%d")) {
	stop(paste0("Initial date ", date.ini, " is out of range"))
} else if (date.fin > as.Date(x = as.character(20191001), format = "%Y%m%d")){
	stop(paste0("End date ", date.fin, " is out of range"))
}

# load configuration file
source("./config.R")
# load clim function
source("./clim.R")

# load create available data vectors function
source("./data_check.R")

available.files <- exists_data(date.ini, date.fin, data.dir)

#load funtions to cut files
source("./cut.R")

#daily_cut
month <- "(jan)"
cut_files(available.files$monthly_24h$jan[,1], shp.dir, outdir)
month <- "(feb)"
cut_files(available.files$monthly_24h$feb[,1], shp.dir, outdir)
month <- "(mar)"
cut_files(available.files$monthly_24h$mar[,1], shp.dir, outdir)
month <- "(apr)"
cut_files(available.files$monthly_24h$apr[,1], shp.dir, outdir)
month <- "(may)"
cut_files(available.files$monthly_24h$may[,1], shp.dir, outdir)
month <- "(jun)"
cut_files(available.files$monthly_24h$jun[,1], shp.dir, outdir)
month <- "(jul)"
cut_files(available.files$monthly_24h$jul[,1], shp.dir, outdir)
month <- "(aug)"
cut_files(available.files$monthly_24h$aug[,1], shp.dir, outdir)
month <- "(sep)"
cut_files(available.files$monthly_24h$sep[,1], shp.dir, outdir)
month <- "(oct)"
cut_files(available.files$monthly_24h$oct[,1], shp.dir, outdir)
month <- "(nov)"
cut_files(available.files$monthly_24h$nov[,1], shp.dir, outdir)
month <- "(dec)"
cut_files(available.files$monthly_24h$dec[,1], shp.dir, outdir)

#hourly cut
if(int_an){
	cut_files(available.files$monthly_1h$jan[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$feb[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$mar[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$apr[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$may[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$jun[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$jul[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$aug[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$sep[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$oct[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$nov[,1], shp.dir, outdir)
	cut_files(available.files$monthly_1h$dec[,1], shp.dir, outdir)
}

#working cut files daily
wrk_files <- list()
wrk_files$monthly_24h$jan <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$jan[,1]),
					available.files$monthly_24h$jan[,2]),
					dim=c(length(available.files$monthly_24h$jan[,2]), 2))
wrk_files$monthly_24h$feb <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$feb[,1]),
					available.files$monthly_24h$feb[,2]),
					dim=c(length(available.files$monthly_24h$feb[,2]), 2))
wrk_files$monthly_24h$mar <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$mar[,1]),
					available.files$monthly_24h$mar[,2]),
					dim=c(length(available.files$monthly_24h$mar[,2]), 2))
wrk_files$monthly_24h$apr <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$apr[,1]),
					available.files$monthly_24h$apr[,2]),
					dim=c(length(available.files$monthly_24h$apr[,2]), 2))
wrk_files$monthly_24h$may <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$may[,1]),
					available.files$monthly_24h$may[,2]),
					dim=c(length(available.files$monthly_24h$may[,2]), 2))
wrk_files$monthly_24h$jun <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$jun[,1]),
					available.files$monthly_24h$jun[,2]),
					dim=c(length(available.files$monthly_24h$jun[,2]), 2))
wrk_files$monthly_24h$jul <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$jul[,1]),
					available.files$monthly_24h$jul[,2]),
					dim=c(length(available.files$monthly_24h$jul[,2]), 2))
wrk_files$monthly_24h$aug <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$aug[,1]),
					available.files$monthly_24h$aug[,2]),
					dim=c(length(available.files$monthly_24h$aug[,2]), 2))
wrk_files$monthly_24h$sep <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$sep[,1]),
					available.files$monthly_24h$sep[,2]),
					dim=c(length(available.files$monthly_24h$sep[,2]), 2))
wrk_files$monthly_24h$oct <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$oct[,1]),
					available.files$monthly_24h$oct[,2]),
					dim=c(length(available.files$monthly_24h$oct[,2]), 2))
wrk_files$monthly_24h$nov <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$nov[,1]),
					available.files$monthly_24h$nov[,2]),
					dim=c(length(available.files$monthly_24h$nov[,2]), 2))
wrk_files$monthly_24h$dec <- array(c(paste0(outdir, shp.name, available.files$monthly_24h$dec[,1]),
					available.files$monthly_24h$dec[,2]),
					dim=c(length(available.files$monthly_24h$dec[,2]), 2))

#working cut files hourly
wrk_files$monthly_1h$jan <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$jan[,1]),
					available.files$monthly_1h$jan[,2]),
					dim=c(length(available.files$monthly_1h$jan[,2]), 2))
wrk_files$monthly_1h$feb <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$feb[,1]),
					available.files$monthly_1h$feb[,2]),
					dim=c(length(available.files$monthly_1h$feb[,2]), 2))
wrk_files$monthly_1h$mar <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$mar[,1]),
					available.files$monthly_1h$mar[,2]),
					dim=c(length(available.files$monthly_1h$mar[,2]), 2))
wrk_files$monthly_1h$apr <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$apr[,1]),
					available.files$monthly_1h$apr[,2]),
					dim=c(length(available.files$monthly_1h$apr[,2]), 2))
wrk_files$monthly_1h$may <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$may[,1]),
					available.files$monthly_1h$may[,2]),
					dim=c(length(available.files$monthly_1h$may[,2]), 2))
wrk_files$monthly_1h$jun <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$jun[,1]),
					available.files$monthly_1h$jun[,2]),
					dim=c(length(available.files$monthly_1h$jun[,2]), 2))
wrk_files$monthly_1h$jul <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$jul[,1]),
					available.files$monthly_1h$jul[,2]),
					dim=c(length(available.files$monthly_1h$jul[,2]), 2))
wrk_files$monthly_1h$aug <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$aug[,1]),
					available.files$monthly_1h$aug[,2]),
					dim=c(length(available.files$monthly_1h$aug[,2]), 2))
wrk_files$monthly_1h$sep <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$sep[,1]),
					available.files$monthly_1h$sep[,2]),
					dim=c(length(available.files$monthly_1h$sep[,2]), 2))
wrk_files$monthly_1h$oct <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$oct[,1]),
					available.files$monthly_1h$oct[,2]),
					dim=c(length(available.files$monthly_1h$oct[,2]), 2))
wrk_files$monthly_1h$nov <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$nov[,1]),
					available.files$monthly_1h$nov[,2]),
					dim=c(length(available.files$monthly_1h$nov[,2]), 2))
wrk_files$monthly_1h$dec <- array(c(paste0(outdir, shp.name, available.files$monthly_1h$dec[,1]),
					available.files$monthly_1h$dec[,2]),
					dim=c(length(available.files$monthly_1h$dec[,2]), 2))

#load functions to do temporal aggregations
#monthly stats
out <- paste0(outdir, shp.name, "/month/")
dir.create(out, recursive = T)

clim(filein = wrk_files$monthly_24h$jan, outdir = paste0(out, "jan_"))
clim(filein = wrk_files$monthly_24h$feb, outdir = paste0(out, "feb_"))
clim(filein = wrk_files$monthly_24h$mar, outdir = paste0(out, "mar_"))
clim(filein = wrk_files$monthly_24h$apr, outdir = paste0(out, "apr_"))
clim(filein = wrk_files$monthly_24h$may, outdir = paste0(out, "may_"))
clim(filein = wrk_files$monthly_24h$jun, outdir = paste0(out, "jun_"))
clim(filein = wrk_files$monthly_24h$jul, outdir = paste0(out, "jul_"))
clim(filein = wrk_files$monthly_24h$aug, outdir = paste0(out, "aug_"))
clim(filein = wrk_files$monthly_24h$sep, outdir = paste0(out, "sep_"))
clim(filein = wrk_files$monthly_24h$oct, outdir = paste0(out, "oct_"))
clim(filein = wrk_files$monthly_24h$nov, outdir = paste0(out, "nov_"))
clim(filein = wrk_files$monthly_24h$dec, outdir = paste0(out, "dec_"))

#seasonal stats
#seas_stats <- T
#if(seas_stats){
#	outdir <- paste0(outdir, shp.name, "/seas/", )
#	clim(wrk_files$monthly_24h$jan, outdir)
#}

#yearly stats
#year_stats <- T
#if(year_stats){
#	outdir <- paste0(outdir, shp.name, "/year/", )
#	clim(wrk_files$monthly_24h$jan, outdir)
#}

