#!/bin/bash
#=================================================
# https://github.com/kingyan/Actions-Padavan
# Description: DIY script
# Lisence: MIT
# Author: kingyan
#=================================================
cd /opt/rt-n56u/trunk

# 优化编译脚本
sed -i '5,11d' build_firmware_modify

# 复制K2编译文件
cp -a configs/boards/PSG1218 configs/boards/K2
sed -i 's/PSG1218/K2/g' configs/boards/K2/board.h
sed -i 's/PSG1218/K2/g' configs/boards/K2/board.mk

# 修改K2配置文件
cp -f configs/templates/PSG1218.config configs/templates/K2.config
sed -i 's/PSG1218/K2/g' configs/templates/K2.config
cp -f configs/templates/PSG1218_nano.config configs/templates/K2_nano.config
sed -i 's/PSG1218/K2/g' configs/templates/K2_nano.config

# MT7615驱动优化
sed -i '/Peer\x27s MPFC isn\x27t used\./{s/DBG_LVL_ERROR/DBG_LVL_TRACE/g}' proprietary/rt_wifi/rtpci/5.0.3.0/mt7615/embedded/security/pmf.c

if [ ! -f configs/templates/$TNAME.config ] ; then
    echo "configs/templates/$TNAME.config not found "
    exit 1
fi
cp -f configs/templates/$TNAME.config .config
if  echo ${TNAME} | grep -qi "nano" ; then
#####################################################################################
        sed -i '/CONFIG_FIRMWARE_INCLUDE_MENTOHUST/d' .config #删除配置项MENTOHUST
        sed -i '/CONFIG_FIRMWARE_INCLUDE_SOFTETHERVPN_SERVER/d' .config #删除配置项SOFTETHERVPN
        sed -i '/CONFIG_FIRMWARE_INCLUDE_SOFTETHERVPN_CLIENT/d' .config #删除配置项SOFTETHERVPN
        sed -i '/CONFIG_FIRMWARE_INCLUDE_SOFTETHERVPN_CMD/d' .config #删除配置项SOFTETHERVPN
        sed -i '/CONFIG_FIRMWARE_INCLUDE_SCUTCLIENT/d' .config #删除配置项SCUTCLIENT
        sed -i '/CONFIG_FIRMWARE_INCLUDE_SHADOWSOCKS/d' .config #删除配置项SS plus+
        sed -i '/CONFIG_FIRMWARE_INCLUDE_SSSERVER/d' .config #删除配置项SS server
        sed -i '/CONFIG_FIRMWARE_INCLUDE_DNSFORWARDER/d' .config #删除配置项DNSFORWARDER
        sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' .config #删除配置项adbyby plus+
        sed -i '/CONFIG_FIRMWARE_INCLUDE_FRPC/d' .config #删除配置项adbyby plus+
        sed -i '/CONFIG_FIRMWARE_INCLUDE_FRPS/d' .config #删除配置项adbyby plus+
        sed -i '/CONFIG_FIRMWARE_INCLUDE_TUNSAFE/d' .config #删除配置项adbyby plus+
        sed -i '/CONFIG_FIRMWARE_INCLUDE_ALIDDNS/d' .config #删除配置项阿里DDNS
        sed -i '/CONFIG_FIRMWARE_INCLUDE_SMARTDNS/d' .config
        ######################################################################
        echo "CONFIG_FIRMWARE_INCLUDE_MENTOHUST=n" >> .config #MENTOHUST
        echo "CONFIG_FIRMWARE_INCLUDE_SOFTETHERVPN_SERVER=n" >> .config #SOFTETHERVPN
        echo "CONFIG_FIRMWARE_INCLUDE_SOFTETHERVPN_CLIENT=n" >> .config #SOFTETHERVPN
        echo "CONFIG_FIRMWARE_INCLUDE_SOFTETHERVPN_CMD=n" >> .config #SOFTETHERVPN
        echo "CONFIG_FIRMWARE_INCLUDE_SCUTCLIENT=n" >> .config #SCUTCLIENT
        echo "CONFIG_FIRMWARE_INCLUDE_SHADOWSOCKS=y" >> .config #SS plus+
        echo "CONFIG_FIRMWARE_INCLUDE_SSSERVER=n" >> .config #SS server
        echo "CONFIG_FIRMWARE_INCLUDE_DNSFORWARDER=n" >> .config #DNSFORWARDER
        echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> .config #adbyby plus+
        echo "CONFIG_FIRMWARE_INCLUDE_FRPC=n" >> .config #内网穿透FRPC
        echo "CONFIG_FIRMWARE_INCLUDE_FRPS=n" >> .config #内网穿透FRPS
        echo "CONFIG_FIRMWARE_INCLUDE_TUNSAFE=n" >> .config #TUNSAFE
        echo "CONFIG_FIRMWARE_INCLUDE_ALIDDNS=y" >> .config #阿里DDNS
        echo "CONFIG_FIRMWARE_INCLUDE_SMARTDNS=y" >> .config
        echo "CONFIG_FIRMWARE_INCLUDE_SMARTDNSBIN=y" >> .config #smartdns二进制文件
        echo "CONFIG_FIRMWARE_INCLUDE_TROJAN=n" >> .config #集成trojan执行文件，如果不集成，会从网上下载下来执行，不影响正常使用
        echo "CONFIG_FIRMWARE_INCLUDE_KOOLPROXY=y" >> .config #KP广告过滤
        echo "CONFIG_FIRMWARE_INCLUDE_CADDY=y" >> .config #在线文件管理服务
        echo "CONFIG_FIRMWARE_INCLUDE_CADDYBIN=n" >> .config #集成caddu执行文件，此文件有13M,请注意固件大小。如果不集成，会从网上下载下来执行，不影响正常使用
        echo "CONFIG_FIRMWARE_INCLUDE_KUMASOCKS=y" >> .config
        echo "CONFIG_FIRMWARE_INCLUDE_ADGUARDHOME=y" >> .config
        if [ "$m" = "K2P-5.0" ] || [ "$m" = "DIR-878-5.0" ]; then
        echo "CONFIG_FIRMWARE_INCLUDE_V2RAY=y" >> .config #v2ray二进制文件
        else
        echo "CONFIG_FIRMWARE_INCLUDE_V2RAY=n" >> .config #v2ray二进制文件
        fi
        ####################################################################################
fi
