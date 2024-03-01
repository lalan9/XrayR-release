#!/bin/sh

red='\033[0;31m'
green='\033[0;32m'
plain='\033[0m'

# 检查是否以 root 用户身份运行脚本
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${red}错误：${plain}必须以 root 用户身份运行此脚本！"
        exit 1
    fi
}

# 安装必要的软件包
install_dependencies() {
    apk update
    apk add --no-cache tzdata ca-certificates bash wget unzip socat curl
}

# 安装 XrayR
install_xrayr() {
    latest_version=$(curl -s "https://api.github.com/repos/BobCoderS9/XrayR-release/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    echo -e "检测到 XrayR 最新版本：${latest_version}"

    wget -q --show-progress "https://github.com/BobCoderS9/XrayR-release/releases/download/${latest_version}/XrayR-linux-64.zip" -O XrayR-linux.zip
    unzip -q XrayR-linux.zip -d /usr/local/XrayR
    rm XrayR-linux.zip

    # 启用 XrayR 服务
    cp /usr/local/XrayR/XrayR.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl enable XrayR
    systemctl start XrayR
}

# 主函数
main() {
    check_root
    install_dependencies
    install_xrayr
}

# 执行主函数
main
