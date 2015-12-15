#!/bin/sh
#時間間隔でファイルをサーバーに送信する
while true ; do
  #
  # ここにセンサーから送られてきたテキストファイルから人数を抽出しCountに挿入するコマンドを書く
  # とりあえずはCountに適当に数字を入れておきます
  #
  # ランダムに数字を作成する(0~20)
  Random=`echo $(( $(od -vAn -N4 -tu4 < /dev/random) % 20 ))`
  Count=`echo "$Random"`

  # dateコマンドで現在の日時を取得
  DATE=`date "+%Y-%m-%d,%H:%M:%S"`
  JSON=`echo "{\"day\":\"$DATE\",\"Count\":"$Count"},\r"`

  echo $JSON
  # sedコマンドでjsonファイルの3行目を書き換える
  # 現在"log.json-e"という変なファイルが作成される
  sed -i -e "3s/^/${JSON}/" log.json
  # scpコマンドでVMにファイルを送る -Pオプションはポート番号指定
  scp -P 1234 ./log.json e135750@10.0.3.187:/var/www/html
  # 1分ごとにファイル送信(適時変更)
  sleep 60
done
