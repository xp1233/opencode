# 回到你之前成功的基础镜像
FROM python:3.9-slim

WORKDIR /app

# 这是你之前成功的写法：不替换 sources.list，直接安装 git
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# 关键：用国内加速地址克隆 GitHub（避免阿里云构建时超时）
RUN git clone https://ghproxy.com/https://github.com/xp1233/opencode.git .

# 用国内 PyPI 源安装依赖（避免超时）
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

EXPOSE 3000
CMD ["python", "main.py"]
