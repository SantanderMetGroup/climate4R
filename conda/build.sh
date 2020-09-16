# for convertR
export UDUNITS2_LIB=${PREFIX}/lib
export UDUNITS2_INCLUDE=${PREFIX}/include
export CPATH=${PREFIX}/include

# for rjava
export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib/server:$PREFIX/lib/R/library/rJava/libs:$PREFIX/jre/lib/amd64/server

R --vanilla -e 'install.packages("devtools", repos="https://cloud.r-project.org/")'
R --vanilla -e "install.packages('udunits2', repos='https://cloud.r-project.org/', configure.args='--with-udunits2-lib=${UDUNITS2_LIB}')"
#R --vanilla -e 'install.packages("rJava", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("ncdf4", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("gh", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("matrix", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("geojsonio", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("rgdal", repos="https://cloud.r-project.org/")'
R --vanilla -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/tree/tree_1.0-38.tar.gz")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.UDG@v0.2.0")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.java@v1.1.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR@v1.6.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.ECOMS@v1.4.6")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/transformeR@v2.0.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/downscaleR.keras@v0.0.2")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/downscaleR@v3.3.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/visualizeR@v1.6.0")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/convertR@v0.2.0")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/geoprocessoR@v0.2.0")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.climdex@v0.2.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.indices@v0.1.0")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.2nc@v0.1.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/fireDanger@v1.1.0")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/VALUE@v2.2.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.value@v0.0.2")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/mopa@v1.0.0")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/drought4R@v0.2.0")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.datasets@v0.0.1")'
