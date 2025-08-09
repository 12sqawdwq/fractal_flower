#!/bin/bash

# ==============================================================================
# Fractal Flower - 卸载脚本
# ==============================================================================

INSTALL_NAME="fractal_flower"
INSTALL_DIR="/usr/local/bin"

# 同样，检查并获取 root 权限
if [[ "$EUID" -ne 0 ]]; then
  echo "卸载脚本需要管理员权限，正在用 sudo 重新运行..."
  sudo bash "$0" "$@"
  exit $?
fi

echo "--- 开始卸载 Fractal Flower ---"

# 检查文件是否存在于安装目录
if [[ -f "${INSTALL_DIR}/${INSTALL_NAME}" ]]; then
    echo "[1/1] 正在从 ${INSTALL_DIR} 删除 ${INSTALL_NAME}..."
    rm "${INSTALL_DIR}/${INSTALL_NAME}"
    echo "      卸载成功！"
else
    echo "警告: 未在 ${INSTALL_DIR} 中找到 ${INSTALL_NAME}。"
    echo "      可能尚未安装或已被卸载。无需任何操作。"
fi

exit 0
