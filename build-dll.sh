#!/usr/bin/env bash
# 在 Mac 上交叉编译 32 位 Windows DLL（通达信需 32 位）
set -e

MINGW_PREFIX=""
if command -v brew &>/dev/null; then
  MINGW_PREFIX=$(brew --prefix mingw-w64 2>/dev/null || true)
fi
if [[ -z "$MINGW_PREFIX" || ! -d "$MINGW_PREFIX" ]]; then
  echo "未检测到 mingw-w64，正在安装: brew install mingw-w64"
  brew install mingw-w64
  MINGW_PREFIX=$(brew --prefix mingw-w64)
fi
export PATH="$MINGW_PREFIX/bin:$PATH"

if ! command -v i686-w64-mingw32-gcc &>/dev/null; then
  echo "错误: 未找到 i686-w64-mingw32-gcc，请确认 mingw-w64 已正确安装"
  exit 1
fi

echo "添加 32 位 Windows 目标: i686-pc-windows-gnu"
rustup target add i686-pc-windows-gnu

echo "开始编译 release ..."
cargo build --release --target i686-pc-windows-gnu

DLL="target/i686-pc-windows-gnu/release/zen_stock.dll"
if [[ -f "$DLL" ]]; then
  echo "已生成: $DLL"
  echo "可复制到 Windows 通达信目录，例如: C:\\tdx\\T0002\\dlls"
else
  echo "未找到 $DLL。若链接报 _Unwind_Resume 未定义，请改用: ./build-dll-cross.sh (需 Docker)"
  exit 1
fi
