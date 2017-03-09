#!/bin/sh

case $1 in
    test)
        docker ps | grep -s -q murdock_slave
        ;;
    start)
        echo docker rm murdock_slave
        echo docker pull kaspar030/riotdocker:latest
        echo start_murdock_slave.sh
        ;;
    stop)
        echo docker kill murdock_slave
        ;;
esac
