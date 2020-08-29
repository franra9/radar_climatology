# this script checks if data exists or not

exists.data <- function(date.ini = NULL, date.fin = NULL, data.dir = NULL)
{

dates <- seq(date.ini, date.fin, by="days")
yyyy <- format(dates,"%Y")
mm   <- format(dates,"%m")
dd   <- format(dates,"%d")
hh   <- c(paste0("0",1:9), 10:24)

daily_file  <- file.exists(paste0(data.dir,"/CMP24KG_24h/XXX/",yyyy,"/",mm,"/",dd,"/XXX_RNN_",yyyy,mm,dd,"_0000_CMP24KG_24h.tif"))
exist_daily <- paste0("/CMP24KG_24h/XXX/",yyyy,"/",mm,"/",dd,"/XXX_RNN_",yyyy,mm,dd,"_0000_CMP24KG_24h.tif")
exist_dailyi <- exist_daily[daily_file]

hourly_file  <- file.exists(paste0(data.dir,"/CMPAC1C_1h/",yyyy,"/",mm,"/",dd,"/XXX_RN1_",yyyy,mm,dd,"_",hh,"00_CMPAC1C_1h.tif"))
exist_hourly <- paste0("/CMPAC1C_1h/",yyyy,"/",mm,"/",dd,"/XXX_RN1_",yyyy,mm,dd,"_",hh,"00_CMPAC1C_1h.tif")
exist_hourlyi <- exist_hourly[hourly_file]

avail_files <- list("daily"=exist_dailyi, "hourly"=exist_hourlyi)
return(avail_files)
}

