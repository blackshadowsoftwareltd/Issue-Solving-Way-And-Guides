error: failed to run custom build command for `ring v0.16.20`


# [target.aarch64-linux-android]
# linker = "aarch64-linux-android26-clang"




error occurred: Failed to find tool. Is `aarch64-linux-android-ar` installed?

sudo dnf install binutils-aarch64-linux-gnu.x86_64

To fix copy and rename llvm-ar to aarch64-linux-android-ar in ${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/{SYSTEM}/bin
