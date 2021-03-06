#!/bin/bash

cwdir=`pwd`
rootdir=`dirname "$0"`
cd "$rootdir"
rootdir=`pwd`
target=macos_x86_32
prefix=$rootdir/$target
version=`cat "$rootdir/version.txt"`
rm -rf "$rootdir/$version"
mkdir -p "$rootdir/$version"
cp -rf "$rootdir/../$version/"* "$rootdir/$version"
rm -rf "$rootdir/build"
mkdir -p "$rootdir/build"
cd "$rootdir/build"
cmake -DBUILD64=OFF -C "$rootdir/CMakeLists.txt" -DWITH_ZLIB=OFF -DWITH_BZip2=OFF -DWITH_PNG=OFF -DWITH_HarfBuzz=OFF -DCMAKE_INSTALL_PREFIX="$prefix" "$rootdir/$version"
cmake --build . --target install --config Release --clean-first
mkdir -p "$rootdir/../target/include/$target"
cp -rf "$prefix/include/freetype2/"* "$rootdir/../target/include/$target"
mkdir -p "$rootdir/../target/lib/$target"
cp -f "$prefix/lib/libfreetype.a" "$rootdir/../target/lib/$target"
cd "$cwdir"
rm -rf "$rootdir/$version"
rm -rf "$rootdir/build"
rm -rf "$prefix"
