#!/bin/bash

set -e -x

BUILD_DIR="build"
BUILD_TARGET="all"
BUILD_TYPE="Debug"

if [ ! -d "$BUILD_DIR" ]; then
    mkdir $BUILD_DIR
fi

# 引数の解析
while [ $# -gt 0 ]; do
    case "$1" in
        "--target")
            shift
            if [$# -eq 0]; then
                break
            fi
            BUILD_TARGET="$1"
            shift
            ;;
        "--release")
            shift
            BUILD_TYPE="Release"
            ;;
        "--not-install")
            NOT_INSTALL="ON"
            shift
            ;;
        *)
            echo "無効なオプションが指定されました: $1"
            exit 1
            ;;
    esac
done

cmake -B $BUILD_DIR -DCMAKE_INSTALL_PREFIX=./bin -DCMAKE_BUILD_TYPE=${BUILD_TYPE}
cmake --build $BUILD_DIR --target $BUILD_TARGET -j$(nproc)
if [ !-z "${NOT_INSTALL}"]; then
    cmake --install $BUILD_DIR --component $BUILD_TARGET
fi