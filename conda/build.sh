R CMD javareconf
R --vanilla -e 'library(devtools); 
				install_github(c(
					"SantanderMetGroup/loadeR.java@v1.1.1", 
					"SantanderMetGroup/loadeR@v1.4.15", 
					"SantanderMetGroup/transformeR@v1.6.0", 
					"SantanderMetGroup/visualizeR@v1.5.0", 
					"SantanderMetGroup/downscaleR@v3.1.0"))' 
