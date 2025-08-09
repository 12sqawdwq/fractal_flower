#!/bin/bash

# ==============================================================================
# Fractal Flower - 安装脚本
# ==============================================================================

# 设置变量
SCRIPT_NAME="fractal_flower.sh"
INSTALL_NAME="fractal_flower"
INSTALL_DIR="/usr/local/bin"

# 步骤 0: 检查是否以 root/sudo 权限运行
# 如果不是，则用 sudo 重新执行本脚本
if [[ "$EUID" -ne 0 ]]; then
  echo "本安装脚本需要管理员权限来将命令安装到 ${INSTALL_DIR}"
  echo "正在用 sudo 重新运行..."
  # 将所有传入的参数原样传递给新进程
  sudo bash "$0" "$@"
  # 退出原始的非特权脚本
  exit $?
fi

# --- 从这里开始，脚本将以 root 权限执行 ---

echo "--- 开始安装 Fractal Flower ---"

# 步骤 1: 检查依赖 'bc'
echo "[1/3] 正在检查依赖..."
if ! command -v bc &> /dev/null; then
    echo "错误: 依赖 'bc' 未安装。"
    echo "请根据您的系统运行相应的命令安装它 (例如: sudo apt install bc, sudo pacman -S bc, brew install bc)，然后再重新运行此脚本。"
    exit 1
fi
echo "      依赖检查通过。"

# 步骤 2: 赋予主脚本执行权限并复制到安装目录
echo "[2/3] 正在安装脚本到 ${INSTALL_DIR}..."

# 检查主脚本文件是否存在
if [[ ! -f "$SCRIPT_NAME" ]]; then
    echo "错误: 主脚本文件 '${SCRIPT_NAME}' 未在当前目录找到。"
    echo "请确保您在项目的根目录下运行此安装脚本。"
    exit 1
fi

chmod +x "$SCRIPT_NAME"
cp "$SCRIPT_NAME" "${INSTALL_DIR}/${INSTALL_NAME}"

# 步骤 3: 验证安装结果
echo "[3/3] 正在验证安装..."
if command -v "$INSTALL_NAME" &> /dev/null; then
    echo "      安装成功！"
    echo ""
    echo "恭喜！您现在可以在终端的任何位置直接输入以下命令来运行："
    echo "  ${INSTALL_NAME}"
    echo ""
    echo "如果需要卸载，请运行项目中的 uninstall.sh 脚本。"
else
    echo "      安装失败！"
    echo "未能将脚本成功安装到您的系统中。请检查 ${INSTALL_DIR} 是否在您的 \$PATH 环境变量中。"
    exit 1
fi

exit 0
