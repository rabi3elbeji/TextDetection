FROM centos:7
MAINTAINER Rabii Elbeji <rabi3elbeji@gmail.com>

  #
  # Install basic tools
  #
RUN yum update -y && \
  yum install -y \
   automake \
   bison \
   bzip2-devel \
   curl \
   curl-devel \
   coreutils \
   file \
   gettext \
   make \
   openssl-devel \
   patch \
   perl \
   perl-devel \
   unzip \
   wget \
   which \
   yasm \
   openssl-devel \
   expat-devel \
   zlib-devel \
   lftp \
   zip \
   dos2unix \
   java-1.8.0-openjdk-devel \
   ghostscript