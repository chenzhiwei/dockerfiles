# docker

Docker is a Linux Container.

## Install docker

```
$ sudo apt-get install docker.io
$ sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
```

## Docker image

Docker image likes VM image, there is a [Docker Hub][docker-hub-url] that contains pre-built docker images, and you can also build your own docker images.

When you run a docker container, you need to specify a docker image, and docker will first check if the image is present on you local disk, if not docker will fetch this image from Docker Hub.

You can build your docker image and upload to Docker Hub.

## Build a docker image from Dockerfile

```
$ sudo docker build -t chenzhiwei/ubuntu:14.04 /path/to/Dockerfile_dir
```

Dockerfile format is located here: <https://docs.docker.com/reference/builder/>.

There is a example Dockerfile in <https://github.com/chenzhiwei/hello-docker>.

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

After this, you will launch your first container. If the `ubuntu::14.04` is not present on your local disk, docker will fetch it from [Docker Hub][docker-hub-url].

[docker-hub-url]: https://hub.docker.com/

## A full Demo

```
$ sudo docker build -t demo-docker/ubuntu:14.04 git://github.com/chenzhiwei/hello-docker.git
$ sudo docker run -d -p 2222:22 --name="container_name" --hostname="container_hostname" --dns="127.0.0.1" demo-docker/ubuntu:14.04
$ ssh -p 2222 ubuntu@127.0.0.1
Enter password: password
```

After these three commands, you are now in a docker container, enjoy docker!

Haha, before you enjoy docker, you need to start dnsmasq service in docker container.

## Issues

The warning when run `locale` command like this `locale: Cannot set LC_CTYPE to default locale: No such file or directory` means you did not generate en_US.UTF-8.

This locale issue can be solved by run `localedef -v -c -i en_US -f UTF-8 en_US.UTF-8` on CentOS, and `locale-gen en_US.UTF-8` on Ubuntu.

If you can't find `localedef` command on CentOS, you need to reinstall `glibc-common` package, `locales` package on Ubuntu.

## In the End

Docker document: <https://docs.docker.com>
