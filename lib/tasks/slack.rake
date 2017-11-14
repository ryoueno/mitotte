namespace :slack do
  desc "Send message to slack. (Set to rescue worker.)"

  # 全員の作業記録を ENV['SLACK_PUBLIC_CHANNEL'] に送信
  task :send_result => :environment do
    include ActivityHelper
    begin
      # アクティビティログに出力するもの
      logs = ['CHANGE_STATUS', 'CHANGE_SCHEDULE', 'WORKING', 'LAZY']

      # ログに出力する件数
      log_limit = 10

      # 昨日の作業状況を送信
      the_day = Date.yesterday

      log_behavior_ids = Behavior.where("name in (?)", logs).pluck('id')

      # 全員の進捗を１つのチャンネルに送信
      users = User.all
      users.each do |user|
        activities = user.activities.aggregate(user.id, the_day)
        ActivityHelper.generate_activity_table(activities, the_day, user.projects.first)
        activity_logs = Activity.where("user_id = ? and behavior_id in (?) and DATE(created_at) = ?", user.id, log_behavior_ids, the_day).limit(log_limit)

        title = "#{user.name}(@#{user.slack_name}) さんの#{the_day.strftime('%m月%d日')}の作業状況\n"

        if(Schedule.yesterdays_users_schedules(user.id).empty?)
          body = "実施予定の作業がありません。今日はお休みです。"
        else
          body = "#{ENV['APP_FQDN']}/images/activities/#{user.id}_#{user.projects.first.id}_#{the_day.strftime('%Y%m%d')}.png"
        end

        # アクティビティログがあれば本文に追加
        if (activity_logs.present?)
          log_thread = []
          tmp_text = ''
          # 重複を除去
          activity_logs.each do |activity|
            if (tmp_text != activity.display)
              log_thread.push("\n#{activity.created_at.strftime('%H:%M')} #{activity.display}\n -----------------------------------------------------------")
            end
            tmp_text = activity.display
          end
          body += log_thread.join
        end

        Resque.enqueue(SendToSlack, ENV['SLACK_PUBLIC_CHANNEL'], title + body)
      end
    rescue => e
      Resque.enqueue(SendToSlack, ENV['SLACK_ADMIN_CHANNEL'], "エラーが発生しました。 #{e}")
    end
  end

  # 時間とアクティビティを確認し、ユーザに通知
  task :notification => :environment do
    begin
      users = User.all
      users.each do |user|
        todays_activities = Activity.where("user_id = '#{user.id}' AND DATE(created_at) = '#{Date.today}'")

        # 現在作業をやるべき時間で、アクティビティがない場合通知
        if (user.todo_tasks.present? && todays_activities.empty?)
          task_title = user.todo_tasks.first ? user.todo_tasks.first.subject : '卒研'
          Resque.enqueue(SendToSlack, user.slack_name, "#{task_title}の時間です。作業を開始せよ(､´･ω･)▄︻┻┳═一")
        end
      end
    rescue => e
      Resque.enqueue(SendToSlack, ENV['SLACK_ADMIN_CHANNEL'], "エラーが発生しました。 #{e}")
    end
  end
end
