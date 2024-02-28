# 构建阶段
FROM golang:1.21.4-alpine AS builder

# 设置工作目录
WORKDIR /app

# 安装 curl 和 tar
RUN apk add --no-cache curl tar

# 下载并执行 XrayR 安装脚本
RUN curl -L -o install.sh https://raw.githubusercontent.com/lalan9/XrayR-release/master/install.sh
RUN chmod +x install.sh
RUN ./install.sh

# 发布阶段
FROM alpine

# 安装必要的工具包和设置时区
RUN apk --update --no-cache add tzdata ca-certificates \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 创建配置目录
RUN mkdir /etc/XrayR/

# 从构建阶段复制 XrayR 可执行文件到发布阶段
COPY --from=builder /usr/local/bin/XrayR /usr/local/bin/XrayR

# 指定入口点和配置文件路径
ENTRYPOINT [ "XrayR", "--config", "/etc/XrayR/config.yml"]
