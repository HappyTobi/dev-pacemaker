FROM ubuntu:22.04

ARG GOLANG_VERSION="1.22.2"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Pacemaker envs
ENV OCF_ROOT /usr/lib/ocf/

RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  git \
  iproute2 \
  curl \
  python3 \
  python3-pip \
  make \
  unzip \
  pcs \
  pacemaker

COPY ./scripts/golang.sh /tmp/scripts/golang.sh
RUN chmod +x /tmp/scripts/golang.sh && /tmp/scripts/golang.sh "${GOLANG_VERSION}"

CMD bash