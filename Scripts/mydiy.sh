sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk
sed -i 's/hybrid/server/g' target/linux/qualcommax/base-files/etc/uci-defaults/991_set-network.sh
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq60xx.sh package/base-files/files/etc/uci-defaults/998-ipq60xx.sh
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq807x.sh package/base-files/files/etc/uci-defaults/998-ipq807x.sh

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    mv package/openclash-core/master/meta/clash-linux-arm64.tar.gz package/base-files/files/etc/clash-linux-arm64.tar.gz
    rm -rf package/openclash-core
fi

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release


#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po
rm -rf feeds/packages/net/quectel-cm
rm -rf feeds/packages/kernel/fibocom-qmi-wwan
rm -rf feeds/packages/kernel/quectel-qmi-wwan
rm -rf feeds/luci/protocols/luci-proto-quectel
rm -rf feeds/nss_packages/wwan

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/OpenWrt-nikki
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
#rm -rf feeds/packages/devel/gn
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}

#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f
rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

git clone --depth 1 https://github.com/destan19/OpenAppFilter.git  package/oaf
git clone --depth 1 https://github.com/kiddin9/kwrt-packages.git package/kwrt-packages
mv package/kwrt-packages/uugamebooster package/uugamebooster
mv package/kwrt-packages/luci-app-uugamebooster package/luci-app-uugamebooster
mv package/kwrt-packages/luci-app-pushbot package/luci-app-pushbot
rm -rf package/kwrt-packages

rm -rf feeds/packages/net/adguardhome
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-onliner package/luci-app-onliner
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-pptp-server package/luci-app-pptp-server
mv package/kz8-small/luci-app-pushbot package/luci-app-pushbot
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
rm -rf package/kz8-small
