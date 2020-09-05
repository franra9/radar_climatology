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

available.files <- list("daily"=exist_dailyi, "hourly"=exist_hourlyi, "dat_day"=daily_file, "dat_hour"=hourly_file)

monthly.files <- list(NULL)
jan<-feb <-mar<- apr<- may<- jun<- jul<- aug<- sep<- oct<- nov<- dec<- c()

for(daily_file){
	if(mm=="01"){jan <- append(jan, daily_file) }
	if(mm=="02"){jan <- append(jan, daily_file) }
	if(mm=="03"){jan <- append(jan, daily_file) }
	if(mm=="04"){jan <- append(jan, daily_file) }
	if(mm=="05"){jan <- append(jan, daily_file) }
	.
	.
	.
	if(mm=="12"){}
}
monthly.files <- 
}

