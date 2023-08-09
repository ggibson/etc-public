#!/bin/bash
alias dc=docker-compose

# useful commands
# docker image prune -- removed unused, dangling layers


unset DOCKER_CERT_PATH
unset DOCKER_HOST
unset DOCKER_TLS_VERIFY

function docker.doall {
	local cmd=$1
	docker ps | awk '{ print $1}' | grep -v CONTAINER | xargs -I % docker $cmd %
}

function docker.dogroup {
	local str=$1
	local cmd=$2
	docker ps -a | grep $str | awk '{ print $1}' | grep -v CONTAINER | xargs -I % docker $cmd %
}

function docker.find {
	local str=$1
	docker ps -a | grep $str | awk '{ print $1 }'
}

# nuke all the containers
function docker.clean_all {
  docker rm $(docker ps -aq)

  # from http://tiborsimko.org/docker-for-python-applications.html
  # We can remove all "incompletely built" images by running:
  #
  # $ docker images | grep none | awk '{print "docker rmi " $3;}' | sh
}

# clean up all exited containers
function docker.clean {
    docker ps -a | grep Exited | awk '{ print $1 }' | xargs -I % docker rm %
}

function docker.newest {
    local container=$(docker ps | grep -v CONTAINER | head -n 1 | awk '{ print $1 }')
    echo $container
}


function docker.sh {
    local newest=$(docker.newest)
    local cid=${1:-$newest}
    docker exec -u ${2:-root} -it $cid sh
}

function docker.dcsh {
	dc exec $1 bash
}

alias dsh=docker.sh
alias dcsh=docker.dcsh


docker.examine() {
    local image=$1
    docker run --rm -it --entrypoint=/bin/bash $image -i
}

docker.killall() {
    docker ps | awk '{print$1}' | xargs -I % docker kill %
}

docker.rm_untagged() {
    docker images | grep none | awk '{print $3}' | xargs -I % docker rmi %
}
