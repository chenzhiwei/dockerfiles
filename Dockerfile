# Ubuntu Base
#
# VERSION 0.0.2
#

FROM ubuntu:15.04
MAINTAINER Chen Zhiwei <zhiweik@gmail.com>

# Set Default username and password
ENV _USERNAME_=zhiwei _PASSWORD_=password

# Add a new user and to admin group
RUN useradd -m -d /home/$_USERNAME_ -s /bin/bash -G adm,sudo $_USERNAME_ \

    # Set the user password
    && echo "$_USERNAME_:$_PASSWORD_" | chpasswd \

    # Make sure the package repository is up to date
    && apt-get -qq update \

    # Install essential packages
    && apt-get -qqy install sudo vim git dnsmasq openssh-server bash-completion \

    && mkdir -p /var/run/sshd

VOLUME ["/var/lib/docker"]

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
