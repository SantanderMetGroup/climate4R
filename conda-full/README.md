## conda recipe for climate4R

```bash
# create a conda environment
conda create --name nameofmycondaenvironment
# activate the environment
conda activate nameofmycondaenvironment
# install climate4R
conda install -c defaults -c r -c conda-forge -c santandermetgroup climate4r=1.4.0
```
Activate the conda environment to work with climate4R. To deactivate the environment run the following:

```bash
# deactivate the environment
conda deactivate
```

### Build (only for the admin)

```bash
conda build -c defaults -c r -c conda-forge .
anaconda login
anaconda upload -u SantanderMetGroup TAR_BZ2
```
