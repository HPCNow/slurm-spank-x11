# Slurm spank plugin for X11 support
Some applications provide a graphical user interface (GUI) to interact while they are performing high IO and/or CPU intensive operations. 
This does not suit batch processing requirements but slurm can accomodate that with this plugin.

Once a resource allocation is granted you can take advantage of the X11 graphical forwarding functionality available in srun thanks to this plugin. 

Developed by Mathieu Hautreux (mathieu.hautreux@cea.fr)

Contributors:
- Stephan Gorget (Electricité De France)
- Ana Guerrero López (Electricité De France)
- Davide Vanzo (Vanderbilt University) 
- Jordi Blasco (HPCNow!)

# How to build and install RPM packages for CentOS/RHEL/SuSE

```
wget URL
rpmbuild -ta slurm-spank-x11-$VERSION.tar.bz2
rpm -ivh 
```

# How to build and install DEB packages for Debian/Ubuntu

```
wget URL
tar -jxvf slurm-spank-x11-xxx
cd slurm-spank-x11
debuild -i -us -uc -b
dpkg -i ../slurm-spank-x11-*.deb
```


# How to use the plugin

This plugin extends the srun options. By using the ```--x11``` option you will be able to export x11 display on first|last|all allocated node(s).

```
srun --x11=[batch|first|last|all] --pty bash
```

- ```--x11=batch```: supports use in a batch job submission, and will provide X11 forwarding to the first node allocated to a batch job.
- ```--x11=first```: [default] provides X11 forwarding to the first compute hosts allocated.
- ```--x11=last```: provides X11 forwarding to the last of the compute hosts allocated.
- ```--x11=all```: provides X11 forwarding from all allocated compute hosts.
