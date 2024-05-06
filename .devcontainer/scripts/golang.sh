#!/bin/bash

GOLANG_VERSION="${1:-"1.22.2"}"

architecture="$(uname -m)"
case ${architecture} in
  x86_64) architecture="amd64";;
  aarch64 | armv8*) architecture="arm64";;
  aarch32 | armv7* | armvhf*) architecture="arm";;
  i?86) architecture="386";;
  *) echo "(!) Architecture ${architecture} unsupported"; exit 1 ;;
esac

echo "Downloading golang ${GOLANG_VERSION}..."

curl -sSL -o "/tmp/golang.tar.gz" "https://go.dev/dl/go${GOLANG_VERSION}.linux-${architecture}.tar.gz"
tar -C "/usr/local" -xzf "/tmp/golang.tar.gz"

echo "Done..."