#this script computes the climatology in different timescales

clim <- function(filein = NULL, outdir = NULL){
#	for(file in filein){
  		#tifs <- lapply(filein[,1], raster)
		#tafs <- brick(tifs)
		#sum <- tafs[,,1]
		sumtot<-0
		for(i in 1:length(filein[,1])){  		
	  		tif <- raster(filein[i,1])
	  		sumtot <- sumtot + tif
		}
#	}
}

