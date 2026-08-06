FROM node:24.18.0-trixie-slim

# 基础工具 + Python（含 pip）+ PDF/Office 系统依赖
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     curl ca-certificates vim git \
     python3 python3-pip python-is-python3 \
     qpdf poppler-utils \
     tesseract-ocr tesseract-ocr-chi-sim \
  && rm -rf /var/lib/apt/lists/*

# Python 库（Debian trixie 有 PEP 668 限制，容器内用 --break-system-packages 是安全的）
RUN pip install --break-system-packages --no-cache-dir \
     pypdf pdfplumber reportlab \
     pytesseract pdf2image \
     openpyxl

# 安装 pi 本体
RUN npm install -g @earendil-works/pi-coding-agent@0.85.1 \
  && corepack enable pnpm \
  && npm install -g docx \
  && npm install -g pptxgenjs

# 安装 rtk
RUN curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh \
  | RTK_INSTALL_DIR=/usr/local/bin sh

# 切到 node 用户，装扩展（会写入 /home/node/.pi/agent/npm）
USER node

RUN pi install npm:@ff-labs/pi-fff \
  && pi install npm:pi-rtk-optimizer \
  && pi install npm:pi-cache-graph \
  && pi install npm:pi-web-access \
  && pi install npm:@gotgenes/pi-permission-system \
  && pi install npm:pi-mcp-adapter \
  && pi install npm:pi-mono-figma \
  && pi update --extensions

COPY --chown=node:node --chmod=755 entrypoint.sh /home/node/entrypoint.sh
ENTRYPOINT ["/home/node/entrypoint.sh"]
