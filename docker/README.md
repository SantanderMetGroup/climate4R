# Dockerfile

This Dockerfile is the basis of the climate4R [Docker](https://www.docker.com/why-docker), where `climate4R` and [jupyter](https://jupyter.readthedocs.io/en/latest) frameworks are already installed. This is the base layer for the **climate4R Hub** (a cloud-based computing facility to run `climate4R` notebooks at [IFCA (CSIC-UC) Cloud Services](https://ifca.unican.es/en-us/research/advanced-computing-and-e-science)).

## Instructions to start working with the climate4R Docker

### Install Docker

The best option is to install Docker from its own [repositories](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository).

After installing, to be able to use Docker without the `sudo`, it is necessary to add your user to the docker group (this group is created during the installation).

```
$ sudo usermod -aG docker your-user
```

Finally, "logout" and "login" again.

Find more information about docker at [this freeCodeCamp entry](https://medium.freecodecamp.org/a-beginner-friendly-introduction-to-containers-vms-and-docker-79a9e3e119b)

### Pull and run the climate4r Docker image

```
$ docker pull santandermetgroup/climate4r 

$ docker run -p 8888:8888 santandermetgroup/climate4r 
```

The last command will return an Url:

http://(firstchoice or secondchoice):8888/

Write http://firstchoice:8888/ or http://secondchoice:8888/ in your browser and start working with climate4R in jupyter!

## Build (only for the admin)

- Docker image for jupyter uses python 3.7 version due to climate4R dependencies.
- This is the docker version of the IPCC hub. Do not consider this a climate4R docker, the IPCC hub has a very particular environment and specific user requirements.

```bash
docker build -t santandermetgroup/hubipcc:${VERSION} -f Dockerfile .
docker login
docker push santandermetgroup/hubipcc:${VERSION}
```
