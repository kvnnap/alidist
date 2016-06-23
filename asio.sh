package: asio
version: master
source: https://github.com/Corvusoft/asio-dependency
requires:
- boost
build_requires:
- autotools
tag: master
---
#!/bin/sh

mkdir $INSTALLROOT/include/
rsync -av --delete --exclude="**/.git" $SOURCEDIR/asio/include/ $INSTALLROOT/include/
#cd asio
#./autogen.sh
#mkdir build
#cd build
#../configure --prefix="$INSTALLROOT"  				\
#			 --with-boost=${BOOST_ROOT}/include

#make ${JOBS:+-j $JOBS}
#make install

MODULEDIR="$INSTALLROOT/etc/modulefiles"
MODULEFILE="$MODULEDIR/$PKGNAME"
mkdir -p "$MODULEDIR"
cat > "$MODULEFILE" <<EoF
#%Module1.0
proc ModulesHelp { } {
  global version
  puts stderr "ALICE Modulefile for $PKGNAME $PKGVERSION-@@PKGREVISION@$PKGHASH@@"
}
set version $PKGVERSION-@@PKGREVISION@$PKGHASH@@
module-whatis "ALICE Modulefile for $PKGNAME $PKGVERSION-@@PKGREVISION@$PKGHASH@@"
# Dependencies
module load BASE/1.0
# Our environment
setenv ASIO_ROOT \$::env(BASEDIR)/$PKGNAME/\$version
EoF