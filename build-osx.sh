#!/bin/bash
set -x
set -e

if [ $# -eq 0 ]; then
    # ARCH=arm64
    ARCH=x86_64
else
    ARCH=$1
fi

LLVM_STRIP=llvm-strip

BUILD_DIR=build-osx-$ARCH

rm -rf $BUILD_DIR/output

cmake -B $BUILD_DIR \
    -GNinja \
    -DCMAKE_OSX_ARCHITECTURES=$ARCH \
    -DCMAKE_BUILD_TYPE=Release \
    -DENABLE_HLSL=OFF \
    -DENABLE_SPVREMAPPER=OFF \
    -DSKIP_GLSLANG_INSTALL=ON \
    -DSPIRV_SKIP_EXECUTABLES=ON

ninja -C $BUILD_DIR

mkdir $BUILD_DIR/output
find $BUILD_DIR -name "*.a" -exec $LLVM_STRIP --strip-debug {} \; -exec cp {} $BUILD_DIR/output \;

rm $BUILD_DIR/output/*SPIRV-Tools-link*
rm $BUILD_DIR/output/*SPIRV-Tools-reduce*
