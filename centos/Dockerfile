# CentOS Docker image with sshd

FROM centos:7
MAINTAINER Chen Zhiwei <zhiweik@gmail.com>

# Set default root password
ARG ROOT_PASSWORD=password

# Unlock root user
RUN passwd -u root \

    # Set root password
    && echo "root:$ROOT_PASSWORD" | chpasswd \

    # Custom nameserver
    && echo nameserver 223.5.5.5 > /etc/resolv.conf \
    && echo nameserver 223.6.6.6 >> /etc/resolv.conf \

    # Install essential packages
    && yum clean all \
    && yum -y install bash-completion curl git openssh-server rsync vim \

    # Allow root ssh
    && sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config \

    && sshd-keygen \
    && mkdir -p /var/run/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
