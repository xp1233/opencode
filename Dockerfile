# 使用包含标准 sources.list 的 Python 3.9 镜像
FROM python:3.9-bookworm-slim

# 设置工作目录
WORKDIR /app

# 替换 Debian 软件源为阿里云国内源（此镜像存在 /etc/apt/sources.list）
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# 使用国内加速地址克隆 GitHub 代码
RUN git clone https://ghproxy.com/https://github.com/xp1233/opencode.git .

# 使用国内 PyPI 源安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 暴露服务端口
EXPOSE 3000

# 启动服务命令
CMD ["python", "main.py"]
