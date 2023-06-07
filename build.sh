export DRAGONOS_SYSROOT=$(pwd)/sysroot

stage0(){
    echo "正在进行stage0构建"
    dadk --config-dir ./dadk_config_stage0 --dragonos-dir $DRAGONOS_SYSROOT build || exit 1
    dadk --config-dir ./dadk_config_stage0 --dragonos-dir $DRAGONOS_SYSROOT install || exit 1
}

stage1(){
    echo "正在进行stage1构建"
    dadk --config-dir ./dadk_config_stage1 --dragonos-dir $DRAGONOS_SYSROOT build || exit 1
    dadk --config-dir ./dadk_config_stage1 --dragonos-dir $DRAGONOS_SYSROOT install || exit 1
}

stage2(){
    echo "正在进行stage2构建"
    dadk --config-dir ./dadk_config_stage2 --dragonos-dir $DRAGONOS_SYSROOT build || exit 1
    dadk --config-dir ./dadk_config_stage2 --dragonos-dir $DRAGONOS_SYSROOT install || exit 1
}

stage0 || exit 1
source ~/.bashrc
stage1 || exit 1
source ~/.bashrc
stage2 || exit 1
source ~/.bashrc


