# this script checks if data exists or not and exits a list of files and their respective year.

exists_data <- function(date.ini = NULL, date.fin = NULL, data.dir = NULL)
{

#find all years, months days and hours that are enclosed in the study period
dates <- seq(date.ini, date.fin, by="days")
yyyy <- format(dates,"%Y")
mm   <- format(dates,"%m")
dd   <- format(dates,"%d")
hh   <- c(paste0("0",0:9), 10:23)
yyyy24 <- rep(yyyy, each = 24) #repeat year 24 times for each day

all_dly <- paste0("/CMP24KG_24h/XXX/",yyyy,"/",mm,"/",dd,"/XXX_RNN_",yyyy,mm,dd,"_0000_CMP24KG_24h.tif")
exist_dly  <- file.exists(paste0(data.dir,all_dly))
exist_dailyi <- all_dly[exist_dly]
yyyyd <- yyyy[exist_dly]

all_hrly1 <- paste0("/CMPAC1C_1h/",yyyy,"/",mm,"/",dd,"/XXX_RN1_",yyyy,mm,dd,"_")
all_hrly <- paste0(expand.grid(hh, all_hrly1)$Var2, expand.grid(hh, all_hrly1)$Var1, "00_CMPAC1C_1h.tif")

exist_hrly  <- file.exists(paste0(data.dir,all_hrly))
exist_hourlyi <- all_hrly[exist_hrly]
yyyyh <- yyyy24[exist_hrly]

available.files <- list("daily"=exist_dailyi, "hourly"=exist_hourlyi, "dat_day"=exist_dly, "dat_hour"=exist_hrly)

jan24 <- feb24 <- mar24 <- apr24 <- may24 <- jun24 <- jul24 <- aug24 <- sep24 <- oct24 <- nov24 <- dec24 <- c(NULL)

jan1 <- feb1 <- mar1 <- apr1 <- may1 <- jun1 <- jul1 <- aug1 <- sep1 <- oct1 <- nov1 <- dec1 <- c(NULL)

tjan24 <- tfeb24 <- tmar24 <- tapr24 <- tmay24 <- tjun24 <- tjul24 <- taug24 <- tsep24 <- toct24 <- tnov24 <- tdec24 <- c(NULL)

tjan1 <- tfeb1 <- tmar1 <- tapr1 <- tmay1 <- tjun1 <- tjul1 <- taug1 <- tsep1 <- toct1 <- tnov1 <- tdec1 <- c(NULL)

i<-1
#24h aggregation
for(mm in mm[exist_dly]){
	if(mm == "01"){jan24 <- append(jan24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "02"){feb24 <- append(feb24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "03"){mar24 <- append(mar24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "04"){apr24 <- append(apr24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "05"){may24 <- append(may24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "06"){jun24 <- append(jun24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "07"){jul24 <- append(jul24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "08"){aug24 <- append(aug24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "09"){sep24 <- append(sep24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "10"){oct24 <- append(oct24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "11"){nov24 <- append(nov24, c(exist_dailyi[i], yyyyd[i])) }
	if(mm == "12"){dec24 <- append(dec24, c(exist_dailyi[i], yyyyd[i])) }
i <- i+1
}

j <- 1
#1hour aggregation
mmddhh <- paste0(expand.grid(hh,dd,mm)$Var3, expand.grid(hh,dd,mm)$Var2, expand.grid(hh,dd,mm)$Var1)
for(mmddhh in mmddhh[exist_hrly]){
	mon <- substr(mmddhh,1,2)
	if(mon == "01"){jan1 <- append(jan1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "02"){feb1 <- append(feb1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "03"){mar1 <- append(mar1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "04"){apr1 <- append(apr1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "05"){may1 <- append(may1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "06"){jun1 <- append(jun1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "07"){jul1 <- append(jul1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "08"){aug1 <- append(aug1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "09"){sep1 <- append(sep1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "10"){oct1 <- append(oct1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "11"){nov1 <- append(nov1, c(exist_hourlyi[j], yyyyh[j])) }
	if(mon == "12"){dec1 <- append(dec1, c(exist_hourlyi[j], yyyyh[j])) }
print(j)
j<- j+1
}

#try() because t() does not like NULL values

#dayly
try(tjan24 <- t(array(data = jan24, dim = c(2, length(jan24)/2))))
try(tfeb24 <- t(array(data = feb24, dim = c(2, length(feb24)/2))))
try(tmar24 <- t(array(data = mar24, dim = c(2, length(mar24)/2))))
try(tapr24 <- t(array(data = apr24, dim = c(2, length(apr24)/2))))
try(tmay24 <- t(array(data = may24, dim = c(2, length(may24)/2))))
try(tjun24 <- t(array(data = jun24, dim = c(2, length(jun24)/2))))
try(tjul24 <- t(array(data = jul24, dim = c(2, length(jul24)/2))))
try(taug24 <- t(array(data = aug24, dim = c(2, length(aug24)/2))))
try(tsep24 <- t(array(data = sep24, dim = c(2, length(sep24)/2))))
try(toct24 <- t(array(data = oct24, dim = c(2, length(oct24)/2))))
try(tnov24 <- t(array(data = nov24, dim = c(2, length(nov24)/2))))
try(tdec24 <- t(array(data = dec24, dim = c(2, length(dec24)/2))))

#hourly
try(tjan1 <- t(array(data = jan1, dim = c(2, length(jan1)/2))))
try(tfeb1 <- t(array(data = feb1, dim = c(2, length(feb1)/2))))
try(tmar1 <- t(array(data = mar1, dim = c(2, length(mar1)/2))))
try(tapr1 <- t(array(data = apr1, dim = c(2, length(apr1)/2))))
try(tmay1 <- t(array(data = may1, dim = c(2, length(may1)/2))))
try(tjun1 <- t(array(data = jun1, dim = c(2, length(jun1)/2))))
try(tjul1 <- t(array(data = jul1, dim = c(2, length(jul1)/2))))
try(taug1 <- t(array(data = aug1, dim = c(2, length(aug1)/2))))
try(tsep1 <- t(array(data = sep1, dim = c(2, length(sep1)/2))))
try(toct1 <- t(array(data = oct1, dim = c(2, length(oct1)/2))))
try(tnov1 <- t(array(data = nov1, dim = c(2, length(nov1)/2))))
try(tdec1 <- t(array(data = dec1, dim = c(2, length(dec1)/2))))

files.by.month <- list("monthly_24h" = list("jan" = tjan24,
					 "feb" = tfeb24,
					 "mar" = tmar24,
					 "apr" = tapr24,
					 "may" = tmay24,
					 "jun" = tjun24,
					 "jul" = tjul24,
					 "aug" = taug24,
					 "sep" = tsep24,
					 "oct" = toct24,
					 "nov" = tnov24,
					 "dec" = tdec24),
			"monthly_1h" = list("jan" = tjan1,
					 "feb" = tfeb1,
					 "mar" = tmar1,
					 "apr" = tapr1,
					 "may" = tmay1,
					 "jun" = tjun1,
					 "jul" = tjul1,
					 "aug" = taug1,
					 "sep" = tsep1,
					 "oct" = toct1,
					 "nov" = tnov1,
					 "dec" = tdec1))
return(files.by.month)
}


