# hohsaki/asm-i386:1.0

FROM i386/debian:bullseye-20210621

COPY package-core.lst /

ENV DEBIAN_FRONTEND noninteractive

# install packages
RUN set -eux; \
    sed -i 's/ main/ main contrib non-free/' /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends $(cat /package-core.lst)

# install i386-specific packages
RUN set -eux; \
    apt-get install -y --no-install-recommends gdb-multiarch

# generate en_US.UTF-8 locale
RUN set -eux; \
    sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen; \
    locale-gen

# enable AArch64 binary support
RUN set -eux; \
    mkdir /etc/qemu-binfmt; \
    ln -s /usr/aarch64-linux-gnu /etc/qemu-binfmt/aarch64

# install Python modules
RUN set -eux; \
    pip3 install casl ecalc py-stats

# add user `asm'
RUN set -eux; \
    useradd --uid 1000 --gid staff --groups sudo --shell /bin/bash --home-dir /home/asm  asm; \
    echo 'asm:as -a foo.s' | chpasswd

# copy source code
ADD code.tar.gz /home/asm
RUN chown -R asm.staff /home/asm/code

# start SSH daemon
CMD mkdir /run/sshd; chmod 0755 /run/sshd; /usr/sbin/sshd -D
