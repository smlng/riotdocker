#!/bin/sh

MURDOCK_HOSTNAME=${MURDOCK_HOSTNAME:-$(hostname)}
MURDOCK_USER=${MURDOCK_USER:-murdock}
MURDOCK_HOME=$(eval echo ~${MURDOCK_USER})
MURDOCK_QUEUES=${MURDOCK_QUEUES:-${MURDOCK_HOSTNAME} default}
MURDOCK_DOCKER_ARGS=${MURDOCK_DOCKER_ARGS:-"--tmpfs /tmp:size=1g,exec,nosuid"}

exec docker run --rm -u $(id -u ${MURDOCK_USER}) \
    -v ${MURDOCK_HOME}:/data/riotbuild \
    ${MURDOCK_DOCKER_ARGS} \
    -e CCACHE="ccache" \
    -e DWQ_SSH \
    --security-opt seccomp=unconfined \
    riotdocker-dwq murdock_slave --name $MURDOCK_HOSTNAME --queues ${MURDOCK_QUEUES} "$@"
