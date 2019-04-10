
## An R Framework for Climate Data Access and Post-processing <img src="/man/figures/cliamte4R_logo.svg" align="left" alt="" width="120" />

`climate4R` is a bundle of R packages for transparent climate data access, post-processing (including data collocation and bias correction / downscaling) and visualization. climate4R builds on two main data structures (grid and station, including metadata) to deal with gridded and point data from observations, reanalysis, seasonal forecasts and climate projections. It considers ensemble members as a basic dimension of the data structures. Moreover, climate4R is transparently (and remotely) connected to the Santancer Climate Data Gateway, offering several state-of-the-art datasets (including CMIP and CORDEX subsets).

* climate4R is formed by the following four core packages (all in GitHub): [`loadeR`](https://github.com/SantanderMetGroup/loadeR) , [`transformeR`](https://github.com/SantanderMetGroup/transformeR), [`downscaleR`](https://github.com/SantanderMetGroup/downscaleR) and [`visualizeR`](https://github.com/SantanderMetGroup/visualizeR).

* Compatibility with some external packages has been achieved by wrapping packages, thus enhancing climate4R with new functionalities (e.g. ETCCDI extreme climate indices via the [`climdex`](https://github.com/pacificclimate/climdex.pcic) package). 

* Semmantic provenance (metadata) information for `climate4R` products can be generated using [METACLIP](http://www.metaclip.org) via the [metaclipR](https://github.com/metaclip/metaclipR) package.

* A [docker](https://www.docker.com/why-docker) file with pre-installed `climate4R` and [jupyter](https://jupyter.readthedocs.io/en/latest) frameworks is in preparation. 


## References and Examples

The main `climate4R` references (with worked out examples) of are: [Iturbide et al. 2019](https://doi.org/10.1016/j.envsoft.2018.09.009) (general description and climate change examples), 
[Cofiño et al. 2018](http://doi.org/10.1016/j.cliser.2017.07.001) (seasonal forecasting ), [Frías et al. 2018](http://doi.org/10.1016/j.envsoft.2017.09.008) (visualization). Moreove, there is a [notebook repository](https://github.com/SantanderMetGroup/notebooks) including several illustrative notebooks (which are companion material of several papers).

## Installation
``` r
    > library(devtools)
    > install_github(c("SantanderMetGroup/loadeR.java",
                 "SantanderMetGroup/loadeR",
                 "SantanderMetGroup/transformeR",
                 "SantanderMetGroup/visualizeR",
                 "SantanderMetGroup/downscaleR"))
```

## Getting started

## Getting data

## Applications in sectoral impact studies (with worked out examples):

**Fire danger:** [Bedia et al. (2018)](http://doi.org/10.1016/j.cliser.2017.04.001) Seasonal predictions of Fire Weather Index: Paving the way for their operational applicability in Mediterranean Europe. Climate Services, 9, 101-110. 

**Species distribution models:** [Iturbide et al. (2018)](https://journal.r-project.org/archive/2018/RJ-2018-019/index.html) Tackling Uncertainties of Species Distribution Model Projections with Package mopa. The R Journal, 10(1), 122-139. 
