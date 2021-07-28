#!/bin/bash

set -x
set -e

if [ $# -eq 0 ]; then
    # ARCH=x86
    # ARCH=x86_64
    # ARCH=armeabi-v7a
    ARCH=arm64-v8a
else
    ARCH=$1
fi

LLVM_STRIP=llvm-strip
# LLVM_STRIP=$NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin/llvm-strip.exe

BUILD_DIR=build-android-$ARCH

rm -rf $BUILD_DIR/output

cmake -B $BUILD_DIR \
    -GNinja \
    -DCMAKE_TOOLCHAIN_FILE=$NDK_ROOT/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ARCH \
    -DANDROID_PLATFORM=android-19 \
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
