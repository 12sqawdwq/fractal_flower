# Fractal Flower - 终端分形花

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell: Zsh/Bash](https://img.shields.io/badge/Shell-Zsh%20%7C%20Bash-blue)](https://www.zsh.org/)

这是一个有趣的纯 Shell 脚本，它可以在您的终端中生成优美的、不断生长的分形花/树动画。它不依赖任何复杂的图形库，仅使用 `tput` 和 `bc` 等基础命令来精确控制终端光标和进行数学计算，以“绘画”的方式模拟植物生长。


## 特性 (Features)

- **纯 Shell 实现**: 无需编译，可在大多数现代 Linux 和 macOS 系统上运行。
- **轻量级**: 除 `bc` 计算器外无其他复杂依赖。
- **高度可定制**: 通过命令行参数可以轻松改变分形树的形态。
- **无限模式**: 支持自动、连续地生成形态各异的花朵，是绝佳的终端背景“屏保”。
- **教育性**: 是一个学习 Shell 脚本、终端控制和分形几何的绝佳示例。

## 安装 (Installation)

1.  **安装依赖 `bc`**

    本脚本使用 `bc` 进行浮点数和三角函数计算。请确保您的系统已安装它。
    ```bash
    # Arch Linux / Manjaro
    sudo pacman -S bc

    # Debian / Ubuntu / Mint
    sudo apt-get update && sudo apt-get install bc

    # Fedora / CentOS
    sudo yum install bc

    # macOS (通常已自带, 或通过 Homebrew 安装)
    brew install bc
    ```

2.  **克隆或下载脚本**
    ```bash
    git clone [https://github.com/你的用户名/你的仓库名.git](https://github.com/你的用户名/你的仓库名.git)
    cd 你的仓库名
    ```
    或者，您可以直接将 `fractal_flower.sh` 文件的内容保存到本地。

3.  **赋予执行权限**
    ```bash
    chmod +x fractal_flower.sh
    ```

## 使用 (Usage)

直接运行脚本即可看到默认效果：
```bash
./fractal_flower.sh
```

### 命令行选项

您可以使用丰富的选项来创造属于您自己的分形艺术：

| 选项            | 描述                                     | 默认值      |
|-----------------|------------------------------------------|-------------|
| `-l`, `--length`| 设置初始树干的长度                       | `8`         |
| `-a`, `--angle` | 设置树枝的分叉角度（度）                 | `35`        |
| `-s`, `--shrink`| 设置每次分叉后长度的缩减率 (0.1-0.9)     | `0.8`       |
| `-b`, `--branch`| 设置构成树枝的字符                       | `#`         |
| `-f`, `--flower`| 设置构成花朵的字符                       | `*`         |
| `-i`, `--infinite`| 启用无限迭代模式，花朵将不断重生         | `false`     |
| `-h`, `--help`  | 显示帮助信息                             |             |

### 一些有趣的例子

**1. 创造一棵高耸的、像松树一样的树：**
```bash
./fractal_flower.sh -l 12 -a 20 -s 0.85
```

**2. 模拟一片不断生成的、开阔的阔叶林：**
```bash
./fractal_flower.sh -i -a 45 -s 0.75
```

**3. 用更具艺术感的字符作画：**
```bash
./fractal_flower.sh -b "│" -f "✿" -l 10
```

## 贡献 (Contributing)

欢迎提交问题 (Issues)、提出新功能的想法或直接通过拉取请求 (Pull Requests) 来改进这个项目。

## 授权 (License)

本项目采用 [MIT 授权](https://opensource.org/licenses/MIT)。
# fractal_flower
