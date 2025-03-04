#!/bin/bash
# 添加 KernelSU
export BOOT_DIR=/home/dibin/boot/lmi-boot.img
export NEW_BOOT_DIR=/home/dibin/out

export OUT=out
export CLANG_PATH=/home/dibin/clang
export PATH=${CLANG_PATH}/bin:${PATH}
make LLVM=1 LLVM_IAS=1 O=out ARCH=arm64 SUBARCH=arm64 CC=clang LD=ld.lld vendor/lmi_defconfig
make -j$(nproc) LLVM=1 LLVM_IAS=1 O=${OUT} ARCH=arm64 SUBARCH=arm64 CC=clang LD=ld.lld CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi-

cd out/arch/arm64/boot
wget https://github.com/dibin666/toolchains/releases/download/magiskboot/magiskbootx86_64
chmod +x magiskbootx86_64

cp $BOOT_DIR ./

mv lmi-boot.img boot.img
./magiskbootx86_64 unpack boot.img
mv -f Image kernel
./magiskbootx86_64 repack boot.img
