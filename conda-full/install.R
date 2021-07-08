package.version <- list(
    climate4R.UDG =      "0.2.3",
    loadeR.java =        "1.1.1",
    loadeR =             "1.7.1",
    loadeR.ECOMS =       "1.4.6",
    transformeR =        "2.1.2",
    downscaleR =         "3.3.3",
    downscaleR.keras =   "1.0.0",
    visualizeR =         "1.6.1",
    convertR =           "0.2.0",
    geoprocessoR =       "0.2.0",
    climate4R.climdex =  "0.2.2",
    climate4R.indices =  "0.2.0",
    loadeR.2nc =         "0.1.2",
    fireDanger =         "1.1.0",
    VALUE =              "2.2.1",
    climate4R.value =    "0.0.2",
    mopa =               "1.0.2",
    drought4R =          "0.2.0",
    climate4R.datasets = "0.0.1"
)
for (pkg in names(package.version)) {
  tarball = sprintf("https://github.com/SantanderMetGroup/%s/archive/refs/tags/v%s.tar.gz", pkg, package.version[[pkg]])
  if(!require(pkg, character.only = TRUE)){ # to avoid download and install already installed packages
    install.packages(tarball, repos = NULL)
    require(pkg, character.only = TRUE)
  }
}
