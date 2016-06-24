package: jsonbox
version: master
source: https://github.com/anhero/JsonBox
build_requires:
- CMake
tag: master
---
#!/bin/sh
cmake "$SOURCEDIR"                               \
      -DCMAKE_INSTALL_PREFIX=$INSTALLROOT        

make ${JOBS:+-j $JOBS}
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
setenv JSONBOX_ROOT \$::env(BASEDIR)/$PKGNAME/\$version
prepend-path LD_LIBRARY_PATH \$::env(JSONBOX_ROOT)/lib
EoF