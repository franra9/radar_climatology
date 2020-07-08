# Francesc Roura Adserias # treball final de grau
# aquest script fa un retall de tiff que volem, per a acumulades diàries i horàries. tabé treu un fitxer amb els dies sense dades.
# acumulada horària

setwd("/home/francesc/TFG/")

#library(tiff)
#library(sp)
#library(raster)
#library(rgdal)

date <- as.Date("2013-01-01")

any <- substr(date,1,4)
mes <- substr(date,6,7)
dia <- substr(date,9,10)

shape <- shapefile("~/TFG/LIASE_extremes.shp") #rectangle que fem servir de motlle

df_exist <- data.frame("year"=rep(NA,7*12),"month"=rep(NA,7*12),"exist"=rep(NA,7*12),"no_exist"=rep(NA,7*12),"perc_exist"=rep(NA,7*12))
k<-1
exists    <- 0
no_exists <- 0

sum <- 0

#### retall dels fitxers de precipitació horària #### 
for(i in 1:(7*370)){ #7 anys 370 dies per si de cas
# for(i in 1:(25)){
  any <- substr(date,1,4)
  mes <- substr(date,6,7)
  dia <- substr(date,9,10)
  
  for(j in 0:23){ #loop per les hores del dia
    if(j<10){
      hh <- paste0("0",j)  
    } else {
      hh <- j
    }
    
    filein_1h  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/",any,"/",mes,"/",dia,"/",
                         "XXX_RN1_",any, #primer mes de 2013 el nom es diferent
                         mes,
                         dia,
                         "_",
                         hh,
                         "00",
                         "_CMPAC1C_1h.tif")

    if(file.exists(filein_1h)){
      
      ##################### ini retallar ############################    
      fileout_1h  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/",any,"/",mes,"/",dia,"/",
                            "XXX_RN1_",any, #primer mes de 2013 el nom es diferent
                            mes,
                            dia,
                            "_",
                            hh,
                            "00",
                            "_CMPAC1C_1h_A.tif")
      
      # tif <- raster(filein_1h)
      
      # e <- extent(150,170,-60,-40)
      # extract(r, e)
      #plot(r)
      #plot(e, add=T)
      # shape <- readOGR(dsn = "prova.qgz", layer = "SHAPEFILE")
      # str(shape)
      
      # tif <-projectRaster(from = tif, crs=crs("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
      
      # projection(shape)
      # projection(tif)
      
      # area_est <- crop(tif, shape) #crop image
      # writeRaster(area_est, fileout_1h, overwrite=T) #save cut image
      ##################### end retallar ############################
      sum <- sum + area_est
      
      exists <- exists+1
      
    }else{
      
      # print("el fitxer raw del dia")
      # print(date)
      # print("no existeix")
      # a <- date
      # write.table(a,"/media/francesc/disc_extern_francesc/CMPAC1C_1h/dies_sense_dades_1h.txt", append = T, col.names = F,row.names = F)
      
      no_exists <- no_exists+1
    }
    
    
    
  }
  
  date_old <- date
  
  date <- date+1
  
  date_new <- date

  if(j%%23==0){
    print(date)
  }
  
  if(substr(date_old,6,7) != substr(date_new,6,7)){ # canvi de mes
    
    df_exist$year[k]     <- substr(date_old,1,4) 
    df_exist$month[k]    <- substr(date_old,6,7)
    df_exist$exist[k]   <- exists
    df_exist$no_exist[k] <- no_exists
    df_exist$perc_exist[k] <- exists/(exists+no_exists)*100
    
    exists    <- 0
    no_exists <- 0
    
    # fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/monthly_agg/ monthly_agg_XXX_RNN_",
    #                   any,"_",
    #                   mes,"_",
    #                   "CMP24KG_24h_A.tif")
    # 
    # writeRaster(sum, fileout, overwrite=T)
    
    sum <- 0
    
    k <- k+1
  }
  
  if(date > "2019-10-25"){
    
    df_exist$year[k]       <- substr(date_old,1,4) 
    df_exist$month[k]      <- substr(date_old,6,7)
    df_exist$exist[k]      <- exists
    df_exist$no_exist[k]   <- 31*24-25*24+no_exists
    df_exist$perc_exist[k] <- (exists-no_exists)/exists*100
    
    stop("Dia més enllà de l'últim dia amb dades")
  }
  
}

print(df_exist)

#### aquí s'acaba horari ppt ####

write.table(df_exist,"/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/monthly_agg/percentatge_hores_sense_dades_13-19.txt",row.names=F)



#################################### diari: #####################################33
# date <- as.Date("2013-01-01")
# date <- as.Date("2013-01-01")
# 
# any <- substr(date,1,4)
# mes <- substr(date,6,7)
# dia <- substr(date,9,10)
# 
# df_exist <- data.frame("year"=rep(NA,7*12),"month"=rep(NA,7*12),"exist"=rep(NA,7*12),"no_exist"=rep(NA,7*12),"perc_exist"=rep(NA,7*12))
# k<-1
# exists    <- 0
# no_exists <- 0
# 
# sum <- 0
# 
# #### 24h aggregate ####
# for(i in 1:(7*370)){ # 7 anys
#   # for(i in 1:62){
#   
#   any <- substr(date,1,4)
#   mes <- substr(date,6,7)
#   dia <- substr(date,9,10)
#   
#   filein  <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/XXX/",any,"/",mes,"/",dia,"/",
#                     "XXX_RNN_",any, #primer mes de 2013 el nom es diferent
#                     mes,
#                     dia,
#                     "_0000_CMP24KG_24h.tif")
#   
#   if(file.exists(filein)){
    
    ##################### ini retallar ############################
    # fileout <- paste0("/media/francesc/disc_extern_francesc/CMP24KG_24h/XXX/",any,"/",mes,"/",dia,"/",
    # "XXX_RNN_",any,
    # mes,
    # dia,
    # "_0000_CMP24KG_24h_A.tif")  
    # fileout <- "/home/francesc/cut_thing.tif"
    # tif <- raster(filein)
    
    # e <- extent(150,170,-60,-40)
    # extract(r, e)
    #plot(r)
    #plot(e, add=T) 
    # shape <- readOGR(dsn = "/home/francesc/TFG/LIASE_extremes.shp")
    # str(shape)
    
    # tif <-projectRaster(from = tif, crs=crs("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
    # projection(shape)
    # projection(tif)
    
    # area_est <- crop(tif, shape) #crop image
    # # writeRaster(area_est, fileout, overwrite=T) #save cut image
    # 
    # sum <- sum + area_est
    # 
    # exists <- exists+1
    ##################### end retallar ############################
    
  # }else{
    
    # print("el fitxer raw del dia")
    # print(date)
    # print("no existeix")
    # # a <- date
    # # write.table(a,"/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/dies_sense_dades_24h.txt", append = T, col.names = F,row.names = F)
    # 
    # no_exists<- no_exists+1
  # }
  
  # date_old <- date
  # 
  # date <- date+1
  # 
  # date_new <- date
  # 
  # print(date)
  
  # if(substr(date_old,6,7) != substr(date_new,6,7)){ # canvi de mes
  #   
  #   df_exist$year[k]     <- substr(date_old,1,4) 
  #   df_exist$month[k]    <- substr(date_old,6,7)
  #   df_exist$exist[k]   <- exists
  #   df_exist$no_exist[k] <- no_exists
  #   df_exist$perc_exist[k] <- exists/(exists+no_exists)*100
  #   
  #   exists    <- 0
  #   no_exists <- 0
  #   
  #   fileout <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/monthly_agg/monthly_agg_XXX_RNN_",
  #                     any,"_",
  #                     mes,"_",
  #                     "CMP24KG_24h_A.tif")
  #   
  #   writeRaster(sum, fileout, overwrite =T)
  #   
  #   sum <- 0
  #   
  #   k <- k+1
  # }
  
#   if(date > "2019-10-25"){
#     
#     df_exist$year[k]       <- substr(date_old,1,4) 
#     df_exist$month[k]      <- substr(date_old,6,7)
#     df_exist$exist[k]      <- exists
#     df_exist$no_exist[k]   <- 31-25+no_exists
#     df_exist$perc_exist[k] <- (exists-no_exists)/exists*100
#     
#     stop("Dia més enllà de l'últim dia amb dades")
#   }
#   
# # }
# 
# print(df_exist)

# write.table(df_exist,"/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMP24KG_24h/percentatge_dies_sense_dades_13-19.txt",row.names=F)

# plot(area_est)

# rasterize() 

# plot(tif)

