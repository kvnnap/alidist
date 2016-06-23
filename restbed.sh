package: restbed
version: master
source: https://github.com/Corvusoft/restbed
requires:
- asio
build_requires:
- CMake
tag: master
---
#!/bin/sh
cmake "$SOURCEDIR"                              \
      -DCMAKE_INSTALL_PREFIX=$INSTALLROOT       \
      -Dasio_INCLUDE=$ASIO_ROOT/include			\
      -DBUILD_SHARED=YES 						\
      -DBUILD_EXAMPLES=NO 						\
      -DBUILD_TESTS=NO 							\
      -DBUILD_SSL=YES

make ${JOBS:+-j $JOBS}	VERBOSE=1
make install

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
setenv RESTBED_ROOT \$::env(BASEDIR)/$PKGNAME/\$version
prepend-path LD_LIBRARY_PATH \$::env(RESTBED_ROOT)/library
EoF