#!/usr/bin/Rscript
# Author: Francesc Roura Adserias 29/08/2020
# this script is the main script of the radar_climatology repository

library(argparse)

# TODO (fran): Write an appropiate description to the program and args
# descriptions. Add a Usage description too? 
parser <- ArgumentParser(prog = "Name of the Program",
                         description = "Description",
                         usage = "Test")

parser$add_argument("--start", "-s", type = "character", nargs = "?",
                    default = "20180201",
                    help = "indicate start date in YYYYMMDD format.")

parser$add_argument("--end", "-e", type = "character", nargs = "?",
                    default = "20190930")

parser$add_argument("--months", "-m", type = "character", nargs = "+",
                    default = tolower(month.abb))

parser$add_argument("--interval", "-i", type = "character", nargs = "+",
                    default = c("monthly_24h"))

parser$add_argument("--periods", "-p", type = "character", nargs = "+",
                    default = c("month"))

parser$add_argument("--datadir", type = "character", default = "data/")

parser$add_argument("--shpdir", type = "character")

parser$add_argument("--shpname", type = "character")

parser$add_argument("--outdir", type = "character", default = "results/")

args <- parser$parse_args()

source("./config.R")

date.ini <- as.Date(x = args$start, format = "%Y%m%d")
date.fin <- as.Date(x = args$end, format = "%Y%m%d")

if (date.ini < as.Date(x = "20130101", format = "%Y%m%d")) {
  stop(paste0("Initial date ", date.ini, " is out of range"))
} else if (date.fin > as.Date(x = "20191001", format = "%Y%m%d")) {
  stop(paste0("End date ", date.fin, " is out of range"))
}

# load clim function
source("./clim.R")

# load create available data vectors function
source("./data_check.R")

#load funtions to cut files
source("./cut.R")

available.files <- exists_data(date.ini, date.fin, args$datadir)

wrk_files <- list()

for (p in args$periods) {

  out <- paste0(args$outdir, args$shpname, paste0("/", p, "/"))
  dir.create(out, recursive = T, showWarnings = FALSE)

  for (t  in args$interval) {
    for (m in args$months) {
      # TODO (fran): Maybe move this to be an argument for the specific functions?
      month <- paste0("(", m, ")")

      input <- available.files[[t]]

      cut_files(input[[m]][, 1], args$shpdir, args$outdir, args$datadir)

      output <- c(paste0(args$outdir, args$shpname, 
                         input[[m]][, 1]), input[[m]][, 2])
      dim <-	c(length(input[[m]][, 2]), 2)
      wrk_files[[t]][[m]] <- array(output, dim = dim)

      # TODO (fran): Check if lenght makes sense
      clim(filein = wrk_files[[t]][[m]],
           outdir = paste0(out, paste0(m, "_")),
           length(available.files$not_monthly[[m]]),
           corr = T)
    }
  }
}
