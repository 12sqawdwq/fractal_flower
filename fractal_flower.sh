#!/bin/zsh

# ==============================================================================
#
#          FILE:  fractal_flower.sh
#
#         USAGE:  ./fractal_flower.sh [OPTIONS]
#
#   DESCRIPTION:  一个纯 Shell 实现的、可定制的分形花/树生长模拟器。
#                 它使用终端 ANSI 转义序列进行“绘画”，不依赖复杂的库。
#
#       OPTIONS:  --- 请参见下面的帮助信息或运行 ./fractal_flower.sh --help ---
#  REQUIREMENTS:  zsh (或兼容的 bash), bc
#        AUTHOR:  AI (Assisted by User)
#       LICENSE:  MIT License
#       VERSION:  2.1
#       CREATED:  2025-08-10
#
# ==============================================================================

# --- 默认配置 ---
INITIAL_LENGTH=8
ANGLE_SPREAD=35
LENGTH_SHRINK=0.8
MIN_BRANCH_LENGTH=2.0
BRANCH_CHAR="#"
FLOWER_CHAR="*"
BRANCH_COLOR="130" # 棕色
FLOWER_COLOR="199" # 粉色
ANIMATION_SPEED=0.01
INFINITE_MODE=false
INFINITE_DELAY=2

# --- 帮助信息 ---
show_help() {
cat << EOF
分形花生成器 - v2.1

一个纯 Shell 实现的、可定制的分形花生长模拟器。

用法: ./fractal_flower.sh [选项]

选项:
  -l, --length <数值>     设置初始树干的长度 (默认: $INITIAL_LENGTH)
  -a, --angle <度数>      设置树枝的分叉角度 (默认: $ANGLE_SPREAD)
  -s, --shrink <0.1-0.9>  设置每次分叉后长度的缩减率 (默认: $LENGTH_SHRINK)
  -b, --branch <字符>     设置构成树枝的字符 (默认: "$BRANCH_CHAR")
  -f, --flower <字符>     设置构成花朵的字符 (默认: "$FLOWER_CHAR")
  -i, --infinite          启用无限迭代模式，花朵将不断重生
  -h, --help              显示此帮助信息并退出

示例:
  # 画一棵又长又瘦的树
  ./fractal_flower.sh -l 12 -a 15

  # 无限生成快速开放的阔叶花
  ./fractal_flower.sh -i -a 45 -s 0.7
EOF
}

# --- 依赖检查 ---
if ! command -v bc &> /dev/null; then
    echo "错误: 本脚本需要 'bc' 命令来进行计算。请先安装它。"
    exit 1
fi

# --- 参数解析 ---
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -l|--length) INITIAL_LENGTH="$2"; shift ;;
        -a|--angle) ANGLE_SPREAD="$2"; shift ;;
        -s|--shrink) LENGTH_SHRINK="$2"; shift ;;
        -b|--branch) BRANCH_CHAR="$2"; shift ;;
        -f|--flower) FLOWER_CHAR="$2"; shift ;;
        -i|--infinite) INFINITE_MODE=true ;;
        -h|--help) show_help; exit 0 ;;
        *) echo "未知参数: $1"; show_help; exit 1 ;;
    esac
    shift
done

# --- 核心函数 ---
draw() {
    printf "\e[%s;%sH\e[38;5;%sm%s" "$1" "$2" "$4" "$3"
}

grow() {
    local y1=$1 x1=$2 angle=$3 length=$4
    if (( $(echo "$length < $MIN_BRANCH_LENGTH" | bc -l) )); then
        draw "$(printf "%.0f" $y1)" "$(printf "%.0f" $x1)" "$FLOWER_CHAR" "$FLOWER_COLOR"
        return
    fi
    local angle_rad=$(echo "scale=4; $angle * 3.14159 / 180" | bc -l)
    local x2=$(echo "scale=4; $x1 + $length * c($angle_rad)" | bc -l)
    local y2=$(echo "scale=4; $y1 - $length * s($angle_rad)" | bc -l)
    local dx=$(echo "scale=4; ($x2 - $x1) / $length" | bc -l)
    local dy=$(echo "scale=4; ($y2 - $y1) / $length" | bc -l)
    for (( i=1; i<=$(printf "%.0f" $length); i++ )); do
        local current_x=$(echo "$x1 + $dx * $i" | bc -l)
        local current_y=$(echo "$y1 + $dy * $i" | bc -l)
        draw "$(printf "%.0f" $current_y)" "$(printf "%.0f" $current_x)" "$BRANCH_CHAR" "$BRANCH_COLOR"
        sleep $ANIMATION_SPEED
    done
    local new_length=$(echo "$length * $LENGTH_SHRINK" | bc -l)
    local angle_offset=$((RANDOM % 10 - 5))
    grow $y2 $x2 $(($angle + $ANGLE_SPREAD + angle_offset)) $new_length
    grow $y2 $x2 $(($angle - $ANGLE_SPREAD + angle_offset)) $new_length
}

# --- 主程序 ---
main() {
    trap "tput cnorm; clear; exit" INT TERM EXIT
    while true; do
        tput civis; clear
        local term_height=$(tput lines); local term_width=$(tput cols)
        local start_y=$term_height; local start_x=$((term_width / 2))
        local initial_angle=90
        if [[ "$INFINITE_MODE" == true ]]; then
            initial_angle=$((90 + RANDOM % 10 - 5))
        fi
        grow $start_y $start_x $initial_angle $INITIAL_LENGTH
        if [[ "$INFINITE_MODE" == true ]]; then
            sleep $INFINITE_DELAY
        else
            break
        fi
    done
    read -n 1
}

main
