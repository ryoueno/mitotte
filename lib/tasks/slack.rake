namespace :slack do
  desc "Send message to slack."
  task :send_result => :environment do
    begin
      puts "sending..."
      user = User.first
      message = <<EOF
        テストメッセージ#{user.name}
        #{ENV['DB_TEST_USERNAME']}
EOF
      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'], channel: "@#{user.slack_name}"
      notifier.ping message
    rescue => e
      puts "Unhandled exception! #{e}"
    end
  end
end
