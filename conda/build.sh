# for convertR
export UDUNITS2_LIB=${PREFIX}/lib
export CPATH=${PREFIX}/include

# for rjava
export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib/server:$PREFIX/lib/R/library/rJava/libs:$PREFIX/jre/lib/amd64/server

R CMD javareconf
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.UDG@spock")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.java")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR@devel")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.ECOMS")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/transformeR@v1.6.0")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/downscaleR@v3.1.0")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/visualizeR@devel")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/convertR")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/geoprocessoR@v0.1.0")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.climdex@v0.2.1")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.indices@v0.0.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.2nc")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/fireDanger")' 
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/VALUE@v2.1.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.value@v0.0.1")' 

# mopa
R --vanilla -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/tree/tree_1.0-38.tar.gz")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/mopa")'

R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/drought4R")'
