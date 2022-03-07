############################################################################
# this script cuts the tiff data files with the shape defined at shape.dir #
# author froura 2021  							     #
############################################################################

cut_files <- function(available.files = NULL, shp.dir = NULL, outdir = NULL){
	if(is.null(available.files)){
		warning("Month with NULL files, current month has been skipped")
	} else { 
		shape <- shapefile(shp.dir)
		files.list <- paste0(data.dir, available.files)
		for(i in 1:length(files.list)){
		  if(i %% 100 == 0){
		    print(available.files[i])
		  }
		  try(tif <- raster(files.list[i]))
			try(tiff <- projectRaster(from = tif, crs = crs("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")))
			try(area <- crop(tiff, shape)) #crop image)
			  dir.create(path = paste0(outdir, shp.name, available.files[i]), recursive=T)
			try(writeRaster(area, paste0(outdir, shp.name, available.files[i]), overwrite=T)) #save cut image
		}
		print(paste0("Existing", month, "files from ", date.ini," to ", date.fin, " have been cut and saved at", outdir, shp.name, "/"))
	}
}
