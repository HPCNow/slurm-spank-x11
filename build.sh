#!/bin/bash
#
gcc -fPIC -shared -I/usr/scheduler/slurm/include -I/usr/include \
    -o x11.so slurm-spank-x11-plug.c
#
gcc -o slurm-spank-x11 slurm-spank-x11.c