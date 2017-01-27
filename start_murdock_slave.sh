#!/bin/sh

MURDOCK_HOSTNAME=${MURDOCK_HOSTNAME:-$(hostname)}
MURDOCK_USER=${MURDOCK_USER:-${USER}}
MURDOCK_HOME=$(eval echo ~${MURDOCK_USER})
MURDOCK_QUEUES=${MURDOCK_QUEUES:-${MURDOCK_HOSTNAME} default}
#MURDOCK_EXTRA_ARGS="--tmpfs /tmp:size=4g,exec,nosuid"

echo exec docker run --rm -t -i -u $(id -u ${MURDOCK_USER}) \
    -v ${MURDOCK_HOME}:/data/riotbuild \
    ${MURDOCK_EXTRA_ARGS} \
    -e CCACHE="ccache" \
    -e DWQ_SSH \
    --security-opt seccomp=unconfined \
    riotdocker-dwq murdock_slave --name $MURDOCK_HOSTNAME --queues ${MURDOCK_QUEUES}
