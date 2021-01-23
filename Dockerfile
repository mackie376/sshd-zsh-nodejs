FROM node:14.15.4-buster-slim
LABEL maintainer="Takashi Makimoto <mackie@beehive-dev.com>"

ARG USER=user
ARG GROUP=user
ARG PASS=password
ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND=nointeracitve \
    DEBCONF_NOWARNINGS=yes \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      git-lfs \
      gnupg2 \
      locales \
      sudo \
      ssh \
      vim \
      zsh \
    && userdel -r node \
    && groupadd -g "$GID" "$GROUP" \
    && useradd -m -s /usr/bin/zsh -u "$UID" -g "$GID" "$USER" \
    && usermod -aG sudo "$USER" \
    && echo "${USER}:${PASS}" | chpasswd \
    && sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
    && locale-gen \
    && sed -i -E 's/#AddressFamily any/AddressFamily inet/' /etc/ssh/sshd_config \
    && sed -i -E 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i -E 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && mkdir -p /run/sshd \
    && git clone --recursive https://github.com/sorin-ionescu/prezto.git "/home/${USER}/.prezto" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF8

COPY ./conf.d/zsh/.zshenv "/home/${USER}/"
COPY ./conf.d/zsh/.p10k.zsh \
     ./conf.d/zsh/.zlogin \
     ./conf.d/zsh/.zlogout \
     ./conf.d/zsh/.zpreztorc \
     ./conf.d/zsh/.zprofile \
     ./conf.d/zsh/.zshrc "/home/${USER}/.config/zsh/"
RUN    mkdir "/home/${USER}/.ssh" \
    && chown -R "${USER}:${GROUP}" \
      "/home/${USER}/.config" \
      "/home/${USER}/.ssh" \
      "/home/${USER}/.zshenv" \
      "/home/${USER}/.prezto"

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
