ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG USERNAME
ENV USERNAME=${USERNAME}

RUN cat > ~/.viamdevrc <<-'EOS'
	eval "\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	export LIBRARY_PATH=/home/linuxbrew/.linuxbrew/lib
	export CGO_LDFLAGS=-L/home/linuxbrew/.linuxbrew/lib
	export CGO_CFLAGS=-I/home/linuxbrew/.linuxbrew/include
	export GOPRIVATE=github.com/viamrobotics/*,go.viam.com/*
	export CC=gcc-11 \
	export CXX=g++-11 \
	EOS

USER root

### app dependencies
## go
ENV GO_VERSION=1.23.0
ENV GOARCH=arm64

RUN apt-get update && \
    wget https://go.dev/dl/go${GO_VERSION}.linux-${GOARCH}.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-${GOARCH}.tar.gz && \
    rm go${GO_VERSION}.linux-${GOARCH}.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


ENV PATH="/usr/local/go/bin:${PATH}"
## end go

RUN apt-get update && \
    apt-get install -y \
    gcc-11 \
    protobuf-compiler

## node
# Use bash for the shell
USER $USERNAME
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create a script file sourced by both interactive and non-interactive bash shells
ENV BASH_ENV=.bash_env
RUN touch "${BASH_ENV}"
USER root
RUN echo '. "${BASH_ENV}"' >> .bashrc
USER $USERNAME

# Download and install nvm and set Node version
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | PROFILE="${BASH_ENV}" bash
RUN echo node > .nvmrc
RUN nvm install 20
## end node
### end app dependencies

USER root
RUN wget -O /usr/local/bin/x264 https://artifacts.videolan.org/x264/release-debian-aarch64/x264-r3213-570f6c7 && \
    chmod +x /usr/local/bin/x264
USER $USERNAME

USER root
RUN wget -O /usr/local/bin/x264 https://github.com/grpc/grpc-web/releases/download/1.5.0/protoc-gen-grpc-web-1.5.0-linux-aarch64 && \
    chmod +x /usr/local/bin/x264
USER $USERNAME
