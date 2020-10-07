#this script computes the climatology in different timescales

clim <- function(filein = NULL, outdir = NULL){
		sumtot<-0
		for(i in 1:length(filein[,1])){  		
	  		tif <- raster(filein[i,1])
	  		sumtot <- sumtot + tif
		}
		nyear <- length(levels(factor(filein[,2])))
		fileout <- paste0(outdir, 
				levels(factor(filein[,2]))[1],
				"-",
				levels(factor(filein[,2]))[length(levels(factor(filein[,2])))],
				".tif")
		writeRaster(sumtot/nyear, fileout, overwrite=T)
		print(paste0("Monthly mean written at ", fileout))
	}

