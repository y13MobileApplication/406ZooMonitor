#!/bin/sh
#時間間隔でファイルをサーバーに送信する
while true ; do
  #
  # ここにセンサーから送られてきたテキストファイルから人数を抽出しCountに挿入するコマンドを書く
  # とりあえずはCountに適当に文字を入れておきます
  #
  Count=`echo "14"`

  # dateコマンドで現在の日時を取得
  DATE=`date "+%Y-%m-%d,%H:%M:%S"`
  JSON=`echo "{\"day\":\"$DATE\",\"Count\":"$Count"},\r"`
  # sedコマンドでjsonファイルの3行目を書き換える
  # 現在"log.json-e"という変なファイルが作成される
  sed -i -e "3s/^/${JSON}/" log.json
  # scpコマンドでVMにファイルを送る -Pオプションはポート番号指定
  # scp -P portnumber ~/log.json username@ipaddress:path
  # 1分ごとにファイル送信(適時変更)
  sleep 60
done
