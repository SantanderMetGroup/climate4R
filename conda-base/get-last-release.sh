#!/bin/bash

set -u

trap exit SIGINT

repos='
SantanderMetGroup/climate4R.UDG
SantanderMetGroup/loadeR.java
SantanderMetGroup/loadeR
SantanderMetGroup/loadeR.ECOMS
SantanderMetGroup/transformeR
SantanderMetGroup/downscaleR.keras
SantanderMetGroup/downscaleR
SantanderMetGroup/visualizeR
SantanderMetGroup/convertR
SantanderMetGroup/geoprocessoR
SantanderMetGroup/climate4R.climdex
SantanderMetGroup/climate4R.indices
SantanderMetGroup/loadeR.2nc
SantanderMetGroup/fireDanger
SantanderMetGroup/VALUE
SantanderMetGroup/climate4R.value
SantanderMetGroup/mopa
SantanderMetGroup/drought4R
SantanderMetGroup/climate4R.datasets'

cat >build.sh <<EOF
# for convertR
export UDUNITS2_LIB=\${PREFIX}/lib
export UDUNITS2_INCLUDE=\${PREFIX}/include
export CPATH=\${PREFIX}/include

# for rjava
export LD_LIBRARY_PATH=\${PREFIX}/lib:\${PREFIX}/lib/server:\$PREFIX/lib/R/library/rJava/libs:\$PREFIX/jre/lib/amd64/server

R --vanilla -e 'install.packages("devtools", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("rJava", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("udunits2", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("ncdf4", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("gh", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("matrix", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("geojsonio", repos="https://cloud.r-project.org/")'
#R --vanilla -e 'install.packages("rgdal", repos="https://cloud.r-project.org/")'
R --vanilla -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/tree/tree_1.0-38.tar.gz")'
EOF

for repo in $repos
do
    release=$(curl --silent "https://api.github.com/repos/${repo}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    echo "R --vanilla -e 'library(devtools);install_github(\"${repo}@${release}\")'" >> build.sh
done
