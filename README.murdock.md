# Setting up a murdock slave

## Overview

This guide has instructions on how to set up a slave for RIOT's Murdock 2
distributed build system.

The slave will run within a container and connect to Murdock's disque server
via ssh.

It needs a user, mainly for holding the ssh configuration, and as a place for
ccache.  By default, the slave will use up to 50g for the cache.

## Setup

1. create user

    # sudo useradd -r -d /srv/murdock murdock

2. Extract murdock_slave_homedir.tgz into /srv
   (the archive contains ssh configuration)

   sudo tar -C /srv murdock_slave_homedir.tgz

3. make sure murdock user can ssh "murdock" without password

    # sudo su -s /bin/sh - murdock
    # ssh murdock && echo OK!

4. create container

    # docker build -t riotdocker-dwq .

5. Adjust tmpfs in start_murdock_slave.sh
   Find the size=1g option and set it to around 250mb per core/hyperthread
   The default of 1g is fine for quad core boxes without hyperthreading

4a. Now either start the murdock slave manually:

    # sh start_murdock_slave.sh

Or install systemd service:

4b. install helper script and systemd service

    # sudo cp start_murdock_slave.sh /usr/local/bin
    # sudo cp murdock-slave.service /etc/systemd/system
    # sudo systemctl daemon-reload
    # sudo systemctl enable murdock-slave
    # sudo systemctl start murdock-slave

Now Warm up cache:

5. warm up ccache
    # pip install --user dwq
    # export DWQ_REPO=https://github.com/RIOT-OS/RIOT DWQ_COMMIT=<master HEAD commit>
    # dwqc -q $(hostname) './.murdock get_jobs' | dwqc -P

This'll take ~2.5hrs on a quad-core box.
