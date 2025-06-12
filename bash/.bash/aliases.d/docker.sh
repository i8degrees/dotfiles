#!/usr/bin/env bash
#
#

[ -e "$HOME/.bash/lib" ] && . "$HOME/.bash/lib"

dockershell() {
  NAME=$1
  NS=$2
  SHELL=/bin/sh
  if [ -n "$NS" ]; then
    SHELL="$2"
  fi

  if [ -z "$NAME" ]; then
    return 1;
  fi

  docker exec -it "$NAME" "$SHELL"
}

# https://bytefreaks.net/applications/docker/how-to-list-all-docker-container-names-and-their-ips
showDockerIps() {
  containerIps="$(docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }} {{range .NetworkSettings.Networks}} {{.IPAddress}} / {{.GlobalIPv6Address}}{{end}}' | sed 's#^/##' | sort -u)";
  numContainers="$(docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }} {{range .NetworkSettings.Networks}} {{.IPAddress}} / {{.GlobalIPv6Address}}{{end}}' | sed 's#^/##' | sort -u|wc -l)";

  echo "${containerIps}"
  echo
  echo "NumContainers: ${numContainers}"
}

# TODO(JEFF): Verify
showDockerLabels() {
  cid="$1"
  containerLabels="$(docker ps -q | xargs -n 1 docker inspect --format "{{json .Config.Labels}}" "$cid" | sort -u | jq .)"
  numContainers="$(docker ps -q | xargs -n 1 docker inspect --format "{{json .Config.Labels}}" "$cid" | sort -u | wc -l)"

  echo "${containerLabels}"
  echo
  echo "NumContainers: ${numContainers}"
}

#alias compose='k3s kubectl exec -it docker-1-847bfd6c5d-mwqp6 -n ix-docker-1 -- docker compose $@'
#alias docker='k3s kubectl exec -it docker-1-695d96b4f6-5nlx6 -n ix-docker-1 -- docker $@'

# NOTE(JEFF): Try to warn the user of missing dependencies that may affect the usage of these aliases.
# Some of these are typicallly shell "built-ins" depending on the interpreter,
# such as is the case with BASH.
deps=(jq sed sort wc bc docker)
for script in "${deps[@]}"; do
  if ! exists_exe "$script"; then
    echo "ERROR: Failed to find $script..."
    continue
    #exit 2
  fi
done

if exists_exe docker; then
  # Docker aliases
  alias dockerlogs='docker logs'
  alias dockerrestart='docker restart'
  alias dockerlist='docker ps'
  alias dockerlistcount='docker ps -qa|wc'
  alias dockerstop='docker sto'
  alias dockerstart='docker start'
  alias dockerrm='docker rm'
  #alias dockerstoprm='docker stop $@; docker rm $@'

  # Docker compose aliases
  alias compose='docker compose'
  alias composelogs='compose logs'
  alias composerestart='compose restart'
  alias composeup='compose up -d'
  alias composedown='compose down'
  alias composestart='composeup'
  alias composestop='compose stop'
  alias composebuild='compose build'
  [ -n "$DEBUG" ] && echo "INFO: Docker aliases have been setup..."
fi

