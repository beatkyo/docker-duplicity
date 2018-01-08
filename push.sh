#!/bin/bash
set -e

ARCH=${1:-$(uname -m)}

function push {
  echo
  echo "+ push"
  echo "+ image: dalexandre/duplicity-${ARCH:?}:latest"
  echo

  docker push "dalexandre/duplicity-$ARCH:latest"
}

function push-i386 {
	ARCH="i386"

	push
}

function push-amd64 {
	ARCH="amd64"

	push
}

function push-aarch64 {
  ARCH="arm64v8"

  push
}

function push-x86_64 {
	push-amd64
}

push-$ARCH
