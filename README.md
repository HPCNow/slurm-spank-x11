# Slurm plugin for X11 support
This plugin allows to do X
Developed by
Contributors
- 
- 
-

# How to build and install RPM packages for CentOS/RHEL/SuSE

```
wget URL
rpmbuild 
rpm -ivh 
```

# How to build and install DEB packages for Debian/Ubuntu

```
wget URL
tar -jxvf slurm-spank-x11-xxx
cd slurm-spank-x11-xxx
gbp buildpackage --git-ignore-new -us -uc
dpkg -i slurm-spank-x11-XXX.deb
```
