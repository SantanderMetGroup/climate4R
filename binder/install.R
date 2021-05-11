#!/usr/bin/env Rscript
package.list <- matrix(c(
    "climate4R.UDG",      "0.2.0",
    "loadeR.java",        "1.1.1",
    "loadeR",             "1.7.0",
    "loadeR.ECOMS",       "1.4.6",
    "transformeR",        "2.1.0",
    "downscaleR",         "3.3.2",
    "downscaleR.keras",   "1.0.0",
    "visualizeR",         "1.6.0",
    "convertR",           "0.2.0",
    "geoprocessoR",       "0.2.0",
    "climate4R.climdex",  "0.2.1",
    "climate4R.indices",  "0.1.0",
    "loadeR.2nc",         "0.1.1",
    "fireDanger",         "1.1.0",
    "VALUE",              "2.2.1",
    "climate4R.value",    "0.0.2",
    "mopa",               "1.0.0",
    "drought4R",          "0.2.0",
    "climate4R.datasets", "0.0.1"
  ),ncol = 2, byrow = TRUE)

for (i in 1:nrow(package.list)) {
  tarball = paste("https://github.com/SantanderMetGroup/", package.list[i,1], "/archive/refs/tags/v", package.list[i,2], ".tar.gz", sep = "")
  if(!require(package.list[i,1], character.only = TRUE)){ # to avoid download and install already installed packages
    install.packages(tarball, repos=NULL)
    require(package.list[i,1], character.only = TRUE)
  }
} 
