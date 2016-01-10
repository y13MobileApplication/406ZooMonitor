#!/bin/sh
#時間間隔でファイルをサーバーに送信する
while true ; do
  #
  # ここにセンサーから送られてきたテキストファイルから人数を抽出しCountに挿入するコマンドを書く
  # とりあえずはCountに適当に数字を入れておきます
  # 湿度を%で送られて来たと仮定しています。
  # 季節が夏なら25~28℃55~65%で冬なら18~22℃45~60%
  # Max(最高気温)で季節を判断する感じ？Max(最高気温)+2で室温と定義する。
  #

  # ランダムに数字を作成する(0~20)
  Random=`echo $(( $(od -vAn -N4 -tu4 < /dev/random) % 20 ))`
  Count=`echo "$Random"`
  # 現在の最高気温の抽出(適正温度表示に使います)
  Max=`curl -s http://weather.livedoor.com/forecast/webservice/json/v1\?city\=471010 | jq -r '.forecasts[0].temperature.max.celsius '`
  # 室温の定義
  Room=`expr $Max + 2`
  # 湿度の定義
  Rh=67
  # 不快指数の計算式
  DI=`echo 0.81\*$Room+0.01\*$Rh\*\(0.99\*$Room-14.3\)+46.3 | bc`
  # dateコマンドで現在の日時を取得
  DATE=`date "+%Y-%m-%d,%H:%M:%S"`
  HOUR=`date "+%H:%M"`
  JSON=`echo "{\"day\":\"$DATE\",\"Count\":"$Count",\"Max\":$Max},\r"`
  echo $HOUR #デバッグ用
  echo $JSON #デバッグ用
  echo $Max  #デバッグ用
  echo $DI   #デバッグ用
  # sedコマンドでjsonファイルの3行目を書き換える
  # 現在"log.json-e"という変なファイルが作成される
  sed -i -e "3s/^/${JSON}/" log.json
  # 現在生成される"log.json-e"をとりあえず削除するスクリプト
  if [ -e log.json-e ]; then
    echo "File Deleted"
    rm -r log.json-e
  fi
  # scpコマンドでVMにファイルを送る -Pはポート番号指定 -iは鍵認証
  scp -P 1234 -i ~/.ssh/client_rsa ./log.json e135750@10.0.3.187:/var/www/html

  # 24時間毎にtemplate.jsonからlog.jsonへと上書き
  if [[ $HOUR == "24:00" ]]; then
    echo "clean up..." # クリーンアップ
    cat template.json > log.json
  fi
  # 1分ごとにファイル送信(適時変更)
  sleep 60
done
