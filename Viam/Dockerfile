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
RUN apt-get update && \
    apt-get install -y jq 
## go
ENV GO_VERSION=1.23.0
ENV GOARCH=arm64

RUN wget https://go.dev/dl/go${GO_VERSION}.linux-${GOARCH}.tar.gz && \
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

# x264
USER root
RUN wget -O /usr/local/bin/x264 https://artifacts.videolan.org/x264/release-debian-aarch64/x264-r3213-570f6c7 && \
    chmod +x /usr/local/bin/x264
USER $USERNAME
# end x264

# protoc-gen-grpc-web
USER root
RUN wget -O /usr/local/bin/protoc-gen-grpc-web https://github.com/grpc/grpc-web/releases/download/1.5.0/protoc-gen-grpc-web-1.5.0-linux-aarch64 && \
    chmod +x /usr/local/bin/protoc-gen-grpc-web
USER $USERNAME
# end protoc-gen-grpc-web

# tensorflow
USER root
RUN apt-get update && apt-get install -y python3 python3-venv python3-pip
RUN python3 -m venv /ve
ENV PATH="/ve/bin:$PATH"
RUN pip install 'tensorflow[and-cuda]'
USER $USERNAME
# end tensorflow

# mod_profiles
USER root
RUN echo "source .viamdevrc" >> .bashrc
USER $USERNAME

USER root
RUN git config --global url.ssh://git@github.com/viamrobotics/rdk.insteadOf https://github.com/viamrobotics/rdk && \
	git config --global url.ssh://git@github.com/viamrobotics/api.insteadOf https://github.com/viamrobotics/api
USER $USERNAME

# TODO: get agent forwarding to work
# USER root
# RUN mkdir -p .ssh && \
#     grep -q github.com .ssh/known_hosts || ssh-keyscan -t rsa github.com >> .ssh/known_hosts
# USER $USERNAME
# end mod_profiles

# docker
USER root
RUN apt-get update && apt-get install -y ca-certificates && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli
USER $USERNAME
# end docker
### end app dependencies
