FROM --platform=linux/amd64 ubuntu:latest

# basic settings
RUN apt update -y
RUN apt install -y sudo git make curl ssh vim emacs clang
RUN useradd -m -s /bin/bash developer
RUN echo "developer:developer" | chpasswd
RUN gpasswd -a developer sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER developer
WORKDIR /home/developer/
EXPOSE 9944

# install rust
RUN sudo apt install -y build-essential
RUN sudo apt install -y --assume-yes git clang curl libssl-dev protobuf-compiler
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ./rustup.sh \
    && chmod +x ./rustup.sh \
    && .//rustup.sh -y --default-toolchain nightly --no-modify-path
ENV PATH="/home/developer/.cargo/bin:$PATH"
RUN rustup default stable
RUN rustup update
RUN rustup update nightly
RUN rustup target add wasm32-unknown-unknown --toolchain nightly
RUN rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu
RUN rm ./rustup.sh

# install cargo-contract
RUN rustup component add rust-src
RUN rustup target add wasm32-unknown-unknown --toolchain nightly
RUN rustup component add rust-src
RUN cargo install --force --locked cargo-contract --version 2.0.0-rc

# install node & npm
RUN sudo apt install -y nodejs npm
RUN sudo npm install -y -g n
RUN sudo n stable
RUN sudo apt purge -y nodejs npm

# intall yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt update
RUN sudo apt install -y yarn

# set git config
RUN git config --global user.name developer
RUN git config --global user.email developer@dev.com

# install swanky
RUN sudo npm install -y -g @astar-network/swanky-cli

