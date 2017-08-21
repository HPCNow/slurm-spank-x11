#!/usr/bin/make

CC      = gcc
CFLAGS  ?= -g 
LDFLAGS ?= -D"X11_LIBEXEC_PROG=\"/usr/bin/slurm-spank-x11\""

all: slurm-spank-x11

default: slurm-spank-x11

x11.so:
	$(CC) $(CFLAGS) -shared -fPIC -o x11.so $(LDFLAGS) slurm-spank-x11-plug.c


slurm-spank-x11: x11.so
	$(CC) $(CFLAGS) -o slurm-spank-x11 $(LDFLAGS) slurm-spank-x11.c

install: all
	mkdir -p $(BUILDROOT)/usr/lib/x86_64-linux-gnu/slurm/
	install -m 755 slurm-spank-x11 $(BUILDROOT)/usr/bin/
	install -m 755 x11.so $(BUILDROOT)/usr/lib/x86_64-linux-gnu/slurm/

clean:
	rm -f slurm-spank-x11 x11.so

