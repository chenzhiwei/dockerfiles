# Ubuntu Base
#
# VERSION 0.0.1

FROM ubuntu:14.04
MAINTAINER Chen Zhiwei <zhiweik@gmail.com>

# add a new user since ubuntu disabled root user by default
RUN useradd -m -d /home/ubuntu -s /bin/bash -G adm,sudo ubuntu

# change the `ubuntu` user password to `password`
RUN echo 'ubuntu:password' | chpasswd

# make sure the package repository is up to date
RUN apt-get -qq update

# install essential packages
RUN apt-get -qqy install vim openssh-server bash-completion 

# add files and change owner
ADD ./config/dot_vimrc /home/ubuntu/.vimrc
RUN chown -R ubuntu:ubuntu /home/ubuntu

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
