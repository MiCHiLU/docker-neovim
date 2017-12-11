FROM alpine:edge

ENV \
  CMAKE_EXTRA_FLAGS="-DENABLE_JEMALLOC=OFF"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk --no-cache --update add \
  libgcc \
  libtermkey \
  libvterm \
  unibilium \
  #
  perl \
  cmake \
  gcc \
  git \
  g++ \
  ;

ARG \
  neovim=v0.2.2

RUN apk --no-cache --update add --virtual build-deps \
  autoconf \
  automake \
  cmake \
  musl-dev \
  g++ \
  git \
  gcc \
  libtermkey-dev \
  libtool \
  libvterm-dev \
  unibilium-dev \
  ncurses-dev \
  libuv \
  #linux-headers \
  luarocks \
  #lua-sec \
  #lua5.3-dev \
  m4 \
  perl \
  make \
  #unzip \
  ##
  && git clone --branch="${neovim}" --depth=1 https://github.com/neovim/neovim.git src \
  && (cd src \
    && make \
    && make install \
  ) \
  && rm -rf src \
  ##
  && apk del build-deps

ENTRYPOINT /usr/local/bin/nvim
