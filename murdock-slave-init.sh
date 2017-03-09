#!/bin/sh

NAME=murdock_slave

case $1 in
    test)
        docker ps | grep -s -q "\\s${NAME}\$"
        ;;
    start)
        docker rm ${NAME} >/dev/null 2>&1
        docker pull kaspar030/riotdocker:latest
        start_murdock_slave.sh
        ;;
    stop)
        docker kill ${NAME}
        docker rm ${NAME}
        ;;
esac
