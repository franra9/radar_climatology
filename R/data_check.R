# this script checks if data exists or not and exits a list of files and their respective year.
# Author: froura 2021
#

exists_data <- function(date.ini = NULL, date.fin = NULL, data.dir = NULL)
{

#find all years, months days and hours that are enclosed in the study period
dates <- seq(date.ini, date.fin, by = "days")
yyyy <- format(dates,"%Y")
mm   <- format(dates,"%m")
dd   <- format(dates,"%d")
hh   <- c(paste0("0",0:9), 10:23)
yyyy24 <- rep(yyyy, each = 24) #repeat year 24 times for each day

## in daily steps
all_dly <- paste0("/CMP24KG_24h/XXX/",yyyy,"/",mm,"/",dd,"/XXX_RNN_",yyyy,mm,dd,"_0000_CMP24KG_24h.tif")
exist_dly  <- file.exists(paste0(data.dir,all_dly))
exist_dailyi <- all_dly[exist_dly]
yyyyd <- yyyy[exist_dly]
nexist_dailyi <- all_dly[!exist_dly]
nyyyyd <- yyyy[!exist_dly]

all_hrly1 <- paste0("/CMPAC1C_1h/",yyyy,"/",mm,"/",dd,"/XXX_RN1_",yyyy,mm,dd,"_")
all_hrly <- paste0(expand.grid(hh, all_hrly1)$Var2, expand.grid(hh, all_hrly1)$Var1, "00_CMPAC1C_1h.tif")

## in hourly steps
exist_hrly  <- file.exists(paste0(data.dir,all_hrly))
exist_hourlyi <- all_hrly[exist_hrly]
yyyyh <- yyyy24[exist_hrly]
nexist_hourlyi <- all_hrly[!exist_hrly]
nyyyyh <- yyyy24[!exist_hrly]

#initialize variables

jan24 <- feb24 <- mar24 <- apr24 <- may24 <- jun24 <- jul24 <- aug24 <- sep24 <- oct24 <- nov24 <- dec24 <- c(NULL)
njan24 <- nfeb24 <- nmar24 <- napr24 <- nmay24 <- njun24 <- njul24 <- naug24 <- nsep24 <- noct24 <- nnov24 <- ndec24 <- c(NULL)

jan1 <- feb1 <- mar1 <- apr1 <- may1 <- jun1 <- jul1 <- aug1 <- sep1 <- oct1 <- nov1 <- dec1 <- c(NULL)
njan1 <- nfeb1 <- nmar1 <- napr1 <- nmay1 <- njun1 <- njul1 <- naug1 <- nsep1 <- noct1 <- nnov1 <- ndec1 <- c(NULL)

tjan24 <- tfeb24 <- tmar24 <- tapr24 <- tmay24 <- tjun24 <- tjul24 <- taug24 <- tsep24 <- toct24 <- tnov24 <- tdec24 <- c(NULL)
ntjan24 <- ntfeb24 <- ntmar24 <- ntapr24 <- ntmay24 <- ntjun24 <- ntjul24 <- ntaug24 <- ntsep24 <- ntoct24 <- ntnov24 <- ntdec24 <- c(NULL)

tjan1 <- tfeb1 <- tmar1 <- tapr1 <- tmay1 <- tjun1 <- tjul1 <- taug1 <- tsep1 <- toct1 <- tnov1 <- tdec1 <- c(NULL)
ntjan1 <- ntfeb1 <- ntmar1 <- ntapr1 <- ntmay1 <- ntjun1 <- ntjul1 <- ntaug1 <- ntsep1 <- ntoct1 <- ntnov1 <- ntdec1 <- c(NULL)

i<-1
#existing files, 24h aggregation
for(mmm in mm[exist_dly]){
	if(mmm == "01"){jan24 <- append(jan24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "02"){feb24 <- append(feb24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "03"){mar24 <- append(mar24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "04"){apr24 <- append(apr24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "05"){may24 <- append(may24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "06"){jun24 <- append(jun24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "07"){jul24 <- append(jul24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "08"){aug24 <- append(aug24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "09"){sep24 <- append(sep24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "10"){oct24 <- append(oct24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "11"){nov24 <- append(nov24, c(exist_dailyi[i], yyyyd[i])) }
	if(mmm == "12"){dec24 <- append(dec24, c(exist_dailyi[i], yyyyd[i])) }
i <- i+1
}

i<-1
#non existing files, 24h aggregation
if(!isTRUE(exist_dly)){
for(mmm in mm[!exist_dly]){
	if(mmm == "01"){njan24 <- append(njan24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "02"){nfeb24 <- append(nfeb24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "03"){nmar24 <- append(nmar24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "04"){napr24 <- append(napr24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "05"){nmay24 <- append(nmay24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "06"){njun24 <- append(njun24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "07"){njul24 <- append(njul24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "08"){naug24 <- append(naug24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "09"){nsep24 <- append(nsep24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "10"){noct24 <- append(noct24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "11"){nnov24 <- append(nnov24, c(nexist_dailyi[i], nyyyyd[i])) }
	if(mmm == "12"){ndec24 <- append(ndec24, c(nexist_dailyi[i], nyyyyd[i])) }
i <- i+1
}
}

j <- 1
#existing files, 1hour aggregation
mmddhh <- paste0(expand.grid(hh, paste0(mm,dd))$Var2, expand.grid(hh, paste0(mm,dd))$Var1)
for(mmddhh1 in mmddhh[exist_hrly]){
	mon <- substr(mmddhh1,1,2)
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
j<- j+1
}

j <- 1
#not existing files, 1hour aggregation
if(!isTRUE(exist_hrly)){
mmddhh <- paste0(expand.grid(hh, paste0(mm,dd))$Var2, expand.grid(hh, paste0(mm,dd))$Var1)
for(mmddhh1 in mmddhh[!exist_hrly]){
	mon <- substr(mmddhh1,1,2)
	if(mon == "01"){njan1 <- append(njan1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "02"){nfeb1 <- append(nfeb1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "03"){nmar1 <- append(nmar1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "04"){napr1 <- append(napr1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "05"){nmay1 <- append(nmay1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "06"){njun1 <- append(njun1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "07"){njul1 <- append(njul1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "08"){naug1 <- append(naug1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "09"){nsep1 <- append(nsep1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "10"){noct1 <- append(noct1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "11"){nnov1 <- append(nnov1, c(nexist_hourlyi[j], nyyyyh[j])) }
	if(mon == "12"){ndec1 <- append(ndec1, c(nexist_hourlyi[j], nyyyyh[j])) }
j<- j+1
}
}

#t() does not like NULL values
#dayly
if(!is.null(jan24)){tjan24 <- t(array(data = jan24, dim = c(2, length(jan24)/2)))}
if(!is.null(feb24)){tfeb24 <- t(array(data = feb24, dim = c(2, length(feb24)/2)))}
if(!is.null(mar24)){tmar24 <- t(array(data = mar24, dim = c(2, length(mar24)/2)))}
if(!is.null(apr24)){tapr24 <- t(array(data = apr24, dim = c(2, length(apr24)/2)))}
if(!is.null(may24)){tmay24 <- t(array(data = may24, dim = c(2, length(may24)/2)))}
if(!is.null(jun24)){tjun24 <- t(array(data = jun24, dim = c(2, length(jun24)/2)))}
if(!is.null(jul24)){tjul24 <- t(array(data = jul24, dim = c(2, length(jul24)/2)))}
if(!is.null(oct24)){taug24 <- t(array(data = aug24, dim = c(2, length(aug24)/2)))}
if(!is.null(sep24)){tsep24 <- t(array(data = sep24, dim = c(2, length(sep24)/2)))}
if(!is.null(oct24)){toct24 <- t(array(data = oct24, dim = c(2, length(oct24)/2)))}
if(!is.null(nov24)){tnov24 <- t(array(data = nov24, dim = c(2, length(nov24)/2)))}
if(!is.null(dec24)){tdec24 <- t(array(data = dec24, dim = c(2, length(dec24)/2)))}

#hourly
if(!is.null(jan1)){tjan1 <- t(array(data = jan1, dim = c(2, length(jan1)/2)))}
if(!is.null(feb1)){tfeb1 <- t(array(data = feb1, dim = c(2, length(feb1)/2)))}
if(!is.null(mar1)){tmar1 <- t(array(data = mar1, dim = c(2, length(mar1)/2)))}
if(!is.null(apr1)){tapr1 <- t(array(data = apr1, dim = c(2, length(apr1)/2)))}
if(!is.null(may1)){tmay1 <- t(array(data = may1, dim = c(2, length(may1)/2)))}
if(!is.null(jun1)){tjun1 <- t(array(data = jun1, dim = c(2, length(jun1)/2)))}
if(!is.null(jul1)){tjul1 <- t(array(data = jul1, dim = c(2, length(jul1)/2)))}
if(!is.null(aug1)){taug1 <- t(array(data = aug1, dim = c(2, length(aug1)/2)))}
if(!is.null(sep1)){tsep1 <- t(array(data = sep1, dim = c(2, length(sep1)/2)))}
if(!is.null(oct1)){toct1 <- t(array(data = oct1, dim = c(2, length(oct1)/2)))}
if(!is.null(nov1)){tnov1 <- t(array(data = nov1, dim = c(2, length(nov1)/2)))}
if(!is.null(dec1)){tdec1 <- t(array(data = dec1, dim = c(2, length(dec1)/2)))}

#t() does not like NULL values
#daily
if(!is.null(njan24)){ntjan24 <- t(array(data = njan24, dim = c(2, length(njan24)/2)))}
if(!is.null(nfeb24)){ntfeb24 <- t(array(data = nfeb24, dim = c(2, length(nfeb24)/2)))}
if(!is.null(nmar24)){ntmar24 <- t(array(data = nmar24, dim = c(2, length(nmar24)/2)))}
if(!is.null(napr24)){ntapr24 <- t(array(data = napr24, dim = c(2, length(napr24)/2)))}
if(!is.null(nmay24)){ntmay24 <- t(array(data = nmay24, dim = c(2, length(nmay24)/2)))}
if(!is.null(njun24)){ntjun24 <- t(array(data = njun24, dim = c(2, length(njun24)/2)))}
if(!is.null(njul24)){ntjul24 <- t(array(data = njul24, dim = c(2, length(njul24)/2)))}
if(!is.null(naug24)){ntaug24 <- t(array(data = naug24, dim = c(2, length(naug24)/2)))}
if(!is.null(nsep24)){ntsep24 <- t(array(data = nsep24, dim = c(2, length(nsep24)/2)))}
if(!is.null(noct24)){ntoct24 <- t(array(data = noct24, dim = c(2, length(noct24)/2)))}
if(!is.null(nnov24)){ntnov24 <- t(array(data = nnov24, dim = c(2, length(nnov24)/2)))}
if(!is.null(ndec24)){ntdec24 <- t(array(data = ndec24, dim = c(2, length(ndec24)/2)))}

#hourly
if(!is.null(njan1)){ntjan1 <- t(array(data = njan1, dim = c(2, length(njan1)/2)))}
if(!is.null(nfeb1)){ntfeb1 <- t(array(data = nfeb1, dim = c(2, length(nfeb1)/2)))}
if(!is.null(nmar1)){ntmar1 <- t(array(data = nmar1, dim = c(2, length(nmar1)/2)))}
if(!is.null(napr1)){ntapr1 <- t(array(data = napr1, dim = c(2, length(napr1)/2)))}
if(!is.null(nmay1)){ntmay1 <- t(array(data = nmay1, dim = c(2, length(nmay1)/2)))}
if(!is.null(njun1)){ntjun1 <- t(array(data = njun1, dim = c(2, length(njun1)/2)))}
if(!is.null(njul1)){ntjul1 <- t(array(data = njul1, dim = c(2, length(njul1)/2)))}
if(!is.null(naug1)){ntaug1 <- t(array(data = naug1, dim = c(2, length(naug1)/2)))}
if(!is.null(nsep1)){ntsep1 <- t(array(data = nsep1, dim = c(2, length(nsep1)/2)))}
if(!is.null(noct1)){ntoct1 <- t(array(data = noct1, dim = c(2, length(noct1)/2)))}
if(!is.null(nnov1)){ntnov1 <- t(array(data = nnov1, dim = c(2, length(nnov1)/2)))}
if(!is.null(ndec1)){ntdec1 <- t(array(data = ndec1, dim = c(2, length(ndec1)/2)))}

#existing and non existent hourly and daily files, by month.
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
			"not_monthly_24h" = list("jan" = ntjan24,
					 "feb" = ntfeb24,
					 "mar" = ntmar24,
					 "apr" = ntapr24,
					 "may" = ntmay24,
					 "jun" = ntjun24,
					 "jul" = ntjul24,
					 "aug" = ntaug24,
					 "sep" = ntsep24,
					 "oct" = ntoct24,
					 "nov" = ntnov24,
					 "dec" = ntdec24),
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
					 "dec" = tdec1),
			"not_monthly_1h" = list("jan" = ntjan1,
					 "feb" = ntfeb1,
					 "mar" = ntmar1,
					 "apr" = ntapr1,
					 "may" = ntmay1,
					 "jun" = ntjun1,
					 "jul" = ntjul1,
					 "aug" = ntaug1,
					 "sep" = ntsep1,
					 "oct" = ntoct1,
					 "nov" = ntnov1,
					 "dec" = ntdec1))
return(files.by.month)
}


