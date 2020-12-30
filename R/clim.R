#this script computes the climatology in different timescales

clim <- function(filein = NULL, outdir = NULL, non_exist,corr = F){
		sumtot<-0
		for(i in 1:length(filein[,1])){  		
	  		tif <- raster(filein[i,1])
	  		sumtot <- sumtot + tif
		}
		if(corr){ # Correction factor taking into account the missing files
			sumtot <- sumtot * length(filein[,1])/(length(filein[,1]) + non_exist)
			sufix <- "_corr"
		} else {
			sufix <- ""			
		}
		nyear <- length(levels(factor(filein[,2])))
		fileout <- paste0(outdir, 
				levels(factor(filein[,2]))[1],
				"-",
				levels(factor(filein[,2]))[length(levels(factor(filein[,2])))],
				sufix,
				".tif")
		# Write file
		writeRaster(sumtot/nyear, fileout, overwrite=T)
		print(paste0("Monthly mean written at ", fileout))
	}

