FROM alpine:3.9

ARG KUBE_VERSION=v1.14.2

RUN apk add --no-cache \
        apache2-utils \
        bash \
        bash-completion \
        binutils \
        bind-tools \
        busybox-extras \
        curl \
        file \
        git \
        iproute2 \
        iputils \
        jq \
        net-tools \
        nmap \
        openssh-client \
        rsync \
        unzip \
        vim \
        vimdiff \
        wget \
    && echo '. /etc/profile.d/bash_completion.sh' > /root/.bashrc \
    && curl -ksSL -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl \
    && chmod +x /usr/bin/kubectl

CMD ["/bin/bash"]
