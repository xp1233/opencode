# 使用 Python 3.9 作为基础镜像
FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 1. 替换 Debian 软件源为阿里云国内源
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# 2. 使用国内加速地址克隆 GitHub 代码
RUN git clone https://ghproxy.com/https://github.com/xp1233/opencode.git .

# 3. 使用国内 PyPI 源安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 暴露端口
EXPOSE 3000

# 启动命令
CMD ["python", "main.py"]
