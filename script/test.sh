#!/bin/sh
# scpコマンドでVMにファイルを送る -Pオプションはポート番号指定
scp -P portnumber hoge.txt username@ipaddress:VMPath
