## conda recipe for climate4R

```bash
# create a conda environment
conda create --name nameofmycondaenvironment
# activate the environment
conda activate nameofmycondaenvironment
# install climate4R
conda install -c defaults -c conda-forge -c santandermetgroup climate4r
```
Activate the conda environment to work with climate4R. To deactivate the environment run the following:

```bash
# deactivate the environment
conda deactivate nameofmycondaenvironment
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
conda install -c conda-forge -c santandermetgroup climate4r
```

### Build (only for the admin)
```bash
conda build -c conda-forge .
anaconda login
anaconda upload -u SantanderMetGroup TAR_BZ2
```
