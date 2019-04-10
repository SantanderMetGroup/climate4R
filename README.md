
## An R Framework Climate Data Access and Post-processing <img src="http://meteo.unican.es/work/climate4r/climate4R_logo.svg" align="left" alt="" width="120" />


`climate4R` is a bundle of R packages for transparent climate data access, post-processing (including data collocation and bias correction / downscaling) and visualization. climate4R builds on two main data structures (grid and station, including metadata) to deal with gridded and point data from observations, reanalysis, seasonal forecasts and climate projections. It considers ensemble members as a basic dimension of the data structures. Compatibility with some external packages has been achieved by wrapping packages, thus enhancing climate4R with new functionalities (e.g. ETCCDI extreme climate indices via the [`climdex`](https://github.com/pacificclimate/climdex.pcic) package). Moreover, climate4R is transparently (and remotely) connected to the Santancer Climate Data Gateway, offering several state-of-the-art datasets (including CMIP and CORDEX subsets).

climate4R is formed by the following four core packages (all in GitHub): `loadeR`, `transformeR`, `downscaleR` and `visualizeR`. 

## Installation
``` r
    > library(devtools)
    > install_github(c("SantanderMetGroup/loadeR.java",
                 "SantanderMetGroup/loadeR",
                 "SantanderMetGroup/transformeR",
                 "SantanderMetGroup/visualizeR",
                 "SantanderMetGroup/downscaleR"))
```

A [docker](https://www.docker.com/why-docker) file with pre-installed climate4R and [jupyter](https://jupyter.readthedocs.io/en/latest) frameworks is in preparation. This is the basis of the climate4R Hub.

## Getting started

## Getting data

The original references fo `climate4R` are:

## References (all including worked out examples):
[Iturbide et al. 2019](https://doi.org/10.1016/j.envsoft.2018.09.009) (general description and examples for climate change CMIP and CORDEX), 
[Cofiño et al. 2018](http://doi.org/10.1016/j.cliser.2017.07.001) (description for seasonal forecasting ), [Frías et al. 2018](http://doi.org/10.1016/j.envsoft.2017.09.008)(visualization), 


3
