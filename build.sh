#!/bin/bash
BUILD_START=$(date +"%s")
KERNEL_DIR=$PWD
export KBUILD_BUILD_USER="octo21" # Build Host
export KBUILD_BUILD_HOST="lineageOS" # Build Name
REPACK_DIR=/home/octo21/android/octopus_aosp_mido/AnyKernel2
OUT=$KERNEL_DIR/out
ZIP_NAME="$VERSION"-v3.0-"$DATE"
VERSION="mido"
DATE=`date +"%Y%m%d"`
export ARCH=arm64 && export SUBARCH=arm64
export CROSS_COMPILE="/home/octo21/android/aarch64-linux-android/bin/aarch64-linux-android-"
export CROSS_COMPILE_ARM32="/home/octo21/android/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-"
export STRIP_KO="/home/octo21/android/aarch64-linux-android/aarch64-common-linux-android/bin/strip"

make_zip()
{
		cd $REPACK_DIR
		cp $KERNEL_DIR/out/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-nontreble.dtb $REPACK_DIR/treble-unsupported/
		cp $KERNEL_DIR/out/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-treble.dtb $REPACK_DIR/treble-supported/
		cp $KERNEL_DIR/out/arch/arm64/boot/Image.gz $REPACK_DIR/
		FINAL_ZIP="${VERSION}-octopus-${DATE}.zip"
		zip -r9 "${FINAL_ZIP}" *
		cp *.zip $OUT
		rm *.zip
		cd $KERNEL_DIR
}

make O=out octopus_defconfig
make O=out -j$(nproc --all)
make_zip

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
