class SendToSlack
  @queue = 'mitotte'
  @webhook_url = ENV['SLACK_WEBHOOK_URL']

  def self.perform(channel, message)
    begin
      sleep 2
      notifier = Slack::Notifier.new(@webhook_url, channel: channel)
      notifier.ping(message)
    rescue => e
      puts "Unhandled exception! #{e}"
    end
  end
end
