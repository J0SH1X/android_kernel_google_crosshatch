export CROSS_COMPILE=/home/j0sh1x/toolchain/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/j0sh1x/toolchain32/bin/arm-linux-androideabi-
export ARCH=arm64
#path="/home/j0sh1x/clang-toolchain/clang-r353983/bin/"
#export DATE=date '+%d-%m-%Y-%H-%M-%S'
defcon=b1c1_defconfig

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

cp /home/j0sh1x/kernel-crosshatch-q-dp2/out/arch/arm64/boot/Image.lz4-dtb ../kernels/Image.lz4-dtb
