#!/bin/sh
#時間間隔でファイルをサーバーに送信する
while true ; do
  #
  # ここにセンサーから送られてきたテキストファイルから人数を抽出しCountに挿入するコマンドを書く
  # とりあえずはCountに適当に数字を入れておきます
  # 湿度を%で送られて来たと仮定しています。
  # 季節が夏なら25~28℃55~65%で冬なら18~22℃45~60%
  #

  # ランダムに数字を作成する(0~20)
  Random=`echo $(( $(od -vAn -N4 -tu4 < /dev/random) % 20 ))`
  Count=`echo "$Random"`
  # 室温の定義
  Room=25
  # 湿度の定義
  Rh=67

  # dateコマンドで現在の日時を取得
  DATE=`date "+%Y-%m-%d,%H:%M:%S"`
  HOUR=`date "+%H:%M"`
  JSON=`echo "{\"day\":\"$DATE\",\"Count\":"$Count"},\r"`
  # gnuplot 出力用のデータを作成する
  DAT=`echo $DATE $Count >> graph.dat`

  # sedコマンドでjsonファイルの3行目を書き換える
  # 現在"log.json-e"という変なファイルが作成される
  sed -i -e "3s/^/${JSON}/" log.json
  # 現在生成される"log.json-e"をとりあえず削除するスクリプト
  if [ -e log.json-e ]; then
    echo "File Deleted"
    rm -r log.json-e
  fi
  # gnuplotのコマンド
  #gnuplot -e "
  #  set title 'test graph' ;
  #  set xdata time ;
  #  set timefmt '%Y-%m-%d,%H:%M:%S' ;
  #  set format x "%H:%M" ;
  #  plot "graph.dat" using 1:2 w l ;
  #  pause -1
  #"
  # scpコマンドでVMにファイルを送る -Pはポート番号指定 -iは鍵認証
  #scp -P 1234 -i ~/.ssh/client_rsa ./log.json e135750@10.0.3.187:/var/www/html

  # 24時間毎にtemplate.jsonからlog.jsonへと上書き
  if [[ $HOUR == "24:00" ]]; then
    echo "clean up..." # クリーンアップ
    cat template.json > log.json
  fi
  # 1分ごとにファイル送信(適時変更)
  sleep 60
done
