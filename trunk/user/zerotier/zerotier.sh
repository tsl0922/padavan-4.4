#!/bin/sh
#20200426 chongshengB
#20210410 xumng123
#20240831 fightround
PROG=/usr/bin/zerotier-one
PROGCLI=/usr/bin/zerotier-cli
PROGIDT=/usr/bin/zerotier-idtool
config_path="/etc/storage/zerotier-one"
start_instance() {
	port=""
	args=""
	nwid="$(nvram get zerotier_id)"
	moonid="$(nvram get zerotier_moonid)"
	secret="$(nvram get zerotier_secret)"
	mkdir -p $config_path/networks.d
	mkdir -p $config_path/moons.d
	if [ -n "$port" ]; then
		args="$args -p$port"
	fi
	if [ -z "$secret" ]; then
		logger -t "zerotier" "密匙为空,正在生成密匙,请稍后..."
		sf="$config_path/identity.secret"
		pf="$config_path/identity.public"
		$PROGIDT generate "$sf" "$pf"  >/dev/null
		[ $? -ne 0 ] && return 1
		secret="$(cat $sf)"
		#rm "$sf"
		nvram set zerotier_secret="$secret"
		nvram commit
	else
		logger -t "zerotier" "找到密匙,正在写入文件,请稍后..."
		echo "$secret" >$config_path/identity.secret
		$PROGIDT getpublic $config_path/identity.secret >$config_path/identity.public
		#rm -f $config_path/identity.public
	fi

	$PROG $args $config_path >/dev/null 2>&1 &

	while [ ! -f $config_path/zerotier-one.port ]; do
		sleep 1
	done
	if [ -n "$moonid" ]; then
		$PROGCLI orbit $moonid $moonid
		logger -t "zerotier" "加入moon: $moonid 成功!"
	fi
	if [ -n "$nwid" ]; then
		$PROGCLI join $nwid
		logger -t "zerotier" "加入网络: $nwid 成功!"
		rules

	fi
}

rules() {
	while [ "$(ifconfig | grep zt | awk '{print $1}')" = "" ]; do
		sleep 1
	done
	nat_enable=$(nvram get zerotier_nat)
	zt0=$(ifconfig | grep zt | awk '{print $1}')
	del_rules
 	logger -t "zerotier" "添加防火墙规则中..."
	iptables -A INPUT -i $zt0 -j ACCEPT
	iptables -A FORWARD -i $zt0 -o $zt0 -j ACCEPT
	iptables -A FORWARD -i $zt0 -j ACCEPT
	if [ $nat_enable -eq 1 ]; then
		iptables -t nat -A POSTROUTING -o $zt0 -j MASQUERADE
		while [ "$(ip route | grep -E "dev\s+$zt0\s+proto\s+kernel"| awk '{print $1}')" = "" ]; do
		    sleep 1
		done
		ip_segment=$(ip route | grep -E "dev\s+$zt0\s+proto\s+kernel"| awk '{print $1}')
                logger -t "zerotier" "$zt0 网段为$ip_segment 添加进NAT规则中..."
		iptables -t nat -A POSTROUTING -s $ip_segment -j MASQUERADE
	fi
		logger -t "zerotier" "zerotier接口: $zt0 启动成功!"
}

del_rules() {
	zt0=$(ifconfig | grep zt | awk '{print $1}')
	ip_segment=$(ip route | grep -E "dev\s+$zt0\s+proto\s+kernel"| awk '{print $1}')
	logger -t "zerotier" "删除防火墙规则中..."
	iptables -D INPUT -i $zt0 -j ACCEPT 2>/dev/null
	iptables -D FORWARD -i $zt0 -o $zt0 -j ACCEPT 2>/dev/null
	iptables -D FORWARD -i $zt0 -j ACCEPT 2>/dev/null
	iptables -t nat -D POSTROUTING -o $zt0 -j MASQUERADE 2>/dev/null
	iptables -t nat -D POSTROUTING -s $ip_segment -j MASQUERADE 2>/dev/null
}

start_zero() {
	logger -t "zerotier" "正在启动zerotier"
	kill_z
	start_instance 'zerotier'

}
kill_z() {
	zerotier_process=$(pidof zerotier-one)
	if [ -n "$zerotier_process" ]; then
		logger -t "zerotier" "有进程在运行，结束中..."
		killall zerotier-one >/dev/null 2>&1
		kill -9 "$zerotier_process" >/dev/null 2>&1
	fi
}
stop_zero() {
    logger -t "zerotier" "正在关闭zerotier..."
	del_rules
	kill_z
	rm -rf $config_path
	logger -t "zerotier" "zerotier关闭成功!"
}

case $1 in
start)
	start_zero
	;;
stop)
	stop_zero
	;;
*)
	echo "check"
	#exit 0
	;;
esac
