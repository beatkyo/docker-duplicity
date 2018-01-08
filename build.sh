#!/bin/bash
set -e

ARCH=${1:-$(uname -m)}
DIST="duplicity"

function build {
  echo
  echo "+ build"
  echo "+ arch: ${ARCH:?}"
  echo "+ image: ${IMAGE:?}"
  echo "+ dist: ${DIST:?}"
  echo

  export IMAGE

  docker build \
    --pull \
    --build-arg "IMAGE=$IMAGE" \
    --build-arg "DIST=$DIST" \
    --tag "dalexandre/duplicity-$ARCH:latest" \
    .
}

function build-i386 {
  ARCH="i386"
  IMAGE="i386/alpine"
  DIST="$DIST-linux-386"

  build
}

function build-amd64 {
  ARCH="amd64"
  IMAGE="amd64/alpine"
  DIST="$DIST-linux-amd64"

  build
}

function build-aarch64 {
  ARCH="arm64v8"
  IMAGE="arm64v8/alpine"
  DIST="$DIST-linux-arm64"

  build
}

function build-x86_64 {
  build-amd64
}

build-${ARCH:?}
