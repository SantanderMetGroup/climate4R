## climate4R
An R Framework Climate Data Access and Post-processing

climate4R is a bundle of R packages for transparent climate data access, post-processing (including data collocation and bias correction and downscaling) and visualization. climate4R builds on two main data structures (grid and station, including metadata) to deal with gridded and point data from observations, reanalysis, seasonal forecasts and climate projections. It considers ensemble members as a basic dimension of the data structures. Compatibility with some external packages has been achieved by wrapping packages, thus enhancing climate4R with new functionalities (e.g. ETCCDI extreme climate indices). Moreover, climate4R is transparently (and remotely) connected to the Santancer Climate Data Gateway, offering several state-of-the-art datasets (including CMIP and CORDEX subsets).

climate4R is formed by the following packages (all in GitHub): loadeR, transformeR, downscaleR and visualizeR. 

A [docker](https://www.docker.com/why-docker) file with pre-installed climate4R and [jupyter](https://jupyter.readthedocs.io/en/latest) frameworks is in preparation. This is the basis of the climate4R Hub.
