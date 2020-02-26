## conda recipe for climate4R

```bash
conda install -c defaults -c conda-forge -c santandermetgroup climate4r
```

### Build (only for the admin)

Contents of ~/.condarc

```yaml
channels:
  - defaults
  - conda-forge
channel_priority: 'strict'
```

Install conda-build in a conda environment and execute the following:

```bash
conda build -c conda-forge .
anaconda login
anaconda upload -u SantanderMetGroup TAR_BZ2
```
