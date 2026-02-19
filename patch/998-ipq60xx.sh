#!/bin/sh
uci set luci.main.mediaurlbase='/luci-static/bootstrap'
uci commit luci

uci del network.wan6
uci set network.lan.ip6assign=64
uci del network.globals.ula_prefix
uci set dhcp.lan.dns_service='0'
uci del dhcp.lan.dhcpv6
uci del dhcp.lan.ndp
uci set dhcp.lan.ra='server'
uci del dhcp.lan.ra_flags
uci add_list dhcp.lan.ra_flags='none'
uci set network.lan.delegate='0'
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
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/openwrt/snapshots/targets/qualcommax/ipq60xx/kmods/6.12.69-1-67bbb6dcbb55390b208878d242522feb/packages.adb' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/qualcommax/ipq60xx/packages/packages.adb' /etc/apk/repositories.d/distfeeds.list

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

# wifi设置
uci set wireless.default_radio0.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-5G
uci set wireless.radio0.txpower='20'
uci set wireless.default_radio1.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-2.4G
uci set wireless.radio1.txpower='20'
uci commit wireless

#uci set network.lan.ipaddr='192.168.23.1'
#uci set network.usbwan=interface
#uci set network.usbwan.proto='dhcp'
#uci set network.usbwan.device='eth0'
#uci add_list firewall.cfg03dc81.network='usbwan'
#uci commit network
uci commit
#不用重启network，源码自带
exit 0
