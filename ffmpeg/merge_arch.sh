#!/bin/bash

PREPATH=$1
if [[ "$PREPATH" == "" ]]; then
  echo "The Input params Path is empty."
  exit 1
fi

echo "$PREPATH"

# 设置 arm64 和 x86 静态库的路径
ARM64_LIBS_PATH="./$PREPATH/arm64/lib"
X86_LIBS_PATH="./$PREPATH/x86_64/lib"

# 设置输出通用库的路径
UNIVERSAL_LIBS_PATH="./$PREPATH/universal"

# 创建存放合并后通用库的文件夹
mkdir -p "$UNIVERSAL_LIBS_PATH"

# 遍历 arm64 文件夹中的所有 .a 文件
for ARM64_LIB in "$ARM64_LIBS_PATH"/*.a; do
    # 获取库的基本名称（不包含路径）
    LIB_NAME=$(basename "$ARM64_LIB")

    # 对应的 x86 库的路径
    X86_LIB="$X86_LIBS_PATH/$LIB_NAME"

    # 输出通用库的完整路径
    UNIVERSAL_LIB="$UNIVERSAL_LIBS_PATH/$LIB_NAME"

    # 检查 x86 版本的库是否存在
    if [ -f "$X86_LIB" ]; then
        # 使用 lipo 合并两个架构的库
        lipo -create "$ARM64_LIB" "$X86_LIB" -output "$UNIVERSAL_LIB"
        echo "Created universal library: $UNIVERSAL_LIB"
    else
        echo "Warning: Matching x86 library not found for $LIB_NAME"
    fi
done