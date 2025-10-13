FROM ubuntu:22.04

# Install required tools and dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        autoconf build-essential curl git ca-certificates make unzip wget \
        binutils cmake zlib1g-dev \
        libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev \
        libglu1-mesa-dev libvlc-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone BennuGD2 source
RUN git clone --recursive https://github.com/SplinterGU/BennuGD2.git /BennuGD2

WORKDIR /BennuGD2

# Build SDL GPU
RUN ./vendor/build-sdl-gpu.sh linux clean

# Build BennuGD2
RUN ./build.sh linux clean

# Default shell
ENTRYPOINT ["bash"]
CMD ["-i"]

# Build: docker build -t bennugd2 .
# Usage: docker run -it bennugd2
