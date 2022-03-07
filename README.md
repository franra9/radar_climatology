# radar_climatology

This repository aims to compute climatologies from a region given a daily or hourly data set in form of raster and a shapefile where to compute the climatologies (average).

In the current version is tailored to use specific data structure from catalan met office ([meteocat](https://www.meteo.cat/)) and the data is only available under request.

All the data processing is stored in .tif format in form of monthly means, season and anual means.

The scripts are what follows:

### `R/` where all code is stored:

* `main.R` : main script where all the functions are called and where all the workflow is visible
* `config.R` : list of necessary parameters to run the repository
* `clim.R` : function that computes the climatologies 
* `cut.R` : funtion that cuts the raster provided a geometry
* `data_check.R` : checks what files exist or not and provides a list of existing and non existent data organized by months 


### run
`Rscript main.R start_date final_date`

i.e. `Rscript main.R 20150101 20151231`

whatch out! start_date has to be the first day of the month, final_date has to be the last date of the month

### Reports: 

`.TFG.pdf` : bachelor thesis, seasonal, anual precipitation climatologies, intensit analysis
Institution: University of Barcelona

`.summer_intensity_analysis_2013-2020.pdf` : extra report, summer intensity distribution study
Institution: University of Innsbruck

Info about the packges and versions used in the last successful run can be found in 'packages.log'

### Other scripts in `/R`:

Dirty scripts used some time to plot hystograms and rasters. Not operative but can be useful to have some ideas for further plots ;)

### How to contribute

`oper` branch is the opertive branch. Feel free to start from there. Open a pull request using `dev-` prefix in the pull request name.

Author: Francesc Roura Adserias [Personal page](https://www.linkedin.com/in/francescroura/) , 2022

