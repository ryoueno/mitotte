## whenever 使い方

* `schedule.rb` を更新
* `whenever -i` で `crontab`　更新
* `whenever` で内容を確認
* `/etc/init.d/cron start` で `cron` 起動
* `/etc/init.d/cron status` で確認
* `bin/resque start` でタスクスタート
* `sudo rails s -e production -p 80` で本番環境起動
* `sudo lsof -i tcp:80 -t` でポート確認して `sudo kill [num]` すればserver止めれる

* `rails db:seed_fu FILTER=2017111400000003_positive_word.rb` 特定のseederファイル実行

* `sudo RAILS_ENV=production bin/resque start` 本番用

* `bundle exec rake slack:send_result` 報告
* `sudo RAILS_ENV=production bundle exec rake slack:send_result` 報告
