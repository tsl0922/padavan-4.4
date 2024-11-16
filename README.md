# padavan #

### 基于TSL大佬的padavan4.4版本，做了一些自己的缝合和优化，比较适合养老！ 支持一键action编译自己的定制固件，插件增删在trunk/configs/tempaltes修改！
- 科学上网做了很多的优化，gfw和绕过模式+chinadns-ng都能正常使用，gfw列表更新地址也放出来可以设置。
- zerotier和frpc都更新到最新，都正常使用。异地组网的好搭档。
- ipv6正常使用，ipv6不支持nat！
- hwnat硬加速和sfe软加速都有效果！
- 去除了很多log里刷屏的内核日志！
- 升级了很多软件的版本！
- 回滚了部分软件版本，解决版本不稳定的问题！

zerotier 使用技巧：

- 1、ap模式下如果想要其他zerotier端可以访问ap网段，在padavan开机脚本里开启ap模式下的ip转发功能，虚拟网段改成你自己实际的。
```
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -s 10.11.12.0/24 -j MASQUERADE
```
- 2、解决当wan重拨号或其他原因，导致zerotier防火墙规则丢失，zerotier网络无法正常使用。可以在padavan设置 WAN 上行/下行启动后执行 加入下面的脚本。 切记不要放防火墙重启后里，测试有重启进不去系统的可能！！
```
if [ $1 == "up" ] ; then
SleepTime=30
logger -t "WAN状态改变" "【延时$SleepTime秒检测ZeroTier状态】"
sleep $SleepTime
KEYWORD="zte"
RULE_EXIST=$(iptables -L -n -v | grep "$KEYWORD")
NVRAM_ZEROTIER_ENABLE=$(nvram get zerotier_enable)
if [ -z "$RULE_EXIST" ]; then
    if [ "$NVRAM_ZEROTIER_ENABLE" = "1" ]; then
        logger -t "检测结果" "【ZeroTier防火墙规则不存在，但服务已启用，需要重启服务！】"
        zerotier.sh stop && zerotier.sh start
    else
        logger -t "检测结果" "【ZeroTier防火墙规则不存在，但服务未启用，不需要重启服务！】"
    fi
else
    logger -t "检测结果" "【ZeroTier防火墙规则存在，不需要重启服务！】"    
fi
fi
```
默认信息如下
- ip：192.168.2.1
- 账号：admin
- 密码：admin
- wifi密码：1234567890
![image](https://github.com/user-attachments/assets/c9e7f317-22d3-47a5-91a7-12b084992a47)
![image](https://github.com/user-attachments/assets/eca3da71-3b7f-4ef0-b5cf-a0f12be536bb)
![image](https://github.com/user-attachments/assets/aad24ef7-633c-4576-a215-ea68e3b829a0)
![image](https://github.com/user-attachments/assets/215423ac-cef8-4f25-a7d2-b4942c427193)
![image](https://github.com/user-attachments/assets/90e0471d-4842-4c6d-b39d-cbc94b4a17f2)



This project is based on original rt-n56u with latest mtk 4.4.198 kernel, which is fetch from D-LINK GPL code.

#### Extra functions / changes
- AP Relay auto-daemon
##### Enhancements in this repo

- commits has beed rewritten on top of [hanwckf/rt-n56u](https://github.com/hanwckf/rt-n56u) repo for better history tracking
- Optimized Makefiles and build scripts, added a toplevel Makefile
- Added ccache support, may save up to 50%+ build time
- Upgraded the toolchain and libc:
  - gcc 13.3.0
  - musl 1.2.5 / uClibc-ng 1.0.48
 - OpenWrt style package Makefile
 - Enabled kernel cgroups support
 - Fixed K2P led label names
 - Replaced udpxy with msd_lite
 - Replaced Web Console with ttyd
 - Upgraded libs and user packages
 - And a lot of package related fixes
 - ...

# Features

- Based on 4.4.198 Linux kernel
- Support MT7621 based devices
- Support MT7615D/MT7615N/MT7915D wireless chips
- Support raeth and mt7621 hwnat with legency driver
- Support qca shortcut-fe
- Support IPv6 NAT based on netfilter
- Support WireGuard integrated in kernel
- Support fullcone NAT (by Chion82)
- Support LED&GPIO control via sysfs

# Supported devices

- CR660x
- JCG-Q20
- JCG-AC860M
- JCG-836PRO
- JCG-Y2
- DIR-878
- DIR-882
- K2P
- K2P-USB
- NETGEAR-BZV
- MR2600
- MI-4
- MI-R3G
- MI-R3P
- R2100
- XY-C1
