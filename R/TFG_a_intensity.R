# Francesc Roura Adarias # treball final de grau
# aquest script fa un retall de tiff que volem, per a acumulades diàries i horàries. tabé treu un fitxer amb els dies sense dades.
# acumulada horària.

ini <- Sys.time()

setwd("/home/francesc/TFG/")

#library(tiff)
#library(sp)
#library(raster)
#library(rgdal)
#library(ggplot2)

date <- as.Date("2013-01-01")

shape <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_area_interior.shp") #rectangle que fem servir de motlle

# carreguem shape
shape <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp") #area petita est (no irr).

any <- substr(date,1,4)
mes <- substr(date,6,7)
dia <- substr(date,9,10)

k<-1
j<- 1
exists    <- 0
no_exists <- 0

####################################
#seleccionar T o F
accumulation_count <- T
agg.intensities <- T
max_aw_ae <- FALSE
count_EW <- matrix(ncol=2, nrow=7*24*2*30) #anys*hores*dies*2mesos
pos <- 0
####################################

# hh <- 10

ppt_low <- ppt_low0 <- 0
ppt_mod <- ppt_mod0 <- 0
ppt_high <- ppt_high0 <- 0

#### retall dels fitxers de precipitació horària #### 
for(i in 1:(7*370)){ #7 anys 370 dies per si de cas
  any <- substr(date,1,4)
  mes <- substr(date,6,7)
  dia <- substr(date,9,10)

  
##### seasonal or yearly, comment if yearly wanted
# if( mes == "06" | mes == "07" | mes == "08") { #seasonal or yearly, comment if yearly wanted
 if(mes == "12"){
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
                          "_CMPAC1C_1h_a.tif")
    
    if(file.exists(filein_1h)){
      exists <- exists + 1
      tif <- raster(filein_1h)
      df <- aggregate(tif, 1) #remostreo a 1km

      
      #####
      if(slot(attributes(tif)$data,"max")!=0){ #trobar si l'hora que es mira ha plogut o no.
          # print("s'ha trobat una hora amb ppt")
        
        if(agg.intensities == T){
          tif0<-tif
          ppt_low <- (tif > 0 & tif < 0.3 )
          ppt_mod  <- (tif >= 0.3 & tif <= 0.8 )
          ppt_high  <- (tif > 0.8)
          
          # Suma per a intensitats (comentar si només es vol comptar numero d'hores)
          if( accumulation_count == T ){
            ppt_low <- mask(tif0,ppt_low,maskvalue=0,updatevalue=0)
            ppt_mod <- mask(tif0,ppt_mod,maskvalue=0,updatevalue=0)
            ppt_high <- mask(tif0,ppt_high,maskvalue=0,updatevalue=0) 
          }
          
          ppt_low0 <- ppt_low + ppt_low0
          ppt_mod0 <- ppt_mod + ppt_mod0
          ppt_high0 <- ppt_high + ppt_high0
        }
        
        if(max_aw_ae == T){ #això és per a lscatterplot
          r_masked0 <- raster::mask(tif, shape,inverse=TRUE) #irr
          r_masked1 <- raster::mask(tif, shape,inverse=FALSE) #non irr
          
          if(slot(attributes(r_masked0)$data,"max")!=0 & slot(attributes(r_masked1)$data,"max")!=0 ){
            pos <- pos + 1
            count_WE[pos,1] <- slot(attributes(r_masked0)$data,"max")
            count_WE[pos,2] <- slot(attributes(r_masked1)$data,"max")
          }
          
        }
          
      } #aquí s'acaba el loop de si exiteix punt no nul.
      #####
      
      
    }
    # if(!file.exists(fileout_1h)){
    #   # tif <- raster(filein_1h)
    # 
    #   ##################### end retallar ############################
    #   # sum <- sum + area_est
    # }
    #   exists <- exists+1
    #   
    # }else{
    #   print(paste("el fitxer raw del dia",date,"no existeix"))
    # }
    
    ## this chunk is to write hourly max (July or August)
    # plot(ppt_high0)
    # plot(ppt_mod0)
    # plot(ppt_low0)
    # 
    # fileout1 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
    #                    "XXX_RN1_CMPAC1C_1h_a_high_accum_08.tif")
    # fileout2 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
    #                    "XXX_RN1_CMPAC1C_1h_a_mod_accum_08.tif")
    # fileout3 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
    #                    "XXX_RN1_CMPAC1C_1h_a_low_accum_08.tif")
    # 
    # writeRaster(ppt_high0, fileout1, overwrite=T)
    # writeRaster(ppt_mod0, fileout2, overwrite=T)
    # writeRaster(ppt_low0, fileout3, overwrite=T)
    ## this chunk finishes here
    
    
  }
}# loop del mes

  date_old <- date
  # 
  date <- date+1
  # 
  date_new <- date
  
  if(j%%23==0){
    print(date)
  }
  
  # if(substr(date_old,6,7) != substr(date_new,6,7)){ # canvi de mes
  # 
  # }
  
  if(date > "2019-10-25"){
    
    ## this chunk is to write total counts 
    # total, yearly
    # plot(ppt_high0)
    # plot(ppt_mod0)
    # plot(ppt_low0)
    # 
    # fileout1 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/year/",
    #                   "XXX_RN1_CMPAC1C_1h_a_high_count.tif")
    # fileout2 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/year/",
    #                   "XXX_RN1_CMPAC1C_1h_a_mod_count.tif")
    # fileout3 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/year/",
    #                   "XXX_RN1_CMPAC1C_1h_a_low_count.tif")
    # 
    # writeRaster(ppt_high0, fileout1, overwrite=T)
    # writeRaster(ppt_mod0, fileout2, overwrite=T)
    # writeRaster(ppt_low0, fileout3, overwrite=T)
    ## this chunk finishes here 

    ## this chunk is to write seasonal counts (in this case, summer)
    # plot(ppt_high0)
    # plot(ppt_mod0)
    # plot(ppt_low0)
    # 
    # fileout1 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/season/",
    #                    "XXX_RN1_CMPAC1C_1h_a_high_count_seasonal.tif")
    # fileout2 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/season/",
    #                    "XXX_RN1_CMPAC1C_1h_a_mod_count_seasonal.tif")
    # fileout3 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/season/",
    #                    "XXX_RN1_CMPAC1C_1h_a_low_count_seasonal.tif")
    # 
    # writeRaster(ppt_high0, fileout1, overwrite=T)
    # writeRaster(ppt_mod0, fileout2, overwrite=T)
    # writeRaster(ppt_low0, fileout3, overwrite=T)    
    ## this chunk finishes here

    ## this chunk is to write monthly counts (July or August)
     # plot(ppt_high0)
     # plot(ppt_mod0)
     # plot(ppt_low0)
     # 
     # fileout1 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
     #                    "XXX_RN1_CMPAC1C_1h_a_high_count_08.tif")
     # fileout2 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
     #                    "XXX_RN1_CMPAC1C_1h_a_mod_count_08.tif")
     # fileout3 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
     #                    "XXX_RN1_CMPAC1C_1h_a_low_count_08.tif")
     # 
     # writeRaster(ppt_high0, fileout1, overwrite=T)
     # writeRaster(ppt_mod0, fileout2, overwrite=T)
     # writeRaster(ppt_low0, fileout3, overwrite=T)    
    ## this chunk finishes here
    
    ## this chunk is to write monthly accumulation (July or August)
    plot(ppt_high0)
    plot(ppt_mod0)
    plot(ppt_low0)

    fileout1 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
                       "XXX_RN1_CMPAC1C_1h_a_high_accum_12.tif")
    fileout2 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
                       "XXX_RN1_CMPAC1C_1h_a_mod_accum_12.tif")
    fileout3 <- paste0("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/",
                       "XXX_RN1_CMPAC1C_1h_a_low_accum_12.tif")

    writeRaster(ppt_high0, fileout1, overwrite=T)
    writeRaster(ppt_mod0, fileout2, overwrite=T)
    writeRaster(ppt_low0, fileout3, overwrite=T)
    ## this chunk finishes here

  }
  
} #aquí s'acaba el loop de 7*370 dies

################# separate east west "a" ##############

# raster = your_raster
# shape = SpatialPolygons(your_polygon)

# # carreguem shape
# shape <- shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp")

#carreguem rasers intensitat anual
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/year/XXX_RN1_CMPAC1C_1h_a_high_count.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/year/XXX_RN1_CMPAC1C_1h_a_mod_count.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/year/XXX_RN1_CMPAC1C_1h_a_low_count.tif")

plot(ppt_high0 + ppt_mod0 + ppt_low0)

#carreguem rasters intensitat estacional
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/season/XXX_RN1_CMPAC1C_1h_a_high_count_seasonal.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/season/XXX_RN1_CMPAC1C_1h_a_mod_count_seasonal.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/season/XXX_RN1_CMPAC1C_1h_a_low_count_seasonal.tif")

#carreguem rasters intensitat juliol
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_count_07.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_count_07.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_count_07.tif")

#carreguem rasters intensitat agost
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_count_08.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_count_08.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_count_08.tif")

#carreguem rasters accumulacií segons intensitat gener
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_01.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_01.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_01.tif")

#carreguem rasters accumulacií segons intensitat febrer
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_02.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_02.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_02.tif")

#carreguem rasters accumulacií segons intensitat març
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_03.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_03.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_03.tif")

#carreguem rasters accumulacií segons intensitat abril
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_04.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_04.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_04.tif")

#carreguem rasters accumulacií segons intensitat may
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_05.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_05.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_05.tif")

#carreguem rasters accumulacií segons intensitat jun
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_06.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_06.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_06.tif")

#carreguem rasters accumulacií segons intensitat juliol
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_07.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_07.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_07.tif")

#carreguem rasters accumulacií segons intensitat agost
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_08.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_08.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_08.tif")

#carreguem rasters accumulacií segons intensitat setembre
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_09.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_09.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_09.tif")

#carreguem rasters accumulacií segons intensitat octubre
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_10.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_10.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_10.tif")

#carreguem rasters accumulacií segons intensitat novembre
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_11.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_11.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_11.tif")

#carreguem rasters accumulacií segons intensitat desembre
ppt_high0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_high_accum_12.tif")
ppt_mod0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_mod_accum_12.tif")
ppt_low0 <- raster("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/intensity/month/XXX_RN1_CMPAC1C_1h_a_low_accum_12.tif")

#seleccionem l'àrea que volem
r_masked0 <- raster::mask(ppt_high0, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(ppt_high0, shape,inverse=FALSE) #non irr

r_masked0 <- raster::mask(ppt_mod0, shape,inverse=TRUE)
r_masked1 <- raster::mask(ppt_mod0, shape,inverse=FALSE)

r_masked0 <- raster::mask(ppt_low0, shape,inverse=TRUE)
r_masked1 <- raster::mask(ppt_low0, shape,inverse=FALSE)

cellStats(r_masked0, stat='mean', na.rm=TRUE, asSample=TRUE)
cellStats(r_masked1, stat='mean', na.rm=TRUE, asSample=TRUE)

cellStats(r_masked0, stat='sd', na.rm=TRUE, asSample=TRUE)
cellStats(r_masked1, stat='sd', na.rm=TRUE, asSample=TRUE)

hist(r_masked0)
hist(r_masked1)

mean(r_masked0)

# mirar climatologia del percentatge d'intensitat de precipitació high, mod, low (total):

sum <- ppt_high0 + ppt_mod0 + ppt_low0

print(exists)

percent <- sum/exists

plot(percent)

writeRaster(percent,"/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/CMPAC1C_1h/XXX_RN1_CMPAC1C_1h_a_count_total.tif")

percent_high <- ppt_high0/sum
percent_mod <- ppt_mod0/sum
percent_low <- ppt_low0/sum

plot(percent_high)
plot(percent_mod)
plot(percent_low)



# area_est <- crop(ppt_high0, shape) #crop imagede forma rectangular
# plot channel and comarques.

plot(shapefile("/media/francesc/disc_extern_francesc/radar_SMC_ppt_TFG/shape/LIASE_a_est_2.shp"),bg="transparent", add=TRUE)
plot(comarques, bg="transparent", add=TRUE)
plot(raster(fileout3))
fin <- Sys.time()

print(Sys.time()-ini)


######################## plot max accum east west #######################
plot(polotew,xlab="maximum hourly accumulation a_w (mm)",ylab="maximum hourly accumulation a_e (mm)",pch = 20 ,cex = .5)

lm(count_EW[,2] ~ count_EW[,1])

abline(0, 0.4586)
# abline(0,1)
abline(0,1, col="red", lwd=1, lty=2)

ggplot(data.frame(polotew), aes(x=X1, y=X2) ) +
  geom_bin2d() +
  theme_bw()

##################################################
sum <- ppt_high0 + ppt_mod0 + ppt_low0

r_masked0 <- raster::mask(jan, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(jan, shape,inverse=FALSE) #non irr

#jan
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Jan",xlim=c(80,180), ylim=c(0,0.06),freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Jan", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

r_masked0 <- raster::mask(feb, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(feb, shape,inverse=FALSE) #non irr

#feb
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Feb",xlim=c(200,260),ylim=c(0,0.05), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Feb", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

r_masked0 <- raster::mask(mar, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(mar, shape,inverse=FALSE) #non irr

#mar
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Mar",xlim=c(260,370), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Mar", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3),breaks=10)

r_masked0 <- raster::mask(apr, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(apr, shape,inverse=FALSE) #non irr

#apr
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Apr",xlim=c(340,450),ylim=c(0,0.05), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Apr", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3),breaks=15)

r_masked0 <- raster::mask(may, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(may, shape,inverse=FALSE) #non irr

#may
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="May",xlim=c(200,350),ylim=c(0,0.025), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="May", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

r_masked0 <- raster::mask(jun, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(jun, shape,inverse=FALSE) #non irr

#jun
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Jun",ylim=c(0,0.020), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Jun", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

r_masked0 <- raster::mask(set, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(set, shape,inverse=FALSE) #non irr

#set
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Sep",ylim=c(0,0.02),xlim=c(100,300), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Set", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

r_masked0 <- raster::mask(oct, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(oct, shape,inverse=FALSE) #non irr

#oct
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Oct",xlim=c(300,550),ylim=c(0,0.02), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Oct", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

r_masked0 <- raster::mask(nov, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(nov, shape,inverse=FALSE) #non irr

#mov
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Nov",xlim=c(250,450),ylim=c(0,0.02), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Nov", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

r_masked0 <- raster::mask(dec, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(dec, shape,inverse=FALSE) #non irr

#dec
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Dec",xlim=c(40,65),ylim=c(0,0.2), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Dec", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3),breaks=15)


r_masked0j <- raster::mask(jul, shape,inverse=TRUE) #irr
r_masked1j <- raster::mask(jul, shape,inverse=FALSE) #non irr

# r_masked0j <- data.frame(rasterToPoints(r_masked0j))
# r_masked0j <- r_masked0j$layer

# r_masked1j <- data.frame(rasterToPoints(r_masked1j))
# r_masked1j <- r_masked1j$layer
# r_masked1j <- crop(r_masked0j,shape)

# sum(!is.na(slot(attributes(r_masked0j)$data,"values")))
# sum(!is.na(slot(attributes(r_masked1j)$data,"values")))

# slot(attributes(tif)$data,"max")


r_masked0a <- raster::mask(aug, shape,inverse=TRUE) #irr
# r_masked0a <- data.frame(rasterToPoints(r_masked0a))
# r_masked0a <- r_masked0a$layer

r_masked1a <- raster::mask(aug, shape,inverse=FALSE) #non irr
# r_masked1a <- data.frame(rasterToPoints(r_masked1a))
# r_masked1a <- as.vector(r_masked1a$layer)

  
# hist<-hist(r_masked1a,freq=F) 
# hist$density <- hist$density*1000

#mar
# hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="a)",xlim=c(130,180), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
# hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="a)", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
# 
# #apr
# hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="a)",xlim=c(130,180), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
# hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="a)", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
# 
# #may
# hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="a)",xlim=c(130,180), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
# hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="a)", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

# #jun
# hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="a)",xlim=c(130,180), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
# hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="a)", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))

#jul
hist(r_masked1j,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Jul", xlim=c(150,300),ylim=c(0,0.025), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5), breaks=10)
hist(r_masked0j ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Jul", xlim=c(150,300), freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3),breaks=10)

#aug
hist(r_masked1a,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="Aug", xlim=c(50,260),ylim=c(0,0.025), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5), breaks=10)
hist(r_masked0a ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Aug", xlim=c(50,400), freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3),breaks=10)

#set
# hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="a)",xlim=c(130,180), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
# hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="a)", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
# 
# #oct
# hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="a)",xlim=c(130,180), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
# hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="a)", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
# 
# #nov
# hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="a)",xlim=c(130,180), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
# hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="a)", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
# 
# #dec
# hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="a)",xlim=c(130,180), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
# hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="a)", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3))
seas<-jul+aug+jun

r_masked0 <- raster::mask(seas, shape,inverse=TRUE) #irr
r_masked1 <- raster::mask(seas, shape,inverse=FALSE) #non irr

#dec
hist(r_masked1,xlab = "accumulation (mm)", cex.lab = 1.5,cex.axis=1.2,ylab="normalized frequency (%)",main="summer",xlim=c(450,750), freq=F, col = rgb(red = 1, green = 1, blue = 0, alpha = 0.5))
hist(r_masked0 ,xlab = "accumulation (mm)",ylab="normalized frequency",main="Dec", freq=F, bg="transparent", add=TRUE,col = rgb(red = 0, green = 0, blue = 1, alpha = 0.3),breaks=15)

##################################################



barplot(height = table(factor(r_masked0j, levels=min(r_masked0j):max(r_masked0j)))/length(x),
        ylab = "proportion",
        xlab = "values",
        main = "histogram of x (proportions)")

