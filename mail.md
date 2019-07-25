# spam判定基準、blacklist mailscore greylisting(new)
- http://projects.puremagic.com/greylisting/index.html
- https://www.eis.co.jp/anti_spam_greylisting/


# エンゲージメントベースの宛先リスト管理（Sunset Policy）
- 以下から引用抜粋
-- https://sendgrid.kke.co.jp/docs/Tutorials/D_Improve_Deliverability/cleaning_recipient_list.html
-Sunset Policyとは、ユーザのエンゲージメントサイクルの中で「Sunset＝ユーザとの別れの時」を定義するポリシーのことです。どのような状態をSunsetとするかはサービスによって異なりますが、例えば、送信したメールに対して反応のない宛先をSunset状態とみなし宛先リストから削除して、今後送信しないようにするといった運用を行います。このポリシーを作成して運用することで、例えば、古い宛先リストに含まれたスパムトラップを排除することができます。 こうした運用を実現するためには、各宛先のエンゲージメントを把握して、メールを開封していない宛先やエンゲージしていない宛先をリストから削除する必要があります。具体的には、以下のようなポリシーで宛先を削除すると良いようです。
-- 日次メールを送り続けて3週間経過してもエンゲージしない宛先
-- 週次メールを送り続けて2ヶ月間経過してもエンゲージしない宛先
-- 月次メールを送り続けて半年間経過してもエンゲージしない宛先

# メールアドレスの死活チェック
- python
-- https://github.com/syrusakbary/validate_email
- ruby
-- https://qiita.com/yutackall/items/ce9285ecdf2f03db0404
-- これはsmtpでつないだときの結果チェックがないので(DNSのチェックだと例外が上がるが、smtpでのアドレスチェックの場合
-- 処理で捕捉しようとしている例外は上がらない。resultcode 250以外がきた場合の処理を追加してあげる必要あり
- ruby on rails
-- https://github.com/kamilc/email_verifier

# メールアドレス死活チェックをするまでの道のり
- DNSにMXレコード追加し、メール送信できるようにしとく。
-- SESを使った
- AWSの場合はIPに逆引き設定の申請を出しておく。
-- https://www.slideshare.net/AmazonWebServicesJapan/aws-ec2-e-rdns#9 
- Elastic IPを開放すると同時に申請解除も必要。
-- https://portal.aws.amazon.com/gp/aws/html-forms-controller/contactus/ec2-email-limit-rdns-request 

# スパムチェッカー
- https://www.mail-tester.com/
