export CROSS_COMPILE=/home/j0sh1x/toolchain/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/j0sh1x/toolchain32/bin/arm-linux-androideabi-
export ARCH=arm64
d=`date +%m%d`
path="scripts/prebuilt/clang/bin/"
defcon=b1c1_defconfig
dp=DP2

if [ -d out/ ]
then
    echo "clearing out directory"
    make clean
    make mrproper
    rm -rf out
else
    echo "creating out directory"
    mkdir out
fi

make O=out $defcon
make O=out -j$(nproc --all)

if [ ! -d ../kernels/ ]
then
    mkdir ../kernels/
fi

./scripts/mkbootimg/mkbootimg.py --kernel out/arch/arm64/boot/Image.lz4-dtb --ramdisk scripts/prebuilt/ramdisk --dtb scripts/prebuilt/dtb --cmdline 'console=ttyMSM0,115200n8 androidboot.console=ttyMSM0 printk.devkmsg=on msm_rtb.filter=0x237 ehci-hcd.park=3 service_locator.enable=1 cgroup.memory=nokmem lpm_levels.sleep_disabled=1 usbcore.autosuspend=7 loop.max_part=7 androidboot.boot_devices=soc/1d84000.ufshc androidboot.super_partition=system buildvariant=userdebug androidboot.selinux=permissive' --header_version 2 -o ../kernels/${d}_KernelSU_${dp}.img

echo "Your finished kernel is in ../kernels"


