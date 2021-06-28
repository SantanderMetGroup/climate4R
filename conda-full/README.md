# conda recipe for climate4R

```bash
conda install -c santandermetgroup -c conda-forge -c r -c defaults climate4r=1.5.0
```

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
conda mambabuild -c conda-forge -c r -c defaults .
```
