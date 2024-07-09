#!/bin/bash

source .env

check_var() {
  if [[ -z "${!1}" ]]
  then
    echo "${1} is not set"
    exit
  fi
}

error() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}
