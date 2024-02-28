FROM debian:11

# 安装curl和其他必要工具
RUN apt-get update && apt-get install -y curl

# 下载并安装XrayR
RUN bash -c 'bash <(curl -Ls https://raw.githubusercontent.com/BobCoderS9/XrayR-release/master/install.sh)'

# 暴露端口4399
EXPOSE 4399

# 容器启动时执行的命令
CMD ["xrayr"]

# 容器命名为xrayrbob
LABEL name="xrayrbob"
