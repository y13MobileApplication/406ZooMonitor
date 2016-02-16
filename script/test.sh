#!/bin/sh
#時間間隔でファイルをサーバーに送信する
while true ; do
  # Random=`echo $(( $(od -vAn -N4 -tu4 < /dev/random) % 20 ))`
  # Count=`echo "$Random"`
  # tailコマンドで最後の行を抽出しtrコマンドで数字だけを取り出す
  Count=`tail -n 3 ~/Processing/txtGenerator/log.txt | sed -n 2p | tr -cd '0123456789\n'`
  # awkコマンドで湿度と温度を抽出する
  Room=`tail -n 3 ~/Processing/txtGenerator/THlog.txt | sed -n 2p | cut -c 6-9`
  Rh=`tail -n 3 ~/Processing/txtGenerator/THlog.txt | sed -n 2p | cut -c 1-4`
  # 室温の定義
  # Room=25.0
  # 湿度の定義
  # Rh=67.0

  # dateコマンドで現在の日時を取得
  DATE=`date "+%m\/%d,%H:%M"`
  DAY=`date "+%d-%H:%M:%S"`
  MANTH=`date "+%y-%m"`
  YEAR=`date "+%y"`
  HOUR=`date "+%H:%M"`
  MD=`date "+%m\/%d"`
  # データーがnullでなければ実行する
  if [ -n "$Count" ] && [ -n "$Room" ] && [ -n "$Rh"]; then
    JSON=`echo "{\"year\":\"$YEAR\",\"day\":\"$MD\",\"time\":\"$HOUR\",\"Count\":"$Count",\"Room\":$Room,\"Rh\":$Rh},\r"`
    # sedコマンドでjsonファイルの3行目を書き換える
    # 現在"log.json-e"という変なファイルが作成される
    sed -i -e "3s/^/${JSON}/" log.json
    # scpコマンドでVMにファイルを送る -Pはポート番号指定 -iは鍵認証
    scp -P 1234 -i ~/.ssh/client_rsa ./log.json e135750@10.0.3.187:/var/www/html
  fi
  # 現在生成される"log.json-e"をとりあえず削除するスクリプト
  if [ -e log.json-e ]; then
    echo "File Deleted"
    rm -r log.json-e
  fi

  # 1ヶ月毎にクリーンアップする
  if [[ $DAY == "01-00:00:00" ]]; then
    echo "clean up..." # クリーンアップ
    # ここでリネーム例えば2016年2月分のlog.jsonを2016-02.jsonに変更する
    mv log.json $MANTH.json
    # リネームされたファイルをVMに送信
    scp -P 1234 -i ~/.ssh/client_rsa ./$MANTH.json e135750@10.0.3.187:/var/www/html
    # そしてlog.jsonを上書き保存
    cat template.json > log.json
  fi
  # 1分ごとにファイル送信(適時変更)
  sleep 60
done
