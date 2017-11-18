# 引数に渡したファイル(１行ずつURLが書いてある想定)をチェックしステータスコードを吐くよ
#!/bin/bash


if  [ -e "$1" ] && [ -e "$1" ]; then

        cat "$1" | while read line
        do
	    echo "aaa" . $line
            # --location: リダイレクトに対応
            # --get: HTTP GETリクエストで送信する
            # --compressed: 圧縮に対応
            # --user-agent: ユーザエージェントを指定
            result=`curl --location --get --compressed --user-agent 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)' $line -o /dev/null -w '%{http_code}\n' -s`
            sleep 1
            echo $line, $result
        done
else
  	echo "usage ./url_checker.sh ファイルパス"
  	echo "引数にファイル名を指定してください。"
        echo "ファイルなし"

fi

exit 0
