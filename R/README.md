# Perform climate4R operations over a large amount of data with function climate4R.chunk

**climate4R.chunk.R** contains the `climate4R.chunk` function and this is its documentation.

## Apply climate4R function to each loaded set (chunk) of latitudes.

### Description

Function tailored to operations performed over large data (e.g. for the entire world).
The function uses a loop where in each iteration a chunk of latitudes is loaded and a climate4R
function is applied to it.

### Usage 

climate4R.chunk(n.chunks = 10,
                     C4R.FUN.args = list(FUN = "climdexGrid",
                                         index.code = "CWD",
                                         pr = list(dataset = "WATCH_WFDEI", var = "pr")),
                    loadGridData.args = list(years = 1981:2000,
                                             lonLim = c(-10, 10),
                                             latLim = c(36, 45)),
                    output.path = NULL)
                    
### Arguments

* **n.chunks** number of latitude chunks over which iterate

* **C4R.FUN.args** list of arguments being the name of the C4R function (character)
the first. The rest of the arguments are those passed to the selected C4R function.
This list is passed to function `do.call` internally. For the parameters
(of a particular C4R function) where data (grids) need to be provided, here, a list of 2
arguments are passed (instead of a grid): `list(dataset = "", var = "")`.

* **loadGridData.args** list of collocation arguments passed to function loadGridData.

* **output.path** Optional. Path where the results of each iteration will be saved (*.rda).
Useful when the amount of data after the C4R function application is large, i.e. similar
to the pre-processed data (e.g. when the `biasCorrection` function is applied.)

### Details

Note that the appropriate libraries need to be loaded before applying this function. Packages
`loadeR` and `transformeR` are always needed. Depending on the C4R function that
is applied it will also be needed to load the corresponding package/s.

### Value

If `output.path` is NULL a grid containing all latitudes is returned. If `output.path`
is provided *.rda objects for each latitude chunk are saved in the specified path.

### Authors
M. Iturbide

### Examples
##### #Load climate4R.chunk function into the R environment
source("R/climate4R.chunk.R")

##### #Load climate4R packages
library(loadeR)\
library(transformeR)\
library(climate4R.climdex)

##### #Login to the UDG

loginUDG(username = "", password = "")

##### #Apply function
z <- climate4R.chunk(n.chunks = 10,\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C4R.FUN.args = list(FUN = "climdexGrid", index.code = "CWD", pr = list(dataset = "WATCH_WFDEI", var = "pr")),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;loadGridData.args = list(years = 1981:2000, lonLim = c(-10, 10), latLim = c(36, 45)),\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output.path = NULL)
                    
##### #Plot the output                    
library(visualizeR)\
spatialPlot(climatology(z), backdrop.theme = "coastline")

<img src="/man/figures/climate4R.chunk_example.png" />