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

if [ ! -d ${gcc_path} ]; then
    echo "INFO: ${gcc_path} not found, cloning DragonOS-gcc..."
    git clone https://github.com/DragonOS-Community/gcc.git --depth=1

else
    echo "INFO: ${gcc_path} found, pulling DragonOS-gcc..."
    cd ${gcc_path}
    git pull
    cd ${CURRENT_DIR}
fi

if [ ! -d ${sys_root} ]; then
    echo "Error: ${sys_root} not found"
    exit 1
fi

# 安装依赖
# 注意texinfo和binutils的版本是否匹配
# 注意gmp/mpc/mpfr和gcc/g++的版本是否匹配
sudo apt-get install -y \
    g++ \
    gcc \
    make \
    texinfo \
    libgmp3-dev \
    libmpc-dev \
    libmpfr-dev \
    flex \
    wget

mkdir -p build-gcc || exit 1
mkdir -p ${PREFIX} || exit 1

cd build-gcc
${gcc_path}/configure --prefix=${PREFIX} --target=x86_64-dragonos --with-sysroot=${sys_root} --disable-werror --disable-shared --disable-bootstrap --enable-languages=c,c++ || exit 1
make all-gcc all-target-libgcc -j $(nproc) || exit 1
make install-gcc install-target-libgcc -j $(nproc)  || exit 1

# 如果没有检测到x86_64-dragonos-gcc，需要往bashrc里添加环境变量
echo "export PATH=$HOME/opt/dragonos-host-userspace/bin:$PATH" >> ~/.bashrc
source ~/.bashrc