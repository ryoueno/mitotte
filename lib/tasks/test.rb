class Test
  def self.check
    begin
      puts "sending..."
      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'], channel: "@admin"
      notifier.ping "おにぎりせんべい これはテストメッセージです"
    rescue => e
      puts "Unhandled exception! #{e}"
    end
  end
end
