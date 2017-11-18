# 引数に渡したファイル(１行ずつURLが書いてある想定)をチェックしステータスコードを吐くよ
#!/bin/bash


if  [ -e "$1" ] && [ -e "$1" ]; then

        cat "$1" | while read line
        do
	    echo "aaa" . $line
            result=`curl -LI $line -o /dev/null -w '%{http_code}\n' -s`
            sleep 1
            echo $line, $result
        done
else
  	echo "usage ./url_checker.sh fine_full_path"
  	echo "引数にファイル名を指定してください。"
        echo "ファイルなし"

fi

exit 0
