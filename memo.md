## whenever 使い方

* `schedule.rb` を更新
* `whenever -i` で `crontab`　更新
* `whenever` で内容を確認
* `/etc/init.d/cron start` で `cron` 起動
* `/etc/init.d/cron status` で確認
* `bin/resque start` でタスクスタート
* `sudo rails s -e production -p 80` で本番環境起動
* `sudo lsof -i tcp:80 -t` でポート確認して `sudo kill [num]` すればserver止めれる

* `sudo RAILS_ENV=production bin/resque start` 本番用
