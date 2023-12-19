#!/bin/bash

# 架构类型, arm64, x86_64, 根据需要选择
ARCHS="x86_64"

# 设置SDK路径
SDK_PATH=$(xcrun --sdk appletvos --show-sdk-path)
OS_VERSION_MIN="-mappletvos-version-min=13.0"
# 根据架构选择合适的SDK
if [ "$ARCHS" == "x86_64" ]; then
    SDK_PATH=$(xcrun --sdk appletvsimulator --show-sdk-path)
    OS_VERSION_MIN="-mappletvsimulator-version-min=13.0"
fi

echo "**** $SDK_PATH"

# 设置安装目录
PREFIX="./build_tvos/$ARCHS"

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
    --disable-audiotoolbox \
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
    --disable-indev=avfoundation \
    || exit 1
    ##tvos 下不编译 avfoundation

# 编译和安装
# 编译和安装
make -j$(sysctl -n hw.ncpu) && make install || exit 1

# 清理临时文件
make clean