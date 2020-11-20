ARG UBUNTU_VERSION=20.04

FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update &&                                 \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https                               \
    apt-utils                                         \
    automake                                          \
    bash-completion                                   \
    build-essential                                   \
    ca-certificates                                   \
    cmake                                             \
    curl                                              \
    dialog                                            \
    git                                               \
    gnupg2                                            \
    iproute2                                          \
    jq                                                \
    less                                              \
    libc6                                             \
    libgcc1                                           \
    libgssapi-krb5-2                                  \
    libicu[0-9][0-9]                                  \
    liblttng-ust0                                     \
    libssl1.1                                         \
    libstdc++6                                        \
    locales                                           \
    lsb-release                                       \
    nano                                              \
    openssh-client                                    \
    procps                                            \
    software-properties-common                        \
    sudo                                              \
    unzip                                             \
    vim                                               \
    wget                                              \
    zlib1g                                            \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

ADD .editorconfig /

ADD setup.sh /tmp/

RUN chmod +x /tmp/setup.sh
RUN /tmp/setup.sh \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
