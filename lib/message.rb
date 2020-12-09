# frozen_string_literal: true

class Message
  TIMETREE_URL = "https://timetreeapp.com/calendars/#{@calendar_id}/events/"

  def initialize(response:, calendar_id:)
    @response = response
    @calendar_id = calendar_id
  end

  def create
    response_json = @response['data']
    events_count = response_json.length

    message = if events_count == 0
                '`今週の予定はないよ！`'
              else
                "今週の予定だよ!\n\n"
              end

    response_json.each do |o|
      event_id = o['id']

      event_attribute = o['attributes']
      event_title = event_attribute['title']
      event_description = event_attribute['description'].nil? ? '' : "\n詳細: #{event_attribute['description']}"
      event_registered_url = event_attribute['url'].nil? ? '' : "\nURL#{event_attribute['url']}"

      event_start_at = event_attribute['start_at']
      event_start_month = event_start_at.slice(5, 2)
      event_start_date = event_start_at.slice(8, 2)
      event_start_day = "#{event_start_month}/#{event_start_date}"

      event_end_at = event_attribute['end_at']

      event_all_day = event_attribute['all_day']
      event_time = if event_all_day == true
                     '終日'
                   else
                     event_start_time = event_start_at.slice(11,5)
                     event_end_time = event_end_at.slice(11, 5)
                     "#{event_start_time} ~ #{event_end_time}"
                   end

      event_relationships = o['relationships']
      event_creator_id = event_relationships['creator']['data']['id']

      event_id_url = if event_id.length <= 32
                       event_id
                     else
                       event_ymd = event_start_at.slice(0, 10)
                       event_id.slice(0, 32) + '?date=' + event_ymd
                     end
      event_url = TIMETREE_URL + event_id_url

      event_creator_name = ''
      event_attendees_name = ''

      included_response = @response['included']
      included_response.each do |included|
        event_creator_name = included['attributes']['name'] if included['id'] == event_creator_id
      end

      event_attendees = event_relationships['attendees']['data']
      event_attendees.each do |attendee|
        included_response.each do |included|
          event_attendees_name += "#{included['attributes']['name']}, " if included['id'] == attendee['id']
        end
      end


      message += "*<#{event_url}|#{event_title}>*\n日時: #{event_start_day} #{event_time}\n作成者: #{event_creator_name}\n参加者： #{event_attendees_name}\n#{event_description}\n#{event_registered_url}\n\n\n"
    end
    return message
  end
end