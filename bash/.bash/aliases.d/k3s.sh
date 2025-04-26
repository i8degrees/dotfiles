#!/bin/sh
#
#

[ -x "$(which kubectl)" ] && alias kubectl='k3s kubectl $@'

function run() {
  [ -n "$DEBUG" ] && echo "DEBUG: $@"
  [ -z "$DRY_RUN" ] && "$*"
}

# list pods of Kubernetes orchestration cluster-fuck
function kubepods() {
  SHELL=/bin/sh
  run sudo k3s kubectl get pods -A $@
}

function kubelogs() {
  NAME=$1
  NS=$2
  run sudo k3s kubectl logs "$NAME" -n "$NS" | tail -n3
}

function kubeshell() {
  NAME=$1
  NS=$2
  SHELL=/bin/sh
  if [[ -n $3 ]]; then
    SHELL=$3
  fi
  run sudo k3s kubectl exec -it "$NAME" -n "$NS" -- "$SHELL"
}

function kubepod() {
  NAME=$1
  NS=$2
  run sudo k3s kubectl get pod "$NAME" -n "$NS"
}

