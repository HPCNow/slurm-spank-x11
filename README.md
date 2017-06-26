# Building the RPM
```
export PKGNAME=$(basename $(pwd))
# pick one of the following, the matching git tag (or reference) must exist
export VERSION=$(grep 'Version:' $PKGNAME.spec)
export VERSION=0.2.5-2
export VERSION=0.2.5
# continue
export TOPDIR="$(pwd)/rpmbuild"
rm -rf "${TOPDIR}"
mkdir -p "${TOPDIR}"/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
git archive --prefix=$PKGNAME-$(echo $VERSION | cut -f 1 -d -)/ -o $TOPDIR/SOURCES/$PKGNAME-$(echo $VERSION | cut -f 1 -d -).tar.gz $VERSION
cp $PKGNAME.spec $TOPDIR/SPECS/
rpmbuild --define "_topdir $TOPDIR" -bb $TOPDIR/SPECS/$PKGNAME.spec
```
