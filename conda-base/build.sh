# for convertR
export UDUNITS2_LIB=${PREFIX}/lib
export UDUNITS2_INCLUDE=${PREFIX}/include
export CPATH=${PREFIX}/include

# for rjava
export LD_LIBRARY_PATH=${PREFIX}/lib:${PREFIX}/lib/server:$PREFIX/lib/R/library/rJava/libs:$PREFIX/jre/lib/amd64/server

R --vanilla -e 'install.packages("devtools", repos="https://cloud.r-project.org/")'
R --vanilla -e "install.packages('udunits2', repos='https://cloud.r-project.org/', configure.args='--with-udunits2-lib=${UDUNITS2_LIB}')"
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.java@v1.1.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/climate4R.UDG@devel")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR@devel")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/loadeR.2nc@v0.1.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/transformeR@v2.0.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/downscaleR@v3.3.1")'
R --vanilla -e 'library(devtools);install_github("SantanderMetGroup/visualizeR@v1.6.0")'
