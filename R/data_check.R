# this script checks if data exists or not

exists.data <- function(date.ini = NULL, date.fin = NULL, data.dir = NULL)
{

dates <- seq(date.ini, date.fin, by="days")
yyyy <- format(dates,"%Y")
mm   <- format(dates,"%m")
dd   <- format(dates,"%d")
hh   <- c(paste0("0",1:9), 10:24)

daily_file  <- file.exists(paste0(data.dir,"/CMP24KG_24h/XXX/",yyyy,"/",mm,"/",dd,"/XXX_RNN_",yyyy,mm,dd,"_0000_CMP24KG_24h.tif"))
hourly_file <- file.exists(paste0(data.dir,"/",yyyy))

file_dates <- list("daily"=daily_file, "hourly"=hourly_file)
return(file_dates)
}

