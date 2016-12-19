#!/bin/sh

autossh -f -N -L7711:localhost:7711 \
    -o ServerAliveInterval=60 -o ServerAliveCountMax=2 \
    ${DWQ_SSH:-murdock}

git-cache init

exec dwqw $*
