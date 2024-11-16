#!/bin/sh
#创建运行环境
killall frpc
mkdir -p /tmp/frp

#创建frpc配置文件
cat > "/tmp/frp/myfrpc.ini" <<-\EOF
# ==========客户端配置：==========
[common]
server_addr = 1192.0.0.3
server_port = 7000
token = 12345

log_file = /tmp/frpc.log
log_level = info
log_max_days = 3

[test]
remote_port = 6000
type = tcp
local_ip = 192.168.2.1
local_port = 80
# ================================
EOF

#启动程序
frpc_enable=`nvram get frpc_enable`
if [ "$frpc_enable" = "1" ] ; then
    frpc -c /tmp/frp/myfrpc.ini 2>&1 &
fi