FROM ubuntu:latest AS builder

ARG USERNAME=bashocker

RUN useradd -ms /bin/bash ${USERNAME}

WORKDIR /home/$USERNAME

FROM builder AS dev

COPY dotfiles.copy .files

RUN ./.files/install.sh ./

USER $USERNAME

RUN ./.files/stow.sh ./

RUN nvim --headless "+Lazy! sync" +qa

FROM builder AS prod

ADD https://github.com/bashar-515/dotfiles/archive/refs/heads/main.tar.gz ./

RUN mkdir ./.files && \
    tar -xzf main.tar.gz --strip-components=1 -C .files && \
    rm main.tar.gz

RUN ./.files/install.sh ./

USER $USERNAME

RUN ./.files/stow.sh ./

RUN nvim --headless "+Lazy! sync" +qa
