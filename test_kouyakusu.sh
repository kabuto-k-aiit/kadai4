#!/bin/bash

kouyakusu_script="./kouyakusu.sh"

# テスト用一時ファイル
tmp_output=$(mktemp)

# 正常系テスト: 2と4 -> 2
echo "テスト 1: 引数2と4の場合は2"
output=$($kouyakusu_script 2 4)
if [ "$output" != "2" ]; then
  echo "テスト 1 失敗: '$output'"
  exit 1
else
  echo "テスト 1 成功"
fi

# 異常系テスト: 引数1個のみ -> エラー
echo "テスト 2: 引数が1つの場合はエラーが発生するべき"
$kouyakusu_script 3 > $tmp_output 2>&1
if [ $? -eq 0 ]; then
  echo "テスト 2 失敗:成功している"
  exit 1
fi
if ! grep -qi "error" $tmp_output; then
  echo "テスト 2 失敗:エラーメッセージが出てない"
  exit 1
else
  echo "テスト 2 成功"
fi

# 異常系テスト: 非数値入力 -> エラー
echo "テスト 3: 引数が数字でない場合はエラーが発生するべき"
$kouyakusu_script a b > $tmp_output 2>&1
if [ $? -eq 0 ]; then
  echo "テスト 3 失敗:成功している"
  exit 1
fi
if ! grep -qi "error" $tmp_output; then
  echo "テスト 3 失敗:エラーメッセージが出てない"
  exit 1
else
  echo "テスト 3 成功"
fi

# 異常系テスト: 引数ゼロ -> エラー
echo "テスト 4: 引数が0個の場合はエラーが発生するべき"
$kouyakusu_script > $tmp_output 2>&1
if [ $? -eq 0 ]; then
  echo "テスト 4 失敗:成功している"
  exit 1
fi
if ! grep -qi "error" $tmp_output; then
  echo "テスト 4 失敗:エラーメッセージが出てない"
  exit 1
else
  echo "テスト 4 成功"
fi


# 異常系テスト: 引数が3個以上 -> エラー
echo "テスト 5: 引数が3個以上の場合はエラーが発生するべき"
# テスト対象の引数のパターン（3個以上）
test_cases=(
  "4 8 12"
  "4 8 12 16"
  "10 20 30 40 50"
)

for args in "${test_cases[@]}"; do
  echo "  実行: $kouyakusu_script $args"
  $kouyakusu_script $args > $tmp_output 2>&1
  
  if [ $? -eq 0 ]; then
    echo "  失敗: 成功している (引数: $args)"
    exit 1
  fi
  
  if ! grep -qi "error" $tmp_output; then
    echo "  失敗: エラーメッセージが出ていない (引数: $args)"
    exit 1
  else
    echo "  成功: 正しくエラー処理された (引数: $args)"
  fi
done
echo "テスト 5 全て成功"

# 異常系テスト: 引数が負の正数 -> エラー
echo "テスト 6: 引数が負の正数の場合はエラーが発生するべき"
test_cases=(
  "-4 8"
  "-4 -8"
  "4 -8"
)
for args in "${test_cases[@]}"; do
  echo "  実行: $kouyakusu_script $args"
  $kouyakusu_script $args > $tmp_output 2>&1
  
  if [ $? -eq 0 ]; then
    echo "  失敗: 成功している (引数: $args)"
    exit 1
  fi
  
  if ! grep -qi "error" $tmp_output; then
    echo "  失敗: エラーメッセージが出ていない (引数: $args)"
    exit 1
  else
    echo "  成功: 正しくエラー処理された (引数: $args)"
  fi
done
echo "テスト 6 全て成功"

# 異常系テスト: 引数が小数点 -> エラー
echo "テスト 7: 引数に小数点がある場合はエラーが発生するべき"
test_cases=(
  "4.8 8.8"
  "4 8.8"
  "4.8 8"
)
for args in "${test_cases[@]}"; do
  echo "  実行: $kouyakusu_script $args"
  $kouyakusu_script $args > $tmp_output 2>&1
  
  if [ $? -eq 0 ]; then
    echo "  失敗: 成功している (引数: $args)"
    exit 1
  fi
  
  if ! grep -qi "error" $tmp_output; then
    echo "  失敗: エラーメッセージが出ていない (引数: $args)"
    exit 1
  else
    echo "  成功: 正しくエラー処理された (引数: $args)"
  fi
done
echo "テスト 7 全て成功"

# 異常系テスト: 引数が空白文字 -> エラー
echo "テスト 8: 引数に空白文字がある場合はエラーが発生するべき"
test_cases=(
  "'' ''"
  "4 ''"
  "'' 8"
)
for args in "${test_cases[@]}"; do
  echo "  実行: $kouyakusu_script $args"
  $kouyakusu_script $args > $tmp_output 2>&1
  
  if [ $? -eq 0 ]; then
    echo "  失敗: 成功している (引数: $args)"
    exit 1
  fi
  
  if ! grep -qi "error" $tmp_output; then
    echo "  失敗: エラーメッセージが出ていない (引数: $args)"
    exit 1
  else
    echo "  成功: 正しくエラー処理された (引数: $args)"
  fi
done
echo "テスト 8 全て成功"

# 異常系テスト: 引数が0 -> エラー
echo "テスト 9: 引数にoがある場合はエラーが発生するべき"
test_cases=(
  "0 0"
  "4 0"
  "0 8"
)
for args in "${test_cases[@]}"; do
  echo "  実行: $kouyakusu_script $args"
  $kouyakusu_script $args > $tmp_output 2>&1
  
  if [ $? -eq 0 ]; then
    echo "  失敗: 成功している (引数: $args)"
    exit 1
  fi
  
  if ! grep -qi "error" $tmp_output; then
    echo "  失敗: エラーメッセージが出ていない (引数: $args)"
    exit 1
  else
    echo "  成功: 正しくエラー処理された (引数: $args)"
  fi
done
echo "テスト 9 全て成功"

# テスト完了
rm -f $tmp_output
echo "全テスト完了"
exit 0
