FROM alpine:edge

RUN apk --no-cache --update add \
  libgcc \
  libtermkey \
  libvterm \
  unibilium \
  #
  cmake \
  g++ \
  gcc \
  git \
  perl \
  ;

ENV \
  CMAKE_EXTRA_FLAGS="-DENABLE_JEMALLOC=OFF"

ARG \
  neovim=v0.2.2

RUN apk --no-cache --update add --virtual build-deps \
  autoconf \
  automake \
  cmake \
  g++ \
  gcc \
  git \
  libtermkey-dev \
  libtool \
  libuv \
  libvterm-dev \
  luarocks \
  m4 \
  make \
  musl-dev \
  ncurses-dev \
  perl \
  unibilium-dev \
  && git clone --branch="${neovim}" --depth=1 https://github.com/neovim/neovim.git src \
  && (cd src \
    && make \
    && make install \
  ) \
  && rm -rf src \
  && apk del build-deps

ENTRYPOINT ["nvim"]

WORKDIR /root
