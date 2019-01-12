#!/bin/sh

case "$(uname -s)" in
  CYGWIN*|MINGW32*|MSYS*) ext=.cmd; plat=windows;;
  *) plat=linux;;
esac;

case $1 in
  clean)
    rm -rf libs obj;
    exit 0;
  ;;
esac;

if [ ! "$NDK_ROOT" ]; then
  NDK_ROOT=`pwd`/android-ndk-r15c;
fi;
if [ ! "$NDK_TOOLCHAIN_VERSION" ]; then
  NDK_TOOLCHAIN_VERSION=clang;
fi;
if [ ! "$APP_ABI" ]; then
  APP_ABI=armeabi;
fi;
if [ ! "$APP_PLATFORM" ]; then
  APP_PLATFORM=android-21;
fi;

# Set up Android NDK
echo "Fetching Android NDK r15c"
[ -f "android-ndk-r15c-linux-x86_64.zip" ] || wget https://dl.google.com/android/repository/android-ndk-r15c-$plat-x86_64.zip
[ -d "android-ndk-r15c" ] || unzip -o android-ndk-r15c-$plat-x86_64.zip

# Build
$NDK_ROOT/ndk-build$ext NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk NDK_TOOLCHAIN_VERSION=$NDK_TOOLCHAIN_VERSION APP_ABI=$APP_ABI APP_PLATFORM=$APP_PLATFORM APP_STL=gnustl_static;
exit 0;

