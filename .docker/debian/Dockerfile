FROM debian:latest

MAINTAINER OpenBee AI TEAM

  #
  # Install basic tools
  #
RUN apt-get update -y && \
  apt-get install -y \
  --no-install-recommends apt-utils \
  build-essential \
   automake \
   bison \
   curl \
   coreutils \
   file \
   gettext \
   make \
   openssl \
   libssl-dev \
   libgcrypt11-dev \
   libcurl4-openssl-dev \
   zlib1g \
   zlib1g-dev \
   expat \
   libexpat1-dev \
   patch \
   perl \
   unzip \
   wget \
   yasm \
   lftp \
   zip \
   dos2unix \
   openjdk-8-jdk \
   ghostscript
  #
  # Install dev tools
  #
RUN  apt-get install -y build-essential
  #
  # Install git 2.x
  #
ENV GIT_VER 2.20.1
RUN wget https://www.kernel.org/pub/software/scm/git/git-$GIT_VER.tar.gz \
    && tar xf git-$GIT_VER.tar.gz && cd git-$GIT_VER \
    && make -j"$(nproc --all)" prefix=/usr/local all \
    && make prefix=/usr/local -j"$(nproc --all)" install \
    && cd .. && rm -f git-$GIT_VER.tar.gz && rm -rf git-$GIT_VER
RUN git config --global url."https://".insteadOf git://
  #
  # Install CMake
  #
ENV CMAKE_VERSION=3.10.2
RUN  cd /usr/src && \
  CMAKE_VERSION_XY=$(echo ${CMAKE_VERSION} | sed -r 's/\.[0-9]+$//') && \
  wget https://cmake.org/files/v${CMAKE_VERSION_XY}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz && \
  tar -xzvf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz && \
  rm -f cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz && \
  cd cmake-${CMAKE_VERSION}-Linux-x86_64 && \
  rm -rf doc man && \
  rm -rf bin/cmake-gui && \
  ln -s $(pwd)/bin/cmake /usr/local/bin/cmake && \
  ln -s $(pwd)/bin/ctest /usr/local/bin/ctest && \
  ln -s $(pwd)/bin/cpack /usr/local/bin/cpack && \
  ln -s $(pwd)/bin/ccmake /usr/local/bin/ccmake 
  #
  # Add /usr/local/lib to ldconfig
  #
RUN  echo '/usr/local/lib' >> /etc/ld.so.conf.d/usr-local.conf && \
  ldconfig
  #
  # we don't need libpython*.a, and they're many megabytes
  #
RUN  find /usr/local/lib -name '*.a' -print0 | xargs -0 rm -f 
  #
  # Install dev tools
  #
RUN cd /opt && \
    wget "http://www.leptonica.com/source/leptonica-1.77.0.tar.gz" && \
    tar -zxvf leptonica-1.77.0.tar.gz && \
    cd leptonica-1.77.0/ && \
    ./configure && \
    make && \
    make install
  # 
  # Install Catch2
  #
RUN cd /opt && \
    git clone https://github.com/catchorg/Catch2.git && \
    cd Catch2 && \
    cmake -Bbuild -H. -DBUILD_TESTING=OFF && \
    cmake --build build/ --target install 
  #
  # Install jsoncpp 
  #
RUN cd /opt \
  && git clone https://github.com/open-source-parsers/jsoncpp.git \
  && cd jsoncpp && mkdir build && cd build \
  && cmake \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DCMAKE_BUILD_TYPE=Release \
    .. \
  && make \
  && make install \
  && mkdir /usr/local/include/jsoncpp \
  && cp -r /usr/local/include/json /usr/local/include/jsoncpp/
  #
  # Install OpenCV
  #
RUN cd /opt && \
    mkdir opencv_installer && \
    cd opencv_installer && \
    git clone https://github.com/opencv/opencv.git && \
    cd opencv && \
    git checkout 3.4.3 && \
    cd .. && \
    git clone https://github.com/opencv/opencv_contrib.git && \
    cd opencv_contrib && \
    git checkout 3.4.3 && \
    cd ../opencv && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D BUILD_SHARED_LIBS=ON \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules .. && \
    make -j"$(nproc --all)" && \
    make install
  #
  # Install zxing
  #
RUN cd /opt && \
    mkdir zxing_installer && \
    cd zxing_installer && \
    git clone https://github.com/rabi3elbeji/zxing-cpp.git && \
    cd zxing-cpp && \
    git checkout 7a168e94cbb26442f794381c2e2dc7d86b36e83b && \
    mkdir build && cd build && \
    cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D BUILD_SHARED_LIBS=true \
    -D CMAKE_DISABLE_FIND_PACKAGE_Iconv=ON \
    .. && \
    make -j"$(nproc --all)" && \
    make install

WORKDIR /usr/src
CMD /bin/bash
