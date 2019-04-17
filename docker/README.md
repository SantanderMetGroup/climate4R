
## Dockerfile with the R Framework for Climate Data Access and Post-processing <img src="/man/figures/climate4R_logo.svg" align="left" alt="" width="120" />

A [docker](https://www.docker.com/why-docker) file with pre-installed `climate4R` and [jupyter](https://jupyter.readthedocs.io/en/latest) framework. This is the base layer for the **climate4R Hub** (a cloud-based computing facility to run `climate4R` notebooks at [IFCA/CSIC Cloud Services](https://ifca.unican.es/en-us/research/advanced-computing-and-e-science)).

### Install Docker

The best option is to install Docker from its own [repositories](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository)

After installing, to be able to use Docker without the `sudo`, it is necessary to add your user to the docker group (this group is created during the installation).

$ sudo usermod -aG docker your-user

Finally, "logout" and "login" again.

Find more information about docker at [https://medium.freecodecamp.org/a-beginner-friendly-introduction-to-containers-vms-and-docker-79a9e3e119b](https://medium.freecodecamp.org/a-beginner-friendly-introduction-to-containers-vms-and-docker-79a9e3e119b)

### Run the climate4r Docker image and start working

The santandermetgroup/climate4r image was built from the Dockerfile available here.

$ docker pull santandermetgroup/climate4r 
$ docker run -p 8888:8888 santandermetgroup/climate4r 

The last command will return an Url, e.g.:
http://(317acec1df5f or 127.0.0.1):8888/

Write http://317acec1df5f:8888/ or http://127.0.0.1:8888/ in your browser and start working with climate4R in jupyter!

