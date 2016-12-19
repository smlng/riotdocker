#!/bin/sh

exec docker run --rm -t -i -u $(id -u) \
	--tmpfs /tmp:rw,exec,size=8g \
    -v ${HOME}/.ssh:/data/riotbuild/.ssh \
	-v ${HOME}/.gitcache:/data/riotbuild/.gitcache \
	-v ${HOME}/.ccache:/data/riotbuild/.ccache \
    -e CCACHE="ccache" \
	-e "DWQ_SSH=${DWQ_SSH}" \
	riotdocker-dwq $*
