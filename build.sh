#!/bin/bash -e
#
## Installation directory for x11.so
PLUGINDIR=$( scontrol show config | awk '/PluginDir/ {print $3}' )
## Installation directory for slurm-spank-x11
EXECDIR=$( awk '/define X11_L/ {print $3}' slurm-spank-x11-plug.c | sed 's/"//g' )
## Installation directory for xalloc script
SCRIPTDIR=$( which salloc | sed 's/\/salloc//g' )
#
## Check if executing as root
if [[ $EUID -ne 0 ]]; then
   echo -en "\nThis script must be run as root. Sorry...\n\n" 1>&2
   exit 1
fi
## Build plugin components
gcc -fPIC -shared -I/usr/scheduler/slurm/include -I/usr/include \
    -o x11.so slurm-spank-x11-plug.c
gcc -o slurm-spank-x11 slurm-spank-x11.c
#
## Prompt for x11.so installation
if [ ! -d "${PLUGINDIR}" ]; then
    echo -e "\nDirectory ${PLUGINDIR} not present. What should I do?"
    select yn in "Create" "Skip"; do
	case $yn in
            Create ) echo -ne '\n>>> '; mkdir -vp ${PLUGINDIR}; break;;
            Skip ) INSTALL=false; break;;
	esac
    done
fi
#
if [ "${INSTALL}" != false ]; then
    echo -en "\nInstall x11.so in ${PLUGINDIR} ?\n"
    select yn in "Yes" "No"; do
	case $yn in
            Yes ) mv x11.so ${PLUGINDIR}; \
		  chmod 755 ${PLUGINDIR}/x11.so; \
		  break;;
            No ) echo -ne '\n>>> Skip x11.so installation\n\n'; \
		 break;;
	esac
    done
else
     echo -en '\n>>> No installation directory. Skip x11.so installation\n\n'
fi
#
## Prompt for slurm-spank-x11 installation
if [ ! -d "${EXECDIR}" ]; then
    echo -e "Directory ${EXECDIR} not present. What should I do?"
    select yn in "Create" "Skip"; do
	case $yn in
            Create ) echo -ne '\n>>> '; \
		     mkdir -vp ${EXECDIR}; \
		     echo; \
		     break;;
            Skip ) INSTALL=false; break;;
	esac
    done
fi
#
if [ "${INSTALL}" != false ]; then
    echo "Install slurm-spank-x11 in ${EXECDIR} ?"
    select yn in "Yes" "No"; do
	case $yn in
            Yes ) mv slurm-spank-x11 ${EXECDIR}; \
		  chmod 755 ${EXECDIR}/slurm-spank-x11; \
		  break;;
            No ) echo -ne '\n>>> Skip slurm-spank-x11 installation\n'; \
		 break;;
	esac
    done
else
     echo -en '\n>>> No installation directory. Skip slurm-spank-x11 installation\n\n'
fi
#
## Prompt for xalloc installation
if [ ! -d "${SCRIPTDIR}" ]; then
    echo -e "Directory ${SCRIPTDIR} not present. What should I do?"
    select yn in "Create" "Skip"; do
	case $yn in
            Create ) echo -ne '\n>>> '; \
		     mkdir -vp ${SCRIPTDIR}; \
		     echo; \
		     break;;
            Skip ) INSTALL=false; break;;
	esac
    done
fi
#
if [ "${INSTALL}" != false ]; then
    echo "Install xalloc in ${SCRIPTDIR} ?"
    select yn in "Yes" "No"; do
	case $yn in
            Yes ) cp xalloc ${SCRIPTDIR}; \
		  chmod 755 ${SCRIPTDIR}/xalloc; \
		  break;;
            No ) echo -ne '\n>>> Skip xalloc installation\n'; \
		 break;;
	esac
    done
else
     echo -en '\n>>> No installation directory. Skip xalloc installation\n\n'
fi