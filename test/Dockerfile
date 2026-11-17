# Fresh Ubuntu with a sudo user, roughly what a new desktop install has.
# Built and run by test/docker.sh, which mounts the repo at ~/env.
ARG VERSION=26.04
FROM ubuntu:${VERSION}
RUN apt-get update \
 && ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      sudo ca-certificates whiptail tzdata \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -m -s /bin/bash tester \
 && echo 'tester ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/tester
USER tester
ENV TERM=xterm-256color
WORKDIR /home/tester/env
