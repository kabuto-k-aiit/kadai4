#!/bin/bash

# 引数チェック
if [ $# -ne 2 ]; then
  echo "error: 引数は2つの自然数でなければなりません。" >&2
  exit 1
fi

# 自然数かチェック（0より大きい整数）
for arg in "$@"; do
  if ! [[ "$arg" =~ ^[1-9][0-9]*$ ]]; then
    echo "error: '$arg' は自然数ではありません。" >&2
    exit 1
  fi
done

# ユークリッドの互除法で最大公約数を計算
a=$1
b=$2

while [ "$b" -ne 0 ]; do
  temp=$b
  b=$((a % b))
  a=$temp
done

echo "$a"
