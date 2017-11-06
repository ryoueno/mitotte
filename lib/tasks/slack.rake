namespace :slack do
  desc "Send message to slack. (Set to rescue worker.)"
  task :send_result => :environment do
    include ActivityHelper
    begin
      # 昨日の作業状況を送信
      the_day = Date.yesterday

      # 全員の進捗を１つのチャンネルに送信
      users = User.all
      users.each do |user|
        activities = user.activities.aggregate(user.id, the_day)

        title = "#{user.name}(@#{user.slack_name}) さんの#{the_day.strftime('%m月%d日')}の作業状況\n"

        if(Schedule.yesterdays_users_schedules(user.id).empty?)
          body = "実施予定の作業がありません。今日はお休みです。"
        else
          body = "#{ENV['APP_FQDN']}/images/activities/#{user.id}_#{user.projects.first.id}_#{the_day.strftime('%Y%m%d')}.png"
        end

        Resque.enqueue(SendToSlack, ENV['SLACK_PUBLIC_CHANNEL'], title + body)
      end
    rescue => e
      Resque.enqueue(SendToSlack, ENV['SLACK_PUBLIC_CHANNEL'], "エラーが発生しました。 #{e}")
    end
  end
end
