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

# テスト完了
rm -f $tmp_output
echo "全テスト完了"
exit 0
