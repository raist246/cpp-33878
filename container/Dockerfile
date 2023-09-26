FROM docker.io/ubuntu:jammy 

USER root

RUN apt-get update && apt install -yq locales

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive
RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure dash

# Basic packages for a poky + useful stuff
RUN apt install -yq \
      cmake \
      build-essential \
      cpio \
      curl \
      diffstat \
      file \
      gawk \
      gdb-multiarch \
      git \
      iproute2 \
      libssl-dev \
      nano \
      ninja-build \
      python3 \
      python3-pip \
      python3-pytest \
      rsync \
      vim \
      wget \
      xz-utils \
      zip

# Install a recent version of CMake (to support using CMake presets)
RUN wget -O - https://github.com/Kitware/CMake/releases/download/v3.26.5/cmake-3.26.5-linux-x86_64.sh \
    > /tmp/cmake-3.26.5-linux-x86_64.sh \
    && chmod +x /tmp/cmake-3.26.5-linux-x86_64.sh \
    && /tmp/cmake-3.26.5-linux-x86_64.sh --skip-license --prefix=/usr \
    && rm /tmp/cmake-3.26.5-linux-x86_64.sh

RUN apt-get install -yq \
      bash-completion \
      iputils-ping \
      && echo "source /usr/share/bash-completion/completions/git" >> /etc/bash.bashrc \
      && rm -rf /var/lib/apt/lists 

RUN wget https://downloads.yoctoproject.org/releases/yocto/yocto-4.2/toolchain/x86_64/poky-glibc-x86_64-core-image-minimal-cortexa57-qemuarm64-toolchain-ext-4.2.sh -O /tmp/sdk.sh

RUN useradd user && chmod +x /tmp/sdk.sh && chown user /tmp/sdk.sh && mkdir -p /opt/sdk && chown  user /opt/sdk
USER user

RUN /tmp/sdk.sh -d /opt/sdk 

COPY toolchain.cmake /opt/sdk/
