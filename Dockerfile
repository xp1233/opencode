# 你之前成功使用的基础镜像
FROM python:3.9-slim

WORKDIR /app

# 完全去掉国内加速源，直接用默认源安装 git
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# 去掉 ghproxy 加速，直接从 GitHub 原生地址克隆（阿里云服务器访问 GitHub 本身就比较稳定）
RUN git clone https://github.com/xp1233/opencode.git .

# 去掉清华 PyPI 源，直接用默认源安装依赖
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3000
CMD ["python", "main.py"]
