# Conda recipe for climate4R metapackage

## Installing climate4R conda metapackage

```bash
conda install -c conda-forge -c r -c defaults -c santandermetgroup  r-climate4r
```

***
_Note for jupyter notebook users_: From a dedicated environment, to run notebooks using climate4R include it as:

```bash
conda install -c conda-forge -c r -c defaults -c santandermetgroup  r-climate4r jupyter r-irkernel
```

in order to include jupyter notebooks in your newly created environment
***

## Building climate4R conda metapackage

```bash
conda build -c conda-forge -c r -c defaults -c santandermetgroup .
anaconda login
anaconda upload -u SantanderMetGroup PATH_TO_TAR_BZ2
```

## ToDo, explore mamba and boa

[mamba](https://github.com/mamba-org/mamba) and [boa](https://github.com/mamba-org/boa)

Install:

```bash
conda install mamba -n base -c conda-forge
```

Build:

```bash
rm -rf ${HOME}/miniconda3/conda-bld/src_cache
conda mambabuild -c conda-forge -c r -c defaults -c santandermetgroup . &>log &
```
