#!/bin/sh
#時間間隔でファイルを送信する
while true ; do
  # dateコマンドで現在の日時を取得
  date +"%H:%M:%S"
  # scpコマンドでVMにファイルを送る -Pオプションはポート番号指定
  scp -P 1234 file username@ipaddress:VMPath
  # 1分ごとにファイル送信
  sleep 60
done
