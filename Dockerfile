FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

ENV PY310VER "3.10.0"
ENV PY39VER "3.9.6"
ENV LD_LIBRARY_PATH "/usr/local/lib"
#Upgrade Everything
RUN apt-get -qq update && \
    apt-get -y upgrade && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-add-repository multiverse && \
    apt-add-repository universe && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get -qq update && \
    apt-get install -y build-essential

# Upgrade
RUN apt-get update && apt-get -qqy upgrade 

#More Libs
RUN apt-get install -y libssl-dev \
                       libcurl4-openssl-dev \
                       manpages-dev \
                       python-dev \
                       libc-ares-dev \
                       autoconf \
                       libtool-bin \
                       libcrypto++-dev \
                       zlib1g-dev \
                       libfreeimage-dev \
                       libraw-dev \
                       libsodium-dev \
                       libsqlite3-dev \
                       libncurses-dev \
                       libncursesw5-dev \
                       libncurses5-dev \
                       libgdbm-dev \
                       libnss3-dev \
                       libreadline-dev \
                       libffi-dev \
                       libbz2-dev \
                       gcc \
                       g++ \
                       make \
                       cmake \
                       uidmap \
                       m4
                       
#Utils 
RUN apt-get install -y wget \
                       git \
                       curl \
                       nano \
                       unzip \
                       zip \
                       xz-utils \
                       htop \
                       gcc-11 \
                       g++-11 \
                       ffmpeg \
                       pv \
                       jq \
                       p7zip-full \
                       p7zip-rar \
                       parallel \
                       neofetch \
                       screen \
                       glances \
                       ranger \
                       calcurse \
                       chkrootkit \
                       ack \
                       silversearcher-ag \
                       thefuck \
                       mtr \
                       pydf \
                       nnn \
                       gnupg \
                       ca-certificates \
                       numactl \
                       procps \
                       dirmngr \
                       pkg-config \
                       dumb-init \
                       locales \
                       man \
                       procps \
                       ssh \
                       vim \
                       fuse \
                       sudo

#Locales
ENV LANG=en_US.UTF-8
RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && \ 
    locale-gen

#Googler
RUN wget -q https://github.com/jarun/googler/releases/download/v4.3.2/googler_4.3.2-1_ubuntu20.04.amd64.deb && \
    apt-get install -y ./googler_4.3.2-1_ubuntu20.04.amd64.deb && rm -rf googler_4.3.2-1_ubuntu20.04.amd64.deb

#Browsh
RUN wget -q https://github.com/browsh-org/browsh/releases/download/v1.6.4/browsh_1.6.4_linux_amd64.deb && \
    apt-get install -y ./browsh_1.6.4_linux_amd64.deb && rm -rf browsh_1.6.4_linux_amd64.deb

#Node JS
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash && \
    #Node JS and NPM
    apt-get install -y nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    #Yarn
    apt-get install -y yarn
 
#PostgreSQL
RUN apt-get -y install postgresql \
               postgresql-contrib
#Nginx
RUN apt-get install -y nginx

#Java
RUN apt-get install -y openjdk-14-jdk-headless

# Php
RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get install -y php8.0 \
                       libapache2-mod-php8.0
                     
# Ruby
RUN apt-add-repository -y ppa:brightbox/ruby-ng && \
    apt-get install -y ruby2.5   

#Clang
RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    #Adding Repo
    add-apt-repository -y "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main" && \ 
    # LLVM
    apt-get install -y libllvm-11-ocaml-dev \
                       libllvm11 \
                       llvm-11 \
                       llvm-11-dev \
                       llvm-11-doc \
                       llvm-11-examples \
                       llvm-11-runtime && \
    # Clang and co
    apt-get install -y clang-11 \
                       clang-tools-11 \
                       clang-11-doc \
                       libclang-common-11-dev \
                       libclang-11-dev \
                       libclang1-11 \
                       clang-format-11 \
                       clangd-11 && \
    # libfuzzer
    apt-get install -y libfuzzer-11-dev && \
    # lldb
    apt-get install -y  lldb-11 && \
    # lld (linker)
    apt-get install -y lld-11 && \
    # libc++
    apt-get install -y libc++-11-dev \
                       libc++abi-11-dev && \
    # OpenMP
    apt-get install -y libomp-11-dev

# # Compile Python 3.8
# RUN wget https://www.python.org/ftp/python/$PY38VER/Python-$PY38VER.tar.xz && \
#     tar -xf Python-$PY38VER.tar.xz && rm -rf Python-$PY38VER.tar.xz && cd Python-$PY38VER && \
#     CC=/usr/bin/gcc-11 ./configure --enable-optimizations --enable-shared && make -j$(nproc --all) && \
#     make altinstall && cd .. && rm -rf Python-$PY38VER

# Compile Python 3.9
RUN wget https://www.python.org/ftp/python/$PY39VER/Python-$PY39VER.tar.xz && \
    tar -xf Python-$PY39VER.tar.xz && rm -rf Python-$PY39VER.tar.xz && cd Python-$PY39VER && \
    CC=/usr/bin/gcc-11 ./configure --enable-optimizations --enable-shared && make -j$(nproc --all) && \
    make altinstall && cd .. && rm -rf Python-$PY39VER
    
# Compile Python 3.10
RUN wget https://www.python.org/ftp/python/$PY310VER/Python-$PY310VER.tar.xz && \
    tar -xf Python-$PY310VER.tar.xz && rm -rf Python-$PY310VER.tar.xz && cd Python-$PY310VER && \
    CC=/usr/bin/gcc-11 ./configure --enable-optimizations --enable-shared && make -j$(nproc --all) && \
    make altinstall && cd .. && rm -rf Python-$PY310VER

# C#
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    apt-get install -y ./packages-microsoft-prod.deb && rm -rf packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-5.0 \
                       aspnetcore-runtime-5.0

#Utils2
RUN apt-get install -y bcal \
                       neovim                       

#Caddy
RUN echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
    | tee -a /etc/apt/sources.list.d/caddy-fury.list && \
    apt update && \
    apt install -y caddy \
                   module-assistant
                   
# #Docker
# RUN curl -sSL https://get.docker.com | sh
