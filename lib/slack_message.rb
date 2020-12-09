# frozen_string_literal: true

class SlackMessage
  def initialize(message:)
    @message = message
  end

  def post
    notifier = Slack::Notifier.new '',
                                          channel: '',
                                          username: 'Notifier',
                                          icon_emoji: ':slack:'
    notifier.ping @message
  end
end
