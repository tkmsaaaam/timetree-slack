# frozen_string_literal: true

require 'httparty'
require 'slack-notifier'

require './lib/event.rb'
require './lib/message.rb'
require './lib/slack_message.rb'

CALENDER_ID = ''

response = Event.new(calendar_id: CALENDER_ID).get

message = Message.new(response: response, calendar_id: CALENDER_ID).create

SlackMessage.new(message: message).post
