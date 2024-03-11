FROM ubuntu:23.04

# Update the package lists
RUN dpkg --add-architecture i386 && apt-get update && apt-get upgrade -y

# Install the necessary tools
RUN apt-get install -y autoconf build-essential curl git make unzip wget

RUN apt-get install -y binutils git cmake build-essential zlib1g-dev libsdl2-dev libglu1-mesa-dev libsdl2-image-dev libvlc-dev libsdl2-mixer-dev

RUN git clone https://github.com/SplinterGU/BennuGD2.git /BennuGD2

WORKDIR /BennuGD2

RUN git submodule update --init --recursive

WORKDIR /BennuGD2/vendor

RUN ./sdl-gpu-patch-001.sh

RUN ./sdl-gpu-patch-002.sh

RUN ./build-sdl-gpu.sh linux clean

WORKDIR /BennuGD2

RUN ./build.sh linux clean

ENTRYPOINT ["bash"]

CMD ["-i"]

# Build: docker build -t bennugd2 .
# Usage: docker run -it bennugd2
