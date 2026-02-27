# 使用 Python 3.9 作为基础镜像
FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 安装依赖
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# 克隆代码（如果是自动构建，这一步其实是多余的，因为代码已经被拉取到构建环境了）
# 所以我们直接复制当前目录的代码
COPY . .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 暴露端口
EXPOSE 3000

# 启动命令
CMD ["python", "main.py"]
