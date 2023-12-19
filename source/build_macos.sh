#!/bin/bash

# 架构类型, arm64, x86_64, 根据需要选择
ARCHS="x86_64"

# 设置SDK路径
SDK_PATH=$(xcrun --sdk macosx --show-sdk-path)
OS_VERSION_MIN="-mmacosx-version-min=10.15"

echo "**** $SDK_PATH"

# 设置安装目录
PREFIX="./build_macos/$ARCHS"

make distclean
#
./configure \
    --target-os=darwin --arch=$ARCHS --enable-cross-compile \
    --sysroot=$SDK_PATH \
    --cc="$(xcrun -find clang)" \
    --extra-cflags="-arch $ARCHS $OS_VERSION_MIN -isysroot $SDK_PATH" \
    --extra-ldflags="-arch $ARCHS $OS_VERSION_MIN -isysroot $SDK_PATH" \
    --prefix=$PREFIX \
    --disable-debug --disable-programs \
    --enable-static --disable-shared \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-doc \
    --disable-htmlpages \
    --disable-manpages \
    --disable-podpages \
    --disable-txtpages \
    --enable-audiotoolbox \
    --enable-avformat \
    --enable-avcodec \
    --enable-swresample \
    --enable-swscale \
    --enable-avdevice \
    --enable-avfilter \
    --enable-pthreads \
    --enable-dwt \
    --enable-faan \
    --enable-pixelutils \
    || exit 1

# 编译和安装
# 编译和安装
make -j$(sysctl -n hw.ncpu) && make install || exit 1

# 清理临时文件
make clean