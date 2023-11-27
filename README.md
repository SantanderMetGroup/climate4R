
## R Framework for Climate Data Access and Post-processing <img src="/man/figures/climate4R_logo.svg" align="left" alt="" width="120" />

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/SantanderMetGroup/climate4r/devel)

`climate4R` is a bundle of R packages for transparent climate data access, post-processing (including data collocation and bias correction / downscaling) and visualization. `climate4R` builds on two main data structures (grid and station, including metadata) to deal with gridded and point data from observations, reanalysis, seasonal forecasts and climate projections. It considers ensemble members as a basic dimension of the data structures. Moreover, `climate4R` is transparently (and remotely) connected to the Santander Climate Data Gateway, offering several state-of-the-art datasets (including CMIP5 and CORDEX subsets).

* `climate4R` is formed by the following four core packages (all in GitHub): [`loadeR`](https://github.com/SantanderMetGroup/loadeR) , [`transformeR`](https://github.com/SantanderMetGroup/transformeR), [`downscaleR`](https://github.com/SantanderMetGroup/downscaleR) and [`visualizeR`](https://github.com/SantanderMetGroup/visualizeR). These packages are fully documented in the corresponding GitHub wikis.

* `climate4R` capabilities are further extended by providing support to physical units handling ([`convertR`](https://github.com/SantanderMetGroup/convertR) package) and geoprocessing tasks ([`geoprocessoR`](https://github.com/SantanderMetGroup/geoprocessoR) package).   

* Compatibility with some external packages has been achieved by wrapping packages, thus enhancing `climate4R` with new functionalities (e.g. ETCCDI extreme climate indices via the [`climdex`](https://github.com/pacificclimate/climdex.pcic) package). 

* Semantic provenance (metadata) information for `climate4R` products can be generated using [METACLIP](http://www.metaclip.org) via the [`metaclipR`](https://github.com/metaclip/metaclipR) package.

* [Conda](https://github.com/SantanderMetGroup/climate4R/tree/master/conda) and [docker](https://github.com/SantanderMetGroup/climate4R/tree/master/docker) `climate4R` installations available. The [docker](https://www.docker.com/why-docker) file also includes the [jupyter](https://jupyter.readthedocs.io/en/latest) framework. This is the base layer for the **climate4R Hub** (a cloud-based computing facility to run `climate4R` notebooks at [IFCA/CSIC Cloud Services](https://ifca.unican.es/en-us/research/advanced-computing-and-e-science)).

<!--
An schematic illustration of the different components of `climate4R` is given in the following figure:
-->

<p align="center">
<img src="/man/figures/climate4R_2.png"/>
</p>

## References and Examples


The **formal reference** of `climate4R` is: 

****
M. Iturbide, J. Bedia, S. Herrera, J. Baño-Medina, J. Fernández, M.D. Frías, R. Manzanas, D. San-Martín, E. Cimadevilla, A.S. Cofiño and JM Gutiérrez (2019) The R-based climate4R open framework for reproducible climate data access and post-processing. *Environmental Modelling & Software*, **111**, 42-54. [DOI: /10.1016/j.envsoft.2018.09.009](https://doi.org/10.1016/j.envsoft.2018.09.009)
****

Additional references for **specific components** of `climate4R` (with worked examples) are [Cofiño _et al._ 2018](http://doi.org/10.1016/j.cliser.2017.07.001) (seasonal forecasting ), [Frías _et al._ 2018](http://doi.org/10.1016/j.envsoft.2017.09.008) (visualization),  [Bedia _et al._ 2019](https://doi.org/10.1016/j.envsoft.2019.07.005) (data provenance) and [Bedia _et al._ 2019a](https://doi.org/10.5194/gmd-2019-224) (statistical downscaling). Other publications describing applications in **sectoral impact studies** (also with worked out examples) are [Bedia _et al._ (2018)](http://doi.org/10.1016/j.cliser.2017.04.001) (fire danger) or [Iturbide _et al._ (2018)](https://journal.r-project.org/archive/2018/RJ-2018-019/index.html) (Species distribution models), among others.
<!-- 
* [Cofiño et al. 2018](http://doi.org/10.1016/j.cliser.2017.07.001) (seasonal forecasting )
 * [Frías et al. 2018](http://doi.org/10.1016/j.envsoft.2017.09.008) (visualization). 

Other publications describing applications of `climate4R` in **sectoral impact studies** (with worked out examples):

 * **Fire danger:** [Bedia et al. (2018)](http://doi.org/10.1016/j.cliser.2017.04.001) Seasonal predictions of Fire Weather Index: Paving the way for their operational applicability in Mediterranean Europe. *Climate Services*, **9**, 101-110. 

 * **Species distribution models:** [Iturbide et al. (2018)](https://journal.r-project.org/archive/2018/RJ-2018-019/index.html) Tackling Uncertainties of Species Distribution Model Projections with Package mopa. *The R Journal*, **10**(1), 122-139. 
-->

Moreover, there is a [notebook repository](https://github.com/SantanderMetGroup/notebooks) including several illustrative **notebooks with worked-out examples** (which are companion material of several papers). 

## Installation

The `climate4R` framework relies on a wealth of other R packages and bindings to third-party libraries. Therefore, the recommended installation is through the conda package below, which ensures the proper installation of all dependencies.

### Installation using miniconda:

[Miniconda](https://docs.conda.io/en/latest/miniconda.html) is a free minimal installer for conda. The [conda recipe](conda) installs an up-to-date version of the different packages composing the `climate4R` framework, along with the associated library dependencies (udunits, openjdk, netcdf Java etc.), avoiding potential problems like the R-java configuration etc. Note that the appropriate miniconda distribution must be installed (go to the [miniconda installers page](https://docs.conda.io/en/latest/miniconda.html)) before running the following commands. We recommend starting from a clean environment (named climate4R in this example):

```bash
conda create --name climate4R
conda activate climate4R
```

In this environment, install `climate4R` by issuing:

```bash
mamba install -y -c conda-forge -c r -c defaults -c santandermetgroup r-climate4r
```

Activate the conda environment to work with climate4R. Deactivate the environment with:

```bash
conda deactivate
```

### Direct package installation from github:

Individual packages can be installed directly from the github sources.

``` r
    > library(devtools)
    > install_github(c("SantanderMetGroup/loadeR.java",
                 "SantanderMetGroup/climate4R.UDG",
                 "SantanderMetGroup/loadeR",
                 "SantanderMetGroup/transformeR",
                 "SantanderMetGroup/visualizeR",
                 "SantanderMetGroup/downscaleR"))
```

#### NOTE: installation of specific package versions

In case a particular paper notebook is to be replicated, the installation of specific version tags can be done by just explicitly indicating the tag number in the repo name. For example:

```r
   > devtools::install_github("SantanderMetGroup/visualizeR@v1.0.0")
```
installs the `visualizeR` package version used in Frías _et al._ 2018, while the following

```r
   > devtools::install_github("SantanderMetGroup/visualizeR@v1.4.6")
```
will install a more recent version of the package used in the paper by Iturbide _et al._ 2019.


## Example of use

Examples of use of the `climate4R` framework are given in the reference papers above. In the following we illustrate the main functionalities of `climate4R` with a simple example, consisting on **calculating an ETCCDI index (Summer Days) from bias corrected EURO-CORDEX data over Southern Europe.** More details at the [brief introduction to climate4R](/man/2018_ClimateInformatics_Gutierrez.pdf) document in the `man` folder and full code at the companion [jupyter notebook](/man/notebooks/climate4R.ipynb).

<img src="/man/figures/climate4r_example.png" align="center" alt="" width="" />


***
## User Support

Please note that the pool of people who can provide support for `climate4R` packages is very small and our time for support is limited. We don't necessarily have the capacity for long, open-ended user support. Please follow these basic guidelines before posting:

* Introduce the problem before you post any code
* Help others reproduce the problem
* Avoid sending the same question to multiple places

These [posting guidelines](https://stackoverflow.com/help/how-to-ask) at stackoverflow provide further recommendations on how to make a good question. If questions are kept short, specific and direct, there's a greater chance that someone will take on the ticket. 

***

