# conda recipe for climate4R

```bash
conda install -c santandermetgroup -c conda-forge -c r -c defaults climate4r=1.5.1
```

***
_Note for jupyter notebook users_: From a dedicated environment, to run notebooks using climate4R include it as:

```
conda install -c santandermetgroup -c conda-forge -c r -c defaults climate4r=1.5.1 jupyter r-irkernel
```

in order to include jupyter notebooks in your newly created environment

***

## Build (only for the admin)

Use mambabuild, see below.

```bash
conda build -c conda-forge -c r -c defaults .
anaconda login
anaconda upload -u SantanderMetGroup TAR_BZ2
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
conda mambabuild -c conda-forge -c r -c defaults . &>log &
```
