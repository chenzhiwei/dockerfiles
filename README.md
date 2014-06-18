# docker


## Install docker

```
$ sudo apt-get install docker.io
$ sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
```

## Run a docker container

```
$ sudo docker run -i -t --name="first_container" ubuntu:14.04 /bin/echo "Hello, World!"
```

`docker run` means run a docker container.

`-i` means run docker container in interactive mode.

`-t` means allocate a pseudo-tty do this docker container.

`--name` means assign a name to this docker container.

`ubuntu` means a docker image repository.

`14.04` means a image tag, one image can have more than one tag.

`/bin/echo "Hello, World!"` means run a command in the container.

After this, you will launch your first container. If the `ubuntu::14.04` is not present in your local disk, docker will fetch it from [Docker Hub][docker-hub-url].

[docker-hub-url]: https://hub.docker.com/

## Build a docker image from Dockerfile

```
$ sudo docker build -t chenzhiwei/ubuntu:14.04 /path/to/Dockerfile_dir
```

## Run a docker container

```
$ sudo docker run -d -P --name first_container chenzhiwei/ubuntu:14.04
```

## A full Demo

```
$ sudo docker build -t demo-docker/ubuntu:14.04 https://github.com/chenzhiwei/hello-docker.git
$ sudo docker run -d -p 2222:22 --name="demo-docker" demo-docker/ubuntu:14.04
$ ssh -p 2222 ubuntu@127.0.0.1
Enter password: password
```

After these three commands, you are now in a docker container, enjoy docker!

## In the End

Docker document: <https://docs.docker.com>
