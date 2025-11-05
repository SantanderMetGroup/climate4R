## Climate4R – R Framework for Climate Data Access and Post-processing <img src="/man/figures/climate4R_logo.svg" align="left" alt="" width="120" />

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/SantanderMetGroup/climate4r/devel)

**Climate4R** is a framework of R packages for transparent climate data access, post-processing (including data collocation, bias correction, and downscaling), and visualization.  
It builds on two main data structures (grid and station, including metadata) to handle gridded and point data from observations, reanalysis, seasonal forecasts, and climate projections, including ensemble members as a native dimension.

---

### Current structure and new metapackage

As of version **2.7.x**, the recommended way to install the entire Climate4R ecosystem is through the **metapackage [`climate4r-meta`](SantanderMetGroup/climate4R-meta)**.  
This repository now focuses on documentation, references, and examples.

> **If you just want to install and use Climate4R**, please use:
>
> ~~~bash
> conda install -c conda-forge r-climate4r
> ~~~
>
> or see the [`climate4r-meta`](SantanderMetGroup/climate4R-meta) repository for details.

---

## Overview

The Climate4R ecosystem consists of interoperable R packages covering all steps of the climate data workflow:

- **Core packages:** [`loadeR`](SantanderMetGroup/loadeR), [`transformeR`](SantanderMetGroup/transformeR), [`downscaleR`](SantanderMetGroup/downscaleR), [`visualizeR`](SantanderMetGroup/visualizeR)
- **Extended functionality:**  
  [`convertR`](SantanderMetGroup/convertR) (unit handling),  
  [`geoprocessoR`](SantanderMetGroup/geoprocessoR) (geoprocessing),  
  [`climate4R.UDG`](SantanderMetGroup/climate4R.UDG) (data gateway interface),  
  [`climate4R.indices`](SantanderMetGroup/climate4R.indices),  
  [`climate4R.climdex`](SantanderMetGroup/climate4R.climdex),  
  [`climate4R.value`](SantanderMetGroup/climate4R.value),  
  [`downscaleR.keras`](SantanderMetGroup/downscaleR.keras),  
  [`fireDanger`](SantanderMetGroup/fireDanger),  
  [`mopa`](SantanderMetGroup/mopa),  
  [`drought4R`](SantanderMetGroup/drought4R), and others.

Climate4R connects transparently to the **Santander Climate Data Gateway**, offering direct access to major climate datasets such as CMIP5, CORDEX, ERA5, and others.  
It is also the foundation of the **climate4R Hub**, a cloud-based service running at [IFCA/CSIC Cloud Services](https://ifca.unican.es/en-us/research/advanced-computing-and-e-science).

<p align="center">
<img src="/man/figures/climate4R_2.png"/>
</p>

---

## References and Examples

The formal reference of Climate4R is:

**Iturbide, M.**, **Bedia, J.**, **Herrera, S.**, **Baño-Medina, J.**, **Fernández, J.**, **Frías, M.D.**, **Manzanas, R.**, **San-Martín, D.**, **Cimadevilla, E.**, **Cofiño, A.S.**, **Gutiérrez, J.M.** (2019).  
*The R-based climate4R open framework for reproducible climate data access and post-processing.*  
*Environmental Modelling & Software*, **111**, 42–54.  
[https://doi.org/10.1016/j.envsoft.2018.09.009](https://doi.org/10.1016/j.envsoft.2018.09.009)

Additional references for specific components and applications include:  
- [Cofiño et al. 2018](http://doi.org/10.1016/j.cliser.2017.07.001) – Seasonal forecasting  
- [Frías et al. 2018](http://doi.org/10.1016/j.envsoft.2017.09.008) – Visualization  
- [Bedia et al. 2019](https://doi.org/10.1016/j.envsoft.2019.07.005) – Data provenance  
- [Bedia et al. 2019a](https://doi.org/10.5194/gmd-2019-224) – Statistical downscaling  
- [Bedia et al. 2018](http://doi.org/10.1016/j.cliser.2017.04.001) – Fire danger  
- [Iturbide et al. 2018](https://journal.r-project.org/archive/2018/RJ-2018-019/index.html) – Species distribution models  

For illustrative notebooks and examples:  
👉 [Climate4R Notebooks Repository](SantanderMetGroup/notebooks)

---

## Installation (Development or Legacy)

The installation of individual packages from GitHub is still possible for development purposes:

~~~r
  library(devtools)
  install_github(c(
    "SantanderMetGroup/loadeR.java",
    "SantanderMetGroup/climate4R.UDG",
    "SantanderMetGroup/loadeR",
    "SantanderMetGroup/transformeR",
    "SantanderMetGroup/visualizeR",
    "SantanderMetGroup/downscaleR"
  ))
~~~

To install a specific package version (for reproducibility):
~~~r
  devtools::install_github("SantanderMetGroup/visualizeR@v1.4.6")
~~~
will install a more recent version of the package used in the paper by Iturbide _et al._ 2019.

In case a particular paper notebook is to be replicated, the installation of specific version tags can be done by just explicitly indicating the tag number in the repo name. For example:

```r
  devtools::install_github("SantanderMetGroup/visualizeR@v1.0.0")
```
installs the `visualizeR` package version used in Frías _et al._ 2018, while the following

## Example of Use

A simple example showing the main functionality of Climate4R, calculating an ETCCDI index (Summer Days) from bias-corrected EURO-CORDEX data, is available in the [introductory document](/man/2018_ClimateInformatics_Gutierrez.pdf) and the companion [Jupyter notebook](/man/notebooks/climate4R.ipynb).

<img src="/man/figures/climate4r_example.png" align="center" alt="" width="" />

---

## User Support

Please note that support resources are limited.  
Before posting issues:

- Describe your problem clearly before sharing code.  
- Help others reproduce it with a minimal example.  
- Avoid posting the same question in multiple places.  

See the [StackOverflow posting guidelines](https://stackoverflow.com/help/how-to-ask) for reference.

Main tracker for framework-wide questions:  
👉 [Climate4R Issues](SantanderMetGroup/climate4R/issues)

---

## License

Climate4R is distributed under the **GNU General Public License v3.0 (GPL-3)**.

---
