# frozen_string_literal: true

class Event
  TIMETREE_ACCESS_TOKEN = ''

  def initialize(calendar_id:)
    @calendar_id = calendar_id
  end

  def get
    response = HTTParty.get(
        "https://timetreeapis.com/calendars/#{@calendar_id}/upcoming_events?timezone=Asia/Tokyo&days=7&include=creator,label,attendees",
        {
            headers: {
                'Authorization': "Bearer #{TIMETREE_ACCESS_TOKEN}"
            }
        }
    )

    return response
  end
end
