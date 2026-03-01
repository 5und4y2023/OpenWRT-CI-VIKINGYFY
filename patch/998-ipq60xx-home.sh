#!/bin/sh
uci set luci.main.mediaurlbase='/luci-static/bootstrap'
uci commit luci


uci set wireless.default_radio0.ssid=CMCC-E155
uci set wireless.radio0.txpower='20'
uci set wireless.default_radio1.ssid=CMCC-E122
uci set wireless.radio1.txpower='20'
uci set wireless.default_radio0.key=86880959189
uci set wireless.default_radio1.key=86880959Liu
uci commit wireless

uci del network.lan.ipaddr
uci add_list network.lan.ipaddr='192.168.13.1/24'
uci del network.wan6
uci set network.lan.ip6assign=64
uci del network.globals.ula_prefix
uci set network.lan.ip6ifaceid='random'

uci set network.wan.proto='pppoe'
uci set network.wan.username='037606332332'
uci set network.wan.password='332332'

uci commit dhcp
uci commit network
uci commit

sed -i 's/root::0:0:99999:7:::/root:$1$uqDPdTlT$M6M5orrncaHsn.z.RWRcL\/:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$uqDPdTlT$M6M5orrncaHsn.z.RWRcL\/:0:0:99999:7:::/g' /etc/shadow

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i '/passwall/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/nss/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/sqm/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/qualcommax/d' /etc/apk/repositories.d/distfeeds.list
sed -i 's#downloads.immortalwrt.org#mirror.nju.edu.cn/immortalwrt#g' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://downloads.openwrt.org/snapshots/targets/qualcommax/ipq60xx/kmods/6.12.71-1-f3a2414047faa4fea126ea97c911a6ab/packages.adb' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/qualcommax/ipq60xx/packages/packages.adb' /etc/apk/repositories.d/distfeeds.list

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''


uci commit
#不用重启network，源码自带
exit 0
