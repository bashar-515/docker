FROM ubuntu:latest AS builder

# used by tzdata to set system's local timezone
ENV TZ="America/New_York"

RUN apt-get update

# misc. software installs
RUN apt-get install \
    tzdata

# required installations to run my dotfiles setup scripts
RUN apt-get install -y \
    git curl

RUN apt-get install \
    stow

# base of my environment
# tmux
# neovim
# starship
RUN apt-get install -y \
    tmux neovim

RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

ARG USERNAME=beesho

RUN useradd -ms /bin/bash $USERNAME

USER $USERNAME

WORKDIR /home/$USERNAME

# for development of this Docker environment
FROM builder AS dev

COPY .files.copy .files

RUN ./.files/setup.sh && \
    nvim --headless "+Lazy! sync" +qa

# for actual use of this Docker environment
FROM builder AS prod

RUN git clone https://github.com/bashar-515/dotfiles.git .files && \
    ./.files/setup.sh && \
    nvim --headless "+Lazy! sync" +qa
