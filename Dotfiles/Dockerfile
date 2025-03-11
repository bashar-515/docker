FROM ubuntu:latest AS builder

ARG USERNAME=bashar-dot

RUN useradd -ms /bin/bash $USERNAME

WORKDIR /home/$USERNAME

FROM builder AS dev

COPY dotfiles.copy .files

RUN ./.files/install.sh

USER $USERNAME

RUN ./.files/stow.sh

USER root

RUN ./.files/setup.sh && \
    nvim --headless "+Lazy! sync" +qa

USER $USERNAME

FROM builder AS prod

RUN apt-get update && \
    apt-get install -y git

RUN ./.files/install.sh

USER $USERNAME

RUN ./.files/stow.sh

USER root

RUN ./.files/setup.sh && \
    nvim --headless "+Lazy! sync" +qa

USER $USERNAME
