##############################################
# DragonOS hosted gcc build script
#
# This script is used to build userland gcc for DragonOS（Running on Linux)
##############################################

# 编译前请先设置参数
sys_root=$DRAGONOS_SYSROOT
CURRENT_DIR=$(pwd)
gcc_path=${CURRENT_DIR}/gcc
# 要安装到的目录
PREFIX=$HOME/opt/dragonos-host-userspace

source ~/.bashrc

if [ ! -d ${gcc_path} ]; then
    echo "Error: ${gcc_path} not found"
    exit 1
fi

if [ ! -d ${sys_root} ]; then
    echo "Error: ${sys_root} not found"
    exit 1
fi



cd build-gcc

make all-target-libstdc++-v3 -j $(nproc) || exit 1
make install-target-libstdc++-v3 -j $(nproc) || exit 1
make clean
cd ..
rm -rf build-gcc
